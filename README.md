## Installation
in plugin.cfg add `threebot:github.com/threefoldtech/threebot_coredns`

## Configuration

in Corefile

```
. {
    threebot ZONE {
        explorer EXPLORER_URL
    }
}

```

e.g

```
. {
    threebot grid.tf. {
        explorer "https://explorer.testnet.threefoldtoken.com"
    }
}
```

that will enable threebot against testnet explorer



## Running

```
cat ~/Corefile
. {
    threebot grid.tf. {
    	explorer https://explorer.testnet.threefoldtoken.com
    }
}
```

```
 ./coredns -conf ~/Corefile -dns.port 1053
.:1053
2019-05-08T12:27:37.303+02:00 [INFO] CoreDNS-1.5.0
2019-05-08T12:27:37.303+02:00 [INFO] linux/amd64, go1.12.4, 8be8dd18-dirty
CoreDNS-1.5.0
linux/amd64, go1.12.4, 8be8dd18-dirty
```

### Example 

we have a [3bot record](https://explorer.testnet.threefoldtoken.com/explorer/whois/3bot/codepaste.thabeta) 

```
{"record":{"id":38,"addresses":["google.com","8.8.8.8","192.168.12.42","2001:db8:85a3::8a2e:370:7334"],"names":["codepaste.thabeta"],"publickey":"ed25519:47ae06c4457f8fc1ec9ecc944fc05459d320670575a95b517465b6c332a7f2d2","expiration":1559901840}}
```

Asking for A records

```
dig A codepaste.thabeta.grid.tf -p 1053

; <<>> DiG 9.11.3-1ubuntu1.7-Ubuntu <<>> A codepaste.thabeta.grid.tf -p 1053
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 22860
;; flags: qr aa rd; QUERY: 1, ANSWER: 2, AUTHORITY: 0, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 5e8985f723928c22 (echoed)
;; QUESTION SECTION:
;codepaste.thabeta.grid.tf.	IN	A

;; ANSWER SECTION:
codepaste.thabeta.grid.tf. 300	IN	A	8.8.8.8
codepaste.thabeta.grid.tf. 300	IN	A	192.168.12.42

;; Query time: 74 msec
;; SERVER: 127.0.0.53#1053(127.0.0.53)
;; WHEN: Wed May 08 12:31:39 EET 2019
;; MSG SIZE  rcvd: 148


```

Asking for AAAA records

```
dig AAAA codepaste.thabeta.grid.tf -p 1053

; <<>> DiG 9.11.3-1ubuntu1.7-Ubuntu <<>> AAAA codepaste.thabeta.grid.tf -p 1053
;; global options: +cmd
;; Got answer:
;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 59266
;; flags: qr aa rd; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1
;; WARNING: recursion requested but not available

;; OPT PSEUDOSECTION:
; EDNS: version: 0, flags:; udp: 4096
; COOKIE: 86fe5e9946a6698c (echoed)
;; QUESTION SECTION:
;codepaste.thabeta.grid.tf.	IN	AAAA

;; ANSWER SECTION:
codepaste.thabeta.grid.tf. 360	IN	AAAA	2001:db8:85a3::8a2e:370:7334

;; Query time: 70 msec
;; SERVER: 127.0.0.53#1053(127.0.0.53)
;; WHEN: Wed May 08 12:31:34 EET 2019
;; MSG SIZE  rcvd: 119

````