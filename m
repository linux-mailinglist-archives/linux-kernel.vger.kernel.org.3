Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B09597A30
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242341AbiHQXVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242251AbiHQXV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:21:29 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A2FA404E;
        Wed, 17 Aug 2022 16:21:23 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HMYgQk004694;
        Wed, 17 Aug 2022 23:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=XVTh9LFifTJjbKoOaCrCHNWQi9V5/V0A+uf4GMBkNEA=;
 b=BWb4EsWx6Hyek92gtq5rlX6rWydfrgfuxIij+Igk3eLMJezglQ3AiNxCK3ExGvAIsYbd
 Hc1kQkbtvg/WED9kqSL463e7kO9qey49KKpdqEDoXvIjxXXOTviLesegMkcHUnLFZY4G
 ND8IcVtgZCNxq+P/8cp1az391lP69JIFPt5UMGPr9avXDoZCQCy/tyqqa+nyv9El4qKf
 32A1Q4qVwlf0McoqyEUv5UnH/uP+XROzjQfNFkf3YwS/WvQggnluLdJic218mgqF6Fau
 V3abC0lYQqh2lDc+JtJurrGXfsBbpEE19vnlUvmx0J8KZjDaHuv6iRHQbKUWBuV6HfRi 8A== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j19810aub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 23:21:17 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 46F4E804CB0;
        Wed, 17 Aug 2022 23:21:16 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 02FA580171A;
        Wed, 17 Aug 2022 23:21:15 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 04/10] crypto: Kconfig - move sparc entries to a submenu
Date:   Wed, 17 Aug 2022 18:20:51 -0500
Message-Id: <20220817232057.73643-5-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817232057.73643-1-elliott@hpe.com>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
X-Proofpoint-GUID: ko29fw-VTsJ_edzyyVK-G7YwJAx8V30B
X-Proofpoint-ORIG-GUID: ko29fw-VTsJ_edzyyVK-G7YwJAx8V30B
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_15,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208170088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 arch/sparc/crypto/Kconfig | 103 ++++++++++++++++++++++++++++++++++++++
 crypto/Kconfig            | 101 ++-----------------------------------
 2 files changed, 106 insertions(+), 98 deletions(-)
 create mode 100644 arch/sparc/crypto/Kconfig

diff --git a/arch/sparc/crypto/Kconfig b/arch/sparc/crypto/Kconfig
new file mode 100644
index 000000000000..0e99310d2497
--- /dev/null
+++ b/arch/sparc/crypto/Kconfig
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Accelerated Cryptographic Algorithms for CPU (sparc64)"
+
+config CRYPTO_CRC32C_SPARC64
+	tristate "CRC32c CRC algorithm (SPARC64)"
+	depends on SPARC64
+	select CRYPTO_HASH
+	select CRC32
+	help
+	  CRC32c CRC algorithm implemented using sparc64 crypto instructions,
+	  when available.
+
+config CRYPTO_MD5_SPARC64
+	tristate "MD5 digest algorithm (SPARC64)"
+	depends on SPARC64
+	select CRYPTO_MD5
+	select CRYPTO_HASH
+	help
+	  MD5 message digest algorithm (RFC1321) implemented
+	  using sparc64 crypto instructions, when available.
+
+config CRYPTO_SHA1_SPARC64
+	tristate "SHA1 digest algorithm (SPARC64)"
+	depends on SPARC64
+	select CRYPTO_SHA1
+	select CRYPTO_HASH
+	help
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
+	  using sparc64 crypto instructions, when available.
+
+config CRYPTO_SHA256_SPARC64
+	tristate "SHA224 and SHA256 digest algorithm (SPARC64)"
+	depends on SPARC64
+	select CRYPTO_SHA256
+	select CRYPTO_HASH
+	help
+	  SHA-256 secure hash standard (DFIPS 180-2) implemented
+	  using sparc64 crypto instructions, when available.
+
+config CRYPTO_SHA512_SPARC64
+	tristate "SHA384 and SHA512 digest algorithm (SPARC64)"
+	depends on SPARC64
+	select CRYPTO_SHA512
+	select CRYPTO_HASH
+	help
+	  SHA-512 secure hash standard (DFIPS 180-2) implemented
+	  using sparc64 crypto instructions, when available.
+
+config CRYPTO_AES_SPARC64
+	tristate "AES cipher algorithms (SPARC64)"
+	depends on SPARC64
+	select CRYPTO_SKCIPHER
+	help
+	  Use SPARC64 crypto opcodes for AES algorithm.
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
+	  ECB and CBC.
+
+config CRYPTO_CAMELLIA_SPARC64
+	tristate "Camellia cipher algorithm (SPARC64)"
+	depends on SPARC64
+	select CRYPTO_ALGAPI
+	select CRYPTO_SKCIPHER
+	help
+	  Camellia cipher algorithm module (SPARC64).
+
+	  Camellia is a symmetric key block cipher developed jointly
+	  at NTT and Mitsubishi Electric Corporation.
+
+	  The Camellia specifies three key sizes: 128, 192 and 256 bits.
+
+	  See also:
+	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
+
+config CRYPTO_DES_SPARC64
+	tristate "DES and Triple DES EDE cipher algorithms (SPARC64)"
+	depends on SPARC64
+	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_DES
+	select CRYPTO_SKCIPHER
+	help
+	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3),
+	  optimized using SPARC64 crypto opcodes.
+
+endmenu
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 5678f7f18b76..2db3480158aa 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -617,15 +617,6 @@ menuconfig CRYPTO
 	  gain performance compared with software implementation.
 	  Module will be crc32c-intel.
 
-config CRYPTO_CRC32C_SPARC64
-	tristate "CRC32c CRC algorithm (SPARC64)"
-	depends on SPARC64
-	select CRYPTO_HASH
-	select CRC32
-	help
-	  CRC32c CRC algorithm implemented using sparc64 crypto instructions,
-	  when available.
-
 config CRYPTO_CRC32
 	tristate "CRC32 CRC algorithm"
 	select CRYPTO_HASH
@@ -764,15 +755,6 @@ menuconfig CRYPTO
 	help
 	  MD5 message digest algorithm (RFC1321).
 
-config CRYPTO_MD5_SPARC64
-	tristate "MD5 digest algorithm (SPARC64)"
-	depends on SPARC64
-	select CRYPTO_MD5
-	select CRYPTO_HASH
-	help
-	  MD5 message digest algorithm (RFC1321) implemented
-	  using sparc64 crypto instructions, when available.
-
 config CRYPTO_MICHAEL_MIC
 	tristate "Michael MIC keyed digest algorithm"
 	select CRYPTO_HASH
@@ -839,15 +821,6 @@ menuconfig CRYPTO
 	  Extensions version 1 (AVX1), or Advanced Vector Extensions
 	  version 2 (AVX2) instructions, when available.
 
-config CRYPTO_SHA1_SPARC64
-	tristate "SHA1 digest algorithm (SPARC64)"
-	depends on SPARC64
-	select CRYPTO_SHA1
-	select CRYPTO_HASH
-	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
-	  using sparc64 crypto instructions, when available.
-
 config CRYPTO_SHA256
 	tristate "SHA224 and SHA256 digest algorithm"
 	select CRYPTO_HASH
@@ -861,15 +834,6 @@ menuconfig CRYPTO
 	  This code also includes SHA-224, a 224 bit hash with 112 bits
 	  of security against collision attacks.
 
-config CRYPTO_SHA256_SPARC64
-	tristate "SHA224 and SHA256 digest algorithm (SPARC64)"
-	depends on SPARC64
-	select CRYPTO_SHA256
-	select CRYPTO_HASH
-	help
-	  SHA-256 secure hash standard (DFIPS 180-2) implemented
-	  using sparc64 crypto instructions, when available.
-
 config CRYPTO_SHA512
 	tristate "SHA384 and SHA512 digest algorithms"
 	select CRYPTO_HASH
@@ -882,15 +846,6 @@ menuconfig CRYPTO
 	  This code also includes SHA-384, a 384 bit hash with 192 bits
 	  of security against collision attacks.
 
-config CRYPTO_SHA512_SPARC64
-	tristate "SHA384 and SHA512 digest algorithm (SPARC64)"
-	depends on SPARC64
-	select CRYPTO_SHA512
-	select CRYPTO_HASH
-	help
-	  SHA-512 secure hash standard (DFIPS 180-2) implemented
-	  using sparc64 crypto instructions, when available.
-
 config CRYPTO_SHA3
 	tristate "SHA3 digest algorithm"
 	select CRYPTO_HASH
@@ -1035,33 +990,6 @@ menuconfig CRYPTO
 	  ECB, CBC, LRW, XTS. The 64 bit version has additional
 	  acceleration for CTR.
 
-config CRYPTO_AES_SPARC64
-	tristate "AES cipher algorithms (SPARC64)"
-	depends on SPARC64
-	select CRYPTO_SKCIPHER
-	help
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
-
-	  See <http://csrc.nist.gov/encryption/aes/> for more information.
-
-	  In addition to AES cipher algorithm support, the acceleration
-	  for some popular block cipher mode is supported too, including
-	  ECB and CBC.
-
 config CRYPTO_ANUBIS
 	tristate "Anubis cipher algorithm"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
@@ -1192,22 +1120,6 @@ menuconfig CRYPTO
 	  See also:
 	  <https://info.isl.ntt.co.jp/crypt/eng/camellia/index_s.html>
 
-config CRYPTO_CAMELLIA_SPARC64
-	tristate "Camellia cipher algorithm (SPARC64)"
-	depends on SPARC64
-	select CRYPTO_ALGAPI
-	select CRYPTO_SKCIPHER
-	help
-	  Camellia cipher algorithm module (SPARC64).
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
@@ -1268,16 +1180,6 @@ menuconfig CRYPTO
 	help
 	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
 
-config CRYPTO_DES_SPARC64
-	tristate "DES and Triple DES EDE cipher algorithms (SPARC64)"
-	depends on SPARC64
-	select CRYPTO_ALGAPI
-	select CRYPTO_LIB_DES
-	select CRYPTO_SKCIPHER
-	help
-	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3),
-	  optimized using SPARC64 crypto opcodes.
-
 config CRYPTO_DES3_EDE_X86_64
 	tristate "Triple DES EDE cipher algorithm (x86-64)"
 	depends on X86 && 64BIT
@@ -1838,6 +1740,9 @@ menuconfig CRYPTO_DRBG_MENU
 if S390
 source "arch/s390/crypto/Kconfig"
 endif
+if SPARC64
+source "arch/sparc/crypto/Kconfig"
+endif
 
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
-- 
2.37.1

