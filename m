Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B0257FF86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbiGYNH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiGYNH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:07:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DDA13DC6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658754438; x=1690290438;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zVQNjZCZbrx7YBoEsGRPaUn9ETcmC+pt2UNxfnvHVEk=;
  b=TpsZbYNgn474M8mh8f0r6V99AP/aWhCTaocsoH3ErqC1Twnw8yKq6oxY
   MB2Qf1hGXfmq01590tjzQ9Av9WJKSWh1TNDDIrZ90ux2C/bFaB4hxcW6b
   6+iwbnalWgcQ33u4zER+Rw+XXVC95DE6Y0dsPSeWc2/WyjpKrwXAFU1wI
   AMJb94VPqYyG+SIZ7BhgaveaRI30fkN645nAjGG+KdJxhlWU0uVUpSgXl
   rvVqYtcfCGw2kU0Ex9OJuE57PgATGY7v2WHse1E3h/hfhguSxEKCtC1C2
   7gq1oLfkQz79/mR1wKqGjNSQgFc2Agi697gJB5Hc5jNALJDC7PrDVY7rT
   w==;
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="166265300"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2022 06:07:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 25 Jul 2022 06:07:15 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 25 Jul 2022 06:07:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 5/5] ASoC: mchp-spdiftx: add and remove black line around MODULE_DEVICE_TABLE()
Date:   Mon, 25 Jul 2022 16:09:25 +0300
Message-ID: <20220725130925.1781791-6-claudiu.beznea@microchip.com>
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

Add blank line after MODULE_DEVICE_TABLE() and remove the one
before it.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdiftx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index 74729ec8423b..e8f4ff1b7c7c 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -760,8 +760,8 @@ static const struct of_device_id mchp_spdiftx_dt_ids[] = {
 	},
 	{ /* sentinel */ }
 };
-
 MODULE_DEVICE_TABLE(of, mchp_spdiftx_dt_ids);
+
 static int mchp_spdiftx_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-- 
2.34.1

