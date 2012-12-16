package worlds;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.World;


class ApathyWins extends World {
	private var _score:Int;
	private var _timelasted:String;

	public function new(score:Int, timelasted:String) {
		_score = score;
		_timelasted = timelasted;
		super();
	}


	public override function begin() {
		Input.define("start", [Key.ENTER]);

		addGraphic(new Text("That old goat, APATHY, wins another round. YOU Lose. Press [Enter] to try again.", 30, 30));
		addGraphic(new Text("Total Gathered XP: " + _score, 30, 70));
		addGraphic(new Text("Total Time Survived: " + _timelasted, 30, 100));
	}

	public override function update() {
		if(Input.check("start")) {
			HXP.world = new worlds.Race();
		}

		super.update();
	}
}
