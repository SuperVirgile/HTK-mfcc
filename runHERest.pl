#!/usr/local/bin/perl

$HEREST="HERest";
$herestConf="-T 1 -H configs/HMMmacro";
$HHED="HHEd";
$LOC="Locuteur1";

&HERest("lists/phonesHTK", "donnees/$LOC", "lists/lex0.txt", "hmms/hmm.1", "hmms/hmm.2");
   

#-------------------------------------------------------------------------
# HERest: Apprentissage en mode connecté des modèles de Markov  
#-------------------------------------------------------------------------
sub HERest {
    local($hmmList, $refDir, $paramList, $srcHMM, $destHMM)=@_;
    $nbIter = 5;
    
	if ($srcHMM ne $destHMM) {
	system("$HEREST $herestConf -L $refDir/lab -M $refDir/$destHMM -S $refDir/$paramList -d $refDir/$srcHMM $hmmList");
    }
	for ($i = 0;$i < $nbIter;$i++) {
		system("$HEREST -T 1 -H $refDir/$destHMM/HMMmacro -L $refDir/lab -M $refDir/$destHMM -S $refDir/$paramList $hmmList");
		}
    }
