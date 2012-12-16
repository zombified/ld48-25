package worlds;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.World;


class Menu extends World {

	public function new() {
		super();
	}


	public override function begin() {
		Input.define("start", [Key.ENTER]);
	}

	public override function update() {
		if(Input.check("start")) {
			HXP.world = new worlds.Race();
		}


		super.update();
	}
}
