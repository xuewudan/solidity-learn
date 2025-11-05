// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MessageInfo {
    function getMessageDetails() public payable returns (address, uint256) {
        return (msg.sender, msg.value);
    }

    function getBanlance( ) public view returns (uint256) {
        return address(this).balance;
    }
}

contract BlockInfo {
    function getBlockDetails() public view returns (uint256, uint256) {
        return (block.number, block.timestamp);
    }
}


contract ThisExample {

    //0xb27A31f1b0AF2946B7F582768f03239b1eC07c2c
    //0xb27A31f1b0AF2946B7F582768f03239b1eC07c2c

    function getContractAddress() public view returns (address) {
        return address(this);
    }

    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
}