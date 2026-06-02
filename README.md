# centrex-desktop-kde

KDE Plasma desktop layer for CentrexOS. Contains theme configuration, defaults, SDDM login screen, and KWin rules. No packages are installed from this module — it provides configuration only.

---

## Structure

```
desktop-kde/
├── plasma/
│   └── look-and-feel/
│       └── com.centrexos.desktop/
│           ├── metadata.json       Plasma look-and-feel package descriptor
│           └── contents/
│               └── defaults        Mapping of defaults → component configs
├── themes/
│   └── colors/
│       └── CentrexDark.colors      Full KDE colour scheme (Tokyo Night palette)
├── defaults/
│   ├── kdeglobals                  Global KDE settings (fonts, icons, widget style)
│   └── plasma-workspace.conf       Plasma shell, compositor, wallpaper
├── kwin/
│   └── scripts/
│       └── centrex-kwin-rules.js   KWin scripting rules
└── sddm/
    └── centrex-sddm/
        ├── Main.qml                SDDM login screen (QML)
        └── theme.conf              Theme configuration
```

---

## Colour Scheme

`CentrexDark.colors` is a full KDE colour scheme based on the Tokyo Night palette. It covers all KDE colour roles: Button, View, Window, Selection, Tooltip, Complementary, and Header.

Key colours:

| Role | Value |
|---|---|
| Window background | `#1a1b26` |
| View background | `#24283b` |
| Normal foreground | `#c0caf5` |
| Accent / focus | `#7aa2f7` |
| Error | `#f7768e` |
| Success | `#9ece6a` |

---

## SDDM Login Screen

`sddm/centrex-sddm/Main.qml` is a full QML login screen with:

- Dark background with wallpaper + overlay
- CentrexOS SVG logo
- Username and password fields with focus highlight
- "Sign In" button
- Reboot / Power Off buttons
- Focus auto-management: if username is blank, focuses username; otherwise focuses password

### Testing the SDDM theme

```sh
sudo sddm-greeter --test-mode --theme /path/to/desktop-kde/sddm/centrex-sddm
```

---

## Applying to a Live KDE Session

```sh
# kdeglobals
cp defaults/kdeglobals ~/.config/kdeglobals

# Colour scheme
mkdir -p ~/.local/share/color-schemes
cp themes/colors/CentrexDark.colors ~/.local/share/color-schemes/

# Look-and-feel package
mkdir -p ~/.local/share/plasma/look-and-feel
cp -r plasma/look-and-feel/com.centrexos.desktop ~/.local/share/plasma/look-and-feel/

# Apply with lookandfeeltool (requires KDE)
lookandfeeltool -a com.centrexos.desktop

# Reload Plasma shell
kquitapp5 plasmashell && kstart5 plasmashell &
```

---

## Installing the SDDM Theme (system-wide)

```sh
sudo cp -r sddm/centrex-sddm /usr/share/sddm/themes/
sudo sed -i 's/^Current=.*/Current=centrex-sddm/' /etc/sddm.conf
```
