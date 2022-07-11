Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9245700B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 13:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbiGKLen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 07:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiGKLe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 07:34:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7468267165
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657538392; x=1689074392;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DQaW0cxKqEYfNCVtbNUDwr6+l53vLSw0LukJycah+fY=;
  b=pA2ul5TzMg14ko0wqfQnEnQyapMMQVC9Vl5mMiLf0i3w2Raeo0IbbyOM
   5qsqvn6Fn85GnFa0e5hOt6UkZ4xl5HAbYqr9kbLT4kkMgHr/766qa7KE1
   U30df1Vt15ibaktAD8uSE2l/UF/UbgWn/BuMfziRbBIKgbxCaP/8WTJqc
   gILq7F/WqyrttdzTtUtRhTFFlvWN56x9HGZieyeAqKwiNbpejoxNwm3KT
   1+K6k2lSnwsAUk1Vdc6xnbPSb5DLiI/TnzXczZ0lk3Bu2TJgmkpUP+zKF
   QRovUAtW1ec1NKn3lv84asTfUIZN3l4Lc9Voj2dueZ34SJZFe1LZhVv9+
   w==;
X-IronPort-AV: E=Sophos;i="5.92,262,1650956400"; 
   d="scan'208";a="164172576"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2022 04:19:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 11 Jul 2022 04:19:49 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 11 Jul 2022 04:19:47 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>
CC:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH] ASoC: atmel: mchp-pdmc: remove space in front of mchp_pdmc_dt_init()
Date:   Mon, 11 Jul 2022 14:22:12 +0300
Message-ID: <20220711112212.888895-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra space in front of mchp_pdmc_dt_init().

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-pdmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/mchp-pdmc.c b/sound/soc/atmel/mchp-pdmc.c
index aba7c5cde62c..44aefbd5b62c 100644
--- a/sound/soc/atmel/mchp-pdmc.c
+++ b/sound/soc/atmel/mchp-pdmc.c
@@ -985,7 +985,7 @@ static int mchp_pdmc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	dd->dev = &pdev->dev;
-	ret =  mchp_pdmc_dt_init(dd);
+	ret = mchp_pdmc_dt_init(dd);
 	if (ret < 0)
 		return ret;
 
-- 
2.34.1

