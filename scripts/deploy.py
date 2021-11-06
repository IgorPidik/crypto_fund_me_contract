from brownie import CryptoFundMe
from brownie import accounts


def main():
    # deploys the contract using one of the pre-generated accounts
    auth_nft = CryptoFundMe.deploy({'from': accounts[0]})
