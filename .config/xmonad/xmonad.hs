import qualified Data.Map as M
import XMonad
import qualified XMonad.StackSet as W

import Graphics.X11.ExtraTypes.XF86

import XMonad.Actions.FloatSnap
import XMonad.Actions.WithAll(sinkAll)

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP

import XMonad.Layout.NoBorders(smartBorders)
import XMonad.Layout.AvoidFloats
import XMonad.Layout.ToggleLayouts

import XMonad.Util.Loggers
import XMonad.Util.NamedScratchpad

import XMonad.Hooks.EwmhDesktops

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, xK_Return), spawn "alacritty")
    , ((modm, xK_e), spawn "thunar")
    , ((modm .|. shiftMask, xK_e), spawn "alacritty -e lf-ueberzug")
    , ((modm, xK_m), namedScratchpadAction scratchpads "cmus")
    , ((modm .|. shiftMask, xK_m), namedScratchpadAction scratchpads "spotify")
    --, ((modm, xK_p), spawn "dmenu_run -fn 'size=15'")
    , ((modm, xK_p), spawn "rofi -show run")
    , ((modm, xK_q), kill)
    , ((modm, xK_r), spawn "xmonad --restart")
    , ((modm, xK_w), spawn "brave")
    , ((modm, xK_f), sendMessage $ Toggle "Full")
    , ((modm .|. shiftMask, xK_w), spawn "brave --incognito")
    , ((modm .|. shiftMask, xK_q), spawn "arcolinux-logout")
    , ((controlMask .|. mod1Mask, xK_x), spawn "xkill")
    --Layout
    , ((modm, xK_space),  sendMessage NextLayout)
    , ((modm, xK_Delete), withFocused $ windows . W.sink)
    , ((modm, xK_comma),  sendMessage (IncMasterN 1))
    , ((modm, xK_period), sendMessage (IncMasterN (-1)))
    , ((modm, xK_h), sendMessage Shrink)
    , ((modm, xK_j), windows W.focusDown)
    , ((modm, xK_k), windows W.focusUp)
    , ((modm, xK_l), sendMessage Expand)
    , ((modm, xK_n), refresh)
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)
    , ((modm .|. shiftMask, xK_j), windows W.swapDown  )
    , ((modm .|. shiftMask, xK_k), windows W.swapUp    )
    , ((modm .|. shiftMask, xK_b), sendMessage AvoidFloatToggle)
    , ((modm .|. shiftMask, xK_Delete), sinkAll)

    , ((modm, xK_Left),  withFocused $ snapMove L Nothing)
    , ((modm, xK_Right), withFocused $ snapMove R Nothing)
    , ((modm, xK_Up),    withFocused $ snapMove U Nothing)
    , ((modm, xK_Down),  withFocused $ snapMove D Nothing)
    , ((modm .|. shiftMask, xK_Left),  withFocused $ snapShrink R Nothing)
    , ((modm .|. shiftMask, xK_Right), withFocused $ snapGrow R Nothing)
    , ((modm .|. shiftMask, xK_Up),    withFocused $ snapShrink D Nothing)
    , ((modm .|. shiftMask, xK_Down),  withFocused $ snapGrow D Nothing)

    , ((0, xK_Print), spawn "scrot -q 100")
    , ((shiftMask, xK_Print), spawn "flameshot gui")
    , ((0, xF86XK_AudioMute), spawn "amixer -q set Master toggle")
    , ((0, xF86XK_AudioLowerVolume), spawn "amixer -q set Master 2%-")
    , ((0, xF86XK_AudioRaiseVolume), spawn "amixer -q set Master 2%+")
    , ((controlMask .|. mod1Mask, xK_j), spawn "amixer -q set Master 2%-")
    , ((controlMask .|. mod1Mask, xK_k), spawn "amixer -q set Master 2%+")
    , ((controlMask .|. mod1Mask, xK_i), spawn "cmus-remote -u")
    , ((controlMask .|. mod1Mask, xK_l), spawn "cmus-remote -n")
    , ((controlMask .|. mod1Mask, xK_h), spawn "cmus-remote -r")
    , ((0, xF86XK_AudioPlay), spawn "cmus-remote -u")
    , ((0, xF86XK_AudioNext), spawn "cmus-remote -n")
    , ((0, xF86XK_AudioPrev), spawn "cmus-remote -r")
    ]
    ++
    [((m .|. modm, k), windows $ f i) | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]

main :: IO ()
main = xmonad
     . ewmhFullscreen
     . ewmh
     . withEasySB (statusBarProp "xmobar ~/.config/xmonad/xmobarrc" (pure myXmobarPP)) defToggleStrutsKey
     $ def { modMask = mod4Mask
            , layoutHook = myLayout
            , manageHook = myManageHook
            , terminal = "alacritty"
            , focusFollowsMouse  = True
            , clickJustFocuses = False
            , borderWidth = 1
            , normalBorderColor = "#dddddd"
            , focusedBorderColor = "#0e79ad"
            , keys = myKeys
            }

myManageHook = composeAll . concat $
    [ [isDialog --> doCenterFloat]
    , [className =? c --> doCenterFloat | c <- myCFloats]
    , [title =? t --> doFloat | t <- myTFloats]
    , [resource =? r --> doFloat | r <- myRFloats]
    , [resource =? i --> doIgnore | i <- myIgnores]
    , [namedScratchpadManageHook scratchpads]]
    where
    myCFloats = ["Galculator", "spotify", "mpv", "Gimp", "Steam", "Pavucontrol", "Xmessage", "MPlayer"]
    myTFloats = ["Downloads", "Save As..."]
    myIgnores = ["desktop_window"]
    myRFloats = []

myLayout = smartBorders . toggleLayouts Full $ tiled
  where
    tiled    = Tall nmaster delta ratio
    nmaster  = 1      -- Default number of windows in the master pane
    ratio    = 1/2    -- Default proportion of screen occupied by master pane
    delta    = 1/100  -- Percent of screen to increment by when resizing panes

myXmobarPP :: PP
myXmobarPP = do
    def { ppSep = magenta " • "
    , ppTitleSanitize  = xmobarStrip
    , ppVisible = wrap "(" ")"
    , ppCurrent = xmobarColor "#c3e88d" ""
    , ppUrgent = red . wrap (yellow "!") (yellow "!")
    , ppOrder = \[ws, l, _, wins] -> [ws, l, wins]
    , ppExtras = [logTitles ppWindow (\x -> "")]
    }
  where
    ppWindow = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 40

    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta  = xmobarColor "#ff79c6" ""
    blue     = xmobarColor "#bd93f9" ""
    white    = xmobarColor "#f8f8f2" ""
    yellow   = xmobarColor "#f1fa8c" ""
    red      = xmobarColor "#ff5555" ""
    lowWhite = xmobarColor "#bbbbbb" ""

scratchpads = [ NS "cmus" "alacritty -t cmus -e cmus" (title =? "cmus") (customFloating $ W.RationalRect 0.05 0.05 0.9 0.9)
              , NS "spotify" "spotify" (className =? "Spotify") (customFloating $ W.RationalRect 0.05 0.05 0.9 0.9) ]
