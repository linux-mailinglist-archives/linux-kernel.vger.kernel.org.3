Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C93FB57FD10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiGYKJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbiGYKJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:09:23 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C2017E10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 03:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658743761; x=1690279761;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zVQNjZCZbrx7YBoEsGRPaUn9ETcmC+pt2UNxfnvHVEk=;
  b=y4F9VJKMSEFZn8z5GJVgHJb20dVwlxvj3kBXtY3mnxtqlH2fJzIwHEjk
   2Mca3Z6ROpjbt5MFFiAqZTvYT4KSQ0v9DzDMSVFK4iZcJNLIDX32sbx0i
   ooDS02HSaNTkFOPpW4jnHQiXxX2pImo8CMNZIVT3l2YiAcLParH1zkEEL
   0zYnXem2rzqSvRgzewdZdF+6OK7Xn3opgGLIgNyzKmLXGD7drOMiosZWy
   lrmyVyaLCLwI4PNqiUnHPHgFTtRgtW7l310IGCRoC0AUR1eT0c4b8h7Ki
   24RljkgwrFNjjxZJt3diHneT7t7uVNor7Sgt7iyawrnLhvsKhSvjJb73+
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="173496326"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2022 03:09:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 25 Jul 2022 03:09:19 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 25 Jul 2022 03:09:17 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/5] ASoC: mchp-spdiftx: add and remove black line around MODULE_DEVICE_TABLE()
Date:   Mon, 25 Jul 2022 13:11:30 +0300
Message-ID: <20220725101130.1780393-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220725101130.1780393-1-claudiu.beznea@microchip.com>
References: <20220725101130.1780393-1-claudiu.beznea@microchip.com>
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

