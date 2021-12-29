// SPDX-License-Identifier: SyneziaSoft (c) 2021

pragma solidity >=0.7.0 <0.9.0;

contract Storage 
{
    string private name; 

    constructor() { 
        name = "FirstContract";  
    }

    function getName() public view returns (string memory)
    {
        return name;
    }

    function setName(string memory _name) public
    {
        name = _name;
    }
}
