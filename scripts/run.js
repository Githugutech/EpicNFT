const main = async () => {
    /**
     * every time you run a terminal command that starts with npx hardhat you are getting this hre object built on the fly 
     * using the hardhat.config.js specified in your code! 
     * This means you will never have to actually do some sort of import into your files 
     */
    const nftContractFactory = await hre.ethers.getContractFactory('MyEpicNFT');
    // This will actually compile our contract and generate the necessary files we need to work with our contract under the artifacts
    const nftContract = await nftContractFactory.deploy();
    /**
     * Hardhat will create a local Ethereum network for us, but just for this contract. 
     * Then, after the script completes it'll destroy that local network. So, every time you run the contract, 
     * it'll be a fresh blockchain. Whats the point?
     *  It's kinda like refreshing your local server every time so you always start from a clean slate which makes it easy to debug errors.
     */
    await nftContract.deployed();
    /**
     * We'll wait until our contract is officially mined and deployed to our local blockchain! 
     * Hardhat actually creates fake "miners" on your machine to try its best to imitate the actual blockchain.
     */
    console.log("Contract deployed to:", nftContract.address);
    /**
     * once it's deployed nftContract.address will basically give us the address of the deployed contract. 
     * This address is how we can actually find our contract on the blockchain. Right now on our local blockchain it's just us. 
     */
};

const runMain = async () => {
    try {
        await main ();
        process.exit(0);
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

runMain ();
