-------------------------------------------------------------------------------
-- |
-- Module      :  xmonad.hs
-- Copyright   :  (c) Patrick Brisbin 2010, Joel Burget 2010, 2011
-- License     :  BSD3
--
-- Maintainer  :  joelburget@gmail.com
-- Stability   :  unstable
-- Portability :  unportable
--
-- Up to date [testing], using -darcs, last modified September 16, 2010
--
-- vim:foldmethod=marker foldmarker={{{,}}}
-------------------------------------------------------------------------------
--
-- TODO: 
--   Make Dzen bar translucent, have trayer match
--   Battery Meter
--   Single Dzen bar
--   Dzen on both screens
--
-- Links:
--   Dzen multiplexer: 
--     http://dzen.geekmode.org/dwiki/doku.php?id=dzen:multiplexer
--     implemented as dmhplex in .bin
--   guide on setting up: https://bbs.archlinux.org/viewtopic.php?id=55673
--   battery meter:
--     http://dzen.geekmode.org/dwiki/doku.php?id=dzen:battery-meter
--     icons in .xmonad/dzen_bitmaps
--   This is nice:  http://phollow.fr/2009/03/la-config-du-mois-mars-2009/
--   Brightness adjustment
--   Notification of volume, brightness, etc. would be nice


-- Imports {{{

-- my lib
import Dzen           -- http://pbrisbin.com/xmonad/docs/Dzen.html
import ScratchPadKeys -- http://pbrisbin.com/xmonad/docs/ScratchPadKeys.html

-- xmonad
import XMonad hiding ((|||))
import qualified XMonad.StackSet as W

-- xmonad-contrib
import XMonad.Actions.CycleWS            (toggleWS)
import XMonad.Actions.FindEmptyWorkspace (tagToEmptyWorkspace, viewEmptyWorkspace)
import XMonad.Actions.WithAll            (killAll)
import XMonad.Actions.GridSelect
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops         (ewmh)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.IM                  (Property(..), withIM)
import XMonad.Layout.LayoutCombinators   ((|||), JumpToLayout(..))
import XMonad.Layout.LayoutHints         (layoutHintsWithPlacement)
import XMonad.Layout.NoBorders           (Ambiguity(..), With(..), lessBorders)
import XMonad.Layout.PerWorkspace        (onWorkspace)
import XMonad.Layout.ResizableTile       (ResizableTall(..), MirrorResize(..))
import XMonad.Layout.SimpleFloat         (simpleFloat')
import XMonad.Layout.SimpleDecoration    (defaultTheme)
import XMonad.Layout.Decoration          (shrinkText)
import XMonad.Util.EZConfig              (additionalKeysP)

-- haskell stuff
import Data.List      (isPrefixOf)
import System.IO      (Handle, hPutStrLn, hGetContents)
import System.Process (runInteractiveCommand)
import System.FilePath.Posix
import System.Time

-- }}}

-- Main {{{
main :: IO ()
main = do
    d <- spawnDzen myLeftBar

    spawn "conky"
    spawn $ "conky -c ~/.dzen_conkyrc | " ++ show myRightBar

    -- ewmh just makes wmctrl work
    xmonad $ ewmh $ withUrgencyHookC myUrgencyHook myUrgencyConfig $ defaultConfig
        { terminal           = myTerminal
        , modMask            = mod4Mask
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , layoutHook         = myLayout
        , manageHook         = myManageHook
        , logHook            = myLogHook d
        } `additionalKeysP` myKeys

-- }}}

-- Options {{{
myTerminal           = "urxvtc"
myBorderWidth        = 2
myNormalBorderColor  = colorFG
myFocusedBorderColor = "#5eb050"

-- if you change workspace names, be sure to update them throughout
myWorkspaces = clickable . (map dzenEscape) $ "web" : (map show [2..6]) ++ ["mail", "chat", "hidden"]
  where clickable l = [ "^ca(1,xdotool key super+" ++ show (n) ++ ")" ++ ws ++ "^ca()" |
                        (i,ws) <- zip [1..] l,
                        let n = i ]

-- aur/dzen2-svn is required for an xft font
--myFont = "terminus 8"
--myFont = "-*-terminus-*-r-normal-*-*-120-*-*-*-*-iso8859-*"
myFont = "xft:Bitstream Vera Sans Mono:pixelsize=11:antialias=true"


-- background/foreground and various levels of emphasis
colorBG  = "#303030"
colorFG  = "#606060"
colorFG2 = "#909090"
colorFG3 = "#c4df90"
colorFG4 = "#cc896d"
colorFG5 = "#c4df90"
colorFG6 = "#ffffba"

-- status bar sizes
leftBarWidth  = 670
rightBarWidth = 560

-- }}}

-- Layouts {{{
--
-- See http://pbrisbin.com:8080/pages/im-layout.html#update
--
myLayout = avoidStruts $ onWorkspace "8-chat" imLayout $ standardLayouts

    where
        -- gajim's roster on left tenth, standardLayouts in the rest
        imLayout = withIM (1/10) (Role "roster") standardLayouts

        standardLayouts = tiled {-||| Mirror tiled-} ||| (simpleFloat' shrinkText defaultTheme) ||| full

        tiled = hinted $ ResizableTall 1 (1/100) golden []
        full  = hinted $ Full

        -- golden ratio
        golden = toRational $ 2/(1 + sqrt 5 :: Double)

        -- custom hintedTile
        hinted l = layoutHintsWithPlacement (0,0) l

-- }}}

-- ManageHook {{{
myManageHook :: ManageHook
myManageHook = mainManageHook <+> manageDocks <+> manageFullScreen <+> manageScratchPads scratchPadList

    where
        -- the main managehook
        mainManageHook = composeAll $ concat
            [ [ resource  =? r     --> doIgnore         |  r    <- myIgnores ]
            , [ className =? c     --> doShift "1-web"  |  c    <- myWebs    ]
            , [ title     =? t     --> doShift "8-chat" |  t    <- myChats   ]
            , [ className =? c     --> doShift "8-chat" | (c,_) <- myIMs     ]
            , [ className =? c     --> doFloat          |  c    <- myFloats  ]
            , [ className =? c     --> doCenterFloat    |  c    <- myCFloats ]
            , [ name      =? n     --> doCenterFloat    |  n    <- myCNames  ]
            , [ classNotRole (c,r) --> doFloat          | (c,r) <- myIMs     ]
            , [ isDialog           --> doCenterFloat                         ]
            ]

        -- fullscreen but still allow focusing of other WSs
        manageFullScreen = isFullscreen --> doF W.focusDown <+> doFullFloat

        -- a special query to find an im window that's not my buddy list
        classNotRole :: (String,String) -> Query Bool
        classNotRole (c,r) = className =? c <&&> role /=? r

        role = stringProperty "WM_WINDOW_ROLE"
        name = stringProperty "WM_NAME"

        myIMs     = [("Gajim.py","roster")]
        myIgnores = ["desktop","desktop_window"]
        myChats   = ["irssi","mutt"]
        myWebs    = ["chromium", "chromium-dev", "firefox", "Uzbl","Uzbl-core","Jumanji"]
        myFloats  = ["MPlayer","Zenity","VirtualBox","rdesktop", "gimp", "xv"]
        myCFloats = ["Xmessage","Save As...","XFontSel"]
        myCNames  = ["bashrun"]

-- }}}

-- StatusBars {{{
--
-- See http://pbrisbin.com:8080/xmonad/docs/Dzen.html
--
myLeftBar :: DzenConf
myLeftBar = defaultDzen
    { width       = leftBarWidth
    , font        = myFont
    , fg_color    = colorFG
    , bg_color    = colorBG
    }

myRightBar :: DzenConf
myRightBar = myLeftBar
    { x_position = leftBarWidth
    , width      = rightBarWidth
    , alignment  = RightAlign
    }

-- }}}

-- LogHook {{{
--
-- todo: refactor this
--
myLogHook :: Handle -> X ()
myLogHook h = do 
    dynamicLogWithPP $ defaultPP
        { ppCurrent         = dzenColor "#303030" "#909090" . pad
        , ppVisible         = dzenFG colorFG2 . pad
        , ppHidden          = dzenFG colorFG2 . noScratchPad
        , ppHiddenNoWindows = namedOnly
        , ppUrgent          = dzenFG colorFG4 . pad . dzenStrip
        , ppSep             = replicate 4 ' '
        , ppWsSep           = []
        , ppTitle           = shorten 100 
        , ppLayout          = dzenFG colorFG2 . renameLayouts . stripIM
        -- myUpdates is too slow. when webkit starts throwing X events
        -- like it's on crack, the whole WM becomes unusable for a few
        -- seconds. feel free to use it if you don't run one of them
        -- new-fangled minimal webkit browsers :)
        , ppOutput          = hPutStrLn h
        }

    where

        namedOnly    ws = if any (`elem` ws) ['a'..'z'] then pad ws else ""
        noScratchPad ws = if ws /= "NSP"                then pad ws else ""

        -- L needed for loggers
        dzenFG  c = dzenColor  c ""

        renameLayouts s = case s of
            "Hinted ResizableTall"          -> "/ /-/"
            "Mirror Hinted ResizableTall"   -> "/-,-/"
            "Hinted Full"                   -> "/   /"
            "Simple Float"                  -> "/.../"
            _                               -> s

        stripIM s = if "IM " `isPrefixOf` s then drop (length "IM ") s else s


-- }}}

-- SpawnHook {{{
--
-- Spawn any arbitrary command on urgent
--
data MySpawnHook = MySpawnHook String deriving (Read, Show)

instance UrgencyHook MySpawnHook where
    urgencyHook (MySpawnHook s) w = spawn s

myUrgencyHook :: MySpawnHook
myUrgencyHook = MySpawnHook "ossplay -q /usr/share/gajim/data/sounds/message2.wav" 

myUrgencyConfig :: UrgencyConfig
myUrgencyConfig = UrgencyConfig OnScreen (Repeatedly 1 30)

-- }}}

-- KeyBindings {{{
myKeys :: [(String, X())]
myKeys = [ ("M-p"                   , spawn "$(echo | yeganesh)"   ) -- dmenu app launcher
         , ("M-S-p"                 , spawn "bashrun"    ) -- gmrun replacement

         -- opening apps with Win
         , ("M-m"                  , myMail             ) -- open mail client
         , ("M-b"                  , myBrowser          ) -- open web client
         , ("M-S-l"                , myLock             ) -- W-l to lock screen
         , ("M-i"                  , myIRC              ) -- open/attach IRC client in screen
         , ("M-r"                  , myTorrents         ) -- open/attach rtorrent in screen 

         -- some custom hotkeys
         , ("<Print>"               , spawn "sshot"        ) -- take a screenshot

         -- extended workspace navigations
         , ("M-`"                   , toggleWS           ) -- switch to the most recently viewed ws
         , ("M-<Backspace>"         , focusUrgent        ) -- focus most recently urgent window
         , ("M-S-<Backspace>"       , clearUrgents       ) -- make urgents go away
         , ("M-0"                   , viewEmptyWorkspace ) -- go to next empty workspace
         , ("M-S-0"                 , tagToEmptyWorkspace) -- send window to empty workspace and view it

         -- extended window movements
         , ("M-z"                   , mirrorShrink       ) -- shink slave panes vertically
         , ("M-a"                   , mirrorExpand       ) -- expand slave panes vertically
         , ("M-f"                   , jumpToFull         ) -- jump to full layout
         , ("M-s"                   , goToSelected defaultGSConfig)

         , ("<XF86AudioMute>"       , spawn "amixer -c 0 sset Master toggle") -- toggle mute
         , ("<XF86AudioLowerVolume>", spawn "amixer -c 0 sset Master 1-") -- volume down 
         , ("<XF86AudioRaiseVolume>", spawn "amixer -c 0 sset Master 1+") -- volume up
         -- kill, reconfigure, exit commands
         , ("M-q"                   , myRestart          ) -- restart xmonad
         , ("M-S-q"                 , spawn "leave"      ) -- logout menu

         -- See http://pbrisbin.com:8080/xmonad/docs/ScratchPadKeys.html
         ] ++ scratchPadKeys scratchPadList

    where

        shotsDir = "~/shots"
        sshot1 = do
          t <- getClockTime
          t2 <- (\(TOD sec _) -> return sec) t
          spawn $ "scrot " ++ addExtension (combine shotsDir (show t2)) ".png"
        sshot2 = do
          t <- getClockTime
          t2 <- (\(TOD sec _) -> return sec) t
          spawn $ "scrot -s " ++ addExtension (combine shotsDir (show t2)) ".png"
            

        shrink = sendMessage Shrink
        expand = sendMessage Expand

        mirrorShrink = sendMessage MirrorShrink
        mirrorExpand = sendMessage MirrorExpand

        focusScreen n = screenWorkspace n >>= flip whenJust (windows . W.view)
        jumpToFull    = sendMessage $ JumpToLayout "Hinted Full"

        myBrowser  = spawn "chromium"
        myLock     = spawn "slimlock"
        --myEject    = spawn "eject -T"
        myMail     = spawn $ myTerminal ++ " -e sup"

        -- see http://pbrisbin.com:8080/pages/screen_tricks.html
        myIRC      = spawnInScreen "irssi"
        myTorrents = spawnInScreen "rtorrent"

        spawnInScreen s = spawn $ unwords [ myTerminal, "-title", s, "-e bash -cl", command s ]

            where
                -- a quoted command to pass off to bash -cl
                command s = ("\""++) . (++"\"") $ unwords ["SCREEN_CONF=" ++ s, "screen -S", s, "-R -D", s]

        -- see http://pbrisbin.com:8080/pages/mplayer-control.html
        mplayer s = spawn $ unwords [ "echo", s, "> $HOME/.mplayer_fifo" ]

        -- kill all conky/dzen2 before executing default restart command
        myRestart = spawn $ "for pid in `pgrep conky`; do kill -9 $pid; done && " ++
                            "for pid in `pgrep dzen2`; do kill -9 $pid; done && " ++
                            "xmonad --recompile && xmonad --restart"

-- }}}
