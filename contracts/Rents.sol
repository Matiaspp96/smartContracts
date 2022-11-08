// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import './IBonvo.sol';

abstract contract Rents is IBonvo{
    mapping (address => mapping(uint=> Rent)) public myRents;
    mapping (address => uint) public countRents;
    Rent[] rents;

    function saveRent(Rent memory rent) internal{
        rents.push(rent);
        uint size = countRents[msg.sender];
        myRents[msg.sender][size+1] = rent;
        countRents[msg.sender] = size+1;
    }

    function getMyRents(address user) public view returns(Rent[] memory){
        uint size = countRents[user];
        Rent[] memory tRents = new Rent[](size);
        for (uint256 i = 0; i < size; i++) {
            tRents[i] = myRents[user][i];
        }
        return tRents;
    }
}