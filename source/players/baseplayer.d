/// Contains the baseplayer classes
module players.baseplayer;

import std.json;

import gl3n.linalg;

import d2d.game;
import d2d.core.base;
import d2d.core.event;
import d2d.core.io;
import d2d.util.serialize;

class BaseStats : AbstractPlayerStatsClass
{
    double energy = 0.0;
    double maxEnergy = 0.0;
    double health = 0.0;
    double maxHealth = 0.0;

    mixin createSerialize!(true,"energy","maxEnergy","health","maxHealth");
}

class BasePlayer : AnimatedPlayer!(BaseStats)
{
    this(string name) 
    {
        super(name);
    }

    
}