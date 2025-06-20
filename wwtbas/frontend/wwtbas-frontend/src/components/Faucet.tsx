import { getFaucetHost, requestSuiFromFaucetV2 } from "@mysten/sui/faucet";
import { useEffect } from "react";

const Faucet = () => {

    useEffect(() =>{
        async function fetchFaucet() {
            let headers = new Headers();
            headers.append('Access-Control-Allow-Origin', '*')
            await requestSuiFromFaucetV2({
            host: getFaucetHost('testnet'),
            recipient: '0x8b082a4184f4e6cb83e2b19a8cf8611c1846675991f764ccc5745e7ebf05bcd1', 
            headers: headers,
            }).catch((error) => {
                console.error(error);  
            }).then((response) => {
                console.log(response);
            });
        }
        fetchFaucet();
    }, []);

    return (
        <div>Faucet</div>
    )
}

export default Faucet;