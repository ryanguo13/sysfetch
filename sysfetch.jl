#!/usr/bin/env julia

function get_system_info()
    # 获取基本系统信息
    os_name = Sys.KERNEL
    os_release = Sys.ARCH
    julia_version = VERSION
    cpu_threads = Base.Sys.CPU_THREADS
    mem_total = Base.Sys.total_memory() / (1024^3)  # 将内存转换为GB
    hostname = gethostname()
    
    # 打印系统信息
    println("System Information:")
    println("===================")
    println("Operating System   : $os_name $os_release")
    println("Julia Version      : $julia_version")
    println("CPU Threads        : $cpu_threads")
    println("Total Memory (GB)  : $(round(mem_total, digits=2))")
    println("Hostname           : $hostname")
end

function get_uptime()
    # 获取系统运行时间（此部分根据平台可能有所不同，Linux下可以从/proc/uptime读取）
    try
        uptime_seconds = Sys.uptime()
        uptime_hours = uptime_seconds / 3600
        println("Uptime             : $(round(uptime_hours, digits=2)) hours")
    catch e
        println("Unable to retrieve uptime on this system.")
    end
end

function main()
    get_system_info()
    get_uptime()
end

main()

