# Hoisin
This is Hoisin ([w]ho is in - *groan*), a simple Node.js application to let you 
know who's currently at work. It's great if you have remote workers, an office
in another country or simply a big ol' office where you can't see everyone!

It works by continuously scanning the network and recognising the 
[MAC addresses](http://en.wikipedia.org/wiki/MAC_address) of people's computers.
When a machine wakes up in the morning, it'll connect to the network and 
seamlessly mark that person as being present in Hoisin. When it goes to sleep at 
night, Hoisin detects that it's no longer on the network and marks that
person as out of the office.

## Installation
You'll need Node.js, Redis and nmap installed on your machine for this to work.
On OS X, you can get all three at once with `brew install redis nodejs nmap`.

From there, clone this repo, do a cheeky `npm install` and run `coffee app.coffee`. The app will pop up on
port 8080 and start scanning immediately. You can then send users to
`http://<your_ip>:8080/enrol` and start getting them to register their machines.

They'll then show up at `http://<your_ip>:8080` for everyone can see.

## Known Issues
- You can't enrol your own machine as nmap doesn't scan it
- Won't work if your network doesn't live on 192.168.x.x
- No config, so Redis will connect to localhost:5432/1 by default, which may not be good
- Pretty much untested
