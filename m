Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3F0597A31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbiHQXVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242271AbiHQXV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:21:29 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75698A50EA;
        Wed, 17 Aug 2022 16:21:26 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HMTxNC027452;
        Wed, 17 Aug 2022 23:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=IAYfgmzUBcLrPOIO3U1xaWZbXdIA3IAcTRfSBc8BNZY=;
 b=atk9IFQkg/ydSOfu7Jg2G1ZNUIeZVUP8+lm8AshF/XGtZCZVh/wpw4lDB83++eMKPhQ4
 ebauC3sINFy6N3PH2Ej+vd+0YUidHNAOdXRVrWi6Z9KB2Ouod/e4VQFO6aUVOHGzGXWD
 kX6SuNqymNrYI734IworDip7LVl6VW6CIcDoml82LatdfoD8d2ELe5P9Jngy4haSoxWN
 6lj2E64M0e3zABzNg2l0xc5RK3UYO2F0UmIhYHTfKjtHsrn9Q96wWLSYB9f4Ch9aILg0
 m4XMYAyIBawO4Vht5pXlgpdd8l22jLB9fIRCXZvwkac/wdwIe9S7x/aG4fLaIP2aKhVS jA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j195ygad8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 23:21:22 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id AB6DB804C87;
        Wed, 17 Aug 2022 23:21:21 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 609378075CC;
        Wed, 17 Aug 2022 23:21:21 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 09/10] crypto: Kconfig - sort the arm entries
Date:   Wed, 17 Aug 2022 18:20:56 -0500
Message-Id: <20220817232057.73643-10-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817232057.73643-1-elliott@hpe.com>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dFbSBlHd4XibbJdKPp2ZU-seI39kyfkm
X-Proofpoint-GUID: dFbSBlHd4XibbJdKPp2ZU-seI39kyfkm
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_15,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=702 malwarescore=0 phishscore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208170088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the arm entries, keeping the hash functions, digests, and ciphers
together.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/arm/crypto/Kconfig | 118 ++++++++++++++++++++--------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index f6edc8f19d17..ee2d7d59dd8e 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -2,6 +2,65 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (arm)"
 
+config CRYPTO_CURVE25519_NEON
+	tristate "NEON accelerated Curve25519 scalar multiplication library"
+	depends on KERNEL_MODE_NEON
+	select CRYPTO_LIB_CURVE25519_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+
+config CRYPTO_GHASH_ARM_CE
+	tristate "PMULL-accelerated GHASH using NEON/ARMv8 Crypto Extensions"
+	depends on KERNEL_MODE_NEON
+	select CRYPTO_HASH
+	select CRYPTO_CRYPTD
+	select CRYPTO_GF128MUL
+	help
+	  Use an implementation of GHASH (used by the GCM AEAD chaining mode)
+	  that uses the 64x64 to 128 bit polynomial multiplication (vmull.p64)
+	  that is part of the ARMv8 Crypto Extensions, or a slower variant that
+	  uses the vmull.p8 instruction that is part of the basic NEON ISA.
+
+config CRYPTO_NHPOLY1305_NEON
+	tristate "NEON accelerated NHPoly1305 hash function (for Adiantum)"
+	depends on KERNEL_MODE_NEON
+	select CRYPTO_NHPOLY1305
+
+config CRYPTO_POLY1305_ARM
+	tristate "Accelerated scalar and SIMD Poly1305 hash implementations"
+	select CRYPTO_HASH
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+
+config CRYPTO_CRC32_ARM_CE
+	tristate "CRC32(C) digest algorithm using CRC and/or PMULL instructions"
+	depends on KERNEL_MODE_NEON
+	depends on CRC32
+	select CRYPTO_HASH
+
+config CRYPTO_CRCT10DIF_ARM_CE
+	tristate "CRCT10DIF digest algorithm using PMULL instructions"
+	depends on KERNEL_MODE_NEON
+	depends on CRC_T10DIF
+	select CRYPTO_HASH
+
+config CRYPTO_BLAKE2S_ARM
+	tristate "BLAKE2s digest algorithm (ARM)"
+	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
+	help
+	  BLAKE2s digest algorithm optimized with ARM scalar instructions.  This
+	  is faster than the generic implementations of BLAKE2s and BLAKE2b, but
+	  slower than the NEON implementation of BLAKE2b.  (There is no NEON
+	  implementation of BLAKE2s, since NEON doesn't really help with it.)
+
+config CRYPTO_BLAKE2B_NEON
+	tristate "BLAKE2b digest algorithm (ARM NEON)"
+	depends on KERNEL_MODE_NEON
+	select CRYPTO_BLAKE2B
+	help
+	  BLAKE2b digest algorithm optimized with ARM NEON instructions.
+	  On ARM processors that have NEON support but not the ARMv8
+	  Crypto Extensions, typically this BLAKE2b implementation is
+	  much faster than SHA-2 and slightly faster than SHA-1.
+
 config CRYPTO_SHA1_ARM
 	tristate "SHA1 digest algorithm (ARM-asm)"
 	select CRYPTO_SHA1
@@ -55,25 +114,6 @@ menu "Accelerated Cryptographic Algorithms for CPU (arm)"
 	  SHA-512 secure hash standard (DFIPS 180-2) implemented
 	  using optimized ARM assembler and NEON, when available.
 
-config CRYPTO_BLAKE2S_ARM
-	tristate "BLAKE2s digest algorithm (ARM)"
-	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
-	help
-	  BLAKE2s digest algorithm optimized with ARM scalar instructions.  This
-	  is faster than the generic implementations of BLAKE2s and BLAKE2b, but
-	  slower than the NEON implementation of BLAKE2b.  (There is no NEON
-	  implementation of BLAKE2s, since NEON doesn't really help with it.)
-
-config CRYPTO_BLAKE2B_NEON
-	tristate "BLAKE2b digest algorithm (ARM NEON)"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_BLAKE2B
-	help
-	  BLAKE2b digest algorithm optimized with ARM NEON instructions.
-	  On ARM processors that have NEON support but not the ARMv8
-	  Crypto Extensions, typically this BLAKE2b implementation is
-	  much faster than SHA-2 and slightly faster than SHA-1.
-
 config CRYPTO_AES_ARM
 	tristate "Scalar AES cipher for ARM"
 	select CRYPTO_ALGAPI
@@ -118,49 +158,9 @@ menu "Accelerated Cryptographic Algorithms for CPU (arm)"
 	  Use an implementation of AES in CBC, CTR and XTS modes that uses
 	  ARMv8 Crypto Extensions
 
-config CRYPTO_GHASH_ARM_CE
-	tristate "PMULL-accelerated GHASH using NEON/ARMv8 Crypto Extensions"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_HASH
-	select CRYPTO_CRYPTD
-	select CRYPTO_GF128MUL
-	help
-	  Use an implementation of GHASH (used by the GCM AEAD chaining mode)
-	  that uses the 64x64 to 128 bit polynomial multiplication (vmull.p64)
-	  that is part of the ARMv8 Crypto Extensions, or a slower variant that
-	  uses the vmull.p8 instruction that is part of the basic NEON ISA.
-
-config CRYPTO_CRCT10DIF_ARM_CE
-	tristate "CRCT10DIF digest algorithm using PMULL instructions"
-	depends on KERNEL_MODE_NEON
-	depends on CRC_T10DIF
-	select CRYPTO_HASH
-
-config CRYPTO_CRC32_ARM_CE
-	tristate "CRC32(C) digest algorithm using CRC and/or PMULL instructions"
-	depends on KERNEL_MODE_NEON
-	depends on CRC32
-	select CRYPTO_HASH
-
 config CRYPTO_CHACHA20_NEON
 	tristate "NEON and scalar accelerated ChaCha stream cipher algorithms"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
-config CRYPTO_POLY1305_ARM
-	tristate "Accelerated scalar and SIMD Poly1305 hash implementations"
-	select CRYPTO_HASH
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-
-config CRYPTO_NHPOLY1305_NEON
-	tristate "NEON accelerated NHPoly1305 hash function (for Adiantum)"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_NHPOLY1305
-
-config CRYPTO_CURVE25519_NEON
-	tristate "NEON accelerated Curve25519 scalar multiplication library"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_LIB_CURVE25519_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
-
 endmenu
-- 
2.37.1

