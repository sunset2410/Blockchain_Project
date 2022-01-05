
//PDX-License-Identifier: GPL-3.0

pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address [] public  players;
    function Lottery() public {
        manager = msg.sender;

    }

    function enter() public payable{
        require(msg.value  > 0.01 ether);
        players.push(msg.sender);
    }


    function random() public view returns (uint){
        return uint(keccak256(block.difficulty, now, players));
    }


    function pickWiner() public restricted returns(address){

        require(msg.sender == manager);

        uint index  = random()%players.length;
        address temp = players[index];
        players[index].transfer(this.balance);
        players = new address[](0);
        return temp;
    }


    modifier restricted(){
        require(msg.sender == manager);
        _;
    }

    function getPlayers() public view returns(address[]) {
        return  players;
    }


}
