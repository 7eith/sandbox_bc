// SPDX-License-Identifier: SyneziaSoft (c) 2021

pragma solidity >=0.7.0 <0.9.0;

/**

	- WishFighter little NFT games, user can fight against "boss" like Rocky, Casus Clay or someone else
	- 


	_  _ 

	TODO: Only Owner can create Coach, Fighter or something like that
 */

contract WishFighter 
{

	struct	Boss 
	{
		string	name;
		string	desc;

		uint	power;
		uint	health;

		uint	rank;	
	}

	struct	Fighter 
	{
		string	name;
		string	desc;

		uint	power;
		uint	health;

		uint	win;
		uint	lost;
	}

	struct	Coach
	{
		string	name;
		string	desc;

		uint	power;
		uint	health;
	}

	struct	Player 
	{
		string	name;
		
		uint	win;
		uint	lost;

		mapping (address => Fighter) fighter;
	}

	mapping (address => Player) private players;

	mapping (uint => Coach) private coachs;
	uint	private coachLength;

    constructor() { 

		coachLength = 0;
		
    }

    // function createPlayer(string memory _name) public
	// {
	// 	Coach storage defaultCoach = Coach("Yourself", "Yourself can help you, but a pro will increase your chances right?", 1, 1);
	// 	Player memory _player = Player(_name, defaultCoach, 0, 0, 0);
	// }

	function createCoach(string memory _name, string memory _desc, uint _power, uint _health) public
	{
		coachLength++;
		Coach storage coach = coachs[coachLength];

		coach.name = _name;
		coach.desc = _desc;
		coach.power = _power;
		coach.health = _health;
	}

	function getCoachs() public view returns (Coach[] memory)
	{
		Coach[] memory memoryArray = new Coach[](coachLength);

		for (uint index = 0; index < coachLength; index++) {
			memoryArray[index] = coachs[index];
		}
		return memoryArray;
	}
}