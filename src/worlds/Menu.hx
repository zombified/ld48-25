package worlds;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.World;


class Menu extends World {
	private static var _music:Sfx = null;

	public function new() {
		super();

		if(_music == null) {
			_music = new Sfx("music/on-the-horses-sisters.mp3");
		}

		if(Main.MusicOn && !_music.playing) {
			_music.loop();
		}
	}


	public override function begin() {
		Input.define("start", [Key.ENTER]);
		Input.define("togglemusic", [Key.M]);

		var backdrop = addGraphic(new Image("gfx/welcomescreen.png"));
		backdrop.x = backdrop.y = 0;
		backdrop.width = HXP.width;
		backdrop.height = HXP.height;	
	}

	public override function update() {
		if(Input.check("start")) {
			HXP.world = new worlds.Race();
		}

		if(Input.pressed("togglemusic")) {
			Main.MusicOn = !Main.MusicOn;
			if(!Main.MusicOn) {
				_music.stop();
			}
			else if(!_music.playing) {
				_music.loop();
			}
		}


		super.update();
	}

	public override function end() {
		_music.stop();
	}
}
