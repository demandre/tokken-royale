const SimpleStorage = artifacts.require("SimpleStorage");
const TutorialToken = artifacts.require("TutorialToken");
const ComplexStorage = artifacts.require("ComplexStorage");
const ElectionFactory = artifacts.require("ElectionFactory");
const ElectionHelper = artifacts.require("ElectionHelper");

module.exports = function(deployer) {
  deployer.deploy(SimpleStorage);
  deployer.deploy(TutorialToken);
  deployer.deploy(ComplexStorage);
  deployer.deploy(ElectionFactory);
  deployer.deploy(ElectionHelper);
};
