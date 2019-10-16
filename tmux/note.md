# tmux  

https://github.com/tmux/tmux  

https://blog.csdn.net/xiaxuesong666/article/details/80579945  

Tmux 快捷键 & 速查表  

启动新会话：  
tmux [new -s 会话名 -n 窗口名]  

恢复会话：  
tmux at [-t 会话名]  

列出所有会话：  
tmux ls  

关闭会话：  
tmux kill-session -t 会话名  

关闭所有会话：  
tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0,  
length($1)-1)}' | xargs kill  

在 Tmux 中，按下 Tmux 前缀 ctrl+b，然后：  
会话  

:new<回车>  启动新会话  
s           列出所有会话  
$           重命名当前会话  

窗口 (标签页)  

c  创建新窗口  
w  列出所有窗口  
n  后一个窗口  
p  前一个窗口  
f  查找窗口  
,  重命名当前窗口  
&  关闭当前窗口  

调整窗口排序  

swap-window -s 3 -t 1  交换 3 号和 1 号窗口  
swap-window -t 1       交换当前和 1 号窗口  
move-window -t 1       移动当前窗口到 1 号  

窗格（分割窗口）  

%  垂直分割  
"  水平分割  
o  交换窗格  
x  关闭窗格  
⍽  左边这个符号代表空格键 - 切换布局  
q 显示每个窗格是第几个，当数字出现的时候按数字几就选中第几个窗格  
{ 与上一个窗格交换位置  
} 与下一个窗格交换位置  
z 切换窗格最大化/最小化  

滚轮  
ctrl + b + :  
set -g mouse on  
然后复制, 就得shift + 鼠标右键  
