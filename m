Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E61B5822B4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiG0JGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiG0JF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:05:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99ACF4333D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 02:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658912757; x=1690448757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CIUopwxdZIlwqjXMsHY6dSEUUehkgUCOaiTv2Ru/m5M=;
  b=Xn+4mlvMguuQUXijWrHjsZSnnvXbR57GoS/g/+E6R7o3w0+ZmZ5Ozo9v
   fMo2Wlqkz6ktxAtaanfHhhvXpztqFWsRVYTw6Ox2NJXezXTYQtG+HN9eV
   Q2OizPhtN1DZs3ydwEvo4fdEvq1CoUj9NWdQ/HtQMcuOGH+8YEKi+igdl
   +fVzlWUdIJLl+SmuH5rgTR2cyW+wXKffhOdKUMpml1cHumCX8qzg39k8b
   mSByFyA8QXokn+l1YZidGBnrJUMOsmCCR7kxwddo4YqlHElZ5a/Fpg7Qd
   U2R2vz5y+EOO2gCRM9im8zgRRGbAFi6Un8xh2D0NGoEKSwUnt9wIlds6G
   w==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="169710970"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 02:05:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 27 Jul 2022 02:05:56 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 27 Jul 2022 02:05:54 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 2/2] ASoC: mchp-spdiftx: remove references to mchp_i2s_caps
Date:   Wed, 27 Jul 2022 12:08:14 +0300
Message-ID: <20220727090814.2446111-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220727090814.2446111-1-claudiu.beznea@microchip.com>
References: <20220727090814.2446111-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove references to struct mchp_i2s_caps as they are not used.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdiftx.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index cb4d0140dfe0..4850a177803d 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -196,7 +196,6 @@ struct mchp_spdiftx_dev {
 	struct clk				*pclk;
 	struct clk				*gclk;
 	unsigned int				fmt;
-	const struct mchp_i2s_caps		*caps;
 	int					gclk_enabled:1;
 };
 
@@ -765,8 +764,6 @@ MODULE_DEVICE_TABLE(of, mchp_spdiftx_dt_ids);
 
 static int mchp_spdiftx_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	struct mchp_spdiftx_dev *dev;
 	struct resource *mem;
 	struct regmap *regmap;
@@ -780,11 +777,6 @@ static int mchp_spdiftx_probe(struct platform_device *pdev)
 	if (!dev)
 		return -ENOMEM;
 
-	/* Get hardware capabilities. */
-	match = of_match_node(mchp_spdiftx_dt_ids, np);
-	if (match)
-		dev->caps = match->data;
-
 	/* Map I/O registers. */
 	base = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
 	if (IS_ERR(base))
-- 
2.34.1

