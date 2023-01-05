# Apprentissage de modèles de Markov cachés et détection de mots clés :

plus d'infos sur : https://isip.piconepress.com/projects/htk_tutorials/html/overview.html

# RUN : tout les détails des opérations se trouvent dans le rapport joint à ce dossier

## lancer les scripts Perl runParamApp et runParamTest
Lancer ces scripts permettent de générer les machines de Markov
Ce script va remplir notre dossier param/apprentissage des .mfc et va générer une liste correspondant au chemin de tout ces fichiers dans donnees/Locuteur/lists
runParamTest fait la même chose pour notre .wav de test

## lancer le script Perl runAlign 
pour générer les .lab

## lancer le script Perl convertLabToTg
pour convertir ces .lab en .TextGrid

## lancer le script Perl runApprentissage
Lance sur le jeu de données les fonctions HInit, HRest, HERest et HHEd de HTK

## lancer : HVITE $hviteConf -H $refDir/$HMM -i dap.rec -S $refDir/$paramList -w tmp/net2 $fileDic $hmmList
Permet de générer un fichier de résultat .rec

## Comparaison et évaluation du modèle : HResults -S liste_matrice.txt -S test phonesHTK.lst

## Résultats : HResults -w -f label.lst EN.rec

# Nous vous invitons, encore, à jeter un œil au rapport de façon à mieux comprendre les résultats obtenus ainsi que les bidouiller avec un ajout de données / récompenses. Bonne lecture :)
