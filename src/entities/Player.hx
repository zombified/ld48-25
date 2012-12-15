package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;

import entities.PhysicsEntity;
import entities.Obstacle;


class Player extends PhysicsEntity {
	private var _state:PlayerState;
	private var _speed = 1;
	private var _jumpspeed = 15;


	public function new(x:Int, y:Int) {
		super(x, y);

		_state = PlayerState.IDLE;

		width =10;
		height = 20;
		graphic = Image.createRect(width, height, 0x990000);
		setHitboxTo(graphic);
		type = "player";

		gravity.x = 0;
		gravity.y = 1.8;
		maxvel.x = _speed * 4;
		maxvel.y = _jumpspeed;
		friction.x = 0.82;
		friction.y = 0.99;
		onground = true;

		Input.define("jump", [Key.UP, Key.W, Key.SPACE]);
		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("right", [Key.RIGHT, Key.D]);
	}


	public override function update() {
		acc.x = acc.y = 0;

		if(Input.pressed("jump") && onground) {
			acc.y += -HXP.sign(gravity.y) * _jumpspeed;
			onground = false;
		}

		if(Input.check("left")) {
			acc.x -= _speed;
		}
		else if(Input.check("right")) {
			acc.x += _speed;
		}
		else {
			x -= cast(HXP.world, worlds.Race).scroll_rate;
		}

		super.update();

		var collidedwith = collide("obstacle", x, y);
		if(collidedwith != null) {
			if(x <= collidedwith.x) {
				x = collidedwith.x - width;
			}
			else {
				x = collidedwith.x + collidedwith.width;
			}
		}
	}

}