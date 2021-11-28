:- dynamic(isSurge/0).

isBirthday :- day(Day), birthday(Birthday), Day =:= Birthday, 
            write('  SSS  U   U RRRR  PPPP  RRRR  III  SSS  EEEE !! '),nl,
            write(' S     U   U R   R P   P R   R  I  S     E    !! '),nl,
            write('  SSS  U   U RRRR  PPPP  RRRR   I   SSS  EEE  !! '),nl,
            write('     S U   U R R   P     R R    I      S E       '),nl,
            write(' SSSS   UUU  R  RR P     R  RR III SSSS  EEEE !! '),nl,nl,
            write('It\'s your birthday !!!'), nl,
            write('A mysterious man knocked on your door'),nl,
            write('The man brought 5 boxes and told you that 4 of them have a prize inside, choose a number between 1-5'),nl,
            read(CC), random(1,6,X), 
            (CC =:= X -> write('BOOM, the box exploded right in front of your face, unlucky even on your birthday huh\n');
             write('The man brought you 150 gold ! HAPPY BIRTHDAY '), nl, addGold(150)).

isBirthday :- day(Day), birthday(Birthday), Day =\= Birthday,  !.

fishAccident :- write('==============================================================================='), nl,
                write('You almost caught another fish, but the fish slapped you in the face and left.'),nl,unconsious(1), loseExp(50,2),
                unconsiousGold(20) ,
                write('==============================================================================='), nl, !.


ranchAccident :- write('======================================================================================================'), nl,  
                write('You went to the storage room only to find that your animals are starting a cult. They anesthetized you.'),nl,unconsious(1), loseExp(50,3),
                unconsiousGold(20) ,
                write('======================================================================================================='), nl, !.


farmAccident :- write('========================================================================='), nl,
                write('Your recklessness caused you to hit yourself with a shovel. You fainted.'), nl,unconsious(1),loseExp(50,1),
                unconsiousGold(20),
                write('========================================================================='), nl, !.

surgefarmPriceUp :-
    priceitems('bayam',A), Anew is A * 2, changePrice('bayam',Anew),
    priceitems('wortel',B), Bnew is B * 2,changePrice('wortel',Bnew),
    priceitems('kentang',C), Cnew is C * 2,changePrice('kentang',Cnew),
    priceitems('jagung',D), Dnew is D * 2,changePrice('jagung',Dnew),
    priceitems('cabe',E), Enew is E* 2,changePrice('cabe',Enew),
    priceitems('bawang merah',F), Fnew is F * 2,changePrice('bawang merah',Fnew),
    priceitems('bawang putih',G), Gnew is G * 2,changePrice('bawang putih',Gnew),
    priceitems('padi',H), Hnew is H * 2,changePrice('padi',Hnew),
    priceitems('kangkung',I), Inew is I * 2,changePrice('kangkung',Inew).

surgeranchPriceUp :-
    priceitems('egg',A), Anew is A * 2, changePrice('egg',Anew),
    priceitems('milk',B), Bnew is B * 2,changePrice('milk',Bnew),
    priceitems('wol',C), Cnew is C * 2,changePrice('wol',Cnew),
    priceitems('cow meat',D), Dnew is D * 2,changePrice('cow meat',Dnew),
    priceitems('sheep meat',E), Enew is E* 2,changePrice('sheep meat',Enew),
    priceitems('chicken meat',F), Fnew is F * 2,changePrice('chicken meat',Fnew).

surgefishPriceUp :-
    priceitems('Lele Raksasa',A), Anew is A * 2, changePrice('Lele Raksasa',Anew),
    priceitems('Paus Uwu',B), Bnew is B * 2,changePrice('Paus Uwu',Bnew),
    priceitems('Teri Mikroskopis',C), Cnew is C * 2,changePrice('Teri Mikroskopis',Cnew),
    priceitems('Ayah Nemo',D), Dnew is D * 2,changePrice('Ayah Nemo',Dnew),
    priceitems('Sarden Badan Licin',E), Enew is E* 2,changePrice('Sarden Badan Licin',Enew),
    priceitems('Cupang Menggemaskan',F), Fnew is F * 2,changePrice('Cupang Menggemaskan',Fnew),
    priceitems('Geri Si Gurame',G), Gnew is G * 2,changePrice('Geri Si Gurame',Gnew),
    priceitems('Kakap Corak Batik khas Nusantara',H), Hnew is H * 2,changePrice('Kakap Corak Batik khas Nusantara',Hnew),
    priceitems('Teri Mini',I), Inew is I * 2,changePrice('Teri Mini',Inew),
    priceitems('Salmon Kulit Crispy Daging Kenyal',J), Jnew is J * 2,changePrice('Salmon Kulit Crispy Daging Kenyal',Jnew),
    priceitems('Cacing Besar Alaska',K), Knew is K * 2,changePrice('Cacing Besar Alaska',Knew),
    priceitems('Teri Biasa Aja',L), Lnew is L * 2,changePrice('Teri Biasa Aja',Lnew).

surgefarmPriceDown :-
    priceitems('bayam',A), Anew is A // 2, changePrice('bayam',Anew),
    priceitems('wortel',B), Bnew is B // 2,changePrice('wortel',Bnew),
    priceitems('kentang',C), Cnew is C // 2,changePrice('kentang',Cnew),
    priceitems('jagung',D), Dnew is D // 2,changePrice('jagung',Dnew),
    priceitems('cabe',E), Enew is E// 2,changePrice('cabe',Enew),
    priceitems('bawang merah',F), Fnew is F // 2,changePrice('bawang merah',Fnew),
    priceitems('bawang putih',G), Gnew is G // 2,changePrice('bawang putih',Gnew),
    priceitems('padi',H), Hnew is H // 2,changePrice('padi',Hnew),
    priceitems('kangkung',I), Inew is I // 2,changePrice('kangkung',Inew).

surgeranchPriceDown :-
    priceitems('egg',A), Anew is A // 2, changePrice('egg',Anew),
    priceitems('milk',B), Bnew is B // 2,changePrice('milk',Bnew),
    priceitems('wol',C), Cnew is C // 2,changePrice('wol',Cnew),
    priceitems('cow meat',D), Dnew is D // 2,changePrice('cow meat',Dnew),
    priceitems('sheep meat',E), Enew is E// 2,changePrice('sheep meat',Enew),
    priceitems('chicken meat',F), Fnew is F // 2,changePrice('chicken meat',Fnew).

surgefishPriceDown :-
    priceitems('Lele Raksasa',A), Anew is A // 2, changePrice('Lele Raksasa',Anew),
    priceitems('Paus Uwu',B), Bnew is B // 2,changePrice('Paus Uwu',Bnew),
    priceitems('Teri Mikroskopis',C), Cnew is C // 2,changePrice('Teri Mikroskopis',Cnew),
    priceitems('Ayah Nemo',D), Dnew is D // 2,changePrice('Ayah Nemo',Dnew),
    priceitems('Sarden Badan Licin',E), Enew is E// 2,changePrice('Sarden Badan Licin',Enew),
    priceitems('Cupang Menggemaskan',F), Fnew is F // 2,changePrice('Cupang Menggemaskan',Fnew),
    priceitems('Geri Si Gurame',G), Gnew is G // 2,changePrice('Geri Si Gurame',Gnew),
    priceitems('Kakap Corak Batik khas Nusantara',H), Hnew is H // 2,changePrice('Kakap Corak Batik khas Nusantara',Hnew),
    priceitems('Teri Mini',I), Inew is I // 2,changePrice('Teri Mini',Inew),
    priceitems('Salmon Kulit Crispy Daging Kenyal',J), Jnew is J // 2,changePrice('Salmon Kulit Crispy Daging Kenyal',Jnew),
    priceitems('Cacing Besar Alaska',K), Knew is K // 2,changePrice('Cacing Besar Alaska',Knew),
    priceitems('Teri Biasa Aja',L), Lnew is L // 2,changePrice('Teri Biasa Aja',Lnew).

priceSurge :- isSurge, write('Prices has gone back to normal , how much did you get yesterday ?'),nl,
              surgefarmPriceDown,surgefishPriceDown,surgeranchPriceDown, retract(isSurge),!.

priceSurge :- \+isSurge,random(1,101,X), X < 6,
              write('HEY IT\'S PRICE SURGE DAY, EVERYTHING YOU SELL IS NOW DOUBLE THE PRICE ,SELL EVERYTHING YOU HAVE NOW!'),nl,
              surgefarmPriceUp,surgefishPriceUp,surgeranchPriceUp, assertz(isSurge),!.


priceSurge :- !.


