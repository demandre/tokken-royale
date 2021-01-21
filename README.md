# Tokken Royale

````shell script
npm install -g truffle
````

## Install modules
```shell script
npm install
cd vapp
npm install
```

## Local project
Into the first console
```shell script
truffle develop
> migrate
```

Into the second console
```shell script
cd vapp
npm run serve
```

## Local Metamask

### Install RPC custom
#### Name of the network
LocalTruffle
#### New URL of RPC
http://127.0.0.1:7545/
#### ID of the chain
Type anything, and on submit it will show you the good one.

### Switch account
In the up right corner, click on your account and select import account. Then use a private key generated in the first console in **Local Project** step.
