Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D775859AFB5
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbiHTSnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbiHTSmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:50 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEAC45991;
        Sat, 20 Aug 2022 11:42:33 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KI2I8t005057;
        Sat, 20 Aug 2022 18:42:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=9ioaJj/5Z6IG3s9q1ND45b62ISD+TqCAFCYtxOrOUR0=;
 b=LrNHRBqB5OiyKz+b8QYvibz+JkU8ZA5sx1rjPuQMPhQsx08vL3lTehOWF91aqaIXJ5ur
 hJb2XUv3ZMGljLSCwtziRut8A5maHFAHIPVEjJoYE7KgTGORDTBUWRIngWDnRiG9mS8+
 Mtyun82j0O0EJs36EH3rrDyyGQ01QyG6QIt3Ot93Z5I4SGBjcQZIbHwvq0z3cjxhLst5
 lozDNLSz+3bF5zrm+QFzhcczIb4HO0XP9+LtJTL5XtpASH5YSYN4cBVhC3LMFHZymjQ/
 9RXYXlo83rdTiAU8fD8pwnVw2KRIpxGwgL9yQOJSzIB3Ydn9VXGOebAtUx1ZAnoWoLNB HQ== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wnn27kd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:27 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 487BFD2EA;
        Sat, 20 Aug 2022 18:42:26 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id EE181803A87;
        Sat, 20 Aug 2022 18:42:25 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 17/17] crypto: Kconfig - simplify compression/RNG entries
Date:   Sat, 20 Aug 2022 13:41:51 -0500
Message-Id: <20220820184151.1149247-18-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
X-Proofpoint-GUID: cnBUflogor9OpgrwOBgU3IX0LfP9Cldy
X-Proofpoint-ORIG-GUID: cnBUflogor9OpgrwOBgU3IX0LfP9Cldy
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 mlxlogscore=959 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 crypto/Kconfig | 82 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 32 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index bee5753aa5bd..e93da749f31b 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1178,81 +1178,92 @@ config CRYPTO_CRC64_ROCKSOFT
 menu "Compression"
 
 config CRYPTO_DEFLATE
-	tristate "Deflate compression algorithm"
+	tristate "Deflate"
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 	select ZLIB_INFLATE
 	select ZLIB_DEFLATE
 	help
-	  This is the Deflate algorithm (RFC1951), specified for use in
-	  IPSec with the IPCOMP protocol (RFC3173, RFC2394).
+	  Deflate compression algorithm (RFC1951)
 
-	  You will most probably want this if using IPSec.
+	  Used by IPSec with the IPCOMP protocol (RFC3173, RFC2394)
 
 config CRYPTO_LZO
-	tristate "LZO compression algorithm"
+	tristate "LZO"
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 	select LZO_COMPRESS
 	select LZO_DECOMPRESS
 	help
-	  This is the LZO algorithm.
+	  LZO compression algorithm
+
+	  See https://www.oberhumer.com/opensource/lzo/ for further information.
 
 config CRYPTO_842
-	tristate "842 compression algorithm"
+	tristate "842"
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 	select 842_COMPRESS
 	select 842_DECOMPRESS
 	help
-	  This is the 842 algorithm.
+	  842 compression algorithm by IBM
+
+	  See https://github.com/plauth/lib842 for further information.
 
 config CRYPTO_LZ4
-	tristate "LZ4 compression algorithm"
+	tristate "LZ4"
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 	select LZ4_COMPRESS
 	select LZ4_DECOMPRESS
 	help
-	  This is the LZ4 algorithm.
+	  LZ4 compression algorithm
+
+	  See https://github.com/lz4/lz4 for further information.
 
 config CRYPTO_LZ4HC
-	tristate "LZ4HC compression algorithm"
+	tristate "LZ4HC"
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 	select LZ4HC_COMPRESS
 	select LZ4_DECOMPRESS
 	help
-	  This is the LZ4 high compression mode algorithm.
+	  LZ4 high compression mode algorithm
+
+	  See https://github.com/lz4/lz4 for further information.
 
 config CRYPTO_ZSTD
-	tristate "Zstd compression algorithm"
+	tristate "Zstd"
 	select CRYPTO_ALGAPI
 	select CRYPTO_ACOMP2
 	select ZSTD_COMPRESS
 	select ZSTD_DECOMPRESS
 	help
-	  This is the zstd algorithm.
+	  zstd compression algorithm
+
+	  See https://github.com/facebook/zstd for further information.
 
 endmenu
 
 menu "Random number generation"
 
 config CRYPTO_ANSI_CPRNG
-	tristate "Pseudo Random Number Generation for Cryptographic modules"
+	tristate "ANSI PRNG (Pseudo Random Number Generator)"
 	select CRYPTO_AES
 	select CRYPTO_RNG
 	help
-	  This option enables the generic pseudo random number generator
-	  for cryptographic modules.  Uses the Algorithm specified in
-	  ANSI X9.31 A.2.4. Note that this option must be enabled if
-	  CRYPTO_FIPS is selected
+	  Pseudo RNG (random number generator) (ANSI X9.31 Appendix A.2.4)
+
+	  This uses the AES cipher algorithm.
+
+	  Note that this option must be enabled if CRYPTO_FIPS is selected
 
 menuconfig CRYPTO_DRBG_MENU
-	tristate "NIST SP800-90A DRBG"
+	tristate "NIST SP800-90A DRBG (Deterministic Random Bit Generator)"
 	help
-	  NIST SP800-90A compliant DRBG. In the following submenu, one or
-	  more of the DRBG types must be selected.
+	  DRBG (Deterministic Random Bit Generator) (NIST SP800-90A)
+
+	  In the following submenu, one or more of the DRBG types must be selected.
 
 if CRYPTO_DRBG_MENU
 
@@ -1263,17 +1274,21 @@ config CRYPTO_DRBG_HMAC
 	select CRYPTO_SHA512
 
 config CRYPTO_DRBG_HASH
-	bool "Enable Hash DRBG"
+	bool "Hash_DRBG"
 	select CRYPTO_SHA256
 	help
-	  Enable the Hash DRBG variant as defined in NIST SP800-90A.
+	  Hash_DRBG variant as defined in NIST SP800-90A.
+
+	  This uses the SHA-1, SHA-256, SHA-384, or SHA-512 hash algorithms.
 
 config CRYPTO_DRBG_CTR
-	bool "Enable CTR DRBG"
+	bool "CTR_DRBG"
 	select CRYPTO_AES
 	select CRYPTO_CTR
 	help
-	  Enable the CTR DRBG variant as defined in NIST SP800-90A.
+	  CTR_DRBG variant as defined in NIST SP800-90A.
+
+	  This uses the AES cipher algorithm with the counter block mode.
 
 config CRYPTO_DRBG
 	tristate
@@ -1284,14 +1299,17 @@ config CRYPTO_DRBG
 endif	# if CRYPTO_DRBG_MENU
 
 config CRYPTO_JITTERENTROPY
-	tristate "Jitterentropy Non-Deterministic Random Number Generator"
+	tristate "CPU Jitter Non-Deterministic RNG (Random Number Generator)"
 	select CRYPTO_RNG
 	help
-	  The Jitterentropy RNG is a noise that is intended
-	  to provide seed to another RNG. The RNG does not
-	  perform any cryptographic whitening of the generated
-	  random numbers. This Jitterentropy RNG registers with
-	  the kernel crypto API and can be used by any caller.
+	  CPU Jitter RNG (Random Number Generator) from the Jitterentropy library
+
+	  A non-physical non-deterministic ("true") RNG (e.g., an entropy source
+	  compliant with NIST SP800-90B) intended to provide a seed to a
+	  deterministic RNG (e.g.  per NIST SP800-90C).
+	  This RNG does not perform any cryptographic whitening of the generated
+
+	  See https://www.chronox.de/jent.html
 
 config CRYPTO_KDF800108_CTR
 	tristate
-- 
2.37.1

