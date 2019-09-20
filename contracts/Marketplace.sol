pragma solidity ^0.5.2;

import "./MarketplaceStorage.sol";

// Import base Initializable contract
import "@openzeppelin/upgrades/contracts/Initializable.sol";

// Import interface and library from OpenZeppelin contracts
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts-ethereum-package/contracts/token/ERC721/IERC721Full.sol";
// TODO: add back
// import "@openzeppelin/contracts-ethereum-package/contracts/ownership/Ownable.sol";
// import "@openzeppelin/contracts-ethereum-package/contracts/lifecycle/Pausable.sol";

contract Marketplace is Initializable, MarketplaceStorage {
  
  event OfferCreated(
    uint256 id,
    IERC721Full store,
    uint256 tokenId,
    IERC20 currency,
    uint256 price,
    address seller,
    uint createdAt,
    bool active
  );

  event OfferPurchased(
    uint256 id,
    IERC721Full store,
    uint256 tokenId,
    IERC20 currency,
    uint256 price,
    address seller,
    address buyer,
    uint createdAt,
    uint purchasedAt,
    bool active
  );

  function initialize() public initializer {}

  function createOffer(address _store, uint256 _tokenId, address _currency, uint256 _price) public {
    // TODO: check that _store is an ERC721 using ERC165.supportsInterface
    // TODO: check that _currency is an ERC20
    uint256 offerId = uint256(keccak256(abi.encodePacked(_store, _tokenId, _currency, _price, msg.sender, block.timestamp)));
    // TODO: check that offerId doesn't already exist

    // check
    require(IERC721Full(_store).ownerOf(_tokenId) == msg.sender, "erc721 item owner should be the creator of the offer");
    require(IERC721Full(_store).getApproved(_tokenId) == address(this), "erc721 item does not approve the marketplace");

    // add
    offers[offerId] = Offer({
      id: offerId,
      store: IERC721Full(_store),
      tokenId: _tokenId,
      currency: IERC20(_currency),
      price: _price,
      seller: msg.sender,
      buyer: address(0),
      createdAt: block.timestamp,
      purchasedAt: 0,
      active: true
    });
    offerIds.push(offerId);

    // event
    emit OfferCreated(offerId, IERC721Full(_store), _tokenId, IERC20(_currency), _price, msg.sender, block.timestamp, true);
  }

  function purchaseOffer(uint256 _offerId) public {
    Offer storage offer = offers[_offerId];

    // check
    // TODO: check that offer exists
    require(offer.active, "offer is not active");
    require(offer.store.ownerOf(offer.tokenId) == offer.seller, "owner of erc721 item is not the offer seller");
    require(offer.store.getApproved(offer.tokenId) == address(this), "erc721 item does not approve the marketplace");
    require(offer.currency.balanceOf(msg.sender) >= offer.price, "not enough erc20 token to pay the offer");
    require(offer.currency.allowance(msg.sender, address(this)) >= offer.price, "marketplace allowance is not enough");

    // transfer
    require(offer.currency.transferFrom(msg.sender, offer.seller, offer.price), "payment failed");
    offer.store.safeTransferFrom(offer.seller, msg.sender, offer.tokenId);

    // update
    offer.buyer = msg.sender;
    offer.active = false;
    offer.purchasedAt = block.timestamp;

    // event
    emit OfferPurchased(offer.id, offer.store, offer.tokenId, offer.currency, offer.price, offer.seller, offer.buyer, offer.createdAt, offer.purchasedAt, offer.active);
  }
}
