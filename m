Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EF459AFC0
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbiHTSnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiHTSmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:51 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC6F45996;
        Sat, 20 Aug 2022 11:42:35 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KHXQjO028512;
        Sat, 20 Aug 2022 18:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=1plaEk66//5jU3qCUGyMS4sfWtNt3ivEuSufy74NEwY=;
 b=bWSQh4Qv92nXdEMersnRcrI+Lk5cGRRSNt5RrBFXAaTZ9ObIFe1In89cI5N/gQKo9aM1
 e0xpzslkVIpA5xJDEP7vatPNZRiU32s+LMiJzOFHiGMeRxDIWdToZaAdRnUIYjSxtdsz
 OgORci+M5OzyCNAIiOeOwiQ4yMKIsWjyEgKeYDiRiovNIh/XNyB55Qgon0ITqPL3EAGx
 CXtlpBcbYDsGBoHJD0jL+gd8LWXKUUni5d81SJGSbzT5v1GhHSttFJBp4StFk69WXACl
 Zyb/EUcbXZ7eDnbQPPtWTIzS1e1DaPx+Z9XIZggwxkD5/HVJ7m0lCgWEA1+cEn1OHz/H Uw== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j32wvrjk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:25 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 29884D2E4;
        Sat, 20 Aug 2022 18:42:25 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id C5D9E803510;
        Sat, 20 Aug 2022 18:42:24 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 16/17] crypto: Kconfig - simplify cipher entries
Date:   Sat, 20 Aug 2022 13:41:50 -0500
Message-Id: <20220820184151.1149247-17-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
Content-Type: text/plain; charset=UTF-8
X-Proofpoint-GUID: RdkawUKgtsBuPAXD3ui1ahusgXY_mK92
X-Proofpoint-ORIG-GUID: RdkawUKgtsBuPAXD3ui1ahusgXY_mK92
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
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

Shorten menu titles and make them consistent:
- acronym
- name
- architecture features in parenthesis
- no suffixes like "<something> algorithm", "support", or
  "hardware acceleration", or "optimized"

Simplify help text descriptions, update references, and ensure that
https references are still valid.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/arm/crypto/Kconfig     |  40 ++++--
 arch/arm64/crypto/Kconfig   | 109 ++++++++++++--
 arch/mips/crypto/Kconfig    |   7 +-
 arch/powerpc/crypto/Kconfig |  14 +-
 arch/s390/crypto/Kconfig    |  28 ++--
 arch/sparc/crypto/Kconfig   |  48 ++-----
 arch/x86/crypto/Kconfig     | 274 ++++++++++++++----------------------
 crypto/Kconfig              | 234 +++++++++++++++---------------
 8 files changed, 410 insertions(+), 344 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index e64e9b8418d6..3858c4d4cb98 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -144,11 +144,13 @@ config CRYPTO_SHA512_ARM
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_AES_ARM
-	tristate "Scalar AES cipher for ARM"
+	tristate "Ciphers: AES"
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES
 	help
-	  Use optimized AES assembler routines for ARM platforms.
+	  Block ciphers: AES cipher algorithms (FIPS-197)
+
+	  Architecture: arm
 
 	  On ARM processors without the Crypto Extensions, this is the
 	  fastest AES implementation for single blocks.  For multiple
@@ -160,7 +162,7 @@ config CRYPTO_AES_ARM
 	  such attacks very difficult.
 
 config CRYPTO_AES_ARM_BS
-	tristate "Bit sliced AES using NEON instructions"
+	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XTS (bit-sliced NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_AES
@@ -168,8 +170,13 @@ config CRYPTO_AES_ARM_BS
 	select CRYPTO_CBC
 	select CRYPTO_SIMD
 	help
-	  Use a faster and more secure NEON based implementation of AES in CBC,
-	  CTR and XTS modes
+	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
+	  with block cipher modes:
+	   - ECB (Electronic Codebook) mode (NIST SP800-38A)
+	   - CBC (Cipher Block Chaining) mode (NIST SP800-38A)
+	   - CTR (Counter) mode (NIST SP800-38A)
+	   - XTS (XOR Encrypt XOR with ciphertext stealing) mode (NIST SP800-38E
+	     and IEEE 1619)
 
 	  Bit sliced AES gives around 45% speedup on Cortex-A15 for CTR mode
 	  and for XTS mode encryption, CBC and XTS mode decryption speedup is
@@ -178,19 +185,34 @@ config CRYPTO_AES_ARM_BS
 	  believed to be invulnerable to cache timing attacks.
 
 config CRYPTO_AES_ARM_CE
-	tristate "Accelerated AES using ARMv8 Crypto Extensions"
+	tristate "Ciphers: AES, modes: ECB/CBC/CTS/CTR/XTS (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_AES
 	select CRYPTO_SIMD
 	help
-	  Use an implementation of AES in CBC, CTR and XTS modes that uses
-	  ARMv8 Crypto Extensions
+	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
+	   with block cipher modes:
+	   - ECB (Electronic Codebook) mode (NIST SP800-38A)
+	   - CBC (Cipher Block Chaining) mode (NIST SP800-38A)
+	   - CTR (Counter) mode (NIST SP800-38A)
+	   - CTS (Cipher Text Stealing) mode (NIST SP800-38A)
+	   - XTS (XOR Encrypt XOR with ciphertext stealing) mode (NIST SP800-38E
+	     and IEEE 1619)
+
+	  Architecture: arm using:
+	  - ARMv8 Crypto Extensions
 
 config CRYPTO_CHACHA20_NEON
-	tristate "NEON and scalar accelerated ChaCha stream cipher algorithms"
+	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (NEON)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	help
+	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
+	  stream cipher algorithms
+
+	  Architecture: arm using:
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_CRC32_ARM_CE
 	tristate "CRC32C and CRC32"
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 709598f6d2e3..7ba9bcb6d409 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -118,66 +118,155 @@ config CRYPTO_POLYVAL_ARM64_CE
 	  - ARMv8 Crypto Extensions
 
 config CRYPTO_AES_ARM64
-	tristate "AES core cipher using scalar instructions"
+	tristate "Ciphers: AES, modes: ECB, CBC, CTR, CTS, XCTR, XTS"
 	select CRYPTO_AES
+	help
+	  Block ciphers: AES cipher algorithms (FIPS-197)
+	  Length-preserving ciphers: AES with ECB, CBC, CTR, CTS,
+	    XCTR, and XTS modes
+	  AEAD cipher: AES with CBC, ESSIV, and SHA-256
+	    for fscrypt and dm-crypt
+
+	  Architecture: arm64
 
 config CRYPTO_AES_ARM64_CE
-	tristate "AES core cipher using ARMv8 Crypto Extensions"
+	tristate "Ciphers: AES (ARMv8 Crypto Extensions)"
 	depends on ARM64 && KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
+	help
+	  Block ciphers: AES cipher algorithms (FIPS-197)
+
+	  Architecture: arm64 using:
+	  - ARMv8 Crypto Extensions
 
 config CRYPTO_AES_ARM64_CE_BLK
-	tristate "AES in ECB/CBC/CTR/XTS/XCTR modes using ARMv8 Crypto Extensions"
+	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XTS (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_AES_ARM64_CE
+	help
+	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
+	  with block cipher modes:
+	  - ECB (Electronic Codebook) mode (NIST SP800-38A)
+	  - CBC (Cipher Block Chaining) mode (NIST SP800-38A)
+	  - CTR (Counter) mode (NIST SP800-38A)
+	  - XTS (XOR Encrypt XOR with ciphertext stealing) mode (NIST SP800-38E
+	    and IEEE 1619)
+
+	  Architecture: arm64 using:
+	  - ARMv8 Crypto Extensions
 
 config CRYPTO_AES_ARM64_NEON_BLK
-	tristate "AES in ECB/CBC/CTR/XTS/XCTR modes using NEON instructions"
+	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XTS (NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_AES
+	help
+	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
+	  with block cipher modes:
+	  - ECB (Electronic Codebook) mode (NIST SP800-38A)
+	  - CBC (Cipher Block Chaining) mode (NIST SP800-38A)
+	  - CTR (Counter) mode (NIST SP800-38A)
+	  - XTS (XOR Encrypt XOR with ciphertext stealing) mode (NIST SP800-38E
+	    and IEEE 1619)
+
+	  Architecture: arm64 using:
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_CHACHA20_NEON
-	tristate "ChaCha20, XChaCha20, and XChaCha12 stream ciphers using NEON instructions"
+	tristate "Ciphers: ChaCha (NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	help
+	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
+	  stream cipher algorithms
+
+	  Architecture: arm64 using:
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_AES_ARM64_BS
-	tristate "AES in ECB/CBC/CTR/XTS modes using bit-sliced NEON algorithm"
+	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XCTR/XTS modes (bit-sliced NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_AES_ARM64_NEON_BLK
 	select CRYPTO_LIB_AES
+	help
+	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
+	  with block cipher modes:
+	  - ECB (Electronic Codebook) mode (NIST SP800-38A)
+	  - CBC (Cipher Block Chaining) mode (NIST SP800-38A)
+	  - CTR (Counter) mode (NIST SP800-38A)
+	  - XCTR mode for HCTR2
+	  - XTS (XOR Encrypt XOR with ciphertext stealing) mode (NIST SP800-38E
+	    and IEEE 1619)
+
+	  Architecture: arm64 using:
+	  - bit-sliced algorithm
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SM4_ARM64_CE
-	tristate "SM4 symmetric cipher (ARMv8.2 Crypto Extensions)"
+	tristate "Ciphers: SM4 (ARMv8.2 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
+	help
+	  Block ciphers: SM4 cipher algorithms (OSCCA GB/T 32907-2016)
+
+	  Architecture: arm64 using:
+	  - ARMv8.2 Crypto Extensions
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SM4_ARM64_CE_BLK
-	tristate "SM4 in ECB/CBC/CFB/CTR modes using ARMv8 Crypto Extensions"
+	tristate "Ciphers: SM4, modes: ECB/CBC/CFB/CTR (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SM4
+	help
+	  Length-preserving ciphers: SM4 cipher algorithms (OSCCA GB/T 32907-2016)
+	  with block cipher modes:
+	  - ECB (Electronic Codebook) mode (NIST SP800-38A)
+	  - CBC (Cipher Block Chaining) mode (NIST SP800-38A)
+	  - CFB (Cipher Feedback) mode (NIST SP800-38A)
+	  - CTR (Counter) mode (NIST SP800-38A)
+
+	  Architecture: arm64 using:
+	  - ARMv8 Crypto Extensions
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SM4_ARM64_NEON_BLK
-	tristate "SM4 in ECB/CBC/CFB/CTR modes using NEON instructions"
+	tristate "Ciphers: SM4, modes: ECB/CBC/CFB/CTR (NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SM4
+	help
+	  Length-preserving ciphers: SM4 cipher algorithms (OSCCA GB/T 32907-2016)
+	  with block cipher modes:
+	  - ECB (Electronic Codebook) mode (NIST SP800-38A)
+	  - CBC (Cipher Block Chaining) mode (NIST SP800-38A)
+	  - CFB (Cipher Feedback) mode (NIST SP800-38A)
+	  - CTR (Counter) mode (NIST SP800-38A)
+
+	  Architecture: arm64 using:
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_AES_ARM64_CE_CCM
-	tristate "AES in CCM mode using ARMv8 Crypto Extensions"
+	tristate "AEAD cipher: AES in CCM mode (ARMv8 Crypto Extensions)"
 	depends on ARM64 && KERNEL_MODE_NEON
 	select CRYPTO_ALGAPI
 	select CRYPTO_AES_ARM64_CE
 	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
+	help
+	  AEAD cipher: AES cipher algorithms (FIPS-197) with
+	  CCM (Counter with Cipher Block Chaining-Message Authentication Code)
+	  authenticated encryption mode (NIST SP800-38C)
+
+	  Architecture: arm64 using:
+	  - ARMv8 Crypto Extensions
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_CRCT10DIF_ARM64_CE
 	tristate "CRCT10DIF (PMULL)"
diff --git a/arch/mips/crypto/Kconfig b/arch/mips/crypto/Kconfig
index de162f69675c..9003a5c1e879 100644
--- a/arch/mips/crypto/Kconfig
+++ b/arch/mips/crypto/Kconfig
@@ -61,9 +61,14 @@ config CRYPTO_SHA512_OCTEON
 	  Architecture: mips OCTEON using crypto instructions, when available
 
 config CRYPTO_CHACHA_MIPS
-	tristate "ChaCha stream cipher algorithms (MIPS 32r2 optimized)"
+	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (MIPS32r2)"
 	depends on CPU_MIPS32_R2
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	help
+	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
+	  stream cipher algorithms
+
+	  Architecture: MIPS32r2
 
 endmenu
diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 5a4770a029ef..c1b964447401 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -73,12 +73,20 @@ config CRYPTO_SHA256_PPC_SPE
 	  - SPE (Signal Processing Engine) extensions
 
 config CRYPTO_AES_PPC_SPE
-	tristate "AES cipher algorithms (PPC SPE)"
+	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XTS (SPE)"
 	depends on PPC && SPE
 	select CRYPTO_SKCIPHER
 	help
-	  AES cipher algorithms (FIPS-197). Additionally the acceleration
-	  for popular block cipher modes ECB, CBC, CTR and XTS is supported.
+	  Block ciphers: AES cipher algorithms (FIPS-197)
+	  Length-preserving ciphers: AES with ECB, CBC, CTR, and XTS modes
+
+	  Architecture: powerpc using:
+	  - SPE (Signal Processing Engine) extensions
+
+	  SPE is available for:
+	  - Processor Type: Freescale 8500
+	  - CPU selection: e500 (8540)
+
 	  This module should only be used for low power (router) devices
 	  without hardware AES acceleration (e.g. caam crypto). It reduces the
 	  size of the AES tables from 16KB to 8KB + 256 bytes and mitigates
diff --git a/arch/s390/crypto/Kconfig b/arch/s390/crypto/Kconfig
index 04cc3a6467ab..06ee706b0d78 100644
--- a/arch/s390/crypto/Kconfig
+++ b/arch/s390/crypto/Kconfig
@@ -81,44 +81,54 @@ config CRYPTO_GHASH_S390
 	  It is available as of z196.
 
 config CRYPTO_AES_S390
-	tristate "AES cipher algorithms"
+	tristate "Ciphers: AES, modes: ECB, CBC, CTR, XTS, GCM"
 	depends on S390
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  AES cipher algorithms (FIPS-197).
+	  Block cipher: AES cipher algorithms (FIPS 197)
+	  AEAD cipher: AES with GCM
+	  Length-preserving ciphers: AES with ECB, CBC, XTS, and CTR modes
+
+	  Architecture: s390
 
 	  As of z9 the ECB and CBC modes are hardware accelerated
 	  for 128 bit keys.
+
 	  As of z10 the ECB and CBC modes are hardware accelerated
 	  for all AES key sizes.
+
 	  As of z196 the CTR mode is hardware accelerated for all AES
 	  key sizes and XTS mode is hardware accelerated for 256 and
 	  512 bit keys.
 
 config CRYPTO_DES_S390
-	tristate "DES and Triple DES cipher algorithms"
+	tristate "Ciphers: DES and Triple DES EDE, modes: ECB, CBC, CTR"
 	depends on S390
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
+	  Block ciphers: DES (FIPS 46-2) cipher algorithm
+	  Block ciphers: Triple DES EDE (FIPS 46-3) cipher algorithm
+	  Length-preserving ciphers: DES with ECB, CBC, and CTR modes
+	  Length-preserving ciphers: Triple DES EDED with ECB, CBC, and CTR modes
+
+	  Architecture: s390
 
 	  As of z990 the ECB and CBC mode are hardware accelerated.
 	  As of z196 the CTR mode is hardware accelerated.
 
 config CRYPTO_CHACHA_S390
-	tristate "ChaCha20 stream cipher"
+	tristate "Ciphers: ChaCha20"
 	depends on S390
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	help
-	  This is the s390 SIMD implementation of the ChaCha20 stream
-	  cipher (RFC 7539).
+	  Length-preserving cipher: ChaCha20 stream cipher (RFC 7539)
+
+	  Architecture: s390
 
 	  It is available as of z13.
 
diff --git a/arch/sparc/crypto/Kconfig b/arch/sparc/crypto/Kconfig
index 519348de6860..cfe5102b1c68 100644
--- a/arch/sparc/crypto/Kconfig
+++ b/arch/sparc/crypto/Kconfig
@@ -3,14 +3,18 @@
 menu "Accelerated Cryptographic Algorithms for CPU (sparc64)"
 
 config CRYPTO_DES_SPARC64
-	tristate "DES and Triple DES EDE cipher algorithms (SPARC64)"
+	tristate "Ciphers: DES and Triple DES EDE, modes: ECB/CBC"
 	depends on SPARC64
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_DES
 	select CRYPTO_SKCIPHER
 	help
-	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3),
-	  optimized using SPARC64 crypto opcodes.
+	  Block cipher: DES (FIPS 46-2) cipher algorithm
+	  Block cipher: Triple DES EDE (FIPS 46-3) cipher algorithm
+	  Length-preserving ciphers: DES with ECB and CBC modes
+	  Length-preserving ciphers: Tripe DES EDE with ECB and CBC modes
+
+	  Architecture: sparc64
 
 config CRYPTO_CRC32C_SPARC64
 	tristate "CRC32c"
@@ -63,46 +67,24 @@ config CRYPTO_SHA512_SPARC64
 	  Architecture: sparc64 using crypto instructions, when available
 
 config CRYPTO_AES_SPARC64
-	tristate "AES cipher algorithms (SPARC64)"
+	tristate "Ciphers: AES, modes: ECB, CBC, CTR"
 	depends on SPARC64
 	select CRYPTO_SKCIPHER
 	help
-	  Use SPARC64 crypto opcodes for AES algorithm.
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
+	  Block ciphers: AES cipher algorithms (FIPS-197)
+	  Length-preseving ciphers: AES with ECB, CBC, and CTR modes
 
-	  See <http://csrc.nist.gov/encryption/aes/> for more information.
-
-	  In addition to AES cipher algorithm support, the acceleration
-	  for some popular block cipher mode is supported too, including
-	  ECB and CBC.
+	  Architecture: sparc64 using crypto instructions
 
 config CRYPTO_CAMELLIA_SPARC64
-	tristate "Camellia cipher algorithm (SPARC64)"
+	tristate "Ciphers: Camellia, modes: ECB, CBC"
 	depends on SPARC64
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	help
-	  Camellia cipher algorithm module (SPARC64).
-
-	  Camellia is a symmetric key block cipher developed jointly
-	  at NTT and Mitsubishi Electric Corporation.
+	  Block ciphers: Camellia cipher algorithms
+	  Length-preserving ciphers: Camellia with ECB and CBC modes
 
-	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
-
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+	  Architecture: sparc64
 
 endmenu
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index fc24f4562700..9bb0f7939c6b 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -14,7 +14,7 @@ config CRYPTO_CURVE25519_X86
 	  - ADX (large integer arithmetic)
 
 config CRYPTO_AES_NI_INTEL
-	tristate "AES cipher algorithms (AES-NI)"
+	tristate "Ciphers: AES, modes: ECB, CBC, CTS, CTR, XTR, XTS, GCM (AES-NI)"
 	depends on X86
 	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
@@ -22,96 +22,63 @@ config CRYPTO_AES_NI_INTEL
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
 	help
-	  Use Intel AES-NI instructions for AES algorithm.
+	  Block cipher: AES cipher algorithms
+	  AEAD cipher: AES with GCM
+	  Length-preserving ciphers: AES with ECB, CBC, CTS, CTR, XTR, XTS
 
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
+	  Architecture: x86 (32-bit and 64-bit) using:
+	  - AES-NI (AES new instructions)
 
 config CRYPTO_BLOWFISH_X86_64
-	tristate "Blowfish cipher algorithm (x86_64)"
+	tristate "Ciphers: Blowfish, modes: ECB, CBC"
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
+	  Block cipher: Blowfish cipher algorithm
+	  Length-preserving ciphers: Blowfish with ECB and CBC modes
 
-	  See also:
-	  <https://www.schneier.com/blowfish.html>
+	  Architecture: x86_64
 
 config CRYPTO_CAMELLIA_X86_64
-	tristate "Camellia cipher algorithm (x86_64)"
+	tristate "Ciphers: Camellia with modes: ECB, CBC"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	imply CRYPTO_CTR
 	help
-	  Camellia cipher algorithm module (x86_64).
-
-	  Camellia is a symmetric key block cipher developed jointly
-	  at NTT and Mitsubishi Electric Corporation.
+	  Block cipher: Camellia cipher algorithms
+	  Length-preserving ciphers: Camellia with ECB and CBC modes
 
-	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
-
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+	  Architecture: x86_64
 
 config CRYPTO_CAMELLIA_AESNI_AVX_X86_64
-	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX)"
+	tristate "Ciphers: Camellia with modes: ECB, CBC (AES-NI/AVX)"
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
-
-	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
+	  Length-preserving ciphers: Camellia with ECB and CBC modes
 
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+	  Architecture: x86_64 using:
+	  - AES-NI (AES New Instructions)
+	  - AVX (Advanced Vector Extensions)
 
 config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
-	tristate "Camellia cipher algorithm (x86_64/AES-NI/AVX2)"
+	tristate "Ciphers: Camellia with modes: ECB, CBC (AES-NI/AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_CAMELLIA_AESNI_AVX_X86_64
 	help
-	  Camellia cipher algorithm module (x86_64/AES-NI/AVX2).
+	  Length-preserving ciphers: Camellia with ECB and CBC modes
 
-	  Camellia is a symmetric key block cipher developed jointly
-	  at NTT and Mitsubishi Electric Corporation.
-
-	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
-
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+	  Architecture: x86_64 using:
+	  - AES-NI (AES New Instructions)
+	  - AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_CAST5_AVX_X86_64
-	tristate "CAST5 (CAST-128) cipher algorithm (x86_64/AVX)"
+	tristate "Ciphers: CAST5 with modes: ECB, CBC (AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST5
@@ -119,14 +86,16 @@ config CRYPTO_CAST5_AVX_X86_64
 	select CRYPTO_SIMD
 	imply CRYPTO_CTR
 	help
-	  The CAST5 encryption algorithm (synonymous with CAST-128) is
-	  described in RFC2144.
+	  Length-preserving ciphers: CAST5 (CAST-128) cipher algorithm
+	  (RFC2144) with ECB and CBC modes
 
-	  This module provides the Cast5 cipher algorithm that processes
-	  sixteen blocks parallel using the AVX instruction set.
+	  Architecture: x86_64 using:
+	  - AVX (Advanced Vector Extensions)
+
+	  Processes 16 blocks in parallel.
 
 config CRYPTO_CAST6_AVX_X86_64
-	tristate "CAST6 (CAST-256) cipher algorithm (x86_64/AVX)"
+	tristate "Ciphers: CAST6 with modes: ECB, CBC (AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_CAST6
@@ -135,66 +104,62 @@ config CRYPTO_CAST6_AVX_X86_64
 	imply CRYPTO_XTS
 	imply CRYPTO_CTR
 	help
-	  The CAST6 encryption algorithm (synonymous with CAST-256) is
-	  described in RFC2612.
+	  Length-preserving ciphers: CAST6 (CAST-256) cipher algorithm
+	  (RFC2612) with ECB and CBC modes
+
+	  Architecture: x86_64 using:
+	  - AVX (Advanced Vector Extensions)
 
-	  This module provides the Cast6 cipher algorithm that processes
-	  eight blocks parallel using the AVX instruction set.
+	  Processes eight blocks in parallel.
 
 config CRYPTO_DES3_EDE_X86_64
-	tristate "Triple DES EDE cipher algorithm (x86-64)"
+	tristate "Ciphers: Triple DES EDE with modes: ECB, CBC"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_DES
 	imply CRYPTO_CTR
 	help
-	  Triple DES EDE (FIPS 46-3) algorithm.
+	  Block cipher: Triple DES EDE (FIPS 46-3) cipher algorithm
+	  Length-preserving ciphers: Triple DES EDE with ECB and CBC modes
+
+	  Architecture: x86_64
 
-	  This module provides implementation of the Triple DES EDE cipher
-	  algorithm that is optimized for x86-64 processors. Two versions of
-	  algorithm are provided; regular processing one input block and
-	  one that processes three blocks parallel.
+	  Processes one or three blocks in parallel.
 
 config CRYPTO_SERPENT_SSE2_X86_64
-	tristate "Serpent cipher algorithm (x86_64/SSE2)"
+	tristate "Ciphers: Serpent with modes: ECB, CBC (SSE2)"
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
+	  Length-preserving ciphers: Serpent cipher algorithm
+	  with ECB and CBC modes
 
-	  This module provides Serpent cipher algorithm that processes eight
-	  blocks parallel using SSE2 instruction set.
+	  Architecture: x86_64 using:
+	  - SSE2 (Streaming SIMD Extensions 2)
 
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+	  Processes eight blocks in parallel.
 
 config CRYPTO_SERPENT_SSE2_586
-	tristate "Serpent cipher algorithm (i586/SSE2)"
+	tristate "Ciphers: Serpent with modes: ECB, CBC (32-bit with SSE2)"
 	depends on X86 && !64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
 	select CRYPTO_SIMD
 	imply CRYPTO_CTR
 	help
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+	  Length-preserving ciphers: Serpent cipher algorithm
+	  with ECB and CBC modes
 
-	  Keys are allowed to be from 0 to 256 bits in length, in steps
-	  of 8 bits.
-
-	  This module provides Serpent cipher algorithm that processes four
-	  blocks parallel using SSE2 instruction set.
+	  Architecture: x86 (32-bit) using:
+	  - SSE2 (Streaming SIMD Extensions 2)
 
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+	  Processes four blocks in parallel.
 
 config CRYPTO_SERPENT_AVX_X86_64
-	tristate "Serpent cipher algorithm (x86_64/AVX)"
+	tristate "Ciphers: Serpent with modes: ECB, CBC (AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SERPENT
@@ -202,56 +167,50 @@ config CRYPTO_SERPENT_AVX_X86_64
 	imply CRYPTO_XTS
 	imply CRYPTO_CTR
 	help
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+	  Length-preserving ciphers: Serpent cipher algorithm
+	  with ECB and CBC modes
 
-	  Keys are allowed to be from 0 to 256 bits in length, in steps
-	  of 8 bits.
-
-	  This module provides the Serpent cipher algorithm that processes
-	  eight blocks parallel using the AVX instruction set.
+	  Architecture: x86_64 using:
+	  - AVX (Advanced Vector Extensions)
 
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+	  Processes eight blocks in parallel.
 
 config CRYPTO_SERPENT_AVX2_X86_64
-	tristate "Serpent cipher algorithm (x86_64/AVX2)"
+	tristate "Ciphers: Serpent with modes: ECB, CBC (AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_SERPENT_AVX_X86_64
 	help
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+	  Length-preserving ciphers: Serpent cipher algorithm
+	  with ECB and CBC modes
 
-	  Keys are allowed to be from 0 to 256 bits in length, in steps
-	  of 8 bits.
-
-	  This module provides Serpent cipher algorithm that processes 16
-	  blocks parallel using AVX2 instruction set.
+	  Architecture: x86_64 using:
+	  - AVX2 (Advanced Vector Extensions 2)
 
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+	  Processes 16 blocks in parallel.
 
 config CRYPTO_SM4_AESNI_AVX_X86_64
-	tristate "SM4 cipher algorithm (x86_64/AES-NI/AVX)"
+	tristate "Ciphers: SM4 with modes: ECB, CBC, CFB, CTR (AES-NI/AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 	help
-	  SM4 cipher algorithms (OSCCA GB/T 32907-2016) (x86_64/AES-NI/AVX).
+	  Length-preserving ciphers: SM4 cipher algorithms
+	  (OSCCA GB/T 32907-2016) with ECB, CBC, CFB, and CTR modes
 
-	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
-	  Organization of State Commercial Administration of China (OSCCA)
-	  as an authorized cryptographic algorithms for the use within China.
+	  Architecture: x86_64 using:
+	  - AES-NI (AES New Instructions)
+	  - AVX (Advanced Vector Extensions)
 
-	  This is SM4 optimized implementation using AES-NI/AVX/x86_64
-	  instruction set for block cipher. Through two affine transforms,
+	  Through two affine transforms,
 	  we can use the AES S-Box to simulate the SM4 S-Box to achieve the
 	  effect of instruction acceleration.
 
 	  If unsure, say N.
 
 config CRYPTO_SM4_AESNI_AVX2_X86_64
-	tristate "SM4 cipher algorithm (x86_64/AES-NI/AVX2)"
+	tristate "Ciphers: SM4 with modes: ECB, CBC, CFB, CTR (AES-NI/AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
@@ -259,75 +218,58 @@ config CRYPTO_SM4_AESNI_AVX2_X86_64
 	select CRYPTO_SM4
 	select CRYPTO_SM4_AESNI_AVX_X86_64
 	help
-	  SM4 cipher algorithms (OSCCA GB/T 32907-2016) (x86_64/AES-NI/AVX2).
+	  Length-preserving ciphers: SM4 cipher algorithms
+	  (OSCCA GB/T 32907-2016) with ECB, CBC, CFB, and CTR modes
 
-	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
-	  Organization of State Commercial Administration of China (OSCCA)
-	  as an authorized cryptographic algorithms for the use within China.
+	  Architecture: x86_64 using:
+	  - AES-NI (AES New Instructions)
+	  - AVX2 (Advanced Vector Extensions 2)
 
-	  This is SM4 optimized implementation using AES-NI/AVX2/x86_64
-	  instruction set for block cipher. Through two affine transforms,
+	  Through two affine transforms,
 	  we can use the AES S-Box to simulate the SM4 S-Box to achieve the
 	  effect of instruction acceleration.
 
 	  If unsure, say N.
 
 config CRYPTO_TWOFISH_586
-	tristate "Twofish cipher algorithms (i586)"
+	tristate "Ciphers: Twofish (32-bit)"
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
+	  Block cipher: Twofish cipher algorithm
 
-	  See also:
-	  <https://www.schneier.com/twofish.html>
+	  Architecture: x86 (32-bit)
 
 config CRYPTO_TWOFISH_X86_64
-	tristate "Twofish cipher algorithm (x86_64)"
+	tristate "Ciphers: Twofish"
 	depends on (X86 || UML_X86) && 64BIT
 	select CRYPTO_ALGAPI
 	select CRYPTO_TWOFISH_COMMON
 	imply CRYPTO_CTR
 	help
-	  Twofish cipher algorithm (x86_64).
+	  Block cipher: Twofish cipher algorithm
 
-	  Twofish was submitted as an AES (Advanced Encryption Standard)
-	  candidate cipher by researchers at CounterPane Systems.  It is a
-	  16 round block cipher supporting key sizes of 128, 192, and 256
-	  bits.
-
-	  See also:
-	  <https://www.schneier.com/twofish.html>
+	  Architecture: x86_64
 
 config CRYPTO_TWOFISH_X86_64_3WAY
-	tristate "Twofish cipher algorithm (x86_64, 3-way parallel)"
+	tristate "Ciphers: Twofish with modes: ECB, CBC (3-way parallel)"
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
+	  Length-preserving cipher: Twofish cipher algorithm
+	  with ECB and CBC modes
 
-	  This module provides Twofish cipher algorithm that processes three
-	  blocks parallel, utilizing resources of out-of-order CPUs better.
+	  Architecture: x86_64
 
-	  See also:
-	  <https://www.schneier.com/twofish.html>
+	  Processes three blocks in parallel, better utilizing resources of
+	  out-of-order CPUs.
 
 config CRYPTO_TWOFISH_AVX_X86_64
-	tristate "Twofish cipher algorithm (x86_64/AVX)"
+	tristate "Ciphers: Twofish with modes: ECB, CBC (AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SIMD
@@ -336,28 +278,28 @@ config CRYPTO_TWOFISH_AVX_X86_64
 	select CRYPTO_TWOFISH_X86_64_3WAY
 	imply CRYPTO_XTS
 	help
-	  Twofish cipher algorithm (x86_64/AVX).
-
-	  Twofish was submitted as an AES (Advanced Encryption Standard)
-	  candidate cipher by researchers at CounterPane Systems.  It is a
-	  16 round block cipher supporting key sizes of 128, 192, and 256
-	  bits.
+	  Length-preserving cipher: Twofish cipher algorithm
+	  with ECB and CBC modes
 
-	  This module provides the Twofish cipher algorithm that processes
-	  eight blocks parallel using the AVX Instruction Set.
+	  Architecture: x86_64 using:
+	  - AVX (Advanced Vector Extensions)
 
-	  See also:
-	  <https://www.schneier.com/twofish.html>
+	  Processes eight blocks in parallel.
 
 config CRYPTO_CHACHA20_X86_64
-	tristate "ChaCha stream cipher algorithms (x86_64/SSSE3/AVX2/AVX-512VL)"
+	tristate "Ciphers: ChaCha20, XChaCha20, XChaCha12 (SSSE3/AVX2/AVX-512VL)"
 	depends on X86 && 64BIT
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 	help
-	  SSSE3, AVX2, and AVX-512VL optimized implementations of the ChaCha20,
-	  XChaCha20, and XChaCha12 stream ciphers.
+	  Length-preserving ciphers: ChaCha20, XChaCha20, and XChaCha12
+	  stream cipher algorithms
+
+	  Architecture: x86_64 using:
+	  - SSSE3 (Supplemental SSE3)
+	  - AVX2 (Advanced Vector Extensions 2)
+	  - AVX-512VL (Advanced Vector Extensions-512VL)
 
 config CRYPTO_AEGIS128_AESNI_SSE2
 	tristate "AEAD ciphers: AEGIS-128 (AES-NI/SSE2)"
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 913f1da82c91..bee5753aa5bd 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -219,7 +219,8 @@ config CRYPTO_AUTHENC
 	select CRYPTO_NULL
 	help
 	  Authenc: Combined mode wrapper for IPsec.
-	  This is required for IPSec.
+
+	  This is required for IPSec ESP (XFRM_ESP).
 
 config CRYPTO_TEST
 	tristate "Testing module"
@@ -336,12 +337,11 @@ config CRYPTO_CURVE25519
 menu "Block ciphers"
 
 config CRYPTO_AES
-	tristate "AES cipher algorithms"
+	tristate "AES (Advanced Encryption Standard)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 	help
-	  AES cipher algorithms (FIPS-197). AES uses the Rijndael
-	  algorithm.
+	  AES cipher algorithms (Rijndael)(FIPS-197, ISO/IEC 18033-3)
 
 	  Rijndael appears to be consistently a very good performer in
 	  both hardware and software across a wide range of computing
@@ -354,13 +354,13 @@ config CRYPTO_AES
 
 	  The AES specifies three key sizes: 128, 192 and 256 bits
 
-	  See <http://csrc.nist.gov/CryptoToolkit/aes/> for more information.
-
 config CRYPTO_AES_TI
-	tristate "Fixed time AES cipher"
+	tristate "AES (Advanced Encryption Standard) (fixed time)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 	help
+	  AES cipher algorithms (Rijndael)(FIPS-197, ISO/IEC 18033-3)
+
 	  This is a generic implementation of AES that attempts to eliminate
 	  data dependent latencies as much as possible without affecting
 	  performance too much. It is intended for use by the generic CCM
@@ -376,25 +376,24 @@ config CRYPTO_AES_TI
 	  are evicted when the CPU is interrupted to do something else.
 
 config CRYPTO_ANUBIS
-	tristate "Anubis cipher algorithm"
+	tristate "Anubis"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
 	select CRYPTO_ALGAPI
 	help
-	  Anubis cipher algorithm.
+	  Anubis cipher algorithm
 
 	  Anubis is a variable key length cipher which can use keys from
 	  128 bits to 320 bits in length.  It was evaluated as a entrant
 	  in the NESSIE competition.
 
-	  See also:
-	  <https://www.cosic.esat.kuleuven.be/nessie/reports/>
-	  <http://www.larc.usp.br/~pbarreto/AnubisPage.html>
+	  See https://web.archive.org/web/20160606112246/http://www.larc.usp.br/~pbarreto/AnubisPage.html
+	  for further information.
 
 config CRYPTO_ARIA
-	tristate "ARIA cipher algorithm"
+	tristate "ARIA"
 	select CRYPTO_ALGAPI
 	help
-	  ARIA cipher algorithm (RFC5794).
+	  ARIA cipher algorithm (RFC5794)
 
 	  ARIA is a standard encryption algorithm of the Republic of Korea.
 	  The ARIA specifies three key sizes and rounds.
@@ -402,22 +401,21 @@ config CRYPTO_ARIA
 	  192-bit: 14 rounds.
 	  256-bit: 16 rounds.
 
-	  See also:
-	  <https://seed.kisa.or.kr/kisa/algorithm/EgovAriaInfo.do>
+	  See:
+	  https://seed.kisa.or.kr/kisa/algorithm/EgovAriaInfo.do
 
 config CRYPTO_BLOWFISH
-	tristate "Blowfish cipher algorithm"
+	tristate "Blowfish"
 	select CRYPTO_ALGAPI
 	select CRYPTO_BLOWFISH_COMMON
 	help
-	  Blowfish cipher algorithm, by Bruce Schneier.
+	  Blowfish cipher algorithm, by Bruce Schneier
 
 	  This is a variable key length cipher which can use keys from 32
 	  bits to 448 bits in length.  It's fast, simple and specifically
 	  designed for use on "large microprocessors".
 
-	  See also:
-	  <https://www.schneier.com/blowfish.html>
+	  See https://www.schneier.com/blowfish.html for further information.
 
 config CRYPTO_BLOWFISH_COMMON
 	tristate
@@ -425,22 +423,18 @@ config CRYPTO_BLOWFISH_COMMON
 	  Common parts of the Blowfish cipher algorithm shared by the
 	  generic c and the assembler implementations.
 
-	  See also:
-	  <https://www.schneier.com/blowfish.html>
-
 config CRYPTO_CAMELLIA
-	tristate "Camellia cipher algorithms"
+	tristate "Camellia"
 	select CRYPTO_ALGAPI
 	help
-	  Camellia cipher algorithms module.
+	  Camellia cipher algorithms (ISO/IEC 18033-3)
 
 	  Camellia is a symmetric key block cipher developed jointly
 	  at NTT and Mitsubishi Electric Corporation.
 
 	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
 
-	  See also:
-	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+	  See https://info.isl.ntt.co.jp/crypt/eng/camellia/ for further information.
 
 config CRYPTO_CAST_COMMON
 	tristate
@@ -449,85 +443,87 @@ config CRYPTO_CAST_COMMON
 	  generic c and the assembler implementations.
 
 config CRYPTO_CAST5
-	tristate "CAST5 (CAST-128) cipher algorithm"
+	tristate "CAST5 (CAST-128)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_CAST_COMMON
 	help
-	  The CAST5 encryption algorithm (synonymous with CAST-128) is
-	  described in RFC2144.
+	  CAST5 (CAST-128) cipher algorithm (RFC2144, ISO/IEC 18033-3)
 
 config CRYPTO_CAST6
-	tristate "CAST6 (CAST-256) cipher algorithm"
+	tristate "CAST6 (CAST-256)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_CAST_COMMON
 	help
-	  The CAST6 encryption algorithm (synonymous with CAST-256) is
-	  described in RFC2612.
+	  CAST6 (CAST-256) encryption algorithm (RFC2612)
 
 config CRYPTO_DES
-	tristate "DES and Triple DES EDE cipher algorithms"
+	tristate "DES and Triple DES EDE"
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_DES
 	help
-	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
+	  DES (Data Encryption Standard)(FIPS 46-2, ISO/IEC 18033-3) and
+	  Triple DES EDE (Encrypt/Decrypt/Encrypt) (FIPS 46-3, ISO/IEC 18033-3)
+	  cipher algorithms
 
 config CRYPTO_FCRYPT
-	tristate "FCrypt cipher algorithm"
+	tristate "FCrypt"
 	select CRYPTO_ALGAPI
 	select CRYPTO_SKCIPHER
 	help
-	  FCrypt algorithm used by RxRPC.
+	  FCrypt algorithm used by RxRPC
+
+	  See https://ota.polyonymo.us/fcrypt-paper.txt
 
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
 
 config CRYPTO_SEED
-	tristate "SEED cipher algorithm"
+	tristate "SEED"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
 	select CRYPTO_ALGAPI
 	help
-	  SEED cipher algorithm (RFC4269).
+	  SEED cipher algorithm (RFC4269, ISO/IEC 18033-3)
 
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
-	  Serpent cipher algorithm, by Anderson, Biham & Knudsen.
+	  Serpent cipher algorithm, by Anderson, Biham & Knudsen
 
 	  Keys are allowed to be from 0 to 256 bits in length, in steps
 	  of 8 bits.
 
-	  See also:
-	  <https://www.cl.cam.ac.uk/~rja14/serpent.html>
+	  See https://www.cl.cam.ac.uk/~rja14/serpent.html for further information.
 
 config CRYPTO_SM4
 	tristate
 
 config CRYPTO_SM4_GENERIC
-	tristate "SM4 cipher algorithm"
+	tristate "SM4 (ShangMi 4)"
 	select CRYPTO_ALGAPI
 	select CRYPTO_SM4
 	help
-	  SM4 cipher algorithms (OSCCA GB/T 32907-2016).
+	  SM4 cipher algorithms (OSCCA GB/T 32907-2016,
+	  ISO/IEC 18033-3:2010/Amd 1:2021)
 
 	  SM4 (GBT.32907-2016) is a cryptographic standard issued by the
 	  Organization of State Commercial Administration of China (OSCCA)
@@ -544,16 +540,16 @@ config CRYPTO_SM4_GENERIC
 
 	  The input, output, and key of SMS4 are each 128 bits.
 
-	  See also: <https://eprint.iacr.org/2008/329.pdf>
+	  See https://eprint.iacr.org/2008/329.pdf for further information.
 
 	  If unsure, say N.
 
 config CRYPTO_TEA
-	tristate "TEA, XTEA and XETA cipher algorithms"
+	tristate "TEA, XTEA and XETA"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
 	select CRYPTO_ALGAPI
 	help
-	  TEA cipher algorithm.
+	  TEA (Tiny Encryption Algorithm) cipher algorithms
 
 	  Tiny Encryption Algorithm is a simple cipher that uses
 	  many rounds for security.  It is very fast and uses
@@ -567,19 +563,18 @@ config CRYPTO_TEA
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
@@ -592,14 +587,15 @@ config CRYPTO_TWOFISH_COMMON
 menu "Length-preserving ciphers and modes"
 
 config CRYPTO_ADIANTUM
-	tristate "Adiantum support"
+	tristate "Adiantum"
 	select CRYPTO_CHACHA20
 	select CRYPTO_LIB_POLY1305_GENERIC
 	select CRYPTO_NHPOLY1305
 	select CRYPTO_MANAGER
 	help
-	  Adiantum is a tweakable, length-preserving encryption mode
-	  designed for fast and secure disk encryption, especially on
+	  Adiantum tweakable, length-preserving encryption mode
+
+	  Designed for fast and secure disk encryption, especially on
 	  CPUs without dedicated crypto instructions.  It encrypts
 	  each sector using the XChaCha12 stream cipher, two passes of
 	  an ε-almost-∆-universal hash function, and an invocation of
@@ -616,12 +612,12 @@ config CRYPTO_ADIANTUM
 	  If unsure, say N.
 
 config CRYPTO_ARC4
-	tristate "ARC4 cipher algorithm"
+	tristate "ARC4 (Alleged Rivest Cipher 4)"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
 	select CRYPTO_SKCIPHER
 	select CRYPTO_LIB_ARC4
 	help
-	  ARC4 cipher algorithm.
+	  ARC4 cipher algorithm
 
 	  ARC4 is a stream cipher using keys ranging from 8 bits to 2048
 	  bits in length.  This algorithm is required for driver-based
@@ -629,113 +625,118 @@ config CRYPTO_ARC4
 	  weakness of the algorithm.
 
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
 
 config CRYPTO_CBC
-	tristate "CBC support"
+	tristate "CBC (Cipher Block Chaining)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  CBC: Cipher Block Chaining mode
-	  This block cipher algorithm is required for IPSec.
+	  CBC (Cipher Block Chaining) mode (NIST SP800-38A)
+
+	  This block cipher mode is required for IPSec ESP (XFRM_ESP).
 
 config CRYPTO_CFB
-	tristate "CFB support"
+	tristate "CFB (Cipher Feedback)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  CFB: Cipher FeedBack mode
-	  This block cipher algorithm is required for TPM2 Cryptography.
+	  CFB (Cipher Feedback) mode (NIST SP800-38A)
+
+	  This block cipher mode is required for TPM2 Cryptography.
 
 config CRYPTO_CTR
-	tristate "CTR support"
+	tristate "CTR (Counter)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  CTR: Counter mode
-	  This block cipher algorithm is required for IPSec.
+	  CTR (Counter) mode (NIST SP800-38A)
 
 config CRYPTO_CTS
-	tristate "CTS support"
+	tristate "CTS (Cipher Text Stealing)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  CTS: Cipher Text Stealing
-	  This is the Cipher Text Stealing mode as described by
-	  Section 8 of rfc2040 and referenced by rfc3962
-	  (rfc3962 includes errata information in its Appendix A) or
-	  CBC-CS3 as defined by NIST in Sp800-38A addendum from Oct 2010.
+	  CBC-CS3 variant of CTS (Cipher Text Stealing) (NIST
+	  Addendum to SP800-38A (October 2010))
+
 	  This mode is required for Kerberos gss mechanism support
 	  for AES encryption.
 
-	  See: https://csrc.nist.gov/publications/detail/sp/800-38a/addendum/final
-
 config CRYPTO_ECB
-	tristate "ECB support"
+	tristate "ECB (Electronic Codebook)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  ECB: Electronic CodeBook mode
-	  This is the simplest block cipher algorithm.  It simply encrypts
-	  the input block by block.
+	  ECB (Electronic Codebook) mode (NIST SP800-38A)
 
 config CRYPTO_HCTR2
-	tristate "HCTR2 support"
+	tristate "HCTR2"
 	select CRYPTO_XCTR
 	select CRYPTO_POLYVAL
 	select CRYPTO_MANAGER
 	help
-	  HCTR2 is a length-preserving encryption mode for storage encryption that
-	  is efficient on processors with instructions to accelerate AES and
-	  carryless multiplication, e.g. x86 processors with AES-NI and CLMUL, and
-	  ARM processors with the ARMv8 crypto extensions.
+	  HCTR2 length-preserving encryption mode
+
+	  A mode for storage encryption that is efficient on processors with
+	  instructions to accelerate AES and carryless multiplication, e.g.
+	  x86 processors with AES-NI and CLMUL, and ARM processors with the
+	  ARMv8 crypto extensions.
+
+	  See https://eprint.iacr.org/2021/1441
 
 config CRYPTO_KEYWRAP
-	tristate "Key wrapping support"
+	tristate "KW (AES Key Wrap)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  Support for key wrapping (NIST SP800-38F / RFC3394) without
-	  padding.
+	  KW (AES Key Wrap) authenticated encryption mode (NIST SP800-38F
+	  and RFC3394) without padding.
 
 config CRYPTO_LRW
-	tristate "LRW support"
+	tristate "LRW (Liskov Rivest Wagner)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	select CRYPTO_GF128MUL
 	select CRYPTO_ECB
 	help
-	  LRW: Liskov Rivest Wagner, a tweakable, non malleable, non movable
+	  LRW (Liskov Rivest Wagner) mode
+
+	  A tweakable, non malleable, non movable
 	  narrow block cipher mode for dm-crypt.  Use it with cipher
 	  specification string aes-lrw-benbi, the key must be 256, 320 or 384.
 	  The first 128, 192 or 256 bits in the key are used for AES and the
 	  rest is used to tie each cipher block to its logical position.
 
+	  See https://people.csail.mit.edu/rivest/pubs/LRW02.pdf
+
 config CRYPTO_OFB
-	tristate "OFB support"
+	tristate "OFB (Output Feedback)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  OFB: the Output Feedback mode makes a block cipher into a synchronous
+	  OFB (Output Feedback) mode (NIST SP800-38A)
+
+	  This mode makes a block cipher into a synchronous
 	  stream cipher. It generates keystream blocks, which are then XORed
 	  with the plaintext blocks to get the ciphertext. Flipping a bit in the
 	  ciphertext produces a flipped bit in the plaintext at the same
@@ -743,31 +744,38 @@ config CRYPTO_OFB
 	  normally even when applied before encryption.
 
 config CRYPTO_PCBC
-	tristate "PCBC support"
+	tristate "PCBC (Propagating Cipher Block Chaining)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  PCBC: Propagating Cipher Block Chaining mode
-	  This block cipher algorithm is required for RxRPC.
+	  PCBC (Propagating Cipher Block Chaining) mode
+
+	  This block cipher mode is required for RxRPC.
 
 config CRYPTO_XCTR
 	tristate
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	help
-	  XCTR: XOR Counter mode. This blockcipher mode is a variant of CTR mode
-	  using XORs and little-endian addition rather than big-endian arithmetic.
+	  XCTR (XOR Counter) mode for HCTR2
+
+	  This blockcipher mode is a variant of CTR mode using XORs and little-endian
+	  addition rather than big-endian arithmetic.
+
 	  XCTR mode is used to implement HCTR2.
 
 config CRYPTO_XTS
-	tristate "XTS support"
+	tristate "XTS (XOR Encrypt XOR with ciphertext stealing)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_MANAGER
 	select CRYPTO_ECB
 	help
-	  XTS: IEEE1619/D16 narrow block cipher use with aes-xts-plain,
-	  key size 256, 384 or 512 bits. This implementation currently
-	  can't handle a sectorsize which is not a multiple of 16 bytes.
+	  XTS (XOR Encrypt XOR with ciphertext stealing) mode (NIST SP800-38E
+	  and IEEE 1619)
+
+	  Use with aes-xts-plain, key size 256, 384 or 512 bits. This
+	  implementation currently can't handle a sectorsize which is not a
+	  multiple of 16 bytes.
 
 config CRYPTO_NHPOLY1305
 	tristate
@@ -806,7 +814,7 @@ config CRYPTO_CHACHA20POLY1305
 	  mode (RFC8439)
 
 config CRYPTO_CCM
-	tristate "CCM (Counter with Cipher Block Chaining-Message Authentication Code)"
+	tristate "CCM (Counter with Cipher Block Chaining-MAC)"
 	select CRYPTO_CTR
 	select CRYPTO_HASH
 	select CRYPTO_AEAD
@@ -816,7 +824,7 @@ config CRYPTO_CCM
 	  authenticated encryption mode (NIST SP800-38C)
 
 config CRYPTO_GCM
-	tristate "GCM (Galois/Counter Mode) and GMAC (GCM Message Authentication Code)"
+	tristate "GCM (Galois/Counter Mode) and GMAC (GCM MAC)"
 	select CRYPTO_CTR
 	select CRYPTO_AEAD
 	select CRYPTO_GHASH
-- 
2.37.1

