import { getFullnodeUrl, SuiClient } from "@mysten/sui/client";
import { Ed25519Keypair } from "@mysten/sui/keypairs/ed25519";
import { Transaction } from "@mysten/sui/transactions";
import { fromBase64 } from "@mysten/sui/utils";
const rpcUrl = getFullnodeUrl('testnet')

const client = new SuiClient({ url: rpcUrl})
const secertKey = fromBase64('AFzB8iRbABil/uaBV/BFcspkJm3650QyJ9pRSUh8B4vE');
const keypair = Ed25519Keypair.fromSecretKey(secertKey)
const AddQuestion = () =>{
    async function addQuestion () {
        const tx = new Transaction();
        tx.setSender(keypair.toSuiAddress());
        tx.setGasBudget(100000000);
        tx.setGasPayment([{objectId: '0x11f2209209820c5c401a3d1429376c996fc04761ec01ec18e5132f961963731f', 
            version: '446991671', digest: ''}])
        tx.moveCall({
            package: '0xe8549b1168cc0e37e6b5a08c6a46f99d4efce439b15970ec27e5e82f330f710f',
            module: 'wwtbas',
            function: 'add_question',
            arguments: [tx.pure.address
                ('0x6dbfc09013d009931046e820a3a4d20d70e8f51e36c89b09d6f7776b38cc36f2'), 
                    tx.pure.string('What is your name?')]
        })
        await client.signAndExecuteTransaction({signer: keypair, transaction:tx})
        .catch((e)=>{
            console.log(e);
        }).then((res)=>{
            console.log(res);
        });
        return (
            <div>AddQuestion</div>
        )
    }
}