package entities;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.Sfx;


class Message extends Entity {
	public function new(x:Int, y:Int) {
		super(x, y);
	}

	public function set_message(msg:String) {
		graphic = new Text(msg, x, y); 
	}
}