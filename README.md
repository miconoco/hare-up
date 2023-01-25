
	 _
	| |
	| |__   __ _ _ __ ___ ______ _   _ _ __
	| '_ \ / _` | '__/ _ \______| | | | '_ \
	| | | | (_| | | |  __/      | |_| | |_) |
	|_| |_|\__,_|_|  \___|       \__,_| .__/
	                                  | |
	                                  |_|



There is always some madness in love.  
But there is also always some reason in madness.  
[Nietzsche]


Install and Update Hare
=======================

Wrapper script to get <https://harelang.org/> up and running from source.
It bootstraps [qbe](https://c9x.me/compile/), [harec](https://git.sr.ht/~sircmpwn/harec),
[sdc](https://sr.ht/~sircmpwn/scdoc/) and [hare-ssh](https://git.sr.ht/~sircmpwn/hare-ssh) from source, too.

	# ~/.local
	make install
	printf 'HAREPATH=~/.local/src/hare/stdlib:~/.local/src/hare/third-party:/usr/local/src/hare/stdlib:/usr/local/src/hare/third-party\nexport HAREPATH\n' >> ~/.profile

	# system wide
	make
	sudo make PREFIX=/usr/local install


Contribution welcome
====================

Grab the [source](https://git.sr.ht/~miconoco/hare-up)/[mirror](https://codeberg.org/miconoco.de/hare-up);
get your [hands dirty](TODO) and [send patches](https://git-send-email.io)
or questions to [posaune@miconoco.de](https://lists.sr.ht/~miconoco/posaune).

License
=======

Simplified BSD, see [LICENSE](LICENSE) for details.
