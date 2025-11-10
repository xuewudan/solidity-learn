// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AddressExample {
    // 声明一个地址变量
    address public myAddress;

    // 获取当前调用者的地址
    address public caller = msg.sender;

    // 地址类型之间的比较
    function compareAddress(address addr1, address addr2)
        public
        pure
        returns (bool)
    {
        return addr1 == addr2;
    }

    // 地址类型的转换
    function toBytes(address addr) public pure returns (bytes memory) {
        return abi.encodePacked(addr);
    }

    // 获取地址的余额
    function getBalance(address addr) public view returns (uint256) {
        return addr.balance;
    }

    // 向地址转账
    function sendEther(address recipient) public payable {
        // recipient.transfer(msg.value);
        payable(recipient).transfer(msg.value);
    }

    function test(uint256 a, uint256 b) public pure returns (uint256) {
        return a + b;
    }

    // 调用地址的代码（低级别调用）
    function callContract(address addr, bytes memory data)
        public
        returns (bool, bytes memory)
    {
        (bool success, bytes memory result) = addr.call(data);
        return (success, result);
    }
}

// 定义一个简单的接口
interface IERC20 {
    
    function transfer(address to, uint256 amount) external returns (bool);

    function balanceOf(address account) external view returns (uint256);
}

contract ERC20 is IERC20 {
    function transfer(address to, uint256 amount) external returns (bool) {
        return false;
    }

    function balanceOf(address account) external view returns (uint256) {
        return 1;
    }
}
