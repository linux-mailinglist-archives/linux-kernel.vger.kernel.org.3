Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB34D608E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:27:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348237AbiCKL2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348234AbiCKL2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:28:19 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0241BE4C4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646998036; x=1678534036;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yuDYsigMfxICt10t57pHMm+yZj5r1ZXXMzr8CGtNf3g=;
  b=tLK/uT7xlcboHjKawKuJFxi1K3lN3tNXu7w0+wUp/MgP5d3thZgomEHl
   0mUAsvZioBKM/W9wPUb5kV0Ir1/Ul0FIErAY0YtjyWaN2t6Y6uCxXl3/n
   IxX8mjeqEUsYUPEuackUEJLoNoBle2VO6fS/2J4UAXta/CQcffsZFgJcV
   o/xY+igq9f5Q+xuFGXgs3yD4K6NeCToecx8nqXnesi9P50kXe5hPj6QCu
   k1BNllCZV5PnbcDlr4GOtNx+ogTJCorqWD5ExcFq325nEqr6gGFCLNfdu
   7oQP7fNFThkSnZ2cFx9szO35UUswf3hZxHcI77gtyVOi1juBPmBWq5meh
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,173,1643698800"; 
   d="scan'208";a="156565303"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Mar 2022 04:27:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 11 Mar 2022 04:27:15 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 11 Mar 2022 04:27:13 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <codrin.ciubotariu@microchip.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ASoC: mchp-spdifrx: fix typo
Date:   Fri, 11 Mar 2022 13:28:18 +0200
Message-ID: <20220311112818.1482372-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in log describing failure of devm_snd_dmaengine_pcm_register().

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdifrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index bcd4f3e4fb0f..5fc968483f2c 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -920,7 +920,7 @@ static int mchp_spdifrx_probe(struct platform_device *pdev)
 
 	err = devm_snd_dmaengine_pcm_register(&pdev->dev, NULL, 0);
 	if (err) {
-		dev_err(&pdev->dev, "failed to register PMC: %d\n", err);
+		dev_err(&pdev->dev, "failed to register PCM: %d\n", err);
 		return err;
 	}
 
-- 
2.32.0

