Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BBA59AFA9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiHTSmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbiHTSmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:23 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3818645048;
        Sat, 20 Aug 2022 11:42:22 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KG2d54009715;
        Sat, 20 Aug 2022 18:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=w+8XgbF5bwiG5pXyesRAwPbUurWdHY8UTPLUKij1C/I=;
 b=U1zcnjSz6OsDPZjdtkWEm45Q2UTaLql/cIg9cHYIRQv/POaN3W2YFA1BuOySjMiZqIPd
 Oip/iWQy1E0dwSiyAHYUbODvyaj6iU9SH6WX/kA/Q3hB+jzMg1KquwNvmLw3/XUrhpry
 2EMLrPPtakh+X9VDvxmSW+i+YItXnM1fNedfUn7VWKJ0xV4RnP18v0TKbncI9jiWuNvQ
 stMtDw6nM6h5pf/PRzXjq8eGrmM57Eoom2RYOzV/3qYyKsbfhZfdhgr4q+E6IzjWrJsv
 UMVpglciSQWCapqMy/7D+BwFXiazDcmMdQa8T64RjVNFXthmzNb/q3giX+iz2uQLB46N gg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j32sm0mjc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:16 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 9B4F4D2E4;
        Sat, 20 Aug 2022 18:42:15 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 4BB5A8036AB;
        Sat, 20 Aug 2022 18:42:15 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 08/17] crypto: Kconfig - sort the arm64 entries
Date:   Sat, 20 Aug 2022 13:41:42 -0500
Message-Id: <20220820184151.1149247-9-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QfAgLIj8tpP7yozJkxxTxpgBiVeXVYrL
X-Proofpoint-ORIG-GUID: QfAgLIj8tpP7yozJkxxTxpgBiVeXVYrL
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=827 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Sort the arm64 entries so all like entries are together.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/arm64/crypto/Kconfig | 106 +++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 53 deletions(-)

diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 872ab7b898e0..c5d42f62d8bb 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -2,13 +2,24 @@
 
 menu "Accelerated Cryptographic Algorithms for CPU (arm64)"
 
-config CRYPTO_SHA256_ARM64
-	tristate "SHA-224/SHA-256 digest algorithm for arm64"
+config CRYPTO_GHASH_ARM64_CE
+	tristate "GHASH/AES-GCM using ARMv8 Crypto Extensions"
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
+	select CRYPTO_GF128MUL
+	select CRYPTO_LIB_AES
+	select CRYPTO_AEAD
 
-config CRYPTO_SHA512_ARM64
-	tristate "SHA-384/SHA-512 digest algorithm for arm64"
+config CRYPTO_NHPOLY1305_NEON
+	tristate "NHPoly1305 hash function using NEON instructions (for Adiantum)"
+	depends on KERNEL_MODE_NEON
+	select CRYPTO_NHPOLY1305
+
+config CRYPTO_POLY1305_NEON
+	tristate "Poly1305 hash function using scalar or NEON instructions"
+	depends on KERNEL_MODE_NEON
 	select CRYPTO_HASH
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 
 config CRYPTO_SHA1_ARM64_CE
 	tristate "SHA-1 digest algorithm (ARMv8 Crypto Extensions)"
@@ -16,12 +27,20 @@ config CRYPTO_SHA1_ARM64_CE
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
@@ -40,42 +59,11 @@ config CRYPTO_SM3_ARM64_CE
 	select CRYPTO_HASH
 	select CRYPTO_SM3
 
-config CRYPTO_SM4_ARM64_CE
-	tristate "SM4 symmetric cipher (ARMv8.2 Crypto Extensions)"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_ALGAPI
-	select CRYPTO_SM4
-
-config CRYPTO_SM4_ARM64_CE_BLK
-	tristate "SM4 in ECB/CBC/CFB/CTR modes using ARMv8 Crypto Extensions"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_SKCIPHER
-	select CRYPTO_SM4
-
-config CRYPTO_SM4_ARM64_NEON_BLK
-	tristate "SM4 in ECB/CBC/CFB/CTR modes using NEON instructions"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_SKCIPHER
-	select CRYPTO_SM4
-
-config CRYPTO_GHASH_ARM64_CE
-	tristate "GHASH/AES-GCM using ARMv8 Crypto Extensions"
-	depends on KERNEL_MODE_NEON
-	select CRYPTO_HASH
-	select CRYPTO_GF128MUL
-	select CRYPTO_LIB_AES
-	select CRYPTO_AEAD
-
 config CRYPTO_POLYVAL_ARM64_CE
 	tristate "POLYVAL using ARMv8 Crypto Extensions (for HCTR2)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_POLYVAL
 
-config CRYPTO_CRCT10DIF_ARM64_CE
-	tristate "CRCT10DIF digest algorithm using PMULL instructions"
-	depends on KERNEL_MODE_NEON && CRC_T10DIF
-	select CRYPTO_HASH
-
 config CRYPTO_AES_ARM64
 	tristate "AES core cipher using scalar instructions"
 	select CRYPTO_AES
@@ -86,14 +74,6 @@ config CRYPTO_AES_ARM64_CE
 	select CRYPTO_ALGAPI
 	select CRYPTO_LIB_AES
 
-config CRYPTO_AES_ARM64_CE_CCM
-	tristate "AES in CCM mode using ARMv8 Crypto Extensions"
-	depends on ARM64 && KERNEL_MODE_NEON
-	select CRYPTO_ALGAPI
-	select CRYPTO_AES_ARM64_CE
-	select CRYPTO_AEAD
-	select CRYPTO_LIB_AES
-
 config CRYPTO_AES_ARM64_CE_BLK
 	tristate "AES in ECB/CBC/CTR/XTS/XCTR modes using ARMv8 Crypto Extensions"
 	depends on KERNEL_MODE_NEON
@@ -113,23 +93,43 @@ config CRYPTO_CHACHA20_NEON
 	select CRYPTO_LIB_CHACHA_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
-config CRYPTO_POLY1305_NEON
-	tristate "Poly1305 hash function using scalar or NEON instructions"
+config CRYPTO_AES_ARM64_BS
+	tristate "AES in ECB/CBC/CTR/XTS modes using bit-sliced NEON algorithm"
 	depends on KERNEL_MODE_NEON
-	select CRYPTO_HASH
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	select CRYPTO_SKCIPHER
+	select CRYPTO_AES_ARM64_NEON_BLK
+	select CRYPTO_LIB_AES
 
-config CRYPTO_NHPOLY1305_NEON
-	tristate "NHPoly1305 hash function using NEON instructions (for Adiantum)"
+config CRYPTO_SM4_ARM64_CE
+	tristate "SM4 symmetric cipher (ARMv8.2 Crypto Extensions)"
 	depends on KERNEL_MODE_NEON
-	select CRYPTO_NHPOLY1305
+	select CRYPTO_ALGAPI
+	select CRYPTO_SM4
 
-config CRYPTO_AES_ARM64_BS
-	tristate "AES in ECB/CBC/CTR/XTS modes using bit-sliced NEON algorithm"
+config CRYPTO_SM4_ARM64_CE_BLK
+	tristate "SM4 in ECB/CBC/CFB/CTR modes using ARMv8 Crypto Extensions"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_SKCIPHER
-	select CRYPTO_AES_ARM64_NEON_BLK
+	select CRYPTO_SM4
+
+config CRYPTO_SM4_ARM64_NEON_BLK
+	tristate "SM4 in ECB/CBC/CFB/CTR modes using NEON instructions"
+	depends on KERNEL_MODE_NEON
+	select CRYPTO_SKCIPHER
+	select CRYPTO_SM4
+
+config CRYPTO_AES_ARM64_CE_CCM
+	tristate "AES in CCM mode using ARMv8 Crypto Extensions"
+	depends on ARM64 && KERNEL_MODE_NEON
+	select CRYPTO_ALGAPI
+	select CRYPTO_AES_ARM64_CE
+	select CRYPTO_AEAD
 	select CRYPTO_LIB_AES
 
+config CRYPTO_CRCT10DIF_ARM64_CE
+	tristate "CRCT10DIF digest algorithm using PMULL instructions"
+	depends on KERNEL_MODE_NEON && CRC_T10DIF
+	select CRYPTO_HASH
+
 endmenu
 
-- 
2.37.1

