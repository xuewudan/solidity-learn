// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.5.0
pragma solidity ^0.8.27;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract MyToken is ERC20, ERC20Permit {
    // 构造函数执行有顺序，显示ERC20然后是ERC20Permit，最后执行自己构造体的内容；
    constructor() ERC20("MyToken", "MTK") ERC20Permit("MyToken") {
        // 执行构造函数的时候，给自己铸造了100万枚MyToken
        _mint(msg.sender, 1000000);
    }
}
