// // SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

contract CryptoFundMe {
    struct Project {
        uint256 id;
        string name;
        string description;
        address payable owner;
        uint256 balance;
        uint256 totalDonations;
    }

    Project[] public projects;
    // Mapping from address to an array of owned projects
    mapping(address => uint256[]) private _ownedProjectIndices;

    modifier isProjectOwner(uint256 projectId) {
        require(
            projects[projectId].owner == msg.sender,
            "To perform this action you need to be the project owner!"
        );
        _;
    }

    function projectsCount() public view returns (uint256) {
        return projects.length;
    }

    function projectByIndex(uint256 index) public view returns (Project memory) {
        return projects[index];
    }

    function ownedProjectsCount(address owner) public view returns (uint256) {
        return _ownedProjectIndices[owner].length;
    }

    function projectByOwnerIndex(address owner, uint256 ownerIndex) public view returns (Project memory) {
        uint256 globalProjectIndex = _ownedProjectIndices[owner][ownerIndex];
        return projects[globalProjectIndex];
    }

    function createProject(string memory title, string memory description) public returns (uint256) {
        uint256 projectId = projects.length;
        projects.push(Project(projectId, title, description, payable(msg.sender), 0, 0));
        _ownedProjectIndices[msg.sender].push(projectId);
        return projectId;
    }

    function updateProjectName(uint256 projectId, string memory name) public isProjectOwner(projectId) {
        projects[projectId].name = name;
    }

    function updateProjectDescription(uint256 projectId, string memory description) public isProjectOwner(projectId) {
        projects[projectId].description = description;
    }

    function fundProject(uint256 projectId) public payable {
        Project storage project = projects[projectId];
        project.balance += msg.value;
        project.totalDonations += msg.value;
    }

    function withdrawProjectDonations(uint256 projectId) public isProjectOwner(projectId) {
        Project storage project = projects[projectId];
        uint256 amountToWithdraw = project.balance;
        project.balance = 0;
        project.owner.transfer(amountToWithdraw);
    }
}
