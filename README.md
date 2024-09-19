Descrição do Projeto

Este projeto é um aplicativo de caronas desenvolvido utilizando o Flutter. O app permite que os usuários ofereçam e reservem caronas, além de acumularem pontos (kudos) que podem ser trocados por brindes. As funcionalidades incluem autenticação via e-mail, Google e número de telefone. O backend é gerenciado pelo Firebase.


Funcionalidades Implementadas

1. Publicar Carona (carona_screen.dart)
    Os usuários podem oferecer caronas.
    Informações como ponto de saída, destino e horário da carona são fornecidas.

2. Reservar Carona
    Após visualizar as caronas disponíveis, o usuário pode reservar uma carona, que será adicionada à lista de caronas reservadas.

3. Kudos e Brindes (kudos_screen.dart)
    Usuários podem visualizar seus pontos acumulados (kudos).
    Os pontos podem ser trocados por brindes, e um popup confirma o resgate, informando que as instruções foram enviadas para o e-mail do usuário.

4. Login e Cadastro (login_screen.dart)
    Login via e-mail e senha.
    Cadastro de novos usuários.
    Recuperação de senha via e-mail.
    Login via Google.
    Login via número de telefone com verificação por SMS.

5. Serviços de Autenticação
    Autenticação via Firebase (authentication.dart)
    Cadastro e login com e-mail e senha.
    Logout do usuário.
    Autenticação Google (firebase_services.dart)
    Login e logout com a conta Google do usuário.
    Autenticação por Telefone (phone_authentication.dart)
    Cadastro e login utilizando número de telefone, com verificação via SMS.
    Recuperação de Senha (forgot_password.dart)
    Envio de um e-mail com o link para resetar a senha do usuário.



Requisitos

Flutter SDK (v2.0.0 ou superior)
Firebase para autenticação e gerenciamento de usuários
Google Sign-In
Provider para gerenciamento de estado
Configuração do Firebase
Crie um projeto no Firebase Console.
Adicione o Firebase ao seu projeto Flutter seguindo esta documentação.
Habilite os seguintes serviços no Firebase:
Autenticação via e-mail e senha.
Autenticação via Google.
Autenticação via telefone.
Baixe o arquivo google-services.json (para Android) e o coloque na pasta android/app.



Instalação de dependências

Em um terminal do projeto digite as seguintes instruções:
    flutter pub get



Requisitos para Execução

1. Instalar o Flutter
    Certifique-se de ter o Flutter instalado em sua máquina. Siga as instruções no site oficial: Flutter Installation Guide

2. Configurar o Firebase
    Crie um projeto no Firebase Console.
    Ative as autenticações de Email/Password, Google e Phone em Authentication.
    Baixe o arquivo google-services.json e adicione-o à pasta android/app do projeto.

3. Emulador Android
    Instale o Android Studio.
    Crie um emulador Android:
        Device: Pixel 8
        API Level: 35
        System Image: x86_64



Tecnologias Utilizadas

Flutter: Framework principal para desenvolvimento do aplicativo.
Firebase: Autenticação de usuários e gerenciamento de dados.
Provider: Gerenciamento de estado do app.
Google Sign-In: Login rápido com contas Google.
Firebase Auth: Login por e-mail e número de telefone.



Funcionalidades Futuras
Notificações push para atualizações de caronas.
Melhorias na interface do usuário.
Integração com mapas para visualização das rotas de caronas.
