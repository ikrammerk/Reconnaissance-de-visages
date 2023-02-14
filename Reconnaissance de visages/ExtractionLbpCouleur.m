function attribut = ExtractionLbpCouleur(image,rayon,nb_voisin)
    %extraction des compsosnates RGB
    R=image(:,:,1);
    G=image(:,:,2);
    B=image(:,:,3);
    
    %extraction lbp
    attribut_R=lbp(R,rayon,nb_voisin,0,'h');
    attribut_G=lbp(G,rayon,nb_voisin,0,'h');
    attribut_B=lbp(B,rayon,nb_voisin,0,'h');
    
    [~,C]=size(attribut_R);
    
    %Stockage du lbp de chaque composante dans la variable attribut
    attribut=zeros(1,C*3);
    attribut(1,1:C)=attribut_R;
    attribut(1,C+1:C*2)=attribut_G;
    attribut(1,C*2+1:C*3)=attribut_B;
end