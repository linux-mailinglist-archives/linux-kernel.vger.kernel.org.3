Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437EE59AFB3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiHTSmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiHTSmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:11 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41674457A;
        Sat, 20 Aug 2022 11:42:09 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KHtKL3027508;
        Sat, 20 Aug 2022 18:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=xayN4HNeUobbXBP+omqtL4LyLszGdLGZenIwAVh0xm8=;
 b=B95qExqIx1BUXAft2UGto5wQN0et1W4dN+BLwIHB74KQaCXc+jMjpbetC2aPZnEIyMFe
 ImUnX6xmOdSs5nDXz1JEfLHbfGTItzCmQKIHV40VIs2TMkvWWiNjKAY/SUkJLynh5TZd
 KT8JPg/Lvf54aLK/MdOehjy7t7IviKtNCOVa4msVd4acrrZvg1dvqJAIcuBt6Xu9p309
 jRnMqPOJa8i8eeNb6T9SdJJiSJ/ez3nrEtN/DLzIUBOKH3adiQc4xslczHt5X7P3joMj
 WfBHlE1mpdedpPaIkJb8y7VAYQ28QR0wRoZcVp3VK+O25zKrHVm1Ke0YzZamxbx+cIz3 aQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wqs2591-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:01 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id E92F6800E80;
        Sat, 20 Aug 2022 18:41:59 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 8176C803D88;
        Sat, 20 Aug 2022 18:41:59 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 01/17] crypto: Kconfig - move mips entries to a submenu
Date:   Sat, 20 Aug 2022 13:41:35 -0500
Message-Id: <20220820184151.1149247-2-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: G2DHALTHhcLCJxZl2eqjuGBsbLq59IBD
X-Proofpoint-GUID: G2DHALTHhcLCJxZl2eqjuGBsbLq59IBD
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=444 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
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
 arch/mips/crypto/Kconfig | 60 ++++++++++++++++++++++++++++++++++++++++
 crypto/Kconfig           | 59 +++------------------------------------
 2 files changed, 64 insertions(+), 55 deletions(-)
 create mode 100644 arch/mips/crypto/Kconfig

diff --git a/arch/mips/crypto/Kconfig b/arch/mips/crypto/Kconfig
new file mode 100644
index 000000000000..7c07611e2322
--- /dev/null
+++ b/arch/mips/crypto/Kconfig
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Accelerated Cryptographic Algorithms for CPU (mips)"
+
+config CRYPTO_CRC32_MIPS
+	tristate "CRC32c and CRC32 CRC algorithm (MIPS)"
+	depends on MIPS_CRC_SUPPORT
+	select CRYPTO_HASH
+	help
+	  CRC32c and CRC32 CRC algorithms implemented using mips crypto
+	  instructions, when available.
+
+config CRYPTO_POLY1305_MIPS
+	tristate "Poly1305 authenticator algorithm (MIPS optimized)"
+	depends on MIPS
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+
+config CRYPTO_MD5_OCTEON
+	tristate "MD5 digest algorithm (OCTEON)"
+	depends on CPU_CAVIUM_OCTEON
+	select CRYPTO_MD5
+	select CRYPTO_HASH
+	help
+	  MD5 message digest algorithm (RFC1321) implemented
+	  using OCTEON crypto instructions, when available.
+
+config CRYPTO_SHA1_OCTEON
+	tristate "SHA1 digest algorithm (OCTEON)"
+	depends on CPU_CAVIUM_OCTEON
+	select CRYPTO_SHA1
+	select CRYPTO_HASH
+	help
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
+	  using OCTEON crypto instructions, when available.
+
+config CRYPTO_SHA256_OCTEON
+	tristate "SHA224 and SHA256 digest algorithm (OCTEON)"
+	depends on CPU_CAVIUM_OCTEON
+	select CRYPTO_SHA256
+	select CRYPTO_HASH
+	help
+	  SHA-256 secure hash standard (DFIPS 180-2) implemented
+	  using OCTEON crypto instructions, when available.
+
+config CRYPTO_SHA512_OCTEON
+	tristate "SHA384 and SHA512 digest algorithms (OCTEON)"
+	depends on CPU_CAVIUM_OCTEON
+	select CRYPTO_SHA512
+	select CRYPTO_HASH
+	help
+	  SHA-512 secure hash standard (DFIPS 180-2) implemented
+	  using OCTEON crypto instructions, when available.
+
+config CRYPTO_CHACHA_MIPS
+	tristate "ChaCha stream cipher algorithms (MIPS 32r2 optimized)"
+	depends on CPU_MIPS32_R2
+	select CRYPTO_SKCIPHER
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+
+endmenu
diff --git a/crypto/Kconfig b/crypto/Kconfig
index bb427a835e44..7ed62dbb1902 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -699,14 +699,6 @@ config CRYPTO_CRC32_PCLMUL
 	  which will enable any routine to use the CRC-32-IEEE 802.3 checksum
 	  and gain better performance as compared with the table implementation.
 
-config CRYPTO_CRC32_MIPS
-	tristate "CRC32c and CRC32 CRC algorithm (MIPS)"
-	depends on MIPS_CRC_SUPPORT
-	select CRYPTO_HASH
-	help
-	  CRC32c and CRC32 CRC algorithms implemented using mips crypto
-	  instructions, when available.
-
 config CRYPTO_CRC32_S390
 	tristate "CRC-32 algorithms"
 	depends on S390
@@ -841,11 +833,6 @@ config CRYPTO_POLY1305_X86_64
 	  in IETF protocols. This is the x86_64 assembler implementation using SIMD
 	  instructions.
 
-config CRYPTO_POLY1305_MIPS
-	tristate "Poly1305 authenticator algorithm (MIPS optimized)"
-	depends on MIPS
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-
 config CRYPTO_MD4
 	tristate "MD4 digest algorithm"
 	select CRYPTO_HASH
@@ -858,15 +845,6 @@ config CRYPTO_MD5
 	help
 	  MD5 message digest algorithm (RFC1321).
 
-config CRYPTO_MD5_OCTEON
-	tristate "MD5 digest algorithm (OCTEON)"
-	depends on CPU_CAVIUM_OCTEON
-	select CRYPTO_MD5
-	select CRYPTO_HASH
-	help
-	  MD5 message digest algorithm (RFC1321) implemented
-	  using OCTEON crypto instructions, when available.
-
 config CRYPTO_MD5_PPC
 	tristate "MD5 digest algorithm (PPC)"
 	depends on PPC
@@ -961,15 +939,6 @@ config CRYPTO_SHA512_S390
 
 	  It is available as of z10.
 
-config CRYPTO_SHA1_OCTEON
-	tristate "SHA1 digest algorithm (OCTEON)"
-	depends on CPU_CAVIUM_OCTEON
-	select CRYPTO_SHA1
-	select CRYPTO_HASH
-	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
-	  using OCTEON crypto instructions, when available.
-
 config CRYPTO_SHA1_SPARC64
 	tristate "SHA1 digest algorithm (SPARC64)"
 	depends on SPARC64
@@ -1025,15 +994,6 @@ config CRYPTO_SHA256_PPC_SPE
 	  SHA224 and SHA256 secure hash standard (DFIPS 180-2)
 	  implemented using powerpc SPE SIMD instruction set.
 
-config CRYPTO_SHA256_OCTEON
-	tristate "SHA224 and SHA256 digest algorithm (OCTEON)"
-	depends on CPU_CAVIUM_OCTEON
-	select CRYPTO_SHA256
-	select CRYPTO_HASH
-	help
-	  SHA-256 secure hash standard (DFIPS 180-2) implemented
-	  using OCTEON crypto instructions, when available.
-
 config CRYPTO_SHA256_SPARC64
 	tristate "SHA224 and SHA256 digest algorithm (SPARC64)"
 	depends on SPARC64
@@ -1065,15 +1025,6 @@ config CRYPTO_SHA512
 	  This code also includes SHA-384, a 384 bit hash with 192 bits
 	  of security against collision attacks.
 
-config CRYPTO_SHA512_OCTEON
-	tristate "SHA384 and SHA512 digest algorithms (OCTEON)"
-	depends on CPU_CAVIUM_OCTEON
-	select CRYPTO_SHA512
-	select CRYPTO_HASH
-	help
-	  SHA-512 secure hash standard (DFIPS 180-2) implemented
-	  using OCTEON crypto instructions, when available.
-
 config CRYPTO_SHA512_SPARC64
 	tristate "SHA384 and SHA512 digest algorithm (SPARC64)"
 	depends on SPARC64
@@ -1611,12 +1562,6 @@ config CRYPTO_CHACHA20_X86_64
 	  SSSE3, AVX2, and AVX-512VL optimized implementations of the ChaCha20,
 	  XChaCha20, and XChaCha12 stream ciphers.
 
-config CRYPTO_CHACHA_MIPS
-	tristate "ChaCha stream cipher algorithms (MIPS 32r2 optimized)"
-	depends on CPU_MIPS32_R2
-	select CRYPTO_SKCIPHER
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-
 config CRYPTO_CHACHA_S390
 	tristate "ChaCha20 stream cipher"
 	depends on S390
@@ -2128,6 +2073,10 @@ config CRYPTO_STATS
 config CRYPTO_HASH_INFO
 	bool
 
+if MIPS
+source "arch/mips/crypto/Kconfig"
+endif
+
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"
-- 
2.37.1

