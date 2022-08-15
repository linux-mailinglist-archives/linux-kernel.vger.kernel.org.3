Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 023DA593E56
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345994AbiHOUkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346074AbiHOUfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:35:23 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4204E63C;
        Mon, 15 Aug 2022 12:06:29 -0700 (PDT)
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FHdIEC029923;
        Mon, 15 Aug 2022 19:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=d/d9/0ddOCMUWXxWz5xMR0gFJpcAOm6VSQ7E3ZdRtY0=;
 b=Oj5SYJQodAa6nQPbVjIbqYiPCCo+2BPJHF39ayBq1Vi6nIRiPt7crhKegzQ5XTV+jM7I
 MRjqqlbRtUc1ansKyJRYT5xNzFbalxOMZY0GW5SIkqg5jbgUwdZnay1+7QOFYEuWmRck
 EEzli7NbrVSUVFF11Yk65ziFntNytKcFcL6/BUgMcQzAPWps9F9ly3kGjqhlg8t8EvLL
 17g99lelRaW0GPekvaJADqhskAZZdLiQvVXj0p0OlLvOfWCl7qMkfFfc8GdPyC1xmqa3
 2QEPSn7cYfF0AdDwKWn55cszXDnRQZQB9fDZq7X68goGdbE+c0OzU/ZL6+YsTino/KIv JQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hyt4j12gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:06:25 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 8FE25804CBF;
        Mon, 15 Aug 2022 19:06:24 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 451BF80940A;
        Mon, 15 Aug 2022 19:06:24 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 7/8] crypto: Kconfig - sort the digests
Date:   Mon, 15 Aug 2022 14:06:07 -0500
Message-Id: <20220815190608.47182-8-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815190608.47182-1-elliott@hpe.com>
References: <20220815190608.47182-1-elliott@hpe.com>
X-Proofpoint-GUID: BtJhCOfEhCs_Z919nYlXKSWZCTD6UxYO
X-Proofpoint-ORIG-GUID: BtJhCOfEhCs_Z919nYlXKSWZCTD6UxYO
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208150072
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sort the entries in Digests by their displayed names.
In particular, keep the optimized CPU implementations next to the
generic implementations.

Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 crypto/Kconfig | 299 ++++++++++++++++++++++++-------------------------
 1 file changed, 149 insertions(+), 150 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 0116729ea369..f5cfb73e2423 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -632,6 +632,58 @@ menu "Hash modes"
 
 menu "Digests"
 
+config CRYPTO_BLAKE2B
+	tristate "BLAKE2b"
+	select CRYPTO_HASH
+	help
+	  BLAKE2b cryptographic hash function (RFC 7693)
+
+	  BLAKE2b is optimized for 64-bit platforms and can produce digests
+	  of any size between 1 and 64 bytes. The keyed hash is also implemented.
+
+	  This module provides the following algorithms:
+	  - blake2b-160
+	  - blake2b-256
+	  - blake2b-384
+	  - blake2b-512
+
+	  See https://blake2.net for further information.
+
+	  Used by the btrfs filesystem.
+
+config CRYPTO_BLAKE2S
+	tristate "BLAKE2s"
+	select CRYPTO_LIB_BLAKE2S_GENERIC
+	select CRYPTO_HASH
+	help
+	  BLAKE2s cryptographic hash function (RFC 7693)
+
+	  BLAKE2s is optimized for 8 to 32-bit platforms and can produce
+	  digests of any size between 1 and 32 bytes. The keyed hash is
+	  also implemented.
+
+	  This module provides the following algorithms:
+	  - blake2s-128
+	  - blake2s-160
+	  - blake2s-224
+	  - blake2s-256
+
+	  Used by Wireguard.
+
+	  See https://blake2.net for further information.
+
+config CRYPTO_BLAKE2S_X86
+	tristate "BLAKE2s (x86_64 with SSSE3/AVX-512)"
+	depends on X86 && 64BIT
+	select CRYPTO_LIB_BLAKE2S_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
+	help
+	  BLAKE2s cryptographic hash function (RFC 7693)
+
+	  Architecture: x86_64 using:
+	  * SSSE3 (Supplemental SSE3)
+	  * AVX-512 (Advanced Vector Extensions-512)
+
 config CRYPTO_CRC32C
 	tristate "CRC32c"
 	select CRYPTO_HASH
@@ -726,69 +778,6 @@ menu "Digests"
 
 	  It is available with IBM z13 or later.
 
-config CRYPTO_XXHASH
-	tristate "xxHash"
-	select CRYPTO_HASH
-	select XXHASH
-	help
-	  xxHash non-cryptographic hash algorithm
-
-	  Extremely fast, working at speeds close to RAM limits.
-
-	  Used by the btrfs filesystem.
-
-config CRYPTO_BLAKE2B
-	tristate "BLAKE2b"
-	select CRYPTO_HASH
-	help
-	  BLAKE2b cryptographic hash function (RFC 7693)
-
-	  BLAKE2b is optimized for 64-bit platforms and can produce digests
-	  of any size between 1 and 64 bytes. The keyed hash is also implemented.
-
-	  This module provides the following algorithms:
-	  - blake2b-160
-	  - blake2b-256
-	  - blake2b-384
-	  - blake2b-512
-
-	  See https://blake2.net for further information.
-
-	  Used by the btrfs filesystem.
-
-config CRYPTO_BLAKE2S
-	tristate "BLAKE2s"
-	select CRYPTO_LIB_BLAKE2S_GENERIC
-	select CRYPTO_HASH
-	help
-	  BLAKE2s cryptographic hash function (RFC 7693)
-
-	  BLAKE2s is optimized for 8 to 32-bit platforms and can produce
-	  digests of any size between 1 and 32 bytes. The keyed hash is
-	  also implemented.
-
-	  This module provides the following algorithms:
-	  - blake2s-128
-	  - blake2s-160
-	  - blake2s-224
-	  - blake2s-256
-
-	  Used by Wireguard.
-
-	  See https://blake2.net for further information.
-
-config CRYPTO_BLAKE2S_X86
-	tristate "BLAKE2s (x86_64 with SSSE3/AVX-512)"
-	depends on X86 && 64BIT
-	select CRYPTO_LIB_BLAKE2S_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
-	help
-	  BLAKE2s cryptographic hash function (RFC 7693)
-
-	  Architecture: x86_64 using:
-	  * SSSE3 (Supplemental SSE3)
-	  * AVX-512 (Advanced Vector Extensions-512)
-
 config CRYPTO_CRCT10DIF
 	tristate "CRCT10DIF"
 	select CRYPTO_HASH
@@ -819,6 +808,14 @@ menu "Digests"
 	  Architecture: powerpc64 using AltiVec extensions
 	  Enable on POWER8 and newer processors for improved performance.
 
+config CRYPTO_VPMSUM_TESTER
+	tristate "CRC32C and CRC32T10DIF vpmsum hardware acceleration tester (powerpc64)"
+	depends on CRYPTO_CRCT10DIF_VPMSUM && CRYPTO_CRC32C_VPMSUM
+	help
+	  Stress test for CRC32c and CRCT10DIF algorithms implemented with
+	  powerpc64 AltiVec extensions (POWER8 vpmsum instructions).
+	  Unless you are testing these algorithms, you don't need this.
+
 config CRYPTO_CRC64_ROCKSOFT
 	tristate "CRC64 based on the Rocksoft Model CRC Algorithm"
 	depends on CRC64
@@ -830,14 +827,6 @@ menu "Digests"
 
 	  See https://zlib.net/crc_v3.txt
 
-config CRYPTO_VPMSUM_TESTER
-	tristate "CRC32C and CRC32T10DIF vpmsum hardware acceleration tester (powerpc64)"
-	depends on CRYPTO_CRCT10DIF_VPMSUM && CRYPTO_CRC32C_VPMSUM
-	help
-	  Stress test for CRC32c and CRCT10DIF algorithms implemented with
-	  powerpc64 AltiVec extensions (POWER8 vpmsum instructions).
-	  Unless you are testing these algorithms, you don't need this.
-
 config CRYPTO_GHASH
 	tristate "GHASH"
 	select CRYPTO_GF128MUL
@@ -845,37 +834,26 @@ menu "Digests"
 	help
 	  GCM GHASH function (NIST SP800-38D)
 
-config CRYPTO_POLY1305
-	tristate "Poly1305"
-	select CRYPTO_HASH
-	select CRYPTO_LIB_POLY1305_GENERIC
-	help
-	  Poly1305 authenticator algorithm (RFC7539)
-
-	  Poly1305 is an authenticator algorithm designed by Daniel J. Bernstein.
-	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
-	  in IETF protocols. This is the portable C implementation of Poly1305.
-
-config CRYPTO_POLY1305_X86_64
-	tristate "Poly1305 (x86_64 with SSE2/AVX2)"
+config CRYPTO_GHASH_CLMUL_NI_INTEL
+	tristate "GHASH (x86_64 with CLMUL-NI)"
 	depends on X86 && 64BIT
-	select CRYPTO_LIB_POLY1305_GENERIC
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	select CRYPTO_CRYPTD
 	help
-	  Poly1305 authenticator algorithm (RFC7539)
+	  GCM GHASH hash function (NIST SP800-38D)
 
 	  Architecture: x86_64 using:
-	  * SSE2 (Streaming SIMD Extensions 2)
-	  * AVX2 (Advanced Vector Extensions 2)
+	  * CLMUL-NI (carry-less multiplication new instructions)
 
-config CRYPTO_POLY1305_MIPS
-	tristate "Poly1305 (MIPS)"
-	depends on MIPS
-	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+config CRYPTO_GHASH_S390
+	tristate "GHASH (s390)"
+	depends on S390
+	select CRYPTO_HASH
 	help
-	  Poly1305 authenticator algorithm (RFC7539)
+	  GCM GHASH hash function (NIST SP800-38D)
 
-	  Architecture: mips
+	  Architecture: s390
+
+	  It is available as of z196.
 
 config CRYPTO_MD4
 	tristate "MD4"
@@ -930,6 +908,38 @@ menu "Digests"
 	  This algorithm is required for TKIP, but it should not be used for
 	  other purposes because of the weakness of the algorithm.
 
+config CRYPTO_POLY1305
+	tristate "Poly1305"
+	select CRYPTO_HASH
+	select CRYPTO_LIB_POLY1305_GENERIC
+	help
+	  Poly1305 authenticator algorithm (RFC7539)
+
+	  Poly1305 is an authenticator algorithm designed by Daniel J. Bernstein.
+	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
+	  in IETF protocols. This is the portable C implementation of Poly1305.
+
+config CRYPTO_POLY1305_X86_64
+	tristate "Poly1305 (x86_64 with SSE2/AVX2)"
+	depends on X86 && 64BIT
+	select CRYPTO_LIB_POLY1305_GENERIC
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	help
+	  Poly1305 authenticator algorithm
+
+	  Architecture: x86_64 using:
+	  * SSE2 (Streaming SIMD Extensions 2)
+	  * AVX2 (Advanced Vector Extensions 2)
+
+config CRYPTO_POLY1305_MIPS
+	tristate "Poly1305 (MIPS)"
+	depends on MIPS
+	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	help
+	  Poly1305 authenticator algorithm
+
+	  Architecture: mips
+
 config CRYPTO_RMD160
 	tristate "RIPEMD-160"
 	select CRYPTO_HASH
@@ -968,44 +978,6 @@ menu "Digests"
 	  * AVX2 (Advanced Vector Extensions 2)
 	  * SHA-NI (SHA Extensions New Instructions)
 
-config CRYPTO_SHA256_SSSE3
-	tristate "SHA224 and SHA256 (x86_64 with SSSE3/AVX/AVX2/SHA-NI)"
-	depends on X86 && 64BIT
-	select CRYPTO_SHA256
-	select CRYPTO_HASH
-	help
-	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
-
-	  Architecture: x86_64 using:
-	  * SSSE3 (Supplemental SSE3)
-	  * AVX (Advanced Vector Extensions)
-	  * AVX2 (Advanced Vector Extensions 2)
-	  * SHA-NI (SHA Extensions New Instructions)
-
-config CRYPTO_SHA512_SSSE3
-	tristate "SHA384 and SHA512 (x86_64 with SSSE3/AVX/AVX2)"
-	depends on X86 && 64BIT
-	select CRYPTO_SHA512
-	select CRYPTO_HASH
-	help
-	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
-
-	  Architecture: x86_64 using:
-	  * SSSE3 (Supplemental SSE3)
-	  * AVX (Advanced Vector Extensions)
-	  * AVX2 (Advanced Vector Extensions 2)
-
-config CRYPTO_SHA512_S390
-	tristate "SHA384 and SHA512 (s390)"
-	depends on S390
-	select CRYPTO_HASH
-	help
-	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
-
-	  Architecture: s390
-
-	  It is available as of z10.
-
 config CRYPTO_SHA1_OCTEON
 	tristate "SHA1 (OCTEON)"
 	depends on CPU_CAVIUM_OCTEON
@@ -1063,6 +1035,20 @@ menu "Digests"
 	  This is required for IPsec AH (XFRM_AH) and IPsec ESP (XFRM_ESP).
 	  Used by the btrfs filesystem, Ceph, NFS, and SMB.
 
+config CRYPTO_SHA256_SSSE3
+	tristate "SHA224 and SHA256 (x86_64 with SSSE3/AVX/AVX2/SHA-NI)"
+	depends on X86 && 64BIT
+	select CRYPTO_SHA256
+	select CRYPTO_HASH
+	help
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: x86_64 using:
+	  * SSSE3 (Supplemental SSE3)
+	  * AVX (Advanced Vector Extensions)
+	  * AVX2 (Advanced Vector Extensions 2)
+	  * SHA-NI (SHA Extensions New Instructions)
+
 config CRYPTO_SHA256_PPC_SPE
 	tristate "SHA224 and SHA256 (PPC SPE)"
 	depends on PPC && SPE
@@ -1110,6 +1096,30 @@ menu "Digests"
 	help
 	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
 
+config CRYPTO_SHA512_SSSE3
+	tristate "SHA384 and SHA512 (x86_64 with SSSE3/AVX/AVX2)"
+	depends on X86 && 64BIT
+	select CRYPTO_SHA512
+	select CRYPTO_HASH
+	help
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: x86_64 using:
+	  * SSSE3 (Supplemental SSE3)
+	  * AVX (Advanced Vector Extensions)
+	  * AVX2 (Advanced Vector Extensions 2)
+
+config CRYPTO_SHA512_S390
+	tristate "SHA384 and SHA512 (s390)"
+	depends on S390
+	select CRYPTO_HASH
+	help
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: s390
+
+	  It is available as of z10.
+
 config CRYPTO_SHA512_OCTEON
 	tristate "SHA384 and SHA512 (OCTEON)"
 	depends on CPU_CAVIUM_OCTEON
@@ -1213,27 +1223,16 @@ menu "Digests"
 	  See https://web.archive.org/web/20171129084214/http://www.larc.usp.br/~pbarreto/WhirlpoolPage.html
 	  for further information.
 
-config CRYPTO_GHASH_CLMUL_NI_INTEL
-	tristate "GHASH (x86_64 with CLMUL-NI)"
-	depends on X86 && 64BIT
-	select CRYPTO_CRYPTD
-	help
-	  GCM GHASH hash function (NIST SP800-38D)
-
-	  Architecture: x86_64 using:
-	  * CLMUL-NI (carry-less multiplication new instructions)
-
-config CRYPTO_GHASH_S390
-	tristate "GHASH (s390)"
-	depends on S390
+config CRYPTO_XXHASH
+	tristate "xxHash"
 	select CRYPTO_HASH
+	select XXHASH
 	help
-	  GCM GHASH hash function (NIST SP800-38D)
-
-	  Architecture: s390
+	  xxHash non-cryptographic hash algorithm
 
-	  It is available as of z196.
+	  Extremely fast, working at speeds close to RAM limits.
 
+	  Used by the btrfs filesystem.
 endmenu
 
 menu "Ciphers"
-- 
2.37.1

