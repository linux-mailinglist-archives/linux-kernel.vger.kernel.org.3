Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A695542BF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349953AbiFVGXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349994AbiFVGXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:23:09 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DF39FCE;
        Tue, 21 Jun 2022 23:22:57 -0700 (PDT)
X-UUID: 26db0123e0c24dd29e953cfc5126be01-20220622
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:92e0131c-1632-4819-ba51-e39677ad1153,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:b14ad71,CLOUDID:af4bb82d-1756-4fa3-be7f-474a6e4be921,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 26db0123e0c24dd29e953cfc5126be01-20220622
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1397534780; Wed, 22 Jun 2022 14:22:48 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 22 Jun 2022 14:22:47 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Jun 2022 14:22:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 22 Jun 2022 14:22:47 +0800
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        "Allen-KH Cheng" <allen-kh.cheng@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v4 2/4] firmware: mediatek: Use meaningful names for mbox
Date:   Wed, 22 Jun 2022 14:22:43 +0800
Message-ID: <20220622062245.21021-3-tinghan.shen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220622062245.21021-1-tinghan.shen@mediatek.com>
References: <20220622062245.21021-1-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename mbox according to actions instead of 'mbox0' and 'mbox1'

Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
---
 drivers/firmware/mtk-adsp-ipc.c | 36 +++++++++++----------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/firmware/mtk-adsp-ipc.c b/drivers/firmware/mtk-adsp-ipc.c
index cb255a99170c..3c071f814455 100644
--- a/drivers/firmware/mtk-adsp-ipc.c
+++ b/drivers/firmware/mtk-adsp-ipc.c
@@ -12,6 +12,8 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+static const char * const adsp_mbox_ch_names[MTK_ADSP_MBOX_NUM] = { "rx", "tx" };
+
 /*
  * mtk_adsp_ipc_send - send ipc cmd to MTK ADSP
  *
@@ -72,7 +74,6 @@ static int mtk_adsp_ipc_probe(struct platform_device *pdev)
 	struct mtk_adsp_ipc *adsp_ipc;
 	struct mtk_adsp_chan *adsp_chan;
 	struct mbox_client *cl;
-	char *chan_name;
 	int ret;
 	int i, j;
 
@@ -83,12 +84,6 @@ static int mtk_adsp_ipc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	for (i = 0; i < MTK_ADSP_MBOX_NUM; i++) {
-		chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
-		if (!chan_name) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
 		adsp_chan = &adsp_ipc->chans[i];
 		cl = &adsp_chan->cl;
 		cl->dev = dev->parent;
@@ -99,17 +94,20 @@ static int mtk_adsp_ipc_probe(struct platform_device *pdev)
 
 		adsp_chan->ipc = adsp_ipc;
 		adsp_chan->idx = i;
-		adsp_chan->ch = mbox_request_channel_byname(cl, chan_name);
+		adsp_chan->ch = mbox_request_channel_byname(cl, adsp_mbox_ch_names[i]);
 		if (IS_ERR(adsp_chan->ch)) {
 			ret = PTR_ERR(adsp_chan->ch);
 			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "Failed to request mbox chan %d ret %d\n",
-					i, ret);
-			goto out_free;
-		}
+				dev_err(dev, "Failed to request mbox chan %s ret %d\n",
+					adsp_mbox_ch_names[i], ret);
+
+			for (j = 0; j < i; j++) {
+				adsp_chan = &adsp_ipc->chans[j];
+				mbox_free_channel(adsp_chan->ch);
+			}
 
-		dev_dbg(dev, "request mbox chan %s\n", chan_name);
-		kfree(chan_name);
+			return ret;
+		}
 	}
 
 	adsp_ipc->dev = dev;
@@ -117,16 +115,6 @@ static int mtk_adsp_ipc_probe(struct platform_device *pdev)
 	dev_dbg(dev, "MTK ADSP IPC initialized\n");
 
 	return 0;
-
-out_free:
-	kfree(chan_name);
-out:
-	for (j = 0; j < i; j++) {
-		adsp_chan = &adsp_ipc->chans[j];
-		mbox_free_channel(adsp_chan->ch);
-	}
-
-	return ret;
 }
 
 static int mtk_adsp_ipc_remove(struct platform_device *pdev)
-- 
2.18.0

