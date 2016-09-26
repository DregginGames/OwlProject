module maps.testmap;

import gl3n.linalg;

import derelict.sdl2.sdl;
import derelict.sdl2.mixer;

import d2d.core.base;
import d2d.core.dbg.eventdebug;
import d2d.game;

class Testmap : Base, MapController
{
    override void onMapload() 
    {
        if (_map) {
            auto addTarget = _map.parent;
            auto camera = new Camera(5.0);
            addTarget.addChild(camera);
            auto trigg = new StreamTrigger!Sprite("map.testmap",addTarget);
            trigg.loadOffset(vec2(-10.0,0.0));
            trigg.triggerMode = AbstractTrigger.TriggerMode.once;
            trigg.sizeMode = Entity.SizeMode.rect;
            trigg.size = vec2(0.1,0.1);
            trigg.pos = _map.toWorldPos(vec2(5.0,0.0));
            addTarget.addChild(trigg);

            auto cursor = new WorldCursor();
            auto s2 = new AnimatedSprite("animation.walk","tileset.testplayer");
            s2.positionMode = Entity.PositionMode.parentBound;
            s2.sizeMode = Entity.SizeMode.rect;
            s2.size = vec2(1.0,1.0);
            s2.play("left");
            cursor.addChild(s2);
            camera.addChild(cursor);

            auto m = new Music("music.intoTheMenu");
            addTarget.addChild(m);
            //addTarget.addChild(new NoSDLEventDebugger());
            //m.play();
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