Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE9A593E59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbiHOUlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346073AbiHOUfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:35:23 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865FA4E623;
        Mon, 15 Aug 2022 12:06:27 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27FIplv8001482;
        Mon, 15 Aug 2022 19:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pps0720;
 bh=GnXigjBi3Y9D5niWTEiKyH5NhrpH/AJZUwps2V8zaYM=;
 b=MqXoVfG3DEAMD2Ffu6YKhoNaH6k7OOwDjOrWVQj2neTvhLBsgQhZy2f5nzleoUpld9OA
 tHg3mAgvi9PoGFD24lYqCXuyUj5uapzfWg5d9fp56FSS4Vvxfu9DOxS6+4TOiQAZMwtN
 9cBcyHJdHcxvZ5CW1dVuTddJgdbkApNYleQeC2saYMVl97cXZMcdhg0DMG9gN3TyqHDG
 nn8QEmQByrS25whcgqIuK/lj9u0mjB7pa1ag0vq5qSDghS3C3Sobk5L7XinatzUIm0rn
 2VRxPCXcQPYIk5o3WMNS/z5YcBHplJ2BRHTpKO0O9PykpyM0Q9CVxTrFTMFgPSU0wsbh qA== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3hyusxg3jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Aug 2022 19:06:23 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 75DF9804CBC;
        Mon, 15 Aug 2022 19:06:22 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 2F15F803AF6;
        Mon, 15 Aug 2022 19:06:22 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     toshi.kani@hpe.com, Robert Elliott <elliott@hpe.com>
Subject: [PATCH 5/8] crypto: Kconfig - simplify hash mode and digest entries
Date:   Mon, 15 Aug 2022 14:06:05 -0500
Message-Id: <20220815190608.47182-6-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815190608.47182-1-elliott@hpe.com>
References: <20220815190608.47182-1-elliott@hpe.com>
X-Proofpoint-GUID: KI9Co6rv90VAoOgIhIG69O-1NtDz7644
X-Proofpoint-ORIG-GUID: KI9Co6rv90VAoOgIhIG69O-1NtDz7644
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-15_08,2022-08-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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
 crypto/Kconfig | 495 +++++++++++++++++++++++++++----------------------
 1 file changed, 275 insertions(+), 220 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 703c91e8e7a0..e012d33eb739 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -304,6 +304,8 @@ menu "Public-key cryptography"
 	help
 	  Curve25519 algorithm
 
+	  Used by Wireguard.
+
 config CRYPTO_CURVE25519_X86
 	tristate "Curve25519 (x86_64 with ADX)"
 	depends on X86 && 64BIT
@@ -591,149 +593,160 @@ menu "Block modes"
 menu "Hash modes"
 
 config CRYPTO_CMAC
-	tristate "CMAC support"
+	tristate "CMAC (Cipher-based Message Authentication Code)"
 	select CRYPTO_HASH
 	select CRYPTO_MANAGER
 	help
-	  Cipher-based Message Authentication Code (CMAC) specified by
-	  The National Institute of Standards and Technology (NIST).
-
-	  https://tools.ietf.org/html/rfc4493
-	  http://csrc.nist.gov/publications/nistpubs/800-38B/SP_800-38B.pdf
+	  CMAC (Cipher-based Message Authentication Code) authentication
+	  mode (NIST SP800-38B and IETF RFC4493)
 
 config CRYPTO_HMAC
-	tristate "HMAC support"
+	tristate "HMAC (Keyed-Hash Message Authentication Code)"
 	select CRYPTO_HASH
 	select CRYPTO_MANAGER
 	help
-	  HMAC: Keyed-Hashing for Message Authentication (RFC2104).
-	  This is required for IPSec.
+	  HMAC (Keyed-Hash Message Authentication Code) (FIPS 198 and
+	  RFC2104)
+
+	  This is required for IPsec AH (XFRM_AH) and IPsec ESP (XFRM_ESP).
 
 config CRYPTO_XCBC
-	tristate "XCBC support"
+	tristate "XCBC-MAC (Extended Cipher Block Chaining Message Authentication Code)"
 	select CRYPTO_HASH
 	select CRYPTO_MANAGER
 	help
-	  XCBC: Keyed-Hashing with encryption algorithm
-		https://www.ietf.org/rfc/rfc3566.txt
-		http://csrc.nist.gov/encryption/modes/proposedmodes/
-		 xcbc-mac/xcbc-mac-spec.pdf
+	  XCBC-MAC (Extended Cipher Block Chaining Message Authentication
+	  Code) (RFC3566)
 
 config CRYPTO_VMAC
-	tristate "VMAC support"
+	tristate "VMAC"
 	select CRYPTO_HASH
 	select CRYPTO_MANAGER
 	help
 	  VMAC is a message authentication algorithm designed for
 	  very high speed on 64-bit architectures.
 
-	  See also:
-	  <https://fastcrypto.org/vmac>
+	  See https://fastcrypto.org/vmac for further information.
 
 endmenu
 
 menu "Digests"
 
 config CRYPTO_CRC32C
-	tristate "CRC32c CRC algorithm"
+	tristate "CRC32c"
 	select CRYPTO_HASH
 	select CRC32
 	help
-	  Castagnoli, et al Cyclic Redundancy-Check Algorithm.  Used
-	  by iSCSI for header and data digests and by others.
-	  See Castagnoli93.  Module will be crc32c.
+	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
+
+	  A 32-bit CRC (cyclic redundancy check) with a polynomial defined
+	  by G. Castagnoli, S. Braeuer and M. Herrman in "Optimization of Cyclic
+	  Redundancy-Check Codes with 24 and 32 Parity Bits", IEEE Transactions
+	  on Communications, Vol. 41, No. 6, June 1993, selected for use with
+	  iSCSI.
+
+	  Used by btrfs, ext4, jbd2, NVMeoF/TCP, and iSCSI.
 
 config CRYPTO_CRC32C_INTEL
-	tristate "CRC32c INTEL hardware acceleration"
+	tristate "CRC32c (x86 with SSE4.2/PCLMULQDQ)"
 	depends on X86
 	select CRYPTO_HASH
 	help
-	  In Intel processor with SSE4.2 supported, the processor will
-	  support CRC32C implementation using hardware accelerated CRC32
-	  instruction. This option will create 'crc32c-intel' module,
-	  which will enable any routine to use the CRC32 instruction to
-	  gain performance compared with software implementation.
+	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
+
+	  Architecture: x86 (32-bit and 64-bit) using:
+	  * SSE4.2 (Streaming SIMD Extensions 4.2 - CRC32 instruction)
+	  * PCLMULQDQ (carry-less multiplication)
+
 	  Module will be crc32c-intel.
 
 config CRYPTO_CRC32C_VPMSUM
-	tristate "CRC32c CRC algorithm (powerpc64)"
+	tristate "CRC32c (powerpc64)"
 	depends on PPC64 && ALTIVEC
 	select CRYPTO_HASH
 	select CRC32
 	help
-	  CRC32c algorithm implemented using vector polynomial multiply-sum
-	  (vpmsum) instructions, introduced in POWER8. Enable on POWER8
-	  and newer processors for improved performance.
+	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
+
+	  Architecture: powerpc64 using AltiVec extensions
+
+	  Enable on POWER8 and newer processors for improved performance.
 
 config CRYPTO_CRC32C_SPARC64
-	tristate "CRC32c CRC algorithm (SPARC64)"
+	tristate "CRC32c (SPARC64)"
 	depends on SPARC64
 	select CRYPTO_HASH
 	select CRC32
 	help
-	  CRC32c CRC algorithm implemented using sparc64 crypto instructions,
-	  when available.
+	  CRC32c CRC algorithm with the iSCSI polynomial (RFC 3385 and RFC 3720)
+
+	  Architecture: sparc64
 
 config CRYPTO_CRC32
-	tristate "CRC32 CRC algorithm"
+	tristate "CRC32"
 	select CRYPTO_HASH
 	select CRC32
 	help
-	  CRC-32-IEEE 802.3 cyclic redundancy-check algorithm.
+	  CRC32 CRC algorithm (IEEE 802.3)
 	  Shash crypto api wrappers to crc32_le function.
 
+	  Used by RoCEv2 and f2fs.
+
 config CRYPTO_CRC32_PCLMUL
-	tristate "CRC32 PCLMULQDQ hardware acceleration"
+	tristate "CRC32 (x86 with PCLMULQDQ)"
 	depends on X86
 	select CRYPTO_HASH
 	select CRC32
 	help
-	  From Intel Westmere and AMD Bulldozer processor with SSE4.2
-	  and PCLMULQDQ supported, the processor will support
-	  CRC32 PCLMULQDQ implementation using hardware accelerated PCLMULQDQ
-	  instruction. This option will create 'crc32-pclmul' module,
-	  which will enable any routine to use the CRC-32-IEEE 802.3 checksum
-	  and gain better performance as compared with the table implementation.
+	  CRC32 CRC algorithm (IEEE 802.3)
+
+	  Architecture: x86 (32-bit and 64-bit) using:
+	  * PCLMULQDQ (carry-less multiplication)
+
+	  Module will be crc32-pclmul.
 
 config CRYPTO_CRC32_MIPS
-	tristate "CRC32c and CRC32 CRC algorithm (MIPS)"
+	tristate "CRC32c and CRC32 (MIPS)"
 	depends on MIPS_CRC_SUPPORT
 	select CRYPTO_HASH
 	help
-	  CRC32c and CRC32 CRC algorithms implemented using mips crypto
-	  instructions, when available.
+	  CRC32c and CRC32 CRC algorithms
+
+	  Architecture: mips
 
 config CRYPTO_CRC32_S390
-	tristate "CRC-32 algorithms"
+	tristate "CRC32c and CRC32 (s390)"
 	depends on S390
 	select CRYPTO_HASH
 	select CRC32
 	help
-	  Select this option if you want to use hardware accelerated
-	  implementations of CRC algorithms.  With this option, you
-	  can optimize the computation of CRC-32 (IEEE 802.3 Ethernet)
-	  and CRC-32C (Castagnoli).
+	  CRC32c and CRC32 CRC algorithms
+
+	  Architecture: s390
 
 	  It is available with IBM z13 or later.
 
 config CRYPTO_XXHASH
-	tristate "xxHash hash algorithm"
+	tristate "xxHash"
 	select CRYPTO_HASH
 	select XXHASH
 	help
-	  xxHash non-cryptographic hash algorithm. Extremely fast, working at
-	  speeds close to RAM limits.
+	  xxHash non-cryptographic hash algorithm
+
+	  Extremely fast, working at speeds close to RAM limits.
+
+	  Used by the btrfs filesystem.
 
 config CRYPTO_BLAKE2B
-	tristate "BLAKE2b digest algorithm"
+	tristate "BLAKE2b"
 	select CRYPTO_HASH
 	help
-	  Implementation of cryptographic hash function BLAKE2b (or just BLAKE2),
-	  optimized for 64bit platforms and can produce digests of any size
-	  between 1 to 64.  The keyed hash is also implemented.
+	  BLAKE2b cryptographic hash function (RFC 7693)
 
-	  This module provides the following algorithms:
+	  BLAKE2b is optimized for 64-bit platforms and can produce digests
+	  of any size between 1 and 64 bytes. The keyed hash is also implemented.
 
+	  This module provides the following algorithms:
 	  - blake2b-160
 	  - blake2b-256
 	  - blake2b-384
@@ -741,371 +754,407 @@ menu "Digests"
 
 	  See https://blake2.net for further information.
 
+	  Used by the btrfs filesystem.
+
 config CRYPTO_BLAKE2S
-	tristate "BLAKE2s digest algorithm"
+	tristate "BLAKE2s"
 	select CRYPTO_LIB_BLAKE2S_GENERIC
 	select CRYPTO_HASH
 	help
-	  Implementation of cryptographic hash function BLAKE2s
-	  optimized for 8-32bit platforms and can produce digests of any size
-	  between 1 to 32.  The keyed hash is also implemented.
+	  BLAKE2s cryptographic hash function (RFC 7693)
 
-	  This module provides the following algorithms:
+	  BLAKE2s is optimized for 8 to 32-bit platforms and can produce
+	  digests of any size between 1 and 32 bytes. The keyed hash is
+	  also implemented.
 
+	  This module provides the following algorithms:
 	  - blake2s-128
 	  - blake2s-160
 	  - blake2s-224
 	  - blake2s-256
 
+	  Used by Wireguard.
+
 	  See https://blake2.net for further information.
 
 config CRYPTO_BLAKE2S_X86
-	tristate "BLAKE2s digest algorithm (x86 accelerated version)"
+	tristate "BLAKE2s (x86_64 with SSSE3/AVX-512)"
 	depends on X86 && 64BIT
 	select CRYPTO_LIB_BLAKE2S_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
+	help
+	  BLAKE2s cryptographic hash function (RFC 7693)
+
+	  Architecture: x86_64 using:
+	  * SSSE3 (Supplemental SSE3)
+	  * AVX-512 (Advanced Vector Extensions-512)
 
 config CRYPTO_CRCT10DIF
-	tristate "CRCT10DIF algorithm"
+	tristate "CRCT10DIF"
 	select CRYPTO_HASH
 	help
-	  CRC T10 Data Integrity Field computation is being cast as
-	  a crypto transform.  This allows for faster crc t10 diff
-	  transforms to be used if they are available.
+	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
+
+	  CRC algorithm used by the SCSI Block Commands standard.
 
 config CRYPTO_CRCT10DIF_PCLMUL
-	tristate "CRCT10DIF PCLMULQDQ hardware acceleration"
+	tristate "CRCT10DIF (x86_64 with PCLMULQDQ)"
 	depends on X86 && 64BIT && CRC_T10DIF
 	select CRYPTO_HASH
 	help
-	  For x86_64 processors with SSE4.2 and PCLMULQDQ supported,
-	  CRC T10 DIF PCLMULQDQ computation can be hardware
-	  accelerated PCLMULQDQ instruction. This option will create
-	  'crct10dif-pclmul' module, which is faster when computing the
-	  crct10dif checksum as compared with the generic table implementation.
+	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
+
+	  Architecture: x86_64 using:
+	  * PCLMULQDQ (carry-less multiplication)
+
+	  Module is crct10dif-pclmul.
 
 config CRYPTO_CRCT10DIF_VPMSUM
-	tristate "CRC32T10DIF powerpc64 hardware acceleration"
+	tristate "CRC32T10DIF (powerpc64)"
 	depends on PPC64 && ALTIVEC && CRC_T10DIF
 	select CRYPTO_HASH
 	help
-	  CRC10T10DIF algorithm implemented using vector polynomial
-	  multiply-sum (vpmsum) instructions, introduced in POWER8. Enable on
-	  POWER8 and newer processors for improved performance.
+	  CRC16 CRC algorithm used for the T10 (SCSI) Data Integrity Field (DIF)
+
+	  Architecture: powerpc64 using AltiVec extensions
+	  Enable on POWER8 and newer processors for improved performance.
 
 config CRYPTO_CRC64_ROCKSOFT
-	tristate "Rocksoft Model CRC64 algorithm"
+	tristate "CRC64 based on the Rocksoft Model CRC Algorithm"
 	depends on CRC64
 	select CRYPTO_HASH
+	help
+	  CRC64 CRC algorithm based on the Rocksoft Model CRC Algorithm
+
+	  Used by the NVMe implementation of T10 DIF (BLK_DEV_INTEGRITY)
+
+	  See https://zlib.net/crc_v3.txt
 
 config CRYPTO_VPMSUM_TESTER
-	tristate "Powerpc64 vpmsum hardware acceleration tester"
+	tristate "CRC32C and CRC32T10DIF vpmsum hardware acceleration tester (powerpc64)"
 	depends on CRYPTO_CRCT10DIF_VPMSUM && CRYPTO_CRC32C_VPMSUM
 	help
-	  Stress test for CRC32c and CRC-T10DIF algorithms implemented with
-	  POWER8 vpmsum instructions.
+	  Stress test for CRC32c and CRCT10DIF algorithms implemented with
+	  powerpc64 AltiVec extensions (POWER8 vpmsum instructions).
 	  Unless you are testing these algorithms, you don't need this.
 
 config CRYPTO_GHASH
-	tristate "GHASH hash function"
+	tristate "GHASH"
 	select CRYPTO_GF128MUL
 	select CRYPTO_HASH
 	help
-	  GHASH is the hash function used in GCM (Galois/Counter Mode).
-	  It is not a general-purpose cryptographic hash function.
+	  GCM GHASH function (NIST SP800-38D)
 
 config CRYPTO_POLY1305
-	tristate "Poly1305 authenticator algorithm"
+	tristate "Poly1305"
 	select CRYPTO_HASH
 	select CRYPTO_LIB_POLY1305_GENERIC
 	help
-	  Poly1305 authenticator algorithm, RFC7539.
+	  Poly1305 authenticator algorithm (RFC7539)
 
 	  Poly1305 is an authenticator algorithm designed by Daniel J. Bernstein.
 	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
 	  in IETF protocols. This is the portable C implementation of Poly1305.
 
 config CRYPTO_POLY1305_X86_64
-	tristate "Poly1305 authenticator algorithm (x86_64/SSE2/AVX2)"
+	tristate "Poly1305 (x86_64 with SSE2/AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_LIB_POLY1305_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
 	help
-	  Poly1305 authenticator algorithm, RFC7539.
+	  Poly1305 authenticator algorithm (RFC7539)
 
-	  Poly1305 is an authenticator algorithm designed by Daniel J. Bernstein.
-	  It is used for the ChaCha20-Poly1305 AEAD, specified in RFC7539 for use
-	  in IETF protocols. This is the x86_64 assembler implementation using SIMD
-	  instructions.
+	  Architecture: x86_64 using:
+	  * SSE2 (Streaming SIMD Extensions 2)
+	  * AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_POLY1305_MIPS
-	tristate "Poly1305 authenticator algorithm (MIPS optimized)"
+	tristate "Poly1305 (MIPS)"
 	depends on MIPS
 	select CRYPTO_ARCH_HAVE_LIB_POLY1305
+	help
+	  Poly1305 authenticator algorithm (RFC7539)
+
+	  Architecture: mips
 
 config CRYPTO_MD4
-	tristate "MD4 digest algorithm"
+	tristate "MD4"
 	select CRYPTO_HASH
 	help
-	  MD4 message digest algorithm (RFC1320).
+	  MD4 message digest algorithm (RFC1320)
 
 config CRYPTO_MD5
-	tristate "MD5 digest algorithm"
+	tristate "MD5"
 	select CRYPTO_HASH
 	help
-	  MD5 message digest algorithm (RFC1321).
+	  MD5 message digest algorithm (RFC1321)
 
 config CRYPTO_MD5_OCTEON
-	tristate "MD5 digest algorithm (OCTEON)"
+	tristate "MD5 (OCTEON)"
 	depends on CPU_CAVIUM_OCTEON
 	select CRYPTO_MD5
 	select CRYPTO_HASH
 	help
-	  MD5 message digest algorithm (RFC1321) implemented
-	  using OCTEON crypto instructions, when available.
+	  MD5 message digest algorithm (RFC1321)
+
+	  Architecture: OCTEON using crypto instructions, when available
 
 config CRYPTO_MD5_PPC
-	tristate "MD5 digest algorithm (PPC)"
+	tristate "MD5 (PPC)"
 	depends on PPC
 	select CRYPTO_HASH
 	help
-	  MD5 message digest algorithm (RFC1321) implemented
-	  in PPC assembler.
+	  MD5 message digest algorithm (RFC1321)
+
+	  Architecture: powerpc
 
 config CRYPTO_MD5_SPARC64
-	tristate "MD5 digest algorithm (SPARC64)"
+	tristate "MD5 (SPARC64)"
 	depends on SPARC64
 	select CRYPTO_MD5
 	select CRYPTO_HASH
 	help
-	  MD5 message digest algorithm (RFC1321) implemented
-	  using sparc64 crypto instructions, when available.
+	  MD5 message digest algorithm (RFC1321)
+
+	  Architecture: sparc64 using crypto instructions, when available
 
 config CRYPTO_MICHAEL_MIC
-	tristate "Michael MIC keyed digest algorithm"
+	tristate "Michael MIC"
 	select CRYPTO_HASH
 	help
-	  Michael MIC is used for message integrity protection in TKIP
-	  (IEEE 802.11i). This algorithm is required for TKIP, but it
-	  should not be used for other purposes because of the weakness
-	  of the algorithm.
+	  Michael MIC (Message Integrity Code) (IEEE 802.11i)
+
+	  Defined by the IEEE 802.11i TKIP (Temporal Key Integrity Protocol),
+	  known as WPA (Wif-Fi Protected Access).
+
+	  This algorithm is required for TKIP, but it should not be used for
+	  other purposes because of the weakness of the algorithm.
 
 config CRYPTO_RMD160
-	tristate "RIPEMD-160 digest algorithm"
+	tristate "RIPEMD-160"
 	select CRYPTO_HASH
 	help
-	  RIPEMD-160 (ISO/IEC 10118-3:2004).
+	  RIPEMD-160 (ISO/IEC 10118-3:2004)
 
 	  RIPEMD-160 is a 160-bit cryptographic hash function. It is intended
 	  to be used as a secure replacement for the 128-bit hash functions
-	  MD4, MD5 and it's predecessor RIPEMD
+	  MD4, MD5 and its predecessor RIPEMD
 	  (not to be confused with RIPEMD-128).
 
-	  It's speed is comparable to SHA1 and there are no known attacks
+	  Its speed is comparable to SHA1 and there are no known attacks
 	  against RIPEMD-160.
 
 	  Developed by Hans Dobbertin, Antoon Bosselaers and Bart Preneel.
-	  See <https://homes.esat.kuleuven.be/~bosselae/ripemd160.html>
+	  See https://homes.esat.kuleuven.be/~bosselae/ripemd160.html
+	  for further information.
 
 config CRYPTO_SHA1
-	tristate "SHA1 digest algorithm"
+	tristate "SHA1"
 	select CRYPTO_HASH
 	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+	  SHA-1 secure hash algorithm (FIPS 180)
 
 config CRYPTO_SHA1_SSSE3
-	tristate "SHA1 digest algorithm (SSSE3/AVX/AVX2/SHA-NI)"
+	tristate "SHA1 (x86_64 with SSSE3/AVX/AVX2/SHA-NI)"
 	depends on X86 && 64BIT
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
-	  using Supplemental SSE3 (SSSE3) instructions or Advanced Vector
-	  Extensions (AVX/AVX2) or SHA-NI(SHA Extensions New Instructions),
-	  when available.
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: x86_64 using:
+	  * SSSE3 (Supplemental SSE3)
+	  * AVX (Advanced Vector Extensions)
+	  * AVX2 (Advanced Vector Extensions 2)
+	  * SHA-NI (SHA Extensions New Instructions)
 
 config CRYPTO_SHA256_SSSE3
-	tristate "SHA256 digest algorithm (SSSE3/AVX/AVX2/SHA-NI)"
+	tristate "SHA224 and SHA256 (x86_64 with SSSE3/AVX/AVX2/SHA-NI)"
 	depends on X86 && 64BIT
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
-	  SHA-256 secure hash standard (DFIPS 180-2) implemented
-	  using Supplemental SSE3 (SSSE3) instructions, or Advanced Vector
-	  Extensions version 1 (AVX1), or Advanced Vector Extensions
-	  version 2 (AVX2) instructions, or SHA-NI (SHA Extensions New
-	  Instructions) when available.
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: x86_64 using:
+	  * SSSE3 (Supplemental SSE3)
+	  * AVX (Advanced Vector Extensions)
+	  * AVX2 (Advanced Vector Extensions 2)
+	  * SHA-NI (SHA Extensions New Instructions)
 
 config CRYPTO_SHA512_SSSE3
-	tristate "SHA512 digest algorithm (SSSE3/AVX/AVX2)"
+	tristate "SHA384 and SHA512 (x86_64 with SSSE3/AVX/AVX2)"
 	depends on X86 && 64BIT
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
-	  SHA-512 secure hash standard (DFIPS 180-2) implemented
-	  using Supplemental SSE3 (SSSE3) instructions, or Advanced Vector
-	  Extensions version 1 (AVX1), or Advanced Vector Extensions
-	  version 2 (AVX2) instructions, when available.
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: x86_64 using:
+	  * SSSE3 (Supplemental SSE3)
+	  * AVX (Advanced Vector Extensions)
+	  * AVX2 (Advanced Vector Extensions 2)
 
 config CRYPTO_SHA512_S390
-	tristate "SHA384 and SHA512 digest algorithm"
+	tristate "SHA384 and SHA512 (s390)"
 	depends on S390
 	select CRYPTO_HASH
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA512 secure hash standard.
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: s390
 
 	  It is available as of z10.
 
 config CRYPTO_SHA1_OCTEON
-	tristate "SHA1 digest algorithm (OCTEON)"
+	tristate "SHA1 (OCTEON)"
 	depends on CPU_CAVIUM_OCTEON
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
-	  using OCTEON crypto instructions, when available.
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: OCTEON
 
 config CRYPTO_SHA1_SPARC64
-	tristate "SHA1 digest algorithm (SPARC64)"
+	tristate "SHA1 (SPARC64)"
 	depends on SPARC64
 	select CRYPTO_SHA1
 	select CRYPTO_HASH
 	help
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2) implemented
-	  using sparc64 crypto instructions, when available.
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: sparc64
 
 config CRYPTO_SHA1_PPC
-	tristate "SHA1 digest algorithm (powerpc)"
+	tristate "SHA1 (powerpc)"
 	depends on PPC
 	help
-	  This is the powerpc hardware accelerated implementation of the
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: powerpc
 
 config CRYPTO_SHA1_PPC_SPE
-	tristate "SHA1 digest algorithm (PPC SPE)"
+	tristate "SHA1 (PPC SPE)"
 	depends on PPC && SPE
 	help
-	  SHA-1 secure hash standard (DFIPS 180-4) implemented
-	  using powerpc SPE SIMD instruction set.
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: powerpc using SPE (Signal Processing Engine) extensions
 
 config CRYPTO_SHA1_S390
-	tristate "SHA1 digest algorithm"
+	tristate "SHA1 (s390)"
 	depends on S390
 	select CRYPTO_HASH
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA-1 secure hash standard (FIPS 180-1/DFIPS 180-2).
+	  SHA-1 secure hash algorithm (FIPS 180)
+
+	  Architecture: s390
 
 	  It is available as of z990.
 
 config CRYPTO_SHA256
-	tristate "SHA224 and SHA256 digest algorithm"
+	tristate "SHA224 and SHA256"
 	select CRYPTO_HASH
 	select CRYPTO_LIB_SHA256
 	help
-	  SHA256 secure hash standard (DFIPS 180-2).
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180).
 
-	  This version of SHA implements a 256 bit hash with 128 bits of
-	  security against collision attacks.
-
-	  This code also includes SHA-224, a 224 bit hash with 112 bits
-	  of security against collision attacks.
+	  This is required for IPsec AH (XFRM_AH) and IPsec ESP (XFRM_ESP).
+	  Used by the btrfs filesystem, Ceph, NFS, and SMB.
 
 config CRYPTO_SHA256_PPC_SPE
-	tristate "SHA224 and SHA256 digest algorithm (PPC SPE)"
+	tristate "SHA224 and SHA256 (PPC SPE)"
 	depends on PPC && SPE
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
-	  SHA224 and SHA256 secure hash standard (DFIPS 180-2)
-	  implemented using powerpc SPE SIMD instruction set.
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: powerpc using SPE (Signal Processing Engine) extensions
 
 config CRYPTO_SHA256_OCTEON
-	tristate "SHA224 and SHA256 digest algorithm (OCTEON)"
+	tristate "SHA224 and SHA256 (OCTEON)"
 	depends on CPU_CAVIUM_OCTEON
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
-	  SHA-256 secure hash standard (DFIPS 180-2) implemented
-	  using OCTEON crypto instructions, when available.
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: OCTEON using crypto instructions, when available
 
 config CRYPTO_SHA256_SPARC64
-	tristate "SHA224 and SHA256 digest algorithm (SPARC64)"
+	tristate "SHA224 and SHA256 (SPARC64)"
 	depends on SPARC64
 	select CRYPTO_SHA256
 	select CRYPTO_HASH
 	help
-	  SHA-256 secure hash standard (DFIPS 180-2) implemented
-	  using sparc64 crypto instructions, when available.
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: sparc64 using crypto instructions, when available
 
 config CRYPTO_SHA256_S390
-	tristate "SHA256 digest algorithm"
+	tristate "SHA224 and SHA256 (s390)"
 	depends on S390
 	select CRYPTO_HASH
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA256 secure hash standard (DFIPS 180-2).
+	  SHA-224 and SHA-256 secure hash algorithms (FIPS 180)
+
+	  Architecture: s390
 
 	  It is available as of z9.
 
 config CRYPTO_SHA512
-	tristate "SHA384 and SHA512 digest algorithms"
+	tristate "SHA384 and SHA512"
 	select CRYPTO_HASH
 	help
-	  SHA512 secure hash standard (DFIPS 180-2).
-
-	  This version of SHA implements a 512 bit hash with 256 bits of
-	  security against collision attacks.
-
-	  This code also includes SHA-384, a 384 bit hash with 192 bits
-	  of security against collision attacks.
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
 
 config CRYPTO_SHA512_OCTEON
-	tristate "SHA384 and SHA512 digest algorithms (OCTEON)"
+	tristate "SHA384 and SHA512 (OCTEON)"
 	depends on CPU_CAVIUM_OCTEON
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
-	  SHA-512 secure hash standard (DFIPS 180-2) implemented
-	  using OCTEON crypto instructions, when available.
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: OCTEON using crypto instructions, when available
 
 config CRYPTO_SHA512_SPARC64
-	tristate "SHA384 and SHA512 digest algorithm (SPARC64)"
+	tristate "SHA384 and SHA512 (SPARC64)"
 	depends on SPARC64
 	select CRYPTO_SHA512
 	select CRYPTO_HASH
 	help
-	  SHA-512 secure hash standard (DFIPS 180-2) implemented
-	  using sparc64 crypto instructions, when available.
+	  SHA-384 and SHA-512 secure hash algorithms (FIPS 180)
+
+	  Architecture: sparc64 using crypto instructions, when available
 
 config CRYPTO_SHA3
-	tristate "SHA3 digest algorithm"
+	tristate "SHA3"
 	select CRYPTO_HASH
 	help
-	  SHA-3 secure hash standard (DFIPS 202). It's based on
-	  cryptographic sponge function family called Keccak.
-
-	  References:
-	  http://keccak.noekeon.org/
+	  SHA-3 secure hash algorithms (FIPS 202)
 
 config CRYPTO_SHA3_256_S390
-	tristate "SHA3_224 and SHA3_256 digest algorithm"
+	tristate "SHA3_224 and SHA3_256 (s390)"
 	depends on S390
 	select CRYPTO_HASH
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA3_256 secure hash standard.
+	  SHA3-224 and SHA3-256 hash functions (FIPS 202)
+
+	  Architecture: s390
 
 	  It is available as of z14.
 
 config CRYPTO_SHA3_512_S390
-	tristate "SHA3_384 and SHA3_512 digest algorithm"
+	tristate "SHA3_384 and SHA3_512 (s390)"
 	depends on S390
 	select CRYPTO_HASH
 	help
-	  This is the s390 hardware accelerated implementation of the
-	  SHA3_512 secure hash standard.
+	  SHA3-384 and SHA3-512 hash functions (FIPS 202)
+
+	  Architecture: s390
 
 	  It is available as of z14.
 
@@ -1113,44 +1162,47 @@ menu "Digests"
 	tristate
 
 config CRYPTO_SM3_GENERIC
-	tristate "SM3 digest algorithm"
+	tristate "SM3 (ShangMi 3)"
 	select CRYPTO_HASH
 	select CRYPTO_SM3
 	help
-	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3).
-	  It is part of the Chinese Commercial Cryptography suite.
+	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3
+
+	  This is part of the Chinese Commercial Cryptography suite.
 
 	  References:
 	  http://www.oscca.gov.cn/UpFile/20101222141857786.pdf
 	  https://datatracker.ietf.org/doc/html/draft-shen-sm3-hash
 
 config CRYPTO_SM3_AVX_X86_64
-	tristate "SM3 digest algorithm (x86_64/AVX)"
+	tristate "SM3 (ShangMi 3) (x86_64 with AVX)"
 	depends on X86 && 64BIT
 	select CRYPTO_HASH
 	select CRYPTO_SM3
 	help
-	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3).
-	  It is part of the Chinese Commercial Cryptography suite. This is
-	  SM3 optimized implementation using Advanced Vector Extensions (AVX)
-	  when available.
+	  SM3 secure hash function as defined by OSCCA GM/T 0004-2012 SM3
+
+	  Architecture: x86_64 using:
+	  * AVX (Advanced Vector Extensions)
 
 	  If unsure, say N.
 
 config CRYPTO_STREEBOG
-	tristate "Streebog Hash Function"
+	tristate "Streebog (GOST 34.11)"
 	select CRYPTO_HASH
 	help
-	  Streebog Hash Function (GOST R 34.11-2012, RFC 6986) is one of the Russian
-	  cryptographic standard algorithms (called GOST algorithms).
-	  This setting enables two hash algorithms with 256 and 512 bits output.
+	  Streebog Hash Function (GOST R 34.11-2012, RFC 6986)
+
+	  This is one of the Russian cryptographic standard algorithms (called
+	  GOST algorithms). This setting enables two hash algorithms with
+	  256 and 512 bits output.
 
 	  References:
 	  https://tc26.ru/upload/iblock/fed/feddbb4d26b685903faa2ba11aea43f6.pdf
 	  https://tools.ietf.org/html/rfc6986
 
 config CRYPTO_WP512
-	tristate "Whirlpool digest algorithms"
+	tristate "Whirlpool"
 	select CRYPTO_HASH
 	help
 	  Whirlpool hash algorithm 512, 384 and 256-bit hashes
@@ -1158,24 +1210,27 @@ menu "Digests"
 	  Whirlpool-512 is part of the NESSIE cryptographic primitives.
 	  Whirlpool will be part of the ISO/IEC 10118-3:2003(E) standard
 
-	  See also:
-	  <http://www.larc.usp.br/~pbarreto/WhirlpoolPage.html>
+	  See https://web.archive.org/web/20171129084214/http://www.larc.usp.br/~pbarreto/WhirlpoolPage.html
+	  for further information.
 
 config CRYPTO_GHASH_CLMUL_NI_INTEL
-	tristate "GHASH hash function (CLMUL-NI accelerated)"
+	tristate "GHASH (x86_64 with CLMUL-NI)"
 	depends on X86 && 64BIT
 	select CRYPTO_CRYPTD
 	help
-	  This is the x86_64 CLMUL-NI accelerated implementation of
-	  GHASH, the hash function used in GCM (Galois/Counter mode).
+	  GCM GHASH hash function (NIST SP800-38D)
+
+	  Architecture: x86_64 using:
+	  * CLMUL-NI (carry-less multiplication new instructions)
 
 config CRYPTO_GHASH_S390
-	tristate "GHASH hash function"
+	tristate "GHASH (s390)"
 	depends on S390
 	select CRYPTO_HASH
 	help
-	  This is the s390 hardware accelerated implementation of GHASH,
-	  the hash function used in GCM (Galois/Counter mode).
+	  GCM GHASH hash function (NIST SP800-38D)
+
+	  Architecture: s390
 
 	  It is available as of z196.
 
-- 
2.37.1

