Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295D255AC06
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 21:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiFYTJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 15:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbiFYTJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 15:09:05 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7FB13F8C;
        Sat, 25 Jun 2022 12:09:04 -0700 (PDT)
X-UUID: c9da14ebc5974369ac210ebaf0c8640f-20220626
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:683ec30f-e6ea-49c1-a1d3-dd7b08b15648,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:95
X-CID-INFO: VERSION:1.1.6,REQID:683ec30f-e6ea-49c1-a1d3-dd7b08b15648,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:95
X-CID-META: VersionHash:b14ad71,CLOUDID:b903082e-1756-4fa3-be7f-474a6e4be921,C
        OID:16937b3ab9fd,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: c9da14ebc5974369ac210ebaf0c8640f-20220626
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 707786803; Sun, 26 Jun 2022 03:08:58 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 26 Jun 2022 03:08:57 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 26 Jun 2022 03:08:56 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>
CC:     <aaronyu@google.com>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <julianbraha@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: [PATCH v8 3/8] ASoC: mediatek: mt8186: add mt8186-mt6366 common driver
Date:   Sun, 26 Jun 2022 03:08:47 +0800
Message-ID: <20220625190852.29130-4-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220625190852.29130-1-jiaxin.yu@mediatek.com>
References: <20220625190852.29130-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8186-mt6366 common driver for mt8186 series machine.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/mediatek/mt8186/Makefile            |  1 +
 .../mediatek/mt8186/mt8186-mt6366-common.c    | 57 +++++++++++++++++++
 .../mediatek/mt8186/mt8186-mt6366-common.h    | 17 ++++++
 3 files changed, 75 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-common.h

diff --git a/sound/soc/mediatek/mt8186/Makefile b/sound/soc/mediatek/mt8186/Makefile
index 7626bb3499dd..bdca1a3b3ff0 100644
--- a/sound/soc/mediatek/mt8186/Makefile
+++ b/sound/soc/mediatek/mt8186/Makefile
@@ -15,5 +15,6 @@ snd-soc-mt8186-afe-objs := \
 	mt8186-dai-hostless.o \
 	mt8186-dai-tdm.o \
 	mt8186-misc-control.o \
+	mt8186-mt6366-common.o
 
 obj-$(CONFIG_SND_SOC_MT8186) += snd-soc-mt8186-afe.o
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
new file mode 100644
index 000000000000..4e66603d4cdb
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// mt8186-mt6366-common.c
+//	--  MT8186 MT6366 ALSA common driver
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+//
+#include <sound/soc.h>
+
+#include "../../codecs/mt6358.h"
+#include "../common/mtk-afe-platform-driver.h"
+#include "mt8186-afe-common.h"
+#include "mt8186-mt6366-common.h"
+
+int mt8186_mt6366_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *cmpnt_afe =
+		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct snd_soc_component *cmpnt_codec =
+		asoc_rtd_to_codec(rtd, 0)->component;
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt_afe);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	struct snd_soc_dapm_context *dapm = &rtd->card->dapm;
+	int ret;
+
+	/* set mtkaif protocol */
+	mt6358_set_mtkaif_protocol(cmpnt_codec,
+				   MT6358_MTKAIF_PROTOCOL_1);
+	afe_priv->mtkaif_protocol = MT6358_MTKAIF_PROTOCOL_1;
+
+	ret = snd_soc_dapm_sync(dapm);
+	if (ret) {
+		dev_err(rtd->dev, "failed to snd_soc_dapm_sync\n");
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt8186_mt6366_init);
+
+int mt8186_mt6366_card_set_be_link(struct snd_soc_card *card,
+				   struct snd_soc_dai_link *link,
+				   struct device_node *node,
+				   char *link_name)
+{
+	int ret;
+
+	if (node && strcmp(link->name, link_name) == 0) {
+		ret = snd_soc_of_get_dai_link_codecs(card->dev, node, link);
+		if (ret < 0)
+			return dev_err_probe(card->dev, ret, "get dai link codecs fail\n");
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt8186_mt6366_card_set_be_link);
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-common.h b/sound/soc/mediatek/mt8186/mt8186-mt6366-common.h
new file mode 100644
index 000000000000..907d8f5e46b1
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-common.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt8186-mt6366-common.h
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+ */
+
+#ifndef _MT8186_MT6366_COMMON_H_
+#define _MT8186_MT6366_COMMON_H_
+
+int mt8186_mt6366_init(struct snd_soc_pcm_runtime *rtd);
+int mt8186_mt6366_card_set_be_link(struct snd_soc_card *card,
+				   struct snd_soc_dai_link *link,
+				   struct device_node *node,
+				   char *link_name);
+#endif
-- 
2.18.0

