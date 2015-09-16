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
