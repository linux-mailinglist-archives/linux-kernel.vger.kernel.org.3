Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A639593E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345810AbiHOUkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345016AbiHOUfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:35:04 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E337AABD61;
        Mon, 15 Aug 2022 12:06:23 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIDjeH009888;
        Mon, 15 Aug 2022 19:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=OvGNgjyXdRVoprmq/MPuupJ6TYjVRr2YqHsIXBFGU8o=;
 b=nYYy1CKfQpwbMCsrCCSmy5Hk4onohxaszlZ1hQ68uwP1oldmm8+lImAb3yjvfyohFdNu
 bO/KrYi8zIu4NRmC0s+87xkPwBT5DzySp3i96HG47orFbE+9OvUzOOa/zHst9WCwPhQT
 T90k3Dyve3nPT8mXebx1gPVE/yFnSOVfAuEUakaDvlNo/Fpcol/NO+SW23KaS4foYmq9
 2EhQhgRkWTKjSVOseWwfh/AnPi+h8UbG9KlsdVBtdzN/i4NOlDhKeqh+ZU1T+iGEbHvS
 e7OUWg4UkA93TiF+FyEjKMby50YqQDHoWMjhuc2jMTHjZ9DU/JzmFLEMT/dJOpvUGcuE Zg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hyu7r8bpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:06:19 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 218A5D2CF;
        Mon, 15 Aug 2022 19:06:18 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id CCA3B802BAD;
        Mon, 15 Aug 2022 19:06:17 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 1/8] crypto: Kconfig - add submenus
Date:   Mon, 15 Aug 2022 14:06:01 -0500
Message-Id: <20220815190608.47182-2-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815190608.47182-1-elliott@hpe.com>
References: <20220815190608.47182-1-elliott@hpe.com>
X-Proofpoint-GUID: MTwPZk1esdoIQHNY7bUQETSbs3wsir6g
X-Proofpoint-ORIG-GUID: MTwPZk1esdoIQHNY7bUQETSbs3wsir6g
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 suspectscore=0 mlxlogscore=428 spamscore=0 mlxscore=0
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert each comment section into a submenu:
Cryptographic API
    Crypto core or helper
    Public-key cryptography
    AEAD (Authenticated Encryption with Associated Data) ciphers
    Block modes
    Hash modes
    Digests
    Ciphers
    Compression
    Random Number Generation
    User-space interface

That helps find entries (e.g., searching for a name like SHA512 doesn't
just report the location is Main menu -> Cryptography API, leaving you
to wade through 153 entries; it points you to the Digests page).

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/Kconfig | 42 ++++++++++++++++++++++++++++++++----------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 7b81685b5655..c2db970bc998 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -21,7 +21,7 @@ menuconfig CRYPTO
 
 if CRYPTO
 
-comment "Crypto core or helper"
+menu "Crypto core or helper"
 
 config CRYPTO_FIPS
 	bool "FIPS 200 compliance"
@@ -214,7 +214,9 @@ menuconfig CRYPTO
 config CRYPTO_ENGINE
 	tristate
 
-comment "Public-key cryptography"
+endmenu
+
+menu "Public-key cryptography"
 
 config CRYPTO_RSA
 	tristate "RSA algorithm"
@@ -301,7 +303,9 @@ menuconfig CRYPTO
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
 
-comment "Authenticated Encryption with Associated Data"
+endmenu
+
+menu "AEAD (Authenticated Encryption with Associated Data) ciphers"
 
 config CRYPTO_CCM
 	tristate "CCM support"
@@ -378,7 +382,11 @@ menuconfig CRYPTO
 	  a sequence number xored with a salt.  This is the default
 	  algorithm for CBC.
 
-comment "Block modes"
+	  This is required for IPsec ESP (XFRM_ESP).
+
+endmenu
+
+menu "Block modes"
 
 config CRYPTO_CBC
 	tristate "CBC support"
@@ -552,7 +560,9 @@ menuconfig CRYPTO
 	  combined with ESSIV the only feasible mode for h/w accelerated
 	  block encryption)
 
-comment "Hash modes"
+endmenu
+
+menu "Hash modes"
 
 config CRYPTO_CMAC
 	tristate "CMAC support"
@@ -594,7 +604,9 @@ menuconfig CRYPTO
 	  See also:
 	  <https://fastcrypto.org/vmac>
 
-comment "Digest"
+endmenu
+
+menu "Digests"
 
 config CRYPTO_CRC32C
 	tristate "CRC32c CRC algorithm"
@@ -627,7 +639,6 @@ menuconfig CRYPTO
 	  (vpmsum) instructions, introduced in POWER8. Enable on POWER8
 	  and newer processors for improved performance.
 
-
 config CRYPTO_CRC32C_SPARC64
 	tristate "CRC32c CRC algorithm (SPARC64)"
 	depends on SPARC64
@@ -1142,7 +1153,9 @@ menuconfig CRYPTO
 
 	  It is available as of z196.
 
-comment "Ciphers"
+endmenu
+
+menu "Ciphers"
 
 config CRYPTO_AES
 	tristate "AES cipher algorithms"
@@ -1877,7 +1890,9 @@ menuconfig CRYPTO
 	  See also:
 	  <https://www.schneier.com/twofish.html>
 
-comment "Compression"
+endmenu
+
+menu "Compression"
 
 config CRYPTO_DEFLATE
 	tristate "Deflate compression algorithm"
@@ -1936,7 +1951,9 @@ menuconfig CRYPTO
 	help
 	  This is the zstd algorithm.
 
-comment "Random Number Generation"
+endmenu
+
+menu "Random Number Generation"
 
 config CRYPTO_ANSI_CPRNG
 	tristate "Pseudo Random Number Generation for Cryptographic modules"
@@ -1993,6 +2010,8 @@ menuconfig CRYPTO_DRBG_MENU
 	  random numbers. This Jitterentropy RNG registers with
 	  the kernel crypto API and can be used by any caller.
 
+endmenu
+
 config CRYPTO_KDF800108_CTR
 	tristate
 	select CRYPTO_HMAC
@@ -2001,6 +2020,7 @@ menuconfig CRYPTO_DRBG_MENU
 config CRYPTO_USER_API
 	tristate
 
+menu "User-space interface"
 config CRYPTO_USER_API_HASH
 	tristate "User-space interface for hash algorithms"
 	depends on NET
@@ -2069,6 +2089,8 @@ menuconfig CRYPTO_DRBG_MENU
 	  - encrypt/decrypt/sign/verify numbers for asymmetric operations
 	  - generate/seed numbers for rng operations
 
+endmenu
+
 config CRYPTO_HASH_INFO
 	bool
 
-- 
2.37.1

