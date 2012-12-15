package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;


class FloorBlock extends Entity {
	private var _min_w = 200;
	private var _max_w = 400;
	private var _min_h = 35;
	private var _max_h = 75;


	public function new(x:Int, y:Int) {
		super(x, y);

		regen();
		type = "solid";
	}


	public override function update() {
		moveBy(-cast(HXP.world, worlds.Race).scroll_rate, 0);

		super.update();
	}

	public function regen() {
		width = Std.random(_max_w - _min_w) + _min_w + 1;
		height = Std.random(_max_h - _min_h) + _min_h + 1;
		graphic = Image.createRect(width, height, 0x11FF11);
		setHitboxTo(graphic);
	}

}