function steam-safe --wraps='flatpak run com.valvesoftware.Steam' --description 'alias steam-safe=flatpak run com.valvesoftware.Steam'
    flatpak run com.valvesoftware.Steam $argv
end
