Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5BA59AFBE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiHTSm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiHTSmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:14 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF0444578;
        Sat, 20 Aug 2022 11:42:12 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KGCba0000559;
        Sat, 20 Aug 2022 18:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=ER9Dwg1h2BF0ceQiejnVIqgCIvg/EB10iBx0OpyoBxY=;
 b=WosHIS1BPFBR6plH1n+fUVeYM4Gbm+kXIBTQiiz2w+ouMr1BWKXiiZ88i9vDACC1uYJV
 DJVJ61uxkci7tmUfT0hvXwRQktcDzxUXRNZmsjgqpmdzCPWGJqd826mOQ0n6KtlJkUnu
 SCrBBv9KLBVuxbKz3KtE7J7FJiVocJmf78DeArg8rE/jJLcQkm5k6I6o6GVlr1iO8mwP
 S1SyGuQPjTz4m0e7VnFoC6gfmXC5/1bZ+INoFXO45GNy4nrQF7xccU0TBCLqKxUPCqkb
 4fatd8borjVeLa4zhhSEgxC2VhTl4+Xur7aw1muOEzg0J9kzIzNW/7bjawzUwGRbNmH6 jg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j32wvrjj5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:06 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id CA854D2E8;
        Sat, 20 Aug 2022 18:42:05 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 78CE3803510;
        Sat, 20 Aug 2022 18:42:05 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 03/17] crypto: Kconfig - move s390 entries to a submenu
Date:   Sat, 20 Aug 2022 13:41:37 -0500
Message-Id: <20220820184151.1149247-4-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
X-Proofpoint-GUID: CmnSSe0EuB1Twvix7bAXqSJjA38xsF4K
X-Proofpoint-ORIG-GUID: CmnSSe0EuB1Twvix7bAXqSJjA38xsF4K
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=640 adultscore=0 malwarescore=0
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
 arch/s390/crypto/Kconfig | 120 +++++++++++++++++++++++++++++++++++++++
 crypto/Kconfig           | 118 +-------------------------------------
 2 files changed, 123 insertions(+), 115 deletions(-)
 create mode 100644 arch/s390/crypto/Kconfig

diff --git a/arch/s390/crypto/Kconfig b/arch/s390/crypto/Kconfig
new file mode 100644
index 000000000000..ef0651d71e9d
--- /dev/null
+++ b/arch/s390/crypto/Kconfig
@@ -0,0 +1,120 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Accelerated Cryptographic Algorithms for CPU (s390)"
+
+config CRYPTO_CRC32_S390
+	tristate "CRC-32 algorithms"
+	depends on S390
+	select CRYPTO_HASH
+	select CRC32
+	help
+	  Select this option if you want to use hardware accelerated
+	  implementations of CRC algorithms.  With this option, you
+	  can optimize the computation of CRC-32 (IEEE 802.3 Ethernet)
+	  and CRC-32C (Castagnoli).
+
+	  It is available with IBM z13 or later.
+
+config CRYPTO_SHA512_S390
+	tristate "SHA384 and SHA512 digest algorithm"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA512 secure hash standard.
+
+	  It is available as of z10.
+
+config CRYPTO_SHA1_S390
+	tristate "SHA1 digest algorithm"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+
+	  It is available as of z990.
+
+config CRYPTO_SHA256_S390
+	tristate "SHA256 digest algorithm"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA256 secure hash standard (DFIPS 180-2).
+
+	  It is available as of z9.
+
+config CRYPTO_SHA3_256_S390
+	tristate "SHA3_224 and SHA3_256 digest algorithm"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA3_256 secure hash standard.
+
+	  It is available as of z14.
+
+config CRYPTO_SHA3_512_S390
+	tristate "SHA3_384 and SHA3_512 digest algorithm"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  SHA3_512 secure hash standard.
+
+	  It is available as of z14.
+
+config CRYPTO_GHASH_S390
+	tristate "GHASH hash function"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  This is the s390 hardware accelerated implementation of GHASH,
+	  the hash function used in GCM (Galois/Counter mode).
+
+	  It is available as of z196.
+
+config CRYPTO_AES_S390
+	tristate "AES cipher algorithms"
+	depends on S390
+	select CRYPTO_ALGAPI
+	select CRYPTO_SKCIPHER
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  AES cipher algorithms (FIPS-197).
+
+	  As of z9 the ECB and CBC modes are hardware accelerated
+	  for 128 bit keys.
+	  As of z10 the ECB and CBC modes are hardware accelerated
+	  for all AES key sizes.
+	  As of z196 the CTR mode is hardware accelerated for all AES
+	  key sizes and XTS mode is hardware accelerated for 256 and
+	  512 bit keys.
+
+config CRYPTO_DES_S390
+	tristate "DES and Triple DES cipher algorithms"
+	depends on S390
+	select CRYPTO_ALGAPI
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_DES
+	help
+	  This is the s390 hardware accelerated implementation of the
+	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
+
+	  As of z990 the ECB and CBC mode are hardware accelerated.
+	  As of z196 the CTR mode is hardware accelerated.
+
+config CRYPTO_CHACHA_S390
+	tristate "ChaCha20 stream cipher"
+	depends on S390
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	help
+	  This is the s390 SIMD implementation of the ChaCha20 stream
+	  cipher (RFC 7539).
+
+	  It is available as of z13.
+
+endmenu
diff --git a/crypto/Kconfig b/crypto/Kconfig
index beaf87935cae..dff5bb211cbf 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -688,19 +688,6 @@ config CRYPTO_CRC32_PCLMUL
 	  which will enable any routine to use the CRC-32-IEEE 802.3 checksum
 	  and gain better performance as compared with the table implementation.
 
-config CRYPTO_CRC32_S390
-	tristate "CRC-32 algorithms"
-	depends on S390
-	select CRYPTO_HASH
-	select CRC32
-	help
-	  Select this option if you want to use hardware accelerated
-	  implementations of CRC algorithms.  With this option, you
-	  can optimize the computation of CRC-32 (IEEE 802.3 Ethernet)
-	  and CRC-32C (Castagnoli).
-
-	  It is available with IBM z13 or later.
-
 config CRYPTO_XXHASH
 	tristate "xxHash hash algorithm"
 	select CRYPTO_HASH
@@ -893,16 +880,6 @@ config CRYPTO_SHA512_SSSE3
 	  Extensions version 1 (AVX1), or Advanced Vector Extensions
 	  version 2 (AVX2) instructions, when available.
 
-config CRYPTO_SHA512_S390
-	tristate "SHA384 and SHA512 digest algorithm"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA512 secure hash standard.
-
-	  It is available as of z10.
-
 config CRYPTO_SHA1_SPARC64
 	tristate "SHA1 digest algorithm (SPARC64)"
 	depends on SPARC64
@@ -912,16 +889,6 @@ config CRYPTO_SHA1_SPARC64
 	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
 	  using sparc64 crypto instructions, when available.
 
-config CRYPTO_SHA1_S390
-	tristate "SHA1 digest algorithm"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
-
-	  It is available as of z990.
-
 config CRYPTO_SHA256
 	tristate "SHA224 and SHA256 digest algorithm"
 	select CRYPTO_HASH
@@ -944,16 +911,6 @@ config CRYPTO_SHA256_SPARC64
 	  SHA-256 secure hash standard (DFIPS 180-2) implemented
 	  using sparc64 crypto instructions, when available.
 
-config CRYPTO_SHA256_S390
-	tristate "SHA256 digest algorithm"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA256 secure hash standard (DFIPS 180-2).
-
-	  It is available as of z9.
-
 config CRYPTO_SHA512
 	tristate "SHA384 and SHA512 digest algorithms"
 	select CRYPTO_HASH
@@ -985,26 +942,6 @@ config CRYPTO_SHA3
 	  References:
 	  http://keccak.noekeon.org/
 
-config CRYPTO_SHA3_256_S390
-	tristate "SHA3_224 and SHA3_256 digest algorithm"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA3_256 secure hash standard.
-
-	  It is available as of z14.
-
-config CRYPTO_SHA3_512_S390
-	tristate "SHA3_384 and SHA3_512 digest algorithm"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA3_512 secure hash standard.
-
-	  It is available as of z14.
-
 config CRYPTO_SM3
 	tristate
 
@@ -1065,16 +1002,6 @@ config CRYPTO_GHASH_CLMUL_NI_INTEL
 	  This is the x86_64 CLMUL-NI accelerated implementation of
 	  GHASH, the hash function used in GCM (Galois/Counter mode).
 
-config CRYPTO_GHASH_S390
-	tristate "GHASH hash function"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  This is the s390 hardware accelerated implementation of GHASH,
-	  the hash function used in GCM (Galois/Counter mode).
-
-	  It is available as of z196.
-
 comment "Ciphers"
 
 config CRYPTO_AES
@@ -1176,23 +1103,6 @@ config CRYPTO_AES_SPARC64
 	  for some popular block cipher mode is supported too, including
 	  ECB and CBC.
 
-config CRYPTO_AES_S390
-	tristate "AES cipher algorithms"
-	depends on S390
-	select CRYPTO_ALGAPI
-	select CRYPTO_SKCIPHER
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  AES cipher algorithms (FIPS-197).
-
-	  As of z9 the ECB and CBC modes are hardware accelerated
-	  for 128 bit keys.
-	  As of z10 the ECB and CBC modes are hardware accelerated
-	  for all AES key sizes.
-	  As of z196 the CTR mode is hardware accelerated for all AES
-	  key sizes and XTS mode is hardware accelerated for 256 and
-	  512 bit keys.
-
 config CRYPTO_ANUBIS
 	tristate "Anubis cipher algorithm"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
@@ -1423,19 +1333,6 @@ config CRYPTO_DES3_EDE_X86_64
 	  algorithm are provided; regular processing one input block and
 	  one that processes three blocks parallel.
 
-config CRYPTO_DES_S390
-	tristate "DES and Triple DES cipher algorithms"
-	depends on S390
-	select CRYPTO_ALGAPI
-	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_DES
-	help
-	  This is the s390 hardware accelerated implementation of the
-	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
-
-	  As of z990 the ECB and CBC mode are hardware accelerated.
-	  As of z196 the CTR mode is hardware accelerated.
-
 config CRYPTO_FCRYPT
 	tristate "FCrypt cipher algorithm"
 	select CRYPTO_ALGAPI
@@ -1489,18 +1386,6 @@ config CRYPTO_CHACHA20_X86_64
 	  SSSE3, AVX2, and AVX-512VL optimized implementations of the ChaCha20,
 	  XChaCha20, and XChaCha12 stream ciphers.
 
-config CRYPTO_CHACHA_S390
-	tristate "ChaCha20 stream cipher"
-	depends on S390
-	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	help
-	  This is the s390 SIMD implementation of the ChaCha20 stream
-	  cipher (RFC 7539).
-
-	  It is available as of z13.
-
 config CRYPTO_SEED
 	tristate "SEED cipher algorithm"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
@@ -2006,6 +1891,9 @@ config CRYPTO_HASH_INFO
 if PPC
 source "arch/powerpc/crypto/Kconfig"
 endif
+if S390
+source "arch/s390/crypto/Kconfig"
+endif
 
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
-- 
2.37.1

