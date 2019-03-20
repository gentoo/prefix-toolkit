# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2
#
# In stacked Prefix there is no bash installed, yet
# etc/bash/bashrc from base Prefix still is useful.
#

if [[ $- != *i* ]] ; then
	# Shell is non-interactive, bashrc does not apply
	return
fi

if [[ -r @GENTOO_PORTAGE_BPREFIX@/etc/bash/bashrc ]] ; then
	source '@GENTOO_PORTAGE_BPREFIX@/etc/bash/bashrc'
	# only if base Prefix does have an etc/bash/bashrc, we also
	# run bashrc snippets provided by packages in stacked Prefix
	for sh in '@GENTOO_PORTAGE_EPREFIX@'/etc/bash/bashrc.d/* ; do
		[[ -r ${sh} ]] && source "${sh}"
	done
	unset sh
else
	# etc/profile does expect etc/bash/bashrc to set PS1
	PS1='\u@\h \w \$ '
fi
