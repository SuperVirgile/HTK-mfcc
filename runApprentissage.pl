#!/usr/local/bin/perl

$HINIT="HInit";
$hinitConf="-T 1 -i 10 -H configs/HMMmacro";
$LOC="Locuteur";
$LEX="lex0.txt";

&HInit("lists/phonesHTK", "donnees/$LOC", "lists/$LEX", "hmms/hmm.0");


$HREST="HRest";
$hrestConf="-T 1 -i 10 -H configs/HMMmacro";
&HRest("lists/phonesHTK", "donnees/$LOC", "lists/$LEX", "hmms/hmm.0", "hmms/hmm.1");


$HEREST="HERest";
$herestConf="-T 1 -H configs/HMMmacro";
&HERest("lists/phonesHTK", "donnees/$LOC", "lists/$LEX", "hmms/hmm.1", "hmms/hmm.2");

$HHED="HHEd";
$hhedConf="configs/divg.hed";
&HHEd("lists/phonesHTK", "donnees/$LOC", "hmms/hmm.2", "hmms/hmm.3");

&HERest("lists/phonesHTK", "donnees/$LOC", "lists/$LEX", "hmms/hmm.3", "hmms/hmm.3");


 

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
    
#-------------------------------------------------------------------------
# HHEd: Duplication des gaussiennes des machines de Markov  
#-------------------------------------------------------------------------
sub HHEd {
    local($hmmList, $refDir, $srcHMM, $destHMM)=@_;
    
	system("$HHED -H $refDir/$srcHMM/HMMmacro -M $refDir/$destHMM $hhedConf $hmmList");
    }
    
