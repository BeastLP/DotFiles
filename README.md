# Meine Dotfiles

Saubere Grundlage für meine eigenen CachyOS-Einstellungen.

Die übernommenen Konfigurationsordner wurden entfernt. Das ursprüngliche
`sync_dotfiles.sh` mit seinem interaktiven Menü und die leere Paketliste bleiben
erhalten. Eigene Konfigurationen müssen zuerst vom Laptop übernommen werden.
Leere Ordner werden von Git nicht gespeichert.

## Eigene Einstellungen übernehmen

Nach Prüfung und Merge des Bereinigungs-PRs auf dem Laptop:

```bash
git clone https://github.com/BeastLP/DotFiles.git ~/DotFiles-clean
cd ~/DotFiles-clean
bash sync_dotfiles.sh
```

Einen neuen Zielordner verwenden. Das Skript benötigt `gum`, `paru` und `expac`.

1. **Manage Config Folders (Symlinks)** öffnen.
2. Nur die eigenen gewünschten Ordner auswählen, beispielsweise
   `fish`, `hypr`, `jolt`, `kitty`, `nvim`, `rofi` und `waybar`, soweit angezeigt.
3. Die Übernahme prüfen und bestätigen.
4. Vor **Upload Changes (Git Push)** in einem zweiten Terminal
   `git -C ~/DotFiles-clean status --short` ausführen und die neuen Dateien prüfen.
   Zugangsdaten, Shell-Verläufe und gerätespezifische Einstellungen nicht hochladen.

**Verhalten des bisherigen Skripts:** Es verschiebt ausgewählte lokale
Konfigurationsordner ins Repo und ersetzt sie durch Symlinks. Es legt vorher
Backups unter `~/.config/dotfiles-sync/history` an. Es ist kein reines Kopierskript
und filtert persönliche Daten nicht automatisch heraus.

Bereits als Symlink vorliegende lokale Ordner werden eventuell nicht im Menü
angezeigt. Solche Verknüpfungen vor einer Übernahme gesondert prüfen.
