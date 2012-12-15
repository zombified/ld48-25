package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Tween;


class Obstacle extends Entity {
	public var speed:Float;


	public function new(x:Int, y:Int) {
		super(x, y);

		width = 30;
		height = 30;
		graphic = Image.createRect(width, height, 0x333333);
		setHitboxTo(graphic);
		type = "obstacle";

		speed = cast(HXP.world, worlds.Race).scroll_rate;
	}


	public override function update() {
		moveBy(-speed, 0);

		super.update();
	}

	public override function moveCollideX(e:Entity) {
//		e.x = x - e.width - (speed * 2);
	}

}