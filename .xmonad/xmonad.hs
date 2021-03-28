-- Base
import XMonad
import Control.Monad
import DBus (MethodCall, methodCall, methodCallBody, methodCallDestination, objectPath_, interfaceName_, memberName_, busName_, toVariant)
import DBus.Client
import System.Directory
import System.Exit -- (exitSuccess, exitWith)
import System.IO (hPutStrLn)
import qualified XMonad.StackSet as W

-- Actions
import XMonad.Actions.CopyWindow (kill1, killAllOtherCopies)
import XMonad.Actions.CycleWindows
import XMonad.Actions.MouseResize
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves (rotSlavesDown, rotAllDown)
import XMonad.Actions.Search as S
import XMonad.Actions.WithAll (sinkAll, killAll)

-- Data
import Data.Char (isSpace, toUpper)
import Data.Monoid
import qualified Data.Map as M

-- Hooks
import XMonad.Hooks.DynamicLog (dynamicLogWithPP, wrap, xmobarPP, xmobarColor, shorten, PP(..))
import XMonad.Hooks.EwmhDesktops  -- for some fullscreen events, also for xcomposite in obs.
import XMonad.Hooks.FadeInactive
import XMonad.Hooks.InsertPosition
import XMonad.Hooks.ManageHelpers 
import XMonad.Hooks.ManageDocks (avoidStruts, checkDock, docks, docksEventHook, manageDocks, ToggleStruts(..))
import XMonad.Hooks.ServerMode
import XMonad.Hooks.WorkspaceHistory

-- Layouts
import XMonad.Layout.Fullscreen
import XMonad.Layout.ResizableTile
-- import XMonad.Layout.Magnifier

-- Layouts modifiers
import XMonad.Layout.LayoutModifier
import XMonad.Layout.LimitWindows (limitWindows, increaseLimit, decreaseLimit)
import XMonad.Layout.NoBorders
-- import XMonad.Layout.PerWorkspac
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing

-- Prompt
import XMonad.Prompt
import XMonad.Prompt.Input
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Man
import XMonad.Prompt.Pass
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Prompt.XMonad
import Control.Arrow (first)

-- Text
import Text.Printf

-- Utilities
import XMonad.Util.ExtensibleState as XS
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (runProcessWithInput, safeSpawn, spawnPipe, unsafeSpawn)
import XMonad.Util.SpawnOnce


myFont :: String
myFont = "xft:Hurmit Nerd Font:regular:size=9:antialias=true:hinting=true"

myModMask :: KeyMask
myModMask = mod4Mask                    -- Sets modkey to super/windows key

myTerminal :: String
myTerminal = "alacritty"                -- Sets default terminal

myBrowser :: String
myBrowser = "firefox"                   -- Sets firefox as browser for tree select

myEditor :: String
myEditor = myTerminal ++ " -e nvim"     -- Sets neovim as editor for tree select

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True              -- Whether focus follows the mouse pointer.

myClickJustFocuses :: Bool
myClickJustFocuses = False              -- Whether clicking on a window to focus also passes the click to the window

myNormalBorderColor  = "#668bd7"
myFocusedBorderColor = "#8d62a9"

myBorderWidth :: Dimension
myBorderWidth = 1

myWorkspaces = ["www", "dev", "term", "file", "extra", "mail", "obs"]

-- COLORS
cBackground  = "#282A36"
cVurrentLine = "#44475a"
cSelection   = "#44475a" 
cForeground  = "#f8f8f2"
cComment     = "#6272a4"
cCyan        = "#8be9fd"
cGreen       = "#50fa7b"
cOrange      = "#ffb86c"
cPink        = "#ff79c6"
cPurple      = "#bd93f9"
cRed         = "#ff5555"
cYellow      = "#f1fa8c"


joakoXPConfig :: XPConfig
joakoXPConfig = def
      { font                = myFont
      , bgColor             = "#282A36"
      , fgColor             = "#f8f8f2"
      , bgHLight            = "#c792ea"
      , fgHLight            = "#000000"
      , borderColor         = "#bd93f9"
      , promptBorderWidth   = 0
      -- , position            = Top
      , position            = CenteredAt { xpCenterY = 0.011, xpWidth = 0.995 }
      , height              = 20
      , historySize         = 256
      , historyFilter       = id
      , defaultText         = []
      , autoComplete        = Nothing
      , showCompletionOnTab = False
      , searchPredicate     = fuzzyMatch
      , sorter              = fuzzySort
      -- , defaultPrompter     = id $ map toUpper  -- change prompt to UPPER
      , alwaysHighlight     = True
      , maxComplRows        = Just 5      -- set to 'Just 5' for 5 rows
      }

----- HIDE XMOBAR ------

hideXmobar :: X ()
hideXmobar = do
        -- sendMessage ToggleStruts
        unsafeSpawn "dbus-send --session --dest=org.Xmobar.Control --type=method_call --print-reply '/org/Xmobar/Control' org.Xmobar.Control.SendSignal \"string:Toggle 0\""
        return ()



myToggleDocksHook :: Event -> X All
-------------------------------------valor de la 'v'
myToggleDocksHook e = myToggleDocks 4 0x76 e  >> return (All True)

data DockToggleTime = DTT { lastTime :: Time } deriving (Eq, Show, Typeable)

instance ExtensionClass DockToggleTime where
    initialValue = DTT 0

myToggleDocks :: Int -> KeySym -> Event -> X All
myToggleDocks to ks ( KeyEvent { ev_event_display = d
                                , ev_event_type    = et
                                , ev_keycode       = ekc
                                , ev_time          = etime
                                } ) =
        io (keysymToKeycode d ks) >>= toggleDocks >> return (All True)
    where
    toggleDocks kc
        | ekc == kc && et == keyPress = do
            safeSendSignal ["Toggle 0","TogglePersistent"]
            XS.put ( DTT etime )
        | ekc == kc && et == keyRelease = do
            gap <- XS.gets ( (-) etime . lastTime )
            safeSendSignal [ "Toggle 0"
                           , "TogglePersistent"
                        -- , "Hide " ++ show (if gap < 200 then to else 10)
                        ]
            sendMessage ToggleStruts
        | otherwise = return ()

    safeSendSignal s = catchX (io $ sendSignal s) (return ())
    sendSignal    = withSession . callSignal
    withSession mc = connectSession >>= \c -> callNoReply c mc >> disconnect c
    callSignal :: [String] -> MethodCall
    callSignal s = ( methodCall
                    ( objectPath_    "/org/Xmobar/Control" )
                    ( interfaceName_ "org.Xmobar.Control"  )
                    ( memberName_    "SendSignal"          )
                ) { methodCallDestination = Just $ busName_ "org.Xmobar.Control"
                    , methodCallBody        = map toVariant s
                    }

myToggleDocks _ _ _ = return (All True)

myDocksEventHook :: Event -> X All
myDocksEventHook e = do
    when (et == mapNotify || et == unmapNotify) $
        whenX ((not `fmap` (isClient w)) <&&> runQuery checkDock w) refresh
    return (All True)
    where
        w  = ev_window e
        et = ev_event_type e
------------------------

--Prompts
editPrompt :: String -> X ()
editPrompt home = do
    str <- inputPrompt cfg "~/" 
    case str of
        Just s -> openInEditor s
        Nothing -> pure ()
  where
    cfg = joakoXPConfig { defaultText = "", autoComplete = Just 100000 }

openInEditor :: String -> X ()
openInEditor path =
    spawn (myEditor ++ " " ++ path)



archwiki, urban :: S.SearchEngine
archwiki = S.searchEngine "archwiki" "https://wiki.archlinux.org/index.php?search="
urban    = S.searchEngine "urban" "https://www.urbandictionary.com/define.php?term="

searchList :: [(String, S.SearchEngine)]
searchList = [ ("a", archwiki)
             , ("d", S.duckduckgo)
             , ("g", S.google)
             , ("u", urban)
             , ("w", S.wikipedia)
             , ("y", S.youtube)
             ]

-- Mouse bindings: default actions bound to mouse events
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))]

-- No borders are applied
-- if fewer than two windows. So a single window has no gaps.
mySpacing :: Integer -> l a -> XMonad.Layout.LayoutModifier.ModifiedLayout Spacing l a
mySpacing i = spacingRaw True (Border i i i i) True (Border i i i i) True

-- Layouts:
tall = renamed [ Replace "tall" ]
        $ limitWindows 16
        $ mySpacing 2
        $ ResizableTall 1 (1/300) (1/2) []
full = renamed [ Replace "full" ]
        $ limitWindows 8
        $ Full
        
-- myLayout = ( smartBorders full ||| (avoidStruts $ mouseResize (tall ||| Mirror (tall))))
myLayout = smartBorders $ avoidStruts $ mouseResize $ myDefaultLaout
        where
          myDefaultLaout = tall ||| Mirror (tall) ||| full

-- > xprop | grep WM_CLASS
myManageHook :: XMonad.Query (Data.Monoid.Endo WindowSet)
myManageHook = composeAll
    [ className =? "Brave-browser" --> doShift ( myWorkspaces !! 0 )
    , className =? "discord" --> doShift ( myWorkspaces !! 4 )
    , className =? "Google-chrome" --> doShift ( myWorkspaces !! 0 )
    , className =? "Gimp-2.10" --> doShift ( myWorkspaces !! 6 )
    , className =? "Gimp" --> doShift ( myWorkspaces !! 6 )
    , className =? "Mailspring" --> doShift (myWorkspaces !! 5 )
    , className =? "firefox" --> doShift ( myWorkspaces !! 0 ) -- Firefox
    , className =? "obs" --> doShift ( myWorkspaces !! 6 )
    , className =? "Gcr-prompter" --> doShift ( myWorkspaces !! 5 )
    
    , className =? "Qalculate-gtk" --> doSideFloat SC -- S-south, etc. C-center

    -- , className =? "Apostrophe" --> doCenterFloat
    -- , className =? "Typora" --> doCenterFloat

    , isDialog --> doCenterFloat
    , resource =? "desktop_window" --> doIgnore
    , resource =? "kdesktop"       --> doIgnore ]


myLogHook :: X ()
myLogHook = fadeInactiveLogHook fadeAmount
    where fadeAmount = 1.0

-- Startup hook
myStartupHook = do
        spawnOnce "redshift &"
        spawnOnce "nitrogen --retore &"
        spawnOnce "picom --experimental-backends &"

myEasyKeys :: String -> [(String, X ())]
myEasyKeys home =
    -- XMonad
        [ ("M-q", spawn "xmonad --recompile")   --
        , ("M-S-q", spawn "xmonad --restart")   --
        , ("M-C-q", io exitSuccess)             --

    -- Apps
        , ("M-<Return>", spawn myTerminal)
        , ("M-e",spawn (myTerminal ++ " -e vifm .")) -- File viewer
        , ("M-S-e",spawn "nemo")                     -- File viewer
        , ("M-n a",spawn "apostrophe")               -- Markdown editor
        , ("M-n s",spawn "typora")                   -- Markdown editor


    -- Prompts
        -- , ("M-S-<Return>", shellPrompt joakoXPConfig)
        , ("M-S-<Return>", spawn "rofi -show drun" )
        -- , ("M-p e", editPrompt home)        
        , ("M-p e", spawn "~/.config/rofi/edit-files.sh")
        , ("M-r", spawn "rofi -show run")
        , ("M-p m", manPrompt joakoXPConfig)          -- manPrompt

    -- Killers
        , ("M-C-c", kill)
        , ("M-C-S-c", killAll)

    -- Floating windows
        , ("M-t", withFocused $ windows . W.sink)     -- Put floating focused window into the pile
        , ("M-S-t", sinkAll)

    -- Window navigation
        , ("M-m", windows W.focusMaster)  -- 
        , ("M1-<Tab>", windows W.focusDown)  -- 
        , ("M1-S-<Tab>", windows W.focusUp)  -- 
        , ("M-j", windows W.focusDown)    -- 
        , ("M-k", windows W.focusUp)      -- 
        , ("M-S-m", windows W.swapMaster) -- Swap the focused window and the master window
        , ("M-S-j", windows W.swapDown)   -- Swap focused window with next window
        , ("M-S-k", windows W.swapUp)     -- Swap focused window with prev window
        , ("M-<Backspace>", promote)      -- Moves focused window to master, others maintain order
        , ("M-S-<Tab>", rotSlavesDown)    -- Rotate all windows except master and keep focus in place
        , ("M-C-<Tab>", rotAllDown)       -- Rotate all the windows in the current stack
        -- , ("M1-<Tab>", rotFocusedUp)

    -- Laouts
        , ("M-<Tab>", sendMessage NextLayout)
        , ("M-S-<Space>", sendMessage ToggleStruts)     -- Toggles struts

    -- Window resizing
        , ("M-h", sendMessage Shrink)                   -- Shrink horiz window width
        , ("M-l", sendMessage Expand)                   -- Expand horiz window width
        , ("M-M1-j", sendMessage MirrorShrink)          -- Shrink vert window width
        , ("M-M1-k", sendMessage MirrorExpand)          -- Exoand vert window width

    -- Multimedia
        , ("<XF86AudioLowerVolume>", spawn "amixer set Master 5%- unmute")
        , ("<XF86AudioRaiseVolume>", spawn "amixer set Master 5%+ unmute")
        , ("<Scroll_lock>", spawn "betterlockscreen -s -l dim")
        , ("<Print>", spawn "scrot -q 90 ~/Imagenes/ScreenShots/'full_%d-%m-%Y_%H:%M:%S'.png")
        , ("S-<Print>", spawn "scrot -q 90 -s -f --line width=2,color=\"#ff79c6\" ~/Imagenes/screenshots/'recorted_%d-%m-%Y_%H:%M:%S'.png")
        ]
        ++ [("M-b " ++ k, S.promptSearch joakoXPConfig f) | (k,f) <- searchList ]
        ++ [("M-b b " ++ k, S.selectSearch f) | (k,f) <- searchList ]



myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- launch firefox
    [ ((modm,xK_masculine), spawn "firefox")
    , ((modm, xK_period), hideXmobar )
    , ((modm, xK_v), return ())
    -- , ((0, xK_Alt_R), return ())
    -- , ((modm, xK_l), toggleDocksHook 400 xK_l)
    ]
    ++
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_a, xK_s, xK_d, xK_f, xK_z, xK_x, xK_c, xK_v]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]


main :: IO ()
main = do
        home <- getHomeDirectory
        xmproc <- spawnPipe "xmobar $HOME/.config/xmobar/xmobarrc"
        xmonad $ fullscreenSupport $ docks $ ewmh def
            { manageHook = ( isFullscreen --> doFullFloat ) <+> manageDocks <+> myManageHook <+> insertPosition End Newer
            , handleEventHook    = myDocksEventHook <+> myToggleDocksHook
            , keys               = myKeys
            , mouseBindings      = myMouseBindings
            , modMask            = myModMask
            , terminal           = myTerminal
            , startupHook        = myStartupHook
            , layoutHook         = myLayout
            , workspaces         = myWorkspaces
            , borderWidth        = myBorderWidth
            , clickJustFocuses   = myClickJustFocuses
            , normalBorderColor  = myNormalBorderColor
            , focusedBorderColor = myFocusedBorderColor
            , focusFollowsMouse  = myFocusFollowsMouse
            , logHook = workspaceHistoryHook <+> dynamicLogWithPP xmobarPP
                        { ppOutput = \x -> hPutStrLn xmproc x 
                        , ppCurrent = xmobarColor "#98be65" "" . wrap "[" "]" -- Current workspace in xmobar
                        , ppVisible = xmobarColor "#98be65" ""                -- Visible but not current workspace
                        , ppHidden = xmobarColor "#82AAFF" "" . wrap "" ""    -- Hidden workspaces in xmobar "*" ""
                        , ppHiddenNoWindows = xmobarColor "#bd93f9" ""        -- Hidden workspaces (no windows)
                        , ppTitle = xmobarColor "#b3afc2" "" . shorten 60     -- Title of active window in xmobar
                        , ppSep =  "<fc=#666666> <fn=1>\xf6d8</fn> </fc>"          -- Separators in xmobar
                        , ppUrgent = xmobarColor "#C45500" "" . wrap "!" "!"  -- Urgent workspace
                        -- , ppExtras  = [windowCount]                           -- # of windows current workspace
                        , ppOrder  = \(ws:l:t:ex) -> [ws,l]++ex++[t]
                        }
            } `additionalKeysP` myEasyKeys home

