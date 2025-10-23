def wiener_attack(n, e):
    """
    Implements Wiener's attack by checking the convergents of e/n.
    """
    print("\n--- 2. Starting Wiener's Attack ---")

    # The target rational number for continued fraction expansion
    target_fraction = Rational((e, n))

    # Sage's continued_fraction() function returns the list of coefficients (a_i)
    cf_expansion = continued_fraction(target_fraction)
    print(f"Continued Fraction Expansion Coefficients (a_i): {cf_expansion}")
