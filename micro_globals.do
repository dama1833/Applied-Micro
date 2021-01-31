*********************************************************************************																			
*	TITLE: 		Applied Microeconometrics Master Globals File					
*	PURPOSE:					
*	AUTHOR:		Daniel Mangan												
*	CREATED:	2021_0114												
*	UPDATED: 	
*	CALLS UPON:			
*	CALLED BY: 	
*						
*	PRODUCES: 	Figures:	NO
*				Datasets:	
*					
*	CONTENTS:	
*	1. Set globals
*********************************************************************************
 
	clear all
	set more off
	pause on
	
	glob runner "dama1833"	



	*glob system "citrix"
	glob system "local"

	
	if "${system}"=="citrix" { 
		glob drive "H:\"
		glob syntaxpath "H:\GitHub\Applied-Micro\"
		glob s "\"	
	}


	if "${system}"=="local" { 
		if "${runner}"=="dama1833" {
			glob drive "/Users/danielmangan/Documents/CU/"
			glob syntaxpath "/Users/danielmangan/Documents/GitHub/Applied-Micro/docs${s}"	
			glob s "/"
		}
		
	}
	
	   glob projectpath 	"${drive}Applied-Micro${s}"	
	   glob rawdatapath		"${projectpath}1 Raw Data${s}"
	   glob gendatapath		"${projectpath}2 Generated Datasets${s}"
	   glob tablespath		"${projectpath}3 Tables and Figures${s}"
	   glob analyticpath	"${gendatapath}Analytic Datasets${s}"
	   glob intermedpath	"${gendatapath}Intermediary Datasets${s}"
	   glob figurespath		"${tablespath}Raw Figures${s}"

	   glob pspath 		"${syntaxpath}docs${s}"

*********
*
*	1. Set directory (this helps with markdown)
*
*********

	*cd "${projectpath}statafiles"

*********
*
*	2. Run variablel Labels globals
*
*********
	
	*run "${syntaxpath}variable_labels_micro.do" // run variable label globals file
**

