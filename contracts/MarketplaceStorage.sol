pragma solidity ^0.5.2;

import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC721/IERC721Full.sol";

contract MarketplaceStorage {
  struct Offer {
    uint256 id;

    IERC721Full store;
    uint256 tokenId;

    IERC20 currency;
    uint256 price;

    address seller;
    address buyer;

    uint createdAt;
    uint purchasedAt;

    bool active;
  }

  mapping(uint256 => Offer) public offers;
  uint256[] public offerIds;
}
