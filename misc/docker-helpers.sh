#! /bin/bash
#
# Docker CLI helpers
#

source /usr/share/bash-completion/bash_completion

dock() {(
    _usage() {
        echo "dock"
        echo "Usage: dock command [options]"
        echo "       dock help command [options]  !!! not implemented !!!"
        echo ""
        echo "Commands:"
        echo "list            - list up docker containers"
        echo "ip              - list up docker container\'s ip"
        echo "env             - show target environment variables"
        echo "delete-stops    - remove stoped containers"
        echo "delete-olds     - remove old containers (one week)"
        return 0
    }

    _dock() {
        printf "%s" "$(docker ps -l -q)" ;
        return 0
    }

    # show docks
    _dock_list_help() {
        echo 'Not Implemented'
        return 1
    }
    _dock_list() {
        echo $(_dock)
        return 0
    }

    # show docks ip
    _dock_ip_help() {
        echo 'Not Implemented'
        return 1
    }
    _dock_ip() {
        echo $(docker inspect $(_dock) | grep IPAddress | cut -d \" -f 4)
        return 0
    }

    # show dock env
    _dock_env_help() {
        echo 'Not Implemented'
        return 1
    }
    _dock_env() {
        echo "${1}"
        docker run -rm "${1}" env
        return 0
    }

    # delete stoped containers
    _dock_delete_stops_help() {
        echo 'Not Implemented'
        return 1
    }
    _dock_delete_stops() {
        docker rm $(docker ps -a -q)
    }

    # delete old containers
    _dock_delete_olds_help() {
        echo 'Not Implemented'
        return 1
    }
    _dock_delete_olds() {
        docker ps -a | grep 'weeks ago' | awk '{print $1}' | xargs docker rm
        return 0
    }

    _dock_helps() {
        case "${1}" in
            'list') _dock_list_help ;;
            'ip') _dock_ip_help ;;
            'env') _dock_env_help ;;
            'delete-stops') _delete_stops_help ;;
            'delete-olds') _delete-olds_help ;;
            *) _usage ;;
        esac
        return 0
    }

    case "${1}" in
        'list') _dock_list ;;
        'ip') _dock_ip ;;
        'env') _dock_env "${2}" ;;
        'delete-stops') _dock_delete_stops ;;
        'delete-olds') _dock_delete_olds ;;
        # dependencies)
        #     docker images -viz | dot -Tpng -o docker.png
        #     ;;
        'help') _dock_helps "${2}" ;;
        *) _usage ;;
    esac
    return 0
)}

_dock() {
    cur=${COMP_WORDS[COMP_CWORD]}
    prev=${COMP_WORDS[COMP_CWORD-1]}
    if [[ $COMP_CWORD -eq 1 ]] ; then
        COMPREPLY=( $( compgen -W 'list ip env delete-stops delete-olds help' $cur ) )
    fi
}
complete -F _dock dock
