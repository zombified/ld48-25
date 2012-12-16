package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;


class Coin extends Entity {
	private var _apathy_chance = 70; // out of 100
	private var _apathy_coin = false;


	public function new(x:Int, y:Int) {
		super(x, y);

		regen();
		type = "coin";
	}


	public override function update() {
		moveBy(-cast(HXP.world, worlds.Race).scroll_rate, 0);

		super.update();

		var collision = collide("player", x, y);
		if(collision != null) {
			cast(HXP.world, worlds.Race).add_message(_get_message());
			cast(HXP.world, worlds.Race).score += _apathy_coin ? 100 : -200;
			regen();
			x = Std.random(HXP.width) + 1 + HXP.width;
			y = Std.random(HXP.height) + 1;
		}
	}

	public function regen() {
		_apathy_coin = Std.random(99) + 1 < _apathy_chance;

		width = 10;
		height = 10;
		graphic = Image.createRect(width, height, _apathy_coin ? 0xFF00FF : 0xFFFF00);
		setHitboxTo(graphic);
	}


	private function _get_message() {
		var apathymsgs = [
			"You sat on a couch all day",
			"You bought fast-food instead of cooking",
			"You browsed reddit instead of working",
			"You watched TV instead of shovelling",
			"You ignored the leaky faucet... again",
			"After 3 weeks you are still ignoring the faulty cable connection",
			"You ignored the cat litter... again",
			"You decided not to shave today because it's a lot of work"
		];

		var passionmsgs = [
			"You made a game!",
			"You drew a picture!",
			"You played the banjo at your uncle Ted's wedding!",
			"You took your friend out for a rousing game of bowling",
			"You volunteered at a homeless shelter",
			"You started work early",
			"You gave your dog a bath"
		];

		return _apathy_coin
					? apathymsgs[Std.random(apathymsgs.length)]
					: passionmsgs[Std.random(passionmsgs.length)];
	}

}