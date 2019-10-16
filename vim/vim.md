1. echo "set tabstop=4" >> /etc/vimrc  
set tabstop=4          //tab键为4个空格
set softtabstop=4   //按退格键一次能删除4个空格
set shiftwidth=4      //当行之间交错使用4个空格
set autoindent        //自动对齐
set cindent             //定制C语言风格的缩进
set number            //显示行号
set showmatch      //设置为匹配模式
set mouse=a         //使用鼠标，用滚轮时，文本可以上下移动

2. vim 插件  
https://github.com/VundleVim/Vundle.vim
https://github.com/plasticboy/vim-markdown
看这个目录下的vimrc文件

3. set nopaste   set paste  
4. set hlsearch 高亮搜索  

5. Indent Fold

使用以下命令，启用缩进折叠。所有文本将按照（选项shiftwidth 定义的）缩进层次自动折叠。

:set foldmethod=indent

使用zm命令，可以手动折叠缩进；而利用zr命令，则可以打开折叠的缩进。

使用以下命令，将可以根据指定的级别折叠缩进：

:set foldlevel=1

可以使用以下命令，查看关于缩进折叠的帮助信息：

:help fold-indent
