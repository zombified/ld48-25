package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Tween;


class Obstacle extends Entity {
	private var _min_w = 10;
	private var _max_w = 50;
	private var _min_h = 10;
	private var _max_h = 50;

	private var _num_textures = 1;


	public var speed:Float;


	public function new(x:Int, y:Int) {
		super(x, y);

		regen();	
		type = "obstacle";

		speed = cast(HXP.world, worlds.Race).scroll_rate;
	}


	public override function update() {
		moveBy(-speed, 0, "player", true);

		super.update();
	}

	public function regen() {
		width = Std.random(_max_w - _min_w) + _min_w + 1;
		height = Std.random(_max_h - _min_h) + _min_h + 1;
		//graphic = Image.createRect(width, height, 0x33FFAA);
		var img = new Image("gfx/stone" + (Std.random(_num_textures) + 1) + ".png");
		img.scaleX = width / 64;
		img.scaleY = height / 64;
		graphic = img;

		setHitboxTo(this);
	}
}