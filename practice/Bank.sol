// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 定义一个简单的银行接口
interface IBank {
    function deposit() external payable;

    function withdraw(uint256 amount) external;

    function getBalance() external view returns (uint256);
}

// 实现银行接口的合约
contract Bank is IBank {
    mapping(address => uint256) public balances;

    function deposit() external payable override {
        require(msg.value > 0, "jine must be > 0");
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint256 amount) external override {
        require(balances[msg.sender] >= amount, "yue is not enougth");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // 10000000000000000000
    function getBalance() external view override returns (uint256) {
        return balances[msg.sender];
    }
}

// 使用银行接口的合约
// 用户、客户端的合约
contract BankUser {
    // 存款
    function depositToBank(address bankAddress) external payable {
        IBank bank = IBank(bankAddress);
        bank.deposit{value: msg.value}();
    }

    receive() external payable {}

    // 需要callback来兜底，如果交易失败了，需要callback来接收这个资金，否则资金就丢失了
    fallback() external payable {}

    // 取钱
    function withdrawFromBank(address bankAddress, uint256 amount) external {
        IBank bank = IBank(bankAddress);
        bank.withdraw(amount);
    }

    function getBankBalance(address bankAddress)
        external
        view
        returns (uint256)
    {
        IBank bank = IBank(bankAddress);
        return bank.getBalance();
    }
}
