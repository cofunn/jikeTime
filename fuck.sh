#!/bin/bash

# 递归遍历当前目录及其子目录中的所有文件和目录
find . -depth -type f -o -type d | while IFS= read -r file; do
    # 检查文件名是否包含目标字符
    if [[ "$file" == *[\\\/\\\|]* ]]; then
        # 分离路径和文件名
        dir=$(dirname "$file")
        base=$(basename "$file")
        # 删除文件名中的空格
        newbase=$(echo "$base" | tr -d ' ')
        # 构造新的文件名
        newname="$dir/$newbase"
        # 避免空文件名或重复重命名
        if [[ "$file" != "$newname" ]]; then
            # 安全重命名（保留原路径结构）
            mv -- "$file" "$newname"
            echo "Renamed: $file → $newname"
        fi
    fi
done