package worlds;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.World;

import entities.Coin;
import entities.FloorBlock;
import entities.Message;
import entities.Obstacle;
import entities.Player;


class Race extends World {
	private var _player:Player;

	private var _obstacles:Array<Obstacle>;
	private var _num_obstacles = 30;

	private var _floor_blocks:Array<FloorBlock>;
	private var _num_floor_blocks = 10;
	private var _floor_block_min_dist = 15;
	private var _floor_block_max_dist = 115;

	private var _num_coins = 30;
	private var _cur_msg:Entity = null;

	private var _start_time:Date;
	private var _timer_e:Entity;

	private var _score_e:Entity;

	private static var _music:Sfx;


	public var scroll_rate:Float = 2.0;
	public var score:Int = 0;
	public var message:Message;


	public function new() {
		super();

		if(_music == null) {
			_music = new Sfx("music/bu-a-hands-tunnel.mp3");
		}
	}


	public override function begin() {
		// background 
		//var aback:Entity = addGraphic(Image.createRect(HXP.width, HXP.height, 0x444444));
		var aback:Entity = addGraphic(new Image("gfx/background.png"));
		aback.x = aback.y = 0;

		// floor and obstacles
		_create_obstacles();
		_create_floor_blocks();
		_create_coins();

		// player
		_player = new Player(210, Std.int(_floor_blocks[0].y));
		_player.y -= _player.height;
		_player.type = "player";
		add(_player);


		Input.define("reset", [Key.R]);
		Input.define("quit", [Key.ESCAPE]);
		Input.define("togglemusic", [Key.M]);

		_timer_e = addGraphic(new Text("000.000.000", HXP.width - 90, HXP.height - 30));
		_start_time = Date.now();

		_score_e = addGraphic(new Text("00000000", HXP.width - 190, HXP.height - 30));

		if(Main.MusicOn && !_music.playing) {
			_music.loop();
		}

		message = new Message(10, 10);
		add(message);
	}

	public override function update() {
		if(Input.check("quit")) {
			HXP.world = new worlds.Menu();
		}

		if(Input.check("reset")) {
			reset();
		}

		if(Input.pressed("togglemusic")) {
			Main.MusicOn = !Main.MusicOn;
			if(!Main.MusicOn) {
				_music.stop();
			}
			else if(!_music.playing) {
				_music.loop();
			}
		}

		_check_obstacles();
		_check_floor_blocks();
		_check_coins();

		var diff = Date.now().getTime() - _start_time.getTime();
		var mins = Math.floor(diff / 1000 / 60);
		var secs = Math.floor((diff - (mins * 60 * 1000)) / 1000);
		var ms = diff - ((mins * 1000 * 60) + (secs * 1000));

		cast(_timer_e.graphic, Text).text = mins + "." + secs + "." + ms;

		cast(_score_e.graphic, Text).text = score + " xp";

		super.update();
	}

	public override function end() {
		_music.stop();
	}

	public function reset() {
		message.set_message("");	
		removeList(_obstacles);
		removeList(_floor_blocks);
		_create_obstacles();
		_create_floor_blocks();
		_player.y = Std.int(_floor_blocks[0].y) - _player.height - 10;
		_player.x = 160;
		_start_time = Date.now();
	}

	public function add_message(msg:String) {
		message.set_message(msg);
	}

	public function get_time_lasted() {
		return cast(_timer_e.graphic, Text).text;
	}


	private function _create_obstacles() {
		_obstacles = new Array<Obstacle>();
		var i = 0, ob:Obstacle;
		while(i < _num_obstacles) {
			ob = new Obstacle(0, 0);
			ob.x = Std.random(HXP.width*2) + 1;
			ob.y = Std.random(HXP.height) + 1;

			_obstacles.push(ob);
			add(ob);

			i++;
		}
	}

	private function _create_floor_blocks() {
		_floor_blocks = new Array<FloorBlock>();
		var i = 0, block:FloorBlock, lastx = -1, lastw = -1, x =0;
		while(i < _num_floor_blocks) {
			if(lastx < 0) {
				x = lastx = 0;
			}
			else {
				lastx = x;
				x = lastx + lastw + Std.random(_floor_block_max_dist - _floor_block_min_dist) + _floor_block_min_dist + 1;	
			}
			block = new FloorBlock(x, 0);
			block.y = HXP.height - block.height;
			lastw = block.width;
			_floor_blocks.push(block);
			add(block);
			i++;
		}
	}

	private function _create_coins() {
		var i = 0;
		while( i < _num_coins) {
			add(new Coin(
					Std.random(HXP.width*2) + 1,
					Std.random(HXP.height) + 1
				));
			i++;
		}
	}

	private function _check_floor_blocks() {
		var i:Int = 0, lastblock:FloorBlock, block:FloorBlock, dist:Int;
		while(i < _floor_blocks.length) {
			if(_floor_blocks[i].x + _floor_blocks[i].width < -5) {
				block = _floor_blocks.splice(0, 1)[0];
				lastblock = _floor_blocks[_floor_blocks.length-1];
				dist = Std.random(_floor_block_max_dist - _floor_block_min_dist) + _floor_block_min_dist + 1;
				block.regen();
				block.x = lastblock.x + lastblock.width + dist;
				block.y = HXP.height - block.height;
				_floor_blocks.push(block);

				continue;
			}

			break; // if it gets here, no more blocks should be to the left of the left edge of the screen
		}
	}

	private function _check_obstacles() {
		var i = 0, ob:Obstacle;
		while(i < _obstacles.length) {
			ob = _obstacles[i];
			if(ob.x + ob.width < -5) {
				ob.regen();
				ob.x = Std.random(HXP.width) + 1 + HXP.width;
				ob.y = Std.random(HXP.height) + 1;
			}
			i++;
		}
	}

	private function _check_coins() {
		var i = 0, c:Coin;
		var coins:Array<Coin> = [];
		getType("coin", coins);
		while(i < coins.length) {
			c = coins[i];
			if(c.x + c.width < -5) {
				c.regen();
				c.x = Std.random(HXP.width) + 1 + HXP.width;
				c.y = Std.random(HXP.height) + 1;
			}
			i++;
		}
	}
}
