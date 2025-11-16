// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// 导入 OpenZeppelin 的 ERC721 实现和 Ownable 用于权限控制
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title MyArtNFT
 * @dev 一个简单的 ERC721 NFT 合约，用于铸造带有图文 metadata 的艺术品 NFT
 */
contract MyArtNFT is ERC721, Ownable {
    // 计数器，用于生成唯一的 token ID
    uint256 private _tokenIdCounter;

    // 可选：一个 mapping 用于存储每个 token ID 对应的元数据 URI
    // 虽然 ERC721 标准的 tokenURI 函数可以直接返回，但显式存储有时更灵活
    mapping(uint256 => string) private _tokenURIs;

    /**
     * @notice 构造函数
     * @param name_ NFT 集合的名称 (e.g., "My Art Collection")
     * @param symbol_ NFT 集合的符号 (e.g., "ART")
     */
    constructor(string memory name_, string memory symbol_)
        ERC721(name_, symbol_)
        Ownable(msg.sender)
    {
        _tokenIdCounter = 0;
    }

    /**
     * @notice 铸造一个新的 NFT
     * @param to 接收 NFT 的地址
     * @param uri 该 NFT 对应的元数据 (metadata) JSON 文件的 IPFS 链接
     * @return 新铸造 NFT 的 token ID
     */
     // https://ipfs.io/ipfs/bafkreidgiub66frsctihvtmqec3znoz4fmrqedpzl4wm4p4xrin4pp5azi
    // final URI: https://ipfs.io/ipfs/bafkreidoireu5psz7l7bea6cxmcakwzsgql2bpqdsfvv7oqaqpts55rwba
    function mintNFT(address to, string memory uri)
        public
        onlyOwner
        returns (uint256)
    {
        // 确保接收地址有效
        require(to != address(0), "ERC721: mint to the zero address");

        // 获取下一个 token ID
        uint256 newTokenId = _tokenIdCounter;

        // 铸造 NFT
        _safeMint(to, newTokenId);

        // 设置并存储该 NFT 的元数据 URI
        _setTokenURI(newTokenId, uri);

        // 递增计数器，为下一次铸造做准备
        _tokenIdCounter++;

        return newTokenId;
    }

    /**
     * @notice 内部函数，用于设置 token ID 对应的 metadata URI
     * @param tokenId NFT 的 ID
     * @param uri IPFS 上的 metadata JSON 链接
     */
    function _setTokenURI(uint256 tokenId, string memory uri) internal virtual {
        require(
            tokenId >=0,
            "ERC721Metadata: URI set of nonexistent token"
        );
        _tokenURIs[tokenId] = uri;
    }

    /**
     * @notice 重写 ERC721 标准的 tokenURI 函数，以返回我们存储的 URI
     * @param tokenId NFT 的 ID
     * @return 该 NFT 的元数据 URI
     */
    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            // _ownerOf(tokenId) == address(0),
            tokenId >=0,
            "ERC721Metadata: URI query for nonexistent token"
        );
        return _tokenURIs[tokenId];
    }
}
