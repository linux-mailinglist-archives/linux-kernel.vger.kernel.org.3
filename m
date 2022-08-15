Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD0E593E52
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbiHOUkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346069AbiHOUfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:35:12 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89849ABD6A;
        Mon, 15 Aug 2022 12:06:24 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIEgS6004375;
        Mon, 15 Aug 2022 19:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=7UZRl7S6CD59FxX0p50QXXowmOOF0KD87WiCrV0FFvc=;
 b=WoTZfNGQ6W5T+ONutzqQsBHZsRydbTwo0MjYrWxKHQs63hahiBhSZMKKZMTdFFhfJL2s
 3/cj0T6wodN3xloXdTTK+HI62xipD0IXJCEy00CZBOAfSZ3eLuk6GQgLy2Nw31LjqVVL
 LMqQdvXBZsDkjbOpVWP0fLrrvtW7Ixs3MBFqV37j4vXRwvrBb/V16zI8izJZ/T1JqADM
 WK0nNJRnUqJMj+RLJYA70GI538ZvQjWlt9TbjkopOLsIURXHJ3BgqUPM7O2lnuUY95XD
 A9lEu/KFAhU8jC/HOpWwOA2oQ2oe9Yy128d5J8BGWG9pTHsjNZBlnfufUG6paXERQ7qD 2A== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hyu8d0bst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:06:21 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 709AD804CB5;
        Mon, 15 Aug 2022 19:06:20 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 25F73804CF8;
        Mon, 15 Aug 2022 19:06:20 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 3/8] crypto: Kconfig - simplify user-space interface entries
Date:   Mon, 15 Aug 2022 14:06:03 -0500
Message-Id: <20220815190608.47182-4-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815190608.47182-1-elliott@hpe.com>
References: <20220815190608.47182-1-elliott@hpe.com>
X-Proofpoint-ORIG-GUID: qzScPmMadnJgI9WTV04XrqEjOjTzo2TL
X-Proofpoint-GUID: qzScPmMadnJgI9WTV04XrqEjOjTzo2TL
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150071
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten menu titles and help text and make them consistent:
* acronym
* name
* architecture and architecture features in parenthesis
* no suffixes like "<something> algorithm", "support", or
"hardware acceleration", or "optimized"

Clarify architecture restrictions (e.g., include x86 in the names of
all the x86-optimized modules.

Simplify descriptions, update references, and ensure that https
references are still valid.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/Kconfig | 63 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index a7679e8cf842..045ef2a92449 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -2032,55 +2032,67 @@ menuconfig CRYPTO_DRBG_MENU
 	tristate
 
 menu "User-space interface"
+comment "Enable the user-space interface for ..."
 config CRYPTO_USER_API_HASH
-	tristate "User-space interface for hash algorithms"
+	tristate "Hash algorithms"
 	depends on NET
 	select CRYPTO_HASH
 	select CRYPTO_USER_API
 	help
-	  This option enables the user-spaces interface for hash
-	  algorithms.
+	  Enable the user-space interface for hash algorithms.
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
+	  Enable the user-space interface for symmetric key cipher algorithms.
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
+	  Enable the user-space interface for RNG (random number generator)
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
+	  Enable extra APIs in the user-space interface for NIST CAVP
+	  (Cryptographic Algorithm Validation Program) testing:
+	  - resetting DRBG entropy
+	  - providing Additional Data
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
+	  Enable the user-space interface for AEAD cipher algorithms.
+
+	  See Documentation/crypto/userspace-if.rst and
+	  https://www.chronox.de/libkcapi/html/index.html
 
 config CRYPTO_USER_API_ENABLE_OBSOLETE
-	bool "Enable obsolete cryptographic algorithms for userspace"
+	bool "Obsolete cryptographic algorithms"
 	depends on CRYPTO_USER_API
 	default y
 	help
@@ -2089,16 +2101,21 @@ menu "User-space interface"
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

