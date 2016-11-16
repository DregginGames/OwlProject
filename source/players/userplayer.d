module players.userplayer;

import d2d.game;
import d2d.core.base;
import d2d.core.event;
import d2d.core.io;

import players.baseplayer;


class UserPlayer : BasePlayer
{
    this(string name) 
    {
        registerAsService("owl.userplayer");
        super(name);
    }
}

class UserPlayerController : Base, PlayerController
{
    this()
    {
        enableEventHandling();
    }

    override void setPlayer(AbstractPlayer p) 
    {
        _player = cast(UserPlayer)p;
    }
    
    override void update()
    {
        if(_player is null) {
            return;
        }

        bool doesMove = _player.isMoving;
        auto cam = getService!Camera("d2d.mainCamera");

        foreach(event; pollEvents())
        {
            if (doesMove) {
                event.on!(MouseMotionEvent)(delegate(MouseMotionEvent e) {
                    auto cam = getService!Camera("d2d.mainCamera");
                    _player.turnTowards(cam.worldCursor.absolutePos);
                });
            }
            if (!Ui.isAnythingHovered()) {
                event.on!(MouseButtonDownEvent)(delegate(MouseButtonDownEvent e) {
                    import d2d.game.simple.camera;
                
                    //_player.engageNav(cam.worldCursor.absolutePos,0.1,vec2(.5,.5)); // not using this kind of nav
                    _player.turnTowards(cam.worldCursor.absolutePos);
                    if (e.button == e.MouseButtonId.MouseLeft) {
                        _player.isMoving = true;
                    }   
                    else if (e.button == e.MouseButtonId.MouseRight) {
                        isShootingSomething = true;
                    }
                });
            }
            event.on!(MouseButtonUpEvent)(delegate(MouseButtonUpEvent e) {
                if (e.button == e.MouseButtonId.MouseLeft) {
                    _player.isMoving = false;
                }       
                else if (e.button == e.MouseButtonId.MouseRight) {
                    isShootingSomething = false;
                }
            });

        }
        
        if (isShootingSomething&&shotDelayTime <= curtimeS) {
            Sprite s = new Sprite("texture.test");
            s.size = vec2(0.1,0.1);
            s.positionMode = s.PositionMode.parentBound;
            Projectile p = new Projectile();
            p.addChild(s);
            p.emitTowards(_player,cam.worldCursor.absolutePos,4.0,0.5);
            shotDelayTime = curtimeS+0.01;
            this.addChild(p);
        }

    }
private:
    UserPlayer _player;
    bool isShootingSomething = false;
    double shotDelayTime = 0;
    
}