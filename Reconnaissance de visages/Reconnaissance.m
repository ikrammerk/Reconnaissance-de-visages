clear all;
close all;
clc;

nb_classe = 50; % défini le nombre de classes
nb_image = 12; % défini le nombre d'images par classe
nb_ima_train = 6; % défini le nombre d'images d'apprentissage par classe
nb_bins = 256; % défini la taille de l'histogramme des LBP considéré
Attributs = zeros(nb_ima_train*nb_classe, nb_bins);

%% Apprentisage
comp_train = 1;
for i=1:nb_image*nb_classe
    if(mod(i,2)~=0) % les images impaires constituent les images d'apprentissage
        % Enregistrement du numéro de la classe dans un tableau
        num_classe_train(comp_train) = floor((i-1)/nb_image) + 1;
        % Détermination du numéro de l'image
        num_image = 1 + mod(i-1,12);
        % Concaténation des chaînes de caractères
        % pour constituer le chemin d'accès au fichier image
        if (num_image < 10)
            fichier_train = ['Base/' num2str(num_classe_train(comp_train)) '-0' num2str(num_image) '.jpg'];
        else
            fichier_train = ['Base/' num2str(num_classe_train(comp_train)) '-' num2str(num_image) '.jpg'];
        end
        % Affichage du numéro de la classe
        disp([fichier_train ' Classe ' num2str(num_classe_train(comp_train))]);

        % Ouverture de l'image
        Ima_train = imread(fichier_train);

        % Conversion en niveaux de gris
        Ima_gray_train = rgb2gray(Ima_train);

        %imshow(Ima_gray_train);
        
        % Extraction des attributs de texture
		Attributs(comp_train,:) = lbpim(Ima_gray_train,1,8,0,'h');
		
        comp_train = comp_train + 1;

     
    end
end

 %test(Attributs,num_classe_train,1,8,0);


%Le taux de classification images test avec l'intersection d'histograme

disp('test manhattan');
tic
taux = test(Attributs,num_classe_train,1,8,0)
toc 

%???????????????????????????????????????????????????????????????????????????????????????
%Le taux de classification images Train
%tic
%Classe_Train(Attributs,num_classe_train,1,8,0)
%toc



%Question 9

nbBinsClas = 256;
nbBinsU2 = 59;
nbBinsRi = 36; 
nbBinsRiu2 = 10; 


%Voisinage (1,8) 

disp('Taux de Lbp classique au voisinage 1,8:') 
tic
comparaisonQ9(1,8,0,nbBinsClas)
toc 

disp('Taux de Lbp u2 1,8:') 
tic
comparaisonQ9(1,8,'u2', nbBinsU2)
toc 

disp('Taux de Lbp ri au voisinage 1,8:') 
tic
comparaisonQ9(1,8,'ri',nbBinsRi)
toc 

disp('Taux de Lbp riu2 au voisinage 1,8:') 
tic
comparaisonQ9(1,8,'riu2',nbBinsRiu2)
toc 


%On trouve que la méthode classique est donne les meilleurs résultats par rapport au Taux et temps
%On fixe LBP sous sa forme classique, et en fait varier les voisinages:

%Test le meilleur voisinages
nbBinsClasV2_12 = 4096;
nbBinsClasV4_16 = 65536;
disp('Taux de Lbp classique au voisinage 1,8:') 
tic
comparaisonQ9(1,8,0,nbBinsClas)
toc  

disp('Taux de Lbp classique au voisinage 2,12:') 
tic
comparaisonQ9(2,12,0,nbBinsClasV2_12)
toc  

disp('Taux de Lbp ri au voisinage 2,12:') 
tic
%comparaisonQ9(2,12,'ri',nbBinsClasV2_12)
toc  
disp('Taux de Lbp u2 au voisinage 2,12:') 
tic
%comparaisonQ9(2,12,'u2',nbBinsClasV2_12)
toc 

disp('Taux de Lbp ru2 au voisinage 2,12:') 
tic
%comparaisonQ9(2,12,'ru2',nbBinsClasV2_12)
toc 



disp('Taux de Lbp classique au voisinage 4,16:') 
tic
comparaisonQ9(4,16,0,nbBinsClasV4_16)
toc

%Question 10
%Le taux de classification images test avec la distance euclidienne
%disp('Le taux de classification images test avec l intersection histograme')%
%tic
% comparaisonQ9(2,12,0,nbBinsClasV2_12)
%toc

disp('Le taux de classification images test avec la distance euclidienne')
tic 
comparaisonQ9(2,12,0,nbBinsClasV2_12)
toc



