// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract StringReverser {
    // 反转字符串函数：输入 "abcde" 返回 "edcba"
    function reverseString(string calldata input) public pure returns (string memory) {
        // 将字符串转换为字节数组（处理 ASCII 字符）
        bytes memory inputBytes = bytes(input);
        uint256 length = inputBytes.length;
        
        // 若字符串为空，直接返回
        if (length == 0) {
            return input;
        }
        
        // 创建结果字节数组（长度与输入相同）
        bytes memory reversedBytes = new bytes(length);
        
        // 反转逻辑：首尾字符交换
        for (uint256 i = 0; i < length; i++) {
            // 第 i 位字符 = 输入的第 (length - 1 - i) 位字符
            reversedBytes[i] = inputBytes[length - 1 - i];
        }
        
        // 将字节数组转回字符串
        return string(reversedBytes);
    }
}
