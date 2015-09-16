git init
cat ~/.gitconfig
cat .git/config

git status

echo ".\#*" > .gitignore

git add .
git commit -m 'Ignore e script de aula'

touch texto1
git add -i

git add .
git commit -m 'mais um'

cat "text" > texto1
git status
# volta um commit
git reset HEAD~1 --hard
# para ver tudo, inclusive os deletados
git log --stat
git log
git reflog
# para voltar o commit deletado
git merge 8b38f9d
git log

# volta para o indice
git reset HEAD~1 --soft

## da um git add
echo "mais texto" >> texto1
touch texto2
git add texto1
git commit -m 'commit novo'
# agora quero adicionar o outro arquivo no mesmo commit
git add texto2
git commit -m 'nova mensagem' --ammend

git blame texto1

## coloca shell scripts para rodar antes ou depois de comandos do git
ls -alh .git
cd .git/hooks

# apos alteracoes
git stash
git stash list
# faz modificacoes
git stash apply # para incorporar as modificacoes
git stash clear
git stash save 'alterando alguma coisa'
git stash list
git stash apply stash@{0} # volta

git branch teste
git rebase master
