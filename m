Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3C959AF9E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233693AbiHTSm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiHTSm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:27 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568D645043;
        Sat, 20 Aug 2022 11:42:26 -0700 (PDT)
Received: from pps.filterd (m0134425.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KGCb8Y000527;
        Sat, 20 Aug 2022 18:42:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=T38/AyiNSJmlIFykxlxq8CX3IrZIufqRiclQzZFcHk0=;
 b=m07WYmJrFkgNgja36TXfY83EfcfGD5+S5RxvP/IBxSuSfsOKmqOGN/39UP/Pws2sx8QU
 U6IJaJO3XpOabn4NJnhDtUGLPwymrjPsLKAmVei/5fiutxRS3cIWTBus09cvjIF1fv+W
 EOUFYUdJsc6ZHgBxJmHvAChLekfs5MAjkdS7sTWa8r40ei7hT04TFERY2q3rDK1hyNCi
 BjScLL6srAOrLPL+gz7JBO27kOvS4qy0ln/loBnUHQuVVyUrOm8c8WhgKEJCxcjRliEt
 aLLj1HjdfC+K8Fgq4uS+mUhgJnHEgsL3OqwiY3pCGPEpS+1kGyvh516j+0u/a8PtMy7B +A== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j32wvrjjt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:20 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 90BE4D2E8;
        Sat, 20 Aug 2022 18:42:19 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 4060C803510;
        Sat, 20 Aug 2022 18:42:19 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 11/17] crypto: Kconfig - simplify public-key entries
Date:   Sat, 20 Aug 2022 13:41:45 -0500
Message-Id: <20220820184151.1149247-12-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
X-Proofpoint-GUID: 47KsQ1xU5tBwv-kJSrUVJDk5-mZFp4vY
X-Proofpoint-ORIG-GUID: 47KsQ1xU5tBwv-kJSrUVJDk5-mZFp4vY
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208200080
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
 arch/arm/crypto/Kconfig |  7 +++++-
 arch/x86/crypto/Kconfig |  7 +++++-
 crypto/Kconfig          | 55 +++++++++++++++++++++++++----------------
 3 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index d73d19971b87..4b062bf53fa2 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -3,10 +3,15 @@
 menu "Accelerated Cryptographic Algorithms for CPU (arm)"
 
 config CRYPTO_CURVE25519_NEON
-	tristate "NEON accelerated Curve25519 scalar multiplication library"
+	tristate "Public key crypto: Curve25519 (NEON)"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	help
+	  Curve25519 algorithm
+
+	  Architecture: arm with
+	  - NEON (Advanced SIMD) extensions
 
 config CRYPTO_GHASH_ARM_CE
 	tristate "PMULL-accelerated GHASH using NEON/ARMv8 Crypto Extensions"
diff --git a/arch/x86/crypto/Kconfig b/arch/x86/crypto/Kconfig
index 04f4baea12a8..76229ccb79fd 100644
--- a/arch/x86/crypto/Kconfig
+++ b/arch/x86/crypto/Kconfig
@@ -3,10 +3,15 @@
 menu "Accelerated Cryptographic Algorithms for CPU (x86)"
 
 config CRYPTO_CURVE25519_X86
-	tristate "x86_64 accelerated Curve25519 scalar multiplication library"
+	tristate "Public key crypto: Curve25519 (ADX)"
 	depends on X86 && 64BIT
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	help
+	  Curve25519 algorithm
+
+	  Architecture: x86_64 using:
+	  - ADX (large integer arithmetic)
 
 config CRYPTO_AES_NI_INTEL
 	tristate "AES cipher algorithms (AES-NI)"
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 0d2342f92b1c..3694b2ff44f8 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -240,51 +240,60 @@ config CRYPTO_ENGINE
 menu "Public-key cryptography"
 
 config CRYPTO_RSA
-	tristate "RSA algorithm"
+	tristate "RSA (Rivest-Shamir-Adleman)"
 	select CRYPTO_AKCIPHER
 	select CRYPTO_MANAGER
 	select MPILIB
 	select ASN1
 	help
-	  Generic implementation of the RSA public key algorithm.
+	  RSA (Rivest-Shamir-Adleman) public key algorithm (RFC8017)
 
 config CRYPTO_DH
-	tristate "Diffie-Hellman algorithm"
+	tristate "DH (Diffie-Hellman)"
 	select CRYPTO_KPP
 	select MPILIB
 	help
-	  Generic implementation of the Diffie-Hellman algorithm.
+	  DH (Diffie-Hellman) key exchange algorithm
 
 config CRYPTO_DH_RFC7919_GROUPS
-	bool "Support for RFC 7919 FFDHE group parameters"
+	bool "RFC 7919 FFDHE groups"
 	depends on CRYPTO_DH
 	select CRYPTO_RNG_DEFAULT
 	help
-	  Provide support for RFC 7919 FFDHE group parameters. If unsure, say N.
+	  FFDHE (Finite-Field-based Diffie-Hellman Ephemeral) groups
+	  defined in RFC7919.
+
+	  Support these finite-field groups in DH key exchanges:
+	  - ffdhe2048, ffdhe3072, ffdhe4096, ffdhe6144, ffdhe8192
+
+	  If unsure, say N.
 
 config CRYPTO_ECC
 	tristate
 	select CRYPTO_RNG_DEFAULT
 
 config CRYPTO_ECDH
-	tristate "ECDH algorithm"
+	tristate "ECDH (Elliptic Curve Diffie-Hellman)"
 	select CRYPTO_ECC
 	select CRYPTO_KPP
 	help
-	  Generic implementation of the ECDH algorithm
+	  ECDH (Elliptic Curve Diffie-Hellman) key exchange algorithm
+	  using curves P-192, P-256, and P-384 (FIPS 186)
 
 config CRYPTO_ECDSA
-	tristate "ECDSA (NIST P192, P256 etc.) algorithm"
+	tristate "ECDSA (Elliptic Curve Digital Signature Algorithm)"
 	select CRYPTO_ECC
 	select CRYPTO_AKCIPHER
 	select ASN1
 	help
-	  Elliptic Curve Digital Signature Algorithm (NIST P192, P256 etc.)
-	  is A NIST cryptographic standard algorithm. Only signature verification
-	  is implemented.
+	  ECDSA (Elliptic Curve Digital Signature Algorithm) (FIPS 186,
+	  ISO/IEC 14888-3)
+	  using curves P-192, P-256, and P-384
+
+	  Only signature verification is implemented.
 
 config CRYPTO_ECRDSA
-	tristate "EC-RDSA (GOST 34.10) algorithm"
+	tristate "EC-RDSA (Elliptic Curve Russian Digital Signature Algorithm)"
 	select CRYPTO_ECC
 	select CRYPTO_AKCIPHER
 	select CRYPTO_STREEBOG
@@ -292,31 +301,35 @@ config CRYPTO_ECRDSA
 	select ASN1
 	help
 	  Elliptic Curve Russian Digital Signature Algorithm (GOST R 34.10-2012,
-	  RFC 7091, ISO/IEC 14888-3:2018) is one of the Russian cryptographic
-	  standard algorithms (called GOST algorithms). Only signature verification
-	  is implemented.
+	  RFC 7091, ISO/IEC 14888-3)
+
+	  One of the Russian cryptographic standard algorithms (called GOST
+	  algorithms). Only signature verification is implemented.
 
 config CRYPTO_SM2
-	tristate "SM2 algorithm"
+	tristate "SM2 (ShangMi 2)"
 	select CRYPTO_SM3
 	select CRYPTO_AKCIPHER
 	select CRYPTO_MANAGER
 	select MPILIB
 	select ASN1
 	help
-	  Generic implementation of the SM2 public key algorithm. It was
-	  published by State Encryption Management Bureau, China.
+	  SM2 (ShangMi 2) public key algorithm
+
+	  Published by State Encryption Management Bureau, China,
 	  as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012.
 
 	  References:
-	  https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
+	  https://datatracker.ietf.org/doc/draft-shen-sm2-ecdsa/
 	  http://www.oscca.gov.cn/sca/xxgk/2010-12/17/content_1002386.shtml
 	  http://www.gmbz.org.cn/main/bzlb.html
 
 config CRYPTO_CURVE25519
-	tristate "Curve25519 algorithm"
+	tristate "Curve25519"
 	select CRYPTO_KPP
 	select CRYPTO_LIB_CURVE25519_GENERIC
+	help
+	  Curve25519 elliptic curve (RFC7748)
 
 endmenu
 
-- 
2.37.1

