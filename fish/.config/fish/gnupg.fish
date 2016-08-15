# Start or re-use a gpg-agent.
#
# Sets the gpg-agent environment stuff as universal variables, so it
# takes effect across all shells.

set AGENT_INFO ~/.gnupg/.gpg-agent-info

function __refresh_gpg_agent_info -d "Reload $AGENT_INFO into environment"
	cat $AGENT_INFO | sed 's/=/ /' | while read key value
		set -e $key
		set -U -x $key "$value"
	end
end

if not set -q -x GPG_AGENT_INFO; and not test -f $AGENT_INFO
	gpg-agent --daemon --write-env-file $AGENT_INFO >/dev/null
end

__refresh_gpg_agent_info
