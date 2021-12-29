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
		uint	balance;
		
		uint	win;
		uint	lost;

		Coach	coach;
		Fighter fighter;
	}

	mapping (address => Player) private players;
	uint	private	playerLength;

	mapping (uint => Coach) private coachs;
	uint	private coachLength;

	mapping (uint => Boss) private bosses;
	uint	private bossLength;

	address payable owner;

    constructor() { 

		owner = payable(msg.sender);

		coachLength = 0;
		bossLength = 0;

		createCoach("Yourself", "you against world", 5, 5);
		createBoss("Musk", "Tesla $TLS", 100, 100);
		createBoss("Bezos", "Amazon $AMZN", 200, 150);
    }

	function register(string memory _name) public
	{
		Player storage player = players[msg.sender];

		player.name = _name;
		player.balance = 0;
		player.lost = 0;
		player.win = 0;
		player.coach = coachs[0];
	}

	function getPlayerData() public view returns (Player memory)
	{
		return players[msg.sender];
	}

	function createCoach(string memory _name, string memory _desc, uint _power, uint _health) public
	{
		Coach storage coach = coachs[coachLength];

		coach.name = _name;
		coach.desc = _desc;
		coach.power = _power;
		coach.health = _health;

		coachLength++;
	}

	function getCoachs() public view returns (Coach[] memory)
	{
		Coach[] memory memoryArray = new Coach[](coachLength);

		for (uint index = 0; index < coachLength; index++) {
			memoryArray[index] = coachs[index];
		}

		return memoryArray;
	}

	function createBoss(string memory _name, string memory _desc, uint _power, uint _health) public
	{
		Boss storage boss = bosses[bossLength];

		boss.name = _name;
		boss.desc = _desc;
		boss.power = _power;
		boss.health = _health;
		boss.rank = bossLength;

		bossLength++;
	}

	function getBosses() public view returns (Boss[] memory)
	{
		Boss[] memory memoryArray = new Boss[](bossLength);

		for (uint index = 0; index < bossLength; index++) {
			memoryArray[index] = bosses[index];
		}

		return memoryArray;
	}

	function createFighter(string memory _name, string memory _desc) public payable
	{
		Player storage player = players[msg.sender];

		player.fighter.name = _name;
		player.fighter.desc = _desc;
		player.fighter.power = 1;
		player.fighter.health = 5;

		// owner.transfer(msg.value);
		(bool success,) = owner.call{value: msg.value}("");
    	require(success, "Failed to send money");
		// owner.transfer()
	}

}