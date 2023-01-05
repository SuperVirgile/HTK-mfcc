#!/usr/local/bin/perl

$HVITE="HVite";
$hviteConf="-T 1 -C configs/hviteDIRECT";
$HPARSE="HParse";
$LOC="Locuteur1";

&HViteDirect("lists/lex1.txt", "lists/lex1.net", "lists/phonesHTK", "donnees/$LOC", "hmms/hmm.3/HMMmacro");
   

#-------------------------------------------------------------------------
# HViteDirect: Décodage à l'aide des modèles de Markov  
#-------------------------------------------------------------------------
sub HViteDirect {
    local($fileDic, $fileNet, $hmmList, $refDir, $HMM)=@_;
    
    &SambaFrToHTK($fileDic,"tmp/dic");
    system("$HPARSE $fileNet tmp/net2");		
	system("$HVITE $hviteConf -H $refDir/$HMM -i EN.rec -w tmp/net2 -p 0.0 -s 5.0 tmp/dic $hmmList");
    }

#-------------------------------------------------------------------------
# SambaFrToHTK: Modification des étiquettes du format SampaFr au format HTK  
#-------------------------------------------------------------------------
sub SambaFrToHTK {
    local($fileList, $fileDic)=@_;
  	my @SambaFr = ("2","9","a~","e~","o~");
  	my @HTK = ("#2","#9","a#","e#","o#");
  
	open(FILELIST, $fileList);
	open(FILEDIC, ">$fileDic");
	while(<FILELIST>) {  
		chop($_);
		@liste = split(/ /,$_);
		print FILEDIC "$liste[0] ";
		for ($j = 1;$j<=$#liste;$j++) {
			for ($i=0;$i<=$#SambaFr;$i++) {
				$liste[$j] =~ s/$SambaFr[$i]/$HTK[$i]/;
			}
			printf FILEDIC "$liste[$j] ";
		}
		print FILEDIC "\n";
	}
	print FILEDIC "sil sil\n";
	close(FILELIST);
	close(FILEDIC);
}
