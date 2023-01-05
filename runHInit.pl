#!/usr/local/bin/perl

$HINIT="HInit";
$hinitConf="-T 1 -i 10 -H configs/HMMmacro";
$LOC="Locuteur1";

&HInit("lists/phonesHTK", "donnees/$LOC", "lists/lex0.txt", "hmms/hmm.0");
   

#-------------------------------------------------------------------------
# HInit: Initialisation des modèles de Markov  
#-------------------------------------------------------------------------
sub HInit {
    local($hmmList, $refDir, $paramList, $destHMM)=@_;

    open(HMMLIST, $hmmList);
	while(<HMMLIST>) {  
	    chop($_);
	    system("$HINIT $hinitConf -L $refDir/lab -l $_ -o $_ -M $refDir/$destHMM -S $refDir/$paramList configs/HMMproto");
	}
	close(HMMLIST);
    }
    
