pragma solidity ^0.8.4;

contract Will {
    address owner;
    uint fortune;
    bool deceased;

    constructor() payable public {
        owner = msg.sender; // msg sender represents address being called
        fortune = msg.value; //msg value tells us how much ether is being sent  
    }

    // create modifier so the only person who can call the contract is the owner
    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // only allocates funds if hasDeceased is true. 
    modifier mustBeDeceased {
        require(deceased == true);
        _;
    }    

    // list of family wallets
    address payable[] familyWallets;

    // maps through inheritance and creates a uint for each address.
    mapping(address => uint) inheritance;

    // set inheritance for each address 
    function payout() private mustBeDeceased {
        for(uint i=0; i<familyWallets.length; i++) {
            familyWallets[i].transfer(inheritance[familyWallets[i]]);
            // transferring funds from contract address to reciever address
        }
    }

    // oracle switch to be triggered by the owner.
    function hasDeceased() public onlyOwner {
        deceased = true;
        payout();
    }
}