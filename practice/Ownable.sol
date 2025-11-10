// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// 父合约
contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

    function test() public pure virtual returns (uint256) {
        return 1;
    }
}

// 子合约
contract MyContract is Ownable {
    function changeOwner(address newOwner) public onlyOwner {
        owner = newOwner;
    }

    function test() public pure override returns (uint256) {
        return 1;
    }
}
