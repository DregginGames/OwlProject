module ui.overview;

import d2d.game;
import players.userplayer;
import players.baseplayer;

class OverviewUi : Ui 
{
    this(string name, UserPlayer p) 
    {
        super(name);
        _player = p;
        auto box = cast(TextBox)getByName("dialogBox")[0];
        box.hidden = box.paused = true;
    }

    override void postUpdate()
    {
        bool wasZero = _pendingLines.length==0;
        foreach(event; peekEvents()) {
            event.on!(DialogEvent)(delegate(DialogEvent e) {
                _pendingLines ~= e.line;
            });

            event.on!(UiOnClickEvent,"e.element.name == \"dialogBox\"")(delegate(UiOnClickEvent e) {
                updateLine();
            });
        }

        if (wasZero && _pendingLines.length > 0) {
            updateLine();
        }

        super.postUpdate();
    }

    void updateLine()
    {
        auto box = cast(TextBox)getByName("dialogBox")[0];
        if (_pendingLines.length==0) {
            box.text = "";
            _player.paused = false;
            box.hidden = true; 
            box.paused = true;
        } else {
            box.hidden = false; 
            box.paused = false;
            auto l = _pendingLines[0];
            string textline = l.line;
            if (l.src) {
                textline = l.src.displayName ~ ": " ~ textline;
            }
            box.text = textline;
            if (l.blocking) {
                _player.paused = true;
            }
            _pendingLines = _pendingLines[1..$];
        }
    }
private: 
    UserPlayer _player;
    DialogLine[] _pendingLines;
}