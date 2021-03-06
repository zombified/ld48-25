package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;

import entities.PhysicsEntity;
import entities.Obstacle;


class Player extends PhysicsEntity {
	private var _state:PlayerState;
	private var _speed = 1;
	private var _jumpspeed = 15;

	private var _time_since_move = 0.0;

	private static var _jumpsfx:Sfx;
	private static var _deathsfx:Sfx;
	private static var _walksfx:Sfx;


	public var sprite:Spritemap;


	public function new(x:Int, y:Int) {
		super(x, y);

		_state = PlayerState.IDLE;

		if(_jumpsfx == null) {
			_jumpsfx = new Sfx("sfx/Jump2.wav");
		}
		if(_deathsfx == null) {
			_deathsfx = new Sfx("sfx/Hit_Hurt12.wav");
		}
		if(_walksfx == null) {
			_walksfx = new Sfx("sfx/walk.wav");
		}

		width = 10;
		height = 20;
		sprite = new Spritemap("gfx/goat.png", 24, 24);
		sprite.add("idle", [3]);
		sprite.add("running", [0, 1, 2], 10, true);
		sprite.add("jumping", [1]);
		graphic = sprite;
		//graphic = Image.createRect(width, height, 0x990000);
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

		HXP.timeFlag();
	}


	public override function update() {
		acc.x = acc.y = 0;

		if(Input.pressed("jump") && onground) {
			_walksfx.stop();
			_jumpsfx.play();
			acc.y += -HXP.sign(gravity.y) * _jumpspeed;
			onground = false;
			_time_since_move = 0.0;
		}

		if(Input.check("left")) {
			acc.x -= _speed;
			_time_since_move = 0.0;
			if(!_walksfx.playing && onground) {
				_walksfx.loop();
			}
		}
		else if(Input.check("right")) {
			acc.x += _speed;
			_time_since_move = 0.0;
			if(!_walksfx.playing && onground) {
				_walksfx.loop();
			}
		}
		else {
			_walksfx.stop();
			x -= cast(HXP.world, worlds.Race).scroll_rate;
		}

		if(y > HXP.height) {
			_jumpsfx.stop();
			_walksfx.stop();
			_deathsfx.play();
			HXP.world = new worlds.ApathyWins(cast(HXP.world, worlds.Race).score, cast(HXP.world, worlds.Race).get_time_lasted());
		}
		else if(x > HXP.width) {
			_jumpsfx.stop();
			_walksfx.stop();
			_deathsfx.play();
			HXP.world = new worlds.ApathyWins(cast(HXP.world, worlds.Race).score, cast(HXP.world, worlds.Race).get_time_lasted());
		}

		_time_since_move += HXP.timeFlag();

		if(_time_since_move >= 3 && x + width < -5) {
			HXP.world = new worlds.YouWin();
		}
		else if(_time_since_move < 3 && x + width < -5) {
			_jumpsfx.stop();
			_walksfx.stop();
			_deathsfx.play();
			HXP.world = new worlds.ApathyWins(cast(HXP.world, worlds.Race).score, cast(HXP.world, worlds.Race).get_time_lasted());
		}

		super.update();

		set_animations();

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


	private function set_animations() {
		if(Input.check("left") || Input.check("right")) {
			sprite.flipped = Input.check("left");
			sprite.play("running");
		}
		else if(!onground) {
			sprite.play("jumping");
		}
		else {
			sprite.play("idle");
		}
	}

}