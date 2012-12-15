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
	private var _obstacles:Array<Obstacle>;

	private var _floor_blocks:Array<FloorBlock>;
	private var _floor_block_min_dist = 15;
	private var _floor_block_max_dist = 75;


	public var scroll_rate:Float = 2.0;


	public function new() {
		super();
		_floor_blocks = new Array<FloorBlock>();
	}


	public override function begin() {
		// background 
		var aback:Entity = addGraphic(Image.createRect(HXP.width, HXP.height, 0x444444));
		aback.x = aback.y = 0;

		// floor and obstacles
		_create_floor_blocks();
		_create_obstacles();

		// player
		var player:Player = new Player(60, Std.int(_floor_blocks[0].y));
		player.y -= player.height;
		player.type = "player";
		add(player);
	}

	public override function update() {
		if(Input.check(Key.ESCAPE)) {
			nme.system.System.exit(0);	
		}


		_check_floor_blocks();

		super.update();
	}


	private function _create_obstacles() {

	}

	private function _create_floor_blocks() {
		var block:FloorBlock;
		var lastx = -1, lastw = -1, x = 0;
		while(true) {
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

			if(x > HXP.width) {
				break;
			}
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
}
