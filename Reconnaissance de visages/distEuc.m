function distEuc(R,N,mapping, nb_bins)

nb_classe=50;%défini le nombre de classes 
nb_image=12;%défini le nombre d’images par classe 
nb_ima_train=6;%défini le nombre d’images d’apprentissage par classe 
Attributs=zeros(nb_ima_train*nb_classe,nb_bins);
att_test=zeros(1,nb_bins);

%%Apprentisage 
comp_train=1;
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
    
    %Ouverture de l’image 
    Ima_train=imread(fichier_train);
    
    %Conversion en niveaux de gris 
    Ima_gray_train=rgb2gray(Ima_train);
    
    %Extraction des attributs de texture
    Attributs(comp_train,:) = LbpOfImage(Ima_gray_train,R,N,mapping,'h');
    comp_train=comp_train+1; 
    
    end
end

%Le taux de classification
tic
TestDistEuc(Attributs,num_classe_train,R,N,mapping)
toc   

end
function taux = Test_Reconnaissance_Avec_Dist_Euclidienne(Attributs,num_classe_train,R,N,mapping)

    nb_classe=50;
    nb_image=12;
    nb_ima_train=6;
    nb_ima_test=6;
    comp_test=1;

    for i=1:nb_image*nb_classe
    if(mod(i,2)==0)
        num_classe_test(comp_test)=floor((i-1)/nb_image)+1;
        num_image=1+mod(i-1,12);
            if(num_image<10)
            fichier_test=['Base\' num2str(num_classe_test(comp_test)) '-0' num2str(num_image) '.jpg'];
            else
            fichier_test=['Base\' num2str(num_classe_test(comp_test)) '-' num2str(num_image) '.jpg'];
            end
        Ima_test=imread(fichier_test);
        Ima_gray_test=rgb2gray(Ima_test);
        %Pour chaque image test, on calcule LBP
        att_test = LbpOfImage(Ima_gray_test,R,N,mapping,'h');
            for j=1:nb_ima_train*nb_classe
                test(j)=distance_euclidienne(Attributs(j,:),att_test);
            end
        [M,I] = min(test);
        classe = num_classe_train(I);
        classe_test(comp_test)=classe;
        comp_test=comp_test+1; 
    end
    end
    bien_classe = 0;
    
    %Boucle pour calculer le nombre des images bien classés
    nb_total_images_test = nb_ima_test*nb_classe;
    for i=1:nb_total_images_test
        if(num_classe_train(i) == classe_test(i))
            bien_classe = bien_classe+1;
        end
    end
    taux = bien_classe/nb_total_images_test;
end