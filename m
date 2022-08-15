Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5231C593EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 23:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244948AbiHOU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346882AbiHOUz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:55:59 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33A0C04C4;
        Mon, 15 Aug 2022 12:11:25 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIEmf4004739;
        Mon, 15 Aug 2022 19:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=I701k4loSA5KNIeCflmPRMkgysoXzKyC/LnkRHw7w8Q=;
 b=XoSBg8Qq74kAE92VnlmdOD5JMn/dQAsBiIQGU49Rmkqe3wyliCB3D+eIP61//s8Li0ZQ
 DUSLBUH8g1/vsw4sYq1YSmiZPDcz/Ll2ISoIh0pJMT+DRiI/cghgZHPVPtgHTEaVBI12
 exkGZR+//xL6ZwDc0NV3hSJxQ2DU58GCFdlR+WsZNQRg1D1hYWyjZzDGMgs3tlQdTzk2
 Dnysn4JY7PXFrizFO1Qha4jK18SuUdUj2a3r2iVgE+Oha4745GmdU9/iT3rfCKMJQlEc
 0WGuE9jjekNmxTPnEMqK2PIwgHBCtCfJF/32DocH3jDBxncmOKQ/LKIVI89I5moHAdn3 SQ== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hyu8d0ctk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:11:19 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 54FD18001A6;
        Mon, 15 Aug 2022 19:06:19 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 0D9B080B10C;
        Mon, 15 Aug 2022 19:06:19 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 2/8] crypto: Kconfig - simplify public-key entries
Date:   Mon, 15 Aug 2022 14:06:02 -0500
Message-Id: <20220815190608.47182-3-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815190608.47182-1-elliott@hpe.com>
References: <20220815190608.47182-1-elliott@hpe.com>
X-Proofpoint-ORIG-GUID: 7Qi9pyEbKaGvP_0fYOZJa0v42YoSgeLe
X-Proofpoint-GUID: 7Qi9pyEbKaGvP_0fYOZJa0v42YoSgeLe
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
 engine=8.12.0-2207270000 definitions=main-2208150072
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
 crypto/Kconfig | 51 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index c2db970bc998..a7679e8cf842 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -219,20 +219,20 @@ menu "Crypto core or helper"
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
+	  RSA (Rivest-Shamir-Adleman) public key algorithm
 
 config CRYPTO_DH
-	tristate "Diffie-Hellman algorithm"
+	tristate "DH (Diffie-Hellman)"
 	select CRYPTO_KPP
 	select MPILIB
 	help
-	  Generic implementation of the Diffie-Hellman algorithm.
+	  DH (Diffie-Hellman) key exchange algorithm
 
 config CRYPTO_DH_RFC7919_GROUPS
 	bool "Support for RFC 7919 FFDHE group parameters"
@@ -246,24 +246,26 @@ menu "Public-key cryptography"
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
+	  ECDSA (Elliptic Curve Digital Signature Algorithm) (FIPS 186)
+	  using curves P-192, P-256, and P-384
+
+	  Only signature verification is implemented.
 
 config CRYPTO_ECRDSA
-	tristate "EC-RDSA (GOST 34.10) algorithm"
+	tristate "EC-RDSA (Elliptic Curve Russian Digital Signature Algorithm)"
 	select CRYPTO_ECC
 	select CRYPTO_AKCIPHER
 	select CRYPTO_STREEBOG
@@ -271,37 +273,46 @@ menu "Public-key cryptography"
 	select ASN1
 	help
 	  Elliptic Curve Russian Digital Signature Algorithm (GOST R 34.10-2012,
-	  RFC 7091, ISO/IEC 14888-3:2018) is one of the Russian cryptographic
-	  standard algorithms (called GOST algorithms). Only signature verification
-	  is implemented.
+	  RFC 7091, ISO/IEC 14888-3:2018)
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
+	  Curve25519 algorithm
 
 config CRYPTO_CURVE25519_X86
-	tristate "x86_64 accelerated Curve25519 scalar multiplication library"
+	tristate "Curve25519 (x86_64 with ADX)"
 	depends on X86 && 64BIT
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	help
+	  Curve25519 algorithm
+
+	  Architecture: x86_64 using:
+	  * ADX (large integer arithmetic)
 
 endmenu
 
-- 
2.37.1

