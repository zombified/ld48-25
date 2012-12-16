package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;


class Coin extends Entity {
	private var _apathy_chance = 70; // out of 100
	private var _apathy_coin = false;
	private static var _sfx:Sfx;


	public function new(x:Int, y:Int) {
		super(x, y);

		if(_sfx == null) {
			_sfx = new Sfx("sfx/Pickup_Coin6.wav");
		}

		regen();
		type = "coin";
	}


	public override function update() {
		moveBy(-cast(HXP.world, worlds.Race).scroll_rate, 0);

		super.update();

		var collision = collide("player", x, y);
		if(collision != null) {
			_sfx.play();
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
		//graphic = Image.createRect(width, height, _apathy_coin ? 0xFF00FF : 0xFFFF00);
		graphic = new Image(_apathy_coin ? "gfx/apathycoin.png" : "gfx/passioncoin.png");
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
			"You decided not to shave today because it's a lot of work",
			"You decided to lay on the floor and do nothing",
			"Dog needs water? You ignored it because you could do it later",
			"Your office gets messy because \"you'll clean it later\"",
			"You decided not to shovel because the snow \"looks pretty\"",
			"You buy underwear so you don't have to do the wash",
			"The mailbox is just to far away, so you haven't checked it in a month",
			"You car's oil hasn't changed in year because you \"don't have time to call\"",
			"You decide not to go to the dentist",
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