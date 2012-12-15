package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;


class Player extends Entity {
	private var _speed:Int = 5;

	public function new(x:Int, y:Int) {
		super(x, y);

		width =10;
		height = 20;

		graphic = Image.createRect(width, height, 0x990000);
	}

	public override function update() {
		if(Input.check(Key.LEFT) || Input.check(Key.A)) {
			moveBy(_speed*-1, 0);
		}
		else if(Input.check(Key.RIGHT) || Input.check(Key.D)) {
			moveBy(_speed, 0);
		}

		super.update();
	}
}