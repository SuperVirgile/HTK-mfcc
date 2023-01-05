#!/usr/local/bin/perl

$HHED="HHEd";
$hhedConf="configs/divg.hed";
$LOC="Locuteur1";

&HHEd("lists/phonesHTK", "donnees/$LOC", "hmms/hmm.2", "hmms/hmm.3");
 
#-------------------------------------------------------------------------
# HHEd: Duplication des gaussienes des machines de Markov  
#-------------------------------------------------------------------------
sub HHEd {
    local($hmmList, $refDir, $srcHMM, $destHMM)=@_;
    
	system("$HHED -H $refDir/$srcHMM/HMMmacro -M $refDir/$destHMM $hhedConf $hmmList");
    }
