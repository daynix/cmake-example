
set(_MESSAGES_CMAKE_INCLUDED YES)

# printing in colors
string(ASCII 27 Esc)
set(Reset   "${Esc}[m"  )
set(Red     "${Esc}[31m")
set(Blue    "${Esc}[34m")
set(Green   "${Esc}[32m")
set(Yellow  "${Esc}[33m")

function(msg_colored msg_str color)
    message("${color}${msg_str}${Reset}")
endfunction()

macro(msg_red msg_str)
    msg_colored("${msg_str}" ${Red})
endmacro()

macro(msg_blue msg_str)
    msg_colored("${msg_str}" ${Blue})
endmacro()

macro(msg_green msg_str)
    msg_colored("${msg_str}" ${Green})
endmacro()

macro(msg_yellow msg_str)
    msg_colored("${msg_str}" ${Yellow})
endmacro()
