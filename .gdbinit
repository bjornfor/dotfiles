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

# Linux debugging tip from
#   http://elinux.org/Debugging_The_Linux_Kernel_Using_Gdb
# Usage: dmesg __log_buf log_start log_end
define dmesg
        set $__log_buf = $arg0
        set $log_start = $arg1
        set $log_end = $arg2
        set $x = $log_start
        echo "
        while ($x < $log_end)
                set $c = (char)(($__log_buf)[$x++])
                printf "%c" , $c
        end
        echo "\n
end
document dmesg
dmesg __log_buf log_start log_end
Print the content of the kernel message buffer
end
