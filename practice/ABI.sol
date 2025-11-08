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

    // 获取当前函数签名
    function getSig() public pure returns (bytes4) {
        return msg.sig;
    }

    //  计算函数选择器
    function compputeSelector(string memory func) public view returns (bytes4) {
        return bytes4(keccak256(bytes(func)));
    }

    // 0xa9059cbb000000000000000000000000c3ba5050ec45990f76474163c5ba673c244aaeca0000000000000000000000000000000000000000000000000000000000000064
    function transfer(address addr, uint256 amount)
        public
        pure
        returns (bytes memory)
    {
        return msg.data;
    }

    // 0xa9059cbb000000000000000000000000c3ba5050ec45990f76474163c5ba673c244aaeca0000000000000000000000000000000000000000000000000000000000000064
    function encodeFunctionCall() public pure returns (bytes memory) {
        return
            abi.encodeWithSignature(
                "transfer(address,uint256)",
                0xC3Ba5050Ec45990f76474163c5bA673c244aaECA,
                100
            );
    }

    // hash函数运算
    // 0x24016fcc42c8231f9320529ea87956f9b3879744e4b238417818432d5738b606
    // 0x24016fcc42c8231f9320529ea87956f9b3879744e4b238417818432d5738b606
    // 0x24016fcc42c8231f9320529ea87956f9b3879744e4b238417818432d5738b606
    function hashFunc(string memory input)
        public
        pure
        returns (
            bytes32,
            bytes32,
            bytes32
        )
    {
        return (
            keccak256(abi.encodePacked(input)),
            sha256(abi.encodePacked(input)),
            ripemd160(abi.encodePacked(input))
        );
    }

    // 数学运算
    function mathFunc(
        uint256 x,
        uint256 y,
        uint256 m
    ) public pure returns (uint256, uint256) {
        return (addmod(x, y, m), mulmod(x, y, m));
    }

    // 8.椭圆函数恢复公钥(ecrecover)
    function recoverAddress(
        bytes32 hash,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public pure returns (address) {
        return ecrecover(hash, v, r, s);
    }
}
