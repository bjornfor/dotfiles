# .gdbinit

set prompt [31m(gdb) [m

# log gdb output (defaults to gdb.txt in current directory)
#set logging on

set history save
set history filename ~/.gdb_history
set history size 10000

define bta
thread apply all backtrace
end
document bta
Alias for 'thread apply all backtrace'
end

define btaf
thread apply all backtrace full
end
document btaf
Alias for 'thread apply all backtrace full'
end

define lon
set scheduler-locking on
end
document lon
Alias for 'set scheduler-locking on'
end

define loff
set scheduler-locking off
end
document loff
Alias for 'set scheduler-locking off'
end
