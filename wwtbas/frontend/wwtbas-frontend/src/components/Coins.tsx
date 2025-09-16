import { getFullnodeUrl,SuiClient } from "@mysten/sui/client";
import { useEffect, useState } from "react";

const Coins = () => {

    const rpcUrl = getFullnodeUrl('testnet');

    const client = new SuiClient({ url : rpcUrl})

    const[data, setData] = useState([])
    useEffect(()=>{
        async function fetchCoinsFor(address:string){
            await client.getCoins({
                owner: address,
            }).catch((e)=>{
                console.log(e);
            }).then((res)=>{
                console.log(res);
            });
        }
        fetchCoinsFor
        ('0x8b082a4184f4e6cb83e2b19a8cf8611c1846675991f764ccc5745e7ebf05bcd1');
    },[])
        return (
            <div>
                {data.map((coin, index) =>(
                    <div>
                        ${coin.balance} {coin.coinType.substring}
                        {((coin.coinType.length)-3)} {coin.coinObjectId}
                    </div>
                ))}
            </div>    
        );
    }

export default Coins;