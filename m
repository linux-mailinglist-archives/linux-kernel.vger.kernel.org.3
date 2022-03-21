Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14AA4E2140
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 08:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344895AbiCUHZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 03:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344837AbiCUHYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 03:24:49 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3177BF4E;
        Mon, 21 Mar 2022 00:23:23 -0700 (PDT)
X-UUID: c8d9cbdd811d4e6c9d28233e800b53b0-20220321
X-UUID: c8d9cbdd811d4e6c9d28233e800b53b0-20220321
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1682968864; Mon, 21 Mar 2022 15:23:16 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 21 Mar 2022 15:23:16 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 21 Mar
 2022 15:23:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Mar 2022 15:23:15 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <trevor.wu@mediatek.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <angelogioacchino.delregno@collabora.com>,
        <tzungbi@google.com>, <yc.hung@mediatek.com>
Subject: [PATCH v3 4/6] ASoC: mediatek: mt8195: rename card controls
Date:   Mon, 21 Mar 2022 15:23:10 +0800
Message-ID: <20220321072312.14972-5-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220321072312.14972-1-trevor.wu@mediatek.com>
References: <20220321072312.14972-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to be able to reuse the same configurations in user space,
rename the controls to generic names.

"Headphone Jack" -> "Headphone"
"Speakers" -> "Ext Spk"
"Left Speaker" -> "Left Spk"
"Right Speaker" -> "Right SPk"

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
---
 sound/soc/mediatek/mt8195/mt8195-mt6359.c | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
index 0291b3bec84d..60279eee22c8 100644
--- a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
+++ b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
@@ -64,7 +64,7 @@ struct mt8195_mt6359_priv {
 };
 
 static const struct snd_soc_dapm_widget mt8195_mt6359_widgets[] = {
-	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_HP("Headphone", NULL),
 	SND_SOC_DAPM_MIC("Headset Mic", NULL),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL2, SND_SOC_NOPM, 0, 0, NULL, 0),
 	SND_SOC_DAPM_MIXER(SOF_DMA_DL3, SND_SOC_NOPM, 0, 0, NULL, 0),
@@ -74,8 +74,8 @@ static const struct snd_soc_dapm_widget mt8195_mt6359_widgets[] = {
 
 static const struct snd_soc_dapm_route mt8195_mt6359_routes[] = {
 	/* headset */
-	{ "Headphone Jack", NULL, "HPOL" },
-	{ "Headphone Jack", NULL, "HPOR" },
+	{ "Headphone", NULL, "HPOL" },
+	{ "Headphone", NULL, "HPOR" },
 	{ "IN1P", NULL, "Headset Mic" },
 	/* SOF Uplink */
 	{SOF_DMA_UL4, NULL, "O034"},
@@ -90,35 +90,35 @@ static const struct snd_soc_dapm_route mt8195_mt6359_routes[] = {
 };
 
 static const struct snd_kcontrol_new mt8195_mt6359_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Headphone Jack"),
+	SOC_DAPM_PIN_SWITCH("Headphone"),
 	SOC_DAPM_PIN_SWITCH("Headset Mic"),
 };
 
 static const struct snd_soc_dapm_widget mt8195_dual_speaker_widgets[] = {
-	SND_SOC_DAPM_SPK("Left Speaker", NULL),
-	SND_SOC_DAPM_SPK("Right Speaker", NULL),
+	SND_SOC_DAPM_SPK("Left Spk", NULL),
+	SND_SOC_DAPM_SPK("Right Spk", NULL),
 };
 
 static const struct snd_kcontrol_new mt8195_dual_speaker_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Left Speaker"),
-	SOC_DAPM_PIN_SWITCH("Right Speaker"),
+	SOC_DAPM_PIN_SWITCH("Left Spk"),
+	SOC_DAPM_PIN_SWITCH("Right Spk"),
 };
 
 static const struct snd_soc_dapm_widget mt8195_speaker_widgets[] = {
-	SND_SOC_DAPM_SPK("Speakers", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
 };
 
 static const struct snd_kcontrol_new mt8195_speaker_controls[] = {
-	SOC_DAPM_PIN_SWITCH("Speakers"),
+	SOC_DAPM_PIN_SWITCH("Ext Spk"),
 };
 
 static const struct snd_soc_dapm_route mt8195_rt1011_routes[] = {
-	{ "Left Speaker", NULL, "Left SPO" },
-	{ "Right Speaker", NULL, "Right SPO" },
+	{ "Left Spk", NULL, "Left SPO" },
+	{ "Right Spk", NULL, "Right SPO" },
 };
 
 static const struct snd_soc_dapm_route mt8195_rt1019_routes[] = {
-	{ "Speakers", NULL, "Speaker" },
+	{ "Ext Spk", NULL, "Speaker" },
 };
 
 #define CKSYS_AUD_TOP_CFG 0x032c
-- 
2.18.0

