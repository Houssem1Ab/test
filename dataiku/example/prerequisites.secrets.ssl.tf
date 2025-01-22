resource "google_secret_manager_secret" "certificate" {
  secret_id = "test-certificate"
  project   = local.project_id
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "certificate" {
  secret      = google_secret_manager_secret.certificate.id
  secret_data = <<EOT
-----BEGIN CERTIFICATE-----
MIICqDCCAZACCQCzdZNgyM+fVzANBgkqhkiG9w0BAQsFADAWMRQwEgYDVQQDDAtk
c3N0ZXN0LmNvbTAeFw0yMzA4MDIwNzU1MjNaFw0zMzA3MzAwNzU1MjNaMBYxFDAS
BgNVBAMMC2Rzc3Rlc3QuY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAnF/ltnUGyguFoKD5IFh3pjne0C6kzRwRdVCpuUzooicfku2xrndR6fMpZJMl
KzgqBRLua1avWGigatrY/PZ+MQjTOmItPeWFninxYHC/nzecN+Ynko5qksoPdBMs
yCWOJCRNrJ0cZ8bgEi7bJ24pMuR0CylkshcOaeVfHixsUB5NnROSHUtkMoFEJ33V
xbi8ekIhvNDAaZtei/DCvY/opy/IxccaKw4gKi7uhzLi0ongz9QbZXkpmuAF9LVB
x6OejyqqjRYPxdR94Hpg/JBikig30ObUYRh1Vklkxx4G3I1SLC3qL02MiyLNqfav
Q0s+hmoMsTiTJ09uCOPMZUmapwIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQBFFZ4a
WII51DrJ4NaiIGwjFu/QvbQhD3do7RGAGW0rQIOUAdMsTMUDwFkAMRZl2i/oOCNa
JEZtagY/W6RCl3qA/O85rfrBkbXmlQYXF3PcDPPkXaza2C8wJStsNqOS/jPP1wIH
v4e+Xl43Xp+ZgLJ36/ChJ4hKI/wAMXaO3QTjGpyoKSKCEvHECaXLdw2p26cAS5PZ
aC4BjV8HQ+D4FqcdkFJNa99QQJa/HJ1ksHot5KrknzUIQ4VOcO4cMu43x49sZo2l
0043MbtsxOFWZqwGtYIoidlIIE370gHfPshh4rLcqZHkq4BS7Z6Aj91wb/qC5CSC
8PPJYwM7zvzp9gTz
-----END CERTIFICATE-----
    EOT
}

resource "google_secret_manager_secret" "key" {
  secret_id = "test-key"
  project   = local.project_id
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "key" {
  secret      = google_secret_manager_secret.key.id
  secret_data = <<EOT
-----BEGIN PRIVATE KEY-----
MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCcX+W2dQbKC4Wg
oPkgWHemOd7QLqTNHBF1UKm5TOiiJx+S7bGud1Hp8ylkkyUrOCoFEu5rVq9YaKBq
2tj89n4xCNM6Yi095YWeKfFgcL+fN5w35ieSjmqSyg90EyzIJY4kJE2snRxnxuAS
Ltsnbiky5HQLKWSyFw5p5V8eLGxQHk2dE5IdS2QygUQnfdXFuLx6QiG80MBpm16L
8MK9j+inL8jFxxorDiAqLu6HMuLSieDP1BtleSma4AX0tUHHo56PKqqNFg/F1H3g
emD8kGKSKDfQ5tRhGHVWSWTHHgbcjVIsLeovTYyLIs2p9q9DSz6GagyxOJMnT24I
48xlSZqnAgMBAAECggEBAJdI/8hht8vJEeKxWdQ9QqSC4FmwhqgZO5qwC0PGcFpQ
V2+inoAX2BvqsGUpJpCFqcF260rVdpalwm0ehUdWggeWbiTRzstPPtIh6fBPpFO5
TV2XQTm8psaUzhaSZoTMMJQuuycAaPbNpQJyanvfS+R8uPgDd/QD8mHpEvjyKWfo
Jgd/k3T0X2SAHOUf+R2GjCVYXtjWp/j/QgzBJmow1HIvmken+d2hKtPjgd2g9Kce
k89uebPHiKLBjXrmn/e2WVZmTBhs4PKZH9jEDlGTCuiMcSLLE5kl4nhYwIYkX990
fBtCTNYByPPY0qrN0pfrWIgOxX62Dy/f713aDz1KQ2ECgYEAzgw1DWQwCf3PkjA3
yNcNH3NNsAnRYkSDTBT6zP081xrukx9qJpKiKAc0ZC8sqZ6GL6EUClSUF4jNf8JW
ZYTNZED5fpBtkfTj8U+g8uuvBOvgR8Vp1+F9gZuGE4Ku7Kkma9XyfMJ4nO9USMJf
DPFyDBm0DVj5iXYXAnEyYPy7VGsCgYEAwkjdPy1j8m+c3yZVF/ke/C+ODMEbXoiu
Ncka3fK/xCi8WsAU4d82flN4Cb/w1MN3I7aQ3uCqKxxRq9uPzPkugGlLPqExy/AR
unEEbQ7bJV32ToceYj69Qc7GxSaiBDRivBajZ0EiZcIj/jpcdA7VJDLUqSkCFB4c
JNzcBRkngbUCgYEAjo4HjnJIgkEmAUB29+9BVwcRMsA4K0K3jEXflz+FflVVxlgv
uuwsYIFLkBzLS7cvo3hQQy1tIDM36jJsT+Rnrfr+IsCN7jN+GRA8jJTfDAqdq0o8
Bm4txSPyyUDbAUWuHWFyWTq68+jpaUWBOZU6kICf/7QVQTOAi+IBNvTkLm0CgYEA
tIR5NgNZs1/rNRfrxruNA6q35LfkU0DSBV2XHhQ4A+4JnJSOkpQQkO3DQePaxAXe
BAvUrZG36xiD9heqlDwO7fdnl4i0uRWVk1MBVseP7TdR7QL0wzoiJSwYWgScUyXN
e4/ZQc4uRLhPMx9M2fUSK3EjUQ2uRbz4T3P65q3JnGUCgYBkgnWFPaRf1b3muNCK
L+9bJiL/+zOBDwEzWwMC0aU/XZCj1O3HffU1jMoEEx6wLT8cHp6H/6yS/+KEKbo0
aWOJ3GAoUeF/uZcKX6IbQpAausd6iTGi1iNomOPRO//qFxHGdSAkkxPS66i3c5Zs
c6r3L7d/xrPG3MXTP5DBtOR6Ug==
-----END PRIVATE KEY-----
    EOT
}