# ==============================================================================
# Bash Completion for Janus CLI
# Install path: /etc/bash_completion.d/janus (or ~/.local/share/bash-completion/completions/janus)
# ==============================================================================

_janus() {
    local cur prev words cword
    _init_completion || return

    local commands="status to-windows win windows backup update logs restart version help"

    case "$prev" in
        janus)
            COMPREPLY=( $(compgen -W "$commands" -- "$cur") )
            return 0
            ;;
        backup)
            local backup_opts="--status -s"
            COMPREPLY=( $(compgen -W "$backup_opts" -- "$cur") )
            return 0
            ;;
        logs)
            local containers
            if command -v docker >/dev/null 2>&1; then
                containers=$(docker ps --format '{{.Names}}' 2>/dev/null || true)
            fi
            if [[ -z "$containers" ]]; then
                containers="coolify coolify-proxy docmost vaultwarden postgres redis minio rabbitmq ollama open-webui uptime-kuma netdata jellyfin glitchtip wg-easy"
            fi
            COMPREPLY=( $(compgen -W "$containers" -- "$cur") )
            return 0
            ;;
        restart)
            local containers
            if command -v docker >/dev/null 2>&1; then
                containers=$(docker ps -a --format '{{.Names}}' 2>/dev/null || true)
            fi
            if [[ -z "$containers" ]]; then
                containers="coolify-proxy docmost vaultwarden postgres redis minio rabbitmq ollama open-webui uptime-kuma netdata jellyfin glitchtip wg-easy"
            fi
            COMPREPLY=( $(compgen -W "$containers" -- "$cur") )
            return 0
            ;;
        *)
            ;;
    esac

    COMPREPLY=()
}

complete -F _janus janus
