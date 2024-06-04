// SPDX-License-Identifier: CC0-1.0
// Compatible with OpenZeppelin Contracts ^5.0.0
pragma solidity ^0.8.15;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC4906.sol";

contract Degenfer is ERC721, IERC4906, Ownable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    uint256 private _nextTokenId;
    address private _owner;

    // degen token address on Base:
    address public _degen;

    // the base URI for the token
    string private _metadataBaseURI;

    constructor(string memory name, string memory symbol, address owner, string memory baseURI, address degen)
        ERC721(name, symbol)
    {
        _transferOwnership(owner);
        _grantRole(DEFAULT_ADMIN_ROLE, owner);
        _grantRole(MINTER_ROLE, owner);
        _metadataBaseURI = baseURI;
        _degen = degen;
        _owner = owner;
        _safeMint(owner, _nextTokenId++);
    }

    function _baseURI() internal view override returns (string memory) {
        return _metadataBaseURI;
    }

    // setBaseURI - to be used once all token are minted, to move metadata to ipfs
    function setBaseURI(string memory baseURI) public onlyRole(DEFAULT_ADMIN_ROLE) {
        _metadataBaseURI = baseURI;
        emit BatchMetadataUpdate(0, type(uint256).max);
    }

    // minting via Farcaster frame -- go to /degenfers channel on Warpcast
    function frameMint(address to) public onlyRole(MINTER_ROLE) {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
    }

    // batch mint up to 10 tokens paying 6969 DEGEN for each
    function mint(address to, uint256 amount) public {
        require(amount > 0, "amount must be greater than 0");
        require(amount <= 10, "amount must be less than or equal to 10");
        require(_nextTokenId + amount <= 10021, "max supply reached");
        require(ERC20(_degen).transferFrom(msg.sender, _owner, amount * 6969 ether), "6969 DEGEN per token not approved");
        for (uint256 i = 0; i < amount; i++) {
            uint256 tokenId = _nextTokenId++;
            _safeMint(to, tokenId);
        }
    }

    function totalSupply() public view returns (uint256) {
        return _nextTokenId;
    }

    function exists(uint256 tokenId) public view returns (bool) {
        return _exists(tokenId);
    }

    // The following functions are overrides required by Solidity.

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, IERC165, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
