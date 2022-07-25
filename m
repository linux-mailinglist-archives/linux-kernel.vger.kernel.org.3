Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CA357FF84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 15:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiGYNHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 09:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235414AbiGYNHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 09:07:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F19B9B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658754429; x=1690290429;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7eNUHi9m1jTYNb6cRhRIgN0JdTON6pZLix7RTM4B5OU=;
  b=GNxEPUl9un8slyI83KNEcuoEIDOnPlCRR5o547Krp21HgAVaNE3JGqQs
   Nj7c4Vb3n4wIQW8v6SbXWmNn6njeaLav6WwvRAsEGeC5h65D6Krq4BwhR
   O7oXH4gKQkK5QreyMbsCU5o9TGh+Vtf9NZMifsn63LvVbERyTU+7ZjKVM
   4OJtvZPluFp4GH3LiL0q9yggtV+r60JnVb8X+02A8VWenu4bYSIm2FEUy
   ysLntIQW4pkbEDY8M00+D26sq8a5x00b50MzeWQHibEzVFHmg/spNGrtb
   HbqnxGEzy9aI575YDUNkmIN5oebtAyyH7cSujFSyb7sXUjOrS069ZBbjp
   w==;
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="173519302"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Jul 2022 06:07:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 06:07:07 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 25 Jul 2022 06:07:05 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>
CC:     <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 2/5] ASoC: mchp-spdifrx: use single tab indent for structure
Date:   Mon, 25 Jul 2022 16:09:22 +0300
Message-ID: <20220725130925.1781791-3-claudiu.beznea@microchip.com>
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

Use single tab indentation for mchp_spdifrx_mixer_control structure.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 sound/soc/atmel/mchp-spdifrx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index b6a753893d90..fcc5ca865d81 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -221,11 +221,11 @@ struct mchp_spdifrx_user_data {
 };
 
 struct mchp_spdifrx_mixer_control {
-		struct mchp_spdifrx_ch_stat ch_stat[SPDIFRX_CHANNELS];
-		struct mchp_spdifrx_user_data user_data[SPDIFRX_CHANNELS];
-		bool ulock;
-		bool badf;
-		bool signal;
+	struct mchp_spdifrx_ch_stat ch_stat[SPDIFRX_CHANNELS];
+	struct mchp_spdifrx_user_data user_data[SPDIFRX_CHANNELS];
+	bool ulock;
+	bool badf;
+	bool signal;
 };
 
 struct mchp_spdifrx_dev {
-- 
2.34.1

