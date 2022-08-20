Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E898759AFAF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234084AbiHTSnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiHTSma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:30 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193BD45061;
        Sat, 20 Aug 2022 11:42:28 -0700 (PDT)
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KI26Y6001472;
        Sat, 20 Aug 2022 18:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=BMHbeSF7Zax8IGWzheB5as3XwYPKFZWjZEK0cJukBIA=;
 b=atUjN7PmDwL1ROrf0f7/WqEMbvYTmspqWjeFTRlcrl2xQoHNudJa+a9cvuYqQ+hravI9
 M1yia5XMi4c2H9Qks3wSadFBDozR6IgT9YyZ5O4NMSIgvXCmEwEHyK+wqv00uQX8dbLI
 bN0aINFHFdP1O34y6u5qLtrMtLpDOaSgJA5r9P8DfJhkdtgAYBVCPbyXuotgZqmcDNzo
 8HWRr1HF/EfCmNsSmjQMFrGLvkvN1hYcxa/0eBqrN0i0lttdfeDFonNWqkOcmN2+49+b
 OUmo2+G0Y2GwBQhJFS6PgGWDJxZnNtKypVmXbrTokMvlFLPTSskx7giS2TrfJ8Ttx9+O vA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wqst5tu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:22 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id ACBD5D2E2;
        Sat, 20 Aug 2022 18:42:21 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 5C79E803510;
        Sat, 20 Aug 2022 18:42:21 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 13/17] crypto: Kconfig - simplify aead entries
Date:   Sat, 20 Aug 2022 13:41:47 -0500
Message-Id: <20220820184151.1149247-14-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PzNZaU4zuZeE8RK5QiSfXeZVo6r6JgAy
X-Proofpoint-ORIG-GUID: PzNZaU4zuZeE8RK5QiSfXeZVo6r6JgAy
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
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
 arch/x86/crypto/Kconfig |  8 +++++--
 crypto/Kconfig          | 48 +++++++++++++++++++++++++----------------
 2 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 03f9a3a35e42..93de2684b3dc 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -360,12 +360,16 @@ config CRYPTO_CHACHA20_X86_64
 	  XChaCha20, and XChaCha12 stream ciphers.
 
 config CRYPTO_AEGIS128_AESNI_SSE2
-	tristate "AEGIS-128 AEAD algorithm (x86_64 AESNI+SSE2 implementation)"
+	tristate "AEAD ciphers: AEGIS-128 (AES-NI/SSE2)"
 	depends on X86 && 64BIT
 	select CRYPTO_AEAD
 	select CRYPTO_SIMD
 	help
-	 AESNI+SSE2 implementation of the AEGIS-128 dedicated AEAD algorithm.
+	  AEGIS-128 AEAD algorithm
+
+	  Architecture: x86_64 using:
+	  - AES-NI (AES New Instructions)
+	  - SSE2 (Streaming SIMD Extensions 2)
 
 config CRYPTO_NHPOLY1305_SSE2
 	tristate "NHPoly1305 hash function (x86_64 SSE2 implementation)"
diff --git a/crypto/Kconfig b/crypto/Kconfig
index a47d5d9d1180..9dab2c72f7fb 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -779,49 +779,54 @@ config CRYPTO_NHPOLY1305
 menu "AEAD (authenticated encryption with associated data) ciphers"
 
 config CRYPTO_AEGIS128
-	tristate "AEGIS-128 AEAD algorithm"
+	tristate "AEGIS-128"
 	select CRYPTO_AEAD
 	select CRYPTO_AES  # for AES S-box tables
 	help
-	 Support for the AEGIS-128 dedicated AEAD algorithm.
+	  AEGIS-128 AEAD algorithm
 
 config CRYPTO_AEGIS128_SIMD
-	bool "Support SIMD acceleration for AEGIS-128"
+	bool "AEGIS-128 (arm NEON, arm64 NEON)"
 	depends on CRYPTO_AEGIS128 && ((ARM || ARM64) && KERNEL_MODE_NEON)
 	default y
+	help
+	  AEGIS-128 AEAD algorithm
+
+	  Architecture: arm or arm64 using:
+	  - NEON (Advanced SIMD) extension
 
 config CRYPTO_CHACHA20POLY1305
-	tristate "ChaCha20-Poly1305 AEAD support"
+	tristate "ChaCha20-Poly1305"
 	select CRYPTO_CHACHA20
 	select CRYPTO_POLY1305
 	select CRYPTO_AEAD
 	select CRYPTO_MANAGER
 	help
-	  ChaCha20-Poly1305 AEAD support, RFC7539.
-
-	  Support for the AEAD wrapper using the ChaCha20 stream cipher combined
-	  with the Poly1305 authenticator. It is defined in RFC7539 for use in
-	  IETF protocols.
+	  ChaCha20 stream cipher and Poly1305 authenticator combined
+	  mode (RFC8439)
 
 config CRYPTO_CCM
-	tristate "CCM support"
+	tristate "CCM (Counter with Cipher Block Chaining-Message Authentication Code)"
 	select CRYPTO_CTR
 	select CRYPTO_HASH
 	select CRYPTO_AEAD
 	select CRYPTO_MANAGER
 	help
-	  Support for Counter with CBC MAC. Required for IPsec.
+	  CCM (Counter with Cipher Block Chaining-Message Authentication Code)
+	  authenticated encryption mode (NIST SP800-38C)
 
 config CRYPTO_GCM
-	tristate "GCM/GMAC support"
+	tristate "GCM (Galois/Counter Mode) and GMAC (GCM Message Authentication Code)"
 	select CRYPTO_CTR
 	select CRYPTO_AEAD
 	select CRYPTO_GHASH
 	select CRYPTO_NULL
 	select CRYPTO_MANAGER
 	help
-	  Support for Galois/Counter Mode (GCM) and Galois Message
-	  Authentication Code (GMAC). Required for IPSec.
+	  GCM (Galois/Counter Mode) authenticated encryption mode and GMAC
+	  (GCM Message Authentication Code) (NIST SP800-38D)
+
+	  This is required for IPSec ESP (XFRM_ESP).
 
 config CRYPTO_SEQIV
 	tristate "Sequence Number IV Generator"
@@ -831,8 +836,12 @@ config CRYPTO_SEQIV
 	select CRYPTO_RNG_DEFAULT
 	select CRYPTO_MANAGER
 	help
+	  Sequence Number IV generator
+
 	  This IV generator generates an IV based on a sequence number by
-	  xoring it with a salt.  This algorithm is mainly useful for CTR
+	  xoring it with a salt.  This algorithm is mainly useful for CTR.
+
+	  This is required for IPsec ESP (XFRM_ESP).
 
 config CRYPTO_ECHAINIV
 	tristate "Encrypted Chain IV Generator"
@@ -841,16 +850,19 @@ config CRYPTO_ECHAINIV
 	select CRYPTO_RNG_DEFAULT
 	select CRYPTO_MANAGER
 	help
+	  Encrypted Chain IV generator
+
 	  This IV generator generates an IV based on the encryption of
 	  a sequence number xored with a salt.  This is the default
 	  algorithm for CBC.
 
 config CRYPTO_ESSIV
-	tristate "ESSIV support for block encryption"
+	tristate "Encrypted Salt-Sector IV Generator"
 	select CRYPTO_AUTHENC
 	help
-	  Encrypted salt-sector initialization vector (ESSIV) is an IV
-	  generation method that is used in some cases by fscrypt and/or
+	  Encrypted Salt-Sector IV generator
+
+	  This IV generator is used in some cases by fscrypt and/or
 	  dm-crypt. It uses the hash of the block encryption key as the
 	  symmetric key for a block encryption pass applied to the input
 	  IV, making low entropy IV sources more suitable for block
-- 
2.37.1

