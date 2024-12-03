# nmapSelector  

A short script selecting between thorough and sequencial nmap scan modes.  
use:  
`-m thorough` to run an extensive scan
`-m sequencial` to first get quick results of a a default scan, then getting results of an Aggressive scan of the found ports, and then make an all-ports Aggressive scan
...more modes to be integrated in the future

### Note
Aggressive scan (`-A` in nmap) implicitly includes the following scan prompts:
- `-O` OS detection 
- `-sV` Version detection 
- `-sC` Script scanning using default scripts
- `--traceroute` Traceroute
