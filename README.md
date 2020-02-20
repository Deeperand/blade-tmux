# README
## Original Project
https://github.com/gpakosz/.tmux.git

## Design Philosophy
为了具有更良好的兼容性, 在 `~/.tmux.config` 文件中仅仅使用了 `source` 语句来调用 `Blade-Tmux` 中的 `.tmux.config` 文件. 相较与使用链接更稳定. (部分文本编辑器在保存时实际上可能会使硬链接失效, 猜测可能是由于保存时不是直接写入文件, 而是将文件删除后新建了一个, 所以硬链接才会失效)

与之对应, 由于 `~/.tmux.config` 相较于 `$BLADE_TMUX_CONFIG_FILE_DIR/.tmux.config` 更简洁, 故而在需要 source 配置文件时, 均 source `~/.tmux.config` 来实现对 `$BLADE_TMUX_CONFIG_FILE_DIR/.tmux.config` 的间接调用

## Required
- enviroment variable `$BLADE_TMUX_CONFIG_FILE_DIR` should be the direction of this `README.md` file exist
- add this statment in `~/.tmux.config` at the first line:
    ```tmux
    source ~/Documents/my_config/Blade-Tmux/.tmux.conf
    ```
