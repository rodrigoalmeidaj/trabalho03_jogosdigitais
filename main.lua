local fisica = require("physics");  -- importa a biblioteca
fisica.start();                 -- inicia a física
fisica.setDrawMode("normal");   -- define como será a visualização dos elementos físicos
fisica.setGravity(0, 9.8); --definindo gravidade horizontal e vertical

display.setStatusBar(display.HiddenStatusBar);

_w = display.contentWidth;
_h = display.contentHeight;

-- Definindo o padrão dos pontos âncora para o canto superior esquerdo
display.setDefault("anchorX", -1);
display.setDefault("anchorY", -1);

local tictac;

local fundo = display.newImageRect("images/Backgrounds/colored_grass.png", _h, _h);

local madeiraEsquerda = display.newImageRect("images/Wood/elementWood015.png", 100, 30 );
madeiraEsquerda.y = _h - madeiraEsquerda.height;
madeiraEsquerda.nome = "madeiraEsquerda"
fisica.addBody(madeiraEsquerda, "static", { density=2, bounce=0.2 });

local madeiraDireita = display.newImageRect("images/Wood/elementWood015.png", 100, 30);
madeiraDireita.x = _w - madeiraDireita.width;
madeiraDireita.y = _h - madeiraDireita.height;
madeiraDireita.nome = "madeiraDireita"
fisica.addBody(madeiraDireita, "static", { density=2, bounce=0.2 });

local MetalCentro = display.newImageRect("images/Metal/elementMetal016.png", 120, 30 );
MetalCentro.x = _w-100 - MetalCentro.width;
MetalCentro.y = _h - MetalCentro.height;
MetalCentro.nome = "MetalCentro"
fisica.addBody(MetalCentro, "static", { density=2, bounce=0.2 });

local peca = display.newImageRect("images/Metal/elementMetal013.png", 80, 30);
peca.x = _w-120 - peca.width;
peca.y = _h-50 - peca.height;
peca.nome = "peca"
fisica.addBody(peca, "static", { density=2 });

--criando allien
-- local alien = display.newImageRect("images/Aliens/alienYellow_round.png", 30, 30);

--funcoes evento
-- local function criaAlien(ev)
--      local x = math.random(20, _w-20); 
--      local y = math.random(20, _h-20);
     
--      local alien = display.newImageRect("images/Aliens/alienYellow_round.png", x, y, 30);
--      alien.x = _w / 2 - alien.width / 2;
--      alien.y = 10;
--      alien.nome = "Alien"
--     --  alien:setFillColor(math.random(0,255/255), math.random(0,255/255), math.random(0,255/255));
-- end

-- -- Adicionando o Alien à física
-- fisica.addBody(alien, "dynamic", { density=1, bounce=1, radius=15 });

local paredeEsq = display.newRect(-10, 0, 10, _h);
paredeEsq.nome = "Parede"
fisica.addBody(paredeEsq, "static");
local paredeDir = display.newRect(_w, 0, 10, _h);
paredeDir.nome = "Parede"
fisica.addBody(paredeDir, "static");




--funcoes de evento
local function colideAlien(self, ev)
    if ev.phase == "began" then
        print(ev.target.nome .. " iniciou colisão com " .. ev.other.nome);

        if ev.other.nome == "Pedra" or ev.other.nome == "Metal" then
            --ev.other:removeSelf();
        end
    elseif ev.phase == "ended" then
        print(ev.target.nome .. " terminou colisão com " .. ev.other.nome);
    end
end


--eventos

tictac = timer.performWithDelay(1000 ,criaAlien, 5)

-- alien.collision = colideAlien;
-- alien:addEventListener("collision");

-- local pecas = {
--     { x=50, y=100, rotation=15, image="Metal/elementMetal013.png", nome="MetalCentro"},
--     { x=180, y=250, rotation=-20, image="Wood/elementWood012.png", nome="MadeiraEsquerda"},
--     { x=180, y=250, rotation=-20, image="Wood/elementWood012.png", nome="MadeiraDireita"},
-- };
