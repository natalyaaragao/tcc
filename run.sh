#!/usr/bin/env bash
set -e

echo "🚀 Instalando H5P Core"
h5p core

echo "📦 Instalando Agamotto ORIGINAL"
h5p setup h5p-agamotto

echo "🧹 Substituindo H5PEditor.PhpLibrary"
rm -rf libraries/h5p-editor-php-library
git clone https://github.com/tcc-h5p/h5p-editor-php-library.git libraries/h5p-editor-php-library
cd libraries/h5p-editor-php-library
git checkout tcc
cd ..
cd ..

echo "🧹 Substituindo H5PEditor.VerticalTabs"
rm -rf libraries/H5PEditor.VerticalTabs-*
git clone https://github.com/tcc-h5p/h5p-editor-vertical-tabs.git libraries/H5PEditor.VerticalTabs-1.3
cd libraries/H5PEditor.VerticalTabs-1.3
git checkout tcc
cd ..
cd ..

echo "🧹 Substituindo H5P.Agamotto"
rm -rf libraries/H5P.Agamotto-*
git clone https://github.com/tcc-h5p/h5p-agamotto.git libraries/h5p-agamotto
cd libraries/h5p-agamotto
git checkout tcc
# Build JS/CSS → dist/
echo "⚙️  Build h5p-agamotto com npm"
npm ci               
npm run build        
cd ../..

echo "🧹 Substituindo H5P.Question"
rm -rf libraries/H5P.Question-*
git clone https://github.com/h5p/h5p-question.git libraries/H5P.Question-1.5
cd libraries/H5P.Question-1.5
git checkout stable
cd ../..

git clone https://github.com/h5p/h5p-table.git libraries/H5P.Table-1.2
cd libraries/H5P.Table-1.2
git checkout release
cd ../..

git clone https://github.com/h5p/h5p-open-ended-question.git libraries/H5P.OpenEndedQuestion-1.0
cd libraries/H5P.OpenEndedQuestion-1.0
npm install
npm run build
cd ../..

echo "🔍 Verificando dependências finais"
h5p library check H5P.Agamotto

echo "✅ Setup completo do H5P + Agamotto"
