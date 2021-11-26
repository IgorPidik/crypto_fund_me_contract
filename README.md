# Install brownie

You can either install brownie gloablly following
their [docs](https://eth-brownie.readthedocs.io/en/stable/install.html). Or you can install it as a library:

```
$ export BROWNIE_LIB=1
$ pipenv install
```

# Deploy on ganache

1. Start ganache
2. Deploy the contract
   ```
   $ pipenv run brownie run scripts/deploy.py
   ```
3. Grab the contract address from the log, you will need it to run the dApp

# TODOs

- [ ] Let owners delete their projects
- [ ] Write unit tests
