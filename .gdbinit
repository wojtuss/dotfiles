set history save on
set history filename ~/.gdb_history
set history size 9999
set print pretty
set history remove-duplicates unlimited
catch throw

alias ct = catch throw
alias ib = info breakpoints


source /home/wojtuss/.vim/bundle/minimal_gdb/dbg_data/min_settings.gdb
