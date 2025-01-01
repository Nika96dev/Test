#!/bin/bash

# -----------------------------------------------------------
# Script per generare commit automatici nel 2025
# Modifica il README.md e crea 1-4 commit casuali
# solo nei giorni lavorativi (lun-ven)
# -----------------------------------------------------------

# Funzione per verificare se una data è un giorno lavorativo
is_weekday() {
    local date=$1
    # %u: 1=Lunedi - 5=Venerdi, 6=Sabato, 7=Domenica
    [ $(date -d "$date" +%u) -le 7 ]
}

# Genera contenuto casuale per il README
generate_random_content() {
    local timestamp=$1
    echo -e "\n## Commit del $timestamp\n- Task completato: $(shuf -n 1 /usr/share/dict/words)\n- Progresso: $((RANDOM % 100))%"
}

# Imposta l'intervallo dell'anno
start_date="2025-01-01"
end_date="2025-01-25"
current_date="$start_date"

while [[ "$current_date" < "$end_date" ]] || [[ "$current_date" == "$end_date" ]]; do
    if is_weekday "$current_date"; then
        # Numero casuale di commit (1-4)
        commits=$((1 + RANDOM % 4))
        
        echo "Generating $commits commits for $current_date"
        
        for ((i=1; i<=commits; i++)); do
            # Genera timestamp casuale nell'orario lavorativo (9:00-18:00)
            hour=$(printf "%02d" $((9 + RANDOM % 9)))
            minute=$(printf "%02d" $((RANDOM % 60)))
            second=$(printf "%02d" $((RANDOM % 60)))
            timestamp="$current_date $hour:$minute:$second"
            
            # Modifica il README.md
            generate_random_content "$timestamp" >> README.md
            
            # Esegui lo script di auto-commit
            ./auto_commit.sh "Update: $(date -d "$timestamp" +'%A %d %B')" "$timestamp"
        done
    fi
    
    # Passa al giorno successivo
    current_date=$(date -d "$current_date + 1 day" +%F)
done

echo "Commit generation completed!"