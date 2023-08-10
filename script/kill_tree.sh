#!/bin/bash

terminate_process_tree() {
    local parent_pid=$1
    local children=$(pgrep -P $parent_pid)  # 获取所有子进程的 PID

    for child_pid in $children; do
        terminate_process_tree $child_pid  # 递归终止子进程的子进程
    done

    sudo kill $parent_pid  # 终止当前父进程
}

if [ $# -eq 1 ]; then
    target_pid=$1
    terminate_process_tree $target_pid
else
    echo "Usage: $0 <pid>"
fi