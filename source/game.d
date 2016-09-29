/**
    Main entry point for a game. Here a game should define its "scripting".
    This includes game logic, ui handlers, ...
    
*/
module game;

//import d2d.engine;
import d2d;

import mainmenu;

int main(char[][] args)
{
    auto engine = new Engine(args, &onStartup);
    engine.run();
    return 0;
}

bool onStartup(Base base)
{
	import std.stdio;
    auto m = new MainMenu();
    base.addChild(m);

	return true;
}