Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5635B4CAC25
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbiCBRd4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 12:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244112AbiCBRd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:33:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530F5D4CA5;
        Wed,  2 Mar 2022 09:32:13 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 222GN1Vd006806;
        Wed, 2 Mar 2022 17:31:24 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ejc28se3y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 17:31:24 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 222HD6eq001668;
        Wed, 2 Mar 2022 17:31:21 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 3efbu9dy38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Mar 2022 17:31:21 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 222HVJ6n55771424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 2 Mar 2022 17:31:19 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11E6811C050;
        Wed,  2 Mar 2022 17:31:19 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CB8711C054;
        Wed,  2 Mar 2022 17:31:18 +0000 (GMT)
Received: from smtp.tlslab.ibm.com (unknown [9.101.4.1])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed,  2 Mar 2022 17:31:18 +0000 (GMT)
Received: from yukon.ibmuc.com (unknown [9.171.58.125])
        by smtp.tlslab.ibm.com (Postfix) with ESMTP id 07645220294;
        Wed,  2 Mar 2022 18:31:16 +0100 (CET)
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
Subject: [PATCH v2 01/10] mtd: spi-nor: aspeed: Rename Kconfig option
Date:   Wed,  2 Mar 2022 18:31:05 +0100
Message-Id: <20220302173114.927476-2-clg@kaod.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220302173114.927476-1-clg@kaod.org>
References: <20220302173114.927476-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5kqQgAyvQhzzbyqq2PnBEY-w7m14ksG1
X-Proofpoint-GUID: 5kqQgAyvQhzzbyqq2PnBEY-w7m14ksG1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_12,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 clxscore=1034 mlxscore=0 suspectscore=0
 mlxlogscore=694 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020076
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
 drivers/mtd/spi-nor/controllers/Kconfig  | 2 +-
 drivers/mtd/spi-nor/controllers/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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

