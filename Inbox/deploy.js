const HDWalletProvider = require('@truffle/hdwallet-provider');
const Web3 = require('web3');

const {interface, bytecode}  = require('./compile');

provider = new HDWalletProvider(
    'garden calm caution custom gauge surge echo atom adapt speak antenna coyote',
    'https://rinkeby.infura.io/v3/53ba013833ad43f0929aaea2c6a93f21'
);

const web3 = new Web3(provider);

const deploy = async () => {
  const accounts = await web3.eth.getAccounts();

  console.log('Attempting to deploy from account', accounts[0]);

  const result = await new web3.eth.Contract(interface)
    .deploy({ data: bytecode})
    .send({ gas: '1000000', from: accounts[0] });

  console.log('Contract deployed to', result.options.address);
  provider.engine.stop();
};
deploy();
