#Toy RSA implementation and client

This isn't meant for any serious encryption, and should be used for educational purposes ONLY.

##Usage
(prefix everything with 'ruby', of course)
  rsa_client gen : generate public and private keys as a hash
  rsa_client enc <message> -n <public_key[:n]> -e <public_key[:e]> : encrypt given message with the public key parts
  rsa_client dec <secret> -n <private_key[:n]> -d <private_key[:d]> : decrypt given secret with the private key parts

##License
MIT License
