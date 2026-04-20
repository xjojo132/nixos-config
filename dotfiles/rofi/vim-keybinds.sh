#!/usr/bin/env bash

# vim-keybinds.sh — searchable vim cheatsheet via rofi
# Place this at ~/.config/rofi/vim-keybinds.sh

THEME="$HOME/.config/rofi/vim-keybinds.rasi"

entries=(
# ── MODES ─────────────────────────────────────────────────────────────
"                    ── MODES ──"
"  i                 insert before cursor"
"  a                 insert after cursor"
"  I                 insert at line start"
"  A                 insert at line end"
"  o                 new line below, enter insert"
"  O                 new line above, enter insert"
"  v                 visual (char) mode"
"  V                 visual (line) mode"
"  Ctrl+v            visual block mode"
"  Esc               return to normal mode"
"  Ctrl+[            same as Esc"
# ── MOVEMENT ──────────────────────────────────────────────────────────
"                    ── MOVEMENT ──"
"  h j k l           left / down / up / right"
"  w                 next word start"
"  b                 prev word start"
"  e                 word end"
"  W B E             same but WORD (ignores punctuation)"
"  0                 line start"
"  ^                 first non-space on line"
"  \$                 line end"
"  gg                top of file"
"  G                 bottom of file"
"  :42               go to line 42"
"  Ctrl+d            half page down"
"  Ctrl+u            half page up"
"  %                 jump to matching bracket"
"  H M L             screen top / middle / bottom"
"  zz                center screen on cursor"
"  zt / zb           scroll cursor to top / bottom"
# ── FIND ON LINE ──────────────────────────────────────────────────────
"                    ── FIND ON LINE ──"
"  fx                jump to next 'x' on line"
"  Fx                jump to prev 'x' on line"
"  tx                jump before next 'x'"
"  Tx                jump before prev 'x'"
"  ; / ,             repeat last f/t forward / backward"
# ── EDITING ───────────────────────────────────────────────────────────
"                    ── EDITING ──"
"  x                 delete char under cursor"
"  X                 delete char before cursor"
"  dd                delete whole line"
"  dw                delete word"
"  d\$                delete to line end"
"  D                 delete to line end (shorthand)"
"  cc                change whole line"
"  cw                change word"
"  C                 change to line end"
"  s                 delete char, enter insert"
"  S                 delete line, enter insert"
"  r                 replace single char"
"  ~                 toggle case"
"  >>                indent right"
"  <<                indent left"
"  ==                auto-indent line"
"  J                 join line below"
# ── COPY & PASTE ──────────────────────────────────────────────────────
"                    ── COPY & PASTE ──"
"  yy                yank (copy) line"
"  yw                yank word"
"  y\$                yank to line end"
"  p                 paste after cursor"
"  P                 paste before cursor"
"  yyp               duplicate line"
# ── TEXT OBJECTS ──────────────────────────────────────────────────────
"                    ── TEXT OBJECTS ──"
"  diw               delete inner word"
"  daw               delete word + surrounding space"
"  ci\"               change inside double quotes"
"  di(               delete inside parentheses"
"  da(               delete parens + content"
"  ci{               change inside curly braces"
"  di[               delete inside square brackets"
"  vip               select inner paragraph"
"  vit               select inner HTML tag"
# ── SEARCH ────────────────────────────────────────────────────────────
"                    ── SEARCH ──"
"  /word Enter       search forward"
"  ?word Enter       search backward"
"  n / N             next / prev match"
"  *                 search word under cursor ↓"
"  #                 search word under cursor ↑"
"  :noh              clear search highlights"
"  :%s/old/new/g     replace all in file"
"  :%s/old/new/gc    replace all, confirm each"
"  :s/old/new/g      replace all on current line"
# ── UNDO / REDO ───────────────────────────────────────────────────────
"                    ── UNDO & REDO ──"
"  u                 undo"
"  Ctrl+r            redo"
"  .                 repeat last change"
# ── LSP / ZED ─────────────────────────────────────────────────────────
"                    ── LSP (ZED VIM MODE) ──"
"  gd                go to definition"
"  gD                go to declaration"
"  gr                go to references"
"  gI                go to implementation"
"  gh                hover docs"
"  Ctrl+o            jump back"
# ── WINDOWS ───────────────────────────────────────────────────────────
"                    ── WINDOWS & FILES ──"
"  Ctrl+w h/j/k/l    move between splits"
"  Ctrl+w v          vertical split"
"  Ctrl+w s          horizontal split"
"  :w                save"
"  :q                close"
"  :wq               save and close"
"  :q!               close without saving"
)

printf '%s\n' "${entries[@]}" | rofi \
    -dmenu \
    -p " vim" \
    -theme "$THEME" \
    -no-custom \
    -i \
    -no-fixed-num-lines \
    -selected-row 0
