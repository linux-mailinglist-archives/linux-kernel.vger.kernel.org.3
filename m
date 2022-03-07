Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263EE4CF041
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 04:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234945AbiCGDcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 22:32:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbiCGDb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 22:31:59 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6982D5DE6E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 19:31:06 -0800 (PST)
X-UUID: d561c3467bb345e6a4ac22575224e62b-20220307
X-UUID: d561c3467bb345e6a4ac22575224e62b-20220307
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 178550271; Mon, 07 Mar 2022 11:31:00 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 7 Mar 2022 11:30:58 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 7 Mar 2022 11:30:58 +0800
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     <broonie@kernel.org>
CC:     <perex@perex.cz>, <matthias.bgg@gmail.com>,
        <trevor.wu@mediatek.com>, <tzungbi@google.com>,
        <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [v2] ASoC: mediatek: mt8183: support wb bt audio
Date:   Mon, 7 Mar 2022 11:30:56 +0800
Message-ID: <20220307033056.11463-1-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "bt-sco-pcm-wb" codec dai driver for wb bt audio.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
---

changed from v1: 
  - describe changes in imperative mood
  - remove description of unnecessary dependenceies

 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
index b0ec5ebd4f2d..889f9e4a96aa 100644
--- a/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
+++ b/sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c
@@ -260,7 +260,7 @@ SND_SOC_DAILINK_DEFS(pcm2,
 
 SND_SOC_DAILINK_DEFS(i2s0,
 	DAILINK_COMP_ARRAY(COMP_CPU("I2S0")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("bt-sco", "bt-sco-pcm")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("bt-sco", "bt-sco-pcm-wb")),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(i2s1,
@@ -291,7 +291,7 @@ SND_SOC_DAILINK_DEFS(i2s3_rt1015p,
 
 SND_SOC_DAILINK_DEFS(i2s5,
 	DAILINK_COMP_ARRAY(COMP_CPU("I2S5")),
-	DAILINK_COMP_ARRAY(COMP_CODEC("bt-sco", "bt-sco-pcm")),
+	DAILINK_COMP_ARRAY(COMP_CODEC("bt-sco", "bt-sco-pcm-wb")),
 	DAILINK_COMP_ARRAY(COMP_EMPTY()));
 
 SND_SOC_DAILINK_DEFS(tdm,
@@ -508,7 +508,6 @@ static struct snd_soc_dai_link mt8183_mt6358_ts3a227_dai_links[] = {
 		.no_pcm = 1,
 		.dpcm_capture = 1,
 		.ignore_suspend = 1,
-		.be_hw_params_fixup = mt8183_i2s_hw_params_fixup,
 		.ops = &mt8183_mt6358_i2s_ops,
 		SND_SOC_DAILINK_REG(i2s0),
 	},
@@ -541,7 +540,6 @@ static struct snd_soc_dai_link mt8183_mt6358_ts3a227_dai_links[] = {
 		.no_pcm = 1,
 		.dpcm_playback = 1,
 		.ignore_suspend = 1,
-		.be_hw_params_fixup = mt8183_i2s_hw_params_fixup,
 		.ops = &mt8183_mt6358_i2s_ops,
 		SND_SOC_DAILINK_REG(i2s5),
 	},
-- 
2.25.1

