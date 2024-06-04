const chain = hre.network.name;

// TODO: update these for production deployment
const tokenName = "Test NFT";
const tokenSymbol = "NFT";

var addr = {};
addr.owner = process.env.OWNER;
// TODO: update in .env for production deployment !!!!!!!!!!!
addr.baseUri = process.env.BASE_URI;

async function main() {
    const MyToken = await ethers.getContractFactory("MockDegen");
 
    // Start deployment, returning a promise that resolves to a contract object
    const myToken = await MyToken.deploy(); // Instance of the contract 
    console.log("Token deployed to address:", myToken.address);
    console.log(`npx hardhat verify --network ${chain} ${myToken.address}`);


    // Grab the contract factory 
    const MyNFT = await ethers.getContractFactory("Degenfer");
 
    // Start deployment, returning a promise that resolves to a contract object
    const myNFT = await MyNFT.deploy(tokenName, tokenSymbol, addr.owner, addr.baseUri, myToken.address); // Instance of the contract 
    console.log("NFT deployed to address:", myNFT.address);
    console.log(`npx hardhat verify --network ${chain} ${myNFT.address} "${tokenName}" ${tokenSymbol} ${addr.owner} ${addr.baseUri} ${myToken.address}`);
 }
 
 main()
   .then(() => process.exit(0))
   .catch(error => {
     console.error(error);
     process.exit(1);
   });