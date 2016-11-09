module maps.testmap;

import gl3n.linalg;

import derelict.sdl2.sdl;
import derelict.sdl2.mixer;

import d2d.core.base;
import d2d.core.save;
import d2d.game;

class Testmap : Base, MapController
{
    override void onMapload() 
    {
        if (_map) {
            auto addTarget = _map.parent;

            auto m = new Music("music.intoTheMenu");
            addTarget.addChild(m);
            //addTarget.addChild(new NoSDLEventDebugger());
            m.play();
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
}