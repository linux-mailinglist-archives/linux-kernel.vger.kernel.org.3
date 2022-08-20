Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AEA59AFBD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiHTSn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbiHTSmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:38 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A7A45079;
        Sat, 20 Aug 2022 11:42:28 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KADCA9015075;
        Sat, 20 Aug 2022 18:42:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=BercTk6UlUiUMmEzXhtBXvvXX46bRenTwAs6Gh17xiA=;
 b=WxoElz1wPPf9H8QlbPuVwuFpF2el7//dO8BtTTBO9hMbQyO8Gd3WlDBKZDilfGioEfAB
 zFZ2+4pUsYs/xIAzG92DJF9DZJEGoK983i9cglGYvFmJQCg9ZLvQgspKESo7WF95ElbR
 KCw7/V30wKgiPmpvuj07EBC9kF7OT05LCT7gazGtI5blJP6gWtsYpbyykrmwCOr0/9eI
 TtM4F2Av50m/uQcz3tPz5Qq6aXgtxwjVDQ09oLB6Q3hy3xnBoro5EUxrF9d+sFvCuc6I
 50zNnWSqyq74kZMnmGPy4QJe+ChwQvzVPsrF6By4fkBqwvY6VoXEnVjg1ObdllU5L2Vn KA== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wnjj429-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:24 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 001398000B7;
        Sat, 20 Aug 2022 18:42:23 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id A139D8036AB;
        Sat, 20 Aug 2022 18:42:23 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 15/17] crypto: Kconfig - simplify userspace entries
Date:   Sat, 20 Aug 2022 13:41:49 -0500
Message-Id: <20220820184151.1149247-16-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
X-Proofpoint-ORIG-GUID: 2Htqen-K7fBXlnyf3Qa7cGM287LrcN6I
X-Proofpoint-GUID: 2Htqen-K7fBXlnyf3Qa7cGM287LrcN6I
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208200079
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
 crypto/Kconfig | 65 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 24 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 5e43c63077e5..913f1da82c91 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1291,60 +1291,72 @@ config CRYPTO_KDF800108_CTR
 	select CRYPTO_SHA256
 
 endmenu
-menu "User-space interface"
+menu "Userspace interface"
 
 config CRYPTO_USER_API
 	tristate
 
 config CRYPTO_USER_API_HASH
-	tristate "User-space interface for hash algorithms"
+	tristate "Hash algorithms"
 	depends on NET
 	select CRYPTO_HASH
 	select CRYPTO_USER_API
 	help
-	  This option enables the user-spaces interface for hash
-	  algorithms.
+	  Enable the userspace interface for hash algorithms.
+
+	  See Documentation/crypto/userspace-if.rst and
+	  https://www.chronox.de/libkcapi/html/index.html
 
 config CRYPTO_USER_API_SKCIPHER
-	tristate "User-space interface for symmetric key cipher algorithms"
+	tristate "Symmetric key cipher algorithms"
 	depends on NET
 	select CRYPTO_SKCIPHER
 	select CRYPTO_USER_API
 	help
-	  This option enables the user-spaces interface for symmetric
-	  key cipher algorithms.
+	  Enable the userspace interface for symmetric key cipher algorithms.
+
+	  See Documentation/crypto/userspace-if.rst and
+	  https://www.chronox.de/libkcapi/html/index.html
 
 config CRYPTO_USER_API_RNG
-	tristate "User-space interface for random number generator algorithms"
+	tristate "RNG (random number generator) algorithms"
 	depends on NET
 	select CRYPTO_RNG
 	select CRYPTO_USER_API
 	help
-	  This option enables the user-spaces interface for random
-	  number generator algorithms.
+	  Enable the userspace interface for RNG (random number generator)
+	  algorithms.
+
+	  See Documentation/crypto/userspace-if.rst and
+	  https://www.chronox.de/libkcapi/html/index.html
 
 config CRYPTO_USER_API_RNG_CAVP
 	bool "Enable CAVP testing of DRBG"
 	depends on CRYPTO_USER_API_RNG && CRYPTO_DRBG
 	help
-	  This option enables extra API for CAVP testing via the user-space
-	  interface: resetting of DRBG entropy, and providing Additional Data.
+	  Enable extra APIs in the userspace interface for NIST CAVP
+	  (Cryptographic Algorithm Validation Program) testing:
+	  - resetting DRBG entropy
+	  - providing Additional Data
+
 	  This should only be enabled for CAVP testing. You should say
 	  no unless you know what this is.
 
 config CRYPTO_USER_API_AEAD
-	tristate "User-space interface for AEAD cipher algorithms"
+	tristate "AEAD cipher algorithms"
 	depends on NET
 	select CRYPTO_AEAD
 	select CRYPTO_SKCIPHER
 	select CRYPTO_NULL
 	select CRYPTO_USER_API
 	help
-	  This option enables the user-spaces interface for AEAD
-	  cipher algorithms.
+	  Enable the userspace interface for AEAD cipher algorithms.
+
+	  See Documentation/crypto/userspace-if.rst and
+	  https://www.chronox.de/libkcapi/html/index.html
 
 config CRYPTO_USER_API_ENABLE_OBSOLETE
-	bool "Enable obsolete cryptographic algorithms for userspace"
+	bool "Obsolete cryptographic algorithms"
 	depends on CRYPTO_USER_API
 	default y
 	help
@@ -1353,16 +1365,21 @@ config CRYPTO_USER_API_ENABLE_OBSOLETE
 	  only useful for userspace clients that still rely on them.
 
 config CRYPTO_STATS
-	bool "Crypto usage statistics for User-space"
+	bool "Crypto usage statistics"
 	depends on CRYPTO_USER
 	help
-	  This option enables the gathering of crypto stats.
-	  This will collect:
-	  - encrypt/decrypt size and numbers of symmeric operations
-	  - compress/decompress size and numbers of compress operations
-	  - size and numbers of hash operations
-	  - encrypt/decrypt/sign/verify numbers for asymmetric operations
-	  - generate/seed numbers for rng operations
+	  Enable the gathering of crypto stats.
+
+	  This collects data sizes, numbers of requests, and numbers
+	  of errors processed by:
+	  - AEAD ciphers (encrypt, decrypt)
+	  - asymmetric key ciphers (encrypt, decrypt, verify, sign)
+	  - symmetric key ciphers (encrypt, decrypt)
+	  - compression algorithms (compress, decompress)
+	  - hash algorithms (hash)
+	  - key-agreement protocol primitives (setsecret, generate
+	    public key, compute shared secret)
+	  - RNG (generate, seed)
 
 endmenu
 
-- 
2.37.1

