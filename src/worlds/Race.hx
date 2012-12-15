package worlds;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;
import com.haxepunk.utils.Input;
import com.haxepunk.World;

import entities.FloorBlock;
import entities.Obstacle;
import entities.Player;


class Race extends World {
	private var _player:Player;

	private var _obstacles:Array<Obstacle>;
	private var _num_obstacles = 30;

	private var _floor_blocks:Array<FloorBlock>;
	private var _num_floor_blocks = 10;
	private var _floor_block_min_dist = 15;
	private var _floor_block_max_dist = 95;


	public var scroll_rate:Float = 2.0;


	public function new() {
		super();

		_floor_blocks = new Array<FloorBlock>();
		_obstacles = new Array<Obstacle>();
	}


	public override function begin() {
		// background 
		var aback:Entity = addGraphic(Image.createRect(HXP.width, HXP.height, 0x444444));
		aback.x = aback.y = 0;

		// floor and obstacles
		_create_obstacles();
		_create_floor_blocks();

		// player
		_player = new Player(60, Std.int(_floor_blocks[0].y));
		_player.y -= _player.height;
		_player.type = "player";
		add(_player);
	}

	public override function update() {
		if(Input.check(Key.ESCAPE)) {
			nme.system.System.exit(0);	
		}


		_check_obstacles();
		_check_floor_blocks();

		super.update();
	}


	private function _create_obstacles() {
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
}
