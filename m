Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5DBF59AFAC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiHTSne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbiHTSmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:50 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009B64505B;
        Sat, 20 Aug 2022 11:42:30 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KAHKw0020599;
        Sat, 20 Aug 2022 18:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=LOQNgGMCa8/+VIjvlcV4RlHkZyzvajf8rEMfG8I1i0Q=;
 b=F9RX6YEWGI2KBYhsEndRUsdW6N/PzkoL1VEyh90kluOQEPJ/flAaxKZ0RD7QeK0qbxu2
 hqu7nkLeJ7Wo7jxEd7UIkUsB4k5wOMRBwRou+010z1aHGiDAiEV0y6btyc/c8Xi9A7XK
 yzc1/FHA42rZpoqXKl3+kq2dv+kU4l6eTAWVU+NHwUC2BMuhdvZtvg1Qgw5Qd/zq2tKI
 ctzzMaduI5gE2Z2SO5L2/Qfb+lJZVW0vQKPzxqd2PH0kn7vncPaecyeDvjPEPnqkMDzR
 IsLNsXKWHqG7102isVfvyAEJJKILkvHzPNJz934e1DTfNf74kMe1+0xhh/Y+h+MUu+Vd ww== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wqq23rq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:24 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CB44F804CA7;
        Sat, 20 Aug 2022 18:42:22 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 76B0C803510;
        Sat, 20 Aug 2022 18:42:22 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 14/17] crypto: Kconfig - simplify hash entries
Date:   Sat, 20 Aug 2022 13:41:48 -0500
Message-Id: <20220820184151.1149247-15-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
X-Proofpoint-GUID: KK0qmydoO-6FOl7cEZxEPBS5-mPEFW65
X-Proofpoint-ORIG-GUID: KK0qmydoO-6FOl7cEZxEPBS5-mPEFW65
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208200080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/arm/crypto/Kconfig     |  94 +++++++++++++------
 arch/arm64/crypto/Kconfig   |  77 +++++++++++++---
 arch/mips/crypto/Kconfig    |  34 ++++---
 arch/powerpc/crypto/Kconfig |  30 +++---
 arch/s390/crypto/Kconfig    |  42 +++++----
 arch/sparc/crypto/Kconfig   |  28 +++---
 arch/x86/crypto/Kconfig     | 101 ++++++++++++---------
 crypto/Kconfig              | 176 ++++++++++++++++++++----------------
 8 files changed, 366 insertions(+), 216 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 75684521f581..e64e9b8418d6 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -14,98 +14,134 @@ config CRYPTO_CURVE25519_NEON
 	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_GHASH_ARM_CE
-	tristate "PMULL-accelerated GHASH using NEON/ARMv8 Crypto Extensions"
+	tristate "Hash functions: GHASH (PMULL/NEON/ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_CRYPTD
 	select CRYPTO_GF128MUL
 	help
+	  GCM GHASH function (NIST SP800-38D)
+
+	  Architecture: arm using
+	  - PMULL (Polynomial Multiply Long) instructions
+	  - NEON (Advanced SIMD) extensions
+	  - ARMv8 Crypto Extensions
+
 	  Use an implementation of GHASH (used by the GCM AEAD chaining mode)
 	  that uses the 64x64 to 128 bit polynomial multiplication (vmull.p64)
 	  that is part of the ARMv8 Crypto Extensions, or a slower variant that
 	  uses the vmull.p8 instruction that is part of the basic NEON ISA.
 
 config CRYPTO_NHPOLY1305_NEON
-	tristate "NEON accelerated NHPoly1305 hash function (for Adiantum)"
+	tristate "Hash functions: NHPoly1305 (NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_NHPOLY1305
+	help
+	  NHPoly1305 hash function (Adiantum)
+
+	  Architecture: arm using:
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_POLY1305_ARM
-	tristate "Accelerated scalar and SIMD Poly1305 hash implementations"
+	tristate "Hash functions: Poly1305 (NEON)"
 	select CRYPTO_HASH
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	help
+	  Poly1305 authenticator algorithm (RFC7539)
+
+	  Architecture: arm optionally using
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_BLAKE2S_ARM
-	bool "BLAKE2s digest algorithm (ARM)"
+	bool "Hash functions: BLAKE2s"
 	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
 	help
-	  BLAKE2s digest algorithm optimized with ARM scalar instructions.  This
-	  is faster than the generic implementations of BLAKE2s and BLAKE2b, but
-	  slower than the NEON implementation of BLAKE2b.  (There is no NEON
-	  implementation of BLAKE2s, since NEON doesn't really help with it.)
+	  BLAKE2s cryptographic hash function (RFC 7693)
+
+	  Architecture: arm
+
+	  This is faster than the generic implementations of BLAKE2s and
+	  BLAKE2b, but slower than the NEON implementation of BLAKE2b.
+	  There is no NEON implementation of BLAKE2s, since NEON doesn't
+	  really help with it.
 
 config CRYPTO_BLAKE2B_NEON
-	tristate "BLAKE2b digest algorithm (ARM NEON)"
+	tristate "Hash functions: BLAKE2b (NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLAKE2B
 	help
+	  BLAKE2b cryptographic hash function (RFC 7693)
+
+	  Architecture: arm using
+	  - NEON (Advanced SIMD) extensions
+
 	  BLAKE2b digest algorithm optimized with ARM NEON instructions.
 	  On ARM processors that have NEON support but not the ARMv8
 	  Crypto Extensions, typically this BLAKE2b implementation is
-	  much faster than SHA-2 and slightly faster than SHA-1.
+	  much faster than the SHA-2 family and slightly faster than
+	  SHA-1.
 
 config CRYPTO_SHA1_ARM
-	tristate "SHA1 digest algorithm (ARM-asm)"
+	tristate "Hash functions: SHA-1"
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
-	  using optimized ARM assembler.
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: arm
 
 config CRYPTO_SHA1_ARM_NEON
-	tristate "SHA1 digest algorithm (ARM NEON)"
+	tristate "Hash functions: SHA-1 (NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SHA1_ARM
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
-	  using optimized ARM NEON assembly, when NEON instructions are
-	  available.
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: arm using
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SHA1_ARM_CE
-	tristate "SHA1 digest algorithm (ARM v8 Crypto Extensions)"
+	tristate "Hash functions: SHA-1 (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SHA1_ARM
 	select CRYPTO_HASH
 	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
-	  using special ARMv8 Crypto Extensions.
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: arm using ARMv8 Crypto Extensions
 
 config CRYPTO_SHA2_ARM_CE
-	tristate "SHA-224/256 digest algorithm (ARM v8 Crypto Extensions)"
+	tristate "Hash functions: SHA-224 and SHA-256 (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SHA256_ARM
 	select CRYPTO_HASH
 	help
-	  SHA-256 secure hash standard (DFIPS 180-2) implemented
-	  using special ARMv8 Crypto Extensions.
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: arm using
+	  - ARMv8 Crypto Extensions
 
 config CRYPTO_SHA256_ARM
-	tristate "SHA-224/256 digest algorithm (ARM-asm and NEON)"
+	tristate "Hash functions: SHA-224 and SHA-256 (NEON)"
 	select CRYPTO_HASH
 	depends on !CPU_V7M
 	help
-	  SHA-256 secure hash standard (DFIPS 180-2) implemented
-	  using optimized ARM assembler and NEON, when available.
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: arm using
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_SHA512_ARM
-	tristate "SHA-384/512 digest algorithm (ARM-asm and NEON)"
+	tristate "Hash functions: SHA-384 and SHA-512 (NEON)"
 	select CRYPTO_HASH
 	depends on !CPU_V7M
 	help
-	  SHA-512 secure hash standard (DFIPS 180-2) implemented
-	  using optimized ARM assembler and NEON, when available.
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: arm using
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_AES_ARM
 	tristate "Scalar AES cipher for ARM"
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index cfc934880c97..709598f6d2e3 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -3,66 +3,119 @@
 menu "Accelerated Cryptographic Algorithms for CPU (arm64)"
 
 config CRYPTO_GHASH_ARM64_CE
-	tristate "GHASH/AES-GCM using ARMv8 Crypto Extensions"
+	tristate "Hash functions: GHASH (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_GF128MUL
 	select CRYPTO_LIB_AES
 	select CRYPTO_AEAD
+	help
+	  GCM GHASH function (NIST SP800-38D)
+
+	  Architecture: arm64 using:
+	  - ARMv8 Crypto Extensions
 
 config CRYPTO_NHPOLY1305_NEON
-	tristate "NHPoly1305 hash function using NEON instructions (for Adiantum)"
+	tristate "Hash functions: NHPoly1305 (NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_NHPOLY1305
+	help
+	  NHPoly1305 hash function (Adiantum)
+
+	  Architecture: arm64 using:
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_POLY1305_NEON
-	tristate "Poly1305 hash function using scalar or NEON instructions"
+	tristate "Hash functions: Poly1305 (NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	help
+	  Poly1305 authenticator algorithm (RFC7539)
+
+	  Architecture: arm64 using:
+	  - NEON (Advanced SIMD) extensions
 
-config CRYPTO_SHA1_ARM64_CE
-	tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
+config CRYPTO_SHA1_ARM64
+	tristate "Hash functions: SHA-1 (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA1
+	help
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: arm64 using:
+	  - ARMv8 Crypto Extensions
 
 config CRYPTO_SHA256_ARM64
-	tristate "SHA-224/SHA-256 digest algorithm for arm64"
+	tristate "Hash functions: SHA-224 and SHA-256"
 	select CRYPTO_HASH
+	help
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: arm64
 
 config CRYPTO_SHA2_ARM64_CE
-	tristate "SHA-224/SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
+	tristate "Hash functions: SHA-224 and SHA-256 (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA256_ARM64
+	help
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: arm64 using:
+	  - ARMv8 Crypto Extensions
 
 config CRYPTO_SHA512_ARM64
-	tristate "SHA-384/SHA-512 digest algorithm for arm64"
+	tristate "Hash functions: SHA-384 and SHA-512"
 	select CRYPTO_HASH
+	help
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: arm64
 
 config CRYPTO_SHA512_ARM64_CE
-	tristate "SHA-384/SHA-512 digest algorithm (ARMv8 Crypto Extensions)"
+	tristate "Hash functions: SHA-384 and SHA-512 (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA512_ARM64
+	help
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: arm64 using:
+	  - ARMv8 Crypto Extensions
 
 config CRYPTO_SHA3_ARM64
-	tristate "SHA3 digest algorithm (ARMv8.2 Crypto Extensions)"
+	tristate "Hash functions: SHA-3 (ARMv8.2 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA3
+	help
+	  SHA-3 secure hash algorithms (FIPS 202)
+
+	  Architecture: arm64 using:
+	  - ARMv8.2 Crypto Extensions
 
 config CRYPTO_SM3_ARM64_CE
-	tristate "SM3 digest algorithm (ARMv8.2 Crypto Extensions)"
+	tristate "Hash functions: SM3 (ARMv8.2 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SM3
+	help
+	  SM3 (ShangMi 3) secure hash function (OSCCA GM/T 0004-2012)
+
+	  Architecture: arm64 using:
+	  - ARMv8.2 Crypto Extensions
 
 config CRYPTO_POLYVAL_ARM64_CE
-	tristate "POLYVAL using ARMv8 Crypto Extensions (for HCTR2)"
+	tristate "Hash functions: POLYVAL (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_POLYVAL
+	help
+	  POLYVAL hash function for HCTR2
+
+	  Architecture: arm64 using:
+	  - ARMv8 Crypto Extensions
 
 config CRYPTO_AES_ARM64
 	tristate "AES core cipher using scalar instructions"
diff --git a/arch/mips/crypto/Kconfig b/arch/mips/crypto/Kconfig
index 8a40add80430..de162f69675c 100644
--- a/arch/mips/crypto/Kconfig
+++ b/arch/mips/crypto/Kconfig
@@ -12,45 +12,53 @@ config CRYPTO_CRC32_MIPS
 	  Architecture: mips
 
 config CRYPTO_POLY1305_MIPS
-	tristate "Poly1305 authenticator algorithm (MIPS optimized)"
+	tristate "Hash functions: Poly1305"
 	depends on MIPS
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	help
+	  Poly1305 authenticator algorithm (RFC7539)
+
+	  Architecture: mips
 
 config CRYPTO_MD5_OCTEON
-	tristate "MD5 digest algorithm (OCTEON)"
+	tristate "Digests: MD5 (OCTEON)"
 	depends on CPU_CAVIUM_OCTEON
 	select CRYPTO_MD5
 	select CRYPTO_HASH
 	help
-	  MD5 message digest algorithm (RFC1321) implemented
-	  using OCTEON crypto instructions, when available.
+	  MD5 message digest algorithm (RFC1321)
+
+	  Architecture: mips OCTEON using crypto instructions, when available
 
 config CRYPTO_SHA1_OCTEON
-	tristate "SHA1 digest algorithm (OCTEON)"
+	tristate "Hash functions: SHA-1 (OCTEON)"
 	depends on CPU_CAVIUM_OCTEON
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
-	  using OCTEON crypto instructions, when available.
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: mips OCTEON
 
 config CRYPTO_SHA256_OCTEON
-	tristate "SHA224 and SHA256 digest algorithm (OCTEON)"
+	tristate "Hash functions: SHA-224 and SHA-256 (OCTEON)"
 	depends on CPU_CAVIUM_OCTEON
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
-	  SHA-256 secure hash standard (DFIPS 180-2) implemented
-	  using OCTEON crypto instructions, when available.
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: mips OCTEON using crypto instructions, when available
 
 config CRYPTO_SHA512_OCTEON
-	tristate "SHA384 and SHA512 digest algorithms (OCTEON)"
+	tristate "Hash functions: SHA-384 and SHA-512 (OCTEON)"
 	depends on CPU_CAVIUM_OCTEON
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
-	  SHA-512 secure hash standard (DFIPS 180-2) implemented
-	  using OCTEON crypto instructions, when available.
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: mips OCTEON using crypto instructions, when available
 
 config CRYPTO_CHACHA_MIPS
 	tristate "ChaCha stream cipher algorithms (MIPS 32r2 optimized)"
diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index d1c34e949ce1..5a4770a029ef 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -36,35 +36,41 @@ config CRYPTO_VPMSUM_TESTER
 	  Unless you are testing these algorithms, you don't need this.
 
 config CRYPTO_MD5_PPC
-	tristate "MD5 digest algorithm (PPC)"
+	tristate "Digests: MD5"
 	depends on PPC
 	select CRYPTO_HASH
 	help
-	  MD5 message digest algorithm (RFC1321) implemented
-	  in PPC assembler.
+	  MD5 message digest algorithm (RFC1321)
+
+	  Architecture: powerpc
 
 config CRYPTO_SHA1_PPC
-	tristate "SHA1 digest algorithm (powerpc)"
+	tristate "Hash functions: SHA-1"
 	depends on PPC
 	help
-	  This is the powerpc hardware accelerated implementation of the
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: powerpc
 
 config CRYPTO_SHA1_PPC_SPE
-	tristate "SHA1 digest algorithm (PPC SPE)"
+	tristate "Hash functions: SHA-1 (SPE)"
 	depends on PPC && SPE
 	help
-	  SHA-1 secure hash standard (DFIPS 180-4) implemented
-	  using powerpc SPE SIMD instruction set.
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: powerpc using
+	  - SPE (Signal Processing Engine) extensions
 
 config CRYPTO_SHA256_PPC_SPE
-	tristate "SHA224 and SHA256 digest algorithm (PPC SPE)"
+	tristate "Hash functions: SHA-224 and SHA-256 (SPE)"
 	depends on PPC && SPE
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
-	  SHA224 and SHA256 secure hash standard (DFIPS 180-2)
-	  implemented using powerpc SPE SIMD instruction set.
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: powerpc using
+	  - SPE (Signal Processing Engine) extensions
 
 config CRYPTO_AES_PPC_SPE
 	tristate "AES cipher algorithms (PPC SPE)"
diff --git a/arch/s390/crypto/Kconfig b/arch/s390/crypto/Kconfig
index 5d12ecfaa337..04cc3a6467ab 100644
--- a/arch/s390/crypto/Kconfig
+++ b/arch/s390/crypto/Kconfig
@@ -15,62 +15,68 @@ config CRYPTO_CRC32_S390
 	  It is available with IBM z13 or later.
 
 config CRYPTO_SHA512_S390
-	tristate "SHA384 and SHA512 digest algorithm"
+	tristate "Hash functions: SHA-384 and SHA-512"
 	depends on S390
 	select CRYPTO_HASH
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA512 secure hash standard.
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: s390
 
 	  It is available as of z10.
 
 config CRYPTO_SHA1_S390
-	tristate "SHA1 digest algorithm"
+	tristate "Hash functions: SHA-1"
 	depends on S390
 	select CRYPTO_HASH
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: s390
 
 	  It is available as of z990.
 
 config CRYPTO_SHA256_S390
-	tristate "SHA256 digest algorithm"
+	tristate "Hash functions: SHA-224 and SHA-256"
 	depends on S390
 	select CRYPTO_HASH
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA256 secure hash standard (DFIPS 180-2).
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: s390
 
 	  It is available as of z9.
 
 config CRYPTO_SHA3_256_S390
-	tristate "SHA3_224 and SHA3_256 digest algorithm"
+	tristate "Hash functions: SHA3-224 and SHA3-256"
 	depends on S390
 	select CRYPTO_HASH
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA3_256 secure hash standard.
+	  SHA3-224 and SHA3-256 secure hash algorithms (FIPS 202)
+
+	  Architecture: s390
 
 	  It is available as of z14.
 
 config CRYPTO_SHA3_512_S390
-	tristate "SHA3_384 and SHA3_512 digest algorithm"
+	tristate "Hash functions: SHA3-384 and SHA3-512"
 	depends on S390
 	select CRYPTO_HASH
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA3_512 secure hash standard.
+	  SHA3-384 and SHA3-512 secure hash algorithms (FIPS 202)
+
+	  Architecture: s390
 
 	  It is available as of z14.
 
 config CRYPTO_GHASH_S390
-	tristate "GHASH hash function"
+	tristate "Hash functions: GHASH"
 	depends on S390
 	select CRYPTO_HASH
 	help
-	  This is the s390 hardware accelerated implementation of GHASH,
-	  the hash function used in GCM (Galois/Counter mode).
+	  GCM GHASH hash function (NIST SP800-38D)
+
+	  Architecture: s390
 
 	  It is available as of z196.
 
diff --git a/arch/sparc/crypto/Kconfig b/arch/sparc/crypto/Kconfig
index 145debe629cd..519348de6860 100644
--- a/arch/sparc/crypto/Kconfig
+++ b/arch/sparc/crypto/Kconfig
@@ -23,40 +23,44 @@ config CRYPTO_CRC32C_SPARC64
 	  Architecture: sparc64
 
 config CRYPTO_MD5_SPARC64
-	tristate "MD5 digest algorithm (SPARC64)"
+	tristate "Digests: MD5"
 	depends on SPARC64
 	select CRYPTO_MD5
 	select CRYPTO_HASH
 	help
-	  MD5 message digest algorithm (RFC1321) implemented
-	  using sparc64 crypto instructions, when available.
+	  MD5 message digest algorithm (RFC1321)
+
+	  Architecture: sparc64 using crypto instructions, when available
 
 config CRYPTO_SHA1_SPARC64
-	tristate "SHA1 digest algorithm (SPARC64)"
+	tristate "Hash functions: SHA-1"
 	depends on SPARC64
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
-	  using sparc64 crypto instructions, when available.
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: sparc64
 
 config CRYPTO_SHA256_SPARC64
-	tristate "SHA224 and SHA256 digest algorithm (SPARC64)"
+	tristate "Hash functions: SHA-224 and SHA-256"
 	depends on SPARC64
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
-	  SHA-256 secure hash standard (DFIPS 180-2) implemented
-	  using sparc64 crypto instructions, when available.
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: sparc64 using crypto instructions, when available
 
 config CRYPTO_SHA512_SPARC64
-	tristate "SHA384 and SHA512 digest algorithm (SPARC64)"
+	tristate "Hash functions: SHA-384 and SHA-512"
 	depends on SPARC64
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
-	  SHA-512 secure hash standard (DFIPS 180-2) implemented
-	  using sparc64 crypto instructions, when available.
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: sparc64 using crypto instructions, when available
 
 config CRYPTO_AES_SPARC64
 	tristate "AES cipher algorithms (SPARC64)"
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 93de2684b3dc..fc24f4562700 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -372,103 +372,122 @@ config CRYPTO_AEGIS128_AESNI_SSE2
 	  - SSE2 (Streaming SIMD Extensions 2)
 
 config CRYPTO_NHPOLY1305_SSE2
-	tristate "NHPoly1305 hash function (x86_64 SSE2 implementation)"
+	tristate "Hash functions: NHPoly1305 (SSE2)"
 	depends on X86 && 64BIT
 	select CRYPTO_NHPOLY1305
 	help
-	  SSE2 optimized implementation of the hash function used by the
-	  Adiantum encryption mode.
+	  NHPoly1305 hash function for Adiantum
+
+	  Architecture: x86_64 using:
+	  - SSE2 (Streaming SIMD Extensions 2)
 
 config CRYPTO_NHPOLY1305_AVX2
-	tristate "NHPoly1305 hash function (x86_64 AVX2 implementation)"
+	tristate "Hash functions: NHPoly1305 (AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_NHPOLY1305
 	help
-	  AVX2 optimized implementation of the hash function used by the
-	  Adiantum encryption mode.
+	  NHPoly1305 hash function for Adiantum
+
+	  Architecture: x86_64 using:
+	  - AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_BLAKE2S_X86
-	bool "BLAKE2s digest algorithm (x86 accelerated version)"
+	bool "Hash functions: BLAKE2s (SSSE3/AVX-512)"
 	depends on X86 && 64BIT
 	select CRYPTO_LIB_BLAKE2S_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
+	help
+	  BLAKE2s cryptographic hash function (RFC 7693)
+
+	  Architecture: x86_64 using:
+	  - SSSE3 (Supplemental SSE3)
+	  - AVX-512 (Advanced Vector Extensions-512)
 
 config CRYPTO_POLYVAL_CLMUL_NI
-	tristate "POLYVAL hash function (CLMUL-NI accelerated)"
+	tristate "Hash functions: POLYVAL (CLMUL-NI)"
 	depends on X86 && 64BIT
 	select CRYPTO_POLYVAL
 	help
-	  This is the x86_64 CLMUL-NI accelerated implementation of POLYVAL. It is
-	  used to efficiently implement HCTR2 on x86-64 processors that support
-	  carry-less multiplication instructions.
+	  POLYVAL hash function for HCTR2
+
+	  Architecture: x86_64 using:
+	  - CLMUL-NI (carry-less multiplication new instructions)
 
 config CRYPTO_POLY1305_X86_64
-	tristate "Poly1305 authenticator algorithm (x86_64/SSE2/AVX2)"
+	tristate "Hash functions: Poly1305 (SSE2/AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_LIB_POLY1305_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	help
-	  Poly1305 authenticator algorithm, RFC7539.
+	  Poly1305 authenticator algorithm (RFC7539)
 
-	  Poly1305 is an authenticator algorithm designed by Daniel J. Bernstein.
-	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
-	  in IETF protocols. This is the x86_64 assembler implementation using SIMD
-	  instructions.
+	  Architecture: x86_64 using:
+	  - SSE2 (Streaming SIMD Extensions 2)
+	  - AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_SHA1_SSSE3
-	tristate "SHA1 digest algorithm (SSSE3/AVX/AVX2/SHA-NI)"
+	tristate "Hash functions: SHA-1 (SSSE3/AVX/AVX2/SHA-NI)"
 	depends on X86 && 64BIT
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
-	  using Supplemental SSE3 (SSSE3) instructions or Advanced Vector
-	  Extensions (AVX/AVX2) or SHA-NI(SHA Extensions New Instructions),
-	  when available.
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: x86_64 using:
+	  - SSSE3 (Supplemental SSE3)
+	  - AVX (Advanced Vector Extensions)
+	  - AVX2 (Advanced Vector Extensions 2)
+	  - SHA-NI (SHA Extensions New Instructions)
 
 config CRYPTO_SHA256_SSSE3
-	tristate "SHA256 digest algorithm (SSSE3/AVX/AVX2/SHA-NI)"
+	tristate "Hash functions: SHA-224 and SHA-256 (SSSE3/AVX/AVX2/SHA-NI)"
 	depends on X86 && 64BIT
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
-	  SHA-256 secure hash standard (DFIPS 180-2) implemented
-	  using Supplemental SSE3 (SSSE3) instructions, or Advanced Vector
-	  Extensions version 1 (AVX1), or Advanced Vector Extensions
-	  version 2 (AVX2) instructions, or SHA-NI (SHA Extensions New
-	  Instructions) when available.
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: x86_64 using:
+	  - SSSE3 (Supplemental SSE3)
+	  - AVX (Advanced Vector Extensions)
+	  - AVX2 (Advanced Vector Extensions 2)
+	  - SHA-NI (SHA Extensions New Instructions)
 
 config CRYPTO_SHA512_SSSE3
-	tristate "SHA512 digest algorithm (SSSE3/AVX/AVX2)"
+	tristate "Hash functions: SHA-384 and SHA-512 (SSSE3/AVX/AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
-	  SHA-512 secure hash standard (DFIPS 180-2) implemented
-	  using Supplemental SSE3 (SSSE3) instructions, or Advanced Vector
-	  Extensions version 1 (AVX1), or Advanced Vector Extensions
-	  version 2 (AVX2) instructions, when available.
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: x86_64 using:
+	  - SSSE3 (Supplemental SSE3)
+	  - AVX (Advanced Vector Extensions)
+	  - AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_SM3_AVX_X86_64
-	tristate "SM3 digest algorithm (x86_64/AVX)"
+	tristate "Hash functions: SM3 (AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_HASH
 	select CRYPTO_SM3
 	help
-	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3).
-	  It is part of the Chinese Commercial Cryptography suite. This is
-	  SM3 optimized implementation using Advanced Vector Extensions (AVX)
-	  when available.
+	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3
+
+	  Architecture: x86_64 using:
+	  - AVX (Advanced Vector Extensions)
 
 	  If unsure, say N.
 
 config CRYPTO_GHASH_CLMUL_NI_INTEL
-	tristate "GHASH hash function (CLMUL-NI accelerated)"
+	tristate "Hash functions: GHASH (CLMUL-NI)"
 	depends on X86 && 64BIT
 	select CRYPTO_CRYPTD
 	help
-	  This is the x86_64 CLMUL-NI accelerated implementation of
-	  GHASH, the hash function used in GCM (Galois/Counter mode).
+	  GCM GHASH hash function (NIST SP800-38D)
+
+	  Architecture: x86_64 using:
+	  - CLMUL-NI (carry-less multiplication new instructions)
 
 config CRYPTO_CRC32C_INTEL
 	tristate "CRC32c (SSE4.2/PCLMULQDQ)"
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 9dab2c72f7fb..5e43c63077e5 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -890,215 +890,233 @@ config CRYPTO_ESSIV
 menu "Hashes, digests, and MACs"
 
 config CRYPTO_BLAKE2B
-	tristate "BLAKE2b digest algorithm"
+	tristate "BLAKE2b"
 	select CRYPTO_HASH
 	help
-	  Implementation of cryptographic hash function BLAKE2b (or just BLAKE2),
-	  optimized for 64bit platforms and can produce digests of any size
-	  between 1 to 64.  The keyed hash is also implemented.
+	  BLAKE2b cryptographic hash function (RFC 7693)
 
-	  This module provides the following algorithms:
+	  BLAKE2b is optimized for 64-bit platforms and can produce digests
+	  of any size between 1 and 64 bytes. The keyed hash is also implemented.
 
+	  This module provides the following algorithms:
 	  - blake2b-160
 	  - blake2b-256
 	  - blake2b-384
 	  - blake2b-512
 
+	  Used by the btrfs filesystem.
+
 	  See https://blake2.net for further information.
 
+ config CRYPTO_BLAKE2S
+	tristate "BLAKE2s"
+        select CRYPTO_LIB_BLAKE2S_GENERIC
+        select CRYPTO_HASH
+        help
+	  BLAKE2s cryptographic hash function (RFC 7693)
+
+	  BLAKE2s is optimized for 8 to 32-bit platforms and can produce
+	  digests of any size between 1 and 32 bytes. The keyed hash is
+	  also implemented.
+
+	  This module provides the following algorithms:
+          - blake2s-128
+          - blake2s-160
+          - blake2s-224
+          - blake2s-256
+
+	  Used by Wireguard.
+
+          See https://blake2.net for further information.
+
 config CRYPTO_CMAC
-	tristate "CMAC support"
+	tristate "CMAC (Cipher-based MAC)"
 	select CRYPTO_HASH
 	select CRYPTO_MANAGER
 	help
-	  Cipher-based Message Authentication Code (CMAC) specified by
-	  The National Institute of Standards and Technology (NIST).
-
-	  https://tools.ietf.org/html/rfc4493
-	  http://csrc.nist.gov/publications/nistpubs/800-38B/SP_800-38B.pdf
+	  CMAC (Cipher-based Message Authentication Code) authentication
+	  mode (NIST SP800-38B and IETF RFC4493)
 
 config CRYPTO_GHASH
-	tristate "GHASH hash function"
+	tristate "GHASH"
 	select CRYPTO_GF128MUL
 	select CRYPTO_HASH
 	help
-	  GHASH is the hash function used in GCM (Galois/Counter Mode).
-	  It is not a general-purpose cryptographic hash function.
+	  GCM GHASH function (NIST SP800-38D)
 
 config CRYPTO_HMAC
-	tristate "HMAC support"
+	tristate "HMAC (Keyed-Hash MAC)"
 	select CRYPTO_HASH
 	select CRYPTO_MANAGER
 	help
-	  HMAC: Keyed-Hashing for Message Authentication (RFC2104).
-	  This is required for IPSec.
+	  HMAC (Keyed-Hash Message Authentication Code) (FIPS 198 and
+	  RFC2104)
+
+	  This is required for IPsec AH (XFRM_AH) and IPsec ESP (XFRM_ESP).
 
 config CRYPTO_MD4
-	tristate "MD4 digest algorithm"
+	tristate "MD4"
 	select CRYPTO_HASH
 	help
-	  MD4 message digest algorithm (RFC1320).
+	  MD4 message digest algorithm (RFC1320)
 
 config CRYPTO_MD5
-	tristate "MD5 digest algorithm"
+	tristate "MD5"
 	select CRYPTO_HASH
 	help
-	  MD5 message digest algorithm (RFC1321).
+	  MD5 message digest algorithm (RFC1321)
 
 config CRYPTO_MICHAEL_MIC
-	tristate "Michael MIC keyed digest algorithm"
+	tristate "Michael MIC"
 	select CRYPTO_HASH
 	help
-	  Michael MIC is used for message integrity protection in TKIP
-	  (IEEE 802.11i). This algorithm is required for TKIP, but it
-	  should not be used for other purposes because of the weakness
-	  of the algorithm.
+	  Michael MIC (Message Integrity Code) (IEEE 802.11i)
+
+	  Defined by the IEEE 802.11i TKIP (Temporal Key Integrity Protocol),
+	  known as WPA (Wif-Fi Protected Access).
+
+	  This algorithm is required for TKIP, but it should not be used for
+	  other purposes because of the weakness of the algorithm.
 
 config CRYPTO_POLYVAL
 	tristate
 	select CRYPTO_GF128MUL
 	select CRYPTO_HASH
 	help
-	  POLYVAL is the hash function used in HCTR2.  It is not a general-purpose
+	  POLYVAL hash function for HCTR2
+
+	  This is used in HCTR2.  It is not a general-purpose
 	  cryptographic hash function.
 
 config CRYPTO_POLY1305
-	tristate "Poly1305 authenticator algorithm"
+	tristate "Poly1305"
 	select CRYPTO_HASH
 	select CRYPTO_LIB_POLY1305_GENERIC
 	help
-	  Poly1305 authenticator algorithm, RFC7539.
+	  Poly1305 authenticator algorithm (RFC7539)
 
 	  Poly1305 is an authenticator algorithm designed by Daniel J. Bernstein.
 	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
 	  in IETF protocols. This is the portable C implementation of Poly1305.
 
 config CRYPTO_RMD160
-	tristate "RIPEMD-160 digest algorithm"
+	tristate "RIPEMD-160"
 	select CRYPTO_HASH
 	help
-	  RIPEMD-160 (ISO/IEC 10118-3:2004).
+	  RIPEMD-160 hash function (ISO/IEC 10118-3)
 
 	  RIPEMD-160 is a 160-bit cryptographic hash function. It is intended
 	  to be used as a secure replacement for the 128-bit hash functions
 	  MD4, MD5 and its predecessor RIPEMD
 	  (not to be confused with RIPEMD-128).
 
-	  It's speed is comparable to SHA1 and there are no known attacks
+	  Its speed is comparable to SHA-1 and there are no known attacks
 	  against RIPEMD-160.
 
 	  Developed by Hans Dobbertin, Antoon Bosselaers and Bart Preneel.
-	  See <https://homes.esat.kuleuven.be/~bosselae/ripemd160.html>
+	  See https://homes.esat.kuleuven.be/~bosselae/ripemd160.html
+	  for further information.
 
 config CRYPTO_SHA1
-	tristate "SHA1 digest algorithm"
+	tristate "SHA-1"
 	select CRYPTO_HASH
 	select CRYPTO_LIB_SHA1
 	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+	  SHA-1 secure hash algorithm (FIPS 180, ISO/IEC 10118-3)
 
 config CRYPTO_SHA256
-	tristate "SHA224 and SHA256 digest algorithm"
+	tristate "SHA-224 and SHA-256"
 	select CRYPTO_HASH
 	select CRYPTO_LIB_SHA256
 	help
-	  SHA256 secure hash standard (DFIPS 180-2).
-
-	  This version of SHA implements a 256 bit hash with 128 bits of
-	  security against collision attacks.
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180, ISO/IEC 10118-3)
 
-	  This code also includes SHA-224, a 224 bit hash with 112 bits
-	  of security against collision attacks.
+	  This is required for IPsec AH (XFRM_AH) and IPsec ESP (XFRM_ESP).
+	  Used by the btrfs filesystem, Ceph, NFS, and SMB.
 
 config CRYPTO_SHA512
-	tristate "SHA384 and SHA512 digest algorithms"
+	tristate "SHA-384 and SHA-512"
 	select CRYPTO_HASH
 	help
-	  SHA512 secure hash standard (DFIPS 180-2).
-
-	  This version of SHA implements a 512 bit hash with 256 bits of
-	  security against collision attacks.
-
-	  This code also includes SHA-384, a 384 bit hash with 192 bits
-	  of security against collision attacks.
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180, ISO/IEC 10118-3)
 
 config CRYPTO_SHA3
-	tristate "SHA3 digest algorithm"
+	tristate "SHA-3"
 	select CRYPTO_HASH
 	help
-	  SHA-3 secure hash standard (DFIPS 202). It's based on
-	  cryptographic sponge function family called Keccak.
-
-	  References:
-	  http://keccak.noekeon.org/
+	  SHA-3 secure hash algorithms (FIPS 202, ISO/IEC 10118-3)
 
 config CRYPTO_SM3
 	tristate
 
 config CRYPTO_SM3_GENERIC
-	tristate "SM3 digest algorithm"
+	tristate "SM3 (ShangMi 3)"
 	select CRYPTO_HASH
 	select CRYPTO_SM3
 	help
-	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3).
-	  It is part of the Chinese Commercial Cryptography suite.
+	  SM3 (ShangMi 3) secure hash function (OSCCA GM/T 0004-2012, ISO/IEC 10118-3)
+
+	  This is part of the Chinese Commercial Cryptography suite.
 
 	  References:
 	  http://www.oscca.gov.cn/UpFile/20101222141857786.pdf
 	  https://datatracker.ietf.org/doc/html/draft-shen-sm3-hash
 
 config CRYPTO_STREEBOG
-	tristate "Streebog Hash Function"
+	tristate "Streebog"
 	select CRYPTO_HASH
 	help
-	  Streebog Hash Function (GOST R 34.11-2012, RFC 6986) is one of the Russian
-	  cryptographic standard algorithms (called GOST algorithms).
-	  This setting enables two hash algorithms with 256 and 512 bits output.
+	  Streebog Hash Function (GOST R 34.11-2012, RFC 6986, ISO/IEC 10118-3)
+
+	  This is one of the Russian cryptographic standard algorithms (called
+	  GOST algorithms). This setting enables two hash algorithms with
+	  256 and 512 bits output.
 
 	  References:
 	  https://tc26.ru/upload/iblock/fed/feddbb4d26b685903faa2ba11aea43f6.pdf
 	  https://tools.ietf.org/html/rfc6986
 
 config CRYPTO_VMAC
-	tristate "VMAC support"
+	tristate "VMAC"
 	select CRYPTO_HASH
 	select CRYPTO_MANAGER
 	help
 	  VMAC is a message authentication algorithm designed for
 	  very high speed on 64-bit architectures.
 
-	  See also:
-	  <https://fastcrypto.org/vmac>
+	  See https://fastcrypto.org/vmac for further information.
 
 config CRYPTO_WP512
-	tristate "Whirlpool digest algorithms"
+	tristate "Whirlpool"
 	select CRYPTO_HASH
 	help
-	  Whirlpool hash algorithm 512, 384 and 256-bit hashes
+	  Whirlpool hash function (ISO/IEC 10118-3)
+
+	  512, 384 and 256-bit hashes.
 
 	  Whirlpool-512 is part of the NESSIE cryptographic primitives.
-	  Whirlpool will be part of the ISO/IEC 10118-3:2003(E) standard
 
-	  See also:
-	  <http://www.larc.usp.br/~pbarreto/WhirlpoolPage.html>
+	  See https://web.archive.org/web/20171129084214/http://www.larc.usp.br/~pbarreto/WhirlpoolPage.html
+	  for further information.
 
 config CRYPTO_XCBC
-	tristate "XCBC support"
+	tristate "XCBC-MAC (Extended Cipher Block Chaining MAC)"
 	select CRYPTO_HASH
 	select CRYPTO_MANAGER
 	help
-	  XCBC: Keyed-Hashing with encryption algorithm
-		https://www.ietf.org/rfc/rfc3566.txt
-		http://csrc.nist.gov/encryption/modes/proposedmodes/
-		 xcbc-mac/xcbc-mac-spec.pdf
+	  XCBC-MAC (Extended Cipher Block Chaining Message Authentication
+	  Code) (RFC3566)
 
 config CRYPTO_XXHASH
-	tristate "xxHash hash algorithm"
+	tristate "xxHash"
 	select CRYPTO_HASH
 	select XXHASH
 	help
-	  xxHash non-cryptographic hash algorithm. Extremely fast, working at
-	  speeds close to RAM limits.
+	  xxHash non-cryptographic hash algorithm
+
+	  Extremely fast, working at speeds close to RAM limits.
+
+	  Used by the btrfs filesystem.
 
 endmenu
 
-- 
2.37.1

