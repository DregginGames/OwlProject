module players.userplayer;

import d2d.game;
import d2d.core.base;
import d2d.core.event;
import d2d.core.io;

class PlayerStats : AbstractPlayerStatsClass
{
}

class UserPlayer : AnimatedPlayer!(PlayerStats)
{
    this(string name) 
    {
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
        
        bool walk = _player.isMoving;
        AbstractPlayer.Direction dir = _player.direction;

        foreach(event; pollEvents())
        {
            event.on!(KeyDownEvent)(delegate(KeyDownEvent e) {
                switch(e.name) {
                    case "moveUp":
                        dir = AbstractPlayer.Direction.up;
                        walk = true;
                        break;
                    case "moveDown":
                        dir = AbstractPlayer.Direction.down;
                        walk = true;
                        break;
                    case "moveLeft":
                        dir = AbstractPlayer.Direction.left;
                        walk = true;
                        break;
                    case "moveRight":
                        dir = AbstractPlayer.Direction.right;
                        walk = true;
                        break;
                    default: break;
                }
            });
            event.on!(KeyUpEvent)(delegate(KeyUpEvent e) {
                switch(e.name) {
                    case "moveUp":
                        walk &= dir != AbstractPlayer.Direction.up;
                        break;
                    case "moveDown":
                        walk &= dir != AbstractPlayer.Direction.down;
                        break;
                    case "moveLeft":
                        walk &= dir != AbstractPlayer.Direction.left;
                        break;
                    case "moveRight":
                        walk &= dir != AbstractPlayer.Direction.right;
                        break;
                    default:
                        break;
                }
            });
        }

        if(walk!=_player.isMoving) {
            _player.isMoving = walk;
        }
        if(dir!=_player.direction) {
            _player.direction = dir;
        }   
    }
private:
    UserPlayer _player;
}