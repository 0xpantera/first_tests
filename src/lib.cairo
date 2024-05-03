#[starknet::interface]
pub trait IHelloStarknet<TContractState> {
    fn increase_balance(ref self: TContractState, amount: felt252);
    fn get_balance(self: @TContractState) -> felt252;
    fn do_a_panic(self: @TContractState);
    fn do_a_string_panic(self: @TContractState);
}

#[starknet::contract]
mod HelloStarknet {

    #[storage]
    struct Storage {
        balance: felt252, 
    }

    #[abi(embed_v0)]
    impl HelloStarknetImpl of super::IHelloStarknet<ContractState> {
        fn increase_balance(ref self: ContractState, amount: felt252) {
            assert(amount != 0, 'Amount cannot be 0');
            self.balance.write(self.balance.read() + amount);
        }

        fn get_balance(self: @ContractState) -> felt252 {
            self.balance.read()
        }

        fn do_a_panic(self: @ContractState) {
            let mut arr = ArrayTrait::new();
            arr.append('PANIC');
            arr.append('DAYTAH');
            panic(arr);
        }

        fn do_a_string_panic(self: @ContractState) {
            assert!(false, "a panicking string can't be longer thatn 31 characters");
        }
    }
}