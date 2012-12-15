package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Tween;
import com.haxepunk.tweens.motion.QuadPath;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;

import entities.PhysicsEntity;


class Player extends PhysicsEntity {
	private var _state:PlayerState;
	private var _speed = .8;
	private var _jumpforce = 20;


	public function new(x:Int, y:Int) {
		super(x, y);

		_state = PlayerState.IDLE;

		width =10;
		height = 20;
		graphic = Image.createRect(width, height, 0x990000);
		setHitboxTo(graphic);

		gravity.x = 0;
		gravity.y = 1.8;
		maxvel.x = 20;
		maxvel.y = 3.2;
		friction.x = 0.82;
		friction.y = 0.99;
		onground = true;

		Input.define("jump", [Key.UP, Key.W, Key.SPACE]);
		Input.define("left", [Key.LEFT, Key.A]);
		Input.define("right", [Key.RIGHT, Key.D]);
	}


	public override function update() {
		acc.x = acc.y = 0;


		if(Input.pressed("jump")) {
			acc.y += -HXP.sign(gravity.y) * _jumpforce;
			onground = false;
		}

		if(Input.check("left")) {
			acc.x -= _speed;
		}
		else if(Input.check("right")) {
			acc.x += _speed;
		}

		super.update();
	}
}