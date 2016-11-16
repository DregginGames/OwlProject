module mainmenu;

import d2d.game;
import d2d.core.io;
import d2d.core.base;
import d2d.engine;

import players.userplayer;
import ui.overview;

class MainMenu : Base
{
    this()
    {
        enableEventHandling();
        this.addChild(new Camera(1.0));

        auto ui = new Ui("ui.menu");
        
        auto title = new Label("OwlProject");
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
                createNewGame();
            });

            event.on!(UiOnClickEvent,"e.element.name == \"loadGameBtn\"")(delegate(UiOnClickEvent e) {
                doSaveRestore("demosave");
            });
        }
    }
    

    void createNewGame()
    {
        this.setDeleted();

        auto groot = getService!GameContainer("d2d.gameroot");
        auto screen = new LoadingScreen("texture.test", delegate(GameContainer gameroot) {
            auto m = new Map("map.chapter0.introgym");
            gameroot.addChild(m);
            m.addToWorld();

            /// add the protagonist
            auto p = new UserPlayer("player.protagonist");
            p.size=vec2(0.5,1.0);
            p.pos=vec2(0.0,1.0);
            p.sizeMode = p.SizeMode.rect;
            auto c = new UserPlayerController();
            c.setPlayer(p);
            gameroot.addChild(p);
            gameroot.addChild(c);
            p.pos = vec2(1.5,0.0);
            auto camera = new Camera(3.0,true);
            p.addChild(camera); 
            camera.positionMode = Entity.PositionMode.relative;
            openUi(gameroot,p);
        });
        groot.addChild(screen);
    }

    static void openUi(GameContainer gameroot, UserPlayer p)
    {
        OverviewUi ui = new OverviewUi("ui.overview",p);
        
        //Box dialogBox = new Box;
        //dialogBox.pos = vec2(0.0,0.9);
        //dialogBox.size = vec2(0.3,0.3);
        //ui.addChild(dialogBox);
        ui.store();
        gameroot.addChild(ui);
    }
}
