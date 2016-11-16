/// Contains the baseplayer classes
module players.baseplayer;

import std.json;

import gl3n.linalg;

import d2d.game;
import d2d.core.base;
import d2d.core.event;
import d2d.core.io;
import d2d.util.serialize;

struct DialogLine
{
    BasePlayer src = null;
    string line = "";
    bool blocking = false;
}

class DialogEvent : Event
{
    this(DialogLine l) {
        _line = l;
    }
    @property DialogLine line() 
    {
        return _line;
    }
private:
    DialogLine _line;
    
}

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

    void sayDialogLine(DialogLine l)
    {
        fireEvent(new DialogEvent(l));
    }

    void sayDialogLine(string[] lines, bool blocking=false)
    {
        foreach(line; lines) {
            sayDialogLine(line,blocking);
        }
    }

    void sayDialogLine(string line, bool blocking=false)
    {
        DialogLine l;
        l.line = line;
        l.blocking = blocking;
        l.src = this;
        sayDialogLine(l);
    }
}