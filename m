Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BEF56660B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiGEJ0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiGEJ0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:26:50 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D98F10C5;
        Tue,  5 Jul 2022 02:26:50 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C0D3E1A0AF1;
        Tue,  5 Jul 2022 11:26:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 886031A0AEC;
        Tue,  5 Jul 2022 11:26:48 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DA4FF1802204;
        Tue,  5 Jul 2022 17:26:45 +0800 (+08)
From:   haibo.chen@nxp.com
To:     ashish.kumar@nxp.com, yogeshgaur.83@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        han.xu@nxp.com, singh.kuldeep87k@gmail.com,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, haibo.chen@nxp.com,
        zhengxunli@mxic.com.tw
Subject: [PATCH 02/11] spi: spi-nxp-fspi: change the default lut index
Date:   Tue,  5 Jul 2022 17:11:34 +0800
Message-Id: <1657012303-6464-2-git-send-email-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
References: <1657012303-6464-1-git-send-email-haibo.chen@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Haibo Chen <haibo.chen@nxp.com>

The fspi dynamic lut use the last lut for all IPS operations, the
imx8ulp only supports 15 luts, so change the last lut index from
31 to 15.

Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/spi/spi-nxp-fspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index b2cd8e06f374..10e71e55d21a 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -65,9 +65,9 @@
 /*
  * The driver only uses one single LUT entry, that is updated on
  * each call of exec_op(). Index 0 is preset at boot with a basic
- * read operation, so let's use the last entry (31).
+ * read operation, so let's use the last entry (15).
  */
-#define	SEQID_LUT			31
+#define	SEQID_LUT			15
 
 /* Registers used by the driver */
 #define FSPI_MCR0			0x00
-- 
2.25.1

