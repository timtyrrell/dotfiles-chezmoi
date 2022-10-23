#!/usr/bin/env bash

set -g mode-style "fg=#7aa2f7,bg=#3b4261"

set -g message-style "fg=#7aa2f7,bg=#3b4261"
set -g message-command-style "fg=#7aa2f7,bg=#3b4261"

set -g pane-border-style "fg=#3b4261"
set -g pane-active-border-style "fg=#7aa2f7"

# set inactive/active window styles
# set -g window-style 'bg=#16161e'
set -g window-active-style 'bg=#1a1b26'

set -g pane-border-lines heavy
set -g pane-border-indicators both

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#7aa2f7,bg=#16161e"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#16161e"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#a9b1d6,bg=#16161e"
setw -g window-status-format "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#16161e,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]"

set -g status-left "#[fg=#15161e,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#16161e,nobold,nounderscore,noitalics]"

# set -g status-right ''
set -g status-right "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#16161e] #{prefix_highlight} #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#15161e,bg=#7aa2f7,bold] #h "

# set -g status-right '#{?#{music_status},♫ #{music_status} #{artist}: #{track} |,""} #(gitmux "#{pane_current_path}") | #{docker_status} | #{kcontext}#{kpod} #{pomodoro_status}'
# set -g status-right '♫ #{music_status} #{artist}: #{track} | #(gitmux "#{pane_current_path}") | #{docker_status} | #{kcontext}#{kpod} #{pomodoro_status}'
# tm_tunes="#{?#{tm_tunes_present},#{track} #{artist},}"
# set -g status-right $tm_tunes

# tm_tunes="#{?#{tm_tunes_present},♫ #{artist}: #{track} |,}"
# tm_tunes="#{?#{tm_tunes_present},♫ #{track} #{artist},}"
# set -g status-right $tm_tunes
# spotify_playing="#{track}"
# spotify_track="♫ #{music_status} #{artist}: #{track} |"
# set -g status-right '#{?#{spotify_playing},♫ #{music_status} #{artist}: #{track} |,""} #{docker_status} | #{kcontext}#{kpod} #{pomodoro_status}'
# set -g status-right '#{?#{spotify_playing},#{spotify_track},} #{docker_status} | #{kcontext}#{kpod} #{pomodoro_status}'
# set -g status-right '♫ #{music_status} #{artist}: #{track} | #{docker_status} | #{kcontext}#{kpod} #{pomodoro_status}'
# set -g status-right '#{docker_status} | #{kcontext}#{kpod} #{pomodoro_status}'
# #{?COND,A,B}
# set -g status-right '#{?#{track},♫ #{music_status} #{artist}: #{track} |, hi}'
