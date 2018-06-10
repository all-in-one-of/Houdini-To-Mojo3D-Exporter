'Houdini scene to mojo3d demostration
'Try changing the scene in houdini, re-exporting it and hit space bar. The changes will reload, without the need to recompiling!
'Make sure there's always a camera named "Camera", or you'll get a crash

Namespace myapp3d

#Import "<std>"
#Import "<mojo>"
#Import "<mojo3d>"
#Import "<mojo3d-loaders>"

#Import "models/"
#Import "textures/"
#Import "scenes/"

#Reflect mojo3d

Using std..
Using mojo..
Using mojo3d..


Class MyWindow Extends Window

	Field _path := "asset::testscene.mojo3d"	
	Field _scene:Scene
	Field _camera:Camera

	
	Method New( title:String="Simple mojo3d loader",width:Int=1280,height:Int=720,flags:WindowFlags=WindowFlags.Resizable | WindowFlags.HighDPI )
		Super.New( title,width,height,flags )
	End
	
	
	Method OnCreateWindow() Override
		ReloadScene()
		Print "Scene reloaded"
	End
	
	
	Method OnRender( canvas:Canvas ) Override
		RequestRender()
		_scene.Update()
		_camera.Render( canvas )
		canvas.DrawText( "FPS="+App.FPS,0,0 )
		canvas.DrawText( "Hit space bar to reload the scene - No need to recompile to see changes to the .mojo3d file!", 5, Height-5, 0, 1 )
		
		If Keyboard.KeyHit( Key.Space ) Then ReloadScene()
	End
	
	
	Method ReloadScene()
		_scene = _scene.Load( _path )
		_camera = Cast<Camera>(_scene.FindEntity("Camera") )
		_camera.View = Self
		_camera.AddComponent<FlyBehaviour>()
	End
	
End

Function Main()
	New AppInstance
	New MyWindow
	App.Run()
End
