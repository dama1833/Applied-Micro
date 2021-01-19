
	<<dd_version: 2 >>	
	<<dd_include: header.txt>>
	<<dd graph: ...>

	Testing out some stuff header
	===========================================

	Like this. 

	<<dd_do:quietly>>
	webuse nhanes2, clear
	<</dd_do>>
	
	## Logistic Regression Results

	We're going to run a logistic model. 

	~~~~
	<<dd_do>>
	logistic highbp weight agegrp##sex, nopvalues vsquish
	<</dd_do>>
	~~~~
	

	