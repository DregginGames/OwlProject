module mainmenu;

import d2d.game;
import d2d.core.io;
import d2d.core.base;
import d2d.engine;

import players.userplayer;

class MainMenu : Base
{
    this()
    {
        enableEventHandling();
        this.addChild(new Camera(1.0));

        auto ui = new Ui("ui.menu");
        
        auto title = new Label("Dragon2D Demogame");
        title.pos = vec2(0.3,0.2);
        title.size = vec2(0.5,0.08);
        ui.addChild(title);
        
        auto newGameBtn = new Button("New Game");
        newGameBtn.name = "newGameBtn";
        newGameBtn.pos = vec2(0.3,0.3);
        newGameBtn.size = vec2(0.4,0.08);
        ui.addChild(newGameBtn);

        auto loadGameBtn = new Button("Load Game");
        loadGameBtn.name = "loadGameBtn";
        loadGameBtn.pos = vec2(0.3,0.4);
        loadGameBtn.size = vec2(0.4,0.08);
        ui.addChild(loadGameBtn);

        auto quitGameBtn = new Button("Quit");
        quitGameBtn.name = "quitBtn";
        quitGameBtn.pos = vec2(0.3,0.5);
        quitGameBtn.size = vec2(0.4,0.08);
        ui.addChild(quitGameBtn);

        this.addChild(ui);
    }

    override void update() {
        
        foreach(event; pollEvents()) {
            event.on!(UiOnClickEvent,"e.element.name == \"quitBtn\"")(delegate(UiOnClickEvent e) {
                fireEvent(new KillEngineEvent());
            });

            event.on!(UiOnClickEvent,"e.element.name == \"newGameBtn\"")(delegate(UiOnClickEvent e) {
                this.setDeleted();
                
                auto gameroot = getService!GameContainer("d2d.gameroot");
                auto m = new Map("map.testmap");
                gameroot.addChild(m);
                m.addToWorld();

                auto p = new UserPlayer("player.userplayer");
                auto c = new UserPlayerController();
                c.setPlayer(p);
                gameroot.addChild(p);
                gameroot.addChild(c);
                p.pos = vec2(1.5,0.0);
                auto camera = new Camera(2.0);
                p.addChild(camera); 
                camera.positionMode = Entity.PositionMode.relative;
            });

            event.on!(UiOnClickEvent,"e.element.name == \"loadGameBtn\"")(delegate(UiOnClickEvent e) {
                doSaveRestore("demosave");
            });
        }
    }
    
}
