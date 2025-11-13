// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    receive() external payable {}

    event CallLog(bytes input, bytes output);

    function withdrawWithTransfer() external {
        payable(msg.sender).transfer(1 ether);
    }

    function withdrawWithSend() external {
        bool success = payable(msg.sender).send(1 ether);
        require(success, "Send failed");
    }

    function withdrawWithCall(bytes memory input) external {
        // data 一般存在合约转给合约的交易
        (bool success, bytes memory data) = payable(msg.sender).call{
            value: 1 ether
        }(input); // 括号里边传的是函数选择器+入参的一个bytes
        require(success, "Call failed");
        emit CallLog(input, data);
    }
}

contract BankUser {

    // 合约与合约之间的交易
    Bank bank;

    receive() external payable {}

    constructor(address payable _bank) {
        bank = Bank(_bank);
    }

    function withdrawWithTransfer() external {
        bank.withdrawWithTransfer();
    }

    function withdrawWithSend() external {
        bank.withdrawWithSend();
    }

    function withdrawWithCall(bytes memory input) external {
        bank.withdrawWithCall(abi.encodePacked(input));
    }

    function testPay() external payable returns (address) {
        return address(this);
    }

    // 0x0000000000000000000000007ef2e0048f5baede046f6bf797943daf4ed8cb47

    // 0x7EF2e0048f5bAeDe046f6BF797943daF4ED8CB47
}
