import	XMonad

import	XMonad.Config.Desktop

import	XMonad.Hooks.DynamicLog
import	XMonad.Hooks.ManageDocks

import	XMonad.Util.EZConfig
import	XMonad.Util.Run

import	System.IO

main = do
	xmproc <- spawnPipe "xmobar /home/marcelom/.config/xmobar/xmobarrc"
	xmonad $ docks defaultConfig
		{ manageHook	=	manageDocks <+> manageHook defaultConfig
		, layoutHook	=	avoidStruts $ layoutHook defaultConfig
		, logHook	=	dynamicLogWithPP xmobarPP
					{ ppOutput	=	hPutStrLn xmproc
					, ppTitle	=	xmobarColor "green"  "" . shorten 50
					}
		, terminal	=	myTerminal
		, modMask	=	myModMask
		, borderWidth	=	myBorderWidth
		}

myTerminal 	= "terminator"
myModMask 	= mod4Mask
myBorderWidth 	= 2
