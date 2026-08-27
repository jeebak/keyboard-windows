# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

AutoHotkey (v1.1, not v2) scripts that reimplement the author's macOS
[Karabiner-Elements](https://ke-complex-modifications.pqrs.org/?q=jeebak)
key mappings on Windows: CapsLock→Control/Escape, a TouchCursor-style chord
layer, window snapping, a Quake-style terminal toggle, and misc mouse/window
utilities. See `README.md` for the mapping rationale and links.

## Commands

There is no build, lint, or test tooling — this is plain interpreted AHK v1.1
source with no package manager.

- **Run/reload**: AutoHotkey v1.1 must be installed on the target Windows
  machine. `ahk/init.ahk` is the entry point — either double-click it to run,
  or shortcut it into the Startup folder (see the comment at the top of the
  file) so it loads on login.
- **Reload after editing**: the running script defines its own reload hotkey,
  `Ctrl+Win+Alt+R` (`^#!r::Reload`, in `ahk/init.ahk`). There's no separate
  "check syntax" step — reloading and exercising the changed hotkey by hand
  is the verification loop.
- **Lock + sleep**: `Ctrl+Shift+Win+Tab` locks the workstation and suspends
  the machine (also in `ahk/init.ahk`).

## Architecture

- **`ahk/init.ahk`** is the single entry point. It sets AHK-wide options
  (`#SingleInstance Force`, `#installKeybdHook`, `#Persistent`), then
  `#Include`s every feature module from `ahk/include/`, then defines the two
  global hotkeys above. To add a new feature module, create it under
  `ahk/include/` and add an `#Include` line here — order matters only if two
  modules would otherwise redefine the same hotkey.
- **`ahk/include/*.ahk`** — one file per feature domain, each independently
  runnable/readable in isolation (no cross-includes between them):
  `TouchCursor.ahk` (Space-chord layer for arrows/media/app shortcuts),
  `AdvancedWindowSnap.ahk` (9-grid + thirds/fourths window snapping),
  `QuakeTerminal.ahk` (Alt+/ show/hide/spawn Windows Terminal),
  `DockWin.ahk` (save/restore window layouts to `%APPDATA%\DockWinData\`,
  keyed by `Win+Shift+<0-9>` / `Win+Ctrl+<0-9>`),
  `CapsLockTapEscapeHoldControl.ahk`, `Spotlight.ahk`, `Screenshots.ahk`,
  `AlwaysOnTop.ahk`, `TabModifier.ahk`, `Media.ahk`, `Misc.ahk`
  (middle-click paste, chorded left+right mouse → middle-click), plus
  `mouser6.ahk`.
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
- **AHK v1.1 syntax throughout** — comma-style commands (`Send, {F1}`,
  `WinGet activeWin, ID, A`), `#IfWinActive` context directives, and
  `DllCall`/`NumGet` for raw Win32 monitor APIs (`GetMonitorIndexFromWindow`
  in `AdvancedWindowSnap.ahk`). Don't introduce v2 syntax (`:=` expressions
  as statements, fat-arrow functions, etc.) — it won't run under v1.1.
- **Line endings**: `.gitattributes` forces `eol=crlf` for all text files
  (this is a Windows-only config repo) — don't fight it by committing LF.
- `ahk/WinPos*.txt` is gitignored (`.gitignore`) — runtime state, not source.
