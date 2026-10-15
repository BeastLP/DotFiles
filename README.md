# Meine Dotfiles

Meine CachyOS-Einstellungen mit dem ursprünglichen interaktiven Sync-Skript.
Die fremden Konfigurationen sind entfernt; eigene Einstellungen werden zuerst
vom Laptop übernommen. Leere Ordner werden von Git nicht gespeichert.

## 1. Einmalig vorbereiten

Alle Befehle im Terminal auf dem CachyOS-Laptop ausführen, auch mit Fish.

### Programme installieren

```bash
sudo pacman -Syu --needed git gum paru expac github-cli
```

Der Befehl aktualisiert auch das System. `gum` stellt das Menü dar;
`paru` und `expac` benötigt das Skript für die Paketverwaltung.
`github-cli` dient zur GitHub-Anmeldung.

### Bei GitHub anmelden

```bash
gh auth login --hostname github.com --git-protocol https --web
gh auth setup-git
```

Der Browser-Anmeldung folgen und den Account **BeastLP** verwenden.
Bei bereits eingerichteter GitHub-Anmeldung kann dieser Schritt entfallen.

### Repo herunterladen

```bash
git clone https://github.com/BeastLP/DotFiles.git ~/DotFiles-clean
cd ~/DotFiles-clean
git config user.name "Fabian Stang"
git config user.email "DEINE-GITHUB-COMMIT-EMAIL"
```

Den E-Mail-Platzhalter durch die eigene GitHub-E-Mail oder die private
`noreply`-Adresse aus [GitHub → Settings → Emails](https://github.com/settings/emails)
ersetzen.

Der Zielordner muss neu sein. Falls er bereits existiert, einen anderen Namen
verwenden und die folgenden Pfade entsprechend anpassen. Bisherige Config- oder
Repo-Ordner nicht löschen: Bestehende Verknüpfungen können darauf zeigen.

## 2. Beim ersten Mal eigene Einstellungen übernehmen

Im heruntergeladenen Repo starten, **ohne sudo**:

```bash
cd ~/DotFiles-clean
bash sync_dotfiles.sh
```

1. **Manage Config Folders (Symlinks)** auswählen.
2. Mit Pfeiltasten navigieren und mit **Leertaste** nur die gewünschten eigenen
   Ordner markieren: etwa `fish`, `hypr`, `kitty`, `nvim`, `rofi`, `waybar`
   und gegebenenfalls `jolt`.
3. Mit **Enter** übernehmen.
4. Prüfen, ob die Programme weiterhin funktionieren, und die Rückfrage beantworten.

**Das Skript verschiebt ausgewählte lokale Config-Ordner ins Repo und ersetzt
sie durch Symlinks.** Vorher erstellt es Backups unter
`~/.config/dotfiles-sync/history`. Änderungen an den verknüpften Einstellungen
landen danach direkt im Repo.

Bereits als Symlink vorliegende lokale Ordner können im Menü fehlen; das betrifft
möglicherweise `jolt`. Solche Verknüpfungen zunächst bestehen lassen und
gesondert prüfen.

## 3. Prüfen und erstmals hochladen

Vor dem Upload in einem zweiten Terminal:

```bash
cd ~/DotFiles-clean
git status --short
git add -N .
git diff
```

`git add -N .` macht auch neue Dateien in der Differenz sichtbar, erstellt aber
keinen Commit. Die Anzeige von `git diff` mit **q** schließen.

Das Repo ist öffentlich. Zugangsdaten, Shell-Verläufe und unerwünschte
gerätespezifische Einstellungen vor dem Upload entfernen oder gezielt ausschließen.
Das Skript filtert diese Daten und eingebettete Monitorregeln nicht automatisch;
sein Upload erfasst alle nicht ignorierten Änderungen im Repo.

Anschließend im Skript **Upload Changes (Git Push)** auswählen, bestätigen und
beispielsweise diese Commit-Nachricht eingeben:

```text
feat(config): import personal laptop settings
```

Nach einem erfolgreichen Push sind die Einstellungen auf GitHub sichtbar.
Bei Git-Fehlermeldungen zuerst den Fehler klären; die abschließende
Erfolgsmeldung des bisherigen Skripts allein ist kein verlässlicher Nachweis.

## 4. Später aktualisieren

Das Menü erneut öffnen:

```bash
cd ~/DotFiles-clean
bash sync_dotfiles.sh
```

| Aufgabe | Vorgehen |
| --- | --- |
| Eigene Änderungen sichern | Wie oben prüfen, dann **Upload Changes (Git Push)** wählen. |
| Änderungen von GitHub holen | Bei sauberem Arbeitsstand die Befehle unten ausführen. |
| Weitere Config-Ordner aufnehmen | **Manage Config Folders (Symlinks)** öffnen, bisherige Auswahl beibehalten und ergänzen. |
| Paketliste verwalten | **Manage System Packages** öffnen; fehlende ausgewählte Pakete können installiert werden. |

Updates von GitHub herunterladen:

```bash
cd ~/DotFiles-clean
git status --short
git pull --ff-only
```

Wenn `git status --short` Änderungen zeigt, diese zuerst prüfen und sichern.
Bei einem Fehler von `git pull --ff-only` stoppen und die Ursache klären.

Durch die Symlinks wirken heruntergeladene Config-Änderungen direkt auf die
lokalen Dateien. Manche Programme müssen anschließend neu geladen oder
gestartet werden. Das Repo deshalb dauerhaft an seinem Platz belassen.

**Auto-Sync** oder `bash sync_dotfiles.sh --sync` kombiniert Download,
Paketinstallation, Config-Verknüpfungen und die Upload-Abfrage. Für den Einstieg
die einzelnen Schritte oben verwenden. Es handelt sich um manuell gestartete
Synchronisierung, nicht um einen Hintergrunddienst.
