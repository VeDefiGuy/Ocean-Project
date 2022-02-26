pragma solidity ^0.8.0;

contract Seed {


    uint256 seed;

    uint256[] public randomArray;

    address sender;
    address owner;

    constructor() {
        randomArray = new uint256[](10);
        owner = msg.sender;
        sender = owner;
        seed = 43770;
    }

    function draw() public view returns(uint256) {
        require(randomArray[0] != 0, "random not init. yet");
        require(msg.sender == sender, "Yo cheater!");

        uint256 rand = random() % 10;
        if (randomArray[rand] % 10 < 5) {
            return getDrawId();
        } else if (randomArray[rand] % 10 < 8) {
            return getWinnerId();
        } else {
            return getLooserId();
        }
    }

    function update(address account) public {
        require(msg.sender == sender, "Yo cheater!");
        
        for (uint256 i = 0; i < 10; i++) {
            seed = uint(keccak256(abi.encodePacked(account, seed)));
            randomArray[i] = seed;
        }
    }

    //
    // VIEW FUNCTIONS
    //

    function getWinnerId() public view returns(uint16) {
        return 1;
    }

    function getLooserId() public view returns(uint16) {
        return 2;
    }

    function getDrawId() public view returns(uint16) {
        return 3;
    }
    

    //
    // ADMIN FUNCTIONS
    //

    function setSender(address _sender) public {
        require(msg.sender == owner, "you are not the owner");
        sender = _sender;
    }

    //
    // PRIVATE FUNCTIONS
    //
    function random() public view returns (uint) {
        // sha3 and now have been deprecated
        return uint(keccak256(abi.encodePacked(block.difficulty, block.timestamp, seed)));
    }
}
