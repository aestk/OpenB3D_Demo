' Simple demo for OpenB3D

#include "openb3d.bi"
#include "fbgfx.bi"

using FB

Dim As Integer sw = 800, sh = 600
Dim As Single cam_x = 0, cam_y = 0
Dim As Single cam_rot_x = 0, cam_rot_y = 0

ScreenRes(sw, sh, 32,,GFX_OPENGL)
Graphics3D(sw, sh, 32)

Var cam = CreateCamera()
CameraViewport(cam, 0, 0, sw, sh)
MoveEntity(cam, 0, 2, 0)
CameraFogMode(cam, 1)
CameraFogRange(cam, 5, 20)

Var light = CreateLight()

Var texture1 = LoadTexture("res/water.jpg")
Var texture2 = LoadTexture("res/grass.bmp")

Var plane = CreatePlane()
EntityColor(plane, 0, 255, 255)

Var cube = CreateCube()
MoveEntity(cube, 0, 1, 0)
EntityTexture(cube, texture1)

Var cone = CreateCone()
MoveEntity(cone, 0, 1, 5)
EntityTexture(cone, texture2)

Do
	If MultiKey(SC_W) Then
		MoveEntity(cam, 0, 0, 0.25)
		
		RotateEntity(cam, cam_rot_x, cam_rot_y+0.25*sin(cam_y), 0.25*cos(cam_x))
		cam_x = cam_x + 0.1
		cam_y = cam_y + 0.15
	End If
	If MultiKey(SC_S) Then
		MoveEntity(cam, 0, 0, -0.25)
		
		RotateEntity(cam, cam_rot_x, cam_rot_y+0.25*sin(cam_y), 0.25*cos(cam_x))
		cam_x = cam_x + 0.1
		cam_y = cam_y + 0.15
	End If
	If MultiKey(SC_A) Then
		MoveEntity(cam, -0.25, 0, 0)
		
		RotateEntity(cam, cam_rot_x, cam_rot_y, 0.25*cos(cam_x))
		cam_x = cam_x + 0.1
	End If
	If MultiKey(SC_D) Then
		MoveEntity(cam, 0.25, 0, 0)
		
		RotateEntity(cam, cam_rot_x, cam_rot_y, 0.25*cos(cam_x))
		cam_x = cam_x + 0.1
	End If
	
	If MultiKey(SC_UP) Then
		If cam_rot_x < 90 Then cam_rot_x = cam_rot_x + 1
		RotateEntity(cam, cam_rot_x, cam_rot_y, 0)
	End If
	If MultiKey(SC_DOWN) Then
		If cam_rot_x > -90 Then cam_rot_x = cam_rot_x - 1
		RotateEntity(cam, cam_rot_x, cam_rot_y, 0)
	End If
	If MultiKey(SC_LEFT) Then
		cam_rot_y = cam_rot_y + 1
		RotateEntity(cam, cam_rot_x, cam_rot_y, 0)
	End If
	If MultiKey(SC_RIGHT) Then
		cam_rot_y = cam_rot_y - 1
		RotateEntity(cam, cam_rot_x, cam_rot_y, 0)
	End If
	
	PositionEntity(cam, EntityX(cam), 2, EntityZ(cam))
	
	TurnEntity(cone, 1, 1, 1)
	
	UpdateWorld()
	RenderWorld()
	
	Flip()
Loop Until MultiKey(SC_ESCAPE)