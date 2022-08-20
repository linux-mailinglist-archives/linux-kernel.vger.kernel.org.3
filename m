Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355CC59AFBF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 20:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbiHTSmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 14:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiHTSmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:42:21 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA814457A;
        Sat, 20 Aug 2022 11:42:20 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27KAHgN3026061;
        Sat, 20 Aug 2022 18:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=i2LNk7/NNEHXTzr3jg1Oihp3c2bfrSPZe0g74y06eyA=;
 b=eFE1EsmYDfdpHpybWKtLw2kW8Bim/zH1WiX+HnIv9xq4NQ77ycP2gYrCJSeyOsQWqOZe
 7TDUvpiYDpPD6eB6rvXxQC7K9HFtKOgzwnZAlecedM5kS4PTpbGbDIW+32IaV6P96aSv
 +MrixOT3na4XZ4i6eVX5MbUOMoa48AcTKT+Q5jtun1c3sr295fat9H58PXwQ+pSw8wbQ
 fhFukRzoTrlV5uLXkdpmL8mTYsQTl4kGk97W5HNsfjFpASS4BQZjYUg1RPtdi1a2RwTA
 K3pdM3BDnagi3Gn3wWNwBA5QHuwR9Y67iAyYTe0a6BprYP9DVJsyS/HkdR1SMrexPAEV Vw== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3j2wqs259m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 18:42:14 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id CC8D7804CB7;
        Sat, 20 Aug 2022 18:42:13 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 7BD28803510;
        Sat, 20 Aug 2022 18:42:13 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v3 07/17] crypto: Kconfig - submenus for arm and arm64
Date:   Sat, 20 Aug 2022 13:41:41 -0500
Message-Id: <20220820184151.1149247-8-elliott@hpe.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220820184151.1149247-1-elliott@hpe.com>
References: <20220817232057.73643-1-elliott@hpe.com>
 <20220820184151.1149247-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Sn4yrX5FyX0LGZokf0rWeqNKpqNjlPhU
X-Proofpoint-GUID: Sn4yrX5FyX0LGZokf0rWeqNKpqNjlPhU
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_08,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=681 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
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
 arch/arm/crypto/Kconfig                  | 12 +++---------
 arch/arm64/Kconfig                       |  3 ---
 arch/arm64/configs/defconfig             |  1 -
 arch/arm64/crypto/Kconfig                | 12 +++---------
 crypto/Kconfig                           |  6 ++++++
 drivers/crypto/Kconfig                   |  1 -
 drivers/net/Kconfig                      |  2 --
 13 files changed, 12 insertions(+), 34 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 87badeae3181..048a4354c213 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1921,8 +1921,4 @@ config ARCH_HIBERNATION_POSSIBLE
 
 endmenu
 
-if CRYPTO
-source "arch/arm/crypto/Kconfig"
-endif
-
 source "arch/arm/Kconfig.assembler"
diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 1ce74f46e114..9d7f87cfe33a 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -32,7 +32,6 @@ CONFIG_KERNEL_MODE_NEON=y
 CONFIG_PM_DEBUG=y
 CONFIG_PM_ADVANCED_DEBUG=y
 CONFIG_ENERGY_MODEL=y
-CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
index 58810e98de3d..10503747924e 100644
--- a/arch/arm/configs/milbeaut_m10v_defconfig
+++ b/arch/arm/configs/milbeaut_m10v_defconfig
@@ -44,7 +44,6 @@ CONFIG_ARM_CPUIDLE=y
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
-CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA1_ARM_CE=m
 CONFIG_CRYPTO_SHA2_ARM_CE=m
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 12b35008571f..0b67ad28aa76 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -132,7 +132,6 @@ CONFIG_ARM_EXYNOS_CPUIDLE=y
 CONFIG_ARM_TEGRA_CPUIDLE=y
 CONFIG_ARM_QCOM_SPM_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
-CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA1_ARM_CE=m
 CONFIG_CRYPTO_SHA2_ARM_CE=m
diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 99d015cf8919..e52e2dee4415 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -53,7 +53,6 @@ CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_KERNEL_MODE_NEON=y
 CONFIG_PM_DEBUG=y
-CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM_NEON=m
 CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 104a45722799..5a2c5358bbd9 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -34,7 +34,6 @@ CONFIG_CPUFREQ_DT=m
 CONFIG_ARM_PXA2xx_CPUFREQ=m
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
-CONFIG_ARM_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM=m
 CONFIG_CRYPTO_SHA256_ARM=m
 CONFIG_CRYPTO_SHA512_ARM=m
diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index 149a5bd6b88c..b4cb519a0609 100644
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
@@ -170,4 +163,5 @@ config CRYPTO_CURVE25519_NEON
 	select CRYPTO_LIB_CURVE25519_GENERIC
 	select CRYPTO_ARCH_HAVE_LIB_CURVE25519
 
-endif
+endmenu
+
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 571cc234d0b3..91bf8e581dfe 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2215,6 +2215,3 @@ menu "CPU Power Management"
 
 source "arch/arm64/kvm/Kconfig"
 
-if CRYPTO
-source "arch/arm64/crypto/Kconfig"
-endif # CRYPTO
diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d5b2d2dd4904..e7a87f63d9d5 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -109,7 +109,6 @@ CONFIG_ACPI_APEI_MEMORY_FAILURE=y
 CONFIG_ACPI_APEI_EINJ=y
 CONFIG_VIRTUALIZATION=y
 CONFIG_KVM=y
-CONFIG_ARM64_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM64_CE=y
 CONFIG_CRYPTO_SHA2_ARM64_CE=y
 CONFIG_CRYPTO_SHA512_ARM64_CE=m
diff --git a/arch/arm64/crypto/Kconfig b/arch/arm64/crypto/Kconfig
index 60db5bb2ddda..872ab7b898e0 100644
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
@@ -138,4 +131,5 @@ config CRYPTO_AES_ARM64_BS
 	select CRYPTO_AES_ARM64_NEON_BLK
 	select CRYPTO_LIB_AES
 
-endif
+endmenu
+
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 3d029b7ca316..8711880b31a2 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1292,6 +1292,12 @@ config CRYPTO_STATS
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
@@ -802,7 +802,6 @@ config CRYPTO_DEV_CCREE
 config CRYPTO_DEV_SA2UL
 	tristate "Support for TI security accelerator"
 	depends on ARCH_K3 || COMPILE_TEST
-	select ARM64_CRYPTO
 	select CRYPTO_AES
 	select CRYPTO_ALGAPI
 	select CRYPTO_AUTHENC
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 94c889802566..0e41d2295073 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -85,8 +85,6 @@ config WIREGUARD
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

