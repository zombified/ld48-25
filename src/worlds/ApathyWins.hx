package worlds;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.World;


class ApathyWins extends World {

	public function new() {
		super();
	}


	public override function begin() {
		Input.define("start", [Key.ENTER]);

		addGraphic(new Text("That old goat, APATHY, wins another round. YOU Lose. Press [Enter] to try again.", 30, 30));
	}

	public override function update() {
		if(Input.check("start")) {
			HXP.world = new worlds.Race();
		}

		super.update();
	}
}
