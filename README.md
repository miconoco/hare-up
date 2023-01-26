
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


About
=====

Wrapper script to get <https://harelang.org/> up and running from source.
It bootstraps the following packages from source.

- [qbe](https://c9x.me/compile/)
- [scdoc](https://sr.ht/~sircmpwn/scdoc/)
- [harec](https://git.sr.ht/~sircmpwn/harec)
- [hare](https://git.sr.ht/~sircmpwn/harec)
- [hare-ssh](https://git.sr.ht/~sircmpwn/hare-ssh)


Install and Update Hare
=======================

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
