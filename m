Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBFF59AFB7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbiHTSma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiHTSmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:14 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B5A44575;
        Sat, 20 Aug 2022 11:42:12 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KFFTxe009110;
        Sat, 20 Aug 2022 18:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=9vVErxsn7pjdDEsYQ/oatkF2O/0rBE5AITWcP9KySUc=;
 b=I0AGj84jN6tpoJoNNK4xGccfg7DxFFNkmOVwSchUIvXj929A1d9LbYdNvG5CBW0wWc2v
 GhwhJv6nuwjBmXiJxq8/zbQZ8b1LkUcGqQCYGGD/AT81g/10xcpToe0+toYegymgN0UO
 oLe/vctJWtyH/lo2VLq+/UjFMzimo3H8fMT/mg8AY+LDFt65cBjFSihILQ8UNoYeG/f2
 XiThuvDQiN7QmDJG37C2mtduraK8q+yiumkhHylqzBD8SRtsD+r/UwrWqkRuxjELqFAS
 FE11gcBk289FYCn3TiOglqLBv//22rmHVYzdjlepLmwRQ66i5C76jkjNyl9KJrSDkxQY zw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wqp23cw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:08 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 4F7218000B7;
        Sat, 20 Aug 2022 18:42:07 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id F0AA3803510;
        Sat, 20 Aug 2022 18:42:06 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 04/17] crypto: Kconfig - move sparc entries to a submenu
Date:   Sat, 20 Aug 2022 13:41:38 -0500
Message-Id: <20220820184151.1149247-5-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
X-Proofpoint-GUID: -eXcMqIoOyFhQkqgeUJcnUW8N-6UdO5i
X-Proofpoint-ORIG-GUID: -eXcMqIoOyFhQkqgeUJcnUW8N-6UdO5i
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208200079
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
index 000000000000..eaa2afc1d50a
--- /dev/null
+++ b/arch/sparc/crypto/Kconfig
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Accelerated Cryptographic Algorithms for CPU (sparc64)"
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
+endmenu
diff --git a/crypto/Kconfig b/crypto/Kconfig
index dff5bb211cbf..e73a344e00de 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -658,15 +658,6 @@ config CRYPTO_CRC32C_INTEL
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
@@ -804,15 +795,6 @@ config CRYPTO_MD5
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
@@ -880,15 +862,6 @@ config CRYPTO_SHA512_SSSE3
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
@@ -902,15 +875,6 @@ config CRYPTO_SHA256
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
@@ -923,15 +887,6 @@ config CRYPTO_SHA512
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
@@ -1076,33 +1031,6 @@ config CRYPTO_AES_NI_INTEL
 	  ECB, CBC, LRW, XTS. The 64 bit version has additional
 	  acceleration for CTR and XCTR.
 
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
@@ -1233,22 +1161,6 @@ config CRYPTO_CAMELLIA_AESNI_AVX2_X86_64
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
@@ -1309,16 +1221,6 @@ config CRYPTO_DES
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
@@ -1894,6 +1796,9 @@ config CRYPTO_HASH_INFO
 if S390
 source "arch/s390/crypto/Kconfig"
 endif
+if SPARC
+source "arch/sparc/crypto/Kconfig"
+endif
 
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
-- 
2.37.1

