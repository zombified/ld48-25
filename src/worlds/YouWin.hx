package worlds;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.World;


class YouWin extends World {

	public function new() {
		super();
	}


	public override function begin() {
		Input.define("start", [Key.ENTER]);

		addGraphic(new Text("You Win!!!!", 30, 30));
		addGraphic(new Text("The old goat, APATHY, has been left behind, and your", 30, 70));
		addGraphic(new Text("mind is now free to feel PASSION again!", 30, 100));
		addGraphic(new Text("Now go DO lots of cool things.", 30, 140));
	}

	public override function update() {
		if(Input.check("start")) {
			HXP.world = new worlds.Race();
		}

		super.update();
	}
}
