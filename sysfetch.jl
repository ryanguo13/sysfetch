try
    using Crayons
catch e
    println("Crayons package not found. Installing Crayons...")
    import Pkg
    Pkg.add("Crayons")
    using Crayons
end


# 定义颜色和样式
header = Crayon(foreground = :cyan, bold = true)
info = Crayon(foreground = :green)
cpu_info_header = Crayon(foreground = :magenta, bold = true)
uptime_header = Crayon(foreground = :yellow, bold = true)
os_header = Crayon(foreground = :blue, bold = true)
arch_header = Crayon(foreground = :red, bold = true)
memory_header = Crayon(foreground = :white, bold = true)


# 收集信息
info_text = """

$(os_header("Operating System:")) $(Sys.KERNEL)
$(arch_header("Architecture:")) $(Sys.ARCH)
$(cpu_info_header("CPU Information:"))
$(info("Model:")) $(Sys.cpu_info()[1].model)
$(header("Threads:")) $(Sys.CPU_THREADS)
$(memory_header("Memory Information:")) Total Memory: $(round(Sys.total_memory() / (1024^3), digits=2)) GB
$(uptime_header("$(read(`uptime`, String))"))
Julia Version: $(VERSION)
"""

# 创建框的上下边界和侧边
function add_emoji_box(text::String)
    lines = split(text, '\n')
    max_len = maximum(length.(lines))   # 找到最长的一行

    top_border = repeat("✧", max_len)  # emoji 符号的上边界，长度与最长行一致
    bottom_border = repeat("✧", max_len)  # emoji 符号的下边界
    
    boxed_lines = [top_border]
    for line in lines
        push!(boxed_lines, rpad(line, max_len))  # 直接输出内容，并填充至最大长度
    end
    push!(boxed_lines, bottom_border)
    
    return join(boxed_lines, "\n")
end


# 输出带 emoji 的系统信息框
# println(header("--------- System Information --------"))
println(add_emoji_box(info_text))
