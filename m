Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1555859AFBC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiHTSmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiHTSmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:21 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34B845063;
        Sat, 20 Aug 2022 11:42:17 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KGCkuR000831;
        Sat, 20 Aug 2022 18:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=yVsQBcbevbXP9SAZLThOplS++4OCfPXjU6i5Nv2k8wM=;
 b=jhvuWSRVRrSpt93lfUBBadmeR3UialLGT0+o9WQ6rUOcYIv93yUp3D3BMjL/TSKwwEAl
 6UlrWbt2L8a2Ja0DMoFupwWB61chUIKx/4iIIbK5G+P8wymqwLoeL5GAcbqdeuHb3iZc
 8AxRYYJR6HbglW6Up4nyHJsHiSr8ms4/fWko3Zr6LR0Z2utvanvRGzm33BDC5U4XAZZ8
 AtlyLE8l5d3YR4B5uEqltNVZqJjkKSnTij1KnUce/MlPXb7IP5NobWxx7qiOQZpY2hJs
 d8C0NDeFrf2G5CnYv078Iy0p7M13b7wQpuL8pVyQt7UGGpl+aANE53LcJxqV8xT8yraf TQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j32wvrjjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:09 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id E5EEF804C87;
        Sat, 20 Aug 2022 18:42:08 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 93A58803A87;
        Sat, 20 Aug 2022 18:42:08 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 05/17] crypto: Kconfig - move x86 entries to a submenu
Date:   Sat, 20 Aug 2022 13:41:39 -0500
Message-Id: <20220820184151.1149247-6-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
X-Proofpoint-GUID: PqAgZZB7X_Umz5cVSvfx3s3Midr-njOv
X-Proofpoint-ORIG-GUID: PqAgZZB7X_Umz5cVSvfx3s3Midr-njOv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=996 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208200080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move CPU-specific crypto/Kconfig entries to arch/xxx/crypto/Kconfig
and create a submenu for them under the Crypto API menu.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/x86/crypto/Kconfig | 500 ++++++++++++++++++++++++++++++++++++++++
 crypto/Kconfig          | 498 +--------------------------------------
 2 files changed, 503 insertions(+), 495 deletions(-)
 create mode 100644 arch/x86/crypto/Kconfig

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
new file mode 100644
index 000000000000..04f4baea12a8
--- /dev/null
+++ b/arch/x86/crypto/Kconfig
@@ -0,0 +1,500 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Accelerated Cryptographic Algorithms for CPU (x86)"
+
+config CRYPTO_CURVE25519_X86
+	tristate "x86_64 accelerated Curve25519 scalar multiplication library"
+	depends on X86 && 64BIT
+	select CRYPTO_LIB_CURVE25519_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+
+config CRYPTO_AES_NI_INTEL
+	tristate "AES cipher algorithms (AES-NI)"
+	depends on X86
+	select CRYPTO_AEAD
+	select CRYPTO_LIB_AES
+	select CRYPTO_ALGAPI
+	select CRYPTO_SKCIPHER
+	select CRYPTO_SIMD
+	help
+	  Use Intel AES-NI instructions for AES algorithm.
+
+	  AES cipher algorithms (FIPS-197). AES uses the Rijndael
+	  algorithm.
+
+	  Rijndael appears to be consistently a very good performer in
+	  both hardware and software across a wide range of computing
+	  environments regardless of its use in feedback or non-feedback
+	  modes. Its key setup time is excellent, and its key agility is
+	  good. Rijndael's very low memory requirements make it very well
+	  suited for restricted-space environments, in which it also
+	  demonstrates excellent performance. Rijndael's operations are
+	  among the easiest to defend against power and timing attacks.
+
+	  The AES specifies three key sizes: 128, 192 and 256 bits
+
+	  See <http://csrc.nist.gov/encryption/aes/> for more information.
+
+	  In addition to AES cipher algorithm support, the acceleration
+	  for some popular block cipher mode is supported too, including
+	  ECB, CBC, LRW, XTS. The 64 bit version has additional
+	  acceleration for CTR and XCTR.
+
+config CRYPTO_BLOWFISH_X86_64
+	tristate "Blowfish cipher algorithm (x86_64)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_BLOWFISH_COMMON
+	imply CRYPTO_CTR
+	help
+	  Blowfish cipher algorithm (x86_64), by Bruce Schneier.
+
+	  This is a variable key length cipher which can use keys from 32
+	  bits to 448 bits in length.  It's fast, simple and specifically
+	  designed for use on "large microprocessors".
+
+	  See also:
+	  <https://www.schneier.com/blowfish.html>
+
+config CRYPTO_CAMELLIA_X86_64
+	tristate "Camellia cipher algorithm (x86_64)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	imply CRYPTO_CTR
+	help
+	  Camellia cipher algorithm module (x86_64).
+
+	  Camellia is a symmetric key block cipher developed jointly
+	  at NTT and Mitsubishi Electric Corporation.
+
+	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
+
+	  See also:
+	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+
+config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
+	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_CAMELLIA_X86_64
+	select CRYPTO_SIMD
+	imply CRYPTO_XTS
+	help
+	  Camellia cipher algorithm module (x86_64/AES-NI/AVX).
+
+	  Camellia is a symmetric key block cipher developed jointly
+	  at NTT and Mitsubishi Electric Corporation.
+
+	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
+
+	  See also:
+	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+
+config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
+	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX2)"
+	depends on X86 && 64BIT
+	select CRYPTO_CAMELLIA_AESNI_AVX_X86_64
+	help
+	  Camellia cipher algorithm module (x86_64/AES-NI/AVX2).
+
+	  Camellia is a symmetric key block cipher developed jointly
+	  at NTT and Mitsubishi Electric Corporation.
+
+	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
+
+	  See also:
+	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+
+config CRYPTO_CAST5_AVX_X86_64
+	tristate "CAST5 (CAST-128) cipher algorithm (x86_64/AVX)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_CAST5
+	select CRYPTO_CAST_COMMON
+	select CRYPTO_SIMD
+	imply CRYPTO_CTR
+	help
+	  The CAST5 encryption algorithm (synonymous with CAST-128) is
+	  described in RFC2144.
+
+	  This module provides the Cast5 cipher algorithm that processes
+	  sixteen blocks parallel using the AVX instruction set.
+
+config CRYPTO_CAST6_AVX_X86_64
+	tristate "CAST6 (CAST-256) cipher algorithm (x86_64/AVX)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_CAST6
+	select CRYPTO_CAST_COMMON
+	select CRYPTO_SIMD
+	imply CRYPTO_XTS
+	imply CRYPTO_CTR
+	help
+	  The CAST6 encryption algorithm (synonymous with CAST-256) is
+	  described in RFC2612.
+
+	  This module provides the Cast6 cipher algorithm that processes
+	  eight blocks parallel using the AVX instruction set.
+
+config CRYPTO_DES3_EDE_X86_64
+	tristate "Triple DES EDE cipher algorithm (x86-64)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_DES
+	imply CRYPTO_CTR
+	help
+	  Triple DES EDE (FIPS 46-3) algorithm.
+
+	  This module provides implementation of the Triple DES EDE cipher
+	  algorithm that is optimized for x86-64 processors. Two versions of
+	  algorithm are provided; regular processing one input block and
+	  one that processes three blocks parallel.
+
+config CRYPTO_SERPENT_SSE2_X86_64
+	tristate "Serpent cipher algorithm (x86_64/SSE2)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_SERPENT
+	select CRYPTO_SIMD
+	imply CRYPTO_CTR
+	help
+	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+
+	  Keys are allowed to be from 0 to 256 bits in length, in steps
+	  of 8 bits.
+
+	  This module provides Serpent cipher algorithm that processes eight
+	  blocks parallel using SSE2 instruction set.
+
+	  See also:
+	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+
+config CRYPTO_SERPENT_SSE2_586
+	tristate "Serpent cipher algorithm (i586/SSE2)"
+	depends on X86 && !64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_SERPENT
+	select CRYPTO_SIMD
+	imply CRYPTO_CTR
+	help
+	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+
+	  Keys are allowed to be from 0 to 256 bits in length, in steps
+	  of 8 bits.
+
+	  This module provides Serpent cipher algorithm that processes four
+	  blocks parallel using SSE2 instruction set.
+
+	  See also:
+	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+
+config CRYPTO_SERPENT_AVX_X86_64
+	tristate "Serpent cipher algorithm (x86_64/AVX)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_SERPENT
+	select CRYPTO_SIMD
+	imply CRYPTO_XTS
+	imply CRYPTO_CTR
+	help
+	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+
+	  Keys are allowed to be from 0 to 256 bits in length, in steps
+	  of 8 bits.
+
+	  This module provides the Serpent cipher algorithm that processes
+	  eight blocks parallel using the AVX instruction set.
+
+	  See also:
+	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+
+config CRYPTO_SERPENT_AVX2_X86_64
+	tristate "Serpent cipher algorithm (x86_64/AVX2)"
+	depends on X86 && 64BIT
+	select CRYPTO_SERPENT_AVX_X86_64
+	help
+	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+
+	  Keys are allowed to be from 0 to 256 bits in length, in steps
+	  of 8 bits.
+
+	  This module provides Serpent cipher algorithm that processes 16
+	  blocks parallel using AVX2 instruction set.
+
+	  See also:
+	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+
+config CRYPTO_SM4_AESNI_AVX_X86_64
+	tristate "SM4 cipher algorithm (x86_64/AES-NI/AVX)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_SIMD
+	select CRYPTO_ALGAPI
+	select CRYPTO_SM4
+	help
+	  SM4 cipher algorithms (OSCCA GB/T 32907-2016) (x86_64/AES-NI/AVX).
+
+	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
+	  Organization of State Commercial Administration of China (OSCCA)
+	  as an authorized cryptographic algorithms for the use within China.
+
+	  This is SM4 optimized implementation using AES-NI/AVX/x86_64
+	  instruction set for block cipher. Through two affine transforms,
+	  we can use the AES S-Box to simulate the SM4 S-Box to achieve the
+	  effect of instruction acceleration.
+
+	  If unsure, say N.
+
+config CRYPTO_SM4_AESNI_AVX2_X86_64
+	tristate "SM4 cipher algorithm (x86_64/AES-NI/AVX2)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_SIMD
+	select CRYPTO_ALGAPI
+	select CRYPTO_SM4
+	select CRYPTO_SM4_AESNI_AVX_X86_64
+	help
+	  SM4 cipher algorithms (OSCCA GB/T 32907-2016) (x86_64/AES-NI/AVX2).
+
+	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
+	  Organization of State Commercial Administration of China (OSCCA)
+	  as an authorized cryptographic algorithms for the use within China.
+
+	  This is SM4 optimized implementation using AES-NI/AVX2/x86_64
+	  instruction set for block cipher. Through two affine transforms,
+	  we can use the AES S-Box to simulate the SM4 S-Box to achieve the
+	  effect of instruction acceleration.
+
+	  If unsure, say N.
+
+config CRYPTO_TWOFISH_586
+	tristate "Twofish cipher algorithms (i586)"
+	depends on (X86 || UML_X86) && !64BIT
+	select CRYPTO_ALGAPI
+	select CRYPTO_TWOFISH_COMMON
+	imply CRYPTO_CTR
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
+config CRYPTO_TWOFISH_X86_64
+	tristate "Twofish cipher algorithm (x86_64)"
+	depends on (X86 || UML_X86) && 64BIT
+	select CRYPTO_ALGAPI
+	select CRYPTO_TWOFISH_COMMON
+	imply CRYPTO_CTR
+	help
+	  Twofish cipher algorithm (x86_64).
+
+	  Twofish was submitted as an AES (Advanced Encryption Standard)
+	  candidate cipher by researchers at CounterPane Systems.  It is a
+	  16 round block cipher supporting key sizes of 128, 192, and 256
+	  bits.
+
+	  See also:
+	  <https://www.schneier.com/twofish.html>
+
+config CRYPTO_TWOFISH_X86_64_3WAY
+	tristate "Twofish cipher algorithm (x86_64, 3-way parallel)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_TWOFISH_COMMON
+	select CRYPTO_TWOFISH_X86_64
+	help
+	  Twofish cipher algorithm (x86_64, 3-way parallel).
+
+	  Twofish was submitted as an AES (Advanced Encryption Standard)
+	  candidate cipher by researchers at CounterPane Systems.  It is a
+	  16 round block cipher supporting key sizes of 128, 192, and 256
+	  bits.
+
+	  This module provides Twofish cipher algorithm that processes three
+	  blocks parallel, utilizing resources of out-of-order CPUs better.
+
+	  See also:
+	  <https://www.schneier.com/twofish.html>
+
+config CRYPTO_TWOFISH_AVX_X86_64
+	tristate "Twofish cipher algorithm (x86_64/AVX)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_SIMD
+	select CRYPTO_TWOFISH_COMMON
+	select CRYPTO_TWOFISH_X86_64
+	select CRYPTO_TWOFISH_X86_64_3WAY
+	imply CRYPTO_XTS
+	help
+	  Twofish cipher algorithm (x86_64/AVX).
+
+	  Twofish was submitted as an AES (Advanced Encryption Standard)
+	  candidate cipher by researchers at CounterPane Systems.  It is a
+	  16 round block cipher supporting key sizes of 128, 192, and 256
+	  bits.
+
+	  This module provides the Twofish cipher algorithm that processes
+	  eight blocks parallel using the AVX Instruction Set.
+
+	  See also:
+	  <https://www.schneier.com/twofish.html>
+
+config CRYPTO_CHACHA20_X86_64
+	tristate "ChaCha stream cipher algorithms (x86_64/SSSE3/AVX2/AVX-512VL)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	help
+	  SSSE3, AVX2, and AVX-512VL optimized implementations of the ChaCha20,
+	  XChaCha20, and XChaCha12 stream ciphers.
+
+config CRYPTO_AEGIS128_AESNI_SSE2
+	tristate "AEGIS-128 AEAD algorithm (x86_64 AESNI+SSE2 implementation)"
+	depends on X86 && 64BIT
+	select CRYPTO_AEAD
+	select CRYPTO_SIMD
+	help
+	 AESNI+SSE2 implementation of the AEGIS-128 dedicated AEAD algorithm.
+
+config CRYPTO_NHPOLY1305_SSE2
+	tristate "NHPoly1305 hash function (x86_64 SSE2 implementation)"
+	depends on X86 && 64BIT
+	select CRYPTO_NHPOLY1305
+	help
+	  SSE2 optimized implementation of the hash function used by the
+	  Adiantum encryption mode.
+
+config CRYPTO_NHPOLY1305_AVX2
+	tristate "NHPoly1305 hash function (x86_64 AVX2 implementation)"
+	depends on X86 && 64BIT
+	select CRYPTO_NHPOLY1305
+	help
+	  AVX2 optimized implementation of the hash function used by the
+	  Adiantum encryption mode.
+
+config CRYPTO_BLAKE2S_X86
+	bool "BLAKE2s digest algorithm (x86 accelerated version)"
+	depends on X86 && 64BIT
+	select CRYPTO_LIB_BLAKE2S_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
+
+config CRYPTO_POLYVAL_CLMUL_NI
+	tristate "POLYVAL hash function (CLMUL-NI accelerated)"
+	depends on X86 && 64BIT
+	select CRYPTO_POLYVAL
+	help
+	  This is the x86_64 CLMUL-NI accelerated implementation of POLYVAL. It is
+	  used to efficiently implement HCTR2 on x86-64 processors that support
+	  carry-less multiplication instructions.
+
+config CRYPTO_POLY1305_X86_64
+	tristate "Poly1305 authenticator algorithm (x86_64/SSE2/AVX2)"
+	depends on X86 && 64BIT
+	select CRYPTO_LIB_POLY1305_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	help
+	  Poly1305 authenticator algorithm, RFC7539.
+
+	  Poly1305 is an authenticator algorithm designed by Daniel J. Bernstein.
+	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
+	  in IETF protocols. This is the x86_64 assembler implementation using SIMD
+	  instructions.
+
+config CRYPTO_SHA1_SSSE3
+	tristate "SHA1 digest algorithm (SSSE3/AVX/AVX2/SHA-NI)"
+	depends on X86 && 64BIT
+	select CRYPTO_SHA1
+	select CRYPTO_HASH
+	help
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
+	  using Supplemental SSE3 (SSSE3) instructions or Advanced Vector
+	  Extensions (AVX/AVX2) or SHA-NI(SHA Extensions New Instructions),
+	  when available.
+
+config CRYPTO_SHA256_SSSE3
+	tristate "SHA256 digest algorithm (SSSE3/AVX/AVX2/SHA-NI)"
+	depends on X86 && 64BIT
+	select CRYPTO_SHA256
+	select CRYPTO_HASH
+	help
+	  SHA-256 secure hash standard (DFIPS 180-2) implemented
+	  using Supplemental SSE3 (SSSE3) instructions, or Advanced Vector
+	  Extensions version 1 (AVX1), or Advanced Vector Extensions
+	  version 2 (AVX2) instructions, or SHA-NI (SHA Extensions New
+	  Instructions) when available.
+
+config CRYPTO_SHA512_SSSE3
+	tristate "SHA512 digest algorithm (SSSE3/AVX/AVX2)"
+	depends on X86 && 64BIT
+	select CRYPTO_SHA512
+	select CRYPTO_HASH
+	help
+	  SHA-512 secure hash standard (DFIPS 180-2) implemented
+	  using Supplemental SSE3 (SSSE3) instructions, or Advanced Vector
+	  Extensions version 1 (AVX1), or Advanced Vector Extensions
+	  version 2 (AVX2) instructions, when available.
+
+config CRYPTO_SM3_AVX_X86_64
+	tristate "SM3 digest algorithm (x86_64/AVX)"
+	depends on X86 && 64BIT
+	select CRYPTO_HASH
+	select CRYPTO_SM3
+	help
+	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3).
+	  It is part of the Chinese Commercial Cryptography suite. This is
+	  SM3 optimized implementation using Advanced Vector Extensions (AVX)
+	  when available.
+
+	  If unsure, say N.
+
+config CRYPTO_GHASH_CLMUL_NI_INTEL
+	tristate "GHASH hash function (CLMUL-NI accelerated)"
+	depends on X86 && 64BIT
+	select CRYPTO_CRYPTD
+	help
+	  This is the x86_64 CLMUL-NI accelerated implementation of
+	  GHASH, the hash function used in GCM (Galois/Counter mode).
+
+config CRYPTO_CRC32C_INTEL
+	tristate "CRC32c INTEL hardware acceleration"
+	depends on X86
+	select CRYPTO_HASH
+	help
+	  In Intel processor with SSE4.2 supported, the processor will
+	  support CRC32C implementation using hardware accelerated CRC32
+	  instruction. This option will create 'crc32c-intel' module,
+	  which will enable any routine to use the CRC32 instruction to
+	  gain performance compared with software implementation.
+	  Module will be crc32c-intel.
+
+config CRYPTO_CRC32_PCLMUL
+	tristate "CRC32 PCLMULQDQ hardware acceleration"
+	depends on X86
+	select CRYPTO_HASH
+	select CRC32
+	help
+	  From Intel Westmere and AMD Bulldozer processor with SSE4.2
+	  and PCLMULQDQ supported, the processor will support
+	  CRC32 PCLMULQDQ implementation using hardware accelerated PCLMULQDQ
+	  instruction. This option will create 'crc32-pclmul' module,
+	  which will enable any routine to use the CRC-32-IEEE 802.3 checksum
+	  and gain better performance as compared with the table implementation.
+
+config CRYPTO_CRCT10DIF_PCLMUL
+	tristate "CRCT10DIF PCLMULQDQ hardware acceleration"
+	depends on X86 && 64BIT && CRC_T10DIF
+	select CRYPTO_HASH
+	help
+	  For x86_64 processors with SSE4.2 and PCLMULQDQ supported,
+	  CRC T10 DIF PCLMULQDQ computation can be hardware
+	  accelerated PCLMULQDQ instruction. This option will create
+	  'crct10dif-pclmul' module, which is faster when computing the
+	  crct10dif checksum as compared with the generic table implementation.
+
+endmenu
diff --git a/crypto/Kconfig b/crypto/Kconfig
index e73a344e00de..3d029b7ca316 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -316,12 +316,6 @@ config CRYPTO_CURVE25519
 	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
 
-config CRYPTO_CURVE25519_X86
-	tristate "x86_64 accelerated Curve25519 scalar multiplication library"
-	depends on X86 && 64BIT
-	select CRYPTO_LIB_CURVE25519_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
-
 comment "Authenticated Encryption with Associated Data"
 
 config CRYPTO_CCM
@@ -369,14 +363,6 @@ config CRYPTO_AEGIS128_SIMD
 	depends on CRYPTO_AEGIS128 && ((ARM || ARM64) && KERNEL_MODE_NEON)
 	default y
 
-config CRYPTO_AEGIS128_AESNI_SSE2
-	tristate "AEGIS-128 AEAD algorithm (x86_64 AESNI+SSE2 implementation)"
-	depends on X86 && 64BIT
-	select CRYPTO_AEAD
-	select CRYPTO_SIMD
-	help
-	 AESNI+SSE2 implementation of the AEGIS-128 dedicated AEAD algorithm.
-
 config CRYPTO_SEQIV
 	tristate "Sequence Number IV Generator"
 	select CRYPTO_AEAD
@@ -514,22 +500,6 @@ config CRYPTO_NHPOLY1305
 	select CRYPTO_HASH
 	select CRYPTO_LIB_POLY1305_GENERIC
 
-config CRYPTO_NHPOLY1305_SSE2
-	tristate "NHPoly1305 hash function (x86_64 SSE2 implementation)"
-	depends on X86 && 64BIT
-	select CRYPTO_NHPOLY1305
-	help
-	  SSE2 optimized implementation of the hash function used by the
-	  Adiantum encryption mode.
-
-config CRYPTO_NHPOLY1305_AVX2
-	tristate "NHPoly1305 hash function (x86_64 AVX2 implementation)"
-	depends on X86 && 64BIT
-	select CRYPTO_NHPOLY1305
-	help
-	  AVX2 optimized implementation of the hash function used by the
-	  Adiantum encryption mode.
-
 config CRYPTO_ADIANTUM
 	tristate "Adiantum support"
 	select CRYPTO_CHACHA20
@@ -646,18 +616,6 @@ config CRYPTO_CRC32C
 	  by iSCSI for header and data digests and by others.
 	  See Castagnoli93.  Module will be crc32c.
 
-config CRYPTO_CRC32C_INTEL
-	tristate "CRC32c INTEL hardware acceleration"
-	depends on X86
-	select CRYPTO_HASH
-	help
-	  In Intel processor with SSE4.2 supported, the processor will
-	  support CRC32C implementation using hardware accelerated CRC32
-	  instruction. This option will create 'crc32c-intel' module,
-	  which will enable any routine to use the CRC32 instruction to
-	  gain performance compared with software implementation.
-	  Module will be crc32c-intel.
-
 config CRYPTO_CRC32
 	tristate "CRC32 CRC algorithm"
 	select CRYPTO_HASH
@@ -666,19 +624,6 @@ config CRYPTO_CRC32
 	  CRC-32-IEEE 802.3 cyclic redundancy-check algorithm.
 	  Shash crypto api wrappers to crc32_le function.
 
-config CRYPTO_CRC32_PCLMUL
-	tristate "CRC32 PCLMULQDQ hardware acceleration"
-	depends on X86
-	select CRYPTO_HASH
-	select CRC32
-	help
-	  From Intel Westmere and AMD Bulldozer processor with SSE4.2
-	  and PCLMULQDQ supported, the processor will support
-	  CRC32 PCLMULQDQ implementation using hardware accelerated PCLMULQDQ
-	  instruction. This option will create 'crc32-pclmul' module,
-	  which will enable any routine to use the CRC-32-IEEE 802.3 checksum
-	  and gain better performance as compared with the table implementation.
-
 config CRYPTO_XXHASH
 	tristate "xxHash hash algorithm"
 	select CRYPTO_HASH
@@ -704,12 +649,6 @@ config CRYPTO_BLAKE2B
 
 	  See https://blake2.net for further information.
 
-config CRYPTO_BLAKE2S_X86
-	bool "BLAKE2s digest algorithm (x86 accelerated version)"
-	depends on X86 && 64BIT
-	select CRYPTO_LIB_BLAKE2S_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
-
 config CRYPTO_CRCT10DIF
 	tristate "CRCT10DIF algorithm"
 	select CRYPTO_HASH
@@ -718,17 +657,6 @@ config CRYPTO_CRCT10DIF
 	  a crypto transform.  This allows for faster crc t10 diff
 	  transforms to be used if they are available.
 
-config CRYPTO_CRCT10DIF_PCLMUL
-	tristate "CRCT10DIF PCLMULQDQ hardware acceleration"
-	depends on X86 && 64BIT && CRC_T10DIF
-	select CRYPTO_HASH
-	help
-	  For x86_64 processors with SSE4.2 and PCLMULQDQ supported,
-	  CRC T10 DIF PCLMULQDQ computation can be hardware
-	  accelerated PCLMULQDQ instruction. This option will create
-	  'crct10dif-pclmul' module, which is faster when computing the
-	  crct10dif checksum as compared with the generic table implementation.
-
 config CRYPTO_CRC64_ROCKSOFT
 	tristate "Rocksoft Model CRC64 algorithm"
 	depends on CRC64
@@ -750,15 +678,6 @@ config CRYPTO_POLYVAL
 	  POLYVAL is the hash function used in HCTR2.  It is not a general-purpose
 	  cryptographic hash function.
 
-config CRYPTO_POLYVAL_CLMUL_NI
-	tristate "POLYVAL hash function (CLMUL-NI accelerated)"
-	depends on X86 && 64BIT
-	select CRYPTO_POLYVAL
-	help
-	  This is the x86_64 CLMUL-NI accelerated implementation of POLYVAL. It is
-	  used to efficiently implement HCTR2 on x86-64 processors that support
-	  carry-less multiplication instructions.
-
 config CRYPTO_POLY1305
 	tristate "Poly1305 authenticator algorithm"
 	select CRYPTO_HASH
@@ -770,19 +689,6 @@ config CRYPTO_POLY1305
 	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
 	  in IETF protocols. This is the portable C implementation of Poly1305.
 
-config CRYPTO_POLY1305_X86_64
-	tristate "Poly1305 authenticator algorithm (x86_64/SSE2/AVX2)"
-	depends on X86 && 64BIT
-	select CRYPTO_LIB_POLY1305_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-	help
-	  Poly1305 authenticator algorithm, RFC7539.
-
-	  Poly1305 is an authenticator algorithm designed by Daniel J. Bernstein.
-	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
-	  in IETF protocols. This is the x86_64 assembler implementation using SIMD
-	  instructions.
-
 config CRYPTO_MD4
 	tristate "MD4 digest algorithm"
 	select CRYPTO_HASH
@@ -828,40 +734,6 @@ config CRYPTO_SHA1
 	help
 	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
 
-config CRYPTO_SHA1_SSSE3
-	tristate "SHA1 digest algorithm (SSSE3/AVX/AVX2/SHA-NI)"
-	depends on X86 && 64BIT
-	select CRYPTO_SHA1
-	select CRYPTO_HASH
-	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
-	  using Supplemental SSE3 (SSSE3) instructions or Advanced Vector
-	  Extensions (AVX/AVX2) or SHA-NI(SHA Extensions New Instructions),
-	  when available.
-
-config CRYPTO_SHA256_SSSE3
-	tristate "SHA256 digest algorithm (SSSE3/AVX/AVX2/SHA-NI)"
-	depends on X86 && 64BIT
-	select CRYPTO_SHA256
-	select CRYPTO_HASH
-	help
-	  SHA-256 secure hash standard (DFIPS 180-2) implemented
-	  using Supplemental SSE3 (SSSE3) instructions, or Advanced Vector
-	  Extensions version 1 (AVX1), or Advanced Vector Extensions
-	  version 2 (AVX2) instructions, or SHA-NI (SHA Extensions New
-	  Instructions) when available.
-
-config CRYPTO_SHA512_SSSE3
-	tristate "SHA512 digest algorithm (SSSE3/AVX/AVX2)"
-	depends on X86 && 64BIT
-	select CRYPTO_SHA512
-	select CRYPTO_HASH
-	help
-	  SHA-512 secure hash standard (DFIPS 180-2) implemented
-	  using Supplemental SSE3 (SSSE3) instructions, or Advanced Vector
-	  Extensions version 1 (AVX1), or Advanced Vector Extensions
-	  version 2 (AVX2) instructions, when available.
-
 config CRYPTO_SHA256
 	tristate "SHA224 and SHA256 digest algorithm"
 	select CRYPTO_HASH
@@ -912,19 +784,6 @@ config CRYPTO_SM3_GENERIC
 	  http://www.oscca.gov.cn/UpFile/20101222141857786.pdf
 	  https://datatracker.ietf.org/doc/html/draft-shen-sm3-hash
 
-config CRYPTO_SM3_AVX_X86_64
-	tristate "SM3 digest algorithm (x86_64/AVX)"
-	depends on X86 && 64BIT
-	select CRYPTO_HASH
-	select CRYPTO_SM3
-	help
-	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3).
-	  It is part of the Chinese Commercial Cryptography suite. This is
-	  SM3 optimized implementation using Advanced Vector Extensions (AVX)
-	  when available.
-
-	  If unsure, say N.
-
 config CRYPTO_STREEBOG
 	tristate "Streebog Hash Function"
 	select CRYPTO_HASH
@@ -949,14 +808,6 @@ config CRYPTO_WP512
 	  See also:
 	  <http://www.larc.usp.br/~pbarreto/WhirlpoolPage.html>
 
-config CRYPTO_GHASH_CLMUL_NI_INTEL
-	tristate "GHASH hash function (CLMUL-NI accelerated)"
-	depends on X86 && 64BIT
-	select CRYPTO_CRYPTD
-	help
-	  This is the x86_64 CLMUL-NI accelerated implementation of
-	  GHASH, the hash function used in GCM (Galois/Counter mode).
-
 comment "Ciphers"
 
 config CRYPTO_AES
@@ -999,38 +850,6 @@ config CRYPTO_AES_TI
 	  block. Interrupts are also disabled to avoid races where cachelines
 	  are evicted when the CPU is interrupted to do something else.
 
-config CRYPTO_AES_NI_INTEL
-	tristate "AES cipher algorithms (AES-NI)"
-	depends on X86
-	select CRYPTO_AEAD
-	select CRYPTO_LIB_AES
-	select CRYPTO_ALGAPI
-	select CRYPTO_SKCIPHER
-	select CRYPTO_SIMD
-	help
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
-
-	  See <http://csrc.nist.gov/encryption/aes/> for more information.
-
-	  In addition to AES cipher algorithm support, the acceleration
-	  for some popular block cipher mode is supported too, including
-	  ECB, CBC, LRW, XTS. The 64 bit version has additional
-	  acceleration for CTR and XCTR.
-
 config CRYPTO_ANUBIS
 	tristate "Anubis cipher algorithm"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
@@ -1082,22 +901,6 @@ config CRYPTO_BLOWFISH_COMMON
 	  See also:
 	  <https://www.schneier.com/blowfish.html>
 
-config CRYPTO_BLOWFISH_X86_64
-	tristate "Blowfish cipher algorithm (x86_64)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_BLOWFISH_COMMON
-	imply CRYPTO_CTR
-	help
-	  Blowfish cipher algorithm (x86_64), by Bruce Schneier.
-
-	  This is a variable key length cipher which can use keys from 32
-	  bits to 448 bits in length.  It's fast, simple and specifically
-	  designed for use on "large microprocessors".
-
-	  See also:
-	  <https://www.schneier.com/blowfish.html>
-
 config CRYPTO_CAMELLIA
 	tristate "Camellia cipher algorithms"
 	select CRYPTO_ALGAPI
@@ -1112,55 +915,6 @@ config CRYPTO_CAMELLIA
 	  See also:
 	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
 
-config CRYPTO_CAMELLIA_X86_64
-	tristate "Camellia cipher algorithm (x86_64)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	imply CRYPTO_CTR
-	help
-	  Camellia cipher algorithm module (x86_64).
-
-	  Camellia is a symmetric key block cipher developed jointly
-	  at NTT and Mitsubishi Electric Corporation.
-
-	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
-
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
-
-config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
-	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_CAMELLIA_X86_64
-	select CRYPTO_SIMD
-	imply CRYPTO_XTS
-	help
-	  Camellia cipher algorithm module (x86_64/AES-NI/AVX).
-
-	  Camellia is a symmetric key block cipher developed jointly
-	  at NTT and Mitsubishi Electric Corporation.
-
-	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
-
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
-
-config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
-	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX2)"
-	depends on X86 && 64BIT
-	select CRYPTO_CAMELLIA_AESNI_AVX_X86_64
-	help
-	  Camellia cipher algorithm module (x86_64/AES-NI/AVX2).
-
-	  Camellia is a symmetric key block cipher developed jointly
-	  at NTT and Mitsubishi Electric Corporation.
-
-	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
-
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
-
 config CRYPTO_CAST_COMMON
 	tristate
 	help
@@ -1175,21 +929,6 @@ config CRYPTO_CAST5
 	  The CAST5 encryption algorithm (synonymous with CAST-128) is
 	  described in RFC2144.
 
-config CRYPTO_CAST5_AVX_X86_64
-	tristate "CAST5 (CAST-128) cipher algorithm (x86_64/AVX)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_CAST5
-	select CRYPTO_CAST_COMMON
-	select CRYPTO_SIMD
-	imply CRYPTO_CTR
-	help
-	  The CAST5 encryption algorithm (synonymous with CAST-128) is
-	  described in RFC2144.
-
-	  This module provides the Cast5 cipher algorithm that processes
-	  sixteen blocks parallel using the AVX instruction set.
-
 config CRYPTO_CAST6
 	tristate "CAST6 (CAST-256) cipher algorithm"
 	select CRYPTO_ALGAPI
@@ -1198,22 +937,6 @@ config CRYPTO_CAST6
 	  The CAST6 encryption algorithm (synonymous with CAST-256) is
 	  described in RFC2612.
 
-config CRYPTO_CAST6_AVX_X86_64
-	tristate "CAST6 (CAST-256) cipher algorithm (x86_64/AVX)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_CAST6
-	select CRYPTO_CAST_COMMON
-	select CRYPTO_SIMD
-	imply CRYPTO_XTS
-	imply CRYPTO_CTR
-	help
-	  The CAST6 encryption algorithm (synonymous with CAST-256) is
-	  described in RFC2612.
-
-	  This module provides the Cast6 cipher algorithm that processes
-	  eight blocks parallel using the AVX instruction set.
-
 config CRYPTO_DES
 	tristate "DES and Triple DES EDE cipher algorithms"
 	select CRYPTO_ALGAPI
@@ -1221,20 +944,6 @@ config CRYPTO_DES
 	help
 	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
 
-config CRYPTO_DES3_EDE_X86_64
-	tristate "Triple DES EDE cipher algorithm (x86-64)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_DES
-	imply CRYPTO_CTR
-	help
-	  Triple DES EDE (FIPS 46-3) algorithm.
-
-	  This module provides implementation of the Triple DES EDE cipher
-	  algorithm that is optimized for x86-64 processors. Two versions of
-	  algorithm are provided; regular processing one input block and
-	  one that processes three blocks parallel.
-
 config CRYPTO_FCRYPT
 	tristate "FCrypt cipher algorithm"
 	select CRYPTO_ALGAPI
@@ -1278,16 +987,6 @@ config CRYPTO_CHACHA20
 	  reduced security margin but increased performance.  It can be needed
 	  in some performance-sensitive scenarios.
 
-config CRYPTO_CHACHA20_X86_64
-	tristate "ChaCha stream cipher algorithms (x86_64/SSSE3/AVX2/AVX-512VL)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	help
-	  SSSE3, AVX2, and AVX-512VL optimized implementations of the ChaCha20,
-	  XChaCha20, and XChaCha12 stream ciphers.
-
 config CRYPTO_SEED
 	tristate "SEED cipher algorithm"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
@@ -1330,80 +1029,6 @@ config CRYPTO_SERPENT
 	  See also:
 	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
 
-config CRYPTO_SERPENT_SSE2_X86_64
-	tristate "Serpent cipher algorithm (x86_64/SSE2)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_SERPENT
-	select CRYPTO_SIMD
-	imply CRYPTO_CTR
-	help
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
-
-	  Keys are allowed to be from 0 to 256 bits in length, in steps
-	  of 8 bits.
-
-	  This module provides Serpent cipher algorithm that processes eight
-	  blocks parallel using SSE2 instruction set.
-
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
-
-config CRYPTO_SERPENT_SSE2_586
-	tristate "Serpent cipher algorithm (i586/SSE2)"
-	depends on X86 && !64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_SERPENT
-	select CRYPTO_SIMD
-	imply CRYPTO_CTR
-	help
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
-
-	  Keys are allowed to be from 0 to 256 bits in length, in steps
-	  of 8 bits.
-
-	  This module provides Serpent cipher algorithm that processes four
-	  blocks parallel using SSE2 instruction set.
-
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
-
-config CRYPTO_SERPENT_AVX_X86_64
-	tristate "Serpent cipher algorithm (x86_64/AVX)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_SERPENT
-	select CRYPTO_SIMD
-	imply CRYPTO_XTS
-	imply CRYPTO_CTR
-	help
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
-
-	  Keys are allowed to be from 0 to 256 bits in length, in steps
-	  of 8 bits.
-
-	  This module provides the Serpent cipher algorithm that processes
-	  eight blocks parallel using the AVX instruction set.
-
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
-
-config CRYPTO_SERPENT_AVX2_X86_64
-	tristate "Serpent cipher algorithm (x86_64/AVX2)"
-	depends on X86 && 64BIT
-	select CRYPTO_SERPENT_AVX_X86_64
-	help
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
-
-	  Keys are allowed to be from 0 to 256 bits in length, in steps
-	  of 8 bits.
-
-	  This module provides Serpent cipher algorithm that processes 16
-	  blocks parallel using AVX2 instruction set.
-
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
-
 config CRYPTO_SM4
 	tristate
 
@@ -1433,49 +1058,6 @@ config CRYPTO_SM4_GENERIC
 
 	  If unsure, say N.
 
-config CRYPTO_SM4_AESNI_AVX_X86_64
-	tristate "SM4 cipher algorithm (x86_64/AES-NI/AVX)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_SIMD
-	select CRYPTO_ALGAPI
-	select CRYPTO_SM4
-	help
-	  SM4 cipher algorithms (OSCCA GB/T 32907-2016) (x86_64/AES-NI/AVX).
-
-	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
-	  Organization of State Commercial Administration of China (OSCCA)
-	  as an authorized cryptographic algorithms for the use within China.
-
-	  This is SM4 optimized implementation using AES-NI/AVX/x86_64
-	  instruction set for block cipher. Through two affine transforms,
-	  we can use the AES S-Box to simulate the SM4 S-Box to achieve the
-	  effect of instruction acceleration.
-
-	  If unsure, say N.
-
-config CRYPTO_SM4_AESNI_AVX2_X86_64
-	tristate "SM4 cipher algorithm (x86_64/AES-NI/AVX2)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_SIMD
-	select CRYPTO_ALGAPI
-	select CRYPTO_SM4
-	select CRYPTO_SM4_AESNI_AVX_X86_64
-	help
-	  SM4 cipher algorithms (OSCCA GB/T 32907-2016) (x86_64/AES-NI/AVX2).
-
-	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
-	  Organization of State Commercial Administration of China (OSCCA)
-	  as an authorized cryptographic algorithms for the use within China.
-
-	  This is SM4 optimized implementation using AES-NI/AVX2/x86_64
-	  instruction set for block cipher. Through two affine transforms,
-	  we can use the AES S-Box to simulate the SM4 S-Box to achieve the
-	  effect of instruction acceleration.
-
-	  If unsure, say N.
-
 config CRYPTO_TEA
 	tristate "TEA, XTEA and XETA cipher algorithms"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
@@ -1515,83 +1097,6 @@ config CRYPTO_TWOFISH_COMMON
 	  Common parts of the Twofish cipher algorithm shared by the
 	  generic c and the assembler implementations.
 
-config CRYPTO_TWOFISH_586
-	tristate "Twofish cipher algorithms (i586)"
-	depends on (X86 || UML_X86) && !64BIT
-	select CRYPTO_ALGAPI
-	select CRYPTO_TWOFISH_COMMON
-	imply CRYPTO_CTR
-	help
-	  Twofish cipher algorithm.
-
-	  Twofish was submitted as an AES (Advanced Encryption Standard)
-	  candidate cipher by researchers at CounterPane Systems.  It is a
-	  16 round block cipher supporting key sizes of 128, 192, and 256
-	  bits.
-
-	  See also:
-	  <https://www.schneier.com/twofish.html>
-
-config CRYPTO_TWOFISH_X86_64
-	tristate "Twofish cipher algorithm (x86_64)"
-	depends on (X86 || UML_X86) && 64BIT
-	select CRYPTO_ALGAPI
-	select CRYPTO_TWOFISH_COMMON
-	imply CRYPTO_CTR
-	help
-	  Twofish cipher algorithm (x86_64).
-
-	  Twofish was submitted as an AES (Advanced Encryption Standard)
-	  candidate cipher by researchers at CounterPane Systems.  It is a
-	  16 round block cipher supporting key sizes of 128, 192, and 256
-	  bits.
-
-	  See also:
-	  <https://www.schneier.com/twofish.html>
-
-config CRYPTO_TWOFISH_X86_64_3WAY
-	tristate "Twofish cipher algorithm (x86_64, 3-way parallel)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_TWOFISH_COMMON
-	select CRYPTO_TWOFISH_X86_64
-	help
-	  Twofish cipher algorithm (x86_64, 3-way parallel).
-
-	  Twofish was submitted as an AES (Advanced Encryption Standard)
-	  candidate cipher by researchers at CounterPane Systems.  It is a
-	  16 round block cipher supporting key sizes of 128, 192, and 256
-	  bits.
-
-	  This module provides Twofish cipher algorithm that processes three
-	  blocks parallel, utilizing resources of out-of-order CPUs better.
-
-	  See also:
-	  <https://www.schneier.com/twofish.html>
-
-config CRYPTO_TWOFISH_AVX_X86_64
-	tristate "Twofish cipher algorithm (x86_64/AVX)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_SIMD
-	select CRYPTO_TWOFISH_COMMON
-	select CRYPTO_TWOFISH_X86_64
-	select CRYPTO_TWOFISH_X86_64_3WAY
-	imply CRYPTO_XTS
-	help
-	  Twofish cipher algorithm (x86_64/AVX).
-
-	  Twofish was submitted as an AES (Advanced Encryption Standard)
-	  candidate cipher by researchers at CounterPane Systems.  It is a
-	  16 round block cipher supporting key sizes of 128, 192, and 256
-	  bits.
-
-	  This module provides the Twofish cipher algorithm that processes
-	  eight blocks parallel using the AVX Instruction Set.
-
-	  See also:
-	  <https://www.schneier.com/twofish.html>
-
 comment "Compression"
 
 config CRYPTO_DEFLATE
@@ -1799,6 +1304,9 @@ config CRYPTO_HASH_INFO
 if SPARC
 source "arch/sparc/crypto/Kconfig"
 endif
+if X86
+source "arch/x86/crypto/Kconfig"
+endif
 
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
-- 
2.37.1

