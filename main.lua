display.setStatusBar(display.HiddenStatusBar);

_w = display.contentWidth;
_h = display.contentHeight;

-- Definindo o padrão dos pontos âncora para o canto superior esquerdo
display.setDefault("anchorX", -1);
display.setDefault("anchorY", -1);

-- APLICANDO A FISICA
local fisica = require("physics");  -- importa a biblioteca
fisica.start();                 -- inicia a física
fisica.setDrawMode("normal");   -- define como será a visualização dos elementos físicos
fisica.setGravity(0, 5); --definindo gravidade horizontal e vertical


---------------- ITENS IMÓVEIS NA TELA ------------------------

-- Background
local fundo = display.newImageRect("images/Backgrounds/colored_grass.png", _h, _h);

-- Teto e chao Invisível
local teto = display.newRect(0,0,_w,-10);
fisica.addBody(teto, "static")
teto.nome = "teto"
local chao1 = display.newRect(0,_h, _w,10);
fisica.addBody(chao1, "static")
chao1.nome = "chao1"
local chao2 = display.newRect(0,_h+20, _w,10);
fisica.addBody(chao2, "static")
chao2.nome = "chao2"
local chao3 = display.newRect(0,_h+30, _w,10);
fisica.addBody(chao3, "static")
chao3.nome = "chao3"

-- Paredes invisíveis
local paredeEsq = display.newRect(-10, 0, 10, _h);
paredeEsq.nome = "Parede"
fisica.addBody(paredeEsq, "static");
local paredeDir = display.newRect(_w, 0, 10, _h);
paredeDir.nome = "Parede"
fisica.addBody(paredeDir, "static");


-- Vidas
local vida1 = display.newImageRect("images/Other/starGold.png", 40, 40);
vida1.nome = "vida1";
vida1.x = _w / 1.5;
vida1.y = -5;

local vida2 = display.newImageRect("images/Other/starGold.png", 40, 40);
vida2.nome = "vida2";
vida2.x = _w / 1.3;
vida2.y = -5;

local vida3 = display.newImageRect("images/Other/starGold.png", 40, 40);
vida3.nome = "vida3";
vida3.x = _w / 1.15;
vida3.y = -5;

-- Pontuação
local pontos = display.newText( "Pontos: ", 10, 10, 250, 300, native.systemFontBold, 15 )
pontos:setFillColor( 0, 0, 0);

local pontuacao = 0
local pontuacao = display.newText(pontuacao , 67, 9, 250, 300, native.systemFontBold, 18)
pontuacao:setFillColor( 0, 0, 0);

-- Peças de colisão
local madeiraEsquerda = display.newImageRect("images/Wood/elementWood047.png", 100, 30 );
madeiraEsquerda.y = _h - madeiraEsquerda.height;
madeiraEsquerda.nome = "madeira"
fisica.addBody(madeiraEsquerda, "static", { density=1, bounce=0.2 });

local vidaPedra = 0
local pedraCentro = display.newImageRect("images/Stone/elementStone047.png", 120, 30 );
pedraCentro.x = _w-100 - pedraCentro.width;
pedraCentro.y = _h - pedraCentro.height;
pedraCentro.nome = "pedra"
fisica.addBody(pedraCentro, "static", { density=1, bounce=0.2 });

local madeiraDireita = display.newImageRect("images/Wood/elementWood047.png", 100, 30);
madeiraDireita.x = _w - madeiraDireita.width;
madeiraDireita.y = _h - madeiraDireita.height;
madeiraDireita.nome = "madeira"
fisica.addBody(madeiraDireita, "static", { density=1, bounce=0.2 });


-------------------------------------------------------------------------------------------------


-- Peça de movimentação
local peca = display.newImageRect("images/Metal/elementMetal013.png", _w/3, 30);
peca.x = _w/3;
peca.y = _h-50 - peca.height;
peca.nome = "peca"
fisica.addBody(peca, "static", { density=2, bounce = 0.2 });

local tictac;
local alien;
local colisao = 0;
local contador = -1;

-- Funcoes de evento
function peca:touch(ev) 
    if (ev.phase == "began") then
        self.isFocus = true;
    elseif (self.isFocus) then 
        if (ev.phase == "moved") then
            if (ev.x > 0 and ev.x < _w - 108) then
                peca.x = ev.x; 
            end    
        elseif (ev.phase == "ended" or ev.phase == "cancelled") then
            peca.x = ev.x;
        end
    end
    return true;
end


local function colisaoAlien(self, ev)
    if (alien ~= nill) then
        if(ev.phase == "began")then
            if (ev.target.nome == "alien" and ev.other.nome == "madeira") then
                ev.other:removeSelf();
            end   
            if (ev.target.nome == "alien" and ev.other.nome == "madeira") then
                ev.other:removeSelf();
            end 
            if (ev.target.nome == "alien" and ev.other.nome == "peca") then
                colisao = colisao + 1;
                if (colisao == 3) then
                    contador = contador + 1;
                    ev.target:removeSelf();
                    pontuacao:removeSelf();
                    pontuacao = contador + 1;
                    pontuacao = display.newText(pontuacao, 67, 9, 250, 300, native.systemFontBold, 18)
                    pontuacao:setFillColor( 0, 0, 0);
                    colisao = 0;
                end
            end 
            if (ev.target.nome == "alien" and ev.other.nome == "pedra") then 
                if (vidaPedra == 1) then
                    ev.other:removeSelf();
                end
                vidaPedra = 1;
            end 

            if (ev.target.nome == "alien" and ev.other.nome == "chao1") then 
                vida1:removeSelf();
                vida1:removeSelf();
                ev.other:removeSelf();
                ev.target:removeSelf();
                vidaPedra = 1;
            end 
            if (ev.target.nome == "alien" and ev.other.nome == "chao2") then 
                vida2:removeSelf();                
                ev.other:removeSelf();
                ev.target:removeSelf();
                vidaPedra = 1;
            end 
            if (ev.target.nome == "alien" and ev.other.nome == "chao3") then 
                if (vidaPedra == 1) then
                    vida3:removeSelf();
                    timer.cancel(tictac);
                end
                ev.other:removeSelf();
                ev.target:removeSelf();
                vidaPedra = 1;
            end 
        elseif (ev.phase == "ended") then
        
        end
    end
end

-- Criando alliens aleatorios
local function criaAlien()        
    alien = display.newImageRect("images/Aliens/mariaJuliaDedo.png", 50, 50);
    -- alien = display.newImageRect("images/Aliens/alienPink_round.png", 40, 40);
    alien.x = math.random(0,_w);
    alien.y = 30;
    alien.nome = "alien";
    fisica.addBody(alien,"dynamic",{density = 1, bounce = 1, radius = 25});
    alien.collision = colisaoAlien;
    alien:addEventListener("collision");
end

-- Eventos
Runtime:addEventListener("touch", peca )
tictac = timer.performWithDelay(3000, criaAlien, 0);

