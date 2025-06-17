// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TestNFT is ERC721URIStorage, Ownable {
    constructor() ERC721("Test NFT", "TNF") Ownable(msg.sender){}

    function mintToken(address to, uint256 tokenId) external onlyOwner {
        _safeMint(to, tokenId);
    }

    function setTokenURI(uint256 tokenId, string memory uri) external onlyOwner {
        _setTokenURI(tokenId, uri);
    }
}