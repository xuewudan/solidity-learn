// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title BeggingContract
 * @dev 一个简单的乞讨合约，允许用户捐赠以太币，所有者可以提取资金。
 */
contract BeggingContract {
    // --- 状态变量 ---

    /// @notice 记录每个地址的捐赠总额
    mapping(address => uint256) public donations;

    /// @notice 合约所有者地址
    address private _owner;

    // --- 事件定义 ---

    /**
     * @notice 捐赠事件
     * @param donor 捐赠者地址
     * @param amount 捐赠金额（以 wei 为单位）
     */
    event Donated(address indexed donor, uint256 amount);

    /**
     * @notice 提款事件
     * @param owner 合约所有者地址
     * @param amount 提款金额（以 wei 为单位）
     */
    event Withdrawn(address indexed owner, uint256 amount);

    // --- 修饰符 ---

    /**
     * @notice 仅所有者可调用的修饰符
     */
    modifier onlyOwner() {
        require(msg.sender == _owner, "BeggingContract: caller is not the owner");
        _;
    }

    // --- 构造函数 ---

    /**
     * @notice 初始化合约，设置部署者为所有者
     */
    constructor() {
        _owner = msg.sender;
    }

    // --- 核心功能 ---

    /**
     * @notice 捐赠函数，允许用户向合约发送以太币
     * @dev 使用 payable 修饰符接收以太币
     */
    function donate() public payable {
        require(msg.value > 0, "BeggingContract: donation amount must be greater than 0");

        // 更新捐赠者的捐赠总额
        donations[msg.sender] += msg.value;

        // 触发捐赠事件
        emit Donated(msg.sender, msg.value);
    }

    /**
     * @notice 提款函数，允许合约所有者提取所有资金
     * @dev 仅所有者可调用，使用 address.transfer 发送以太币
     */
    function withdraw() public onlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "BeggingContract: contract balance is zero");

        // 提取所有余额到所有者地址
        (bool success, ) = _owner.call{value: contractBalance}("");
        require(success, "BeggingContract: withdrawal failed");

        // 触发提款事件
        emit Withdrawn(_owner, contractBalance);
    }

    /**
     * @notice 查询某个地址的捐赠总额
     * @param donor 捐赠者地址
     * @return 捐赠总额（以 wei 为单位）
     */
    function getDonation(address donor) public view returns (uint256) {
        return donations[donor];
    }

    /**
     * @notice 辅助函数，查看合约当前余额
     * @return 合约余额（以 wei 为单位）
     */
    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}