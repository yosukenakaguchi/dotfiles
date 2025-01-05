hs.hotkey.bind({"alt"}, "space", function()
  local ghostty = hs.application.find('ghostty')
  if ghostty:isFrontmost() then
    ghostty:hide()
  else
    hs.application.launchOrFocus("/Applications/Ghostty.app")
  end
end)