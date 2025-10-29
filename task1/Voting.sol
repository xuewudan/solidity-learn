// SPDX-License-Identifier: MIT
pragma solidity 0.8.30;

contract Voting {
    // 存储候选人得票数：候选人地址 => 得票数
    mapping(address => uint256) public candidateVotes;

    // 记录已投票用户，防止重复投票：用户地址 => 是否已投票
    mapping(address => bool) public hasVoted;

    //记录候选人，这里的候选人列表是元素不重复的集合
    address[] public candidateList;

    // 投票函数：向指定候选人投票（每人仅限一次）
    function vote(address candidate) external {
        // 校验：候选人地址不能为零地址
        require(candidate != address(0), "Voting: invalid candidate address");
        // 校验：用户未投过票
        require(!hasVoted[msg.sender], "Voting: you have already voted");
        if (candidateVotes[candidate] == 0) {
            candidateList.push(candidate);
        }
        // 记录投票状态
        hasVoted[candidate] = true;
        // 候选人得票数 +1
        candidateVotes[candidate]++;
    }

    // 查询函数：返回指定候选人的得票数
    function getVotes(address candidate) external view returns (uint256) {
        return candidateVotes[candidate];
    }

    // 重置函数：清空所有候选人得票和投票记录（仅拥有者可操作）
    function resetVotes() external {
        for (uint256 i = 0; i < candidateList.length; i++) {
            address candidate = candidateList[i];
            candidateVotes[candidate] = 0;
        }
    }
}
