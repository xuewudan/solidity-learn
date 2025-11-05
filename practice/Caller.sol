// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Caller {
    // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    function testMsg() public view returns (address) {
        return msg.sender;
    }

    function getCurrentAdrress() public view returns (address) {
        return address(this);
    }

    // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    function testTx() public view returns (address) {
        return tx.origin;
    }
}

// 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
contract Callee {
    Caller caller;

    constructor() {
        caller = new Caller();
    }

    // 0x5FD6eB55D12E759a21C09eF703fe0CBa1DC9d88D
    function testMsg() public view returns (address) {
        return caller.testMsg();
    }

    // 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4
    function testTx() public view returns (address) {
        return caller.testTx();
    }
}
