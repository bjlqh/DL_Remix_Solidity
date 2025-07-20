// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./MyERC721.sol";
import "contracts/MyToken.sol";

contract NFTMarket is ITokenReceiver{

    struct Listing {
        address seller;
        uint price;
    }
    mapping(uint => Listing) public listings;
    
    MyERC721 public nft;
    MyToken public token;
    

    constructor(address nftAddress, address tokenAddress){
        nft = MyERC721(nftAddress);
        token = MyToken(tokenAddress);
    }

    //上架
    function list(uint tokenId, uint price) external {
        //token不属于owner
        require(nft.ownerOf(tokenId) == msg.sender, "Not owner");
        require(price > 0, "Price must be greater than 0");
        listings[tokenId] = Listing({seller: msg.sender, price: price});
    }

    //购买
    function buyNFT(uint tokenId) external {
        Listing memory item = listings[tokenId];
        require(item.seller != address(0), "NFT not listed");
        require(msg.sender != item.seller, "Cannot buy your own NFT");
        require(token.balanceOf(msg.sender) >= item.price, "Not enough tokens to buy NFT");
        
        //支付token到market
        bool success = token.transferFrom(msg.sender, address(this), item.price);
        require(success, "Token transferFrom failed");

        //转移所有权给买家
        nft.safeTransferFrom(item.seller, msg.sender, tokenId);
        
        //清除
        delete listings[tokenId];
    }

    //平台收款
    function tokensReceived(address spender, uint amount, bytes calldata data) external returns (bool) {
        require(msg.sender == address(token), "unauthorized contract!");
        uint tokenId = abi.decode(data, (uint));
        Listing memory item = listings[tokenId];
        
        require(item.price > 0, "NFT not listed");
        require(amount >= item.price, "Insufficient Amount!");
        
        //给卖家付款
        require(token.transfer(item.seller, item.price), "Transfer to seller failed");
        
        //转移所有权给买家
        nft.safeTransferFrom(item.seller, spender, tokenId);
        
        //清除
        delete listings[tokenId];
        return true;
    }

}