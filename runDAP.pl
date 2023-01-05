#!/usr/local/bin/perl

$HVITE="HVite";
$hviteConf="-T 1";
$HPARSE="HParse";
$LOC="Locuteur";

&HVite("lists/SampaToHTK.dic", "lists/dap.net", "lists/phonesHTK", "donnees/$LOC", "lists/lex1.txt", "hmms/hmm.3/HMMmacro");
   

#-------------------------------------------------------------------------
# HVite: Décodage à l'aide des modèles de Markov  
#-------------------------------------------------------------------------
sub HVite {
    local($fileDic, $fileNet, $hmmList, $refDir, $paramList, $HMM)=@_;
    
    system("$HPARSE $fileNet tmp/net2");		
	system("$HVITE $hviteConf -H $refDir/$HMM -i dap.rec -S $refDir/$paramList -w tmp/net2 $fileDic $hmmList");
    }
