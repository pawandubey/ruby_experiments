# The keys for the RSA algorithm are generated the following way:
#
#     Choose two distinct prime numbers p and q.
#         For security purposes, the integers p and q should be chosen at random,
#         and should be similar in magnitude but 'differ in length by a
#         few digits'[2] to make factoring harder. Prime integers can be efficiently found using a primality test.
#     Compute n = pq.
#         n is used as the modulus for both the public and private keys. Its length, usually expressed in bits, is the key length.
#     Compute φ(n) = φ(p)φ(q) = (p − 1)(q − 1) = n - (p + q -1), where φ is Euler's totient function. This value is kept private.
#     Choose an integer e such that 1 < e < φ(n) and gcd(e, φ(n)) = 1; i.e., e and φ(n) are coprime.
#         e is released as the public key exponent.
#         e having a short bit-length and small Hamming weight results in more
#         efficient encryption – most commonly 216 + 1 = 65,537. However, much
#         smaller values of e (such as 3) have been shown to be less secure in some settings.[8]
#     Determine d as d ≡ e−1 (mod φ(n)); i.e., d is the modular multiplicative inverse of e (modulo φ(n)).
#
#             This is more clearly stated as: solve for d given d⋅e ≡ 1 (mod φ(n))
#             d is kept as the private key exponent.
#
# The public key consists of the modulus n and the public (or encryption) exponent e. The private key
# consists of the modulus n and the private (or decryption) exponent d, which must be kept secret. p, q,
# and φ(n) must also be kept secret because they can be used to calculate d.
require 'prime'
#require 'random'

class RSA

  def encrypt(message, public_key)
    modular_power(message,public_key[:e],public_key[:n])
  end

  def decrypt(secret, private_key)
    modular_power(secret,private_key[:d],private_key[:n])
  end

  def generate_keys
    p = generate_random_prime
    q = generate_random_prime

    n = p * q
    totient = (p - 1) * (q - 1)

    e = find_coprime(totient)
    d = mod_inverse(e, totient)

    @public_key = { :n => n, :e => e }
    @private_key = { :n => n, :d => d }

    keys = { :public_key => @public_key, :private_key => @private_key }
  end

  private
  def modular_power(base, exponent, modulus)
    result = 1
    while exponent > 0
      if exponent % 2 == 1
        result = (result * base) % modulus
      end
      exponent >>= 1
      base = (base ** 2) % modulus
    end
    result
  end

  def generate_random_prime
    prng = Random.new
    p = prng.rand((1000000)..(100000000))
    while(!Prime.prime?(p))
      p = prng.rand((1000000)..(100000000))
    end
    p
  end

  def find_coprime(number)
    # (number-1).downto 1 do |i|
    #   return i if number.gcd(i) == 1
    # end
    prng = Random.new

    coprime = prng.rand(1..number-1)
    while number.gcd(coprime) != 1
      coprime = prng.rand(1..number-1)
    end
    coprime
  end

  # Modular inverse with Extended Euclidean Method, taken from Wikipedia
  def mod_inverse(a,m)
    t, newt, r, newr = [0, 1, m, a]

    while newr != 0
      quotient = r / newr
      t, newt = [newt, t - quotient * newt]
      r, newr = [newr, r - quotient * newr]
    end

    t < 0 ? t + m : t
  end

end
