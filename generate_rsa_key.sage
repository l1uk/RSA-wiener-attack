def rand_primes(size):
    """Generates random primes with q < p < 2q. Taken from https://github.com/mseckept/generalized-wiener-attack"""
    p = random_prime(1 << (size - 1), 1 << size)
    while True:
        q = random_prime(1 << (size - 1), 1 << size)
        if p < q:
            p, q = q, p
            if q < p < 2*q:
                break

    return p, q
def generate_vulnerable_rsa_key(bits=256):
    """
    Generates a large, vulnerable RSA key pair.
    """
    print(f"--- 1. Generating a Vulnerable {bits}-bit RSA Key ---")

    # Generate large random primes, satifying q < p < 2q
    p, q = rand_primes(bits//2);
    n = p * q
    phi_n = (p - 1) * (q - 1)

    # Calculate the maximum d allowed by Wiener's condition: d < (1/3) * n^(1/4)
    max_d = Integer(round(1/3 * n**(1/4)))

    # Choose a small 'd' to ensure the attack succeeds
    d = random_prime(max_d // 100, lbound=1)

    # Calculate the public exponent 'e' using the optimized modular inverse
    e = inverse_mod(d, phi_n)

    print(f"Modulus n bit length: {n.nbits()}")
    print(f"Maximum safe d (for Wiener's attack): {max_d.nbits()} bits")
    print(f"Chosen d: {d} ({d.nbits()} bits)")

    return n, e, d, p, q
