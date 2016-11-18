module maps.chapter0;

import gl3n.linalg;

import derelict.sdl2.sdl;
import derelict.sdl2.mixer;

import d2d.core.base;
import d2d.core.save;
import d2d.game;
import d2d.util;

import players.baseplayer;
import players.userplayer;

class IntroGym : Base, MapController
{
    this()
    {
        enableEventHandling();
    }
    override void onMapload() 
    {
        if (_map) {
            auto addTarget = _map.parent;

            //auto m = new Music("music.intoTheMenu");
            //addTarget.addChild(m);
            //m.play();
            _teacher = new BasePlayer("player.teacher");
            _teacher.pos=vec2(0.0,-1.0);
            addTarget.addChild(_teacher);
            
            _teacherSpeachTrigger = new Trigger!(UserPlayer)(AbstractTrigger.TriggerMode.once);
            _teacherSpeachTrigger.radius = 1.0;
            _teacherSpeachTrigger.sizeMode = _teacherSpeachTrigger.SizeMode.radius;
            _teacherSpeachTrigger.positionMode = Entity.PositionMode.parentBound;
            _teacher.addChild(_teacherSpeachTrigger);
            _teacher.sayDialogLine(Textlines.get("text.teacher","greeting"),true);
        }
    }

    override void update()
    {
        foreach(event; pollEvents()) {
            event.on!(TriggerEvent)(delegate(TriggerEvent e) {
                if(e.trigger == _teacherSpeachTrigger) {
                    _teacher.sayDialogLine(Textlines.get("text.teacher","greeting"),true);
                }
            });
        }
    }

    override void onMapUnload() 
    {

    }

    override void setMap(Map m) 
    {
        _map = m;
    }

private:
    Map _map;
    BasePlayer _teacher;
    Trigger!(UserPlayer) _teacherSpeachTrigger;
}