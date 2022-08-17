Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD43F597A2C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 01:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242479AbiHQXWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 19:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242243AbiHQXV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 19:21:29 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F108A404D;
        Wed, 17 Aug 2022 16:21:24 -0700 (PDT)
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HNK2P2020374;
        Wed, 17 Aug 2022 23:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=tUbh+vNC70urocfZcuHC8mry030DvJifO41MfmcUrTc=;
 b=A6Tv8X+QInwjSu1v+gJikbG9oRSqQITJotZplfPXNy9xvS+6yWdGonWHRayLxWidAfNd
 WA4e6ImZ8DfgUwiaMLyxFLm1lvhrHR3oQYL8ZnbbSgqvK4v9EXPJfV1V3d3t7Cw5bjAc
 hBoBFpqQFKlFuVG1QKX0GrLO+HkIcCaOAvJn83csi6bjQEKjOkaPn3O4J5LXRvsB0GQ6
 PB14tTYJANQ4sDDx8HLjgzSy/UGrthGLiYZrJdPtLDg1/GvTOdRUB+s7Tts0B3Fv6+j2
 kLahNAUAf++vQDCmz1UgV27B/kLh6EdxvNV949iClaHntqWRGG6Dtr1wUYr8sekRo8BS 5Q== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j19wer08d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 23:21:20 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 8E62D8001AE;
        Wed, 17 Aug 2022 23:21:19 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 43D8B803ADE;
        Wed, 17 Aug 2022 23:21:19 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v2 07/10] crypto: Kconfig - move arm and arm64 menus to Crypto API page
Date:   Wed, 17 Aug 2022 18:20:54 -0500
Message-Id: <20220817232057.73643-8-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220817232057.73643-1-elliott@hpe.com>
References: <20220815190608.47182-9-elliott@hpe.com>
 <20220817232057.73643-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4rvn-bmJZa3fo7lhd-Xz4H-rY5tZYFLe
X-Proofpoint-ORIG-GUID: 4rvn-bmJZa3fo7lhd-Xz4H-rY5tZYFLe
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_15,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=840 clxscore=1015 mlxscore=0
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

Move ARM- and ARM64-accelerated menus into a submenu under
the Crypto API menu (paralleling all the architectures).

Make each submenu always appear if the corresponding architecture
is supported. Get rid of the ARM_CRYPTO and ARM64_CRYPTO symbols.

The "ARM Accelerated" or "ARM64 Accelerated" entry disappears from:
    General setup  --->
    Platform selection  --->
    Kernel Features  --->
    Boot options  --->
    Power management options  --->
    CPU Power Management  --->
[*] ACPI (Advanced Configuration and Power Interface) Support  --->
[*] Virtualization  --->
[*] ARM Accelerated Cryptographic Algorithms  --->
     (or)
[*] ARM64 Accelerated Cryptographic Algorithms  --->
    ...
-*- Cryptographic API  --->
    Library routines  --->
    Kernel hacking  --->

and moves into the Cryptographic API menu, which now contains:
      ...
      Accelerated Cryptographic Algorithms for CPU (arm) --->
      (or)
      Accelerated Cryptographic Algorithms for CPU (arm64) --->
[*]   Hardware crypto devices  --->
      ...

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Robert Elliott <elliott@hpe.com>
---
 arch/arm/Kconfig                         |  4 ----
 arch/arm/configs/exynos_defconfig        |  1 -
 arch/arm/configs/milbeaut_m10v_defconfig |  1 -
 arch/arm/configs/multi_v7_defconfig      |  1 -
 arch/arm/configs/omap2plus_defconfig     |  1 -
 arch/arm/configs/pxa_defconfig           |  1 -
 arch/arm/crypto/Kconfig                  | 11 ++---------
 arch/arm64/Kconfig                       |  3 ---
 arch/arm64/configs/defconfig             |  1 -
 arch/arm64/crypto/Kconfig                | 11 ++---------
 crypto/Kconfig                           |  6 ++++++
 drivers/crypto/Kconfig                   |  1 -
 drivers/net/Kconfig                      |  2 --
 13 files changed, 10 insertions(+), 34 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7630ba9cb6cc..2b42c6ece2de 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1903,8 +1903,4 @@ menu "Power management options"
 
 endmenu
 
-if CRYPTO
-source "arch/arm/crypto/Kconfig"
-endif
-
 source "arch/arm/Kconfig.assembler"
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index aa061074db78..4ac1f1dcb429 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -34,7 +34,6 @@ CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_ADVANCED_DEBUG=y
-CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
index 7c07f9893a0f..ab0acf1e0a71 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -46,7 +46,6 @@ CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_EFI_VARS=m
 CONFIG_EFI_CAPSULE_LOADER=m
-CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA1_ARM_CE=m
 CONFIG_CRYPTO_SHA2_ARM_CE=m
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index ce9826bce29b..ef6e2f9c3288 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -135,7 +135,6 @@ CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_BCM47XX_NVRAM=y
 CONFIG_BCM47XX_SPROM=y
 CONFIG_EFI_CAPSULE_LOADER=m
-CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA1_ARM_CE=m
 CONFIG_CRYPTO_SHA2_ARM_CE=m
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 9380df6b530f..85cd9d232f8d 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -54,7 +54,6 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_PM_DEBUG=y
-CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 1db70dfd32d2..a97f9aca572c 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -743,7 +743,6 @@ CONFIG_CRYPTO_TEA=m
 CONFIG_CRYPTO_TWOFISH=m
 CONFIG_CRYPTO_DEFLATE=y
 CONFIG_CRYPTO_LZO=y
-CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM=m
 CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index e4dba5461cb3..f6edc8f19d17 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -1,13 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-menuconfig ARM_CRYPTO
-	bool "ARM Accelerated Cryptographic Algorithms"
-	depends on ARM
-	help
-	  Say Y here to choose from a selection of cryptographic algorithms
-	  implemented using ARM specific CPU features or instructions.
-
-if ARM_CRYPTO
+menu "Accelerated Cryptographic Algorithms for CPU (arm)"
 
 config CRYPTO_SHA1_ARM
 	tristate "SHA1 digest algorithm (ARM-asm)"
@@ -170,4 +163,4 @@ menuconfig ARM_CRYPTO
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
 
-endif
+endmenu
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1652a9800ebe..78af1ffaa252 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2186,6 +2186,3 @@ menu "CPU Power Management"
 
 source "arch/arm64/kvm/Kconfig"
 
-if CRYPTO
-source "arch/arm64/crypto/Kconfig"
-endif # CRYPTO
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d1105343bc2..eac6f5bf4dea 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -108,7 +108,6 @@ CONFIG_ACPI_APEI_MEMORY_FAILURE=y
 CONFIG_ACPI_APEI_EINJ=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=y
-CONFIG_ARM64_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM64_CE=y
 CONFIG_CRYPTO_SHA2_ARM64_CE=y
 CONFIG_CRYPTO_SHA512_ARM64_CE=m
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index ac85682c013c..5b4d4bfb0356 100644
--- a/arch/arm64/crypto/Kconfig
+++ b/arch/arm64/crypto/Kconfig
@@ -1,13 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-menuconfig ARM64_CRYPTO
-	bool "ARM64 Accelerated Cryptographic Algorithms"
-	depends on ARM64
-	help
-	  Say Y here to choose from a selection of cryptographic algorithms
-	  implemented using ARM64 specific CPU features or instructions.
-
-if ARM64_CRYPTO
+menu "Accelerated Cryptographic Algorithms for CPU (arm64)"
 
 config CRYPTO_SHA256_ARM64
 	tristate "SHA-224/SHA-256 digest algorithm for arm64"
@@ -132,4 +125,4 @@ menuconfig ARM64_CRYPTO
 	select CRYPTO_AES_ARM64_NEON_BLK
 	select CRYPTO_LIB_AES
 
-endif
+endmenu
diff --git a/crypto/Kconfig b/crypto/Kconfig
index f24ba726af25..b61626bf8ee2 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1245,6 +1245,12 @@ menuconfig CRYPTO_DRBG_MENU
 config CRYPTO_HASH_INFO
 	bool
 
+if ARM
+source "arch/arm/crypto/Kconfig"
+endif
+if ARM64
+source "arch/arm64/crypto/Kconfig"
+endif
 if MIPS
 source "arch/mips/crypto/Kconfig"
 endif
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 9728874f66a0..06c71b6da07e 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -802,7 +802,6 @@ menuconfig CRYPTO_HW
 config CRYPTO_DEV_SA2UL
 	tristate "Support for TI security accelerator"
 	depends on ARCH_K3 || COMPILE_TEST
-	select ARM64_CRYPTO
 	select CRYPTO_AES
 	select CRYPTO_ALGAPI
 	select CRYPTO_AUTHENC
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 8c1eeb5a8db8..c94733b0b10f 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -85,8 +85,6 @@ menuconfig NETDEVICES
 	select CRYPTO_POLY1305_X86_64 if X86 && 64BIT
 	select CRYPTO_BLAKE2S_X86 if X86 && 64BIT
 	select CRYPTO_CURVE25519_X86 if X86 && 64BIT
-	select ARM_CRYPTO if ARM
-	select ARM64_CRYPTO if ARM64
 	select CRYPTO_CHACHA20_NEON if ARM || (ARM64 && KERNEL_MODE_NEON)
 	select CRYPTO_POLY1305_NEON if ARM64 && KERNEL_MODE_NEON
 	select CRYPTO_POLY1305_ARM if ARM
-- 
2.37.1

