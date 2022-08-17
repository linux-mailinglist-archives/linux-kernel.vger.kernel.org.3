Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B4C597A24
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242390AbiHQXVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242242AbiHQXV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:21:29 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73353A50D4;
        Wed, 17 Aug 2022 16:21:25 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HMRxtI004300;
        Wed, 17 Aug 2022 23:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=USQSHsqXaJFmzvP5JAAMliYIeROYB4aRqPHT7OFRnpI=;
 b=FP8rVTTJGoB9VyVPoLe7wNeBe0WmNBT9ew1y3S5yJiglTzhNeyf1gPSiFmwUQQL4wMB9
 FNG+ZABu3/fx/0hlscTwUpVBcIWVY1Y1AY52902n1JV8a3/YIIoex2hBWNk9Bu5NnajW
 EEaY55jClq0ba8Q09/FjvL9lgVkVlb+LVChCI4Nxy0nwP2N0cA00aYKrpDAh7mh5QJ+q
 iWjtjB9q885B+t9ruzVudy5beki0GQsrgB2JmIi/jkHT0QqHsdPYsxa2GgZhTZnlaRzP
 FChFDuLjyaBJHyNi5Al503hQdk36xXqPbp2XAAlQPR2m1wD4aFiqQoZVf15mpf/ob+42 AA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3j19550b88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 23:21:20 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id A4994804CAE;
        Wed, 17 Aug 2022 23:21:20 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 603B0807B24;
        Wed, 17 Aug 2022 23:21:20 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 08/10] crypto: Kconfig - sort the arm64 entries
Date:   Wed, 17 Aug 2022 18:20:55 -0500
Message-Id: <20220817232057.73643-9-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817232057.73643-1-elliott@hpe.com>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Bn_fuX_Y8UD9qNvNaaf3t7Z3fuT1HlZB
X-Proofpoint-GUID: Bn_fuX_Y8UD9qNvNaaf3t7Z3fuT1HlZB
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_15,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=768
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208170088
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the arm64 entries so all digests, hash functions,
and ciphers are together.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/arm64/crypto/Kconfig | 54 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 5b4d4bfb0356..64aed2c31e80 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -2,13 +2,28 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (arm64)"
 
-config CRYPTO_SHA256_ARM64
-	tristate "SHA-224/SHA-256 digest algorithm for arm64"
+config CRYPTO_CRCT10DIF_ARM64_CE
+	tristate "CRCT10DIF digest algorithm using PMULL instructions"
+	depends on KERNEL_MODE_NEON && CRC_T10DIF
 	select CRYPTO_HASH
 
-config CRYPTO_SHA512_ARM64
-	tristate "SHA-384/SHA-512 digest algorithm for arm64"
+config CRYPTO_GHASH_ARM64_CE
+	tristate "GHASH/AES-GCM using ARMv8 Crypto Extensions"
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
+	select CRYPTO_GF128MUL
+	select CRYPTO_LIB_AES
+
+config CRYPTO_NHPOLY1305_NEON
+	tristate "NHPoly1305 hash function using NEON instructions (for Adiantum)"
+	depends on KERNEL_MODE_NEON
+	select CRYPTO_NHPOLY1305
+
+config CRYPTO_POLY1305_NEON
+	tristate "Poly1305 hash function using scalar or NEON instructions"
+	depends on KERNEL_MODE_NEON
+	select CRYPTO_HASH
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 
 config CRYPTO_SHA1_ARM64_CE
 	tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
@@ -16,12 +31,20 @@ menu "Accelerated Cryptographic Algorithms for CPU (arm64)"
 	select CRYPTO_HASH
 	select CRYPTO_SHA1
 
+config CRYPTO_SHA256_ARM64
+	tristate "SHA-224/SHA-256 digest algorithm for arm64"
+	select CRYPTO_HASH
+
 config CRYPTO_SHA2_ARM64_CE
 	tristate "SHA-224/SHA-256 digest algorithm (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
 	select CRYPTO_SHA256_ARM64
 
+config CRYPTO_SHA512_ARM64
+	tristate "SHA-384/SHA-512 digest algorithm for arm64"
+	select CRYPTO_HASH
+
 config CRYPTO_SHA512_ARM64_CE
 	tristate "SHA-384/SHA-512 digest algorithm (ARMv8 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
@@ -58,18 +81,6 @@ menu "Accelerated Cryptographic Algorithms for CPU (arm64)"
 	select CRYPTO_SKCIPHER
 	select CRYPTO_SM4
 
-config CRYPTO_GHASH_ARM64_CE
-	tristate "GHASH/AES-GCM using ARMv8 Crypto Extensions"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_HASH
-	select CRYPTO_GF128MUL
-	select CRYPTO_LIB_AES
-
-config CRYPTO_CRCT10DIF_ARM64_CE
-	tristate "CRCT10DIF digest algorithm using PMULL instructions"
-	depends on KERNEL_MODE_NEON && CRC_T10DIF
-	select CRYPTO_HASH
-
 config CRYPTO_AES_ARM64
 	tristate "AES core cipher using scalar instructions"
 	select CRYPTO_AES
@@ -107,17 +118,6 @@ menu "Accelerated Cryptographic Algorithms for CPU (arm64)"
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
-config CRYPTO_POLY1305_NEON
-	tristate "Poly1305 hash function using scalar or NEON instructions"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_HASH
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
-
-config CRYPTO_NHPOLY1305_NEON
-	tristate "NHPoly1305 hash function using NEON instructions (for Adiantum)"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_NHPOLY1305
-
 config CRYPTO_AES_ARM64_BS
 	tristate "AES in ECB/CBC/CTR/XTS modes using bit-sliced NEON algorithm"
 	depends on KERNEL_MODE_NEON
-- 
2.37.1

