Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3F8593E58
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346110AbiHOUlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346055AbiHOUfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:35:23 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04C54E626;
        Mon, 15 Aug 2022 12:06:28 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FJ4te5010959;
        Mon, 15 Aug 2022 19:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=qCh6I0+cDF6swBdDYOmEA/mJHXnGtsAsU0SP+AClfmE=;
 b=Ub0KNwFzAZhvt6rYkm/dOa6yB19Q/C8OVqcGHY5JcpWdFLGK7ZjiD12XkoqWzmE4BCWi
 IdMQC8c44alChEH+DKLX5ncij16sgEh++2gvTqmvXj3VQvvsvb6jhbBvPwiYIV3LS21i
 LXE6LDJDvdw7OKtS0C+qJN9dqeFwUcEsN1ZMW8IcVzYa1r5E7lHF3CbFM8VfzbKX/AgD
 FzbiYG1Yps6CPH65vCEWhjJUVnFJXKueLsRTMYp09jF7/CmHx3gqPxVcxA1fGFWPat1x
 9CZRGCxbYXmTMc4TnJEKypxqvBgucH3xQjfzGWHkRR3lA/PGrp/kMLxC3HygJITddm/X 4Q== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hyuys00ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:06:26 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 99787800E88;
        Mon, 15 Aug 2022 19:06:25 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 56A00808EA6;
        Mon, 15 Aug 2022 19:06:25 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 8/8] crypto: Kconfig - sort the ciphers
Date:   Mon, 15 Aug 2022 14:06:08 -0500
Message-Id: <20220815190608.47182-9-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815190608.47182-1-elliott@hpe.com>
References: <20220815190608.47182-1-elliott@hpe.com>
X-Proofpoint-ORIG-GUID: uHjKQu-OpM44Ya7c7n1iQLIosvqeJO6e
X-Proofpoint-GUID: uHjKQu-OpM44Ya7c7n1iQLIosvqeJO6e
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

Sort the entries in Ciphers by their displayed names.
In particular, keep the optimized CPU implementations next to the
generic implementations.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/Kconfig | 118 ++++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index f5cfb73e2423..03f4e2d97ef9 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1500,6 +1500,65 @@ menu "Ciphers"
 
 	  Processes eight blocks in parallel.
 
+config CRYPTO_CHACHA20
+	tristate "ChaCha"
+	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_SKCIPHER
+	help
+	  The ChaCha20, XChaCha20, and XChaCha12 stream cipher algorithms
+
+	  ChaCha20 is a 256-bit high-speed stream cipher designed by Daniel J.
+	  Bernstein and further specified in RFC7539 for use in IETF protocols.
+	  This is the portable C implementation of ChaCha20.  See
+	  https://cr.yp.to/chacha/chacha-20080128.pdf for further information.
+
+	  XChaCha20 is the application of the XSalsa20 construction to ChaCha20
+	  rather than to Salsa20.  XChaCha20 extends ChaCha20's nonce length
+	  from 64 bits (or 96 bits using the RFC7539 convention) to 192 bits,
+	  while provably retaining ChaCha20's security.  See
+	  https://cr.yp.to/snuffle/xsalsa-20081128.pdf for further information.
+
+	  XChaCha12 is XChaCha20 reduced to 12 rounds, with correspondingly
+	  reduced security margin but increased performance.  It can be needed
+	  in some performance-sensitive scenarios.
+
+config CRYPTO_CHACHA20_X86_64
+	tristate "ChaCha (x86_64 with SSSE3/AVX2/AVX-512VL)"
+	depends on X86 && 64BIT
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	help
+	  ChaCha stream cipher algorithms
+
+	  Architecture: x86_64 using:
+	  * SSSE3 (Supplemental SSE3)
+	  * AVX2 (Advanced Vector Extensions 2)
+	  * AVX-512VL (Advanced Vector Extensions-512VL)
+
+config CRYPTO_CHACHA_MIPS
+	tristate "ChaCha (MIPS32r2)"
+	depends on CPU_MIPS32_R2
+	select CRYPTO_SKCIPHER
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	help
+	  ChaCha stream cipher algorithms
+
+	  Architecture: MIPS32r2
+
+config CRYPTO_CHACHA_S390
+	tristate "ChaCha20 (s390)"
+	depends on S390
+	select CRYPTO_SKCIPHER
+	select CRYPTO_LIB_CHACHA_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_CHACHA
+	help
+	  ChaCha20 stream cipher (RFC 7539)
+
+	  Architecture: s390
+
+	  It is available as of z13.
+
 config CRYPTO_DES
 	tristate "DES and Triple DES EDE"
 	select CRYPTO_ALGAPI
@@ -1566,65 +1625,6 @@ menu "Ciphers"
 	  See https://web.archive.org/web/20171011071731/http://www.larc.usp.br/~pbarreto/KhazadPage.html
 	  for further information.
 
-config CRYPTO_CHACHA20
-	tristate "ChaCha"
-	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_SKCIPHER
-	help
-	  The ChaCha20, XChaCha20, and XChaCha12 stream cipher algorithms
-
-	  ChaCha20 is a 256-bit high-speed stream cipher designed by Daniel J.
-	  Bernstein and further specified in RFC7539 for use in IETF protocols.
-	  This is the portable C implementation of ChaCha20.  See
-	  https://cr.yp.to/chacha/chacha-20080128.pdf for further information.
-
-	  XChaCha20 is the application of the XSalsa20 construction to ChaCha20
-	  rather than to Salsa20.  XChaCha20 extends ChaCha20's nonce length
-	  from 64 bits (or 96 bits using the RFC7539 convention) to 192 bits,
-	  while provably retaining ChaCha20's security.  See
-	  https://cr.yp.to/snuffle/xsalsa-20081128.pdf for further information.
-
-	  XChaCha12 is XChaCha20 reduced to 12 rounds, with correspondingly
-	  reduced security margin but increased performance.  It can be needed
-	  in some performance-sensitive scenarios.
-
-config CRYPTO_CHACHA20_X86_64
-	tristate "ChaCha (x86_64 with SSSE3/AVX2/AVX-512VL)"
-	depends on X86 && 64BIT
-	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	help
-	  ChaCha stream cipher algorithms
-
-	  Architecture: x86_64 using:
-	  * SSSE3 (Supplemental SSE3)
-	  * AVX2 (Advanced Vector Extensions 2)
-	  * AVX-512VL (Advanced Vector Extensions-512VL)
-
-config CRYPTO_CHACHA_MIPS
-	tristate "ChaCha (MIPS32r2)"
-	depends on CPU_MIPS32_R2
-	select CRYPTO_SKCIPHER
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	help
-	  ChaCha stream cipher algorithms
-
-	  Architecture: MIPS32r2
-
-config CRYPTO_CHACHA_S390
-	tristate "ChaCha20 (s390)"
-	depends on S390
-	select CRYPTO_SKCIPHER
-	select CRYPTO_LIB_CHACHA_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_CHACHA
-	help
-	  ChaCha20 stream cipher (RFC 7539)
-
-	  Architecture: s390
-
-	  It is available as of z13.
-
 config CRYPTO_SEED
 	tristate "SEED"
 	depends on CRYPTO_USER_API_ENABLE_OBSOLETE
-- 
2.37.1

