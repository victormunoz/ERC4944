// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./utils/Context.sol";
import "./IERC20.sol";
import "./ERC721.sol";

/**
 * @dev {ERC721} token, including:
 *
 *  - ability for holders to burn (destroy) their tokens
 *  - token ID and URI autogeneration
 *
 * The account that deploys the contract will be granted the owner role
 * which will let it grant minter and pauser abilities.
 */
contract WalletNFT is Context, ERC721 {
    bool private _minted;
    uint256 private _created;
    address owner;

    // Base URI
    string private _baseURIextended;

    /**
     * Token URIs will be autogenerated based on `baseURI` and their token IDs.
     * See {ERC721-tokenURI}.
     */
    constructor(string memory name, string memory symbol, string memory _baseURI) ERC721(name, symbol) {
        _baseURIextended = _baseURI;
        mint(msg.sender,0);
        _minted = true;
        _created = block.timestamp;
        owner = msg.sender;
    }

    /**
     * Transfers ERC20 tokens from the contract to a recipient.
     */
    function transferTokens(IERC20 token, address recipient, uint256 amount) public {
        token.transfer(recipient, amount);
    }

    /**
     * Returns the contract token balance of a given ERC20 address.
     */
    function balanceTokens(IERC20 token) public view virtual returns (uint256) {
        return token.balanceOf(address(this));
    }

    /**
     * @dev Creates a new token for `to`. Its token ID will be automatically
     * assigned (and available on the emitted {IERC721-Transfer} event), and the token
     * URI autogenerated based on the base URI passed at construction.
     *
     * See {ERC721-_mint}.
     *
     * Requirements:
     *
     * - the caller must be owner.
     */
    function mint(address to, uint256 tokenId) public virtual {
        _mint(to, tokenId);
    }

    function _mint(address to, uint256 tokenId) internal virtual override {
        require(!_minted, "NFT: already minted");
        super._mint(to, tokenId);
    }

    function transfer(address to) public virtual {
        super._transfer(msg.sender, to, 0);
    }

    function _transfer(address from, address to, uint256 tokenId) internal virtual override {
        super._transfer(from, to, tokenId);
    }

    function setBaseURI(string memory baseURI_) public virtual {
        _baseURIextended = baseURI_;
    }

    function baseURI() public view returns (string memory){
        return _baseURIextended;
    }

    function getCreated() public view returns (uint256) {
        return _created;
    }

    function isNFT() public pure returns(bool) {
        return true;
    }
}
