// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RomanToInteger {
    // 罗马数字转整数
    function romanToInt(string calldata s) public pure returns (uint256) {
        uint256 length = bytes(s).length;
        require(length > 0, "Empty string is not a valid Roman numeral");

        uint256 result = 0;

        // 遍历罗马数字的每个字符
        for (uint256 i = 0; i < length; i++) {
            // 获取当前字符和下一个字符的值
            uint256 current = getValue(bytes(s)[i]);
            uint256 next = (i < length - 1) ? getValue(bytes(s)[i + 1]) : 0;

            // 核心逻辑：当前值 < 下一个值 → 减去当前值；否则 → 加上当前值
            if (current < next) {
                result -= current;
            } else {
                result += current;
            }
        }

        // 验证结果是否在有效范围（1-3999）
        require(result >= 1 && result <= 3999, "Invalid Roman numeral");
        return result;
    }

    // 辅助函数：将罗马数字字符转换为对应的值
    function getValue(bytes1 char) private pure returns (uint256) {
        if (char == 'I') return 1;
        if (char == 'V') return 5;
        if (char == 'X') return 10;
        if (char == 'L') return 50;
        if (char == 'C') return 100;
        if (char == 'D') return 500;
        if (char == 'M') return 1000;
        // 非法字符直接 revert
        revert("Invalid Roman numeral character");
    }
}