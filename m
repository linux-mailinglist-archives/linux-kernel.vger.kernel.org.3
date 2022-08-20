Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74A3059AFBA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234551AbiHTSnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:43:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiHTSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:37 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F494457A;
        Sat, 20 Aug 2022 11:42:27 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KDuIeM012747;
        Sat, 20 Aug 2022 18:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=8CnRVQFUpzNjBwYLAdtql14KudtUfLh4qZUdPh4sAY0=;
 b=O4eycN1G4p0L0gsUhcLU6S8G1C/hwU0YjoKgCdfrBMFEkb9XUcDm3WwITbT6ubGs0EiK
 IYaFBJCzHzvrQIFm8EyaWT0gv0GcyFK6XOJyNQ+kAELU6zlrsflBMAXwbU1QrvfxIsmj
 AMvJ+TPhLK4maJR+ZOQO7ZyCKOTEPk78XQME8+3a93GNnr0O1OqIKWstLkGdAgE8ZGRk
 9fX3cXg2zGv7bdEjhHmSosKLh12PknnFvc9OByS/m/+KWi0/iyQpV8XWqTSbBiiPgzli
 d+3MwLSxM2y4vlTRoO8ajZI4oIP/0FSeCzjtZ6/VVnOJKJwjqu4FG+ls52AuI8OiSeh3 0g== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wnjj41s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:19 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 6F0FC132DE;
        Sat, 20 Aug 2022 18:42:18 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 16244803A87;
        Sat, 20 Aug 2022 18:42:18 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 10/17] crypto: Kconfig - add submenus
Date:   Sat, 20 Aug 2022 13:41:44 -0500
Message-Id: <20220820184151.1149247-11-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
X-Proofpoint-ORIG-GUID: uc54lip0SBv3OiBIf0j1xbKQsQO37DnY
X-Proofpoint-GUID: uc54lip0SBv3OiBIf0j1xbKQsQO37DnY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208200079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert each comment section into a submenu:
  Cryptographic API
    Crypto core or helper
    Public-key cryptography
    Block ciphers
    Length-preserving ciphers and modes
    AEAD (authenticated encryption with associated data) ciphers
    Hashes, digests, and MACs
    CRCs (cyclic redundancy checks)
    Compression
    Random number generation
    Userspace interface

That helps find entries (e.g., searching for a name like SHA512 doesn't
just report the location is Main menu -> Cryptography API, leaving you
to wade through 153 entries; it points you to the Digests page).

Move entries so they fall into the correct submenus and are
better sorted.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/Kconfig | 1225 ++++++++++++++++++++++++------------------------
 1 file changed, 623 insertions(+), 602 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 8711880b31a2..0d2342f92b1c 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -21,7 +21,7 @@ menuconfig CRYPTO
 
 if CRYPTO
 
-comment "Crypto core or helper"
+menu "Crypto core or helper"
 
 config CRYPTO_FIPS
 	bool "FIPS 200 compliance"
@@ -235,7 +235,9 @@ config CRYPTO_SIMD
 config CRYPTO_ENGINE
 	tristate
 
-comment "Public-key cryptography"
+endmenu
+
+menu "Public-key cryptography"
 
 config CRYPTO_RSA
 	tristate "RSA algorithm"
@@ -316,189 +318,265 @@ config CRYPTO_CURVE25519
 	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
 
-comment "Authenticated Encryption with Associated Data"
+endmenu
 
-config CRYPTO_CCM
-	tristate "CCM support"
-	select CRYPTO_CTR
-	select CRYPTO_HASH
-	select CRYPTO_AEAD
-	select CRYPTO_MANAGER
-	help
-	  Support for Counter with CBC MAC. Required for IPsec.
+menu "Block ciphers"
 
-config CRYPTO_GCM
-	tristate "GCM/GMAC support"
-	select CRYPTO_CTR
-	select CRYPTO_AEAD
-	select CRYPTO_GHASH
-	select CRYPTO_NULL
-	select CRYPTO_MANAGER
+config CRYPTO_AES
+	tristate "AES cipher algorithms"
+	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_AES
 	help
-	  Support for Galois/Counter Mode (GCM) and Galois Message
-	  Authentication Code (GMAC). Required for IPSec.
+	  AES cipher algorithms (FIPS-197). AES uses the Rijndael
+	  algorithm.
 
-config CRYPTO_CHACHA20POLY1305
-	tristate "ChaCha20-Poly1305 AEAD support"
-	select CRYPTO_CHACHA20
-	select CRYPTO_POLY1305
-	select CRYPTO_AEAD
-	select CRYPTO_MANAGER
-	help
-	  ChaCha20-Poly1305 AEAD support, RFC7539.
+	  Rijndael appears to be consistently a very good performer in
+	  both hardware and software across a wide range of computing
+	  environments regardless of its use in feedback or non-feedback
+	  modes. Its key setup time is excellent, and its key agility is
+	  good. Rijndael's very low memory requirements make it very well
+	  suited for restricted-space environments, in which it also
+	  demonstrates excellent performance. Rijndael's operations are
+	  among the easiest to defend against power and timing attacks.
 
-	  Support for the AEAD wrapper using the ChaCha20 stream cipher combined
-	  with the Poly1305 authenticator. It is defined in RFC7539 for use in
-	  IETF protocols.
+	  The AES specifies three key sizes: 128, 192 and 256 bits
 
-config CRYPTO_AEGIS128
-	tristate "AEGIS-128 AEAD algorithm"
-	select CRYPTO_AEAD
-	select CRYPTO_AES  # for AES S-box tables
+	  See <http://csrc.nist.gov/CryptoToolkit/aes/> for more information.
+
+config CRYPTO_AES_TI
+	tristate "Fixed time AES cipher"
+	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_AES
 	help
-	 Support for the AEGIS-128 dedicated AEAD algorithm.
+	  This is a generic implementation of AES that attempts to eliminate
+	  data dependent latencies as much as possible without affecting
+	  performance too much. It is intended for use by the generic CCM
+	  and GCM drivers, and other CTR or CMAC/XCBC based modes that rely
+	  solely on encryption (although decryption is supported as well, but
+	  with a more dramatic performance hit)
 
-config CRYPTO_AEGIS128_SIMD
-	bool "Support SIMD acceleration for AEGIS-128"
-	depends on CRYPTO_AEGIS128 && ((ARM || ARM64) && KERNEL_MODE_NEON)
-	default y
+	  Instead of using 16 lookup tables of 1 KB each, (8 for encryption and
+	  8 for decryption), this implementation only uses just two S-boxes of
+	  256 bytes each, and attempts to eliminate data dependent latencies by
+	  prefetching the entire table into the cache at the start of each
+	  block. Interrupts are also disabled to avoid races where cachelines
+	  are evicted when the CPU is interrupted to do something else.
 
-config CRYPTO_SEQIV
-	tristate "Sequence Number IV Generator"
-	select CRYPTO_AEAD
-	select CRYPTO_SKCIPHER
-	select CRYPTO_NULL
-	select CRYPTO_RNG_DEFAULT
-	select CRYPTO_MANAGER
+config CRYPTO_ANUBIS
+	tristate "Anubis cipher algorithm"
+	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
+	select CRYPTO_ALGAPI
 	help
-	  This IV generator generates an IV based on a sequence number by
-	  xoring it with a salt.  This algorithm is mainly useful for CTR
+	  Anubis cipher algorithm.
 
-config CRYPTO_ECHAINIV
-	tristate "Encrypted Chain IV Generator"
-	select CRYPTO_AEAD
-	select CRYPTO_NULL
-	select CRYPTO_RNG_DEFAULT
-	select CRYPTO_MANAGER
-	help
-	  This IV generator generates an IV based on the encryption of
-	  a sequence number xored with a salt.  This is the default
-	  algorithm for CBC.
+	  Anubis is a variable key length cipher which can use keys from
+	  128 bits to 320 bits in length.  It was evaluated as a entrant
+	  in the NESSIE competition.
 
-comment "Block modes"
+	  See also:
+	  <https://www.cosic.esat.kuleuven.be/nessie/reports/>
+	  <http://www.larc.usp.br/~pbarreto/AnubisPage.html>
 
-config CRYPTO_CBC
-	tristate "CBC support"
-	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
+config CRYPTO_ARIA
+	tristate "ARIA cipher algorithm"
+	select CRYPTO_ALGAPI
 	help
-	  CBC: Cipher Block Chaining mode
-	  This block cipher algorithm is required for IPSec.
+	  ARIA cipher algorithm (RFC5794).
 
-config CRYPTO_CFB
-	tristate "CFB support"
-	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
-	help
-	  CFB: Cipher FeedBack mode
-	  This block cipher algorithm is required for TPM2 Cryptography.
+	  ARIA is a standard encryption algorithm of the Republic of Korea.
+	  The ARIA specifies three key sizes and rounds.
+	  128-bit: 12 rounds.
+	  192-bit: 14 rounds.
+	  256-bit: 16 rounds.
 
-config CRYPTO_CTR
-	tristate "CTR support"
-	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
-	help
-	  CTR: Counter mode
-	  This block cipher algorithm is required for IPSec.
+	  See also:
+	  <https://seed.kisa.or.kr/kisa/algorithm/EgovAriaInfo.do>
 
-config CRYPTO_CTS
-	tristate "CTS support"
-	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
+config CRYPTO_BLOWFISH
+	tristate "Blowfish cipher algorithm"
+	select CRYPTO_ALGAPI
+	select CRYPTO_BLOWFISH_COMMON
 	help
-	  CTS: Cipher Text Stealing
-	  This is the Cipher Text Stealing mode as described by
-	  Section 8 of rfc2040 and referenced by rfc3962
-	  (rfc3962 includes errata information in its Appendix A) or
-	  CBC-CS3 as defined by NIST in Sp800-38A addendum from Oct 2010.
-	  This mode is required for Kerberos gss mechanism support
-	  for AES encryption.
+	  Blowfish cipher algorithm, by Bruce Schneier.
 
-	  See: https://csrc.nist.gov/publications/detail/sp/800-38a/addendum/final
+	  This is a variable key length cipher which can use keys from 32
+	  bits to 448 bits in length.  It's fast, simple and specifically
+	  designed for use on "large microprocessors".
 
-config CRYPTO_ECB
-	tristate "ECB support"
-	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
+	  See also:
+	  <https://www.schneier.com/blowfish.html>
+
+config CRYPTO_BLOWFISH_COMMON
+	tristate
 	help
-	  ECB: Electronic CodeBook mode
-	  This is the simplest block cipher algorithm.  It simply encrypts
-	  the input block by block.
+	  Common parts of the Blowfish cipher algorithm shared by the
+	  generic c and the assembler implementations.
 
-config CRYPTO_LRW
-	tristate "LRW support"
-	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
-	select CRYPTO_GF128MUL
-	select CRYPTO_ECB
+	  See also:
+	  <https://www.schneier.com/blowfish.html>
+
+config CRYPTO_CAMELLIA
+	tristate "Camellia cipher algorithms"
+	select CRYPTO_ALGAPI
 	help
-	  LRW: Liskov Rivest Wagner, a tweakable, non malleable, non movable
-	  narrow block cipher mode for dm-crypt.  Use it with cipher
-	  specification string aes-lrw-benbi, the key must be 256, 320 or 384.
-	  The first 128, 192 or 256 bits in the key are used for AES and the
-	  rest is used to tie each cipher block to its logical position.
+	  Camellia cipher algorithms module.
 
-config CRYPTO_OFB
-	tristate "OFB support"
-	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
+	  Camellia is a symmetric key block cipher developed jointly
+	  at NTT and Mitsubishi Electric Corporation.
+
+	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
+
+	  See also:
+	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+
+config CRYPTO_CAST_COMMON
+	tristate
 	help
-	  OFB: the Output Feedback mode makes a block cipher into a synchronous
-	  stream cipher. It generates keystream blocks, which are then XORed
-	  with the plaintext blocks to get the ciphertext. Flipping a bit in the
-	  ciphertext produces a flipped bit in the plaintext at the same
-	  location. This property allows many error correcting codes to function
-	  normally even when applied before encryption.
+	  Common parts of the CAST cipher algorithms shared by the
+	  generic c and the assembler implementations.
 
-config CRYPTO_PCBC
-	tristate "PCBC support"
-	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
+config CRYPTO_CAST5
+	tristate "CAST5 (CAST-128) cipher algorithm"
+	select CRYPTO_ALGAPI
+	select CRYPTO_CAST_COMMON
 	help
-	  PCBC: Propagating Cipher Block Chaining mode
-	  This block cipher algorithm is required for RxRPC.
+	  The CAST5 encryption algorithm (synonymous with CAST-128) is
+	  described in RFC2144.
 
-config CRYPTO_XCTR
-	tristate
-	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
+config CRYPTO_CAST6
+	tristate "CAST6 (CAST-256) cipher algorithm"
+	select CRYPTO_ALGAPI
+	select CRYPTO_CAST_COMMON
 	help
-	  XCTR: XOR Counter mode. This blockcipher mode is a variant of CTR mode
-	  using XORs and little-endian addition rather than big-endian arithmetic.
-	  XCTR mode is used to implement HCTR2.
+	  The CAST6 encryption algorithm (synonymous with CAST-256) is
+	  described in RFC2612.
 
-config CRYPTO_XTS
-	tristate "XTS support"
-	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
-	select CRYPTO_ECB
+config CRYPTO_DES
+	tristate "DES and Triple DES EDE cipher algorithms"
+	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_DES
 	help
-	  XTS: IEEE1619/D16 narrow block cipher use with aes-xts-plain,
-	  key size 256, 384 or 512 bits. This implementation currently
-	  can't handle a sectorsize which is not a multiple of 16 bytes.
+	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
 
-config CRYPTO_KEYWRAP
-	tristate "Key wrapping support"
+config CRYPTO_FCRYPT
+	tristate "FCrypt cipher algorithm"
+	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
-	select CRYPTO_MANAGER
 	help
-	  Support for key wrapping (NIST SP800-38F / RFC3394) without
-	  padding.
+	  FCrypt algorithm used by RxRPC.
 
-config CRYPTO_NHPOLY1305
-	tristate
-	select CRYPTO_HASH
-	select CRYPTO_LIB_POLY1305_GENERIC
+config CRYPTO_KHAZAD
+	tristate "Khazad cipher algorithm"
+	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
+	select CRYPTO_ALGAPI
+	help
+	  Khazad cipher algorithm.
+
+	  Khazad was a finalist in the initial NESSIE competition.  It is
+	  an algorithm optimized for 64-bit processors with good performance
+	  on 32-bit processors.  Khazad uses an 128 bit key size.
+
+	  See also:
+	  <http://www.larc.usp.br/~pbarreto/KhazadPage.html>
+
+config CRYPTO_SEED
+	tristate "SEED cipher algorithm"
+	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
+	select CRYPTO_ALGAPI
+	help
+	  SEED cipher algorithm (RFC4269).
+
+	  SEED is a 128-bit symmetric key block cipher that has been
+	  developed by KISA (Korea Information Security Agency) as a
+	  national standard encryption algorithm of the Republic of Korea.
+	  It is a 16 round block cipher with the key size of 128 bit.
+
+	  See also:
+	  <http://www.kisa.or.kr/kisa/seed/jsp/seed_eng.jsp>
+
+config CRYPTO_SERPENT
+	tristate "Serpent cipher algorithm"
+	select CRYPTO_ALGAPI
+	help
+	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+
+	  Keys are allowed to be from 0 to 256 bits in length, in steps
+	  of 8 bits.
+
+	  See also:
+	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+
+config CRYPTO_SM4
+	tristate
+
+config CRYPTO_SM4_GENERIC
+	tristate "SM4 cipher algorithm"
+	select CRYPTO_ALGAPI
+	select CRYPTO_SM4
+	help
+	  SM4 cipher algorithms (OSCCA GB/T 32907-2016).
+
+	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
+	  Organization of State Commercial Administration of China (OSCCA)
+	  as an authorized cryptographic algorithms for the use within China.
+
+	  SMS4 was originally created for use in protecting wireless
+	  networks, and is mandated in the Chinese National Standard for
+	  Wireless LAN WAPI (Wired Authentication and Privacy Infrastructure)
+	  (GB.15629.11-2003).
+
+	  The latest SM4 standard (GBT.32907-2016) was proposed by OSCCA and
+	  standardized through TC 260 of the Standardization Administration
+	  of the People's Republic of China (SAC).
+
+	  The input, output, and key of SMS4 are each 128 bits.
+
+	  See also: <https://eprint.iacr.org/2008/329.pdf>
+
+	  If unsure, say N.
+
+config CRYPTO_TEA
+	tristate "TEA, XTEA and XETA cipher algorithms"
+	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
+	select CRYPTO_ALGAPI
+	help
+	  TEA cipher algorithm.
+
+	  Tiny Encryption Algorithm is a simple cipher that uses
+	  many rounds for security.  It is very fast and uses
+	  little memory.
+
+	  Xtendend Tiny Encryption Algorithm is a modification to
+	  the TEA algorithm to address a potential key weakness
+	  in the TEA algorithm.
+
+	  Xtendend Encryption Tiny Algorithm is a mis-implementation
+	  of the XTEA algorithm for compatibility purposes.
+
+config CRYPTO_TWOFISH
+	tristate "Twofish cipher algorithm"
+	select CRYPTO_ALGAPI
+	select CRYPTO_TWOFISH_COMMON
+	help
+	  Twofish cipher algorithm.
+
+	  Twofish was submitted as an AES (Advanced Encryption Standard)
+	  candidate cipher by researchers at CounterPane Systems.  It is a
+	  16 round block cipher supporting key sizes of 128, 192, and 256
+	  bits.
+
+	  See also:
+	  <https://www.schneier.com/twofish.html>
+
+config CRYPTO_TWOFISH_COMMON
+	tristate
+	help
+	  Common parts of the Twofish cipher algorithm shared by the
+	  generic c and the assembler implementations.
+
+endmenu
+
+menu "Length-preserving ciphers and modes"
 
 config CRYPTO_ADIANTUM
 	tristate "Adiantum support"
@@ -524,580 +602,516 @@ config CRYPTO_ADIANTUM
 
 	  If unsure, say N.
 
-config CRYPTO_HCTR2
-	tristate "HCTR2 support"
-	select CRYPTO_XCTR
-	select CRYPTO_POLYVAL
-	select CRYPTO_MANAGER
+config CRYPTO_ARC4
+	tristate "ARC4 cipher algorithm"
+	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_ARC4
 	help
-	  HCTR2 is a length-preserving encryption mode for storage encryption that
-	  is efficient on processors with instructions to accelerate AES and
-	  carryless multiplication, e.g. x86 processors with AES-NI and CLMUL, and
-	  ARM processors with the ARMv8 crypto extensions.
+	  ARC4 cipher algorithm.
 
-config CRYPTO_ESSIV
-	tristate "ESSIV support for block encryption"
-	select CRYPTO_AUTHENC
+	  ARC4 is a stream cipher using keys ranging from 8 bits to 2048
+	  bits in length.  This algorithm is required for driver-based
+	  WEP, but it should not be for other purposes because of the
+	  weakness of the algorithm.
+
+config CRYPTO_CHACHA20
+	tristate "ChaCha stream cipher algorithms"
+	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_SKCIPHER
 	help
-	  Encrypted salt-sector initialization vector (ESSIV) is an IV
-	  generation method that is used in some cases by fscrypt and/or
-	  dm-crypt. It uses the hash of the block encryption key as the
-	  symmetric key for a block encryption pass applied to the input
-	  IV, making low entropy IV sources more suitable for block
-	  encryption.
+	  The ChaCha20, XChaCha20, and XChaCha12 stream cipher algorithms.
 
-	  This driver implements a crypto API template that can be
-	  instantiated either as an skcipher or as an AEAD (depending on the
-	  type of the first template argument), and which defers encryption
-	  and decryption requests to the encapsulated cipher after applying
-	  ESSIV to the input IV. Note that in the AEAD case, it is assumed
-	  that the keys are presented in the same format used by the authenc
-	  template, and that the IV appears at the end of the authenticated
-	  associated data (AAD) region (which is how dm-crypt uses it.)
+	  ChaCha20 is a 256-bit high-speed stream cipher designed by Daniel J.
+	  Bernstein and further specified in RFC7539 for use in IETF protocols.
+	  This is the portable C implementation of ChaCha20.  See also:
+	  <https://cr.yp.to/chacha/chacha-20080128.pdf>
 
-	  Note that the use of ESSIV is not recommended for new deployments,
-	  and so this only needs to be enabled when interoperability with
-	  existing encrypted volumes of filesystems is required, or when
-	  building for a particular system that requires it (e.g., when
-	  the SoC in question has accelerated CBC but not XTS, making CBC
-	  combined with ESSIV the only feasible mode for h/w accelerated
-	  block encryption)
+	  XChaCha20 is the application of the XSalsa20 construction to ChaCha20
+	  rather than to Salsa20.  XChaCha20 extends ChaCha20's nonce length
+	  from 64 bits (or 96 bits using the RFC7539 convention) to 192 bits,
+	  while provably retaining ChaCha20's security.  See also:
+	  <https://cr.yp.to/snuffle/xsalsa-20081128.pdf>
 
-comment "Hash modes"
+	  XChaCha12 is XChaCha20 reduced to 12 rounds, with correspondingly
+	  reduced security margin but increased performance.  It can be needed
+	  in some performance-sensitive scenarios.
 
-config CRYPTO_CMAC
-	tristate "CMAC support"
-	select CRYPTO_HASH
+config CRYPTO_CBC
+	tristate "CBC support"
+	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  Cipher-based Message Authentication Code (CMAC) specified by
-	  The National Institute of Standards and Technology (NIST).
-
-	  https://tools.ietf.org/html/rfc4493
-	  http://csrc.nist.gov/publications/nistpubs/800-38B/SP_800-38B.pdf
+	  CBC: Cipher Block Chaining mode
+	  This block cipher algorithm is required for IPSec.
 
-config CRYPTO_HMAC
-	tristate "HMAC support"
-	select CRYPTO_HASH
+config CRYPTO_CFB
+	tristate "CFB support"
+	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  HMAC: Keyed-Hashing for Message Authentication (RFC2104).
-	  This is required for IPSec.
+	  CFB: Cipher FeedBack mode
+	  This block cipher algorithm is required for TPM2 Cryptography.
 
-config CRYPTO_XCBC
-	tristate "XCBC support"
-	select CRYPTO_HASH
+config CRYPTO_CTR
+	tristate "CTR support"
+	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  XCBC: Keyed-Hashing with encryption algorithm
-		https://www.ietf.org/rfc/rfc3566.txt
-		http://csrc.nist.gov/encryption/modes/proposedmodes/
-		 xcbc-mac/xcbc-mac-spec.pdf
+	  CTR: Counter mode
+	  This block cipher algorithm is required for IPSec.
 
-config CRYPTO_VMAC
-	tristate "VMAC support"
-	select CRYPTO_HASH
+config CRYPTO_CTS
+	tristate "CTS support"
+	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  VMAC is a message authentication algorithm designed for
-	  very high speed on 64-bit architectures.
-
-	  See also:
-	  <https://fastcrypto.org/vmac>
+	  CTS: Cipher Text Stealing
+	  This is the Cipher Text Stealing mode as described by
+	  Section 8 of rfc2040 and referenced by rfc3962
+	  (rfc3962 includes errata information in its Appendix A) or
+	  CBC-CS3 as defined by NIST in Sp800-38A addendum from Oct 2010.
+	  This mode is required for Kerberos gss mechanism support
+	  for AES encryption.
 
-comment "Digest"
+	  See: https://csrc.nist.gov/publications/detail/sp/800-38a/addendum/final
 
-config CRYPTO_CRC32C
-	tristate "CRC32c CRC algorithm"
-	select CRYPTO_HASH
-	select CRC32
+config CRYPTO_ECB
+	tristate "ECB support"
+	select CRYPTO_SKCIPHER
+	select CRYPTO_MANAGER
 	help
-	  Castagnoli, et al Cyclic Redundancy-Check Algorithm.  Used
-	  by iSCSI for header and data digests and by others.
-	  See Castagnoli93.  Module will be crc32c.
+	  ECB: Electronic CodeBook mode
+	  This is the simplest block cipher algorithm.  It simply encrypts
+	  the input block by block.
 
-config CRYPTO_CRC32
-	tristate "CRC32 CRC algorithm"
-	select CRYPTO_HASH
-	select CRC32
+config CRYPTO_HCTR2
+	tristate "HCTR2 support"
+	select CRYPTO_XCTR
+	select CRYPTO_POLYVAL
+	select CRYPTO_MANAGER
 	help
-	  CRC-32-IEEE 802.3 cyclic redundancy-check algorithm.
-	  Shash crypto api wrappers to crc32_le function.
+	  HCTR2 is a length-preserving encryption mode for storage encryption that
+	  is efficient on processors with instructions to accelerate AES and
+	  carryless multiplication, e.g. x86 processors with AES-NI and CLMUL, and
+	  ARM processors with the ARMv8 crypto extensions.
 
-config CRYPTO_XXHASH
-	tristate "xxHash hash algorithm"
-	select CRYPTO_HASH
-	select XXHASH
-	help
-	  xxHash non-cryptographic hash algorithm. Extremely fast, working at
-	  speeds close to RAM limits.
-
-config CRYPTO_BLAKE2B
-	tristate "BLAKE2b digest algorithm"
-	select CRYPTO_HASH
-	help
-	  Implementation of cryptographic hash function BLAKE2b (or just BLAKE2),
-	  optimized for 64bit platforms and can produce digests of any size
-	  between 1 to 64.  The keyed hash is also implemented.
-
-	  This module provides the following algorithms:
-
-	  - blake2b-160
-	  - blake2b-256
-	  - blake2b-384
-	  - blake2b-512
-
-	  See https://blake2.net for further information.
-
-config CRYPTO_CRCT10DIF
-	tristate "CRCT10DIF algorithm"
-	select CRYPTO_HASH
-	help
-	  CRC T10 Data Integrity Field computation is being cast as
-	  a crypto transform.  This allows for faster crc t10 diff
-	  transforms to be used if they are available.
-
-config CRYPTO_CRC64_ROCKSOFT
-	tristate "Rocksoft Model CRC64 algorithm"
-	depends on CRC64
-	select CRYPTO_HASH
-
-config CRYPTO_GHASH
-	tristate "GHASH hash function"
-	select CRYPTO_GF128MUL
-	select CRYPTO_HASH
+config CRYPTO_KEYWRAP
+	tristate "Key wrapping support"
+	select CRYPTO_SKCIPHER
+	select CRYPTO_MANAGER
 	help
-	  GHASH is the hash function used in GCM (Galois/Counter Mode).
-	  It is not a general-purpose cryptographic hash function.
+	  Support for key wrapping (NIST SP800-38F / RFC3394) without
+	  padding.
 
-config CRYPTO_POLYVAL
-	tristate
+config CRYPTO_LRW
+	tristate "LRW support"
+	select CRYPTO_SKCIPHER
+	select CRYPTO_MANAGER
 	select CRYPTO_GF128MUL
-	select CRYPTO_HASH
+	select CRYPTO_ECB
 	help
-	  POLYVAL is the hash function used in HCTR2.  It is not a general-purpose
-	  cryptographic hash function.
+	  LRW: Liskov Rivest Wagner, a tweakable, non malleable, non movable
+	  narrow block cipher mode for dm-crypt.  Use it with cipher
+	  specification string aes-lrw-benbi, the key must be 256, 320 or 384.
+	  The first 128, 192 or 256 bits in the key are used for AES and the
+	  rest is used to tie each cipher block to its logical position.
 
-config CRYPTO_POLY1305
-	tristate "Poly1305 authenticator algorithm"
-	select CRYPTO_HASH
-	select CRYPTO_LIB_POLY1305_GENERIC
+config CRYPTO_OFB
+	tristate "OFB support"
+	select CRYPTO_SKCIPHER
+	select CRYPTO_MANAGER
 	help
-	  Poly1305 authenticator algorithm, RFC7539.
-
-	  Poly1305 is an authenticator algorithm designed by Daniel J. Bernstein.
-	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
-	  in IETF protocols. This is the portable C implementation of Poly1305.
+	  OFB: the Output Feedback mode makes a block cipher into a synchronous
+	  stream cipher. It generates keystream blocks, which are then XORed
+	  with the plaintext blocks to get the ciphertext. Flipping a bit in the
+	  ciphertext produces a flipped bit in the plaintext at the same
+	  location. This property allows many error correcting codes to function
+	  normally even when applied before encryption.
 
-config CRYPTO_MD4
-	tristate "MD4 digest algorithm"
-	select CRYPTO_HASH
+config CRYPTO_PCBC
+	tristate "PCBC support"
+	select CRYPTO_SKCIPHER
+	select CRYPTO_MANAGER
 	help
-	  MD4 message digest algorithm (RFC1320).
+	  PCBC: Propagating Cipher Block Chaining mode
+	  This block cipher algorithm is required for RxRPC.
 
-config CRYPTO_MD5
-	tristate "MD5 digest algorithm"
-	select CRYPTO_HASH
+config CRYPTO_XCTR
+	tristate
+	select CRYPTO_SKCIPHER
+	select CRYPTO_MANAGER
 	help
-	  MD5 message digest algorithm (RFC1321).
+	  XCTR: XOR Counter mode. This blockcipher mode is a variant of CTR mode
+	  using XORs and little-endian addition rather than big-endian arithmetic.
+	  XCTR mode is used to implement HCTR2.
 
-config CRYPTO_MICHAEL_MIC
-	tristate "Michael MIC keyed digest algorithm"
-	select CRYPTO_HASH
+config CRYPTO_XTS
+	tristate "XTS support"
+	select CRYPTO_SKCIPHER
+	select CRYPTO_MANAGER
+	select CRYPTO_ECB
 	help
-	  Michael MIC is used for message integrity protection in TKIP
-	  (IEEE 802.11i). This algorithm is required for TKIP, but it
-	  should not be used for other purposes because of the weakness
-	  of the algorithm.
+	  XTS: IEEE1619/D16 narrow block cipher use with aes-xts-plain,
+	  key size 256, 384 or 512 bits. This implementation currently
+	  can't handle a sectorsize which is not a multiple of 16 bytes.
 
-config CRYPTO_RMD160
-	tristate "RIPEMD-160 digest algorithm"
+config CRYPTO_NHPOLY1305
+	tristate
 	select CRYPTO_HASH
-	help
-	  RIPEMD-160 (ISO/IEC 10118-3:2004).
-
-	  RIPEMD-160 is a 160-bit cryptographic hash function. It is intended
-	  to be used as a secure replacement for the 128-bit hash functions
-	  MD4, MD5 and its predecessor RIPEMD
-	  (not to be confused with RIPEMD-128).
-
-	  It's speed is comparable to SHA1 and there are no known attacks
-	  against RIPEMD-160.
+	select CRYPTO_LIB_POLY1305_GENERIC
 
-	  Developed by Hans Dobbertin, Antoon Bosselaers and Bart Preneel.
-	  See <https://homes.esat.kuleuven.be/~bosselae/ripemd160.html>
+endmenu
 
-config CRYPTO_SHA1
-	tristate "SHA1 digest algorithm"
-	select CRYPTO_HASH
-	select CRYPTO_LIB_SHA1
-	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+menu "AEAD (authenticated encryption with associated data) ciphers"
 
-config CRYPTO_SHA256
-	tristate "SHA224 and SHA256 digest algorithm"
-	select CRYPTO_HASH
-	select CRYPTO_LIB_SHA256
+config CRYPTO_AEGIS128
+	tristate "AEGIS-128 AEAD algorithm"
+	select CRYPTO_AEAD
+	select CRYPTO_AES  # for AES S-box tables
 	help
-	  SHA256 secure hash standard (DFIPS 180-2).
-
-	  This version of SHA implements a 256 bit hash with 128 bits of
-	  security against collision attacks.
+	 Support for the AEGIS-128 dedicated AEAD algorithm.
 
-	  This code also includes SHA-224, a 224 bit hash with 112 bits
-	  of security against collision attacks.
+config CRYPTO_AEGIS128_SIMD
+	bool "Support SIMD acceleration for AEGIS-128"
+	depends on CRYPTO_AEGIS128 && ((ARM || ARM64) && KERNEL_MODE_NEON)
+	default y
 
-config CRYPTO_SHA512
-	tristate "SHA384 and SHA512 digest algorithms"
-	select CRYPTO_HASH
+config CRYPTO_CHACHA20POLY1305
+	tristate "ChaCha20-Poly1305 AEAD support"
+	select CRYPTO_CHACHA20
+	select CRYPTO_POLY1305
+	select CRYPTO_AEAD
+	select CRYPTO_MANAGER
 	help
-	  SHA512 secure hash standard (DFIPS 180-2).
-
-	  This version of SHA implements a 512 bit hash with 256 bits of
-	  security against collision attacks.
+	  ChaCha20-Poly1305 AEAD support, RFC7539.
 
-	  This code also includes SHA-384, a 384 bit hash with 192 bits
-	  of security against collision attacks.
+	  Support for the AEAD wrapper using the ChaCha20 stream cipher combined
+	  with the Poly1305 authenticator. It is defined in RFC7539 for use in
+	  IETF protocols.
 
-config CRYPTO_SHA3
-	tristate "SHA3 digest algorithm"
+config CRYPTO_CCM
+	tristate "CCM support"
+	select CRYPTO_CTR
 	select CRYPTO_HASH
+	select CRYPTO_AEAD
+	select CRYPTO_MANAGER
 	help
-	  SHA-3 secure hash standard (DFIPS 202). It's based on
-	  cryptographic sponge function family called Keccak.
-
-	  References:
-	  http://keccak.noekeon.org/
-
-config CRYPTO_SM3
-	tristate
+	  Support for Counter with CBC MAC. Required for IPsec.
 
-config CRYPTO_SM3_GENERIC
-	tristate "SM3 digest algorithm"
-	select CRYPTO_HASH
-	select CRYPTO_SM3
+config CRYPTO_GCM
+	tristate "GCM/GMAC support"
+	select CRYPTO_CTR
+	select CRYPTO_AEAD
+	select CRYPTO_GHASH
+	select CRYPTO_NULL
+	select CRYPTO_MANAGER
 	help
-	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3).
-	  It is part of the Chinese Commercial Cryptography suite.
-
-	  References:
-	  http://www.oscca.gov.cn/UpFile/20101222141857786.pdf
-	  https://datatracker.ietf.org/doc/html/draft-shen-sm3-hash
+	  Support for Galois/Counter Mode (GCM) and Galois Message
+	  Authentication Code (GMAC). Required for IPSec.
 
-config CRYPTO_STREEBOG
-	tristate "Streebog Hash Function"
-	select CRYPTO_HASH
+config CRYPTO_SEQIV
+	tristate "Sequence Number IV Generator"
+	select CRYPTO_AEAD
+	select CRYPTO_SKCIPHER
+	select CRYPTO_NULL
+	select CRYPTO_RNG_DEFAULT
+	select CRYPTO_MANAGER
 	help
-	  Streebog Hash Function (GOST R 34.11-2012, RFC 6986) is one of the Russian
-	  cryptographic standard algorithms (called GOST algorithms).
-	  This setting enables two hash algorithms with 256 and 512 bits output.
-
-	  References:
-	  https://tc26.ru/upload/iblock/fed/feddbb4d26b685903faa2ba11aea43f6.pdf
-	  https://tools.ietf.org/html/rfc6986
+	  This IV generator generates an IV based on a sequence number by
+	  xoring it with a salt.  This algorithm is mainly useful for CTR
 
-config CRYPTO_WP512
-	tristate "Whirlpool digest algorithms"
-	select CRYPTO_HASH
+config CRYPTO_ECHAINIV
+	tristate "Encrypted Chain IV Generator"
+	select CRYPTO_AEAD
+	select CRYPTO_NULL
+	select CRYPTO_RNG_DEFAULT
+	select CRYPTO_MANAGER
 	help
-	  Whirlpool hash algorithm 512, 384 and 256-bit hashes
-
-	  Whirlpool-512 is part of the NESSIE cryptographic primitives.
-	  Whirlpool will be part of the ISO/IEC 10118-3:2003(E) standard
-
-	  See also:
-	  <http://www.larc.usp.br/~pbarreto/WhirlpoolPage.html>
-
-comment "Ciphers"
+	  This IV generator generates an IV based on the encryption of
+	  a sequence number xored with a salt.  This is the default
+	  algorithm for CBC.
 
-config CRYPTO_AES
-	tristate "AES cipher algorithms"
-	select CRYPTO_ALGAPI
-	select CRYPTO_LIB_AES
+config CRYPTO_ESSIV
+	tristate "ESSIV support for block encryption"
+	select CRYPTO_AUTHENC
 	help
-	  AES cipher algorithms (FIPS-197). AES uses the Rijndael
-	  algorithm.
-
-	  Rijndael appears to be consistently a very good performer in
-	  both hardware and software across a wide range of computing
-	  environments regardless of its use in feedback or non-feedback
-	  modes. Its key setup time is excellent, and its key agility is
-	  good. Rijndael's very low memory requirements make it very well
-	  suited for restricted-space environments, in which it also
-	  demonstrates excellent performance. Rijndael's operations are
-	  among the easiest to defend against power and timing attacks.
+	  Encrypted salt-sector initialization vector (ESSIV) is an IV
+	  generation method that is used in some cases by fscrypt and/or
+	  dm-crypt. It uses the hash of the block encryption key as the
+	  symmetric key for a block encryption pass applied to the input
+	  IV, making low entropy IV sources more suitable for block
+	  encryption.
 
-	  The AES specifies three key sizes: 128, 192 and 256 bits
+	  This driver implements a crypto API template that can be
+	  instantiated either as an skcipher or as an AEAD (depending on the
+	  type of the first template argument), and which defers encryption
+	  and decryption requests to the encapsulated cipher after applying
+	  ESSIV to the input IV. Note that in the AEAD case, it is assumed
+	  that the keys are presented in the same format used by the authenc
+	  template, and that the IV appears at the end of the authenticated
+	  associated data (AAD) region (which is how dm-crypt uses it.)
 
-	  See <http://csrc.nist.gov/CryptoToolkit/aes/> for more information.
+	  Note that the use of ESSIV is not recommended for new deployments,
+	  and so this only needs to be enabled when interoperability with
+	  existing encrypted volumes of filesystems is required, or when
+	  building for a particular system that requires it (e.g., when
+	  the SoC in question has accelerated CBC but not XTS, making CBC
+	  combined with ESSIV the only feasible mode for h/w accelerated
+	  block encryption)
 
-config CRYPTO_AES_TI
-	tristate "Fixed time AES cipher"
-	select CRYPTO_ALGAPI
-	select CRYPTO_LIB_AES
-	help
-	  This is a generic implementation of AES that attempts to eliminate
-	  data dependent latencies as much as possible without affecting
-	  performance too much. It is intended for use by the generic CCM
-	  and GCM drivers, and other CTR or CMAC/XCBC based modes that rely
-	  solely on encryption (although decryption is supported as well, but
-	  with a more dramatic performance hit)
+endmenu
 
-	  Instead of using 16 lookup tables of 1 KB each, (8 for encryption and
-	  8 for decryption), this implementation only uses just two S-boxes of
-	  256 bytes each, and attempts to eliminate data dependent latencies by
-	  prefetching the entire table into the cache at the start of each
-	  block. Interrupts are also disabled to avoid races where cachelines
-	  are evicted when the CPU is interrupted to do something else.
+menu "Hashes, digests, and MACs"
 
-config CRYPTO_ANUBIS
-	tristate "Anubis cipher algorithm"
-	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
-	select CRYPTO_ALGAPI
+config CRYPTO_BLAKE2B
+	tristate "BLAKE2b digest algorithm"
+	select CRYPTO_HASH
 	help
-	  Anubis cipher algorithm.
-
-	  Anubis is a variable key length cipher which can use keys from
-	  128 bits to 320 bits in length.  It was evaluated as a entrant
-	  in the NESSIE competition.
+	  Implementation of cryptographic hash function BLAKE2b (or just BLAKE2),
+	  optimized for 64bit platforms and can produce digests of any size
+	  between 1 to 64.  The keyed hash is also implemented.
 
-	  See also:
-	  <https://www.cosic.esat.kuleuven.be/nessie/reports/>
-	  <http://www.larc.usp.br/~pbarreto/AnubisPage.html>
+	  This module provides the following algorithms:
 
-config CRYPTO_ARC4
-	tristate "ARC4 cipher algorithm"
-	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
-	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_ARC4
-	help
-	  ARC4 cipher algorithm.
+	  - blake2b-160
+	  - blake2b-256
+	  - blake2b-384
+	  - blake2b-512
 
-	  ARC4 is a stream cipher using keys ranging from 8 bits to 2048
-	  bits in length.  This algorithm is required for driver-based
-	  WEP, but it should not be for other purposes because of the
-	  weakness of the algorithm.
+	  See https://blake2.net for further information.
 
-config CRYPTO_BLOWFISH
-	tristate "Blowfish cipher algorithm"
-	select CRYPTO_ALGAPI
-	select CRYPTO_BLOWFISH_COMMON
+config CRYPTO_CMAC
+	tristate "CMAC support"
+	select CRYPTO_HASH
+	select CRYPTO_MANAGER
 	help
-	  Blowfish cipher algorithm, by Bruce Schneier.
-
-	  This is a variable key length cipher which can use keys from 32
-	  bits to 448 bits in length.  It's fast, simple and specifically
-	  designed for use on "large microprocessors".
+	  Cipher-based Message Authentication Code (CMAC) specified by
+	  The National Institute of Standards and Technology (NIST).
 
-	  See also:
-	  <https://www.schneier.com/blowfish.html>
+	  https://tools.ietf.org/html/rfc4493
+	  http://csrc.nist.gov/publications/nistpubs/800-38B/SP_800-38B.pdf
 
-config CRYPTO_BLOWFISH_COMMON
-	tristate
+config CRYPTO_GHASH
+	tristate "GHASH hash function"
+	select CRYPTO_GF128MUL
+	select CRYPTO_HASH
 	help
-	  Common parts of the Blowfish cipher algorithm shared by the
-	  generic c and the assembler implementations.
-
-	  See also:
-	  <https://www.schneier.com/blowfish.html>
+	  GHASH is the hash function used in GCM (Galois/Counter Mode).
+	  It is not a general-purpose cryptographic hash function.
 
-config CRYPTO_CAMELLIA
-	tristate "Camellia cipher algorithms"
-	select CRYPTO_ALGAPI
+config CRYPTO_HMAC
+	tristate "HMAC support"
+	select CRYPTO_HASH
+	select CRYPTO_MANAGER
 	help
-	  Camellia cipher algorithms module.
-
-	  Camellia is a symmetric key block cipher developed jointly
-	  at NTT and Mitsubishi Electric Corporation.
-
-	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
-
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+	  HMAC: Keyed-Hashing for Message Authentication (RFC2104).
+	  This is required for IPSec.
 
-config CRYPTO_CAST_COMMON
-	tristate
+config CRYPTO_MD4
+	tristate "MD4 digest algorithm"
+	select CRYPTO_HASH
 	help
-	  Common parts of the CAST cipher algorithms shared by the
-	  generic c and the assembler implementations.
+	  MD4 message digest algorithm (RFC1320).
 
-config CRYPTO_CAST5
-	tristate "CAST5 (CAST-128) cipher algorithm"
-	select CRYPTO_ALGAPI
-	select CRYPTO_CAST_COMMON
+config CRYPTO_MD5
+	tristate "MD5 digest algorithm"
+	select CRYPTO_HASH
 	help
-	  The CAST5 encryption algorithm (synonymous with CAST-128) is
-	  described in RFC2144.
+	  MD5 message digest algorithm (RFC1321).
 
-config CRYPTO_CAST6
-	tristate "CAST6 (CAST-256) cipher algorithm"
-	select CRYPTO_ALGAPI
-	select CRYPTO_CAST_COMMON
+config CRYPTO_MICHAEL_MIC
+	tristate "Michael MIC keyed digest algorithm"
+	select CRYPTO_HASH
 	help
-	  The CAST6 encryption algorithm (synonymous with CAST-256) is
-	  described in RFC2612.
+	  Michael MIC is used for message integrity protection in TKIP
+	  (IEEE 802.11i). This algorithm is required for TKIP, but it
+	  should not be used for other purposes because of the weakness
+	  of the algorithm.
 
-config CRYPTO_DES
-	tristate "DES and Triple DES EDE cipher algorithms"
-	select CRYPTO_ALGAPI
-	select CRYPTO_LIB_DES
+config CRYPTO_POLYVAL
+	tristate
+	select CRYPTO_GF128MUL
+	select CRYPTO_HASH
 	help
-	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
+	  POLYVAL is the hash function used in HCTR2.  It is not a general-purpose
+	  cryptographic hash function.
 
-config CRYPTO_FCRYPT
-	tristate "FCrypt cipher algorithm"
-	select CRYPTO_ALGAPI
-	select CRYPTO_SKCIPHER
+config CRYPTO_POLY1305
+	tristate "Poly1305 authenticator algorithm"
+	select CRYPTO_HASH
+	select CRYPTO_LIB_POLY1305_GENERIC
 	help
-	  FCrypt algorithm used by RxRPC.
+	  Poly1305 authenticator algorithm, RFC7539.
 
-config CRYPTO_KHAZAD
-	tristate "Khazad cipher algorithm"
-	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
-	select CRYPTO_ALGAPI
+	  Poly1305 is an authenticator algorithm designed by Daniel J. Bernstein.
+	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
+	  in IETF protocols. This is the portable C implementation of Poly1305.
+
+config CRYPTO_RMD160
+	tristate "RIPEMD-160 digest algorithm"
+	select CRYPTO_HASH
 	help
-	  Khazad cipher algorithm.
+	  RIPEMD-160 (ISO/IEC 10118-3:2004).
 
-	  Khazad was a finalist in the initial NESSIE competition.  It is
-	  an algorithm optimized for 64-bit processors with good performance
-	  on 32-bit processors.  Khazad uses an 128 bit key size.
+	  RIPEMD-160 is a 160-bit cryptographic hash function. It is intended
+	  to be used as a secure replacement for the 128-bit hash functions
+	  MD4, MD5 and its predecessor RIPEMD
+	  (not to be confused with RIPEMD-128).
 
-	  See also:
-	  <http://www.larc.usp.br/~pbarreto/KhazadPage.html>
+	  It's speed is comparable to SHA1 and there are no known attacks
+	  against RIPEMD-160.
 
-config CRYPTO_CHACHA20
-	tristate "ChaCha stream cipher algorithms"
-	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_SKCIPHER
+	  Developed by Hans Dobbertin, Antoon Bosselaers and Bart Preneel.
+	  See <https://homes.esat.kuleuven.be/~bosselae/ripemd160.html>
+
+config CRYPTO_SHA1
+	tristate "SHA1 digest algorithm"
+	select CRYPTO_HASH
+	select CRYPTO_LIB_SHA1
 	help
-	  The ChaCha20, XChaCha20, and XChaCha12 stream cipher algorithms.
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
 
-	  ChaCha20 is a 256-bit high-speed stream cipher designed by Daniel J.
-	  Bernstein and further specified in RFC7539 for use in IETF protocols.
-	  This is the portable C implementation of ChaCha20.  See also:
-	  <https://cr.yp.to/chacha/chacha-20080128.pdf>
+config CRYPTO_SHA256
+	tristate "SHA224 and SHA256 digest algorithm"
+	select CRYPTO_HASH
+	select CRYPTO_LIB_SHA256
+	help
+	  SHA256 secure hash standard (DFIPS 180-2).
 
-	  XChaCha20 is the application of the XSalsa20 construction to ChaCha20
-	  rather than to Salsa20.  XChaCha20 extends ChaCha20's nonce length
-	  from 64 bits (or 96 bits using the RFC7539 convention) to 192 bits,
-	  while provably retaining ChaCha20's security.  See also:
-	  <https://cr.yp.to/snuffle/xsalsa-20081128.pdf>
+	  This version of SHA implements a 256 bit hash with 128 bits of
+	  security against collision attacks.
 
-	  XChaCha12 is XChaCha20 reduced to 12 rounds, with correspondingly
-	  reduced security margin but increased performance.  It can be needed
-	  in some performance-sensitive scenarios.
+	  This code also includes SHA-224, a 224 bit hash with 112 bits
+	  of security against collision attacks.
 
-config CRYPTO_SEED
-	tristate "SEED cipher algorithm"
-	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
-	select CRYPTO_ALGAPI
+config CRYPTO_SHA512
+	tristate "SHA384 and SHA512 digest algorithms"
+	select CRYPTO_HASH
 	help
-	  SEED cipher algorithm (RFC4269).
+	  SHA512 secure hash standard (DFIPS 180-2).
 
-	  SEED is a 128-bit symmetric key block cipher that has been
-	  developed by KISA (Korea Information Security Agency) as a
-	  national standard encryption algorithm of the Republic of Korea.
-	  It is a 16 round block cipher with the key size of 128 bit.
+	  This version of SHA implements a 512 bit hash with 256 bits of
+	  security against collision attacks.
 
-	  See also:
-	  <http://www.kisa.or.kr/kisa/seed/jsp/seed_eng.jsp>
+	  This code also includes SHA-384, a 384 bit hash with 192 bits
+	  of security against collision attacks.
 
-config CRYPTO_ARIA
-	tristate "ARIA cipher algorithm"
-	select CRYPTO_ALGAPI
+config CRYPTO_SHA3
+	tristate "SHA3 digest algorithm"
+	select CRYPTO_HASH
 	help
-	  ARIA cipher algorithm (RFC5794).
+	  SHA-3 secure hash standard (DFIPS 202). It's based on
+	  cryptographic sponge function family called Keccak.
 
-	  ARIA is a standard encryption algorithm of the Republic of Korea.
-	  The ARIA specifies three key sizes and rounds.
-	  128-bit: 12 rounds.
-	  192-bit: 14 rounds.
-	  256-bit: 16 rounds.
+	  References:
+	  http://keccak.noekeon.org/
 
-	  See also:
-	  <https://seed.kisa.or.kr/kisa/algorithm/EgovAriaInfo.do>
+config CRYPTO_SM3
+	tristate
 
-config CRYPTO_SERPENT
-	tristate "Serpent cipher algorithm"
-	select CRYPTO_ALGAPI
+config CRYPTO_SM3_GENERIC
+	tristate "SM3 digest algorithm"
+	select CRYPTO_HASH
+	select CRYPTO_SM3
 	help
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3).
+	  It is part of the Chinese Commercial Cryptography suite.
 
-	  Keys are allowed to be from 0 to 256 bits in length, in steps
-	  of 8 bits.
+	  References:
+	  http://www.oscca.gov.cn/UpFile/20101222141857786.pdf
+	  https://datatracker.ietf.org/doc/html/draft-shen-sm3-hash
 
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+config CRYPTO_STREEBOG
+	tristate "Streebog Hash Function"
+	select CRYPTO_HASH
+	help
+	  Streebog Hash Function (GOST R 34.11-2012, RFC 6986) is one of the Russian
+	  cryptographic standard algorithms (called GOST algorithms).
+	  This setting enables two hash algorithms with 256 and 512 bits output.
 
-config CRYPTO_SM4
-	tristate
+	  References:
+	  https://tc26.ru/upload/iblock/fed/feddbb4d26b685903faa2ba11aea43f6.pdf
+	  https://tools.ietf.org/html/rfc6986
 
-config CRYPTO_SM4_GENERIC
-	tristate "SM4 cipher algorithm"
-	select CRYPTO_ALGAPI
-	select CRYPTO_SM4
+config CRYPTO_VMAC
+	tristate "VMAC support"
+	select CRYPTO_HASH
+	select CRYPTO_MANAGER
 	help
-	  SM4 cipher algorithms (OSCCA GB/T 32907-2016).
-
-	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
-	  Organization of State Commercial Administration of China (OSCCA)
-	  as an authorized cryptographic algorithms for the use within China.
+	  VMAC is a message authentication algorithm designed for
+	  very high speed on 64-bit architectures.
 
-	  SMS4 was originally created for use in protecting wireless
-	  networks, and is mandated in the Chinese National Standard for
-	  Wireless LAN WAPI (Wired Authentication and Privacy Infrastructure)
-	  (GB.15629.11-2003).
+	  See also:
+	  <https://fastcrypto.org/vmac>
 
-	  The latest SM4 standard (GBT.32907-2016) was proposed by OSCCA and
-	  standardized through TC 260 of the Standardization Administration
-	  of the People's Republic of China (SAC).
+config CRYPTO_WP512
+	tristate "Whirlpool digest algorithms"
+	select CRYPTO_HASH
+	help
+	  Whirlpool hash algorithm 512, 384 and 256-bit hashes
 
-	  The input, output, and key of SMS4 are each 128 bits.
+	  Whirlpool-512 is part of the NESSIE cryptographic primitives.
+	  Whirlpool will be part of the ISO/IEC 10118-3:2003(E) standard
 
-	  See also: <https://eprint.iacr.org/2008/329.pdf>
+	  See also:
+	  <http://www.larc.usp.br/~pbarreto/WhirlpoolPage.html>
 
-	  If unsure, say N.
+config CRYPTO_XCBC
+	tristate "XCBC support"
+	select CRYPTO_HASH
+	select CRYPTO_MANAGER
+	help
+	  XCBC: Keyed-Hashing with encryption algorithm
+		https://www.ietf.org/rfc/rfc3566.txt
+		http://csrc.nist.gov/encryption/modes/proposedmodes/
+		 xcbc-mac/xcbc-mac-spec.pdf
 
-config CRYPTO_TEA
-	tristate "TEA, XTEA and XETA cipher algorithms"
-	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
-	select CRYPTO_ALGAPI
+config CRYPTO_XXHASH
+	tristate "xxHash hash algorithm"
+	select CRYPTO_HASH
+	select XXHASH
 	help
-	  TEA cipher algorithm.
+	  xxHash non-cryptographic hash algorithm. Extremely fast, working at
+	  speeds close to RAM limits.
 
-	  Tiny Encryption Algorithm is a simple cipher that uses
-	  many rounds for security.  It is very fast and uses
-	  little memory.
+endmenu
 
-	  Xtendend Tiny Encryption Algorithm is a modification to
-	  the TEA algorithm to address a potential key weakness
-	  in the TEA algorithm.
+menu "CRCs (cyclic redundancy checks)"
 
-	  Xtendend Encryption Tiny Algorithm is a mis-implementation
-	  of the XTEA algorithm for compatibility purposes.
+config CRYPTO_CRC32C
+	tristate "CRC32c CRC algorithm"
+	select CRYPTO_HASH
+	select CRC32
+	help
+	  Castagnoli, et al Cyclic Redundancy-Check Algorithm.  Used
+	  by iSCSI for header and data digests and by others.
+	  See Castagnoli93.  Module will be crc32c.
 
-config CRYPTO_TWOFISH
-	tristate "Twofish cipher algorithm"
-	select CRYPTO_ALGAPI
-	select CRYPTO_TWOFISH_COMMON
+config CRYPTO_CRC32
+	tristate "CRC32 CRC algorithm"
+	select CRYPTO_HASH
+	select CRC32
 	help
-	  Twofish cipher algorithm.
+	  CRC-32-IEEE 802.3 cyclic redundancy-check algorithm.
+	  Shash crypto api wrappers to crc32_le function.
 
-	  Twofish was submitted as an AES (Advanced Encryption Standard)
-	  candidate cipher by researchers at CounterPane Systems.  It is a
-	  16 round block cipher supporting key sizes of 128, 192, and 256
-	  bits.
+config CRYPTO_CRCT10DIF
+	tristate "CRCT10DIF algorithm"
+	select CRYPTO_HASH
+	help
+	  CRC T10 Data Integrity Field computation is being cast as
+	  a crypto transform.  This allows for faster crc t10 diff
+	  transforms to be used if they are available.
 
-	  See also:
-	  <https://www.schneier.com/twofish.html>
+config CRYPTO_CRC64_ROCKSOFT
+	tristate "Rocksoft Model CRC64 algorithm"
+	depends on CRC64
+	select CRYPTO_HASH
 
-config CRYPTO_TWOFISH_COMMON
-	tristate
-	help
-	  Common parts of the Twofish cipher algorithm shared by the
-	  generic c and the assembler implementations.
+endmenu
 
-comment "Compression"
+menu "Compression"
 
 config CRYPTO_DEFLATE
 	tristate "Deflate compression algorithm"
@@ -1156,7 +1170,9 @@ config CRYPTO_ZSTD
 	help
 	  This is the zstd algorithm.
 
-comment "Random Number Generation"
+endmenu
+
+menu "Random number generation"
 
 config CRYPTO_ANSI_CPRNG
 	tristate "Pseudo Random Number Generation for Cryptographic modules"
@@ -1218,6 +1234,9 @@ config CRYPTO_KDF800108_CTR
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
 
+endmenu
+menu "User-space interface"
+
 config CRYPTO_USER_API
 	tristate
 
@@ -1289,6 +1308,8 @@ config CRYPTO_STATS
 	  - encrypt/decrypt/sign/verify numbers for asymmetric operations
 	  - generate/seed numbers for rng operations
 
+endmenu
+
 config CRYPTO_HASH_INFO
 	bool
 
-- 
2.37.1

