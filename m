Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFC3593E57
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346048AbiHOUlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345548AbiHOUfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:35:24 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8FA4E63B;
        Mon, 15 Aug 2022 12:06:28 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FHgZeB030960;
        Mon, 15 Aug 2022 19:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=W7YuKLSlg+L9y+3SYMorR1VdFBeJpRx8rEYlFvqIycA=;
 b=A8osAhyuWYcSO7MCQFm/9LUyiDcSxDjkrPLM1pq7NaVbqXfsRNRtB2VtxLgNMw6j/pF1
 EcKUw7j5wGwredqNVXEV5V4A5Dho0IDS5CNv4HHvDRCXkj5KfpDfv+ke1H53U++CahO6
 ArqAr/+iv0XL0o4G5koQrMzd80VAvmn+/AhXZbc0gv260yG/QjysUkTWIieYvsIeAIP1
 5BB57exN/6+CIqXrvPT1g2Ni9gVrhfmFdn4SEo/ucwlesyl67lT/WAGQJlR2dHYtq0oG
 yjcBmzfZTMmbDPTk32Pc8mHVZpWDNdwV1lVO4MMtKs6aFg8AeO2iOynAwySza6TqO57R UQ== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hyts4rp84-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:06:24 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 75596D2EE;
        Mon, 15 Aug 2022 19:06:23 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 2DA1B808EA6;
        Mon, 15 Aug 2022 19:06:23 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 6/8] crypto: Kconfig - simplify cipher, compression, and RNG entries
Date:   Mon, 15 Aug 2022 14:06:06 -0500
Message-Id: <20220815190608.47182-7-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815190608.47182-1-elliott@hpe.com>
References: <20220815190608.47182-1-elliott@hpe.com>
X-Proofpoint-ORIG-GUID: 5wJYbzrvh1bZkfrywhv38VkEunJ0LXvE
X-Proofpoint-GUID: 5wJYbzrvh1bZkfrywhv38VkEunJ0LXvE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten menu titles and help text and make them consistent:
* acronym
* name
* architecture and architecture features in parenthesis
* no suffixes like "<something> algorithm", "support", or
"hardware acceleration", or "optimized"

Clarify architecture restrictions (e.g., include x86 in the names of
all the x86-optimized modules.

Simplify descriptions, update references, and ensure that https
references are still valid.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/Kconfig | 510 +++++++++++++++++++++----------------------------
 1 file changed, 220 insertions(+), 290 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index e012d33eb739..0116729ea369 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1239,7 +1239,7 @@ menu "Digests"
 menu "Ciphers"
 
 config CRYPTO_AES
-	tristate "AES cipher algorithms"
+	tristate "AES (Advanced Encryption Standard)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 	help
@@ -1257,10 +1257,8 @@ menu "Ciphers"
 
 	  The AES specifies three key sizes: 128, 192 and 256 bits
 
-	  See <http://csrc.nist.gov/CryptoToolkit/aes/> for more information.
-
 config CRYPTO_AES_TI
-	tristate "Fixed time AES cipher"
+	tristate "AES (Advanced Encryption Standard) (fixed time)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 	help
@@ -1279,7 +1277,7 @@ menu "Ciphers"
 	  are evicted when the CPU is interrupted to do something else.
 
 config CRYPTO_AES_NI_INTEL
-	tristate "AES cipher algorithms (AES-NI)"
+	tristate "AES (Advanced Encryption Standard) (x86 with AES-NI)"
 	depends on X86
 	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
@@ -1287,63 +1285,29 @@ menu "Ciphers"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
 	help
-	  Use Intel AES-NI instructions for AES algorithm.
-
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
-
-	  The AES specifies three key sizes: 128, 192 and 256 bits
+	  AES cipher algorithms with ECB, CBC, CTS, CTR, XTS, GCM modes
 
-	  See <http://csrc.nist.gov/encryption/aes/> for more information.
-
-	  In addition to AES cipher algorithm support, the acceleration
-	  for some popular block cipher mode is supported too, including
-	  ECB, CBC, LRW, XTS. The 64 bit version has additional
-	  acceleration for CTR.
+	  Architecture: x86 (32-bit and 64-bit) using:
+	  * AES-NI (AES new instructions)
 
 config CRYPTO_AES_SPARC64
-	tristate "AES cipher algorithms (SPARC64)"
+	tristate "AES (Advanced Encryption Standard) (SPARC64)"
 	depends on SPARC64
 	select CRYPTO_SKCIPHER
 	help
-	  Use SPARC64 crypto opcodes for AES algorithm.
-
-	  AES cipher algorithms (FIPS-197). AES uses the Rijndael
-	  algorithm.
+	  AES cipher algorithms (FIPS-197)
 
-	  Rijndael appears to be consistently a very good performer in
-	  both hardware and software across a wide range of computing
-	  environments regardless of its use in feedback or non-feedback
-	  modes. Its key setup time is excellent, and its key agility is
-	  good. Rijndael's very low memory requirements make it very well
-	  suited for restricted-space environments, in which it also
-	  demonstrates excellent performance. Rijndael's operations are
-	  among the easiest to defend against power and timing attacks.
-
-	  The AES specifies three key sizes: 128, 192 and 256 bits
-
-	  See <http://csrc.nist.gov/encryption/aes/> for more information.
-
-	  In addition to AES cipher algorithm support, the acceleration
-	  for some popular block cipher mode is supported too, including
-	  ECB and CBC.
+	  Architecture: sparc64 using crypto instructions
 
 config CRYPTO_AES_PPC_SPE
-	tristate "AES cipher algorithms (PPC SPE)"
+	tristate "AES (Advanced Encryption Standard) (PPC SPE)"
 	depends on PPC && SPE
 	select CRYPTO_SKCIPHER
 	help
-	  AES cipher algorithms (FIPS-197). Additionally the acceleration
-	  for popular block cipher modes ECB, CBC, CTR and XTS is supported.
+	  AES cipher algorithms (FIPS-197)
+
+	  Architecture: powerpc using SPE (Signal Processing Engine) extensions
+
 	  This module should only be used for low power (router) devices
 	  without hardware AES acceleration (e.g. caam crypto). It reduces the
 	  size of the AES tables from 16KB to 8KB + 256 bytes and mitigates
@@ -1352,13 +1316,14 @@ menu "Ciphers"
 	  tables or 256 bytes S-boxes.
 
 config CRYPTO_AES_S390
-	tristate "AES cipher algorithms"
+	tristate "AES (Advanced Encryption Standard) (s390)"
 	depends on S390
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  AES cipher algorithms (FIPS-197).
+	  AES cipher algorithms (FIPS 197)
+
+	  Architecture: s390
 
 	  As of z9 the ECB and CBC modes are hardware accelerated
 	  for 128 bit keys.
@@ -1369,7 +1334,7 @@ menu "Ciphers"
 	  512 bit keys.
 
 config CRYPTO_ANUBIS
-	tristate "Anubis cipher algorithm"
+	tristate "Anubis"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
 	select CRYPTO_ALGAPI
 	help
@@ -1379,12 +1344,11 @@ menu "Ciphers"
 	  128 bits to 320 bits in length.  It was evaluated as a entrant
 	  in the NESSIE competition.
 
-	  See also:
-	  <https://www.cosic.esat.kuleuven.be/nessie/reports/>
-	  <http://www.larc.usp.br/~pbarreto/AnubisPage.html>
+	  See https://web.archive.org/web/20160606112246/http://www.larc.usp.br/~pbarreto/AnubisPage.html
+	  for further information.
 
 config CRYPTO_ARC4
-	tristate "ARC4 cipher algorithm"
+	tristate "ARC4"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_ARC4
@@ -1397,7 +1361,7 @@ menu "Ciphers"
 	  weakness of the algorithm.
 
 config CRYPTO_BLOWFISH
-	tristate "Blowfish cipher algorithm"
+	tristate "Blowfish"
 	select CRYPTO_ALGAPI
 	select CRYPTO_BLOWFISH_COMMON
 	help
@@ -1407,8 +1371,7 @@ menu "Ciphers"
 	  bits to 448 bits in length.  It's fast, simple and specifically
 	  designed for use on "large microprocessors".
 
-	  See also:
-	  <https://www.schneier.com/blowfish.html>
+	  See https://www.schneier.com/blowfish.html for further information.
 
 config CRYPTO_BLOWFISH_COMMON
 	tristate
@@ -1416,103 +1379,74 @@ menu "Ciphers"
 	  Common parts of the Blowfish cipher algorithm shared by the
 	  generic c and the assembler implementations.
 
-	  See also:
-	  <https://www.schneier.com/blowfish.html>
-
 config CRYPTO_BLOWFISH_X86_64
-	tristate "Blowfish cipher algorithm (x86_64)"
+	tristate "Blowfish (x86_64)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_BLOWFISH_COMMON
 	imply CRYPTO_CTR
 	help
-	  Blowfish cipher algorithm (x86_64), by Bruce Schneier.
-
-	  This is a variable key length cipher which can use keys from 32
-	  bits to 448 bits in length.  It's fast, simple and specifically
-	  designed for use on "large microprocessors".
+	  Blowfish cipher algorithm, by Bruce Schneier.
 
-	  See also:
-	  <https://www.schneier.com/blowfish.html>
+	  Architecture: x86_64
 
 config CRYPTO_CAMELLIA
-	tristate "Camellia cipher algorithms"
+	tristate "Camellia"
 	select CRYPTO_ALGAPI
 	help
-	  Camellia cipher algorithms module.
+	  Camellia cipher algorithms
 
 	  Camellia is a symmetric key block cipher developed jointly
 	  at NTT and Mitsubishi Electric Corporation.
 
 	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
 
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+	  See https://info.isl.ntt.co.jp/crypt/eng/camellia/ for further information.
 
 config CRYPTO_CAMELLIA_X86_64
-	tristate "Camellia cipher algorithm (x86_64)"
+	tristate "Camellia (x86_64)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	imply CRYPTO_CTR
 	help
-	  Camellia cipher algorithm module (x86_64).
-
-	  Camellia is a symmetric key block cipher developed jointly
-	  at NTT and Mitsubishi Electric Corporation.
+	  Camellia cipher algorithms
 
-	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
-
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+	  Architecture: x86_64
 
 config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
-	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX)"
+	tristate "Camellia (x86_64 with AES-NI/AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAMELLIA_X86_64
 	select CRYPTO_SIMD
 	imply CRYPTO_XTS
 	help
-	  Camellia cipher algorithm module (x86_64/AES-NI/AVX).
-
-	  Camellia is a symmetric key block cipher developed jointly
-	  at NTT and Mitsubishi Electric Corporation.
+	  Camellia cipher algorithms
 
-	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
-
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+	  Architecture: x86_64 using:
+	  * AES-NI (AES New Instructions)
+	  * AVX (Advanced Vector Extensions)
 
 config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
-	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX2)"
+	tristate "Camellia (x86_64 with AES-NI/AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	help
-	  Camellia cipher algorithm module (x86_64/AES-NI/AVX2).
-
-	  Camellia is a symmetric key block cipher developed jointly
-	  at NTT and Mitsubishi Electric Corporation.
+	  Camellia cipher algorithms
 
-	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
-
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+	  Architecture: x86_64 using:
+	  * AES-NI (AES New Instructions)
+	  * AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_CAMELLIA_SPARC64
-	tristate "Camellia cipher algorithm (SPARC64)"
+	tristate "Camellia (SPARC64)"
 	depends on SPARC64
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	help
-	  Camellia cipher algorithm module (SPARC64).
-
-	  Camellia is a symmetric key block cipher developed jointly
-	  at NTT and Mitsubishi Electric Corporation.
-
-	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
+	  Camellia cipher algorithm module
 
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+	  Architecture: sparc64
 
 config CRYPTO_CAST_COMMON
 	tristate
@@ -1521,15 +1455,14 @@ menu "Ciphers"
 	  generic c and the assembler implementations.
 
 config CRYPTO_CAST5
-	tristate "CAST5 (CAST-128) cipher algorithm"
+	tristate "CAST5 (CAST-128)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_CAST_COMMON
 	help
-	  The CAST5 encryption algorithm (synonymous with CAST-128) is
-	  described in RFC2144.
+	  CAST5 (CAST-128) cipher algorithm (RFC2144)
 
 config CRYPTO_CAST5_AVX_X86_64
-	tristate "CAST5 (CAST-128) cipher algorithm (x86_64/AVX)"
+	tristate "CAST5 (CAST-128) (x86_64 with AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST5
@@ -1537,22 +1470,22 @@ menu "Ciphers"
 	select CRYPTO_SIMD
 	imply CRYPTO_CTR
 	help
-	  The CAST5 encryption algorithm (synonymous with CAST-128) is
-	  described in RFC2144.
+	  CAST5 (CAST-128) cipher algorithm (RFC2144)
 
-	  This module provides the Cast5 cipher algorithm that processes
-	  sixteen blocks parallel using the AVX instruction set.
+	  Architecture: x86_64 using:
+	  * AVX (Advanced Vector Extensions)
+
+	  Processes 16 blocks in parallel.
 
 config CRYPTO_CAST6
-	tristate "CAST6 (CAST-256) cipher algorithm"
+	tristate "CAST6 (CAST-256)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_CAST_COMMON
 	help
-	  The CAST6 encryption algorithm (synonymous with CAST-256) is
-	  described in RFC2612.
+	  CAST6 (CAST-256) encryption algorithm (RFC2612)
 
 config CRYPTO_CAST6_AVX_X86_64
-	tristate "CAST6 (CAST-256) cipher algorithm (x86_64/AVX)"
+	tristate "CAST6 (CAST-256) (x86_64 with AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST6
@@ -1561,144 +1494,155 @@ menu "Ciphers"
 	imply CRYPTO_XTS
 	imply CRYPTO_CTR
 	help
-	  The CAST6 encryption algorithm (synonymous with CAST-256) is
-	  described in RFC2612.
+	  CAST6 (CAST-256) encryption algorithm (RFC2612)
 
-	  This module provides the Cast6 cipher algorithm that processes
-	  eight blocks parallel using the AVX instruction set.
+	  Architecture: x86_64 using:
+	  * AVX (Advanced Vector Extensions)
+
+	  Processes eight blocks in parallel.
 
 config CRYPTO_DES
-	tristate "DES and Triple DES EDE cipher algorithms"
+	tristate "DES and Triple DES EDE"
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_DES
 	help
-	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
+	  DES (FIPS 46-2) and Triple DES EDE (FIPS 46-3) cipher algorithms
 
 config CRYPTO_DES_SPARC64
-	tristate "DES and Triple DES EDE cipher algorithms (SPARC64)"
+	tristate "DES and Triple DES EDE (SPARC64)"
 	depends on SPARC64
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_DES
 	select CRYPTO_SKCIPHER
 	help
-	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3),
-	  optimized using SPARC64 crypto opcodes.
+	  DES (FIPS 46-2) and Triple DES EDE (FIPS 46-3) cipher algorithms
+
+	  Architecture: sparc64
 
 config CRYPTO_DES3_EDE_X86_64
-	tristate "Triple DES EDE cipher algorithm (x86-64)"
+	tristate "Triple DES EDE (x86_64)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	imply CRYPTO_CTR
 	help
-	  Triple DES EDE (FIPS 46-3) algorithm.
+	  Triple DES EDE (FIPS 46-3) cipher algorithm
 
-	  This module provides implementation of the Triple DES EDE cipher
-	  algorithm that is optimized for x86-64 processors. Two versions of
-	  algorithm are provided; regular processing one input block and
-	  one that processes three blocks parallel.
+	  Architecture: x86_64
+
+	  Processes one or three blocks in parallel.
 
 config CRYPTO_DES_S390
-	tristate "DES and Triple DES cipher algorithms"
+	tristate "DES and Triple DES EDE (s390)"
 	depends on S390
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
+	  DES (FIPS 46-2) and Triple DES EDE (FIPS 46-3) cipher algorithms
+
+	  Architecture: s390
 
 	  As of z990 the ECB and CBC mode are hardware accelerated.
 	  As of z196 the CTR mode is hardware accelerated.
 
 config CRYPTO_FCRYPT
-	tristate "FCrypt cipher algorithm"
+	tristate "FCrypt"
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	help
 	  FCrypt algorithm used by RxRPC.
 
 config CRYPTO_KHAZAD
-	tristate "Khazad cipher algorithm"
+	tristate "Khazad"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
 	select CRYPTO_ALGAPI
 	help
-	  Khazad cipher algorithm.
+	  Khazad cipher algorithm
 
 	  Khazad was a finalist in the initial NESSIE competition.  It is
 	  an algorithm optimized for 64-bit processors with good performance
 	  on 32-bit processors.  Khazad uses an 128 bit key size.
 
-	  See also:
-	  <http://www.larc.usp.br/~pbarreto/KhazadPage.html>
+	  See https://web.archive.org/web/20171011071731/http://www.larc.usp.br/~pbarreto/KhazadPage.html
+	  for further information.
 
 config CRYPTO_CHACHA20
-	tristate "ChaCha stream cipher algorithms"
+	tristate "ChaCha"
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_SKCIPHER
 	help
-	  The ChaCha20, XChaCha20, and XChaCha12 stream cipher algorithms.
+	  The ChaCha20, XChaCha20, and XChaCha12 stream cipher algorithms
 
 	  ChaCha20 is a 256-bit high-speed stream cipher designed by Daniel J.
 	  Bernstein and further specified in RFC7539 for use in IETF protocols.
-	  This is the portable C implementation of ChaCha20.  See also:
-	  <https://cr.yp.to/chacha/chacha-20080128.pdf>
+	  This is the portable C implementation of ChaCha20.  See
+	  https://cr.yp.to/chacha/chacha-20080128.pdf for further information.
 
 	  XChaCha20 is the application of the XSalsa20 construction to ChaCha20
 	  rather than to Salsa20.  XChaCha20 extends ChaCha20's nonce length
 	  from 64 bits (or 96 bits using the RFC7539 convention) to 192 bits,
-	  while provably retaining ChaCha20's security.  See also:
-	  <https://cr.yp.to/snuffle/xsalsa-20081128.pdf>
+	  while provably retaining ChaCha20's security.  See
+	  https://cr.yp.to/snuffle/xsalsa-20081128.pdf for further information.
 
 	  XChaCha12 is XChaCha20 reduced to 12 rounds, with correspondingly
 	  reduced security margin but increased performance.  It can be needed
 	  in some performance-sensitive scenarios.
 
 config CRYPTO_CHACHA20_X86_64
-	tristate "ChaCha stream cipher algorithms (x86_64/SSSE3/AVX2/AVX-512VL)"
+	tristate "ChaCha (x86_64 with SSSE3/AVX2/AVX-512VL)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	help
-	  SSSE3, AVX2, and AVX-512VL optimized implementations of the ChaCha20,
-	  XChaCha20, and XChaCha12 stream ciphers.
+	  ChaCha stream cipher algorithms
+
+	  Architecture: x86_64 using:
+	  * SSSE3 (Supplemental SSE3)
+	  * AVX2 (Advanced Vector Extensions 2)
+	  * AVX-512VL (Advanced Vector Extensions-512VL)
 
 config CRYPTO_CHACHA_MIPS
-	tristate "ChaCha stream cipher algorithms (MIPS 32r2 optimized)"
+	tristate "ChaCha (MIPS32r2)"
 	depends on CPU_MIPS32_R2
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	help
+	  ChaCha stream cipher algorithms
+
+	  Architecture: MIPS32r2
 
 config CRYPTO_CHACHA_S390
-	tristate "ChaCha20 stream cipher"
+	tristate "ChaCha20 (s390)"
 	depends on S390
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	help
-	  This is the s390 SIMD implementation of the ChaCha20 stream
-	  cipher (RFC 7539).
+	  ChaCha20 stream cipher (RFC 7539)
+
+	  Architecture: s390
 
 	  It is available as of z13.
 
 config CRYPTO_SEED
-	tristate "SEED cipher algorithm"
+	tristate "SEED"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
 	select CRYPTO_ALGAPI
 	help
-	  SEED cipher algorithm (RFC4269).
+	  SEED cipher algorithm (RFC4269)
 
 	  SEED is a 128-bit symmetric key block cipher that has been
 	  developed by KISA (Korea Information Security Agency) as a
 	  national standard encryption algorithm of the Republic of Korea.
 	  It is a 16 round block cipher with the key size of 128 bit.
 
-	  See also:
-	  <http://www.kisa.or.kr/kisa/seed/jsp/seed_eng.jsp>
+	  See https://seed.kisa.or.kr/kisa/algorithm/EgovSeedInfo.do
+	  for further information.
 
 config CRYPTO_SERPENT
-	tristate "Serpent cipher algorithm"
+	tristate "Serpent"
 	select CRYPTO_ALGAPI
 	help
 	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
@@ -1706,49 +1650,40 @@ menu "Ciphers"
 	  Keys are allowed to be from 0 to 256 bits in length, in steps
 	  of 8 bits.
 
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+	  See https://www.cl.cam.ac.uk/~rja14/serpent.html for further information.
 
 config CRYPTO_SERPENT_SSE2_X86_64
-	tristate "Serpent cipher algorithm (x86_64/SSE2)"
+	tristate "Serpent (x86_64 with SSE2)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
 	imply CRYPTO_CTR
 	help
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
-
-	  Keys are allowed to be from 0 to 256 bits in length, in steps
-	  of 8 bits.
+	  Serpent cipher algorithm
 
-	  This module provides Serpent cipher algorithm that processes eight
-	  blocks parallel using SSE2 instruction set.
+	  Architecture: x86_64 using:
+	  * SSE2 (Streaming SIMD Extensions 2)
 
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+	  Processes eight blocks in parallel.
 
 config CRYPTO_SERPENT_SSE2_586
-	tristate "Serpent cipher algorithm (i586/SSE2)"
+	tristate "Serpent (x86 with SSE2)"
 	depends on X86 && !64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
 	imply CRYPTO_CTR
 	help
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+	  Serpent cipher algorithm
 
-	  Keys are allowed to be from 0 to 256 bits in length, in steps
-	  of 8 bits.
-
-	  This module provides Serpent cipher algorithm that processes four
-	  blocks parallel using SSE2 instruction set.
+	  Architecture: x86 (32-bit) using:
+	  * SSE2 (Streaming SIMD Extensions 2)
 
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+	  Processes four blocks in parallel.
 
 config CRYPTO_SERPENT_AVX_X86_64
-	tristate "Serpent cipher algorithm (x86_64/AVX)"
+	tristate "Serpent (x86_64 with AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
@@ -1756,42 +1691,34 @@ menu "Ciphers"
 	imply CRYPTO_XTS
 	imply CRYPTO_CTR
 	help
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+	  Serpent cipher algorithm
 
-	  Keys are allowed to be from 0 to 256 bits in length, in steps
-	  of 8 bits.
-
-	  This module provides the Serpent cipher algorithm that processes
-	  eight blocks parallel using the AVX instruction set.
+	  Architecture: x86_64 using:
+	  * AVX (Advanced Vector Extensions)
 
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+	  Processes eight blocks in parallel.
 
 config CRYPTO_SERPENT_AVX2_X86_64
-	tristate "Serpent cipher algorithm (x86_64/AVX2)"
+	tristate "Serpent (x86_64 with AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_SERPENT_AVX_X86_64
 	help
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+	  Serpent cipher algorithm
 
-	  Keys are allowed to be from 0 to 256 bits in length, in steps
-	  of 8 bits.
-
-	  This module provides Serpent cipher algorithm that processes 16
-	  blocks parallel using AVX2 instruction set.
+	  Architecture: x86_64 using:
+	  * AVX2 (Advanced Vector Extensions 2)
 
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+	  Processes 16 blocks in parallel.
 
 config CRYPTO_SM4
 	tristate
 
 config CRYPTO_SM4_GENERIC
-	tristate "SM4 cipher algorithm"
+	tristate "SM4 (ShangMi 4)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 	help
-	  SM4 cipher algorithms (OSCCA GB/T 32907-2016).
+	  SM4 cipher algorithms (OSCCA GB/T 32907-2016)
 
 	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
 	  Organization of State Commercial Administration of China (OSCCA)
@@ -1808,33 +1735,36 @@ menu "Ciphers"
 
 	  The input, output, and key of SMS4 are each 128 bits.
 
-	  See also: <https://eprint.iacr.org/2008/329.pdf>
+	  See https://eprint.iacr.org/2008/329.pdf for further information.
 
 	  If unsure, say N.
 
 config CRYPTO_SM4_AESNI_AVX_X86_64
-	tristate "SM4 cipher algorithm (x86_64/AES-NI/AVX)"
+	tristate "SM4 (ShangMi 4) (x86_64 with AES-NI/AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 	help
-	  SM4 cipher algorithms (OSCCA GB/T 32907-2016) (x86_64/AES-NI/AVX).
+	  SM4 cipher algorithms (OSCCA GB/T 32907-2016)
+
+	  Architecture: x86_64 using:
+	  * AES-NI (AES New Instructions)
+	  * AVX (Advanced Vector Extensions)
 
 	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
 	  Organization of State Commercial Administration of China (OSCCA)
 	  as an authorized cryptographic algorithms for the use within China.
 
-	  This is SM4 optimized implementation using AES-NI/AVX/x86_64
-	  instruction set for block cipher. Through two affine transforms,
+	  Through two affine transforms,
 	  we can use the AES S-Box to simulate the SM4 S-Box to achieve the
 	  effect of instruction acceleration.
 
 	  If unsure, say N.
 
 config CRYPTO_SM4_AESNI_AVX2_X86_64
-	tristate "SM4 cipher algorithm (x86_64/AES-NI/AVX2)"
+	tristate "SM4 (ShangMi 4) (x86_64 with AES-NI/AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
@@ -1842,25 +1772,28 @@ menu "Ciphers"
 	select CRYPTO_SM4
 	select CRYPTO_SM4_AESNI_AVX_X86_64
 	help
-	  SM4 cipher algorithms (OSCCA GB/T 32907-2016) (x86_64/AES-NI/AVX2).
+	  SM4 cipher algorithms (OSCCA GB/T 32907-2016)
+
+	  Architecture: x86_64 using:
+	  * AES-NI (AES New Instructions)
+	  * AVX2 (Advanced Vector Extensions 2)
 
 	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
 	  Organization of State Commercial Administration of China (OSCCA)
 	  as an authorized cryptographic algorithms for the use within China.
 
-	  This is SM4 optimized implementation using AES-NI/AVX2/x86_64
-	  instruction set for block cipher. Through two affine transforms,
+	  Through two affine transforms,
 	  we can use the AES S-Box to simulate the SM4 S-Box to achieve the
 	  effect of instruction acceleration.
 
 	  If unsure, say N.
 
 config CRYPTO_TEA
-	tristate "TEA, XTEA and XETA cipher algorithms"
+	tristate "TEA, XTEA and XETA"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
 	select CRYPTO_ALGAPI
 	help
-	  TEA cipher algorithm.
+	  TEA cipher algorithm
 
 	  Tiny Encryption Algorithm is a simple cipher that uses
 	  many rounds for security.  It is very fast and uses
@@ -1874,19 +1807,18 @@ menu "Ciphers"
 	  of the XTEA algorithm for compatibility purposes.
 
 config CRYPTO_TWOFISH
-	tristate "Twofish cipher algorithm"
+	tristate "Twofish"
 	select CRYPTO_ALGAPI
 	select CRYPTO_TWOFISH_COMMON
 	help
-	  Twofish cipher algorithm.
+	  Twofish cipher algorithm
 
 	  Twofish was submitted as an AES (Advanced Encryption Standard)
 	  candidate cipher by researchers at CounterPane Systems.  It is a
 	  16 round block cipher supporting key sizes of 128, 192, and 256
 	  bits.
 
-	  See also:
-	  <https://www.schneier.com/twofish.html>
+	  See https://www.schneier.com/twofish.html for further information.
 
 config CRYPTO_TWOFISH_COMMON
 	tristate
@@ -1895,61 +1827,43 @@ menu "Ciphers"
 	  generic c and the assembler implementations.
 
 config CRYPTO_TWOFISH_586
-	tristate "Twofish cipher algorithms (i586)"
+	tristate "Twofish (x86)"
 	depends on (X86 || UML_X86) && !64BIT
 	select CRYPTO_ALGAPI
 	select CRYPTO_TWOFISH_COMMON
 	imply CRYPTO_CTR
 	help
-	  Twofish cipher algorithm.
-
-	  Twofish was submitted as an AES (Advanced Encryption Standard)
-	  candidate cipher by researchers at CounterPane Systems.  It is a
-	  16 round block cipher supporting key sizes of 128, 192, and 256
-	  bits.
+	  Twofish cipher algorithm
 
-	  See also:
-	  <https://www.schneier.com/twofish.html>
+	  Architecture: x86 (32-bit)
 
 config CRYPTO_TWOFISH_X86_64
-	tristate "Twofish cipher algorithm (x86_64)"
+	tristate "Twofish (x86_64)"
 	depends on (X86 || UML_X86) && 64BIT
 	select CRYPTO_ALGAPI
 	select CRYPTO_TWOFISH_COMMON
 	imply CRYPTO_CTR
 	help
-	  Twofish cipher algorithm (x86_64).
-
-	  Twofish was submitted as an AES (Advanced Encryption Standard)
-	  candidate cipher by researchers at CounterPane Systems.  It is a
-	  16 round block cipher supporting key sizes of 128, 192, and 256
-	  bits.
+	  Twofish cipher algorithm
 
-	  See also:
-	  <https://www.schneier.com/twofish.html>
+	  Architecture: x86_64
 
 config CRYPTO_TWOFISH_X86_64_3WAY
-	tristate "Twofish cipher algorithm (x86_64, 3-way parallel)"
+	tristate "Twofish (x86_64, 3-way parallel)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_TWOFISH_COMMON
 	select CRYPTO_TWOFISH_X86_64
 	help
-	  Twofish cipher algorithm (x86_64, 3-way parallel).
-
-	  Twofish was submitted as an AES (Advanced Encryption Standard)
-	  candidate cipher by researchers at CounterPane Systems.  It is a
-	  16 round block cipher supporting key sizes of 128, 192, and 256
-	  bits.
+	  Twofish cipher algorithm
 
-	  This module provides Twofish cipher algorithm that processes three
-	  blocks parallel, utilizing resources of out-of-order CPUs better.
+	  Architecture: x86_64
 
-	  See also:
-	  <https://www.schneier.com/twofish.html>
+	  Processes three blocks in parallel, better utilizing resources of
+	  out-of-order CPUs.
 
 config CRYPTO_TWOFISH_AVX_X86_64
-	tristate "Twofish cipher algorithm (x86_64/AVX)"
+	tristate "Twofish (x86_64 with AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
@@ -1958,99 +1872,105 @@ menu "Ciphers"
 	select CRYPTO_TWOFISH_X86_64_3WAY
 	imply CRYPTO_XTS
 	help
-	  Twofish cipher algorithm (x86_64/AVX).
+	  Twofish cipher algorithm
 
-	  Twofish was submitted as an AES (Advanced Encryption Standard)
-	  candidate cipher by researchers at CounterPane Systems.  It is a
-	  16 round block cipher supporting key sizes of 128, 192, and 256
-	  bits.
-
-	  This module provides the Twofish cipher algorithm that processes
-	  eight blocks parallel using the AVX Instruction Set.
+	  Architecture: x86_64 using:
+	  * AVX (Advanced Vector Extensions)
 
-	  See also:
-	  <https://www.schneier.com/twofish.html>
+	  Processes eight blocks in parallel.
 
 endmenu
 
 menu "Compression"
 
 config CRYPTO_DEFLATE
-	tristate "Deflate compression algorithm"
+	tristate "Deflate"
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
 	help
-	  This is the Deflate algorithm (RFC1951), specified for use in
-	  IPSec with the IPCOMP protocol (RFC3173, RFC2394).
+	  Deflate algorithm (RFC1951)
 
-	  You will most probably want this if using IPSec.
+	  This is specified for use in IPSec with the IPCOMP protocol (RFC3173, RFC2394).
 
 config CRYPTO_LZO
-	tristate "LZO compression algorithm"
+	tristate "LZO (Lempel-Ziv-Oberhumer)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 	select LZO_COMPRESS
 	select LZO_DECOMPRESS
 	help
-	  This is the LZO algorithm.
+	  LZO compression algorithm
+
+	  See https://www.oberhumer.com/opensource/lzo/ for further information.
+	  Loads two modules: lzo and lzo-rle
 
 config CRYPTO_842
-	tristate "842 compression algorithm"
+	tristate "842"
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 	select 842_COMPRESS
 	select 842_DECOMPRESS
 	help
-	  This is the 842 algorithm.
+	  842 compression algorithm by IBM
+
+	  See https://github.com/plauth/lib842 for further information.
 
 config CRYPTO_LZ4
-	tristate "LZ4 compression algorithm"
+	tristate "LZ4"
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 	select LZ4_COMPRESS
 	select LZ4_DECOMPRESS
 	help
-	  This is the LZ4 algorithm.
+	  LZ4 compression algorithm
+
+	  See https://github.com/lz4/lz4 for further information.
 
 config CRYPTO_LZ4HC
-	tristate "LZ4HC compression algorithm"
+	tristate "LZ4HC"
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 	select LZ4HC_COMPRESS
 	select LZ4_DECOMPRESS
 	help
-	  This is the LZ4 high compression mode algorithm.
+	  LZ4 high compression mode algorithm
+
+	  See https://github.com/lz4/lz4 for further information.
 
 config CRYPTO_ZSTD
-	tristate "Zstd compression algorithm"
+	tristate "Zstd"
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 	select ZSTD_COMPRESS
 	select ZSTD_DECOMPRESS
 	help
-	  This is the zstd algorithm.
+	  zstd compression algorithm
+
+	  See https://github.com/facebook/zstd for further information.
 
 endmenu
 
 menu "Random Number Generation"
 
 config CRYPTO_ANSI_CPRNG
-	tristate "Pseudo Random Number Generation for Cryptographic modules"
+	tristate "ANSI PRNG (Pseudo Random Number Generator)"
 	select CRYPTO_AES
 	select CRYPTO_RNG
 	help
-	  This option enables the generic pseudo random number generator
-	  for cryptographic modules.  Uses the Algorithm specified in
-	  ANSI X9.31 A.2.4. Note that this option must be enabled if
-	  CRYPTO_FIPS is selected
+	  Pseudo RNG (random number generator) (ANSI X9.31 Appendix A.2.4)
+
+	  This uses the AES cipher algorithm.
+
+	  Note that this option must be enabled if CRYPTO_FIPS is selected
 
 menuconfig CRYPTO_DRBG_MENU
-	tristate "NIST SP800-90A DRBG"
+	tristate "NIST SP800-90A DRBG (Deterministic Random Bit Generator)"
 	help
-	  NIST SP800-90A compliant DRBG. In the following submenu, one or
-	  more of the DRBG types must be selected.
+	  DRBG (Deterministic Random Bit Generator) (NIST SP800-90A)
+
+	  In the following submenu, one or more of the DRBG types must be selected.
 
 if CRYPTO_DRBG_MENU
 
@@ -2061,17 +1981,21 @@ menuconfig CRYPTO_DRBG_MENU
 	select CRYPTO_SHA512
 
 config CRYPTO_DRBG_HASH
-	bool "Enable Hash DRBG"
+	bool "Hash_DRBG (Deterministic Random Bit Generator)"
 	select CRYPTO_SHA256
 	help
-	  Enable the Hash DRBG variant as defined in NIST SP800-90A.
+	  Hash_DRBG variant as defined in NIST SP800-90A.
+
+	  This uses the SHA-1, SHA-256, SHA-384, or SHA-512 hash algorithms.
 
 config CRYPTO_DRBG_CTR
-	bool "Enable CTR DRBG"
+	bool "CTR DRBG (Counter Mode Deterministic Random Bit Generator)"
 	select CRYPTO_AES
 	select CRYPTO_CTR
 	help
-	  Enable the CTR DRBG variant as defined in NIST SP800-90A.
+	  CTR_DRBG variant as defined in NIST SP800-90A.
+
+	  This uses the AES cipher algorithm and the counter block cipher mode.
 
 config CRYPTO_DRBG
 	tristate
@@ -2082,15 +2006,21 @@ menuconfig CRYPTO_DRBG_MENU
 endif	# if CRYPTO_DRBG_MENU
 
 config CRYPTO_JITTERENTROPY
-	tristate "Jitterentropy Non-Deterministic Random Number Generator"
+	tristate "CPU Jitter Non-Deterministic RNG (Random Number Generator)"
 	select CRYPTO_RNG
 	help
-	  The Jitterentropy RNG is a noise that is intended
-	  to provide seed to another RNG. The RNG does not
-	  perform any cryptographic whitening of the generated
+	  CPU Jitter RNG (Random Number Generator) from the Jitterentropy library
+
+	  A non-physical non-deterministic ("true") RNG (e.g., an entropy source
+	  compliant with NIST SP800-90B) intended to provide a seed to a
+	  deterministic RNG (e.g.  per NIST SP800-90C).
+
+	  This RNG does not perform any cryptographic whitening of the generated
 	  random numbers. This Jitterentropy RNG registers with
 	  the kernel crypto API and can be used by any caller.
 
+	  See https://www.chronox.de/jent.html
+
 endmenu
 
 config CRYPTO_KDF800108_CTR
-- 
2.37.1

