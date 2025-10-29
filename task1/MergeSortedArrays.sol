// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeSortedArrays {
    // 合并两个非递减有序数组，返回新的非递减有序数组
    function merge(uint256[] calldata arr1,uint256[] calldata arr2) public pure returns (uint256[] memory result) {
        uint256 len1 = arr1.length;
        uint256 len2 = arr2.length;
        uint256 totalLen = len1 + len2;

        // 初始化结果数组，长度为两个数组长度之和
        result = new uint256[](totalLen);

        // 三指针法：i 指向 arr1 当前元素，j 指向 arr2 当前元素，k 指向 result 待插入位置
        uint256 i = 0;
        uint256 j = 0;
        uint256 k = 0;

        // 遍历两个数组，按顺序取较小元素放入结果数组
        while (i < len1 && j < len2) {
            if (arr1[i] <= arr2[j]) {
                result[k] = arr1[i];
                i++; // 移动 arr1 指针
            } else {
                result[k] = arr2[j];
                j++; // 移动 arr2 指针
            }
            k++; // 移动结果数组指针
        }

        // 处理剩余元素（若 arr1 有剩余）
        while (i < len1) {
            result[k] = arr1[i];
            i++;
            k++;
        }

        // 处理剩余元素（若 arr2 有剩余）
        while (j < len2) {
            result[k] = arr2[j];
            j++;
            k++;
        }
    }
}