Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26806597A21
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242472AbiHQXWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242312AbiHQXVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:21:35 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3739A59BE;
        Wed, 17 Aug 2022 16:21:29 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HNKIMb020598;
        Wed, 17 Aug 2022 23:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=l0okhPqh6jj7+W69lSh6MeNqDZDXZJin5lQaSUzN0AA=;
 b=mNoLAUznm9S+pPAPF+v4OCEFt1k3eueV5ghHAKMZ+8DBlLBw8dRoDmMMwRUOYELeORei
 dVh7HvFLXm0OEy6Jlcknce+IYG7mC4/rJEg3auakFFV530XbUGbjBl5ao+8nS8ZHCuOr
 edgVDV8OBDtCCRAzJACOxhw2niCBCQgzVFj5TAkFQKbYbsc0I+I5quxi6tDOkzuRMBiP
 b6v4XbEBXpeNAfiDcOT7OXW+Tg2e4EuJ5jtvFdmZ8YROAia1pOhlF1Tpn/tA/+hEUj44
 02QpwkdkaXeu2695XHono03hTjtvatXW/woAngFwlauUnFZBW4nd989R7JuMCn3Y5wAR TQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j19wer08y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 23:21:25 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CE82C804CA9;
        Wed, 17 Aug 2022 23:21:24 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 87D1F808E9C;
        Wed, 17 Aug 2022 23:21:24 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 10/10] crypto: Kconfig - add submenus
Date:   Wed, 17 Aug 2022 18:20:57 -0500
Message-Id: <20220817232057.73643-11-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817232057.73643-1-elliott@hpe.com>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
X-Proofpoint-GUID: ApJzdwhHTUt2cKV82RLPUZtu-ooHgKzU
X-Proofpoint-ORIG-GUID: ApJzdwhHTUt2cKV82RLPUZtu-ooHgKzU
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_15,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=917 clxscore=1015 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Move a few of the entries so they fall into the correct submenu
and are better sorted.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/Kconfig | 131 +++++++++++++++++++++++++++++--------------------
 1 file changed, 77 insertions(+), 54 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index b61626bf8ee2..3d59f843eb4c 100644
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
@@ -295,7 +297,9 @@ menuconfig CRYPTO
 	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
 
-comment "Authenticated Encryption with Associated Data"
+endmenu
+
+menu "AEAD (Authenticated Encryption with Associated Data) ciphers"
 
 config CRYPTO_CCM
 	tristate "CCM support"
@@ -364,7 +368,39 @@ menuconfig CRYPTO
 	  a sequence number xored with a salt.  This is the default
 	  algorithm for CBC.
 
-comment "Block modes"
+	  This is required for IPsec ESP (XFRM_ESP).
+
+config CRYPTO_ESSIV
+	tristate "ESSIV support for block encryption"
+	select CRYPTO_AUTHENC
+	help
+	  Encrypted salt-sector initialization vector (ESSIV) is an IV
+	  generation method that is used in some cases by fscrypt and/or
+	  dm-crypt. It uses the hash of the block encryption key as the
+	  symmetric key for a block encryption pass applied to the input
+	  IV, making low entropy IV sources more suitable for block
+	  encryption.
+
+	  This driver implements a crypto API template that can be
+	  instantiated either as an skcipher or as an AEAD (depending on the
+	  type of the first template argument), and which defers encryption
+	  and decryption requests to the encapsulated cipher after applying
+	  ESSIV to the input IV. Note that in the AEAD case, it is assumed
+	  that the keys are presented in the same format used by the authenc
+	  template, and that the IV appears at the end of the authenticated
+	  associated data (AAD) region (which is how dm-crypt uses it.)
+
+	  Note that the use of ESSIV is not recommended for new deployments,
+	  and so this only needs to be enabled when interoperability with
+	  existing encrypted volumes of filesystems is required, or when
+	  building for a particular system that requires it (e.g., when
+	  the SoC in question has accelerated CBC but not XTS, making CBC
+	  combined with ESSIV the only feasible mode for h/w accelerated
+	  block encryption)
+
+endmenu
+
+menu "Block modes"
 
 config CRYPTO_CBC
 	tristate "CBC support"
@@ -494,35 +530,9 @@ menuconfig CRYPTO
 
 	  If unsure, say N.
 
-config CRYPTO_ESSIV
-	tristate "ESSIV support for block encryption"
-	select CRYPTO_AUTHENC
-	help
-	  Encrypted salt-sector initialization vector (ESSIV) is an IV
-	  generation method that is used in some cases by fscrypt and/or
-	  dm-crypt. It uses the hash of the block encryption key as the
-	  symmetric key for a block encryption pass applied to the input
-	  IV, making low entropy IV sources more suitable for block
-	  encryption.
+endmenu
 
-	  This driver implements a crypto API template that can be
-	  instantiated either as an skcipher or as an AEAD (depending on the
-	  type of the first template argument), and which defers encryption
-	  and decryption requests to the encapsulated cipher after applying
-	  ESSIV to the input IV. Note that in the AEAD case, it is assumed
-	  that the keys are presented in the same format used by the authenc
-	  template, and that the IV appears at the end of the authenticated
-	  associated data (AAD) region (which is how dm-crypt uses it.)
-
-	  Note that the use of ESSIV is not recommended for new deployments,
-	  and so this only needs to be enabled when interoperability with
-	  existing encrypted volumes of filesystems is required, or when
-	  building for a particular system that requires it (e.g., when
-	  the SoC in question has accelerated CBC but not XTS, making CBC
-	  combined with ESSIV the only feasible mode for h/w accelerated
-	  block encryption)
-
-comment "Hash modes"
+menu "Hash modes"
 
 config CRYPTO_CMAC
 	tristate "CMAC support"
@@ -564,7 +574,9 @@ menuconfig CRYPTO
 	  See also:
 	  <https://fastcrypto.org/vmac>
 
-comment "Digest"
+endmenu
+
+menu "Digests"
 
 config CRYPTO_CRC32C
 	tristate "CRC32c CRC algorithm"
@@ -583,13 +595,18 @@ menuconfig CRYPTO
 	  CRC-32-IEEE 802.3 cyclic redundancy-check algorithm.
 	  Shash crypto api wrappers to crc32_le function.
 
-config CRYPTO_XXHASH
-	tristate "xxHash hash algorithm"
+config CRYPTO_CRCT10DIF
+	tristate "CRCT10DIF algorithm"
 	select CRYPTO_HASH
-	select XXHASH
 	help
-	  xxHash non-cryptographic hash algorithm. Extremely fast, working at
-	  speeds close to RAM limits.
+	  CRC T10 Data Integrity Field computation is being cast as
+	  a crypto transform.  This allows for faster crc t10 diff
+	  transforms to be used if they are available.
+
+config CRYPTO_CRC64_ROCKSOFT
+	tristate "Rocksoft Model CRC64 algorithm"
+	depends on CRC64
+	select CRYPTO_HASH
 
 config CRYPTO_BLAKE2B
 	tristate "BLAKE2b digest algorithm"
@@ -626,19 +643,6 @@ menuconfig CRYPTO
 
 	  See https://blake2.net for further information.
 
-config CRYPTO_CRCT10DIF
-	tristate "CRCT10DIF algorithm"
-	select CRYPTO_HASH
-	help
-	  CRC T10 Data Integrity Field computation is being cast as
-	  a crypto transform.  This allows for faster crc t10 diff
-	  transforms to be used if they are available.
-
-config CRYPTO_CRC64_ROCKSOFT
-	tristate "Rocksoft Model CRC64 algorithm"
-	depends on CRC64
-	select CRYPTO_HASH
-
 config CRYPTO_GHASH
 	tristate "GHASH hash function"
 	select CRYPTO_GF128MUL
@@ -776,7 +780,17 @@ menuconfig CRYPTO
 	  See also:
 	  <http://www.larc.usp.br/~pbarreto/WhirlpoolPage.html>
 
-comment "Ciphers"
+config CRYPTO_XXHASH
+	tristate "xxHash hash algorithm"
+	select CRYPTO_HASH
+	select XXHASH
+	help
+	  xxHash non-cryptographic hash algorithm. Extremely fast, working at
+	  speeds close to RAM limits.
+
+endmenu
+
+menu "Ciphers"
 
 config CRYPTO_AES
 	tristate "AES cipher algorithms"
@@ -1050,7 +1064,9 @@ menuconfig CRYPTO
 	  Common parts of the Twofish cipher algorithm shared by the
 	  generic c and the assembler implementations.
 
-comment "Compression"
+endmenu
+
+menu "Compression"
 
 config CRYPTO_DEFLATE
 	tristate "Deflate compression algorithm"
@@ -1109,7 +1125,9 @@ menuconfig CRYPTO
 	help
 	  This is the zstd algorithm.
 
-comment "Random Number Generation"
+endmenu
+
+menu "Random Number Generation"
 
 config CRYPTO_ANSI_CPRNG
 	tristate "Pseudo Random Number Generation for Cryptographic modules"
@@ -1166,6 +1184,8 @@ menuconfig CRYPTO_DRBG_MENU
 	  random numbers. This Jitterentropy RNG registers with
 	  the kernel crypto API and can be used by any caller.
 
+endmenu
+
 config CRYPTO_KDF800108_CTR
 	tristate
 	select CRYPTO_HMAC
@@ -1174,6 +1194,7 @@ menuconfig CRYPTO_DRBG_MENU
 config CRYPTO_USER_API
 	tristate
 
+menu "User-space interface"
 config CRYPTO_USER_API_HASH
 	tristate "User-space interface for hash algorithms"
 	depends on NET
@@ -1242,6 +1263,8 @@ menuconfig CRYPTO_DRBG_MENU
 	  - encrypt/decrypt/sign/verify numbers for asymmetric operations
 	  - generate/seed numbers for rng operations
 
+endmenu
+
 config CRYPTO_HASH_INFO
 	bool
 
-- 
2.37.1

