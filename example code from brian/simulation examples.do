drop _all
set obs 10
gen x = runiform()
list
clear

disp invnorm(.5) // stata will kick out the value at 
				//which half of the observations in a standard normal dist would be below .5, which would be zero. 
disp invnorm(.975) // = 1.96
disp invnorm(.025) // =-1.96

set obs 10000
gen normal = invnorm(runiform())
histogram normal, normal
gen normal2 = rnormal()
histogram normal2, normal
gen normal3 = rnormal()*2+3 // to change mean of variance, multiply by SD and add mean (first change spread and then shift)
histogram normal3, normal


help random_number_functions // you can draw from a whole crap ton of distributions

/*Truncated Normal*/
/* Let's say you want the right half of a standard normal distribution, like you're interested in drawing earnings but you 
don't want anyone to have negative earnings. You could start by drawing from .5 to 1 */
clear 
set obs 10000
gen uniformhalftoone = 0.5+.5*runiform() // does the same thing as below
gen uniformhalftoone_v2 = runiform(0.5,1) 
histogram uniformhalftoone
gen truncnorm = invnorm(uniformhalftoone)
histogram truncnorm

/*Multivariate Normal*/
set seed 123456789
clear
set obs 10000
matrix mu = (0,0) // vector of means for the two dependent x vars 
matrix sigma = (1,0.5 \ 0.5, 1) // variance-covariance matrix with correlation .5 and variance 1 for each var 
drawnorm x1 x2, mean(mu) cov(sigma) 
histogram x1
histogram x2
scatter x1 x2 


/*Programming*/
capture program drop message
program define message 
version 10.1 
display "ECON 8848 is for nerds" 
end 

message

/*Monte Carlo Simulation*/
capture program drop xbaruniform

program define xbaruniform, rclass 
	version 10.1 
	drop _all 
	set obs 100 
	gen draws = runiform()
	quietly sum draws 
	return scalar xbar = r(mean) 
	return scalar tstat = (r(mean)-0.5)/(r(sd)/sqrt(100)) 
end 
return list


capture program drop xbaruniform
	program define xbaruniform, rclass 
	version 10.1 
	syntax[, n(integer 100) a(real 0) b(real 1) nullhyp(real 0.5)] 
	drop _all 
	set obs `n' 
	gen draws = runiform()*(`b'-`a')+`a'
	quietly sum draws 
	return scalar xbar = r(mean) 
	return scalar tstat = (r(mean)-`nullhyp')/(r(sd)/sqrt(`n')) 
end 

xbaruniform
return list

simulate sampmean=r(xbar) t=r(tstat), reps(1000) seed(123456789) : xbaruniform, n(100)


sum sampmean
disp sqrt((1/12)/100) /*Predicted variance*/

sum t
histogram t, normal scheme(s2mono)
graph export thist.pdf, replace
count if abs(t) > 1.96

simulate sampmean=r(xbar) t=r(tstat), nodots reps(10000) seed(123456789) : xbaruniform, n(100)

simulate sampmean=r(xbar) t=r(tstat), nodots reps(10000) seed(123456789) : xbaruniform, n(1000) 
