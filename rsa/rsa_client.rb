#Client script for the accompanying RSA implementation
require_relative 'rsa'

usage = <<-END
RSA implementation client by Pawan Dubey, 2016
Meant for educational purposes only. Should NEVER be used for any serious encryption. The creator bears no liability for any consequences of running this program.

Usage: (prefix everything with 'ruby', of course)
  rsa_client gen : generate public and private keys as a hash
  rsa_client enc <message> -n <public_key[:n]> -e <public_key[:e]> : encrypt given message with the public key parts
  rsa_client dec <secret> -n <private_key[:n]> -d <private_key[:d]> : decrypt given secret with the private key parts
END

exit if ARGV.size == 0

cipher = RSA.new

if ARGV.size == 1 && ARGV[0] == 'gen'
  keys = cipher.generate_keys
  puts "Keys: #{keys}"

elsif ARGV.size == 1 && ARGV[0] != 'gen'
  puts usage

elsif ARGV.size > 2
  if ARGV.include?('enc')
    message = ARGV[1].to_i
    n = ARGV  [ARGV.index('-n') + 1].to_i
    e = ARGV[ARGV.index('-e') + 1].to_i

    puts cipher.encrypt(message,{ :n => n, :e => e })

  elsif ARGV.include?('dec')
    secret = ARGV[1].to_i
    n = ARGV[ARGV.index('-n') + 1].to_i
    d = ARGV[ARGV.index('-d') + 1].to_i

    puts cipher.decrypt(secret, { :n => n, :d => d})
  else
    puts "Invalid options. Try again."
    puts usage
  end
end
