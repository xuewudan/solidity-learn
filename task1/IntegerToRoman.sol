// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract IntegerToRoman {
    function intToRoman(uint256 num) public pure returns (string memory) {

        require(num >= 1 && num <= 3999, "Number must be between 1 and 3999");

        // 整数数组：显式声明 uint256 类型，避免类型不匹配
        uint16[13] memory values = [
            1000,
            900,
            500,
            400,
            100,
            90,
            50,
            40,
            10,
            9,
            5,
            4,
            1
        ];

        // 字符串数组：声明为固定长度 string[13]，与初始化元素数量匹配
        string[13] memory symbols = [
            "M",
            "CM",
            "D",
            "CD",
            "C",
            "XC",
            "L",
            "XL",
            "X",
            "IX",
            "V",
            "IV",
            "I"
        ];

        bytes memory result = new bytes(0);
        // 循环遍历（values 和 symbols 长度均为 13，可安全遍历）
        for (uint256 i = 0; i < values.length; i++) {
            while (num >= values[i]) {
                result = abi.encodePacked(result, symbols[i]);
                num -= values[i];
            }
            if (num == 0) break;
        }
        return string(result);
    }
}
