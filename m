Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D571859AFA3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbiHTSmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiHTSmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:22 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F43144575;
        Sat, 20 Aug 2022 11:42:22 -0700 (PDT)
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KGMVjw012389;
        Sat, 20 Aug 2022 18:42:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=gcu/cKmPg3QCSEXnR25RzeJ1N087Cn4IRBYUKffotfc=;
 b=FZ+lXs2rBP518DpK5rUK+J69dXLtDFRTWYxIgwfmkYcRNJA8LoMAgwaCm1KorwyeWfcp
 IcV8Csw2RqRFyJSS+hBBxRGnwhTIuzuNCWYkOg8wBGQ4tKEMI7QhRlVb6cBaPfsld8tP
 ubDwlZhxZflWriUv0a2s/D0HKY/PZWjI94wyqxShXkm17gG3N2fpQ4GpVa18qhBVZEKm
 1M4FIFD/GRKwG7DhkYeg0BoHMNLlJVd2dnRZ9E38KTQUZJYhloOREVNtUOkMSoF5aXR1
 WyhA0xy4Kbn5k6GxMnj4SbIUkqI2u0Nddepi6G12aK8w5RlpcP5BmIa6S9pqT7ME/Loa 1A== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wn9j4cs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:18 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 290EFD2E7;
        Sat, 20 Aug 2022 18:42:17 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id CAA37803A87;
        Sat, 20 Aug 2022 18:42:16 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 09/17] crypto: Kconfig - sort the arm entries
Date:   Sat, 20 Aug 2022 13:41:43 -0500
Message-Id: <20220820184151.1149247-10-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: AruC-ZTCp8FjHlA61kpqskrGOTkn3rtD
X-Proofpoint-ORIG-GUID: AruC-ZTCp8FjHlA61kpqskrGOTkn3rtD
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 adultscore=0 mlxlogscore=673 phishscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208200080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the arm entries so all like entries are together.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/arm/crypto/Kconfig | 110 ++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index b4cb519a0609..d73d19971b87 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -2,6 +2,53 @@
 
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
+config CRYPTO_BLAKE2S_ARM
+	bool "BLAKE2s digest algorithm (ARM)"
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
@@ -55,25 +102,6 @@ config CRYPTO_SHA512_ARM
 	  SHA-512 secure hash standard (DFIPS 180-2) implemented
 	  using optimized ARM assembler and NEON, when available.
 
-config CRYPTO_BLAKE2S_ARM
-	bool "BLAKE2s digest algorithm (ARM)"
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
@@ -118,50 +146,22 @@ config CRYPTO_AES_ARM_CE
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
+config CRYPTO_CRC32_ARM_CE
+	tristate "CRC32(C) digest algorithm using CRC and/or PMULL instructions"
 	depends on KERNEL_MODE_NEON
-	select CRYPTO_NHPOLY1305
+	depends on CRC32
+	select CRYPTO_HASH
 
-config CRYPTO_CURVE25519_NEON
-	tristate "NEON accelerated Curve25519 scalar multiplication library"
+config CRYPTO_CRCT10DIF_ARM_CE
+	tristate "CRCT10DIF digest algorithm using PMULL instructions"
 	depends on KERNEL_MODE_NEON
-	select CRYPTO_LIB_CURVE25519_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	depends on CRC_T10DIF
+	select CRYPTO_HASH
 
 endmenu
 
-- 
2.37.1

