// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.1;

// We first import some OpenZeppelin Contracts.
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "hardhat/console.sol";

// We inherit the contract we imported. This means we'll have access
// to the inherited contract's methods.

/**
* OpenZeppelin essentially implements the NFT standard for us
* and then lets us write our own logic on top of it to customize it.
 */
contract MyEpicNFT is ERC721URIStorage {
  // Helps us keep track of tokenIds using openzeppline.
  using Counters for Counters.Counter;
  Counters.Counter private _tokenIds;

  // We need to pass the name of our NFTs token and its symbol.
  constructor() ERC721 ("SquareNFT", "SQUARE") {
    console.log("This is my NFT contract. Woah!");
  }

  // A function our user will hit to get their NFT.
  function makeAnEpicNFT() public {
     // Get the current tokenId, this starts at 0.
    uint256 newItemId = _tokenIds.current();
    /**
    * we're using _tokenIds to keep track of the NFTs unique identifier,
    * and it's just a number! It's automatically initialized to 0 when we declare private _tokenIds.
    * So, when we first call makeAnEpicNFT, newItemId is 0. When we run it again, newItemId will be 1, and so on!
    * _tokenIds is state variable which means if we change it, the value is stored on the contract directly.
    */

     // Actually mint the NFT to the sender using msg.sender.
    _safeMint(msg.sender, newItemId);
    /**
    * When we do _safeMint(msg.sender, newItemId) it's pretty much saying: "mint the NFT with id newItemId to the user with address msg.sender"
    * Here, msg.sender is a variable Solidity itself provides that easily gives us access to the public address of the person calling the contract.
    * by using msg.sender you can't "fake" someone else's public address unless you had their wallet credentials and called the contract on their behalf!
     */

    // Set the NFTs data.
    // the below url is obtained fromjsonkeeper.com which stores json data about the NFT
    _setTokenURI(newItemId, "https://jsonkeeper.com/b/GKHP");
    // help us see when the NFT is minted and to who!
    console.log("An NFT w/ ID %s has been minted to %s", newItemId, msg.sender);
    /**
    * _setTokenURI(newItemId, "blah") which will set the NFTs unique identifier along with the data associated w/ that unique identifier.
    * It's literally us setting the actual data that makes the NFT valuable.
    */

    // Increment the counter for when the next NFT is minted.
    _tokenIds.increment();
    /**
    * After the NFT is minted, we increment tokenIds using _tokenIds.increment() (which is a function OpenZeppelin gives us).
    * This makes sure that next time an NFT is minted, it'll have a different tokenIds identifier. No one can have a tokenIds that's already been minted too.
    * The tokenURI is where the actual NFT data lives. And it usually links to a JSON file called the metadata.
    * every NFT has a name, description, and a link to something like a video, image, etc. It can even have custom attributes on it!
    * Be careful with the structure of your metadata, if your structure does not match the OpenSea Requirements your NFT will appear broken on the website.
    */
  }
}