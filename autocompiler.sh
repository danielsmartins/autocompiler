#!/bin/bash

if [ $# -eq 0 ]; then

    ARQUIVOS_CPP=$(find . -maxdepth 1 -name "*.cpp" -type f)
    if [ -z "$ARQUIVOS_CPP" ]; then
        echo "Nenhum arquivo .cpp encontrado no diretório atual."
        exit 1
    fi
else
    ARQUIVOS_CPP="$@"
fi


echo "Monitorando os seguintes arquivos:"
for ARQUIVO in $ARQUIVOS_CPP; do
    echo "- $ARQUIVO"
done
echo ""


declare -A ULTIMO_MOD


for ARQUIVO in $ARQUIVOS_CPP; do
    if [ -f "$ARQUIVO" ]; then
        ULTIMO_MOD["$ARQUIVO"]=0
    else
        echo "Arquivo não encontrado: $ARQUIVO"
        echo "Arquivos .cpp na pasta atual:"
        find . -maxdepth 1 -name "*.cpp" -type f
        exit 1
    fi
done

echo "Iniciando monitoramento... (Pressione Ctrl+C para parar)"

while true; do
    for ARQUIVO in $ARQUIVOS_CPP; do
        
        ATUAL_MOD=$(stat -c %Y "$ARQUIVO" 2>/dev/null || echo 0)

        
        if ((ATUAL_MOD > ULTIMO_MOD["$ARQUIVO"])); then
            echo "Detectada alteração em: $ARQUIVO"
            echo "Recompilando..."

            
            EXECUTAVEL="${ARQUIVO%.cpp}"

            
            if g++ "$ARQUIVO" -o "$EXECUTAVEL"; then
                echo "✓ Compilação bem-sucedida: $ARQUIVO -> $EXECUTAVEL"
                
                ULTIMO_MOD["$ARQUIVO"]=$ATUAL_MOD
            else
                echo "✗ Erro na compilação de $ARQUIVO"
            fi
            echo ""
        fi
    done
    sleep 5
done