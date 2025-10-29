// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BinarySearch {
    // 在非递减有序数组中查找目标值，返回索引（不存在返回 type(uint256).max 表示 -1）
    function search(uint256[] calldata arr, uint256 target) public pure returns (uint256) {
        uint256 left = 0;
        uint256 right = arr.length - 1;

        // 处理空数组
        if (arr.length == 0) {
            return type(uint256).max; // 表示 -1（未找到）
        }

        // 二分查找核心逻辑
        while (left <= right) {
            // 计算中间索引（避免 left + right 溢出）
            uint256 mid = left + (right - left) / 2;

            if (arr[mid] == target) {
                return mid; // 找到目标，返回索引
            } else if (arr[mid] < target) {
                // 目标在右半部分，移动左指针
                left = mid + 1;
            } else {
                // 目标在左半部分，移动右指针
                // 处理 right 为 0 时的下溢（此时 right - 1 会溢出，直接置为 max 退出循环）
                if (mid == 0) {
                    break;
                }
                right = mid - 1;
            }
        }

        // 循环结束仍未找到，返回 -1（用 max 表示）
        return type(uint256).max;
    }
}