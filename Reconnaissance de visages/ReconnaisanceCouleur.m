nb_classe=50;%défini le nombre de classes 
nb_image=12;%défini le nombre d’images par classe 
nb_ima_train=6;%défini le nombre d’images d’apprentissage par classe 
nb_bins=4096*3;%défini la taille de l’histogramme des LBP considéré 
Attributs=zeros(nb_ima_train*nb_classe,nb_bins);

att_test=zeros(1,nb_bins);

%%Apprentisage 
tic
disp(' La reconnaissance Couleur le temps de (2,12) et le parametre de mapping classique:');
comp_train=1;
comp_test=1;
for i=1:nb_image*nb_classe
    if(mod(i,2)~=0) %les images impaires constituent les images d’apprentissage 
    %Enregistrement du numéro de la classe dans un tableau 
    num_classe_train(comp_train)=floor((i-1)/nb_image)+1;
    %Détermination du numéro de l’image 
    num_image=1+mod(i-1,12);%Concaténation des chaînes de caractères 
    %pour constituer le chemin d’accès au fichier image
    if(num_image<10)
    fichier_train=['Base/' num2str(num_classe_train(comp_train)) '-0' num2str(num_image) '.jpg'];
    else
        fichier_train=['Base/' num2str(num_classe_train(comp_train)) '-' num2str(num_image) '.jpg'];
    end
    %Affichage du numéro de la classe 
%     disp([fichier_train ' Classe ' num2str(num_classe_train(comp_train))]);
    
    %Ouverture de l’image 
    Ima_train=imread(fichier_train);
    
    %Conversion en niveaux de gris 
    %Ima_train=rgb2hsv (Ima_train);
    
    %Extraction des attributs de texture
    %Attributs(comp_train,:) = question3(Ima_gray_train,2,12,0,'h');
    Attributs(comp_train,:) = ExtractionLbpCouleur(Ima_train,2,12);
    comp_train=comp_train+1; 
    
    end
end

for i=1:nb_image*nb_classe
    if(mod(i,2)==0)
        num_classe_test(comp_test)=floor((i-1)/nb_image)+1;
        num_image=1+mod(i-1,12);
            if(num_image<10)
            fichier_test=['Base/' num2str(num_classe_test(comp_test)) '-0' num2str(num_image) '.jpg'];
            else
            fichier_test=['Base/' num2str(num_classe_test(comp_test)) '-' num2str(num_image) '.jpg'];
            end
        Ima_test=imread(fichier_test);
        %Ima_gray_test=rgb2gray(Ima_test);
        %att_test = question3(Ima_gray_test,2,12,0,'h');
        att_test =ExtractionLbpCouleur(Ima_test,2,12);
            for j=1:nb_ima_train*nb_classe
                %test(j)=histogram_intersection(Attributs(j,:),att_test);
                test(j)= sum(abs(att_test(1,:)-Attributs(j,:)));
                 
            end
        [M,I] = max(test);
        classe = num_classe_train(I);
        classe_test(comp_test)=classe;
        comp_test=comp_test+1; 
    end
end
bien_classe = 0;
for i=1:300
    if(num_classe_train(i) == classe_test(i))
        bien_classe = bien_classe+1;
    end
end

taux = bien_classe/300
toc   
