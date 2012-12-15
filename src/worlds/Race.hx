package worlds;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.World;

import entities.Player;


class Race extends World {
	public function new() {
		super();
	}

	public override function begin() {
		// =========== PASSIONATE KITTY HALF ================
		// background 
		var kback:Entity = addGraphic(Image.createRect(HXP.width, Std.int(HXP.halfHeight), 0xEEEEEE));
		kback.x = 0;
		kback.y = 0;

		// floor
		var kfloor:Entity = addGraphic(Image.createRect(HXP.width, Std.int(HXP.halfHeight*.25), 0x666666));
		kfloor.x = 0;
		kfloor.y = Std.int(HXP.halfHeight - (HXP.halfHeight*.25));


		// =========== separator ============================
		var sep:Entity = addGraphic(Image.createRect(HXP.width, 4, 0x000000));
		sep.x = 0;
		sep.y = Std.int(HXP.halfHeight)-2;


		// =========== APATHY GOAT HALF =====================
		// background 
		var aback:Entity = addGraphic(Image.createRect(HXP.width, Std.int(HXP.halfHeight), 0x444444));
		aback.x = 0;
		aback.y = Std.int(HXP.halfHeight);

		// floor
		var afloor:Entity = addGraphic(Image.createRect(HXP.width, Std.int(HXP.halfHeight*.25), 0x111111));
		afloor.x = 0;
		afloor.y = Std.int(HXP.height - (HXP.halfHeight*.25));

		// player
		var player:Player = new Player(30, Std.int(afloor.y));
		player.y -= player.height;
		add(player);
	}

	public override function update() {
		if(Input.check(Key.ESCAPE)) {
			nme.system.System.exit(0);	
		}

		super.update();
	}
}