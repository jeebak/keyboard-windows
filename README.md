# Keyboard Configs For Windows

An attempt to match my [personal mappings](https://ke-complex-modifications.pqrs.org/?rule=json%2Fpersonal_jeebak.json) for [Karabiner-Elements](https://pqrs.org/osx/karabiner/) under macOS, for Windows.

Instead of using:

- [SharpKeys](https://chocolatey.org/packages/sharpkeys/) to remap CapsLock to control
- [TouchCursor](https://martin-stone.github.io/touchcursor/) for its awesomeness
- [AutoHotkey](https://community.chocolatey.org/packages/autohotkey) for misc. remappings

... use AutoHotkey for all of the above.

Requires AutoHotkey v2: run `ahk/init.ahk`. The original AutoHotkey v1.1 script is kept as `ahk/init-v1.ahk`.

Other stuff:

- Old (pre-Sierra **only**) [Karabiner](https://github.com/jeebak/dotfiles/tree/6e62207dcaff536edd2913832e5fb6fa3a076986/karabiner) customizations
- For Linux: [touchcursor-x11](https://github.com/jeebak/touchcursor-x11) (ported to [keyd](https://github.com/rvaiya/keyd))
- [Example Layout](https://www.keyboard-layout-editor.com/#/gists/55f3e3c9149d23cbae5f8ac559627d0f)

## Common shortcuts: Windows vs. Mac

Windows uses `Ctrl` for what macOS does with `Cmd` inside apps, and the `Win` key for OS-level actions, so the two don't map 1:1.

### Windows: Win key

| Combo | Action |
|---|---|
| `Win+D` / `Win+M` | Show desktop / minimize all |
| `Win+E` / `Win+R` | Explorer / Run |
| `Win+L` | Lock |
| `Win+Tab` | Task View |
| `Win+←/→/↑/↓` | Snap / maximize / restore |
| `Win+Shift+←/→` | Move window to another monitor |
| `Win+Ctrl+←/→`, `Win+Ctrl+D` | Switch / create virtual desktop |
| `Win+1…9` | Launch or focus taskbar app |
| `Win+Shift+S` | Screenshot / snip |
| `Win+V` | Clipboard history |
| `Win+.` | Emoji picker |
| `Win+I` / `Win+X` | Settings / power-user menu |
| `Win+A` / `Win+N` | Quick settings / notifications |
| `Win+H` | Voice typing |
| `Win+Space` | Switch input language |

### Windows: Alt key

| Combo | Action |
|---|---|
| `Alt+Tab` / `Alt+Shift+Tab` | Switch windows (forward / back) |
| `Alt+F4` | Close window |
| `Alt+Space` | Window menu |
| `Alt+Enter` | Properties |
| `Alt+←/→` | Back / forward in Explorer and browsers |
| `Alt+D` | Focus address bar |
| `Alt+Esc` | Cycle windows without a switcher |

### Mac: Cmd key

| Combo | Action |
|---|---|
| `Cmd+C/V/X/Z/A/S/F` | Copy / paste / cut / undo / select all / save / find (`Ctrl` on Windows) |
| `Cmd+T/N/W/Q` | New tab / new window / close window / quit app |
| `Cmd+Tab` | Switch apps |
| ``Cmd+` `` | Next window of the same app |
| `Cmd+Space` | Spotlight |
| `Cmd+H` / `Cmd+M` | Hide app / minimize |
| `Cmd+,` | Preferences |
| `Cmd+Shift+3/4/5` | Screenshots |
| `Cmd+Shift+.` | Show hidden files |
| `Cmd+Shift+G` | Go to folder |
| `Cmd+[` / `Cmd+]` | Back / forward |
| `Cmd+←/→` | Line start / end (`Home` / `End` on Windows) |
| `Cmd+↑/↓` | Document start / end (`Ctrl+Home` / `Ctrl+End` on Windows) |
| `Cmd+Delete` | Move to Trash |
| `Cmd+Ctrl+Q` | Lock |
| `Cmd+Ctrl+Space` | Emoji |
| `Cmd+Ctrl+F` | Full screen |

### Mac: Option key

| Combo | Action |
|---|---|
| `Option+←/→` | Jump by word (`Ctrl+←/→` on Windows) |
| `Option+Delete` | Delete previous word (`Ctrl+Backspace` on Windows) |
| `Option+letter/number` | Special characters (`Option+8` gives •, `Option+G` gives ©) |
| `Option+Cmd+Esc` | Force Quit |
| `Option+Cmd+H` | Hide all other apps |
| `Option+Cmd+M` | Minimize all windows of the app |
| `Option+Cmd+D` | Toggle Dock auto-hide |

Windows has no built-in equivalent of ``Cmd+` `` (cycle windows within one app); `Alt+Esc` is the closest.
