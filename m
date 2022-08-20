Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7263D59AFA7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiHTSnS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbiHTSmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:37 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6375245073;
        Sat, 20 Aug 2022 11:42:28 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KAI7ma003285;
        Sat, 20 Aug 2022 18:42:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=kgJCPgqFPl++lvasps/Ie5Mx88SAhREGR8vjJHMNJBI=;
 b=NELpxd4f7Zfbo6dVjkArPPkOGC3++XToC6CasDIgLiCjecY2qHIUPIcF+974UjOcO41/
 TTd+PWXC7Bjq35dx4bSYtvqHlEhUeJ4tKlHstEYg6yNI+3HmAGK/1sXKRHbOArj8JKHH
 qk2lXQ9JnOSynaEdYFq1ZIPW9ZCkdAUnzos9fyF4/S3e6/NDeFgycL8ZCxitp0yIK1Li
 b1sWJ5Uk5K/crbDn8HdiB23qhd9oQadUerLWaJQkC5r/biqpwY4mULSZaTlkH4kDuhO9
 JmKWt/FFWwk+4LIjZhz1b3Iqi/9YSolRaR5nOGXKb35xD7OAW8lUITfAJwELUJ7VOT7Y 6w== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wqpj2pc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:21 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id A4D48D2EA;
        Sat, 20 Aug 2022 18:42:20 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 520818036AB;
        Sat, 20 Aug 2022 18:42:20 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 12/17] crypto: Kconfig - simplify CRC entries
Date:   Sat, 20 Aug 2022 13:41:46 -0500
Message-Id: <20220820184151.1149247-13-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
X-Proofpoint-GUID: IANnbJgFd8rC-FkVIufzaIbLvS7Zi5Hf
X-Proofpoint-ORIG-GUID: IANnbJgFd8rC-FkVIufzaIbLvS7Zi5Hf
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=951 adultscore=0 priorityscore=1501
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 arch/arm/crypto/Kconfig     | 17 +++++++++++++++--
 arch/arm64/crypto/Kconfig   |  7 ++++++-
 arch/mips/crypto/Kconfig    |  7 ++++---
 arch/powerpc/crypto/Kconfig | 28 +++++++++++++++++-----------
 arch/s390/crypto/Kconfig    |  9 ++++-----
 arch/sparc/crypto/Kconfig   |  7 ++++---
 arch/x86/crypto/Kconfig     | 36 ++++++++++++++++--------------------
 crypto/Kconfig              | 37 +++++++++++++++++++++++++------------
 8 files changed, 91 insertions(+), 57 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 4b062bf53fa2..75684521f581 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -157,16 +157,29 @@ config CRYPTO_CHACHA20_NEON
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_CRC32_ARM_CE
-	tristate "CRC32(C) digest algorithm using CRC and/or PMULL instructions"
+	tristate "CRC32C and CRC32"
 	depends on KERNEL_MODE_NEON
 	depends on CRC32
 	select CRYPTO_HASH
+	help
+	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
+	  and CRC32 CRC algorithm (IEEE 802.3)
+
+	  Architecture: arm using:
+	  - CRC and/or PMULL instructions
+
+	  Drivers: crc32-arm-ce and crc32c-arm-ce
 
 config CRYPTO_CRCT10DIF_ARM_CE
-	tristate "CRCT10DIF digest algorithm using PMULL instructions"
+	tristate "CRCT10DIF"
 	depends on KERNEL_MODE_NEON
 	depends on CRC_T10DIF
 	select CRYPTO_HASH
+	help
+	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
+
+	  Architecture: arm using:
+	  - PMULL (Polynomial Multiply Long) instructions
 
 endmenu
 
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index c5d42f62d8bb..cfc934880c97 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -127,9 +127,14 @@ config CRYPTO_AES_ARM64_CE_CCM
 	select CRYPTO_LIB_AES
 
 config CRYPTO_CRCT10DIF_ARM64_CE
-	tristate "CRCT10DIF digest algorithm using PMULL instructions"
+	tristate "CRCT10DIF (PMULL)"
 	depends on KERNEL_MODE_NEON && CRC_T10DIF
 	select CRYPTO_HASH
+	help
+	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
+
+	  Architecture: arm64 using
+	  - PMULL (Polynomial Multiply Long) instructions
 
 endmenu
 
diff --git a/arch/mips/crypto/Kconfig b/arch/mips/crypto/Kconfig
index 7c07611e2322..8a40add80430 100644
--- a/arch/mips/crypto/Kconfig
+++ b/arch/mips/crypto/Kconfig
@@ -3,12 +3,13 @@
 menu "Accelerated Cryptographic Algorithms for CPU (mips)"
 
 config CRYPTO_CRC32_MIPS
-	tristate "CRC32c and CRC32 CRC algorithm (MIPS)"
+	tristate "CRC32c and CRC32"
 	depends on MIPS_CRC_SUPPORT
 	select CRYPTO_HASH
 	help
-	  CRC32c and CRC32 CRC algorithms implemented using mips crypto
-	  instructions, when available.
+	  CRC32c and CRC32 CRC algorithms
+
+	  Architecture: mips
 
 config CRYPTO_POLY1305_MIPS
 	tristate "Poly1305 authenticator algorithm (MIPS optimized)"
diff --git a/arch/powerpc/crypto/Kconfig b/arch/powerpc/crypto/Kconfig
index 74f535940faa..d1c34e949ce1 100644
--- a/arch/powerpc/crypto/Kconfig
+++ b/arch/powerpc/crypto/Kconfig
@@ -3,30 +3,36 @@
 menu "Accelerated Cryptographic Algorithms for CPU (powerpc)"
 
 config CRYPTO_CRC32C_VPMSUM
-	tristate "CRC32c CRC algorithm (powerpc64)"
+	tristate "CRC32c"
 	depends on PPC64 && ALTIVEC
 	select CRYPTO_HASH
 	select CRC32
 	help
-	  CRC32c algorithm implemented using vector polynomial multiply-sum
-	  (vpmsum) instructions, introduced in POWER8. Enable on POWER8
-	  and newer processors for improved performance.
+	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
+
+	  Architecture: powerpc64 using
+	  - AltiVec extensions
+
+	  Enable on POWER8 and newer processors for improved performance.
 
 config CRYPTO_CRCT10DIF_VPMSUM
-	tristate "CRC32T10DIF powerpc64 hardware acceleration"
+	tristate "CRC32T10DIF"
 	depends on PPC64 && ALTIVEC && CRC_T10DIF
 	select CRYPTO_HASH
 	help
-	  CRC10T10DIF algorithm implemented using vector polynomial
-	  multiply-sum (vpmsum) instructions, introduced in POWER8. Enable on
-	  POWER8 and newer processors for improved performance.
+	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
+
+	  Architecture: powerpc64 using
+	  - AltiVec extensions
+
+	  Enable on POWER8 and newer processors for improved performance.
 
 config CRYPTO_VPMSUM_TESTER
-	tristate "Powerpc64 vpmsum hardware acceleration tester"
+	tristate "CRC32c and CRC32T10DIF hardware acceleration tester"
 	depends on CRYPTO_CRCT10DIF_VPMSUM && CRYPTO_CRC32C_VPMSUM
 	help
-	  Stress test for CRC32c and CRC-T10DIF algorithms implemented with
-	  POWER8 vpmsum instructions.
+	  Stress test for CRC32c and CRCT10DIF algorithms implemented with
+	  powerpc64 AltiVec extensions (POWER8 vpmsum instructions).
 	  Unless you are testing these algorithms, you don't need this.
 
 config CRYPTO_MD5_PPC
diff --git a/arch/s390/crypto/Kconfig b/arch/s390/crypto/Kconfig
index ef0651d71e9d..5d12ecfaa337 100644
--- a/arch/s390/crypto/Kconfig
+++ b/arch/s390/crypto/Kconfig
@@ -3,15 +3,14 @@
 menu "Accelerated Cryptographic Algorithms for CPU (s390)"
 
 config CRYPTO_CRC32_S390
-	tristate "CRC-32 algorithms"
+	tristate "CRC32c and CRC32"
 	depends on S390
 	select CRYPTO_HASH
 	select CRC32
 	help
-	  Select this option if you want to use hardware accelerated
-	  implementations of CRC algorithms.  With this option, you
-	  can optimize the computation of CRC-32 (IEEE 802.3 Ethernet)
-	  and CRC-32C (Castagnoli).
+	  CRC32c and CRC32 CRC algorithms
+
+	  Architecture: s390
 
 	  It is available with IBM z13 or later.
 
diff --git a/arch/sparc/crypto/Kconfig b/arch/sparc/crypto/Kconfig
index eaa2afc1d50a..145debe629cd 100644
--- a/arch/sparc/crypto/Kconfig
+++ b/arch/sparc/crypto/Kconfig
@@ -13,13 +13,14 @@ config CRYPTO_DES_SPARC64
 	  optimized using SPARC64 crypto opcodes.
 
 config CRYPTO_CRC32C_SPARC64
-	tristate "CRC32c CRC algorithm (SPARC64)"
+	tristate "CRC32c"
 	depends on SPARC64
 	select CRYPTO_HASH
 	select CRC32
 	help
-	  CRC32c CRC algorithm implemented using sparc64 crypto instructions,
-	  when available.
+	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
+
+	  Architecture: sparc64
 
 config CRYPTO_MD5_SPARC64
 	tristate "MD5 digest algorithm (SPARC64)"
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 76229ccb79fd..03f9a3a35e42 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -467,39 +467,35 @@ config CRYPTO_GHASH_CLMUL_NI_INTEL
 	  GHASH, the hash function used in GCM (Galois/Counter mode).
 
 config CRYPTO_CRC32C_INTEL
-	tristate "CRC32c INTEL hardware acceleration"
+	tristate "CRC32c (SSE4.2/PCLMULQDQ)"
 	depends on X86
 	select CRYPTO_HASH
 	help
-	  In Intel processor with SSE4.2 supported, the processor will
-	  support CRC32C implementation using hardware accelerated CRC32
-	  instruction. This option will create 'crc32c-intel' module,
-	  which will enable any routine to use the CRC32 instruction to
-	  gain performance compared with software implementation.
-	  Module will be crc32c-intel.
+	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
+
+	  Architecture: x86 (32-bit and 64-bit) using:
+	  - SSE4.2 (Streaming SIMD Extensions 4.2) CRC32 instruction
+	  - PCLMULQDQ (carry-less multiplication)
 
 config CRYPTO_CRC32_PCLMUL
-	tristate "CRC32 PCLMULQDQ hardware acceleration"
+	tristate "CRC32 (PCLMULQDQ)"
 	depends on X86
 	select CRYPTO_HASH
 	select CRC32
 	help
-	  From Intel Westmere and AMD Bulldozer processor with SSE4.2
-	  and PCLMULQDQ supported, the processor will support
-	  CRC32 PCLMULQDQ implementation using hardware accelerated PCLMULQDQ
-	  instruction. This option will create 'crc32-pclmul' module,
-	  which will enable any routine to use the CRC-32-IEEE 802.3 checksum
-	  and gain better performance as compared with the table implementation.
+	  CRC32 CRC algorithm (IEEE 802.3)
+
+	  Architecture: x86 (32-bit and 64-bit) using:
+	  - PCLMULQDQ (carry-less multiplication)
 
 config CRYPTO_CRCT10DIF_PCLMUL
-	tristate "CRCT10DIF PCLMULQDQ hardware acceleration"
+	tristate "CRCT10DIF (PCLMULQDQ)"
 	depends on X86 && 64BIT && CRC_T10DIF
 	select CRYPTO_HASH
 	help
-	  For x86_64 processors with SSE4.2 and PCLMULQDQ supported,
-	  CRC T10 DIF PCLMULQDQ computation can be hardware
-	  accelerated PCLMULQDQ instruction. This option will create
-	  'crct10dif-pclmul' module, which is faster when computing the
-	  crct10dif checksum as compared with the generic table implementation.
+	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
+
+	  Architecture: x86_64 using:
+	  - PCLMULQDQ (carry-less multiplication)
 
 endmenu
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 3694b2ff44f8..a47d5d9d1180 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1093,34 +1093,47 @@ config CRYPTO_XXHASH
 menu "CRCs (cyclic redundancy checks)"
 
 config CRYPTO_CRC32C
-	tristate "CRC32c CRC algorithm"
+	tristate "CRC32c"
 	select CRYPTO_HASH
 	select CRC32
 	help
-	  Castagnoli, et al Cyclic Redundancy-Check Algorithm.  Used
-	  by iSCSI for header and data digests and by others.
-	  See Castagnoli93.  Module will be crc32c.
+	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
+
+	  A 32-bit CRC (cyclic redundancy check) with a polynomial defined
+	  by G. Castagnoli, S. Braeuer and M. Herrman in "Optimization of Cyclic
+	  Redundancy-Check Codes with 24 and 32 Parity Bits", IEEE Transactions
+	  on Communications, Vol. 41, No. 6, June 1993, selected for use with
+	  iSCSI.
+
+	  Used by btrfs, ext4, jbd2, NVMeoF/TCP, and iSCSI.
 
 config CRYPTO_CRC32
-	tristate "CRC32 CRC algorithm"
+	tristate "CRC32"
 	select CRYPTO_HASH
 	select CRC32
 	help
-	  CRC-32-IEEE 802.3 cyclic redundancy-check algorithm.
-	  Shash crypto api wrappers to crc32_le function.
+	  CRC32 CRC algorithm (IEEE 802.3)
+
+	  Used by RoCEv2 and f2fs.
 
 config CRYPTO_CRCT10DIF
-	tristate "CRCT10DIF algorithm"
+	tristate "CRCT10DIF"
 	select CRYPTO_HASH
 	help
-	  CRC T10 Data Integrity Field computation is being cast as
-	  a crypto transform.  This allows for faster crc t10 diff
-	  transforms to be used if they are available.
+	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
+
+	  CRC algorithm used by the SCSI Block Commands standard.
 
 config CRYPTO_CRC64_ROCKSOFT
-	tristate "Rocksoft Model CRC64 algorithm"
+	tristate "CRC64 based on Rocksoft Model algorithm"
 	depends on CRC64
 	select CRYPTO_HASH
+	help
+	  CRC64 CRC algorithm based on the Rocksoft Model CRC Algorithm
+
+	  Used by the NVMe implementation of T10 DIF (BLK_DEV_INTEGRITY)
+
+	  See https://zlib.net/crc_v3.txt
 
 endmenu
 
-- 
2.37.1

