package;

@:build(flixel.system.FlxAssets.buildFileReferences("assets", true))
class AssetPaths {

	public static var FntDefault:String = null; /* use default flixel font */ // "assets/fonts/Reckoner.ttf";
	public static var FntDefaultBold:String = null;
	
	public static var ImgEarthPlayer:String = "assets/images/img-earth-player.png";
	public static var ImgMarsPlayer:String = "assets/images/img-mars-player.png";
	public static var ImgRocket:String = "assets/images/img-rocket.png";
	
	public static var ImgSatellite:String = "assets/images/satellite.png";
	public static var ImgPowerShaft:String = "assets/images/powershaft.png";
	public static var ImgLaserGun:String = "assets/images/lasergun.png";
	
	public static var ImgEnemy:String = "assets/images/enemy1.png";
	public static var ImgImpact:String = "assets/images/impact-boss.png";
	
	
	// BG stuff
	public static var ImgPlanetEarth:String = "assets/images/planetearth.png";
	public static var ImgPlanetMars:String = "assets/images/planetmars.png";
	public static var ImgClouds:String = "assets/images/clouds.png";
	public static var ImgLightning:String = "assets/images/lightning.png";
	
	// fx stuf
	public static var ImgJet:String = "assets/images/jets.png";
	public static var ImgParticleRed:String = "assets/images/particle-red.png";
	
	// Map stuff
	public static var MapEarth:String = "assets/data/earth.oel";
	public static var TilesEarth:String = "assets/images/img-earth-tilemap.png";
	
	public static var MapMars:String = "assets/data/mars.oel";
	public static var TilesMars:String = "assets/images/img-mars-tilemap.png";
	
	public static var TilesTech:String = "assets/images/technology.png";
	
	
	// Snd stuff
	public static var SndClap:String = "assets/sounds/clap.mp3";
	public static var SndStatic:String = "assets/sounds/static.mp3";
	public static var SndCantDoThat:String = "assets/sounds/cantdothat.mp3";
	public static var SndShutDown:String = "assets/sounds/shutdown.mp3";
	public static var SndBootUp:String = "assets/sounds/bootup.mp3";
	public static var SndExplosion:String = "assets/sounds/explosion.mp3";
	
	public static var SndTakeOff:String = "assets/sounds/takeoff.mp3";
	
	// Music stuff
	public static var MscBoss:String = "assets/music/boss.mp3";
	public static var Msc1:String = "assets/music/1.mp3";
}