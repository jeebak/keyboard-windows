# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

AutoHotkey scripts that reimplement the author's macOS
[Karabiner-Elements](https://ke-complex-modifications.pqrs.org/?rule=json%2Fpersonal_jeebak.json)
key mappings on Windows: CapsLock→Control/Escape, a TouchCursor-style chord
layer, window snapping, a Quake-style terminal toggle, and misc mouse/window
utilities. See `README.md` for the mapping rationale and links. The entry
point `ahk/init.ahk` is now AHK v2 (`ahk/v2/`); the original AHK v1.1 script
is kept as `ahk/init-v1.ahk` (`ahk/v1/`) — see Architecture below.

## Commands

There is no build, lint, or test tooling — this is plain interpreted AHK
source with no package manager.

- **Run/reload**: AutoHotkey v2 must be installed on the target Windows
  machine. `ahk/init.ahk` is the entry point — either double-click it to run,
  or shortcut it into the Startup folder (see the comment at the top of the
  file) so it loads on login. To run the v1.1 version instead, install
  AutoHotkey v1.1 and run `ahk/init-v1.ahk`; don't run both at once, since
  they define the same hotkeys.
- **Reload after editing**: the running script defines its own reload hotkey,
  `Ctrl+Win+Alt+R` (`^#!r::Reload`, in `ahk/init.ahk`). There's no separate
  "check syntax" step — reloading and exercising the changed hotkey by hand
  is the verification loop.
- **Lock + sleep**: `Ctrl+Shift+Win+Tab` locks the workstation and suspends
  the machine (also in `ahk/init.ahk`).

## Architecture

- **`ahk/init.ahk`** is the entry point (`#Requires AutoHotkey v2.0`; stays at
  `ahk/`, one level up from the version-specific trees below, so the Startup
  shortcut's target path doesn't change between versions). It does the
  script-wide setup (`#SingleInstance Force`, `InstallKeybdHook()`, tray
  icon), then `#Include`s every feature module from `ahk/v2/include/`, then
  defines the two global hotkeys above. To add a new feature module, create
  it under `ahk/v2/include/` and add an `#Include` line here — order matters
  only if two modules would otherwise redefine the same hotkey.
- **`ahk/init-v1.ahk`** is the same entry point for AHK v1.1: identical
  setup and global hotkeys, but it `#Include`s `ahk/v1/include/` (including
  `DockWin.ahk`, which has no v2 port).
- **`ahk/v1/include/*.ahk`** and **`ahk/v2/include/*.ahk`** — one file per
  feature domain in each tree, each independently runnable/readable in
  isolation (no cross-includes between them). Domains, as named in v1:
  `TouchCursor.ahk` (Space-chord layer for arrows/media/app shortcuts),
  `AdvancedWindowSnap.ahk` (9-grid + thirds/fourths window snapping),
  `QuakeTerminal.ahk` (Alt+/ show/hide/spawn Windows Terminal),
  `DockWin.ahk` (save/restore window layouts to `%APPDATA%\DockWinData\`,
  keyed by `Win+Shift+<0-9>` / `Win+Ctrl+<0-9>`),
  `CapsLockTapEscapeHoldControl.ahk`, `Spotlight.ahk`, `Screenshots.ahk`,
  `AlwaysOnTop.ahk`, `TabModifier.ahk`, `Media.ahk`, `Misc.ahk`
  (middle-click paste, chorded left+right mouse → middle-click), plus
  `mouser6.ahk`.
- **`DockWin.ahk` and `mouser6.ahk` are deliberately excluded from the v2
  port**, so they exist only under `ahk/v1/include/`; only `init-v1.ahk`
  loads `DockWin.ahk`.
- **`HomeRowModifiers.ahk` and `NumberRowModifiers.ahk` exist only under
  `ahk/v2/include/`** (no v1 counterpart), each a port of the Karabiner rule
  of the same name: `;` and `'` tap for themselves and hold for Ctrl / Alt;
  the number row types its digit and holds as Ctrl (4-9) or Alt (1-3, 0, -, =).
- **Per-app conditional dispatch** is the main idiom worth knowing before
  adding a hotkey: many handlers branch on the foreground window via
  `WinActive("ahk_exe X.exe")` / `ahk_class` (see the `Space & d/c/v/,`
  handlers in `TouchCursor.ahk`) to send different key sequences to
  Windows Terminal, VSCodium, ConEmu, mintty, and Notepad. New per-app
  behavior should extend these `If/Else If` chains rather than adding a
  separate global hotkey.
- **Hardcoded per-monitor "fudge factor" offsets**: `AdvancedWindowSnap.ahk`'s
  `SnapActiveWindow()` and `QuakeTerminal.ahk`'s `PositionTerminal()` both add
  small pixel corrections (`fudge`/`Fudge`) to compensate for window-border
  sizing quirks that vary per app and per monitor DPI. These are tuned to the
  author's current hardware — see recent commit history ("Add fudge factor
  for chrome.exe", "Update fudge logic") before assuming a snapping bug is
  logic rather than a fudge-value miscalibration.
- **`ahk/v1/` is AHK v1.1 syntax throughout** — comma-style commands
  (`Send, {F1}`, `WinGet activeWin, ID, A`), `#IfWinActive` context
  directives, and `DllCall`/`NumGet` for raw Win32 monitor APIs
  (`GetMonitorIndexFromWindow` in `AdvancedWindowSnap.ahk`). Don't introduce
  v2 syntax there — it won't run under v1.1. `ahk/v2/` (what `init.ahk`
  loads) is the opposite: v2 syntax only (function calls, `:=`-everywhere
  expressions, `#HotIf` instead of `#IfWinActive`) — don't backport v1
  command syntax into it.
- **Line endings**: `.gitattributes` forces `eol=crlf` for all text files
  (this is a Windows-only config repo) — don't fight it by committing LF.
- `ahk/WinPos*.txt` is gitignored (`.gitignore`) — runtime state, not source.
