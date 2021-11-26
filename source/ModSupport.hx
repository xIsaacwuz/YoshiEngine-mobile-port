import flixel.graphics.frames.FlxAtlasFrames;
import openfl.media.Sound;
import sys.FileSystem;
import haxe.display.JsonModuleTypes.JsonTypeParameters;
import flixel.addons.effects.chainable.FlxShakeEffect;
import flixel.FlxBasic;
import flixel.text.FlxText;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.util.FlxColor;
import sys.io.File;
import lime.utils.Assets;
import flixel.system.FlxAssets;
import LoadSettings.Settings;
import flixel.FlxSprite;
import openfl.display.BitmapData;
import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
using StringTools;

class ExceptionState extends FlxState {
    var text:String;
    var resumeTo = 0;
    public function new<T>(text:String, resumeTo:Int) {
        super();
        this.text = text;
        this.resumeTo = resumeTo;
    }
    public override function create() {
        super.create();
        var exceptionText = new FlxText(0,0,FlxG.width,text +"\r\n\r\nPress enter to retry.",8);
        exceptionText.setFormat(Paths.font("vcr.ttf"), Std.int(16), FlxColor.WHITE, LEFT);
        add(exceptionText);
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
        if (FlxG.keys.pressed.ENTER) {
            switch(resumeTo) {
                case 0:
                    FlxG.switchState(new PlayState());
            }
        }
    }
}

class Paths_Mod {
    private var mod:String;
    public function new(mod:String) {
        this.mod = mod;
    }

    public function getModsFolder() {
        return Paths.getModsFolder();
    }

    private function readTextFile(path:String) {
        if (FileSystem.exists(path)) {
            return File.getContent(path);
        } else {
            trace('File at "$path" does not exist');
            return "";
        }
    }

    public function file(file:String) {
        var mFolder = Paths.getModsFolder();
        var path = '$mFolder/$mod/$file';
        if (!FileSystem.exists(path)) {
            trace('File at "$path" does not exist');
        }
    }

    public function txt(file:String):String {
        var mFolder = Paths.getModsFolder();
        return readTextFile('$mFolder/$mod/data/$file.txt');
    }

    public function xml(file:String):String {
        var mFolder = Paths.getModsFolder();
        return readTextFile('$mFolder/$mod/data/$file.xml');
    }

    public function json(file:String):String {
        var mFolder = Paths.getModsFolder();
        return readTextFile('$mFolder/$mod/data/$file.json');
    }

    public function sound(file:String):Sound {
        var mFolder = Paths.getModsFolder();
        #if web
            return Sound.fromFile('$mFolder/$mod/sounds/$file.mp3');
        #else
            return Sound.fromFile('$mFolder/$mod/sounds/$file.ogg');
        #end
    }

    public function image(key:String):BitmapData {
        var mFolder = Paths.getModsFolder();
        var p = '$mFolder/$mod/images/$key.png';
        if (FileSystem.exists(p)) {
            return Paths.getBitmapOutsideAssets(p);
        } else {
            trace('Image at "$p" does not exist');
            return null;
        }
    }

    public function getSparrowAtlas(key:String):FlxAtlasFrames {
        var mFolder = Paths.getModsFolder();
        var png = '$mFolder/$mod/images/$key.png';
        var xml = '$mFolder/$mod/images/$key.xml';
        if (FileSystem.exists(png) && FileSystem.exists(xml)) {
            return FlxAtlasFrames.fromSparrow(Paths.getBitmapOutsideAssets(png), Paths.getTextOutsideAssets(xml));
        } else {
            trace('Sparrow Atlas at "$mFolder/$mod/images/$key" does not exist. Make sure there is an XML and a PNG file');
            return null;
        }
    }

    public function getCharacter(char:String) {
        return Paths.getModCharacter(char);
    }

    public function getPackerAtlas(key:String) {
        var mFolder = Paths.getModsFolder();
        var png = '$mFolder/$mod/images/$key.png';
        var txt = '$mFolder/$mod/images/$key.txt';
        if (FileSystem.exists(png) && FileSystem.exists(txt)) {
            return FlxAtlasFrames.fromSpriteSheetPacker(Paths.getBitmapOutsideAssets(png), Paths.getTextOutsideAssets(txt));
        } else {
            trace('Packer Atlas at "$mFolder/$mod/images/$key" does not exist. Make sure there is an XML and a PNG file');
            return null;
        }
    }
}
class FlxColor_Helper {
    var fc:FlxColor;

    
    public var color(get, null):Int;
    public function get_color():Int {
        return fc;
    }

    public var alpha(get, set):Int;
    public function get_alpha():Int {return fc.alpha;}
    public function set_alpha(obj:Int):Int {fc.alpha = obj; return obj;}

    public var alphaFloat(get, set):Float;
    public function get_alphaFloat():Float {return fc.alphaFloat;}
    public function set_alphaFloat(obj:Float):Float {fc.alphaFloat = obj; return obj;}

    public var black(get, set):Float;
    public function get_black():Float {return fc.black;}
    public function set_black(obj:Float):Float {fc.black = obj; return obj;}

    public var blue(get, set):Int;
    public function get_blue():Int {return fc.blue;}
    public function set_blue(obj:Int):Int {fc.blue = obj; return obj;}

    public var blueFloat(get, set):Float;
    public function get_blueFloat():Float {return fc.blueFloat;}
    public function set_blueFloat(obj:Float):Float {fc.blueFloat = obj; return obj;}

    public var brightness(get, set):Float;
    public function get_brightness():Float {return fc.brightness;}
    public function set_brightness(obj:Float):Float {fc.brightness = obj; return obj;}

    public var cyan(get, set):Float;
    public function get_cyan():Float {return fc.cyan;}
    public function set_cyan(obj:Float):Float {fc.cyan = obj; return obj;}

    public var green(get, set):Int;
    public function get_green():Int {return fc.green;}
    public function set_green(obj:Int):Int {fc.green = obj; return obj;}

    public var greenFloat(get, set):Float;
    public function get_greenFloat():Float {return fc.greenFloat;}
    public function set_greenFloat(obj:Float):Float {fc.greenFloat = obj; return obj;}

    public var hue(get, set):Float;
    public function get_hue():Float {return fc.hue;}
    public function set_hue(obj:Float):Float {fc.hue = obj; return obj;}

    public var lightness(get, set):Float;
    public function get_lightness():Float {return fc.lightness;}
    public function set_lightness(obj:Float):Float {fc.lightness = obj; return obj;}

    public var magenta(get, set):Float;
    public function get_magenta():Float {return fc.magenta;}
    public function set_magenta(obj:Float):Float {fc.magenta = obj; return obj;}

    public var red(get, set):Int;
    public function get_red():Int {return fc.red;}
    public function set_red(obj:Int):Int {fc.red = obj; return obj;}

    public var redFloat(get, set):Float;
    public function get_redFloat():Float {return fc.redFloat;}
    public function set_redFloat(obj:Float):Float {fc.redFloat = obj; return obj;}

    public var saturation(get, set):Float;
    public function get_saturation():Float {return fc.saturation;}
    public function set_saturation(obj:Float):Float {fc.saturation = obj; return obj;}

    public var yellow(get, set):Float;
    public function get_yellow():Float {return fc.yellow;}
    public function set_yellow(obj:Float):Float {fc.yellow = obj; return obj;}

    public static function add(lhs:Int, rhs:Int):Int {return FlxColor.add(lhs, rhs);}
    public static function fromCMYK(Cyan:Float, Magenta:Float, Yellow:Float, Black:Float, Alpha:Float):FlxColor_Helper {return new FlxColor_Helper(FlxColor.fromCMYK(Cyan, Magenta, Yellow, Black, Alpha));}
    public static function fromHSB(Hue:Float, Saturation:Float, Brightness:Float, Alpha:Float = 1):FlxColor_Helper {return new FlxColor_Helper(FlxColor.fromHSB(Hue, Saturation, Brightness, Alpha));}
    public static function fromHSL(Hue:Float, Saturation:Float, Lightness:Float, Alpha:Float = 1):FlxColor_Helper {return new FlxColor_Helper(FlxColor.fromHSL(Hue, Saturation, Lightness, Alpha));}
    public static function fromInt(Value:Int):FlxColor_Helper {return new FlxColor_Helper(Value);}
    public static function fromRGB(Red:Int, Green:Int, Blue:Int, Alpha:Int = 255):FlxColor_Helper {return new FlxColor_Helper(FlxColor.fromRGB(Red, Blue, Green, Alpha));}
    public static function fromRGBFloat(Red:Float, Green:Float, Blue:Float, Alpha:Float = 1):FlxColor_Helper {return new FlxColor_Helper(FlxColor.fromRGBFloat(Red, Blue, Green, Alpha));}
    public static function fromString(str:String):Null<FlxColor_Helper> {
        var color = FlxColor.fromString(str);
        if (color == null)
            return null;
        else
            return new FlxColor_Helper(color);
    }
    public function getAnalogousHarmony(Threshold:Int = 30) {return fc.getAnalogousHarmony(Threshold);}
    public function getColorInfo() {return fc.getColorInfo();}
    public function getComplementHarmony() {return fc.getComplementHarmony();}
    public function getDarkened(Factor:Float = 0.2) {return fc.getDarkened(Factor);}
    public function getInverted() {return fc.getInverted();}
    public function getLightened(Factor:Float = 0.2) {return fc.getLightened(Factor);}
    public function getSplitComplementHarmony(Threshold:Int = 30) {return fc.getSplitComplementHarmony(Threshold);}
    public function getTriadicHarmony() {return fc.getTriadicHarmony();}
    public static function gradient(color1:Int, color2:Int, steps:Int, ?ease:Float -> Float) {return FlxColor.gradient(color1, color2, steps, ease);}
    public static function interpolate(color1:Int, color2:Int, Factor:Float = 0.5) {return FlxColor.interpolate(color1, color2, Factor);}
    public static function multiply(color1:Int, color2:Int) {return FlxColor.multiply(color1, color2);}
    public function setCMYK(Cyan:Float, Magenta:Float, Yellow:Float, Black:Float, Alpha:Float = 1) {return fc.setCMYK(Cyan, Magenta, Yellow, Black, Alpha);}
    public function setHSB(Hue:Float, Saturation:Float, Brightness:Float, Alpha:Float) {return fc.setHSB(Hue, Saturation, Brightness, Alpha);}
    public function setHSL(Hue:Float, Saturation:Float, Lightness:Float, Alpha:Float) {return fc.setHSL(Hue, Saturation, Lightness, Alpha);}
    public function setRGB(Red:Int, Green:Int, Blue:Int, Alpha:Int) {return fc.setRGB(Red, Green, Blue, Alpha);}
    public function setRGBFloat(Red:Float, Green:Float, Blue:Float, Alpha:Float) {return fc.setRGBFloat(Red, Green, Blue, Alpha);}
    public static function substract(color1:Int, color2:Int) {return FlxColor.subtract(color1, color2);}
    public function toHexString(Alpha:Bool = true, Prefix:Bool = true) {return fc.toHexString(Alpha, Prefix);}
    public function toWebString() {return fc.toWebString();}

    public function new(color:Int) {
        fc = new FlxColor(color);
    }
}

class ModSupport {
    public static var song_config_parser:hscript.Interp;
    public static var song_modchart_path:String = "";
    public static var song_stage_path:String = "";
    public static var currentMod:String = "Friday Night Funkin'";

    public static function getExpressionFromPath(path:String, critical:Bool = false):hscript.Expr {
        var parser = new hscript.Parser();
		parser.allowTypes = true;
        var ast = null;
		try {
			#if sys
			ast = parser.parseString(sys.io.File.getContent(path));
			#else
            trace("no sys support");
            #end
		} catch(ex) {
			trace(ex);
            var exThingy = Std.string(ex);
            var line = parser.line;
            if (critical) FlxG.switchState(new ExceptionState('Failed to parse the file located at "$path".\r\n$exThingy at $line', 0));
            trace('Failed to parse the file located at "$path".\r\n$exThingy at $line');
		}
        return ast;
    }

    public static function setHaxeFileDefaultVars(hscript:hscript.Interp, mod:String) {
		hscript.variables.set("PlayState", PlayState.current);
		hscript.variables.set("EngineSettings", Settings.engineSettings.data);

		hscript.variables.set("PlayState_", PlayState);
		hscript.variables.set("FlxSprite", FlxSprite);
		hscript.variables.set("BitmapData", BitmapData);
		hscript.variables.set("FlxG", FlxG);
		hscript.variables.set("Paths", new Paths_Mod(mod));
		hscript.variables.set("Paths_", Paths);
		hscript.variables.set("Std", Std);
		hscript.variables.set("Math", Math);
		hscript.variables.set("FlxMath", FlxMath);
		hscript.variables.set("FlxAssets", FlxAssets);
        hscript.variables.set("Assets", Assets);
		hscript.variables.set("ModSupport", ModSupport);
		hscript.variables.set("Note", Note);
		hscript.variables.set("Character", Character);
		hscript.variables.set("Conductor", Conductor);
		hscript.variables.set("StringTools", StringTools);
		hscript.variables.set("FlxSound", FlxSound);
		hscript.variables.set("FlxTween", FlxTween);
		hscript.variables.set("File", File);
		hscript.variables.set("FileSystem", FileSystem);
		hscript.variables.set("FlxColor", FlxColor_Helper);
		hscript.variables.set("Boyfriend", Boyfriend);
		// hscript.variables.set("FlxColor", Int);
    }
    public static function executeFunc(hscript:hscript.Interp, funcName:String, ?args:Array<Dynamic>):Dynamic {
        
		if (hscript.variables.exists(funcName)) {
            var f = hscript.variables.get(funcName);
            if (args == null) {
                var result = null;
                try {
                    result = f();
                } catch(e) {
                    trace('$e for $funcName');
                }
                return result;
            } else {
                var result = null;
                try {
                    result = Reflect.callMethod(null, f, args);
                } catch(e) {
                    trace('$e for $funcName');
                }
                return result;
            }
			// f();
		}
        return null;
    }
    public static function parseSongConfig() {
        var songName = PlayState.SONG.song.toLowerCase();
        var songCodePath = Paths.getModsFolder() + '/$currentMod/song_conf.hx';
        var parser = new hscript.Parser();
        parser.allowTypes = true;
        var ast = null;
        #if sys
        ast = parser.parseString(sys.io.File.getContent(songCodePath));
        #end
        var interp = new hscript.Interp();
        interp.variables.set("song", songName);
        interp.variables.set("difficulty", PlayState.storyDifficulty);
        interp.variables.set("stage", "default_stage");
        interp.variables.set("cutscene", "");
        interp.variables.set("modchart", "");
        interp.execute(ast);

        var stage = interp.variables.get("stage");
        var modchart = interp.variables.get("modchart");
        trace(stage);
        if (stage == "default_stage")
            song_stage_path = Paths.getModsFolder() + '/Friday Night Funkin\'/stages/$stage'; // fallback
        else
            song_stage_path = Paths.getModsFolder() + '/$currentMod/stages/$stage';

        if (modchart != "")
            song_modchart_path = Paths.getModsFolder() + '/$currentMod/modcharts/$modchart.hx';
        else
            song_modchart_path = "";
        trace(song_stage_path);
        trace(song_modchart_path);
    }

    public static function getFreeplaySongs():Array<String> {
        var folders:Array<String> = [];
        var songs:Array<String> = [];
        #if sys
            var folders:Array<String> = sys.FileSystem.readDirectory(Paths.getModsFolder() + "/");
        #end

        for (mod in folders) {
            trace(mod);
            var freeplayList:String = "";
            #if sys
                try {
                    freeplayList = sys.io.File.getContent(Paths.getModsFolder() + "/" + mod + "/data/freeplaySonglist.txt");
                } catch(e) {
                    freeplayList = "";
                }
            #end
            for(s in freeplayList.trim().replace("\r", "").split("\n")) if (s != "") songs.push('$mod:$s');
        }
        return songs;
    }
}