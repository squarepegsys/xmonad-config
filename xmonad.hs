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
import XMonad.Actions.SpawnOn(spawnOn)
import XMonad.Actions.WorkspaceNames
 
configDir ="/home/mikeh/.xmonad"

xmobarCmd = "xmobar " ++ configDir ++ "/xmobarrc"

myManageHook = composeAll
    [ className =? "Gimp"      --> doFloat
    , className =? "Vncviewer" --> doFloat
    ]
 
myWorkspaces = ["1","2","3","4","5","6","7","8","9"]

main = do
    xmproc <- spawnPipe xmobarCmd
    xmonad $ defaultConfig {
    	 manageHook = manageDocks <+> manageHook defaultConfig
         , workspaces = myWorkspaces
         , layoutHook = avoidStruts  $  layoutHook defaultConfig
         , modMask=mod4Mask
	 , focusFollowsMouse = True
         , startupHook = do                               
             setWorkspaceName (myWorkspaces!!0) "code"
             setWorkspaceName (myWorkspaces!!1) "chrome"
             setWorkspaceName (myWorkspaces!!8) "extras"
             spawnOn "code" "emacs"                      
             spawnOn "chrome" "google-chrome"
             spawnOn "extras" "pidgin"
             spawnOn "extras" "rhythmbox"
             
    }`additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]
