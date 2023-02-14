function taux_test = test(Attributs,num_classe_train,R,N,mapping)
    nb_classe=50;
    nb_image=12;
    nb_ima_train=6;
    nb_ima_test=6;
    comp_test=1;
    comp_vrai =0;
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
            Ima_test_gray= rgb2gray(Ima_test);
            %extract lbp de l'image de test 
            Att= lbpim(Ima_test_gray,R,N,mapping,'h');
             
            for j= 1:300
                 test_i(j)= sum(abs(Att(1,:)-Attributs(j,:)));
            end
    
            [M,I]= min(test_i);
            
            % classse vecteur fih 300 colonnes w kol colonne fih numero de classe qui appar 
            % predection 
            classe(comp_test) = num_classe_train(I);
            comp_test = comp_test + 1;
        
        end
    end

    %contient les vrai
     for i= 1:300
        if num_classe_test(i)==classe(i)
           comp_vrai = comp_vrai +1;     
        end
     end
     % je prend max icic
    taux_test = comp_vrai/300*100;
end
       