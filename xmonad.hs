import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO
import System.Environment
import Control.Monad
import Data.Map
import Prelude hiding (lookup)
 
configDir ="/home/mikeh/.xmonad"

xmobarCmd = "xmobar " ++ configDir ++ "/xmobarrc"

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]
 

main = do
    xmproc <- spawnPipe xmobarCmd
    xmonad $ defaultConfig {
    	 manageHook = manageDocks <+> manageHook defaultConfig
         , layoutHook = avoidStruts  $  layoutHook defaultConfig
         , modMask=mod4Mask
	 , focusFollowsMouse = True
    }`additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]
