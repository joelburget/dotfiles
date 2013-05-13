-------------------------------------------------------------------------------
-- |
-- Module      :  xmonad.hs
-- Copyright   :  (c) Patrick Brisbin 2010, Joel Burget 2010-2012
-- License     :  BSD3
--
-- Maintainer  :  joelburget@gmail.com
-- Stability   :  unstable
-- Portability :  unportable
--
-- vim:foldmethod=marker foldmarker={{{,}}}
-------------------------------------------------------------------------------
--
-- TODO:
--   Make Dzen bar translucent, have trayer match
--   Battery Meter
--   Single Dzen bar
--   Dzen on both screens
--   Look at bluetile, copy their title bars / other things
--
-- Links:
--   This is nice:  http://phollow.fr/2009/03/la-config-du-mois-mars-2009/
--   Notification of volume, brightness, etc. would be nice


-- Imports {{{

-- xmonad
import XMonad hiding ((|||))
import qualified XMonad.StackSet as W

-- xmonad-contrib
import XMonad.Actions.CycleWS            (toggleWS)
import XMonad.Actions.FindEmptyWorkspace (tagToEmptyWorkspace, viewEmptyWorkspace)
import XMonad.Actions.WithAll            (killAll)
import XMonad.Actions.GridSelect         (goToSelected, defaultGSConfig)
import XMonad.Hooks.EwmhDesktops         (ewmh)
import XMonad.Hooks.ManageHelpers        (doCenterFloat, isDialog, isFullscreen, doFullFloat, (/=?))
import XMonad.Hooks.ManageDocks          (avoidStruts, manageDocks)
import XMonad.Hooks.UrgencyHook          (withUrgencyHook, UrgencyHook, UrgencyConfig (UrgencyConfig), SuppressWhen (OnScreen), RemindWhen (Repeatedly), focusUrgent, clearUrgents, urgencyHook, NoUrgencyHook(NoUrgencyHook))
import XMonad.Layout                     (ChangeLayout(NextLayout))
import XMonad.Layout.Decoration          (shrinkText)
import XMonad.Layout.Fullscreen          (fullscreenFull)
import XMonad.Layout.IM                  (Property(..), withIM)
import XMonad.Layout.LayoutCombinators   ((|||), JumpToLayout(..))
import XMonad.Layout.LayoutHints         (layoutHintsWithPlacement)
import XMonad.Layout.NoBorders           (noBorders)
import XMonad.Layout.PerWorkspace        (onWorkspace)
import XMonad.Layout.ResizableTile       (ResizableTall(..), MirrorResize(..))
import XMonad.Layout.SimpleFloat         (simpleFloat')
import XMonad.Layout.SimpleDecoration    (defaultTheme)
-- import XMonad.Layout.ToggleLayouts       (ToggleLayout(ToggleLayout))
import XMonad.Util.EZConfig              (additionalKeysP)
import XMonad.Util.Run                   (spawnPipe)

import Graphics.X11.Xinerama (getScreenInfo)

-- haskell stuff
import Data.List      (isPrefixOf)
import System.IO      (Handle, hPutStrLn, hGetContents)
import System.Process (runInteractiveCommand)
import System.FilePath.Posix
import System.Time

-- }}}

-- Main {{{
main :: IO ()
main = xmonad $ withUrgencyHook NoUrgencyHook $ defaultConfig
        { terminal           = myTerminal
        -- , modMask            = mod4Mask
        , workspaces         = myWorkspaces
        , borderWidth        = myBorderWidth
        , normalBorderColor  = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
        , layoutHook         = myLayout
        , manageHook         = myManageHook
        } `additionalKeysP` myKeys

-- }}}

-- Options {{{
myTerminal           = "urxvtc"
myBorderWidth        = 2
myNormalBorderColor  = colorFG
myFocusedBorderColor = colorFoc

-- if you change workspace names, be sure to update them throughout
myWorkspaces = "web" : map show [2..6] ++ ["mail", "chat", "hidden"]

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
colorFoc = "#5eb050"

-- }}}

-- Layouts {{{
myLayout = avoidStruts standardLayouts

    where
        standardLayouts = tiled ||| simpleFloat' shrinkText defaultTheme ||| full

        tiled = hinted $ ResizableTall 1 (1/100) golden []
        full = noBorders $ fullscreenFull Full

        -- golden ratio
        golden = toRational $ 1 - 2/(1 + sqrt 5 :: Double)

        -- custom hintedTile
        hinted = layoutHintsWithPlacement (0, 0)

-- screenCount :: X Int
-- screenCount = withDisplay (io.fmap length.getScreenInfo)
-- }}}

-- ManageHook {{{
myManageHook :: ManageHook
myManageHook = mainManageHook
           <+> manageDocks
           <+> manageFullScreen

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

-- KeyBindings {{{
myKeys :: [(String, X())]
myKeys = [ ("M-p"                   , spawn "$(echo | yeganesh)"   ) -- dmenu app launcher
         , ("M-l"                  , sendMessage NextLayout)

         -- opening apps with Win
         , ("M-m"                  , myMail             ) -- open mail client
         , ("M-b"                  , myBrowser          ) -- open web client
         , ("M-S-l"                , myLock             ) -- W-l to lock screen
         , ("M-C-l"                , spawn "sudo pm-suspend")
         , ("M-i"                  , myIRC              ) -- open/attach IRC client in screen
         , ("M-r"                  , myTorrents         ) -- open/attach rtorrent in screen

         -- some custom hotkeys
         , ("<Print>"              , sshot1             ) -- take a screenshot
         , ("S-<Print>"            , sshot2             ) -- take a screenshot

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

         , ("<XF86AudioMute>"        , spawn "amixer -c 0 sset Master toggle") -- toggle mute
         , ("<XF86AudioLowerVolume>" , spawn "amixer -c 0 sset Master 1-"    ) -- volume down
         , ("<XF86AudioRaiseVolume>" , spawn "amixer -c 0 sset Master 1+"    ) -- volume up
         , ("<XF86MonBrightnessUp>"  , spawn "/home/joel/bin/brightness up"  )
         , ("<XF86MonBrightnessDown>", spawn "/home/joel/bin/brightness down")

         , ("M-C-1", spawn "disper -d DFP-0,CRT-0 -t top -e; /home/joel/bin/brightness") -- both screens
         , ("M-C-2", spawn "disper -d CRT-0 -s; /home/joel/bin/brightness"             ) -- external monitor only
         , ("M-C-3", spawn "disper -d DFP-0 -s; /home/joel/bin/brightness"             ) -- built-in monitor only
         , ("M-C-0", spawn "/home/joel/bin/brightness"                                 ) -- reset brightness
         ]

    where

        shotsDir = "~/shots"
        sshot1 = io $ do
          t <- getClockTime
          t2 <- (\(TOD sec _) -> return sec) t
          spawn $ "scrot " ++ addExtension (combine shotsDir (show t2)) ".png"
        sshot2 = io $ do
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

-- }}}detect
