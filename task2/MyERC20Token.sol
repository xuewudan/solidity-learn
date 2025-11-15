// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title ERC20 代币合约
 * @dev 实现了 ERC20 标准的核心功能
 */
contract MyERC20Token {

    // --- 公共状态变量 ---

    /// @notice 代币名称
    string public name;

    /// @notice 代币符号
    string public symbol;

    /// @notice 代币小数位数
    uint8 public decimals;

    /// @notice 代币总供应量
    uint256 public totalSupply;

    // --- 核心数据结构 ---

    /// @notice 存储每个账户的余额
    mapping(address => uint256) public balanceOf;

    /// @notice 存储授权信息: owner -> spender -> amount
    mapping(address => mapping(address => uint256)) public allowance;

    // --- 事件定义 ---

    /**
     * @notice 转账事件
     * @param from 转账发起地址
     * @param to 转账接收地址
     * @param value 转账金额
     */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /**
     * @notice 授权事件
     * @param owner 授权方地址
     * @param spender 被授权方地址
     * @param value 授权金额
     */
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    // --- 访问控制 ---

    /// @notice 合约所有者地址
    address private _owner;

    /**
     * @notice 仅所有者可调用的修饰符
     */
    modifier onlyOwner() {
        require(msg.sender == _owner, "MyERC20: caller is not the owner");
        _;
    }

    // --- 构造函数 ---

    /**
     * @notice 初始化合约，设置代币基本信息并 mint 初始供应量给部署者
     * @param name_ 代币名称
     * @param symbol_ 代币符号
     * @param decimals_ 代币小数位数
     * @param initialSupply_ 初始供应量（不带小数）
     */
    constructor(
        string memory name_,
        string memory symbol_,
        uint8 decimals_,
        uint256 initialSupply_
    ) {
        name = name_;
        symbol = symbol_;
        decimals = decimals_;
        _owner = msg.sender;

        // 计算实际供应量（乘以 10^decimals）
        uint256 supplyWithDecimals = initialSupply_ * (10**uint256(decimals_));
        totalSupply = supplyWithDecimals;
        balanceOf[msg.sender] = supplyWithDecimals;

        // 触发初始转账事件（从 0 地址转到部署者）
        emit Transfer(address(0), msg.sender, supplyWithDecimals);
    }

    // --- 核心功能实现 ---

    /**
     * @notice 转账功能
     * @param to 接收地址
     * @param value 转账金额（带小数）
     * @return 转账是否成功
     */
    function transfer(address to, uint256 value) public returns (bool) {
        address from = msg.sender;
        _transfer(from, to, value);
        return true;
    }

    /**
     * @notice 授权功能
     * @param spender 被授权地址
     * @param value 授权金额（带小数）
     * @return 授权是否成功
     */
    function approve(address spender, uint256 value) public returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, value);
        return true;
    }

    /**
     * @notice 授权转账功能
     * @param from 转账发起地址（需已授权给调用者）
     * @param to 接收地址
     * @param value 转账金额（带小数）
     * @return 转账是否成功
     */
    function transferFrom(
        address from,
        address to,
        uint256 value
    ) public returns (bool) {
        address spender = msg.sender;
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    // --- 内部辅助函数 ---

    /**
     * @dev 内部转账逻辑，包含余额检查
     */
    function _transfer(
        address from,
        address to,
        uint256 value
    ) internal {
        require(from != address(0), "MyERC20: transfer from the zero address");
        require(to != address(0), "MyERC20: transfer to the zero address");
        require(
            balanceOf[from] >= value,
            "MyERC20: transfer amount exceeds balance"
        );

        // 更新余额
        unchecked {
            balanceOf[from] -= value;
            balanceOf[to] += value;
        }

        // 触发转账事件
        emit Transfer(from, to, value);
    }

    /**
     * @dev 内部授权逻辑
     */
    function _approve(
        address owner,
        address spender,
        uint256 value
    ) internal {
        require(owner != address(0), "MyERC20: approve from the zero address");
        require(spender != address(0), "MyERC20: approve to the zero address");

        allowance[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    /**
     * @dev 内部授权消耗逻辑，包含授权额度检查
     */
    function _spendAllowance(
        address owner,
        address spender,
        uint256 value
    ) internal {
        uint256 currentAllowance = allowance[owner][spender];
        if (currentAllowance != type(uint256).max) {
            require(
                currentAllowance >= value,
                "MyERC20: insufficient allowance"
            );
            unchecked {
                _approve(owner, spender, currentAllowance - value);
            }
        }
    }

    // --- 所有者功能 ---

    /**
     * @notice 增发代币（仅所有者可调用）
     * @param to 接收增发代币的地址
     * @param value 增发金额（带小数）
     */
    function mint(address to, uint256 value) public onlyOwner {
        require(to != address(0), "MyERC20: mint to the zero address");

        // 更新总供应量和接收者余额
        totalSupply += value;
        balanceOf[to] += value;

        // 触发转账事件（从 0 地址转到接收者）
        emit Transfer(address(0), to, value);
    }

    /**
     * @notice 转移合约所有权（仅所有者可调用）
     * @param newOwner 新所有者地址
     */
    function transferOwnership(address newOwner) public onlyOwner {
        require(
            newOwner != address(0),
            "MyERC20: new owner is the zero address"
        );
        _owner = newOwner;
    }
}
