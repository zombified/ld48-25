import com.haxepunk.Engine;
import com.haxepunk.HXP;

class Main extends Engine
{

	public static inline var kScreenWidth:Int = 800;
	public static inline var kScreenHeight:Int = 200;
	public static inline var kFrameRate:Int = 30;
	public static inline var kClearColor:Int = 0x333333;
	public static inline var kProjectName:String = "APATHY";

	public static var MusicOn = true;

	public function new()
	{
		super(kScreenWidth, kScreenHeight, kFrameRate, false);
	}

	override public function init()
	{
#if debug
	#if flash
		if (flash.system.Capabilities.isDebugger)
	#end
		{
			HXP.console.enable();
		}
#end
		HXP.screen.color = kClearColor;
		HXP.world = new worlds.Menu();
	}

	public static function main()
	{
		new Main();
	}

}