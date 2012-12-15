package entities;

import com.haxepunk.Entity;
import com.haxepunk.HXP;
import flash.geom.Point;


class PhysicsEntity extends Entity {
	public var onground:Bool;
	public var vel:Point;
	public var acc:Point;
	public var friction:Point;
	public var maxvel:Point;
	public var gravity:Point;


	public function new(x:Float, y:Float) {
		super(x, y);

		onground = false;

		vel = new Point();
		acc = new Point();
		friction = new Point();
		maxvel = new Point();
		gravity = new Point();
	}


	public override function update() {
		// update velocity;
		vel.x += acc.x;
		vel.y += acc.y;

		// update position
		moveBy(vel.x, vel.y, "solid", true);

		// adjust velocity for gravity
		vel.x += gravity.x;
		vel.y += gravity.y;

		// ensure that velocity is within bounds
		if(Math.abs(vel.x) > maxvel.x) {
			vel.x = maxvel.x * HXP.sign(vel.x);
		}
		if(Math.abs(vel.y) > maxvel.y) {
			vel.y = maxvel.y * HXP.sign(vel.y);
		}


		super.update();
	}

	// stop movement on the Y axis and reduce velocity on the X axis
	public override function moveCollideY(e:Entity) {
		if(vel.y * HXP.sign(gravity.y) > 0) {
			onground = true;
		}

		vel.x *= friction.x;
		if(Math.abs(vel.x) < .5) {
			vel.x = 0;
		}
		vel.y = 0;
	}

	// stop movement on the X axis and reduce velocity on the Y axis
	public override function moveCollideX(e:Entity) {
		vel.x = 0;
		vel.y *= friction.y;
		if(Math.abs(vel.y) < 1) {
			vel.y = 0;
		}
	}
}