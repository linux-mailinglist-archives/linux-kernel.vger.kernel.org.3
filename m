Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C047057FF87
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235471AbiGYNHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235437AbiGYNH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:07:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5CD13D61
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658754438; x=1690290438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YaWb7yZxkGG+zBnJL2IFm2f4uUx2GkI4cjt6VNqnQM4=;
  b=vSMnsR0y+gO2hdGH38n8DdLa2TnTU+fT3vUTV6Y1QPlMkWG0Th42GCjW
   l7Yvjw0AiQdv9rK8RwYNqjtL2x7MZbvIYSR4J7TIr7axRa4J33LGmD7A+
   YQRIc1EQgVnEwPVX3DM4rPtVUpCD6UPIQeVzJAG7idUEeCvs0jYeeF0mO
   BahTkgN0tMr5akN2q2KfJqAQHZePGXPe5Ebqe7ggigLzxLKVkSAxbvAJ8
   CcxOADmuALwxpxLQ+TPjWGtlHNSIXU1JfyX8yEjbb1iVqKA7yX1R3rptx
   OBdLmMa6uBSd78OSnnlZB3yi/y4MGQxov6nqk3cX4mI/sDr+WlpI1kQaq
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="173519429"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2022 06:07:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 06:07:10 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 25 Jul 2022 06:07:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 3/5] ASoC: mchp-spdiftx: remove references to mchp_i2s_caps
Date:   Mon, 25 Jul 2022 16:09:23 +0300
Message-ID: <20220725130925.1781791-4-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220725130925.1781791-1-claudiu.beznea@microchip.com>
References: <20220725130925.1781791-1-claudiu.beznea@microchip.com>
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
 sound/soc/atmel/mchp-spdiftx.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index 78d5bcf0819a..20e77b374f7e 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -196,7 +196,6 @@ struct mchp_spdiftx_dev {
 	struct clk				*pclk;
 	struct clk				*gclk;
 	unsigned int				fmt;
-	const struct mchp_i2s_caps		*caps;
 	int					gclk_enabled:1;
 };
 
@@ -768,7 +767,6 @@ MODULE_DEVICE_TABLE(of, mchp_spdiftx_dt_ids);
 static int mchp_spdiftx_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	const struct of_device_id *match;
 	struct mchp_spdiftx_dev *dev;
 	struct resource *mem;
 	struct regmap *regmap;
@@ -782,11 +780,6 @@ static int mchp_spdiftx_probe(struct platform_device *pdev)
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

