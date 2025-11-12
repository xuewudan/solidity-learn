// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    receive() external payable {}

    function withdrawWithTransfer() external {
        payable(msg.sender).transfer(1 ether);
    }

    function withdrawWithSend() external {
        bool success = payable(msg.sender).send(1 ether);
        require(success, "Send failed");
    }

    function withdrawWithCall() external {
        (bool success, ) = payable(msg.sender).call{value: 1 ether}("");
        require(success, "Call failed");
    }
}
