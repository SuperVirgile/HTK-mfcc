#!/usr/local/bin/perl

$HREST="HRest";
$hrestConf="-T 1 -i 10 -H configs/HMMmacro";
$LOC="Locuteur1";

&HRest("lists/phonesHTK", "donnees/$LOC", "lists/lex0.txt", "hmms/hmm.0", "hmms/hmm.1");
   

#-------------------------------------------------------------------------
# HRest: Apprentissage en mode isolé des modèles de Markov  
#-------------------------------------------------------------------------
sub HRest {
    local($hmmList, $refDir, $paramList, $srcHMM, $destHMM)=@_;

    open(HMMLIST, $hmmList);
	while(<HMMLIST>) {  
	    chop($_);
	    system("$HREST $hrestConf -L $refDir/lab -l $_ -M $refDir/$destHMM -S $refDir/$paramList $refDir/$srcHMM/$_");
	}
	close(HMMLIST);
    }
