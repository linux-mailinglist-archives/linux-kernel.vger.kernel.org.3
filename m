Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101BE4B4895
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 10:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345485AbiBNJ4r convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 04:56:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344915AbiBNJwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 04:52:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40C26D39F;
        Mon, 14 Feb 2022 01:43:24 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21E8UM9r022252;
        Mon, 14 Feb 2022 09:42:45 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e6rt10krx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 09:42:44 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21E9aDv8025445;
        Mon, 14 Feb 2022 09:42:42 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3e64h92qwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Feb 2022 09:42:42 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21E9gee032047572
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Feb 2022 09:42:40 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E2D43AE053;
        Mon, 14 Feb 2022 09:42:39 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49CD8AE051;
        Mon, 14 Feb 2022 09:42:39 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Mon, 14 Feb 2022 09:42:39 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.60.190])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id D05AE2201E5;
        Mon, 14 Feb 2022 10:42:37 +0100 (CET)
From:   =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org
Cc:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 01/10] mtd: spi-nor: aspeed: Rename Kconfig option
Date:   Mon, 14 Feb 2022 10:42:22 +0100
Message-Id: <20220214094231.3753686-2-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214094231.3753686-1-clg@kaod.org>
References: <20220214094231.3753686-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gX7JK45671uxdo1i3RwU_vYpKq31PP3t
X-Proofpoint-ORIG-GUID: gX7JK45671uxdo1i3RwU_vYpKq31PP3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-14_01,2022-02-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=703
 impostorscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 clxscore=1034 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202140058
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prepare transition to the new Aspeed SMC SPI controller driver using
the spi-mem interface, change the kernel CONFIG option of the current
driver to reflect that the implementation uses the MTD SPI-NOR interface.
Once the new driver is sufficiently exposed, we should remove the old one.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 arch/arm/configs/aspeed_g4_defconfig     | 2 +-
 arch/arm/configs/aspeed_g5_defconfig     | 2 +-
 arch/arm/configs/multi_v5_defconfig      | 2 +-
 arch/arm/configs/multi_v7_defconfig      | 2 +-
 drivers/mtd/spi-nor/controllers/Kconfig  | 2 +-
 drivers/mtd/spi-nor/controllers/Makefile | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index b4a1b2ed1a17..964536444cd7 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -64,7 +64,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_PARTITIONED_MASTER=y
 CONFIG_MTD_SPI_NOR=y
 # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
-CONFIG_SPI_ASPEED_SMC=y
+CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_BLOCK=y
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index ccc4240ee4b5..e809236ca88b 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -103,7 +103,7 @@ CONFIG_MTD_BLOCK=y
 CONFIG_MTD_PARTITIONED_MASTER=y
 CONFIG_MTD_SPI_NOR=y
 # CONFIG_MTD_SPI_NOR_USE_4K_SECTORS is not set
-CONFIG_SPI_ASPEED_SMC=y
+CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_MTD_UBI_BLOCK=y
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 80a3ae02d759..49083ef05fb0 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -103,7 +103,7 @@ CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_NAND_ATMEL=y
 CONFIG_MTD_NAND_ORION=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_SPI_ASPEED_SMC=y
+CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=y
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_ATMEL_SSC=m
diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 33572998dbbe..fc1b69256b64 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -217,7 +217,7 @@ CONFIG_MTD_NAND_DAVINCI=y
 CONFIG_MTD_NAND_STM32_FMC2=y
 CONFIG_MTD_NAND_PL35X=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_SPI_ASPEED_SMC=m
+CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR=m
 CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
diff --git a/drivers/mtd/spi-nor/controllers/Kconfig b/drivers/mtd/spi-nor/controllers/Kconfig
index 5c0e0ec2e6d1..876a47042fec 100644
--- a/drivers/mtd/spi-nor/controllers/Kconfig
+++ b/drivers/mtd/spi-nor/controllers/Kconfig
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config SPI_ASPEED_SMC
+config SPI_ASPEED_SMC_MTD_SPI_NOR
 	tristate "Aspeed flash controllers in SPI mode"
 	depends on ARCH_ASPEED || COMPILE_TEST
 	depends on HAS_IOMEM && OF
diff --git a/drivers/mtd/spi-nor/controllers/Makefile b/drivers/mtd/spi-nor/controllers/Makefile
index e7abba491d98..1e28297fb1e8 100644
--- a/drivers/mtd/spi-nor/controllers/Makefile
+++ b/drivers/mtd/spi-nor/controllers/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_SPI_ASPEED_SMC)	+= aspeed-smc.o
+obj-$(CONFIG_SPI_ASPEED_SMC_MTD_SPI_NOR)	+= aspeed-smc.o
 obj-$(CONFIG_SPI_HISI_SFC)	+= hisi-sfc.o
 obj-$(CONFIG_SPI_NXP_SPIFI)	+= nxp-spifi.o
 obj-$(CONFIG_SPI_INTEL_SPI)	+= intel-spi.o
-- 
2.34.1

