// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ABI {
    // 编码
    function encodeData(string memory text, uint256 number)
        public
        pure
        returns (bytes memory, bytes memory)
    {
        // 0x00000000000000000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000012000000000000000000000000000000000000000000000000000000000000000678756574616f0000000000000000000000000000000000000000000000000000
        // 下面是压缩过的，压缩过的是没办法解码的，需要后面补充0，跟上面相同长度后，才能解码，否则报错；
        // 0x78756574616f0000000000000000000000000000000000000000000000000000000000000012
        return (abi.encode(text, number), abi.encodePacked(text, number));
    }

    //  解码
    function decodeData(bytes memory data)
        public
        pure
        returns (string memory, uint256)
    {
        return abi.decode(data, (string, uint256));
    }
}
