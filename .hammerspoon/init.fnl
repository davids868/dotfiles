(set hs.logger.defaultLogLevel "info")

(local {:application app :hotkey hotkey} hs)

(hs.alert.show "Hammerspoon Loaded" 0.4)

; use the SpoonInstall Spoon easy installing+loading of Spoons
;; (hs.loadSpoon :SpoonInstall)
;; (local install (. spoon :SpoonInstall))

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
  { :c "Google Chrome" }
  { :v "VMware Fusion" }
  { :s "Slack" }
  { :m "Spotify" }
  { :w "whatsapp" }
  { "," "System Preferences" }
  { :n "Notes" }
  { :o "Orion" }
  { :g "OnfidoGmail" }
  { :a "AWS VPN Client" }
  { :p "1Password 7" }
  { :y "YouTube" }
  { :k "Monkeytype" }
  { :z "zoom.us" }
  ])
