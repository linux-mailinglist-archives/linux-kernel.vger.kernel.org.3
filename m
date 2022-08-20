Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8959AFB4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbiHTSmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiHTSmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:11 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FFE44578;
        Sat, 20 Aug 2022 11:42:09 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KADcId031878;
        Sat, 20 Aug 2022 18:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=DiNPZIU3Z9/VBd7Dj6ccn48bW+FMhczFIqNGQsyWuAg=;
 b=hD6gfLd8r+7P3qy7dHhCOW5nOV35CCWeg2/FKtC6cComdQPFlrGIrQ1c9pB3wdl/T03J
 5x9KYuIUsEVd3qCMq2pns3MkPqEl0W7soow4BWQRbpCvmBKEhWg9xGfBiRNyJ4Nf1j/B
 ZrgeK8ToKpaELPrMw/Kz3kKDtEqiiE2yVU1DfCCG4luebXj4+SAesirq327eotcn7zGM
 nKdOnLII1a+r8cAuzI1uoFP+b6InMh8lgNdDFCfCLoigNIcq2JTi+DU4IolKDE0fqt3f
 yKa6BKuZhRvAYiqnIEWvtnRpr6vzZatSV41GbpB9o0/C6G6A3kyWC4Xt9GakDryOU02h 0Q== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wnn27j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:02 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id ADC93D2F2;
        Sat, 20 Aug 2022 18:42:01 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 5AA6C8058E9;
        Sat, 20 Aug 2022 18:42:01 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 02/17] crypto: Kconfig - move powerpc entries to a submenu
Date:   Sat, 20 Aug 2022 13:41:36 -0500
Message-Id: <20220820184151.1149247-3-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _Iqvx0ZKYC836ADUQiSWLyKkLYkpK8li
X-Proofpoint-ORIG-GUID: _Iqvx0ZKYC836ADUQiSWLyKkLYkpK8li
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 mlxlogscore=979 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208200080
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
 arch/powerpc/crypto/Kconfig | 77 +++++++++++++++++++++++++++++++++++++
 crypto/Kconfig              | 76 ++----------------------------------
 2 files changed, 80 insertions(+), 73 deletions(-)
 create mode 100644 arch/powerpc/crypto/Kconfig

diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
new file mode 100644
index 000000000000..74f535940faa
--- /dev/null
+++ b/arch/powerpc/crypto/Kconfig
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Accelerated Cryptographic Algorithms for CPU (powerpc)"
+
+config CRYPTO_CRC32C_VPMSUM
+	tristate "CRC32c CRC algorithm (powerpc64)"
+	depends on PPC64 && ALTIVEC
+	select CRYPTO_HASH
+	select CRC32
+	help
+	  CRC32c algorithm implemented using vector polynomial multiply-sum
+	  (vpmsum) instructions, introduced in POWER8. Enable on POWER8
+	  and newer processors for improved performance.
+
+config CRYPTO_CRCT10DIF_VPMSUM
+	tristate "CRC32T10DIF powerpc64 hardware acceleration"
+	depends on PPC64 && ALTIVEC && CRC_T10DIF
+	select CRYPTO_HASH
+	help
+	  CRC10T10DIF algorithm implemented using vector polynomial
+	  multiply-sum (vpmsum) instructions, introduced in POWER8. Enable on
+	  POWER8 and newer processors for improved performance.
+
+config CRYPTO_VPMSUM_TESTER
+	tristate "Powerpc64 vpmsum hardware acceleration tester"
+	depends on CRYPTO_CRCT10DIF_VPMSUM && CRYPTO_CRC32C_VPMSUM
+	help
+	  Stress test for CRC32c and CRC-T10DIF algorithms implemented with
+	  POWER8 vpmsum instructions.
+	  Unless you are testing these algorithms, you don't need this.
+
+config CRYPTO_MD5_PPC
+	tristate "MD5 digest algorithm (PPC)"
+	depends on PPC
+	select CRYPTO_HASH
+	help
+	  MD5 message digest algorithm (RFC1321) implemented
+	  in PPC assembler.
+
+config CRYPTO_SHA1_PPC
+	tristate "SHA1 digest algorithm (powerpc)"
+	depends on PPC
+	help
+	  This is the powerpc hardware accelerated implementation of the
+	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+
+config CRYPTO_SHA1_PPC_SPE
+	tristate "SHA1 digest algorithm (PPC SPE)"
+	depends on PPC && SPE
+	help
+	  SHA-1 secure hash standard (DFIPS 180-4) implemented
+	  using powerpc SPE SIMD instruction set.
+
+config CRYPTO_SHA256_PPC_SPE
+	tristate "SHA224 and SHA256 digest algorithm (PPC SPE)"
+	depends on PPC && SPE
+	select CRYPTO_SHA256
+	select CRYPTO_HASH
+	help
+	  SHA224 and SHA256 secure hash standard (DFIPS 180-2)
+	  implemented using powerpc SPE SIMD instruction set.
+
+config CRYPTO_AES_PPC_SPE
+	tristate "AES cipher algorithms (PPC SPE)"
+	depends on PPC && SPE
+	select CRYPTO_SKCIPHER
+	help
+	  AES cipher algorithms (FIPS-197). Additionally the acceleration
+	  for popular block cipher modes ECB, CBC, CTR and XTS is supported.
+	  This module should only be used for low power (router) devices
+	  without hardware AES acceleration (e.g. caam crypto). It reduces the
+	  size of the AES tables from 16KB to 8KB + 256 bytes and mitigates
+	  timining attacks. Nevertheless it might be not as secure as other
+	  architecture specific assembler implementations that work on 1KB
+	  tables or 256 bytes S-boxes.
+
+endmenu
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 7ed62dbb1902..beaf87935cae 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -658,17 +658,6 @@ config CRYPTO_CRC32C_INTEL
 	  gain performance compared with software implementation.
 	  Module will be crc32c-intel.
 
-config CRYPTO_CRC32C_VPMSUM
-	tristate "CRC32c CRC algorithm (powerpc64)"
-	depends on PPC64 && ALTIVEC
-	select CRYPTO_HASH
-	select CRC32
-	help
-	  CRC32c algorithm implemented using vector polynomial multiply-sum
-	  (vpmsum) instructions, introduced in POWER8. Enable on POWER8
-	  and newer processors for improved performance.
-
-
 config CRYPTO_CRC32C_SPARC64
 	tristate "CRC32c CRC algorithm (SPARC64)"
 	depends on SPARC64
@@ -762,28 +751,11 @@ config CRYPTO_CRCT10DIF_PCLMUL
 	  'crct10dif-pclmul' module, which is faster when computing the
 	  crct10dif checksum as compared with the generic table implementation.
 
-config CRYPTO_CRCT10DIF_VPMSUM
-	tristate "CRC32T10DIF powerpc64 hardware acceleration"
-	depends on PPC64 && ALTIVEC && CRC_T10DIF
-	select CRYPTO_HASH
-	help
-	  CRC10T10DIF algorithm implemented using vector polynomial
-	  multiply-sum (vpmsum) instructions, introduced in POWER8. Enable on
-	  POWER8 and newer processors for improved performance.
-
 config CRYPTO_CRC64_ROCKSOFT
 	tristate "Rocksoft Model CRC64 algorithm"
 	depends on CRC64
 	select CRYPTO_HASH
 
-config CRYPTO_VPMSUM_TESTER
-	tristate "Powerpc64 vpmsum hardware acceleration tester"
-	depends on CRYPTO_CRCT10DIF_VPMSUM && CRYPTO_CRC32C_VPMSUM
-	help
-	  Stress test for CRC32c and CRC-T10DIF algorithms implemented with
-	  POWER8 vpmsum instructions.
-	  Unless you are testing these algorithms, you don't need this.
-
 config CRYPTO_GHASH
 	tristate "GHASH hash function"
 	select CRYPTO_GF128MUL
@@ -845,14 +817,6 @@ config CRYPTO_MD5
 	help
 	  MD5 message digest algorithm (RFC1321).
 
-config CRYPTO_MD5_PPC
-	tristate "MD5 digest algorithm (PPC)"
-	depends on PPC
-	select CRYPTO_HASH
-	help
-	  MD5 message digest algorithm (RFC1321) implemented
-	  in PPC assembler.
-
 config CRYPTO_MD5_SPARC64
 	tristate "MD5 digest algorithm (SPARC64)"
 	depends on SPARC64
@@ -948,20 +912,6 @@ config CRYPTO_SHA1_SPARC64
 	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
 	  using sparc64 crypto instructions, when available.
 
-config CRYPTO_SHA1_PPC
-	tristate "SHA1 digest algorithm (powerpc)"
-	depends on PPC
-	help
-	  This is the powerpc hardware accelerated implementation of the
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
-
-config CRYPTO_SHA1_PPC_SPE
-	tristate "SHA1 digest algorithm (PPC SPE)"
-	depends on PPC && SPE
-	help
-	  SHA-1 secure hash standard (DFIPS 180-4) implemented
-	  using powerpc SPE SIMD instruction set.
-
 config CRYPTO_SHA1_S390
 	tristate "SHA1 digest algorithm"
 	depends on S390
@@ -985,15 +935,6 @@ config CRYPTO_SHA256
 	  This code also includes SHA-224, a 224 bit hash with 112 bits
 	  of security against collision attacks.
 
-config CRYPTO_SHA256_PPC_SPE
-	tristate "SHA224 and SHA256 digest algorithm (PPC SPE)"
-	depends on PPC && SPE
-	select CRYPTO_SHA256
-	select CRYPTO_HASH
-	help
-	  SHA224 and SHA256 secure hash standard (DFIPS 180-2)
-	  implemented using powerpc SPE SIMD instruction set.
-
 config CRYPTO_SHA256_SPARC64
 	tristate "SHA224 and SHA256 digest algorithm (SPARC64)"
 	depends on SPARC64
@@ -1235,20 +1176,6 @@ config CRYPTO_AES_SPARC64
 	  for some popular block cipher mode is supported too, including
 	  ECB and CBC.
 
-config CRYPTO_AES_PPC_SPE
-	tristate "AES cipher algorithms (PPC SPE)"
-	depends on PPC && SPE
-	select CRYPTO_SKCIPHER
-	help
-	  AES cipher algorithms (FIPS-197). Additionally the acceleration
-	  for popular block cipher modes ECB, CBC, CTR and XTS is supported.
-	  This module should only be used for low power (router) devices
-	  without hardware AES acceleration (e.g. caam crypto). It reduces the
-	  size of the AES tables from 16KB to 8KB + 256 bytes and mitigates
-	  timining attacks. Nevertheless it might be not as secure as other
-	  architecture specific assembler implementations that work on 1KB
-	  tables or 256 bytes S-boxes.
-
 config CRYPTO_AES_S390
 	tristate "AES cipher algorithms"
 	depends on S390
@@ -2076,6 +2003,9 @@ config CRYPTO_HASH_INFO
 if MIPS
 source "arch/mips/crypto/Kconfig"
 endif
+if PPC
+source "arch/powerpc/crypto/Kconfig"
+endif
 
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
-- 
2.37.1

