package polish;

import flixel.group.FlxGroup;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;
import flixel.util.helpers.FlxPointRangeBounds;
import flixel.util.helpers.FlxRange;

/**
 * ...
 * @author Phillip Napieralski
 */
class Fx extends FlxTypedGroup< FlxTypedGroup<FlxEmitter> >
{
	public var NUM_EXPLODE_EMITTERS:Int = 15;
	public var NUM_EXPLODE_EMITTERS_BIG:Int = 8;
	public var NUM_EXPLODE_EMITTERS_BIGGER:Int = 5;
	
	private var explodeEmitters:FlxTypedGroup<FlxEmitter> = null;
	private var bigExplodeEmitters:FlxTypedGroup<FlxEmitter> = null;
	private var biggerExplodeEmitters:FlxTypedGroup<FlxEmitter> = null;
	
	public function new() 
	{
		super();
		
		explodeEmitters = new FlxTypedGroup<FlxEmitter>(NUM_EXPLODE_EMITTERS);
		bigExplodeEmitters = new FlxTypedGroup<FlxEmitter>(NUM_EXPLODE_EMITTERS_BIG);
		biggerExplodeEmitters = new FlxTypedGroup<FlxEmitter>(NUM_EXPLODE_EMITTERS_BIGGER);
				
		var tempEmitter:FlxEmitter = null;
		var tempParticle:FlxParticle = null;
		
		for ( i in 0...NUM_EXPLODE_EMITTERS )
		{
			tempEmitter = new FlxEmitter(8, 8, 5);
		
			tempEmitter.makeParticles(2, 2, FlxColor.GREEN, 5);
			tempEmitter.speed.set(100, 200);
			tempEmitter.launchMode = FlxEmitterMode.CIRCLE;
			
			explodeEmitters.add(tempEmitter);
		}
		
		for ( i in 0...NUM_EXPLODE_EMITTERS_BIG )
		{
			tempEmitter = new FlxEmitter(12, 12, 6);
			tempEmitter.loadParticles(AssetPaths.ImgParticleRed, 6);
			tempEmitter.speed.set(100, 200);
			tempEmitter.launchMode = FlxEmitterMode.CIRCLE;
			

			bigExplodeEmitters.add(tempEmitter);
		}
		
		for ( i in 0...NUM_EXPLODE_EMITTERS_BIGGER )
		{
			tempEmitter = new FlxEmitter(16, 16, 12);
			tempEmitter.speed.set(100, 200);
			tempEmitter.loadParticles(AssetPaths.ImgParticleRed, 12);
			tempEmitter.launchMode = FlxEmitterMode.CIRCLE;
			
			biggerExplodeEmitters.add(tempEmitter);
		}
		
		add(explodeEmitters);
		add(bigExplodeEmitters);
		add(biggerExplodeEmitters);
	}
	
	public function explode(ax:Float, ay:Float):Void
	{
		var emitter:FlxEmitter = explodeEmitters.recycle(FlxEmitter);
		
		if ( emitter != null )
		{
			emitter.x = ax;
			emitter.y = ay;
			emitter.start(true);
		}
	}
	
	public function explodeBig(ax:Float, ay:Float):Void
	{
		var emitter:FlxEmitter = bigExplodeEmitters.recycle(FlxEmitter);
		
		if ( emitter != null )
		{
			emitter.x = ax;
			emitter.y = ay;
			emitter.start(true);
		}
	}
	public function explodeBigger(ax:Float, ay:Float):Void
	{
		var emitter:FlxEmitter = biggerExplodeEmitters.recycle(FlxEmitter);
		
		if ( emitter != null )
		{
			emitter.x = ax;
			emitter.y = ay;
			emitter.start(true);
		}
	}
	
	override public function draw():Void
	{
		super.draw();
	}
	
	public function reset():Void
	{
		explodeEmitters.kill();
		bigExplodeEmitters.kill();
		biggerExplodeEmitters.kill();
	}
}