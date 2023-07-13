(set hs.logger.defaultLogLevel "info")

(local {:application app :hotkey hotkey} hs)

(hs.alert.show "Hammerspoon Loaded" 0.4)

; use the SpoonInstall Spoon easy installing+loading of Spoons
(hs.loadSpoon :SpoonInstall)
(local install (. spoon :SpoonInstall))
(: install :andUse :HoldToQuit)

(set spoon.HoldToQuit.duration 0.5)
(: spoon.HoldToQuit :init)
(: spoon.HoldToQuit :start)

(fn launch [application]
  (fn []
    (hs.application.launchOrFocus application)))

(local hyper [:ctrl :option :cmd :shift])

(hotkey.bind hyper :r (fn [] (hs.reload)))

(fn launchers [args]
  (each [_ tuple (ipairs args)]
    (each [key value (pairs tuple)]
      (hotkey.bind hyper key (launch value)))))

(launchers [
  { :t "alacritty" }
  { :f "Finder" }
  { :c "Brave Browser" }
  { :v "alacritty" }
  { :s "Slack" }
  { :d "Discord" }
  { :m "Spotify" }
  { :w "whatsapp" }
  { "," "System Preferences" }
  { :n "Notes" }
  { :t "Notion" }
  { :o "Opera Developer" }
  { :g "Mail" }
  { :a "AWS VPN Client" }
  { :p "1Password" }
  { :y "YouTube" }
  { :k "Monkeytype" }
  { :z "Google Meet" }
  { :e "excalidraw" }
  { :b "Beekeeper Studio" }
  { :l "Calendar" }
  ])
