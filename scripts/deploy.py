from brownie import CryptoFundMe
from brownie import accounts


def main():
    # deploys the contract using one of the pre-generated accounts
    fund_me = CryptoFundMe.deploy({'from': accounts[0]})
