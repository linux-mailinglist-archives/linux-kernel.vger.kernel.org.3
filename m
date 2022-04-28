Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BA9513049
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiD1Jvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348234AbiD1Jhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:37:32 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB5695486;
        Thu, 28 Apr 2022 02:34:15 -0700 (PDT)
X-UUID: f5663a0de8c74d08858e8f2d5b53c9f6-20220428
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:72ba047b-7cfd-490a-8ebe-e9447095090b,OB:0,LO
        B:0,IP:0,URL:8,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-12
X-CID-META: VersionHash:faefae9,CLOUDID:4c59082f-6199-437e-8ab4-9920b4bc5b76,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: f5663a0de8c74d08858e8f2d5b53c9f6-20220428
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1218965858; Thu, 28 Apr 2022 17:34:11 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Thu, 28 Apr 2022 17:34:10 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 28 Apr 2022 17:34:09 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Apr 2022 17:34:08 +0800
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
Subject: [v4 13/18] ASoC: mediatek: mt8186: add platform driver
Date:   Thu, 28 Apr 2022 17:33:50 +0800
Message-ID: <20220428093355.16172-14-jiaxin.yu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mt8186 platform and affiliated driver.

Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
---
 sound/soc/mediatek/Kconfig                    |   44 +
 sound/soc/mediatek/Makefile                   |    1 +
 sound/soc/mediatek/mt8186/Makefile            |   22 +
 sound/soc/mediatek/mt8186/mt8186-afe-common.h |  235 ++
 .../soc/mediatek/mt8186/mt8186-afe-control.c  |  261 ++
 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    | 3005 +++++++++++++++++
 .../mediatek/mt8186/mt8186-interconnection.h  |   69 +
 .../soc/mediatek/mt8186/mt8186-misc-control.c |  294 ++
 .../mediatek/mt8186/mt8186-mt6366-common.c    |   59 +
 .../mediatek/mt8186/mt8186-mt6366-common.h    |   17 +
 sound/soc/mediatek/mt8186/mt8186-reg.h        | 2913 ++++++++++++++++
 11 files changed, 6920 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8186/Makefile
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-control.c
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-interconnection.h
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-misc-control.c
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-mt6366-common.h
 create mode 100644 sound/soc/mediatek/mt8186/mt8186-reg.h

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 9e5ce1a82639..96917743b0db 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -152,6 +152,50 @@ config SND_SOC_MT8183_DA7219_MAX98357A
 	  Select Y if you have such device.
 	  If unsure select "N".
 
+config SND_SOC_MT8186
+	tristate "ASoC support for Mediatek MT8186 chip"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	depends on COMMON_CLK
+	select SND_SOC_MEDIATEK
+	select MFD_SYSCON if SND_SOC_MT6358
+	help
+	  This adds ASoC driver for Mediatek MT8186 boards
+	  that can be used with other codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
+config SND_SOC_MT8186_MT6366_DA7219_MAX98357
+	tristate "ASoC Audio driver for MT8186 with DA7219 MAX98357A codec"
+	depends on I2C && GPIOLIB
+	depends on SND_SOC_MT8186 && MTK_PMIC_WRAP
+	select SND_SOC_MT6358
+	select SND_SOC_MAX98357A
+	select SND_SOC_DA7219
+	select SND_SOC_BT_SCO
+	select SND_SOC_DMIC
+	select SND_SOC_HDMI_CODEC
+	help
+	  This adds ASoC driver for Mediatek MT8186 boards
+	  with the MT6366(MT6358) DA7219 MAX98357A codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
+config SND_SOC_MT8186_MT6366_RT1019_RT5682S
+	tristate "ASoC Audio driver for MT8186 with RT1019 RT5682S codec"
+	depends on I2C && GPIOLIB
+	depends on SND_SOC_MT8186 && MTK_PMIC_WRAP
+	select SND_SOC_MT6358
+	select SND_SOC_RT1015P
+	select SND_SOC_RT5682S
+	select SND_SOC_BT_SCO
+	select SND_SOC_DMIC
+	select SND_SOC_HDMI_CODEC
+	help
+	  This adds ASoC driver for Mediatek MT8186 boards
+	  with the MT6366(MT6358) RT1019 RT5682S codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
 config SND_SOC_MTK_BTCVSD
 	tristate "ALSA BT SCO CVSD/MSBC Driver"
 	help
diff --git a/sound/soc/mediatek/Makefile b/sound/soc/mediatek/Makefile
index 34778ca12106..5571c640a288 100644
--- a/sound/soc/mediatek/Makefile
+++ b/sound/soc/mediatek/Makefile
@@ -4,5 +4,6 @@ obj-$(CONFIG_SND_SOC_MT2701) += mt2701/
 obj-$(CONFIG_SND_SOC_MT6797) += mt6797/
 obj-$(CONFIG_SND_SOC_MT8173) += mt8173/
 obj-$(CONFIG_SND_SOC_MT8183) += mt8183/
+obj-$(CONFIG_SND_SOC_MT8186) += mt8186/
 obj-$(CONFIG_SND_SOC_MT8192) += mt8192/
 obj-$(CONFIG_SND_SOC_MT8195) += mt8195/
diff --git a/sound/soc/mediatek/mt8186/Makefile b/sound/soc/mediatek/mt8186/Makefile
new file mode 100644
index 000000000000..49b0026628a0
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/Makefile
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# platform driver
+snd-soc-mt8186-afe-objs := \
+	mt8186-afe-pcm.o \
+	mt8186-audsys-clk.o \
+	mt8186-afe-clk.o \
+	mt8186-afe-gpio.o \
+	mt8186-dai-adda.o \
+	mt8186-afe-control.o \
+	mt8186-dai-i2s.o \
+	mt8186-dai-hw-gain.o \
+	mt8186-dai-pcm.o \
+	mt8186-dai-src.o \
+	mt8186-dai-hostless.o \
+	mt8186-dai-tdm.o \
+	mt8186-misc-control.o \
+	mt8186-mt6366-common.o
+
+obj-$(CONFIG_SND_SOC_MT8186) += snd-soc-mt8186-afe.o
+obj-$(CONFIG_SND_SOC_MT8186_MT6366_DA7219_MAX98357) += mt8186-mt6366-da7219-max98357.o
+obj-$(CONFIG_SND_SOC_MT8186_MT6366_RT1019_RT5682S) += mt8186-mt6366-rt1019-rt5682s.o
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-common.h b/sound/soc/mediatek/mt8186/mt8186-afe-common.h
new file mode 100644
index 000000000000..dc888f2de10c
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-common.h
@@ -0,0 +1,235 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * mt8186-afe-common.h  --  Mediatek 8186 audio driver definitions
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+ */
+
+#ifndef _MT_8186_AFE_COMMON_H_
+#define _MT_8186_AFE_COMMON_H_
+#include <sound/soc.h>
+#include <linux/list.h>
+#include <linux/regmap.h>
+#include "mt8186-reg.h"
+#include "../common/mtk-base-afe.h"
+
+enum {
+	MT8186_MEMIF_DL1,
+	MT8186_MEMIF_DL12,
+	MT8186_MEMIF_DL2,
+	MT8186_MEMIF_DL3,
+	MT8186_MEMIF_DL4,
+	MT8186_MEMIF_DL5,
+	MT8186_MEMIF_DL6,
+	MT8186_MEMIF_DL7,
+	MT8186_MEMIF_DL8,
+	MT8186_MEMIF_VUL12,
+	MT8186_MEMIF_VUL2,
+	MT8186_MEMIF_VUL3,
+	MT8186_MEMIF_VUL4,
+	MT8186_MEMIF_VUL5,
+	MT8186_MEMIF_VUL6,
+	MT8186_MEMIF_AWB,
+	MT8186_MEMIF_AWB2,
+	MT8186_MEMIF_NUM,
+	MT8186_DAI_ADDA = MT8186_MEMIF_NUM,
+	MT8186_DAI_AP_DMIC,
+	MT8186_DAI_CONNSYS_I2S,
+	MT8186_DAI_I2S_0,
+	MT8186_DAI_I2S_1,
+	MT8186_DAI_I2S_2,
+	MT8186_DAI_I2S_3,
+	MT8186_DAI_HW_GAIN_1,
+	MT8186_DAI_HW_GAIN_2,
+	MT8186_DAI_SRC_1,
+	MT8186_DAI_SRC_2,
+	MT8186_DAI_PCM,
+	MT8186_DAI_TDM_IN,
+	MT8186_DAI_HOSTLESS_LPBK,
+	MT8186_DAI_HOSTLESS_FM,
+	MT8186_DAI_HOSTLESS_HW_GAIN_AAUDIO,
+	MT8186_DAI_HOSTLESS_SRC_AAUDIO,
+	MT8186_DAI_HOSTLESS_SRC_1,	/* just an exmpale */
+	MT8186_DAI_HOSTLESS_SRC_BARGEIN,
+	MT8186_DAI_HOSTLESS_UL1,
+	MT8186_DAI_HOSTLESS_UL2,
+	MT8186_DAI_HOSTLESS_UL3,
+	MT8186_DAI_HOSTLESS_UL5,
+	MT8186_DAI_HOSTLESS_UL6,
+	MT8186_DAI_NUM,
+};
+
+#define MT8186_RECORD_MEMIF MT8186_MEMIF_VUL12
+#define MT8186_ECHO_REF_MEMIF MT8186_MEMIF_AWB
+#define MT8186_PRIMARY_MEMIF MT8186_MEMIF_DL1
+#define MT8186_FAST_MEMIF MT8186_MEMIF_DL2
+#define MT8186_DEEP_MEMIF MT8186_MEMIF_DL3
+#define MT8186_VOIP_MEMIF MT8186_MEMIF_DL12
+#define MT8186_MMAP_DL_MEMIF MT8186_MEMIF_DL5
+#define MT8186_MMAP_UL_MEMIF MT8186_MEMIF_VUL5
+#define MT8186_BARGEIN_MEMIF MT8186_MEMIF_AWB
+
+enum {
+	MT8186_IRQ_0,
+	MT8186_IRQ_1,
+	MT8186_IRQ_2,
+	MT8186_IRQ_3,
+	MT8186_IRQ_4,
+	MT8186_IRQ_5,
+	MT8186_IRQ_6,
+	MT8186_IRQ_7,
+	MT8186_IRQ_8,
+	MT8186_IRQ_9,
+	MT8186_IRQ_10,
+	MT8186_IRQ_11,
+	MT8186_IRQ_12,
+	MT8186_IRQ_13,
+	MT8186_IRQ_14,
+	MT8186_IRQ_15,
+	MT8186_IRQ_16,
+	MT8186_IRQ_17,
+	MT8186_IRQ_18,
+	MT8186_IRQ_19,
+	MT8186_IRQ_20,
+	MT8186_IRQ_21,
+	MT8186_IRQ_22,
+	MT8186_IRQ_23,
+	MT8186_IRQ_24,
+	MT8186_IRQ_25,
+	MT8186_IRQ_26,
+	MT8186_IRQ_NUM,
+};
+
+enum {
+	MT8186_AFE_IRQ_DIR_MCU = 0,
+	MT8186_AFE_IRQ_DIR_DSP,
+	MT8186_AFE_IRQ_DIR_BOTH,
+};
+
+enum {
+	MTKAIF_PROTOCOL_1 = 0,
+	MTKAIF_PROTOCOL_2,
+	MTKAIF_PROTOCOL_2_CLK_P2,
+};
+
+enum {
+	MTK_AFE_ADDA_DL_GAIN_MUTE = 0,
+	MTK_AFE_ADDA_DL_GAIN_NORMAL = 0xf74f,
+	/* SA suggest apply -0.3db to audio/speech path */
+};
+
+#define MTK_SPK_NOT_SMARTPA_STR "MTK_SPK_NOT_SMARTPA"
+#define MTK_SPK_RICHTEK_RT5509_STR "MTK_SPK_RICHTEK_RT5509"
+#define MTK_SPK_MEDIATEK_MT6660_STR "MTK_SPK_MEDIATEK_MT6660"
+#define MTK_SPK_GOODIX_TFA9874_STR "MTK_SPK_GOODIX_TFA9874"
+
+#define MTK_SPK_I2S_0_STR "MTK_SPK_I2S_0"
+#define MTK_SPK_I2S_1_STR "MTK_SPK_I2S_1"
+#define MTK_SPK_I2S_2_STR "MTK_SPK_I2S_2"
+#define MTK_SPK_I2S_3_STR "MTK_SPK_I2S_3"
+#define MTK_SPK_I2S_5_STR "MTK_SPK_I2S_5"
+#define MTK_SPK_I2S_6_STR "MTK_SPK_I2S_6"
+#define MTK_SPK_I2S_7_STR "MTK_SPK_I2S_7"
+#define MTK_SPK_I2S_8_STR "MTK_SPK_I2S_8"
+#define MTK_SPK_I2S_9_STR "MTK_SPK_I2S_9"
+
+/* MCLK */
+enum {
+	MT8186_I2S0_MCK = 0,
+	MT8186_I2S1_MCK,
+	MT8186_I2S2_MCK,
+	MT8186_I2S4_MCK,
+	MT8186_TDM_MCK,
+	MT8186_MCK_NUM,
+};
+
+enum mtk_spk_type {
+	MTK_SPK_NOT_SMARTPA = 0,
+	MTK_SPK_RICHTEK_RT5509,
+	MTK_SPK_MEDIATEK_MT6660,
+	MTK_SPK_GOODIX_TFA9874,
+	MTK_SPK_TYPE_NUM
+};
+
+enum mtk_spk_i2s_type {
+	MTK_SPK_I2S_TYPE_INVALID = -1,
+	MTK_SPK_I2S_0,
+	MTK_SPK_I2S_1,
+	MTK_SPK_I2S_2,
+	MTK_SPK_I2S_3,
+	MTK_SPK_I2S_5,
+	MTK_SPK_I2S_TYPE_NUM
+};
+
+/* SMC CALL Operations */
+enum mtk_audio_smc_call_op {
+	MTK_AUDIO_SMC_OP_INIT = 0,
+	MTK_AUDIO_SMC_OP_DRAM_REQUEST,
+	MTK_AUDIO_SMC_OP_DRAM_RELEASE,
+	MTK_AUDIO_SMC_OP_FM_REQUEST,
+	MTK_AUDIO_SMC_OP_FM_RELEASE,
+	MTK_AUDIO_SMC_OP_ADSP_REQUEST,
+	MTK_AUDIO_SMC_OP_ADSP_RELEASE,
+	MTK_AUDIO_SMC_OP_NUM
+};
+
+struct snd_pcm_substream;
+struct mtk_base_irq_data;
+struct clk;
+
+struct mt8186_afe_private {
+	struct clk **clk;
+	struct clk_lookup **lookup;
+	struct regmap *topckgen;
+	struct regmap *apmixedsys;
+	struct regmap *infracfg;
+	int irq_cnt[MT8186_MEMIF_NUM];
+	int stf_positive_gain_db;
+	int pm_runtime_bypass_reg_ctl;
+	int sgen_mode;
+	int sgen_rate;
+	int sgen_amplitude;
+
+	/* xrun assert */
+	int xrun_assert[MT8186_MEMIF_NUM];
+
+	/* dai */
+	bool dai_on[MT8186_DAI_NUM];
+	void *dai_priv[MT8186_DAI_NUM];
+
+	/* adda */
+	bool mtkaif_calibration_ok;
+	int mtkaif_protocol;
+	int mtkaif_chosen_phase[4];
+	int mtkaif_phase_cycle[4];
+	int mtkaif_calibration_num_phase;
+	int mtkaif_dmic;
+	int mtkaif_looback0;
+	int mtkaif_looback1;
+
+	/* mck */
+	int mck_rate[MT8186_MCK_NUM];
+};
+
+int mt8186_dai_adda_register(struct mtk_base_afe *afe);
+int mt8186_dai_i2s_register(struct mtk_base_afe *afe);
+int mt8186_dai_tdm_register(struct mtk_base_afe *afe);
+int mt8186_dai_hw_gain_register(struct mtk_base_afe *afe);
+int mt8186_dai_src_register(struct mtk_base_afe *afe);
+int mt8186_dai_pcm_register(struct mtk_base_afe *afe);
+int mt8186_dai_hostless_register(struct mtk_base_afe *afe);
+
+int mt8186_add_misc_control(struct snd_soc_component *component);
+
+unsigned int mt8186_general_rate_transform(struct device *dev,
+					   unsigned int rate);
+unsigned int mt8186_rate_transform(struct device *dev,
+				   unsigned int rate, int aud_blk);
+unsigned int mt8186_tdm_relatch_rate_transform(struct device *dev,
+					       unsigned int rate);
+
+int mt8186_dai_set_priv(struct mtk_base_afe *afe, int id,
+			int priv_size, const void *priv_data);
+
+#endif
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-control.c b/sound/soc/mediatek/mt8186/mt8186-afe-control.c
new file mode 100644
index 000000000000..2d78212c3c3f
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-control.c
@@ -0,0 +1,261 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MediaTek ALSA SoC Audio Control
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+
+#include "mt8186-afe-common.h"
+#include <linux/pm_runtime.h>
+
+enum {
+	MTK_AFE_RATE_8K = 0,
+	MTK_AFE_RATE_11K,
+	MTK_AFE_RATE_12K,
+	MTK_AFE_RATE_384K,
+	MTK_AFE_RATE_16K,
+	MTK_AFE_RATE_22K,
+	MTK_AFE_RATE_24K,
+	MTK_AFE_RATE_352K,
+	MTK_AFE_RATE_32K,
+	MTK_AFE_RATE_44K,
+	MTK_AFE_RATE_48K,
+	MTK_AFE_RATE_88K,
+	MTK_AFE_RATE_96K,
+	MTK_AFE_RATE_176K,
+	MTK_AFE_RATE_192K,
+	MTK_AFE_RATE_260K,
+};
+
+enum {
+	MTK_AFE_PCM_RATE_8K = 0,
+	MTK_AFE_PCM_RATE_16K,
+	MTK_AFE_PCM_RATE_32K,
+	MTK_AFE_PCM_RATE_48K,
+};
+
+enum {
+	MTK_AFE_TDM_RATE_8K = 0,
+	MTK_AFE_TDM_RATE_12K,
+	MTK_AFE_TDM_RATE_16K,
+	MTK_AFE_TDM_RATE_24K,
+	MTK_AFE_TDM_RATE_32K,
+	MTK_AFE_TDM_RATE_48K,
+	MTK_AFE_TDM_RATE_64K,
+	MTK_AFE_TDM_RATE_96K,
+	MTK_AFE_TDM_RATE_128K,
+	MTK_AFE_TDM_RATE_192K,
+	MTK_AFE_TDM_RATE_256K,
+	MTK_AFE_TDM_RATE_384K,
+	MTK_AFE_TDM_RATE_11K,
+	MTK_AFE_TDM_RATE_22K,
+	MTK_AFE_TDM_RATE_44K,
+	MTK_AFE_TDM_RATE_88K,
+	MTK_AFE_TDM_RATE_176K,
+	MTK_AFE_TDM_RATE_352K,
+};
+
+enum {
+	MTK_AFE_TDM_RELATCH_RATE_8K = 0,
+	MTK_AFE_TDM_RELATCH_RATE_11K,
+	MTK_AFE_TDM_RELATCH_RATE_12K,
+	MTK_AFE_TDM_RELATCH_RATE_16K,
+	MTK_AFE_TDM_RELATCH_RATE_22K,
+	MTK_AFE_TDM_RELATCH_RATE_24K,
+	MTK_AFE_TDM_RELATCH_RATE_32K,
+	MTK_AFE_TDM_RELATCH_RATE_44K,
+	MTK_AFE_TDM_RELATCH_RATE_48K,
+	MTK_AFE_TDM_RELATCH_RATE_88K,
+	MTK_AFE_TDM_RELATCH_RATE_96K,
+	MTK_AFE_TDM_RELATCH_RATE_176K,
+	MTK_AFE_TDM_RELATCH_RATE_192K,
+	MTK_AFE_TDM_RELATCH_RATE_352K,
+	MTK_AFE_TDM_RELATCH_RATE_384K,
+};
+
+unsigned int mt8186_general_rate_transform(struct device *dev,
+					   unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_AFE_RATE_8K;
+	case 11025:
+		return MTK_AFE_RATE_11K;
+	case 12000:
+		return MTK_AFE_RATE_12K;
+	case 16000:
+		return MTK_AFE_RATE_16K;
+	case 22050:
+		return MTK_AFE_RATE_22K;
+	case 24000:
+		return MTK_AFE_RATE_24K;
+	case 32000:
+		return MTK_AFE_RATE_32K;
+	case 44100:
+		return MTK_AFE_RATE_44K;
+	case 48000:
+		return MTK_AFE_RATE_48K;
+	case 88200:
+		return MTK_AFE_RATE_88K;
+	case 96000:
+		return MTK_AFE_RATE_96K;
+	case 176400:
+		return MTK_AFE_RATE_176K;
+	case 192000:
+		return MTK_AFE_RATE_192K;
+	case 260000:
+		return MTK_AFE_RATE_260K;
+	case 352800:
+		return MTK_AFE_RATE_352K;
+	case 384000:
+		return MTK_AFE_RATE_384K;
+	default:
+		dev_err(dev, "%s(), rate %u invalid, use %d!!!\n",
+			__func__, rate, MTK_AFE_RATE_48K);
+	}
+
+	return MTK_AFE_RATE_48K;
+}
+
+static unsigned int tdm_rate_transform(struct device *dev,
+				       unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_AFE_TDM_RATE_8K;
+	case 11025:
+		return MTK_AFE_TDM_RATE_11K;
+	case 12000:
+		return MTK_AFE_TDM_RATE_12K;
+	case 16000:
+		return MTK_AFE_TDM_RATE_16K;
+	case 22050:
+		return MTK_AFE_TDM_RATE_22K;
+	case 24000:
+		return MTK_AFE_TDM_RATE_24K;
+	case 32000:
+		return MTK_AFE_TDM_RATE_32K;
+	case 44100:
+		return MTK_AFE_TDM_RATE_44K;
+	case 48000:
+		return MTK_AFE_TDM_RATE_48K;
+	case 64000:
+		return MTK_AFE_TDM_RATE_64K;
+	case 88200:
+		return MTK_AFE_TDM_RATE_88K;
+	case 96000:
+		return MTK_AFE_TDM_RATE_96K;
+	case 128000:
+		return MTK_AFE_TDM_RATE_128K;
+	case 176400:
+		return MTK_AFE_TDM_RATE_176K;
+	case 192000:
+		return MTK_AFE_TDM_RATE_192K;
+	case 256000:
+		return MTK_AFE_TDM_RATE_256K;
+	case 352800:
+		return MTK_AFE_TDM_RATE_352K;
+	case 384000:
+		return MTK_AFE_TDM_RATE_384K;
+	default:
+		dev_err(dev, "%s(), rate %u invalid, use %d!!!\n",
+			__func__, rate, MTK_AFE_TDM_RATE_48K);
+	}
+
+	return MTK_AFE_TDM_RATE_48K;
+}
+
+static unsigned int pcm_rate_transform(struct device *dev,
+				       unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_AFE_PCM_RATE_8K;
+	case 16000:
+		return MTK_AFE_PCM_RATE_16K;
+	case 32000:
+		return MTK_AFE_PCM_RATE_32K;
+	case 48000:
+		return MTK_AFE_PCM_RATE_48K;
+	default:
+		dev_info(dev, "%s(), rate %u invalid, use %d!!!\n",
+			 __func__,
+			 rate, MTK_AFE_PCM_RATE_32K);
+		return MTK_AFE_PCM_RATE_32K;
+	}
+}
+
+unsigned int mt8186_tdm_relatch_rate_transform(struct device *dev,
+					       unsigned int rate)
+{
+	switch (rate) {
+	case 8000:
+		return MTK_AFE_TDM_RELATCH_RATE_8K;
+	case 11025:
+		return MTK_AFE_TDM_RELATCH_RATE_11K;
+	case 12000:
+		return MTK_AFE_TDM_RELATCH_RATE_12K;
+	case 16000:
+		return MTK_AFE_TDM_RELATCH_RATE_16K;
+	case 22050:
+		return MTK_AFE_TDM_RELATCH_RATE_22K;
+	case 24000:
+		return MTK_AFE_TDM_RELATCH_RATE_24K;
+	case 32000:
+		return MTK_AFE_TDM_RELATCH_RATE_32K;
+	case 44100:
+		return MTK_AFE_TDM_RELATCH_RATE_44K;
+	case 48000:
+		return MTK_AFE_TDM_RELATCH_RATE_48K;
+	case 88200:
+		return MTK_AFE_TDM_RELATCH_RATE_88K;
+	case 96000:
+		return MTK_AFE_TDM_RELATCH_RATE_96K;
+	case 176400:
+		return MTK_AFE_TDM_RELATCH_RATE_176K;
+	case 192000:
+		return MTK_AFE_TDM_RELATCH_RATE_192K;
+	case 352800:
+		return MTK_AFE_TDM_RELATCH_RATE_352K;
+	case 384000:
+		return MTK_AFE_TDM_RELATCH_RATE_384K;
+	default:
+		dev_info(dev, "%s(), rate %u invalid, use %d!!!\n",
+			 __func__,
+			 rate, MTK_AFE_TDM_RELATCH_RATE_48K);
+		return MTK_AFE_TDM_RELATCH_RATE_48K;
+	}
+}
+
+unsigned int mt8186_rate_transform(struct device *dev,
+				   unsigned int rate, int aud_blk)
+{
+	switch (aud_blk) {
+	case MT8186_DAI_PCM:
+		return pcm_rate_transform(dev, rate);
+	case MT8186_DAI_TDM_IN:
+		return tdm_rate_transform(dev, rate);
+	default:
+		return mt8186_general_rate_transform(dev, rate);
+	}
+}
+
+int mt8186_dai_set_priv(struct mtk_base_afe *afe, int id,
+			int priv_size, const void *priv_data)
+{
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	void *temp_data;
+
+	temp_data = devm_kzalloc(afe->dev,
+				 priv_size,
+				 GFP_KERNEL);
+	if (!temp_data)
+		return -ENOMEM;
+
+	if (priv_data)
+		memcpy(temp_data, priv_data, priv_size);
+
+	afe_priv->dai_priv[id] = temp_data;
+
+	return 0;
+}
diff --git a/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
new file mode 100644
index 000000000000..70eb16bbf17d
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-afe-pcm.c
@@ -0,0 +1,3005 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Mediatek ALSA SoC AFE platform driver for 8186
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <sound/soc.h>
+
+#include "../common/mtk-afe-platform-driver.h"
+#include "../common/mtk-afe-fe-dai.h"
+
+#include "mt8186-afe-common.h"
+#include "mt8186-afe-clk.h"
+#include "mt8186-afe-gpio.h"
+#include "mt8186-interconnection.h"
+
+static const struct snd_pcm_hardware mt8186_afe_hardware = {
+	.info = (SNDRV_PCM_INFO_MMAP |
+		 SNDRV_PCM_INFO_INTERLEAVED |
+		 SNDRV_PCM_INFO_MMAP_VALID),
+	.formats = (SNDRV_PCM_FMTBIT_S16_LE |
+		    SNDRV_PCM_FMTBIT_S24_LE |
+		    SNDRV_PCM_FMTBIT_S32_LE),
+	.period_bytes_min = 96,
+	.period_bytes_max = 4 * 48 * 1024,
+	.periods_min = 2,
+	.periods_max = 256,
+	.buffer_bytes_max = 4 * 48 * 1024,
+	.fifo_size = 0,
+};
+
+static int mt8186_fe_startup(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	int id = asoc_rtd_to_cpu(rtd, 0)->id;
+	struct mtk_base_afe_memif *memif = &afe->memif[id];
+	const struct snd_pcm_hardware *mtk_afe_hardware = afe->mtk_afe_hardware;
+	int ret;
+
+	memif->substream = substream;
+
+	snd_pcm_hw_constraint_step(substream->runtime, 0,
+				   SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 16);
+
+	snd_soc_set_runtime_hwparams(substream, mtk_afe_hardware);
+
+	ret = snd_pcm_hw_constraint_integer(runtime,
+					    SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		dev_err(afe->dev, "snd_pcm_hw_constraint_integer failed\n");
+		return ret;
+	}
+
+	/* dynamic allocate irq to memif */
+	if (memif->irq_usage < 0) {
+		int irq_id = mtk_dynamic_irq_acquire(afe);
+
+		if (irq_id != afe->irqs_size) {
+			/* link */
+			memif->irq_usage = irq_id;
+		} else {
+			dev_err(afe->dev, "%s() error: no more asys irq\n",
+				__func__);
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
+static void mt8186_fe_shutdown(struct snd_pcm_substream *substream,
+			       struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	int id = asoc_rtd_to_cpu(rtd, 0)->id;
+	struct mtk_base_afe_memif *memif = &afe->memif[id];
+	int irq_id = memif->irq_usage;
+
+	memif->substream = NULL;
+	afe_priv->irq_cnt[id] = 0;
+	afe_priv->xrun_assert[id] = 0;
+
+	if (!memif->const_irq) {
+		mtk_dynamic_irq_release(afe, irq_id);
+		memif->irq_usage = -1;
+		memif->substream = NULL;
+	}
+}
+
+static int mt8186_fe_hw_params(struct snd_pcm_substream *substream,
+			       struct snd_pcm_hw_params *params,
+			       struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	int id = asoc_rtd_to_cpu(rtd, 0)->id;
+	unsigned int channels = params_channels(params);
+	unsigned int rate = params_rate(params);
+	int ret;
+
+	ret = mtk_afe_fe_hw_params(substream, params, dai);
+	if (ret)
+		return ret;
+
+	/* channel merge configuration, enable control is in UL5_IN_MUX */
+	if (id == MT8186_MEMIF_VUL3) {
+		int update_cnt = 8;
+		unsigned int val = 0;
+		unsigned int mask = 0;
+		int fs_mode = mt8186_rate_transform(afe->dev, rate, id);
+
+		/* set rate, channel, update cnt, disable sgen */
+		val = fs_mode << CM1_FS_SELECT_SFT |
+			(channels - 1) << CHANNEL_MERGE0_CHNUM_SFT |
+			update_cnt << CHANNEL_MERGE0_UPDATE_CNT_SFT;
+		mask = CM1_FS_SELECT_MASK_SFT |
+			CHANNEL_MERGE0_CHNUM_MASK_SFT |
+			CHANNEL_MERGE0_UPDATE_CNT_MASK_SFT;
+		regmap_update_bits(afe->regmap, AFE_CM1_CON, mask, val);
+	}
+
+	return 0;
+}
+
+static int mt8186_fe_hw_free(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
+{
+	int ret;
+
+	ret = mtk_afe_fe_hw_free(substream, dai);
+	if (ret)
+		goto exit;
+
+	/* wait for some platform related operation */
+exit:
+	return ret;
+}
+
+static int mt8186_fe_trigger(struct snd_pcm_substream *substream, int cmd,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime * const runtime = substream->runtime;
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	int id = asoc_rtd_to_cpu(rtd, 0)->id;
+	struct mtk_base_afe_memif *memif = &afe->memif[id];
+	int irq_id = memif->irq_usage;
+	struct mtk_base_afe_irq *irqs = &afe->irqs[irq_id];
+	const struct mtk_base_irq_data *irq_data = irqs->irq_data;
+	unsigned int counter = runtime->period_size;
+	unsigned int rate = runtime->rate;
+	int fs;
+	int ret;
+
+	dev_dbg(afe->dev, "%s(), %s cmd %d, irq_id %d\n",
+		__func__, memif->data->name, cmd, irq_id);
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+		ret = mtk_memif_set_enable(afe, id);
+		if (ret) {
+			dev_err(afe->dev, "%s(), error, id %d, memif enable, ret %d\n",
+				__func__, id, ret);
+			return ret;
+		}
+
+		/*
+		 * for small latency record
+		 * ul memif need read some data before irq enable
+		 */
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE &&
+		    ((runtime->period_size * 1000) / rate <= 10))
+			udelay(300);
+
+		/* set irq counter */
+		if (afe_priv->irq_cnt[id] > 0)
+			counter = afe_priv->irq_cnt[id];
+
+		regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
+				   irq_data->irq_cnt_maskbit
+				   << irq_data->irq_cnt_shift,
+				   counter << irq_data->irq_cnt_shift);
+
+		/* set irq fs */
+		fs = afe->irq_fs(substream, runtime->rate);
+		if (fs < 0)
+			return -EINVAL;
+
+		regmap_update_bits(afe->regmap, irq_data->irq_fs_reg,
+				   irq_data->irq_fs_maskbit
+				   << irq_data->irq_fs_shift,
+				   fs << irq_data->irq_fs_shift);
+
+		/* enable interrupt */
+		if (runtime->stop_threshold != ~(0U))
+			regmap_update_bits(afe->regmap,
+					   irq_data->irq_en_reg,
+					   1 << irq_data->irq_en_shift,
+					   1 << irq_data->irq_en_shift);
+		return 0;
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+		if (afe_priv->xrun_assert[id] > 0) {
+			if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
+				int avail = snd_pcm_capture_avail(runtime);
+
+				if (avail >= runtime->buffer_size) {
+					dev_err(afe->dev, "%s(), id %d, xrun assert\n",
+						__func__, id);
+				}
+			}
+		}
+
+		ret = mtk_memif_set_disable(afe, id);
+		if (ret)
+			dev_err(afe->dev, "%s(), error, id %d, memif enable, ret %d\n",
+				__func__, id, ret);
+
+		/* disable interrupt */
+		if (runtime->stop_threshold != ~(0U))
+			regmap_update_bits(afe->regmap,
+					   irq_data->irq_en_reg,
+					   1 << irq_data->irq_en_shift,
+					   0 << irq_data->irq_en_shift);
+
+		/* clear pending IRQ */
+		regmap_write(afe->regmap, irq_data->irq_clr_reg,
+			     1 << irq_data->irq_clr_shift);
+		return ret;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int mt8186_memif_fs(struct snd_pcm_substream *substream,
+			   unsigned int rate)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+	int id = asoc_rtd_to_cpu(rtd, 0)->id;
+
+	return mt8186_rate_transform(afe->dev, rate, id);
+}
+
+static int mt8186_get_dai_fs(struct mtk_base_afe *afe,
+			     int dai_id, unsigned int rate)
+{
+	return mt8186_rate_transform(afe->dev, rate, dai_id);
+}
+
+static int mt8186_irq_fs(struct snd_pcm_substream *substream, unsigned int rate)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_component *component =
+		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(component);
+
+	return mt8186_general_rate_transform(afe->dev, rate);
+}
+
+static int mt8186_get_memif_pbuf_size(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	if ((runtime->period_size * 1000) / runtime->rate > 10)
+		return MT8186_MEMIF_PBUF_SIZE_256_BYTES;
+
+	return MT8186_MEMIF_PBUF_SIZE_32_BYTES;
+}
+
+static int mt8186_fe_prepare(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_pcm_runtime * const runtime = substream->runtime;
+	struct mtk_base_afe *afe = snd_soc_dai_get_drvdata(dai);
+	int id = asoc_rtd_to_cpu(rtd, 0)->id;
+	struct mtk_base_afe_memif *memif = &afe->memif[id];
+	int irq_id = memif->irq_usage;
+	struct mtk_base_afe_irq *irqs = &afe->irqs[irq_id];
+	const struct mtk_base_irq_data *irq_data = irqs->irq_data;
+	unsigned int counter = runtime->period_size;
+	int fs;
+	int ret;
+
+	ret = mtk_afe_fe_prepare(substream, dai);
+	if (ret)
+		return ret;
+
+	/* set irq counter */
+	regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
+			   irq_data->irq_cnt_maskbit
+			   << irq_data->irq_cnt_shift,
+			   counter << irq_data->irq_cnt_shift);
+
+	/* set irq fs */
+	fs = afe->irq_fs(substream, runtime->rate);
+
+	if (fs < 0)
+		return -EINVAL;
+
+	regmap_update_bits(afe->regmap, irq_data->irq_fs_reg,
+			   irq_data->irq_fs_maskbit
+			   << irq_data->irq_fs_shift,
+			   fs << irq_data->irq_fs_shift);
+
+	return 0;
+}
+
+/* FE DAIs */
+static const struct snd_soc_dai_ops mt8186_memif_dai_ops = {
+	.startup	= mt8186_fe_startup,
+	.shutdown	= mt8186_fe_shutdown,
+	.hw_params	= mt8186_fe_hw_params,
+	.hw_free	= mt8186_fe_hw_free,
+	.prepare	= mt8186_fe_prepare,
+	.trigger	= mt8186_fe_trigger,
+};
+
+#define MTK_PCM_RATES (SNDRV_PCM_RATE_8000_48000 |\
+		       SNDRV_PCM_RATE_88200 |\
+		       SNDRV_PCM_RATE_96000 |\
+		       SNDRV_PCM_RATE_176400 |\
+		       SNDRV_PCM_RATE_192000)
+
+#define MTK_PCM_DAI_RATES (SNDRV_PCM_RATE_8000 |\
+			   SNDRV_PCM_RATE_16000 |\
+			   SNDRV_PCM_RATE_32000 |\
+			   SNDRV_PCM_RATE_48000)
+
+#define MTK_PCM_FORMATS (SNDRV_PCM_FMTBIT_S16_LE |\
+			 SNDRV_PCM_FMTBIT_S24_LE |\
+			 SNDRV_PCM_FMTBIT_S32_LE)
+
+static struct snd_soc_dai_driver mt8186_memif_dai_driver[] = {
+	/* FE DAIs: memory intefaces to CPU */
+	{
+		.name = "DL1",
+		.id = MT8186_MEMIF_DL1,
+		.playback = {
+			.stream_name = "DL1",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "DL12",
+		.id = MT8186_MEMIF_DL12,
+		.playback = {
+			.stream_name = "DL12",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "DL2",
+		.id = MT8186_MEMIF_DL2,
+		.playback = {
+			.stream_name = "DL2",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "DL3",
+		.id = MT8186_MEMIF_DL3,
+		.playback = {
+			.stream_name = "DL3",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "DL4",
+		.id = MT8186_MEMIF_DL4,
+		.playback = {
+			.stream_name = "DL4",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "DL5",
+		.id = MT8186_MEMIF_DL5,
+		.playback = {
+			.stream_name = "DL5",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "DL6",
+		.id = MT8186_MEMIF_DL6,
+		.playback = {
+			.stream_name = "DL6",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "DL7",
+		.id = MT8186_MEMIF_DL7,
+		.playback = {
+			.stream_name = "DL7",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "DL8",
+		.id = MT8186_MEMIF_DL8,
+		.playback = {
+			.stream_name = "DL8",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "UL1",
+		.id = MT8186_MEMIF_VUL12,
+		.capture = {
+			.stream_name = "UL1",
+			.channels_min = 1,
+			.channels_max = 4,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "UL2",
+		.id = MT8186_MEMIF_AWB,
+		.capture = {
+			.stream_name = "UL2",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "UL3",
+		.id = MT8186_MEMIF_VUL2,
+		.capture = {
+			.stream_name = "UL3",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "UL4",
+		.id = MT8186_MEMIF_AWB2,
+		.capture = {
+			.stream_name = "UL4",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "UL5",
+		.id = MT8186_MEMIF_VUL3,
+		.capture = {
+			.stream_name = "UL5",
+			.channels_min = 1,
+			.channels_max = 12,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "UL6",
+		.id = MT8186_MEMIF_VUL4,
+		.capture = {
+			.stream_name = "UL6",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "UL7",
+		.id = MT8186_MEMIF_VUL5,
+		.capture = {
+			.stream_name = "UL7",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	},
+	{
+		.name = "UL8",
+		.id = MT8186_MEMIF_VUL6,
+		.capture = {
+			.stream_name = "UL8",
+			.channels_min = 1,
+			.channels_max = 2,
+			.rates = MTK_PCM_RATES,
+			.formats = MTK_PCM_FORMATS,
+		},
+		.ops = &mt8186_memif_dai_ops,
+	}
+};
+
+/* kcontrol */
+static int mt8186_irq_cnt1_get(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+
+	ucontrol->value.integer.value[0] =
+		afe_priv->irq_cnt[MT8186_PRIMARY_MEMIF];
+
+	return 0;
+}
+
+static int mt8186_irq_cnt1_set(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	int memif_num = MT8186_PRIMARY_MEMIF;
+	struct mtk_base_afe_memif *memif = &afe->memif[memif_num];
+	int irq_id = memif->irq_usage;
+	int irq_cnt = afe_priv->irq_cnt[memif_num];
+
+	dev_dbg(afe->dev, "%s(), irq_id %d, irq_cnt = %d, value = %ld\n",
+		__func__, irq_id, irq_cnt, ucontrol->value.integer.value[0]);
+
+	if (irq_cnt == ucontrol->value.integer.value[0])
+		return 0;
+
+	irq_cnt = ucontrol->value.integer.value[0];
+	afe_priv->irq_cnt[memif_num] = irq_cnt;
+
+	if (pm_runtime_status_suspended(afe->dev) || irq_id < 0) {
+		dev_info(afe->dev, "%s(), suspended || irq_id %d, not set\n",
+			 __func__, irq_id);
+	} else {
+		struct mtk_base_afe_irq *irqs = &afe->irqs[irq_id];
+		const struct mtk_base_irq_data *irq_data = irqs->irq_data;
+
+		regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
+				   irq_data->irq_cnt_maskbit
+				   << irq_data->irq_cnt_shift,
+				   irq_cnt << irq_data->irq_cnt_shift);
+	}
+
+	return 0;
+}
+
+static int mt8186_irq_cnt2_get(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+
+	ucontrol->value.integer.value[0] =
+		afe_priv->irq_cnt[MT8186_RECORD_MEMIF];
+
+	return 0;
+}
+
+static int mt8186_irq_cnt2_set(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	int memif_num = MT8186_RECORD_MEMIF;
+	struct mtk_base_afe_memif *memif = &afe->memif[memif_num];
+	int irq_id = memif->irq_usage;
+	int irq_cnt = afe_priv->irq_cnt[memif_num];
+
+	dev_dbg(afe->dev, "%s(), irq_id %d, irq_cnt = %d, value = %ld\n",
+		__func__, irq_id, irq_cnt, ucontrol->value.integer.value[0]);
+
+	if (irq_cnt == ucontrol->value.integer.value[0])
+		return 0;
+
+	irq_cnt = ucontrol->value.integer.value[0];
+	afe_priv->irq_cnt[memif_num] = irq_cnt;
+
+	if (pm_runtime_status_suspended(afe->dev) || irq_id < 0) {
+		dev_info(afe->dev, "%s(), suspended || irq_id %d, not set\n",
+			 __func__, irq_id);
+	} else {
+		struct mtk_base_afe_irq *irqs = &afe->irqs[irq_id];
+		const struct mtk_base_irq_data *irq_data = irqs->irq_data;
+
+		regmap_update_bits(afe->regmap, irq_data->irq_cnt_reg,
+				   irq_data->irq_cnt_maskbit
+				   << irq_data->irq_cnt_shift,
+				   irq_cnt << irq_data->irq_cnt_shift);
+	}
+
+	return 0;
+}
+
+static int mt8186_record_xrun_assert_get(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	int xrun_assert = afe_priv->xrun_assert[MT8186_RECORD_MEMIF];
+
+	ucontrol->value.integer.value[0] = xrun_assert;
+
+	return 0;
+}
+
+static int mt8186_record_xrun_assert_set(struct snd_kcontrol *kcontrol,
+					 struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	int xrun_assert = ucontrol->value.integer.value[0];
+
+	dev_info(afe->dev, "%s(), xrun_assert %d\n", __func__, xrun_assert);
+	afe_priv->xrun_assert[MT8186_RECORD_MEMIF] = xrun_assert;
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new mt8186_pcm_kcontrols[] = {
+	SOC_SINGLE_EXT("Audio IRQ1 CNT", SND_SOC_NOPM, 0, 0x3ffff, 0,
+		       mt8186_irq_cnt1_get, mt8186_irq_cnt1_set),
+	SOC_SINGLE_EXT("Audio IRQ2 CNT", SND_SOC_NOPM, 0, 0x3ffff, 0,
+		       mt8186_irq_cnt2_get, mt8186_irq_cnt2_set),
+	SOC_SINGLE_EXT("record_xrun_assert", SND_SOC_NOPM, 0, 0x1, 0,
+		       mt8186_record_xrun_assert_get,
+		       mt8186_record_xrun_assert_set),
+};
+
+/* dma widget & routes*/
+static const struct snd_kcontrol_new memif_ul1_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN21,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN21,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH3 Switch", AFE_CONN21,
+				    I_ADDA_UL_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("TDM_IN_CH1 Switch", AFE_CONN21_1,
+				    I_TDM_IN_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul1_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN22,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN22,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH3 Switch", AFE_CONN22,
+				    I_ADDA_UL_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH4 Switch", AFE_CONN22,
+				    I_ADDA_UL_CH4, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("TDM_IN_CH2 Switch", AFE_CONN22_1,
+				    I_TDM_IN_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul1_ch3_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN9,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN9,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH3 Switch", AFE_CONN9,
+				    I_ADDA_UL_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("TDM_IN_CH3 Switch", AFE_CONN9_1,
+				    I_TDM_IN_CH3, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul1_ch4_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN10,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN10,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH3 Switch", AFE_CONN10,
+				    I_ADDA_UL_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH4 Switch", AFE_CONN10,
+				    I_ADDA_UL_CH4, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("TDM_IN_CH4 Switch", AFE_CONN10_1,
+				    I_TDM_IN_CH4, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul2_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH1 Switch", AFE_CONN5,
+				    I_I2S0_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1 Switch", AFE_CONN5,
+				    I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH1 Switch", AFE_CONN5,
+				    I_DL12_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1 Switch", AFE_CONN5,
+				    I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1 Switch", AFE_CONN5,
+				    I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH1 Switch", AFE_CONN5_1,
+				    I_DL4_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH1 Switch", AFE_CONN5_1,
+				    I_DL5_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL6_CH1 Switch", AFE_CONN5_1,
+				    I_DL6_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH1 Switch", AFE_CONN5,
+				    I_PCM_1_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH1 Switch", AFE_CONN5,
+				    I_I2S2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("CONNSYS_I2S_CH1 Switch", AFE_CONN5_1,
+				    I_CONNSYS_I2S_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("SRC_1_OUT_CH1 Switch", AFE_CONN5_1,
+				    I_SRC_1_OUT_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul2_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH2 Switch", AFE_CONN6,
+				    I_I2S0_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2 Switch", AFE_CONN6,
+				    I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH2 Switch", AFE_CONN6,
+				    I_DL12_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2 Switch", AFE_CONN6,
+				    I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2 Switch", AFE_CONN6,
+				    I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH2 Switch", AFE_CONN6_1,
+				    I_DL4_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH2 Switch", AFE_CONN6_1,
+				    I_DL5_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL6_CH2 Switch", AFE_CONN6_1,
+				    I_DL6_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH2 Switch", AFE_CONN6,
+				    I_PCM_1_CAP_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH2 Switch", AFE_CONN6,
+				    I_I2S2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("CONNSYS_I2S_CH2 Switch", AFE_CONN6_1,
+				    I_CONNSYS_I2S_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("SRC_1_OUT_CH2 Switch", AFE_CONN6_1,
+				    I_SRC_1_OUT_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul3_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("CONNSYS_I2S_CH1 Switch", AFE_CONN32_1,
+				    I_CONNSYS_I2S_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1 Switch", AFE_CONN32,
+				    I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1 Switch", AFE_CONN32,
+				    I_DL2_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul3_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("CONNSYS_I2S_CH2 Switch", AFE_CONN33_1,
+				    I_CONNSYS_I2S_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul4_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN38,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH1 Switch", AFE_CONN38,
+				    I_I2S0_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul4_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN39,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH2 Switch", AFE_CONN39,
+				    I_I2S0_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul5_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN44,
+				    I_ADDA_UL_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul5_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN45,
+				    I_ADDA_UL_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul6_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN46,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1 Switch", AFE_CONN46,
+				    I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH1 Switch", AFE_CONN46,
+				    I_DL12_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL6_CH1 Switch", AFE_CONN46_1,
+				    I_DL6_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1 Switch", AFE_CONN46,
+				    I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1 Switch", AFE_CONN46,
+				    I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH1 Switch", AFE_CONN46_1,
+				    I_DL4_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH1 Switch", AFE_CONN46,
+				    I_PCM_1_CAP_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("GAIN1_OUT_CH1 Switch", AFE_CONN46,
+				    I_GAIN1_OUT_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul6_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN47,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2 Switch", AFE_CONN47,
+				    I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH2 Switch", AFE_CONN47,
+				    I_DL12_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL6_CH2 Switch", AFE_CONN47_1,
+				    I_DL6_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2 Switch", AFE_CONN47,
+				    I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2 Switch", AFE_CONN47,
+				    I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH2 Switch", AFE_CONN47_1,
+				    I_DL4_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("PCM_1_CAP_CH2 Switch", AFE_CONN47,
+				    I_PCM_1_CAP_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("GAIN1_OUT_CH2 Switch", AFE_CONN47,
+				    I_GAIN1_OUT_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul7_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN48,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_GAIN2_OUT_CH1 Switch", AFE_CONN48,
+				    I_GAIN2_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_2_OUT_CH1 Switch", AFE_CONN48_1,
+				    I_SRC_2_OUT_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul7_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN49,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_GAIN2_OUT_CH2 Switch", AFE_CONN49,
+				    I_GAIN2_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC_2_OUT_CH2 Switch", AFE_CONN49_1,
+				    I_SRC_2_OUT_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul8_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN50,
+				    I_ADDA_UL_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new memif_ul8_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN51,
+				    I_ADDA_UL_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new hw_cm1_ch1_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("TDM_IN_CH1 Switch", AFE_CONN58_1,
+				    I_TDM_IN_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH1 Switch", AFE_CONN58,
+				    I_I2S0_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH1 Switch", AFE_CONN58,
+				    I_I2S2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN58,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1 Switch", AFE_CONN58,
+				    I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH1 Switch", AFE_CONN58,
+				    I_DL12_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH3 Switch", AFE_CONN58,
+				    I_DL12_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1 Switch", AFE_CONN58,
+				    I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1 Switch", AFE_CONN58,
+				    I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH1 Switch", AFE_CONN58_1,
+				    I_DL4_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH1 Switch", AFE_CONN58_1,
+				    I_DL5_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC1_OUT_CH1 Switch", AFE_CONN58_1,
+				    I_SRC_1_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC2_OUT_CH1 Switch", AFE_CONN58_1,
+				    I_SRC_2_OUT_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new hw_cm1_ch2_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("TDM_IN_CH2 Switch", AFE_CONN59_1,
+				    I_TDM_IN_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH2 Switch", AFE_CONN59,
+				    I_I2S0_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH2 Switch", AFE_CONN59,
+				    I_I2S2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN59,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2 Switch", AFE_CONN59,
+				    I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH2 Switch", AFE_CONN59,
+				    I_DL12_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH4 Switch", AFE_CONN59,
+				    I_DL12_CH4, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2 Switch", AFE_CONN59,
+				    I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2 Switch", AFE_CONN59,
+				    I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH2 Switch", AFE_CONN59_1,
+				    I_DL4_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH2 Switch", AFE_CONN59_1,
+				    I_DL5_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC1_OUT_CH2 Switch", AFE_CONN59_1,
+				    I_SRC_1_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC2_OUT_CH2 Switch", AFE_CONN59_1,
+				    I_SRC_2_OUT_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new hw_cm1_ch3_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("TDM_IN_CH3 Switch", AFE_CONN60_1,
+				    I_TDM_IN_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH1 Switch", AFE_CONN60,
+				    I_I2S0_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH1 Switch", AFE_CONN60,
+				    I_I2S2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN60,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1 Switch", AFE_CONN60,
+				    I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH1 Switch", AFE_CONN60,
+				    I_DL12_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH3 Switch", AFE_CONN60,
+				    I_DL12_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1 Switch", AFE_CONN60,
+				    I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1 Switch", AFE_CONN60,
+				    I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH1 Switch", AFE_CONN60_1,
+				    I_DL4_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH1 Switch", AFE_CONN60_1,
+				    I_DL5_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC1_OUT_CH1 Switch", AFE_CONN60_1,
+				    I_SRC_1_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC2_OUT_CH1 Switch", AFE_CONN60_1,
+				    I_SRC_2_OUT_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new hw_cm1_ch4_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("TDM_IN_CH4 Switch", AFE_CONN61_1,
+				    I_TDM_IN_CH4, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH2 Switch", AFE_CONN61,
+				    I_I2S0_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH2 Switch", AFE_CONN61,
+				    I_I2S2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN61,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2 Switch", AFE_CONN61,
+				    I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH2 Switch", AFE_CONN61,
+				    I_DL12_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH4 Switch", AFE_CONN61,
+				    I_DL12_CH4, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2 Switch", AFE_CONN61,
+				    I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2 Switch", AFE_CONN61,
+				    I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH2 Switch", AFE_CONN61_1,
+				    I_DL4_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH2 Switch", AFE_CONN61_1,
+				    I_DL5_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC1_OUT_CH2 Switch", AFE_CONN61_1,
+				    I_SRC_1_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC2_OUT_CH2 Switch", AFE_CONN61_1,
+				    I_SRC_2_OUT_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new hw_cm1_ch5_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("TDM_IN_CH5 Switch", AFE_CONN62_1,
+				    I_TDM_IN_CH5, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH1 Switch", AFE_CONN62,
+				    I_I2S0_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH1 Switch", AFE_CONN62,
+				    I_I2S2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN62,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1 Switch", AFE_CONN62,
+				    I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH1 Switch", AFE_CONN62,
+				    I_DL12_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH3 Switch", AFE_CONN62,
+				    I_DL12_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1 Switch", AFE_CONN62,
+				    I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1 Switch", AFE_CONN62,
+				    I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH1 Switch", AFE_CONN62_1,
+				    I_DL4_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH1 Switch", AFE_CONN62_1,
+				    I_DL5_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC1_OUT_CH1 Switch", AFE_CONN62_1,
+				    I_SRC_1_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC2_OUT_CH1 Switch", AFE_CONN62_1,
+				    I_SRC_2_OUT_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new hw_cm1_ch6_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("TDM_IN_CH6 Switch", AFE_CONN63_1,
+				    I_TDM_IN_CH6, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH2 Switch", AFE_CONN63,
+				    I_I2S0_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH2 Switch", AFE_CONN63,
+				    I_I2S2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN63,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2 Switch", AFE_CONN63,
+				    I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH2 Switch", AFE_CONN63,
+				    I_DL12_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH4 Switch", AFE_CONN63,
+				    I_DL12_CH4, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2 Switch", AFE_CONN63,
+				    I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2 Switch", AFE_CONN63,
+				    I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH2 Switch", AFE_CONN63_1,
+				    I_DL4_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH2 Switch", AFE_CONN63_1,
+				    I_DL5_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC1_OUT_CH2 Switch", AFE_CONN63_1,
+				    I_SRC_1_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC2_OUT_CH2 Switch", AFE_CONN63_1,
+				    I_SRC_2_OUT_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new hw_cm1_ch7_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("TDM_IN_CH7 Switch", AFE_CONN64_1,
+				    I_TDM_IN_CH7, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH1 Switch", AFE_CONN64,
+				    I_I2S0_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH1 Switch", AFE_CONN64,
+				    I_I2S2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN64,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1 Switch", AFE_CONN64,
+				    I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH1v", AFE_CONN64,
+				    I_DL12_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH3 Switch", AFE_CONN64,
+				    I_DL12_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1 Switch", AFE_CONN64,
+				    I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1 Switch", AFE_CONN64,
+				    I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH1 Switch", AFE_CONN64_1,
+				    I_DL4_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH1 Switch", AFE_CONN64_1,
+				    I_DL5_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC1_OUT_CH1 Switch", AFE_CONN64_1,
+				    I_SRC_1_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC2_OUT_CH1 Switch", AFE_CONN64_1,
+				    I_SRC_2_OUT_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new hw_cm1_ch8_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("TDM_IN_CH8 Switch", AFE_CONN65_1,
+				    I_TDM_IN_CH8, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH2 Switch", AFE_CONN65,
+				    I_I2S0_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH2 Switch", AFE_CONN65,
+				    I_I2S2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN65,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2 Switch", AFE_CONN65,
+				    I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH2 Switch", AFE_CONN65,
+				    I_DL12_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH4 Switch", AFE_CONN65,
+				    I_DL12_CH4, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2 Switch", AFE_CONN65,
+				    I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2 Switch", AFE_CONN65,
+				    I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH2 Switch", AFE_CONN65_1,
+				    I_DL4_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH2 Switch", AFE_CONN65_1,
+				    I_DL5_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC1_OUT_CH2 Switch", AFE_CONN65_1,
+				    I_SRC_1_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC2_OUT_CH2 Switch", AFE_CONN65_1,
+				    I_SRC_2_OUT_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new hw_cm1_ch9_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH1 Switch", AFE_CONN66,
+				    I_I2S0_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH1 Switch", AFE_CONN66,
+				    I_I2S2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN66,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1 Switch", AFE_CONN66,
+				    I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH1 Switch", AFE_CONN66,
+				    I_DL12_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH3 Switch", AFE_CONN66,
+				    I_DL12_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1 Switch", AFE_CONN66,
+				    I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1 Switch", AFE_CONN66,
+				    I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH1 Switch", AFE_CONN66_1,
+				    I_DL4_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH1 Switch", AFE_CONN66_1,
+				    I_DL5_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC1_OUT_CH1 Switch", AFE_CONN66_1,
+				    I_SRC_1_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC2_OUT_CH1 Switch", AFE_CONN66_1,
+				    I_SRC_2_OUT_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new hw_cm1_ch10_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH2 Switch", AFE_CONN67,
+				    I_I2S0_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH2 Switch", AFE_CONN67,
+				    I_I2S2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN67,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2 Switch", AFE_CONN67,
+				    I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH2 Switch", AFE_CONN67,
+				    I_DL12_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH4 Switch", AFE_CONN67,
+				    I_DL12_CH4, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2 Switch", AFE_CONN67,
+				    I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2 Switch", AFE_CONN67,
+				    I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH2 Switch", AFE_CONN67_1,
+				    I_DL4_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH2 Switch", AFE_CONN67_1,
+				    I_DL5_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC1_OUT_CH2 Switch", AFE_CONN67_1,
+				    I_SRC_1_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC2_OUT_CH2 Switch", AFE_CONN67_1,
+				    I_SRC_2_OUT_CH2, 1, 0),
+};
+
+static const struct snd_kcontrol_new hw_cm1_ch11_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH1 Switch", AFE_CONN68,
+				    I_I2S0_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH1 Switch", AFE_CONN68,
+				    I_I2S2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH1 Switch", AFE_CONN68,
+				    I_ADDA_UL_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH1 Switch", AFE_CONN68,
+				    I_DL1_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH1 Switch", AFE_CONN68,
+				    I_DL12_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH3 Switch", AFE_CONN68,
+				    I_DL12_CH3, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH1 Switch", AFE_CONN68,
+				    I_DL2_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH1 Switch", AFE_CONN68,
+				    I_DL3_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH1 Switch", AFE_CONN68_1,
+				    I_DL4_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH1 Switch", AFE_CONN68_1,
+				    I_DL5_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC1_OUT_CH1 Switch", AFE_CONN68_1,
+				    I_SRC_1_OUT_CH1, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC2_OUT_CH1 Switch", AFE_CONN68_1,
+				    I_SRC_2_OUT_CH1, 1, 0),
+};
+
+static const struct snd_kcontrol_new hw_cm1_ch12_mix[] = {
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S0_CH2 Switch", AFE_CONN69,
+				    I_I2S0_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("I2S2_CH2 Switch", AFE_CONN69,
+				    I_I2S2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("ADDA_UL_CH2 Switch", AFE_CONN69,
+				    I_ADDA_UL_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL1_CH2 Switch", AFE_CONN69,
+				    I_DL1_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH2 Switch", AFE_CONN69,
+				    I_DL12_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL12_CH4 Switch", AFE_CONN69,
+				    I_DL12_CH4, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL2_CH2 Switch", AFE_CONN69,
+				    I_DL2_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL3_CH2 Switch", AFE_CONN69,
+				    I_DL3_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL4_CH2 Switch", AFE_CONN69_1,
+				    I_DL4_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("DL5_CH2 Switch", AFE_CONN69_1,
+				    I_DL5_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC1_OUT_CH2 Switch", AFE_CONN69_1,
+				    I_SRC_1_OUT_CH2, 1, 0),
+	SOC_DAPM_SINGLE_AUTODISABLE("HW_SRC2_OUT_CH2 Switch", AFE_CONN69_1,
+				    I_SRC_2_OUT_CH2, 1, 0),
+};
+
+/* ADDA UL MUX */
+enum {
+	UL5_IN_MUX_CM1 = 0,
+	UL5_IN_MUX_NORMAL,
+	UL5_IN_MUX_MASK = 0x1,
+};
+
+static const char * const ul5_in_mux_map[] = {
+	"UL5_IN_FROM_CM1", "UL5_IN_FROM_Normal"
+};
+
+static int ul5_in_map_value[] = {
+	UL5_IN_MUX_CM1,
+	UL5_IN_MUX_NORMAL,
+};
+
+static SOC_VALUE_ENUM_SINGLE_DECL(ul5_in_mux_map_enum,
+				  AFE_CM1_CON,
+				  VUL3_BYPASS_CM_SFT,
+				  VUL3_BYPASS_CM_MASK,
+				  ul5_in_mux_map,
+				  ul5_in_map_value);
+
+static const struct snd_kcontrol_new ul5_in_mux_control =
+	SOC_DAPM_ENUM("UL5_IN_MUX Select", ul5_in_mux_map_enum);
+
+static const struct snd_soc_dapm_widget mt8186_memif_widgets[] = {
+	/* inter-connections */
+	SND_SOC_DAPM_MIXER("UL1_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul1_ch1_mix, ARRAY_SIZE(memif_ul1_ch1_mix)),
+	SND_SOC_DAPM_MIXER("UL1_CH2", SND_SOC_NOPM, 0, 0,
+			   memif_ul1_ch2_mix, ARRAY_SIZE(memif_ul1_ch2_mix)),
+	SND_SOC_DAPM_MIXER("UL1_CH3", SND_SOC_NOPM, 0, 0,
+			   memif_ul1_ch3_mix, ARRAY_SIZE(memif_ul1_ch3_mix)),
+	SND_SOC_DAPM_MIXER("UL1_CH4", SND_SOC_NOPM, 0, 0,
+			   memif_ul1_ch4_mix, ARRAY_SIZE(memif_ul1_ch4_mix)),
+
+	SND_SOC_DAPM_MIXER("UL2_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul2_ch1_mix, ARRAY_SIZE(memif_ul2_ch1_mix)),
+	SND_SOC_DAPM_MIXER("UL2_CH2", SND_SOC_NOPM, 0, 0,
+			   memif_ul2_ch2_mix, ARRAY_SIZE(memif_ul2_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("UL3_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul3_ch1_mix, ARRAY_SIZE(memif_ul3_ch1_mix)),
+	SND_SOC_DAPM_MIXER("UL3_CH2", SND_SOC_NOPM, 0, 0,
+			   memif_ul3_ch2_mix, ARRAY_SIZE(memif_ul3_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("UL4_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul4_ch1_mix, ARRAY_SIZE(memif_ul4_ch1_mix)),
+	SND_SOC_DAPM_MIXER("UL4_CH2", SND_SOC_NOPM, 0, 0,
+			   memif_ul4_ch2_mix, ARRAY_SIZE(memif_ul4_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("UL5_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul5_ch1_mix, ARRAY_SIZE(memif_ul5_ch1_mix)),
+	SND_SOC_DAPM_MIXER("UL5_CH2", SND_SOC_NOPM, 0, 0,
+			   memif_ul5_ch2_mix, ARRAY_SIZE(memif_ul5_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("UL6_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul6_ch1_mix, ARRAY_SIZE(memif_ul6_ch1_mix)),
+	SND_SOC_DAPM_MIXER("UL6_CH2", SND_SOC_NOPM, 0, 0,
+			   memif_ul6_ch2_mix, ARRAY_SIZE(memif_ul6_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("UL7_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul7_ch1_mix, ARRAY_SIZE(memif_ul7_ch1_mix)),
+	SND_SOC_DAPM_MIXER("UL7_CH2", SND_SOC_NOPM, 0, 0,
+			   memif_ul7_ch2_mix, ARRAY_SIZE(memif_ul7_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("UL8_CH1", SND_SOC_NOPM, 0, 0,
+			   memif_ul8_ch1_mix, ARRAY_SIZE(memif_ul8_ch1_mix)),
+	SND_SOC_DAPM_MIXER("UL8_CH2", SND_SOC_NOPM, 0, 0,
+			   memif_ul8_ch2_mix, ARRAY_SIZE(memif_ul8_ch2_mix)),
+
+	SND_SOC_DAPM_MIXER("UL5_2CH", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	SND_SOC_DAPM_MIXER("HW_CM1", SND_SOC_NOPM, 0, 0, NULL, 0),
+
+	/* CM1 en*/
+	SND_SOC_DAPM_SUPPLY_S("CM1_EN", 0, AFE_CM1_CON,
+			      CHANNEL_MERGE0_EN_SFT, 0, NULL,
+			      SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMD),
+
+	SND_SOC_DAPM_MIXER("HW_CM1_CH1", SND_SOC_NOPM, 0, 0,
+			   hw_cm1_ch1_mix, ARRAY_SIZE(hw_cm1_ch1_mix)),
+	SND_SOC_DAPM_MIXER("HW_CM1_CH2", SND_SOC_NOPM, 0, 0,
+			   hw_cm1_ch2_mix, ARRAY_SIZE(hw_cm1_ch2_mix)),
+	SND_SOC_DAPM_MIXER("HW_CM1_CH3", SND_SOC_NOPM, 0, 0,
+			   hw_cm1_ch3_mix, ARRAY_SIZE(hw_cm1_ch3_mix)),
+	SND_SOC_DAPM_MIXER("HW_CM1_CH4", SND_SOC_NOPM, 0, 0,
+			   hw_cm1_ch4_mix, ARRAY_SIZE(hw_cm1_ch4_mix)),
+	SND_SOC_DAPM_MIXER("HW_CM1_CH5", SND_SOC_NOPM, 0, 0,
+			   hw_cm1_ch5_mix, ARRAY_SIZE(hw_cm1_ch5_mix)),
+	SND_SOC_DAPM_MIXER("HW_CM1_CH6", SND_SOC_NOPM, 0, 0,
+			   hw_cm1_ch6_mix, ARRAY_SIZE(hw_cm1_ch6_mix)),
+	SND_SOC_DAPM_MIXER("HW_CM1_CH7", SND_SOC_NOPM, 0, 0,
+			   hw_cm1_ch7_mix, ARRAY_SIZE(hw_cm1_ch7_mix)),
+	SND_SOC_DAPM_MIXER("HW_CM1_CH8", SND_SOC_NOPM, 0, 0,
+			   hw_cm1_ch8_mix, ARRAY_SIZE(hw_cm1_ch8_mix)),
+	SND_SOC_DAPM_MIXER("HW_CM1_CH9", SND_SOC_NOPM, 0, 0,
+			   hw_cm1_ch9_mix, ARRAY_SIZE(hw_cm1_ch9_mix)),
+	SND_SOC_DAPM_MIXER("HW_CM1_CH10", SND_SOC_NOPM, 0, 0,
+			   hw_cm1_ch10_mix, ARRAY_SIZE(hw_cm1_ch10_mix)),
+	SND_SOC_DAPM_MIXER("HW_CM1_CH11", SND_SOC_NOPM, 0, 0,
+			   hw_cm1_ch11_mix, ARRAY_SIZE(hw_cm1_ch11_mix)),
+	SND_SOC_DAPM_MIXER("HW_CM1_CH12", SND_SOC_NOPM, 0, 0,
+			   hw_cm1_ch12_mix, ARRAY_SIZE(hw_cm1_ch12_mix)),
+
+	SND_SOC_DAPM_MUX("UL5_IN_MUX", SND_SOC_NOPM, 0, 0,
+			 &ul5_in_mux_control),
+
+	SND_SOC_DAPM_INPUT("UL1_VIRTUAL_INPUT"),
+	SND_SOC_DAPM_INPUT("UL2_VIRTUAL_INPUT"),
+	SND_SOC_DAPM_INPUT("UL3_VIRTUAL_INPUT"),
+	SND_SOC_DAPM_INPUT("UL4_VIRTUAL_INPUT"),
+	SND_SOC_DAPM_INPUT("UL5_VIRTUAL_INPUT"),
+	SND_SOC_DAPM_INPUT("UL6_VIRTUAL_INPUT"),
+};
+
+static const struct snd_soc_dapm_route mt8186_memif_routes[] = {
+	{"UL1", NULL, "UL1_CH1"},
+	{"UL1", NULL, "UL1_CH2"},
+	{"UL1", NULL, "UL1_CH3"},
+	{"UL1", NULL, "UL1_CH4"},
+	{"UL1_CH1", "ADDA_UL_CH1 Switch", "ADDA_UL_Mux"},
+	{"UL1_CH1", "ADDA_UL_CH2 Switch", "ADDA_UL_Mux"},
+	{"UL1_CH2", "ADDA_UL_CH1 Switch", "ADDA_UL_Mux"},
+	{"UL1_CH2", "ADDA_UL_CH2 Switch", "ADDA_UL_Mux"},
+	{"UL1_CH3", "ADDA_UL_CH1 Switch", "ADDA_UL_Mux"},
+	{"UL1_CH3", "ADDA_UL_CH2 Switch", "ADDA_UL_Mux"},
+	{"UL1_CH4", "ADDA_UL_CH1 Switch", "ADDA_UL_Mux"},
+	{"UL1_CH4", "ADDA_UL_CH2 Switch", "ADDA_UL_Mux"},
+	{"UL1_CH1", "TDM_IN_CH1 Switch", "TDM IN"},
+	{"UL1_CH2", "TDM_IN_CH2 Switch", "TDM IN"},
+	{"UL1_CH3", "TDM_IN_CH3 Switch", "TDM IN"},
+	{"UL1_CH4", "TDM_IN_CH4 Switch", "TDM IN"},
+
+	{"UL2", NULL, "UL2_CH1"},
+	{"UL2", NULL, "UL2_CH2"},
+
+	/* cannot connect FE to FE directly */
+	{"UL2_CH1", "DL1_CH1 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH2", "DL1_CH2 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH1", "DL12_CH1 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH2", "DL12_CH2 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH1", "DL6_CH1 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH2", "DL6_CH2 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH1", "DL2_CH1 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH2", "DL2_CH2 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH1", "DL3_CH1 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH2", "DL3_CH2 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH1", "DL4_CH1 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH2", "DL4_CH2 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH1", "DL5_CH1 Switch", "Hostless_UL2 UL"},
+	{"UL2_CH2", "DL5_CH2 Switch", "Hostless_UL2 UL"},
+
+	{"Hostless_UL2 UL", NULL, "UL2_VIRTUAL_INPUT"},
+
+	{"UL2_CH1", "I2S0_CH1 Switch", "I2S0"},
+	{"UL2_CH2", "I2S0_CH2 Switch", "I2S0"},
+	{"UL2_CH1", "I2S2_CH1 Switch", "I2S2"},
+	{"UL2_CH2", "I2S2_CH2 Switch", "I2S2"},
+
+	{"UL2_CH1", "PCM_1_CAP_CH1 Switch", "PCM 1 Capture"},
+	{"UL2_CH2", "PCM_1_CAP_CH2 Switch", "PCM 1 Capture"},
+
+	{"UL2_CH1", "CONNSYS_I2S_CH1 Switch", "Connsys I2S"},
+	{"UL2_CH2", "CONNSYS_I2S_CH2 Switch", "Connsys I2S"},
+
+	{"UL2_CH1", "SRC_1_OUT_CH1 Switch", "HW_SRC_1_Out"},
+	{"UL2_CH2", "SRC_1_OUT_CH2 Switch", "HW_SRC_1_Out"},
+
+	{"UL3", NULL, "UL3_CH1"},
+	{"UL3", NULL, "UL3_CH2"},
+	{"UL3_CH1", "CONNSYS_I2S_CH1 Switch", "Connsys I2S"},
+	{"UL3_CH2", "CONNSYS_I2S_CH2 Switch", "Connsys I2S"},
+
+	{"UL4", NULL, "UL4_CH1"},
+	{"UL4", NULL, "UL4_CH2"},
+	{"UL4_CH1", "ADDA_UL_CH1 Switch", "ADDA_UL_Mux"},
+	{"UL4_CH2", "ADDA_UL_CH2 Switch", "ADDA_UL_Mux"},
+	{"UL4_CH1", "I2S0_CH1 Switch", "I2S0"},
+	{"UL4_CH2", "I2S0_CH2 Switch", "I2S0"},
+
+	{"UL5", NULL, "UL5_IN_MUX"},
+	{"UL5_IN_MUX", "UL5_IN_FROM_Normal", "UL5_2CH"},
+	{"UL5_IN_MUX", "UL5_IN_FROM_CM1", "HW_CM1"},
+	{"UL5_2CH", NULL, "UL5_CH1"},
+	{"UL5_2CH", NULL, "UL5_CH2"},
+	{"UL5_CH1", "ADDA_UL_CH1 Switch", "ADDA_UL_Mux"},
+	{"UL5_CH2", "ADDA_UL_CH2 Switch", "ADDA_UL_Mux"},
+	{"HW_CM1", NULL, "CM1_EN"},
+	{"HW_CM1", NULL, "HW_CM1_CH1"},
+	{"HW_CM1", NULL, "HW_CM1_CH2"},
+	{"HW_CM1", NULL, "HW_CM1_CH3"},
+	{"HW_CM1", NULL, "HW_CM1_CH4"},
+	{"HW_CM1", NULL, "HW_CM1_CH5"},
+	{"HW_CM1", NULL, "HW_CM1_CH6"},
+	{"HW_CM1", NULL, "HW_CM1_CH7"},
+	{"HW_CM1", NULL, "HW_CM1_CH8"},
+	{"HW_CM1", NULL, "HW_CM1_CH9"},
+	{"HW_CM1", NULL, "HW_CM1_CH10"},
+	{"HW_CM1", NULL, "HW_CM1_CH11"},
+	{"HW_CM1", NULL, "HW_CM1_CH12"},
+	{"HW_CM1_CH1", "TDM_IN_CH1 Switch", "TDM IN"},
+	{"HW_CM1_CH2", "TDM_IN_CH2 Switch", "TDM IN"},
+	{"HW_CM1_CH3", "TDM_IN_CH3 Switch", "TDM IN"},
+	{"HW_CM1_CH4", "TDM_IN_CH4 Switch", "TDM IN"},
+	{"HW_CM1_CH5", "TDM_IN_CH5 Switch", "TDM IN"},
+	{"HW_CM1_CH6", "TDM_IN_CH6 Switch", "TDM IN"},
+	{"HW_CM1_CH7", "TDM_IN_CH7 Switch", "TDM IN"},
+	{"HW_CM1_CH8", "TDM_IN_CH8 Switch", "TDM IN"},
+	{"HW_CM1_CH9", "DL1_CH1 Switch", "Hostless_UL5 UL"},
+	{"HW_CM1_CH10", "DL1_CH2 Switch", "Hostless_UL5 UL"},
+
+	{"HW_CM1_CH3", "DL1_CH1 Switch", "Hostless_UL5 UL"},
+	{"HW_CM1_CH4", "DL1_CH2 Switch", "Hostless_UL5 UL"},
+
+	{"HW_CM1_CH3", "DL3_CH1 Switch", "Hostless_UL5 UL"},
+	{"HW_CM1_CH4", "DL3_CH2 Switch", "Hostless_UL5 UL"},
+
+	{"HW_CM1_CH5", "HW_SRC1_OUT_CH1 Switch", "HW_SRC_1_Out"},
+	{"HW_CM1_CH6", "HW_SRC1_OUT_CH2 Switch", "HW_SRC_1_Out"},
+
+	{"HW_CM1_CH9", "DL12_CH1 Switch", "Hostless_UL5 UL"},
+	{"HW_CM1_CH10", "DL12_CH2 Switch", "Hostless_UL5 UL"},
+	{"HW_CM1_CH11", "DL12_CH3 Switch", "Hostless_UL5 UL"},
+	{"HW_CM1_CH12", "DL12_CH4 Switch", "Hostless_UL5 UL"},
+
+	{"Hostless_UL5 UL", NULL, "UL5_VIRTUAL_INPUT"},
+
+	{"UL6", NULL, "UL6_CH1"},
+	{"UL6", NULL, "UL6_CH2"},
+
+	{"UL6_CH1", "ADDA_UL_CH1 Switch", "ADDA_UL_Mux"},
+	{"UL6_CH2", "ADDA_UL_CH2 Switch", "ADDA_UL_Mux"},
+	{"UL6_CH1", "DL1_CH1 Switch", "Hostless_UL6 UL"},
+	{"UL6_CH2", "DL1_CH2 Switch", "Hostless_UL6 UL"},
+	{"UL6_CH1", "DL2_CH1 Switch", "Hostless_UL6 UL"},
+	{"UL6_CH2", "DL2_CH2 Switch", "Hostless_UL6 UL"},
+	{"UL6_CH1", "DL12_CH1 Switch", "Hostless_UL6 UL"},
+	{"UL6_CH2", "DL12_CH2 Switch", "Hostless_UL6 UL"},
+	{"UL6_CH1", "DL6_CH1 Switch", "Hostless_UL6 UL"},
+	{"UL6_CH2", "DL6_CH2 Switch", "Hostless_UL6 UL"},
+	{"UL6_CH1", "DL3_CH1 Switch", "Hostless_UL6 UL"},
+	{"UL6_CH2", "DL3_CH2 Switch", "Hostless_UL6 UL"},
+	{"UL6_CH1", "DL4_CH1 Switch", "Hostless_UL6 UL"},
+	{"UL6_CH2", "DL4_CH2 Switch", "Hostless_UL6 UL"},
+	{"Hostless_UL6 UL", NULL, "UL6_VIRTUAL_INPUT"},
+	{"UL6_CH1", "PCM_1_CAP_CH1 Switch", "PCM 1 Capture"},
+	{"UL6_CH2", "PCM_1_CAP_CH2 Switch", "PCM 1 Capture"},
+	{"UL6_CH1", "GAIN1_OUT_CH1 Switch", "HW Gain 1 Out"},
+	{"UL6_CH2", "GAIN1_OUT_CH2 Switch", "HW Gain 1 Out"},
+
+	{"UL7", NULL, "UL7_CH1"},
+	{"UL7", NULL, "UL7_CH2"},
+	{"UL7_CH1", "ADDA_UL_CH1 Switch", "ADDA_UL_Mux"},
+	{"UL7_CH2", "ADDA_UL_CH2 Switch", "ADDA_UL_Mux"},
+	{"UL7_CH1", "HW_GAIN2_OUT_CH1 Switch", "HW Gain 2 Out"},
+	{"UL7_CH2", "HW_GAIN2_OUT_CH2 Switch", "HW Gain 2 Out"},
+	{"UL7_CH1", "HW_SRC_2_OUT_CH1 Switch", "HW_SRC_2_Out"},
+	{"UL7_CH2", "HW_SRC_2_OUT_CH2 Switch", "HW_SRC_2_Out"},
+
+	{"UL8", NULL, "UL8_CH1"},
+	{"UL8", NULL, "UL8_CH2"},
+	{"UL8_CH1", "ADDA_UL_CH1 Switch", "ADDA_UL_Mux"},
+	{"UL8_CH2", "ADDA_UL_CH2 Switch", "ADDA_UL_Mux"},
+
+	{"HW_GAIN2_IN_CH1", "ADDA_UL_CH1 Switch", "ADDA_UL_Mux"},
+	{"HW_GAIN2_IN_CH2", "ADDA_UL_CH2 Switch", "ADDA_UL_Mux"},
+};
+
+static const struct mtk_base_memif_data memif_data[MT8186_MEMIF_NUM] = {
+	[MT8186_MEMIF_DL1] = {
+		.name = "DL1",
+		.id = MT8186_MEMIF_DL1,
+		.reg_ofs_base = AFE_DL1_BASE,
+		.reg_ofs_cur = AFE_DL1_CUR,
+		.reg_ofs_end = AFE_DL1_END,
+		.reg_ofs_base_msb = AFE_DL1_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_DL1_CUR_MSB,
+		.reg_ofs_end_msb = AFE_DL1_END_MSB,
+		.fs_reg = AFE_DL1_CON0,
+		.fs_shift = DL1_MODE_SFT,
+		.fs_maskbit = DL1_MODE_MASK,
+		.mono_reg = AFE_DL1_CON0,
+		.mono_shift = DL1_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = DL1_ON_SFT,
+		.hd_reg = AFE_DL1_CON0,
+		.hd_shift = DL1_HD_MODE_SFT,
+		.hd_align_reg = AFE_DL1_CON0,
+		.hd_align_mshift = DL1_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.pbuf_reg = AFE_DL1_CON0,
+		.pbuf_mask = DL1_PBUF_SIZE_MASK,
+		.pbuf_shift = DL1_PBUF_SIZE_SFT,
+		.minlen_reg = AFE_DL1_CON0,
+		.minlen_mask = DL1_MINLEN_MASK,
+		.minlen_shift = DL1_MINLEN_SFT,
+	},
+	[MT8186_MEMIF_DL12] = {
+		.name = "DL12",
+		.id = MT8186_MEMIF_DL12,
+		.reg_ofs_base = AFE_DL12_BASE,
+		.reg_ofs_cur = AFE_DL12_CUR,
+		.reg_ofs_end = AFE_DL12_END,
+		.reg_ofs_base_msb = AFE_DL12_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_DL12_CUR_MSB,
+		.reg_ofs_end_msb = AFE_DL12_END_MSB,
+		.fs_reg = AFE_DL12_CON0,
+		.fs_shift = DL12_MODE_SFT,
+		.fs_maskbit = DL12_MODE_MASK,
+		.mono_reg = AFE_DL12_CON0,
+		.mono_shift = DL12_MONO_SFT,
+		.quad_ch_reg = AFE_DL12_CON0,
+		.quad_ch_mask = DL12_4CH_EN_MASK,
+		.quad_ch_shift = DL12_4CH_EN_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = DL12_ON_SFT,
+		.hd_reg = AFE_DL12_CON0,
+		.hd_shift = DL12_HD_MODE_SFT,
+		.hd_align_reg = AFE_DL12_CON0,
+		.hd_align_mshift = DL12_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.pbuf_reg = AFE_DL12_CON0,
+		.pbuf_mask = DL12_PBUF_SIZE_MASK,
+		.pbuf_shift = DL12_PBUF_SIZE_SFT,
+		.minlen_reg = AFE_DL12_CON0,
+		.minlen_mask = DL12_MINLEN_MASK,
+		.minlen_shift = DL12_MINLEN_SFT,
+	},
+	[MT8186_MEMIF_DL2] = {
+		.name = "DL2",
+		.id = MT8186_MEMIF_DL2,
+		.reg_ofs_base = AFE_DL2_BASE,
+		.reg_ofs_cur = AFE_DL2_CUR,
+		.reg_ofs_end = AFE_DL2_END,
+		.reg_ofs_base_msb = AFE_DL2_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_DL2_CUR_MSB,
+		.reg_ofs_end_msb = AFE_DL2_END_MSB,
+		.fs_reg = AFE_DL2_CON0,
+		.fs_shift = DL2_MODE_SFT,
+		.fs_maskbit = DL2_MODE_MASK,
+		.mono_reg = AFE_DL2_CON0,
+		.mono_shift = DL2_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = DL2_ON_SFT,
+		.hd_reg = AFE_DL2_CON0,
+		.hd_shift = DL2_HD_MODE_SFT,
+		.hd_align_reg = AFE_DL2_CON0,
+		.hd_align_mshift = DL2_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.pbuf_reg = AFE_DL2_CON0,
+		.pbuf_mask = DL2_PBUF_SIZE_MASK,
+		.pbuf_shift = DL2_PBUF_SIZE_SFT,
+		.minlen_reg = AFE_DL2_CON0,
+		.minlen_mask = DL2_MINLEN_MASK,
+		.minlen_shift = DL2_MINLEN_SFT,
+	},
+	[MT8186_MEMIF_DL3] = {
+		.name = "DL3",
+		.id = MT8186_MEMIF_DL3,
+		.reg_ofs_base = AFE_DL3_BASE,
+		.reg_ofs_cur = AFE_DL3_CUR,
+		.reg_ofs_end = AFE_DL3_END,
+		.reg_ofs_base_msb = AFE_DL3_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_DL3_CUR_MSB,
+		.reg_ofs_end_msb = AFE_DL3_END_MSB,
+		.fs_reg = AFE_DL3_CON0,
+		.fs_shift = DL3_MODE_SFT,
+		.fs_maskbit = DL3_MODE_MASK,
+		.mono_reg = AFE_DL3_CON0,
+		.mono_shift = DL3_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = DL3_ON_SFT,
+		.hd_reg = AFE_DL3_CON0,
+		.hd_shift = DL3_HD_MODE_SFT,
+		.hd_align_reg = AFE_DL3_CON0,
+		.hd_align_mshift = DL3_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.pbuf_reg = AFE_DL3_CON0,
+		.pbuf_mask = DL3_PBUF_SIZE_MASK,
+		.pbuf_shift = DL3_PBUF_SIZE_SFT,
+		.minlen_reg = AFE_DL3_CON0,
+		.minlen_mask = DL3_MINLEN_MASK,
+		.minlen_shift = DL3_MINLEN_SFT,
+	},
+	[MT8186_MEMIF_DL4] = {
+		.name = "DL4",
+		.id = MT8186_MEMIF_DL4,
+		.reg_ofs_base = AFE_DL4_BASE,
+		.reg_ofs_cur = AFE_DL4_CUR,
+		.reg_ofs_end = AFE_DL4_END,
+		.reg_ofs_base_msb = AFE_DL4_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_DL4_CUR_MSB,
+		.reg_ofs_end_msb = AFE_DL4_END_MSB,
+		.fs_reg = AFE_DL4_CON0,
+		.fs_shift = DL4_MODE_SFT,
+		.fs_maskbit = DL4_MODE_MASK,
+		.mono_reg = AFE_DL4_CON0,
+		.mono_shift = DL4_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = DL4_ON_SFT,
+		.hd_reg = AFE_DL4_CON0,
+		.hd_shift = DL4_HD_MODE_SFT,
+		.hd_align_reg = AFE_DL4_CON0,
+		.hd_align_mshift = DL4_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.pbuf_reg = AFE_DL4_CON0,
+		.pbuf_mask = DL4_PBUF_SIZE_MASK,
+		.pbuf_shift = DL4_PBUF_SIZE_SFT,
+		.minlen_reg = AFE_DL4_CON0,
+		.minlen_mask = DL4_MINLEN_MASK,
+		.minlen_shift = DL4_MINLEN_SFT,
+	},
+	[MT8186_MEMIF_DL5] = {
+		.name = "DL5",
+		.id = MT8186_MEMIF_DL5,
+		.reg_ofs_base = AFE_DL5_BASE,
+		.reg_ofs_cur = AFE_DL5_CUR,
+		.reg_ofs_end = AFE_DL5_END,
+		.reg_ofs_base_msb = AFE_DL5_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_DL5_CUR_MSB,
+		.reg_ofs_end_msb = AFE_DL5_END_MSB,
+		.fs_reg = AFE_DL5_CON0,
+		.fs_shift = DL5_MODE_SFT,
+		.fs_maskbit = DL5_MODE_MASK,
+		.mono_reg = AFE_DL5_CON0,
+		.mono_shift = DL5_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = DL5_ON_SFT,
+		.hd_reg = AFE_DL5_CON0,
+		.hd_shift = DL5_HD_MODE_SFT,
+		.hd_align_reg = AFE_DL5_CON0,
+		.hd_align_mshift = DL5_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.pbuf_reg = AFE_DL5_CON0,
+		.pbuf_mask = DL5_PBUF_SIZE_MASK,
+		.pbuf_shift = DL5_PBUF_SIZE_SFT,
+		.minlen_reg = AFE_DL5_CON0,
+		.minlen_mask = DL5_MINLEN_MASK,
+		.minlen_shift = DL5_MINLEN_SFT,
+	},
+	[MT8186_MEMIF_DL6] = {
+		.name = "DL6",
+		.id = MT8186_MEMIF_DL6,
+		.reg_ofs_base = AFE_DL6_BASE,
+		.reg_ofs_cur = AFE_DL6_CUR,
+		.reg_ofs_end = AFE_DL6_END,
+		.reg_ofs_base_msb = AFE_DL6_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_DL6_CUR_MSB,
+		.reg_ofs_end_msb = AFE_DL6_END_MSB,
+		.fs_reg = AFE_DL6_CON0,
+		.fs_shift = DL6_MODE_SFT,
+		.fs_maskbit = DL6_MODE_MASK,
+		.mono_reg = AFE_DL6_CON0,
+		.mono_shift = DL6_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = DL6_ON_SFT,
+		.hd_reg = AFE_DL6_CON0,
+		.hd_shift = DL6_HD_MODE_SFT,
+		.hd_align_reg = AFE_DL6_CON0,
+		.hd_align_mshift = DL6_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.pbuf_reg = AFE_DL6_CON0,
+		.pbuf_mask = DL6_PBUF_SIZE_MASK,
+		.pbuf_shift = DL6_PBUF_SIZE_SFT,
+		.minlen_reg = AFE_DL6_CON0,
+		.minlen_mask = DL6_MINLEN_MASK,
+		.minlen_shift = DL6_MINLEN_SFT,
+	},
+	[MT8186_MEMIF_DL7] = {
+		.name = "DL7",
+		.id = MT8186_MEMIF_DL7,
+		.reg_ofs_base = AFE_DL7_BASE,
+		.reg_ofs_cur = AFE_DL7_CUR,
+		.reg_ofs_end = AFE_DL7_END,
+		.reg_ofs_base_msb = AFE_DL7_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_DL7_CUR_MSB,
+		.reg_ofs_end_msb = AFE_DL7_END_MSB,
+		.fs_reg = AFE_DL7_CON0,
+		.fs_shift = DL7_MODE_SFT,
+		.fs_maskbit = DL7_MODE_MASK,
+		.mono_reg = AFE_DL7_CON0,
+		.mono_shift = DL7_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = DL7_ON_SFT,
+		.hd_reg = AFE_DL7_CON0,
+		.hd_shift = DL7_HD_MODE_SFT,
+		.hd_align_reg = AFE_DL7_CON0,
+		.hd_align_mshift = DL7_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.pbuf_reg = AFE_DL7_CON0,
+		.pbuf_mask = DL7_PBUF_SIZE_MASK,
+		.pbuf_shift = DL7_PBUF_SIZE_SFT,
+		.minlen_reg = AFE_DL7_CON0,
+		.minlen_mask = DL7_MINLEN_MASK,
+		.minlen_shift = DL7_MINLEN_SFT,
+	},
+	[MT8186_MEMIF_DL8] = {
+		.name = "DL8",
+		.id = MT8186_MEMIF_DL8,
+		.reg_ofs_base = AFE_DL8_BASE,
+		.reg_ofs_cur = AFE_DL8_CUR,
+		.reg_ofs_end = AFE_DL8_END,
+		.reg_ofs_base_msb = AFE_DL8_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_DL8_CUR_MSB,
+		.reg_ofs_end_msb = AFE_DL8_END_MSB,
+		.fs_reg = AFE_DL8_CON0,
+		.fs_shift = DL8_MODE_SFT,
+		.fs_maskbit = DL8_MODE_MASK,
+		.mono_reg = AFE_DL8_CON0,
+		.mono_shift = DL8_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = DL8_ON_SFT,
+		.hd_reg = AFE_DL8_CON0,
+		.hd_shift = DL8_HD_MODE_SFT,
+		.hd_align_reg = AFE_DL8_CON0,
+		.hd_align_mshift = DL8_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+		.pbuf_reg = AFE_DL8_CON0,
+		.pbuf_mask = DL8_PBUF_SIZE_MASK,
+		.pbuf_shift = DL8_PBUF_SIZE_SFT,
+		.minlen_reg = AFE_DL8_CON0,
+		.minlen_mask = DL8_MINLEN_MASK,
+		.minlen_shift = DL8_MINLEN_SFT,
+	},
+	[MT8186_MEMIF_VUL12] = {
+		.name = "VUL12",
+		.id = MT8186_MEMIF_VUL12,
+		.reg_ofs_base = AFE_VUL12_BASE,
+		.reg_ofs_cur = AFE_VUL12_CUR,
+		.reg_ofs_end = AFE_VUL12_END,
+		.reg_ofs_base_msb = AFE_VUL12_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_VUL12_CUR_MSB,
+		.reg_ofs_end_msb = AFE_VUL12_END_MSB,
+		.fs_reg = AFE_VUL12_CON0,
+		.fs_shift = VUL12_MODE_SFT,
+		.fs_maskbit = VUL12_MODE_MASK,
+		.mono_reg = AFE_VUL12_CON0,
+		.mono_shift = VUL12_MONO_SFT,
+		.quad_ch_reg = AFE_VUL12_CON0,
+		.quad_ch_mask = VUL12_4CH_EN_MASK,
+		.quad_ch_shift = VUL12_4CH_EN_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = VUL12_ON_SFT,
+		.hd_reg = AFE_VUL12_CON0,
+		.hd_shift = VUL12_HD_MODE_SFT,
+		.hd_align_reg = AFE_VUL12_CON0,
+		.hd_align_mshift = VUL12_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8186_MEMIF_VUL2] = {
+		.name = "VUL2",
+		.id = MT8186_MEMIF_VUL2,
+		.reg_ofs_base = AFE_VUL2_BASE,
+		.reg_ofs_cur = AFE_VUL2_CUR,
+		.reg_ofs_end = AFE_VUL2_END,
+		.reg_ofs_base_msb = AFE_VUL2_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_VUL2_CUR_MSB,
+		.reg_ofs_end_msb = AFE_VUL2_END_MSB,
+		.fs_reg = AFE_VUL2_CON0,
+		.fs_shift = VUL2_MODE_SFT,
+		.fs_maskbit = VUL2_MODE_MASK,
+		.mono_reg = AFE_VUL2_CON0,
+		.mono_shift = VUL2_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = VUL2_ON_SFT,
+		.hd_reg = AFE_VUL2_CON0,
+		.hd_shift = VUL2_HD_MODE_SFT,
+		.hd_align_reg = AFE_VUL2_CON0,
+		.hd_align_mshift = VUL2_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8186_MEMIF_AWB] = {
+		.name = "AWB",
+		.id = MT8186_MEMIF_AWB,
+		.reg_ofs_base = AFE_AWB_BASE,
+		.reg_ofs_cur = AFE_AWB_CUR,
+		.reg_ofs_end = AFE_AWB_END,
+		.reg_ofs_base_msb = AFE_AWB_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_AWB_CUR_MSB,
+		.reg_ofs_end_msb = AFE_AWB_END_MSB,
+		.fs_reg = AFE_AWB_CON0,
+		.fs_shift = AWB_MODE_SFT,
+		.fs_maskbit = AWB_MODE_MASK,
+		.mono_reg = AFE_AWB_CON0,
+		.mono_shift = AWB_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = AWB_ON_SFT,
+		.hd_reg = AFE_AWB_CON0,
+		.hd_shift = AWB_HD_MODE_SFT,
+		.hd_align_reg = AFE_AWB_CON0,
+		.hd_align_mshift = AWB_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8186_MEMIF_AWB2] = {
+		.name = "AWB2",
+		.id = MT8186_MEMIF_AWB2,
+		.reg_ofs_base = AFE_AWB2_BASE,
+		.reg_ofs_cur = AFE_AWB2_CUR,
+		.reg_ofs_end = AFE_AWB2_END,
+		.reg_ofs_base_msb = AFE_AWB2_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_AWB2_CUR_MSB,
+		.reg_ofs_end_msb = AFE_AWB2_END_MSB,
+		.fs_reg = AFE_AWB2_CON0,
+		.fs_shift = AWB2_MODE_SFT,
+		.fs_maskbit = AWB2_MODE_MASK,
+		.mono_reg = AFE_AWB2_CON0,
+		.mono_shift = AWB2_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = AWB2_ON_SFT,
+		.hd_reg = AFE_AWB2_CON0,
+		.hd_shift = AWB2_HD_MODE_SFT,
+		.hd_align_reg = AFE_AWB2_CON0,
+		.hd_align_mshift = AWB2_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8186_MEMIF_VUL3] = {
+		.name = "VUL3",
+		.id = MT8186_MEMIF_VUL3,
+		.reg_ofs_base = AFE_VUL3_BASE,
+		.reg_ofs_cur = AFE_VUL3_CUR,
+		.reg_ofs_end = AFE_VUL3_END,
+		.reg_ofs_base_msb = AFE_VUL3_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_VUL3_CUR_MSB,
+		.reg_ofs_end_msb = AFE_VUL3_END_MSB,
+		.fs_reg = AFE_VUL3_CON0,
+		.fs_shift = VUL3_MODE_SFT,
+		.fs_maskbit = VUL3_MODE_MASK,
+		.mono_reg = AFE_VUL3_CON0,
+		.mono_shift = VUL3_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = VUL3_ON_SFT,
+		.hd_reg = AFE_VUL3_CON0,
+		.hd_shift = VUL3_HD_MODE_SFT,
+		.hd_align_reg = AFE_VUL3_CON0,
+		.hd_align_mshift = VUL3_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8186_MEMIF_VUL4] = {
+		.name = "VUL4",
+		.id = MT8186_MEMIF_VUL4,
+		.reg_ofs_base = AFE_VUL4_BASE,
+		.reg_ofs_cur = AFE_VUL4_CUR,
+		.reg_ofs_end = AFE_VUL4_END,
+		.reg_ofs_base_msb = AFE_VUL4_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_VUL4_CUR_MSB,
+		.reg_ofs_end_msb = AFE_VUL4_END_MSB,
+		.fs_reg = AFE_VUL4_CON0,
+		.fs_shift = VUL4_MODE_SFT,
+		.fs_maskbit = VUL4_MODE_MASK,
+		.mono_reg = AFE_VUL4_CON0,
+		.mono_shift = VUL4_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = VUL4_ON_SFT,
+		.hd_reg = AFE_VUL4_CON0,
+		.hd_shift = VUL4_HD_MODE_SFT,
+		.hd_align_reg = AFE_VUL4_CON0,
+		.hd_align_mshift = VUL4_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8186_MEMIF_VUL5] = {
+		.name = "VUL5",
+		.id = MT8186_MEMIF_VUL5,
+		.reg_ofs_base = AFE_VUL5_BASE,
+		.reg_ofs_cur = AFE_VUL5_CUR,
+		.reg_ofs_end = AFE_VUL5_END,
+		.reg_ofs_base_msb = AFE_VUL5_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_VUL5_CUR_MSB,
+		.reg_ofs_end_msb = AFE_VUL5_END_MSB,
+		.fs_reg = AFE_VUL5_CON0,
+		.fs_shift = VUL5_MODE_SFT,
+		.fs_maskbit = VUL5_MODE_MASK,
+		.mono_reg = AFE_VUL5_CON0,
+		.mono_shift = VUL5_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = VUL5_ON_SFT,
+		.hd_reg = AFE_VUL5_CON0,
+		.hd_shift = VUL5_HD_MODE_SFT,
+		.hd_align_reg = AFE_VUL5_CON0,
+		.hd_align_mshift = VUL5_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+	[MT8186_MEMIF_VUL6] = {
+		.name = "VUL6",
+		.id = MT8186_MEMIF_VUL6,
+		.reg_ofs_base = AFE_VUL6_BASE,
+		.reg_ofs_cur = AFE_VUL6_CUR,
+		.reg_ofs_end = AFE_VUL6_END,
+		.reg_ofs_base_msb = AFE_VUL6_BASE_MSB,
+		.reg_ofs_cur_msb = AFE_VUL6_CUR_MSB,
+		.reg_ofs_end_msb = AFE_VUL6_END_MSB,
+		.fs_reg = AFE_VUL6_CON0,
+		.fs_shift = VUL6_MODE_SFT,
+		.fs_maskbit = VUL6_MODE_MASK,
+		.mono_reg = AFE_VUL6_CON0,
+		.mono_shift = VUL6_MONO_SFT,
+		.enable_reg = AFE_DAC_CON0,
+		.enable_shift = VUL6_ON_SFT,
+		.hd_reg = AFE_VUL6_CON0,
+		.hd_shift = VUL6_HD_MODE_SFT,
+		.hd_align_reg = AFE_VUL6_CON0,
+		.hd_align_mshift = VUL6_HALIGN_SFT,
+		.agent_disable_reg = -1,
+		.agent_disable_shift = -1,
+		.msb_reg = -1,
+		.msb_shift = -1,
+	},
+};
+
+static const struct mtk_base_irq_data irq_data[MT8186_IRQ_NUM] = {
+	[MT8186_IRQ_0] = {
+		.id = MT8186_IRQ_0,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT0,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ0_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ0_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ0_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ0_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_1] = {
+		.id = MT8186_IRQ_1,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT1,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ1_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ1_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ1_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ1_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_2] = {
+		.id = MT8186_IRQ_2,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT2,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ2_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ2_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ2_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ2_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_3] = {
+		.id = MT8186_IRQ_3,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT3,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ3_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ3_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ3_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ3_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_4] = {
+		.id = MT8186_IRQ_4,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT4,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ4_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ4_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ4_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ4_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_5] = {
+		.id = MT8186_IRQ_5,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT5,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ5_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ5_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ5_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ5_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_6] = {
+		.id = MT8186_IRQ_6,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT6,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ6_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ6_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ6_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ6_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_7] = {
+		.id = MT8186_IRQ_7,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT7,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON1,
+		.irq_fs_shift = IRQ7_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ7_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ7_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ7_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_8] = {
+		.id = MT8186_IRQ_8,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT8,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON2,
+		.irq_fs_shift = IRQ8_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ8_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ8_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ8_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_9] = {
+		.id = MT8186_IRQ_9,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT9,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON2,
+		.irq_fs_shift = IRQ9_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ9_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ9_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ9_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_10] = {
+		.id = MT8186_IRQ_10,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT10,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON2,
+		.irq_fs_shift = IRQ10_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ10_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ10_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ10_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_11] = {
+		.id = MT8186_IRQ_11,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT11,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON2,
+		.irq_fs_shift = IRQ11_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ11_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ11_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ11_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_12] = {
+		.id = MT8186_IRQ_12,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT12,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON2,
+		.irq_fs_shift = IRQ12_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ12_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ12_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ12_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_13] = {
+		.id = MT8186_IRQ_13,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT13,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON2,
+		.irq_fs_shift = IRQ13_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ13_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ13_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ13_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_14] = {
+		.id = MT8186_IRQ_14,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT14,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON2,
+		.irq_fs_shift = IRQ14_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ14_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ14_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ14_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_15] = {
+		.id = MT8186_IRQ_15,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT15,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON2,
+		.irq_fs_shift = IRQ15_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ15_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ15_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ15_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_16] = {
+		.id = MT8186_IRQ_16,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT16,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON3,
+		.irq_fs_shift = IRQ16_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ16_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ16_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ16_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_17] = {
+		.id = MT8186_IRQ_17,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT17,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON3,
+		.irq_fs_shift = IRQ17_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ17_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ17_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ17_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_18] = {
+		.id = MT8186_IRQ_18,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT18,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON3,
+		.irq_fs_shift = IRQ18_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ18_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ18_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ18_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_19] = {
+		.id = MT8186_IRQ_19,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT19,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON3,
+		.irq_fs_shift = IRQ19_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ19_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ19_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ19_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_20] = {
+		.id = MT8186_IRQ_20,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT20,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON3,
+		.irq_fs_shift = IRQ20_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ20_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ20_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ20_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_21] = {
+		.id = MT8186_IRQ_21,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT21,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON3,
+		.irq_fs_shift = IRQ21_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ21_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ21_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ21_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_22] = {
+		.id = MT8186_IRQ_22,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT22,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON3,
+		.irq_fs_shift = IRQ22_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ22_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ22_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ22_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_23] = {
+		.id = MT8186_IRQ_23,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT23,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON3,
+		.irq_fs_shift = IRQ23_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ23_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ23_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ23_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_24] = {
+		.id = MT8186_IRQ_24,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT24,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON4,
+		.irq_fs_shift = IRQ24_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ24_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ24_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ24_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_25] = {
+		.id = MT8186_IRQ_25,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT25,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON4,
+		.irq_fs_shift = IRQ25_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ25_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ25_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ25_MCU_CLR_SFT,
+	},
+	[MT8186_IRQ_26] = {
+		.id = MT8186_IRQ_26,
+		.irq_cnt_reg = AFE_IRQ_MCU_CNT26,
+		.irq_cnt_shift = AFE_IRQ_CNT_SHIFT,
+		.irq_cnt_maskbit = AFE_IRQ_CNT_MASK,
+		.irq_fs_reg = AFE_IRQ_MCU_CON4,
+		.irq_fs_shift = IRQ26_MCU_MODE_SFT,
+		.irq_fs_maskbit = IRQ26_MCU_MODE_MASK,
+		.irq_en_reg = AFE_IRQ_MCU_CON0,
+		.irq_en_shift = IRQ26_MCU_ON_SFT,
+		.irq_clr_reg = AFE_IRQ_MCU_CLR,
+		.irq_clr_shift = IRQ26_MCU_CLR_SFT,
+	},
+};
+
+static const int memif_irq_usage[MT8186_MEMIF_NUM] = {
+	/* TODO: verify each memif & irq */
+	[MT8186_MEMIF_DL1] = MT8186_IRQ_0,
+	[MT8186_MEMIF_DL2] = MT8186_IRQ_1,
+	[MT8186_MEMIF_DL3] = MT8186_IRQ_2,
+	[MT8186_MEMIF_DL4] = MT8186_IRQ_3,
+	[MT8186_MEMIF_DL5] = MT8186_IRQ_4,
+	[MT8186_MEMIF_DL6] = MT8186_IRQ_5,
+	[MT8186_MEMIF_DL7] = MT8186_IRQ_6,
+	[MT8186_MEMIF_DL8] = MT8186_IRQ_7,
+	[MT8186_MEMIF_DL12] = MT8186_IRQ_9,
+	[MT8186_MEMIF_VUL12] = MT8186_IRQ_10,
+	[MT8186_MEMIF_VUL2] = MT8186_IRQ_11,
+	[MT8186_MEMIF_AWB] = MT8186_IRQ_12,
+	[MT8186_MEMIF_AWB2] = MT8186_IRQ_13,
+	[MT8186_MEMIF_VUL3] = MT8186_IRQ_14,
+	[MT8186_MEMIF_VUL4] = MT8186_IRQ_15,
+	[MT8186_MEMIF_VUL5] = MT8186_IRQ_16,
+	[MT8186_MEMIF_VUL6] = MT8186_IRQ_17,
+};
+
+static bool mt8186_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	/* these auto-gen reg has read-only bit, so put it as volatile */
+	/* volatile reg cannot be cached, so cannot be set when power off */
+	switch (reg) {
+	case AUDIO_TOP_CON0:	/* reg bit controlled by CCF */
+	case AUDIO_TOP_CON1:	/* reg bit controlled by CCF */
+	case AUDIO_TOP_CON2:
+	case AUDIO_TOP_CON3:
+	case AFE_DL1_CUR_MSB:
+	case AFE_DL1_CUR:
+	case AFE_DL1_END:
+	case AFE_DL2_CUR_MSB:
+	case AFE_DL2_CUR:
+	case AFE_DL2_END:
+	case AFE_DL3_CUR_MSB:
+	case AFE_DL3_CUR:
+	case AFE_DL3_END:
+	case AFE_DL4_CUR_MSB:
+	case AFE_DL4_CUR:
+	case AFE_DL4_END:
+	case AFE_DL12_CUR_MSB:
+	case AFE_DL12_CUR:
+	case AFE_DL12_END:
+	case AFE_ADDA_SRC_DEBUG_MON0:
+	case AFE_ADDA_SRC_DEBUG_MON1:
+	case AFE_ADDA_UL_SRC_MON0:
+	case AFE_ADDA_UL_SRC_MON1:
+	case AFE_SECURE_CON0:
+	case AFE_SRAM_BOUND:
+	case AFE_SECURE_CON1:
+	case AFE_VUL_CUR_MSB:
+	case AFE_VUL_CUR:
+	case AFE_VUL_END:
+	case AFE_SIDETONE_MON:
+	case AFE_SIDETONE_CON0:
+	case AFE_SIDETONE_COEFF:
+	case AFE_VUL2_CUR_MSB:
+	case AFE_VUL2_CUR:
+	case AFE_VUL2_END:
+	case AFE_VUL3_CUR_MSB:
+	case AFE_VUL3_CUR:
+	case AFE_VUL3_END:
+	case AFE_I2S_MON:
+	case AFE_DAC_MON:
+	case AFE_IRQ0_MCU_CNT_MON:
+	case AFE_IRQ6_MCU_CNT_MON:
+	case AFE_VUL4_CUR_MSB:
+	case AFE_VUL4_CUR:
+	case AFE_VUL4_END:
+	case AFE_VUL12_CUR_MSB:
+	case AFE_VUL12_CUR:
+	case AFE_VUL12_END:
+	case AFE_IRQ3_MCU_CNT_MON:
+	case AFE_IRQ4_MCU_CNT_MON:
+	case AFE_IRQ_MCU_STATUS:
+	case AFE_IRQ_MCU_CLR:
+	case AFE_IRQ_MCU_MON2:
+	case AFE_IRQ1_MCU_CNT_MON:
+	case AFE_IRQ2_MCU_CNT_MON:
+	case AFE_IRQ5_MCU_CNT_MON:
+	case AFE_IRQ7_MCU_CNT_MON:
+	case AFE_IRQ_MCU_MISS_CLR:
+	case AFE_GAIN1_CUR:
+	case AFE_GAIN2_CUR:
+	case AFE_SRAM_DELSEL_CON1:
+	case PCM_INTF_CON2:
+	case FPGA_CFG0:
+	case FPGA_CFG1:
+	case FPGA_CFG2:
+	case FPGA_CFG3:
+	case AUDIO_TOP_DBG_MON0:
+	case AUDIO_TOP_DBG_MON1:
+	case AFE_IRQ8_MCU_CNT_MON:
+	case AFE_IRQ11_MCU_CNT_MON:
+	case AFE_IRQ12_MCU_CNT_MON:
+	case AFE_IRQ9_MCU_CNT_MON:
+	case AFE_IRQ10_MCU_CNT_MON:
+	case AFE_IRQ13_MCU_CNT_MON:
+	case AFE_IRQ14_MCU_CNT_MON:
+	case AFE_IRQ15_MCU_CNT_MON:
+	case AFE_IRQ16_MCU_CNT_MON:
+	case AFE_IRQ17_MCU_CNT_MON:
+	case AFE_IRQ18_MCU_CNT_MON:
+	case AFE_IRQ19_MCU_CNT_MON:
+	case AFE_IRQ20_MCU_CNT_MON:
+	case AFE_IRQ21_MCU_CNT_MON:
+	case AFE_IRQ22_MCU_CNT_MON:
+	case AFE_IRQ23_MCU_CNT_MON:
+	case AFE_IRQ24_MCU_CNT_MON:
+	case AFE_IRQ25_MCU_CNT_MON:
+	case AFE_IRQ26_MCU_CNT_MON:
+	case AFE_IRQ31_MCU_CNT_MON:
+	case AFE_CBIP_MON0:
+	case AFE_CBIP_SLV_MUX_MON0:
+	case AFE_CBIP_SLV_DECODER_MON0:
+	case AFE_ADDA6_MTKAIF_MON0:
+	case AFE_ADDA6_MTKAIF_MON1:
+	case AFE_AWB_CUR_MSB:
+	case AFE_AWB_CUR:
+	case AFE_AWB_END:
+	case AFE_AWB2_CUR_MSB:
+	case AFE_AWB2_CUR:
+	case AFE_AWB2_END:
+	case AFE_DAI_CUR_MSB:
+	case AFE_DAI_CUR:
+	case AFE_DAI_END:
+	case AFE_DAI2_CUR_MSB:
+	case AFE_DAI2_CUR:
+	case AFE_DAI2_END:
+	case AFE_ADDA6_SRC_DEBUG_MON0:
+	case AFE_ADD6A_UL_SRC_MON0:
+	case AFE_ADDA6_UL_SRC_MON1:
+	case AFE_MOD_DAI_CUR_MSB:
+	case AFE_MOD_DAI_CUR:
+	case AFE_MOD_DAI_END:
+	case AFE_AWB_RCH_MON:
+	case AFE_AWB_LCH_MON:
+	case AFE_VUL_RCH_MON:
+	case AFE_VUL_LCH_MON:
+	case AFE_VUL12_RCH_MON:
+	case AFE_VUL12_LCH_MON:
+	case AFE_VUL2_RCH_MON:
+	case AFE_VUL2_LCH_MON:
+	case AFE_DAI_DATA_MON:
+	case AFE_MOD_DAI_DATA_MON:
+	case AFE_DAI2_DATA_MON:
+	case AFE_AWB2_RCH_MON:
+	case AFE_AWB2_LCH_MON:
+	case AFE_VUL3_RCH_MON:
+	case AFE_VUL3_LCH_MON:
+	case AFE_VUL4_RCH_MON:
+	case AFE_VUL4_LCH_MON:
+	case AFE_VUL5_RCH_MON:
+	case AFE_VUL5_LCH_MON:
+	case AFE_VUL6_RCH_MON:
+	case AFE_VUL6_LCH_MON:
+	case AFE_DL1_RCH_MON:
+	case AFE_DL1_LCH_MON:
+	case AFE_DL2_RCH_MON:
+	case AFE_DL2_LCH_MON:
+	case AFE_DL12_RCH1_MON:
+	case AFE_DL12_LCH1_MON:
+	case AFE_DL12_RCH2_MON:
+	case AFE_DL12_LCH2_MON:
+	case AFE_DL3_RCH_MON:
+	case AFE_DL3_LCH_MON:
+	case AFE_DL4_RCH_MON:
+	case AFE_DL4_LCH_MON:
+	case AFE_DL5_RCH_MON:
+	case AFE_DL5_LCH_MON:
+	case AFE_DL6_RCH_MON:
+	case AFE_DL6_LCH_MON:
+	case AFE_DL7_RCH_MON:
+	case AFE_DL7_LCH_MON:
+	case AFE_DL8_RCH_MON:
+	case AFE_DL8_LCH_MON:
+	case AFE_VUL5_CUR_MSB:
+	case AFE_VUL5_CUR:
+	case AFE_VUL5_END:
+	case AFE_VUL6_CUR_MSB:
+	case AFE_VUL6_CUR:
+	case AFE_VUL6_END:
+	case AFE_ADDA_DL_SDM_FIFO_MON:
+	case AFE_ADDA_DL_SRC_LCH_MON:
+	case AFE_ADDA_DL_SRC_RCH_MON:
+	case AFE_ADDA_DL_SDM_OUT_MON:
+	case AFE_CONNSYS_I2S_MON:
+	case AFE_ASRC_2CH_CON0:
+	case AFE_ASRC_2CH_CON2:
+	case AFE_ASRC_2CH_CON3:
+	case AFE_ASRC_2CH_CON4:
+	case AFE_ASRC_2CH_CON5:
+	case AFE_ASRC_2CH_CON7:
+	case AFE_ASRC_2CH_CON8:
+	case AFE_ASRC_2CH_CON12:
+	case AFE_ASRC_2CH_CON13:
+	case AFE_ADDA_MTKAIF_MON0:
+	case AFE_ADDA_MTKAIF_MON1:
+	case AFE_AUD_PAD_TOP:
+	case AFE_DL_NLE_R_MON0:
+	case AFE_DL_NLE_R_MON1:
+	case AFE_DL_NLE_R_MON2:
+	case AFE_DL_NLE_L_MON0:
+	case AFE_DL_NLE_L_MON1:
+	case AFE_DL_NLE_L_MON2:
+	case AFE_GENERAL1_ASRC_2CH_CON0:
+	case AFE_GENERAL1_ASRC_2CH_CON2:
+	case AFE_GENERAL1_ASRC_2CH_CON3:
+	case AFE_GENERAL1_ASRC_2CH_CON4:
+	case AFE_GENERAL1_ASRC_2CH_CON5:
+	case AFE_GENERAL1_ASRC_2CH_CON7:
+	case AFE_GENERAL1_ASRC_2CH_CON8:
+	case AFE_GENERAL1_ASRC_2CH_CON12:
+	case AFE_GENERAL1_ASRC_2CH_CON13:
+	case AFE_GENERAL2_ASRC_2CH_CON0:
+	case AFE_GENERAL2_ASRC_2CH_CON2:
+	case AFE_GENERAL2_ASRC_2CH_CON3:
+	case AFE_GENERAL2_ASRC_2CH_CON4:
+	case AFE_GENERAL2_ASRC_2CH_CON5:
+	case AFE_GENERAL2_ASRC_2CH_CON7:
+	case AFE_GENERAL2_ASRC_2CH_CON8:
+	case AFE_GENERAL2_ASRC_2CH_CON12:
+	case AFE_GENERAL2_ASRC_2CH_CON13:
+	case AFE_DL5_CUR_MSB:
+	case AFE_DL5_CUR:
+	case AFE_DL5_END:
+	case AFE_DL6_CUR_MSB:
+	case AFE_DL6_CUR:
+	case AFE_DL6_END:
+	case AFE_DL7_CUR_MSB:
+	case AFE_DL7_CUR:
+	case AFE_DL7_END:
+	case AFE_DL8_CUR_MSB:
+	case AFE_DL8_CUR:
+	case AFE_DL8_END:
+	case AFE_PROT_SIDEBAND_MON:
+	case AFE_DOMAIN_SIDEBAND0_MON:
+	case AFE_DOMAIN_SIDEBAND1_MON:
+	case AFE_DOMAIN_SIDEBAND2_MON:
+	case AFE_DOMAIN_SIDEBAND3_MON:
+	case AFE_APLL1_TUNER_CFG:	/* [20:31] is monitor */
+	case AFE_APLL2_TUNER_CFG:	/* [20:31] is monitor */
+		return true;
+	default:
+		return false;
+	};
+}
+
+static const struct regmap_config mt8186_afe_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+
+	.volatile_reg = mt8186_is_volatile_reg,
+
+	.max_register = AFE_MAX_REGISTER,
+	.num_reg_defaults_raw = AFE_MAX_REGISTER,
+
+	.cache_type = REGCACHE_FLAT,
+};
+
+static irqreturn_t mt8186_afe_irq_handler(int irq_id, void *dev)
+{
+	struct mtk_base_afe *afe = dev;
+	struct mtk_base_afe_irq *irq;
+	unsigned int status;
+	unsigned int status_mcu;
+	unsigned int mcu_en;
+	int ret;
+	int i;
+
+	/* get irq that is sent to MCU */
+	ret = regmap_read(afe->regmap, AFE_IRQ_MCU_EN, &mcu_en);
+	if (ret) {
+		dev_err(afe->dev, "%s, get irq direction fail, ret %d", __func__, ret);
+		return ret;
+	}
+
+	ret = regmap_read(afe->regmap, AFE_IRQ_MCU_STATUS, &status);
+	/* only care IRQ which is sent to MCU */
+	status_mcu = status & mcu_en & AFE_IRQ_STATUS_BITS;
+
+	if (ret || status_mcu == 0) {
+		dev_err(afe->dev, "%s(), irq status err, ret %d, status 0x%x, mcu_en 0x%x\n",
+			__func__, ret, status, mcu_en);
+
+		goto err_irq;
+	}
+
+	for (i = 0; i < MT8186_MEMIF_NUM; i++) {
+		struct mtk_base_afe_memif *memif = &afe->memif[i];
+
+		if (!memif->substream)
+			continue;
+
+		if (memif->irq_usage < 0)
+			continue;
+
+		irq = &afe->irqs[memif->irq_usage];
+
+		if (status_mcu & (1 << irq->irq_data->irq_en_shift))
+			snd_pcm_period_elapsed(memif->substream);
+	}
+
+err_irq:
+	/* clear irq */
+	regmap_write(afe->regmap, AFE_IRQ_MCU_CLR, status_mcu);
+
+	return IRQ_HANDLED;
+}
+
+static int mt8186_afe_runtime_suspend(struct device *dev)
+{
+	struct mtk_base_afe *afe = dev_get_drvdata(dev);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	unsigned int value = 0;
+	int ret;
+
+	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
+		goto skip_regmap;
+
+	/* disable AFE */
+	regmap_update_bits(afe->regmap, AFE_DAC_CON0, 0x1, 0x0);
+
+	ret = regmap_read_poll_timeout(afe->regmap,
+				       AFE_DAC_MON,
+				       value,
+				       (value & AFE_ON_RETM_MASK_SFT) == 0,
+				       20,
+				       1 * 1000 * 1000);
+	if (ret) {
+		dev_err(afe->dev, "%s(), ret %d\n", __func__, ret);
+		return ret;
+	}
+
+	/* make sure all irq status are cleared */
+	regmap_write(afe->regmap, AFE_IRQ_MCU_CLR, 0xffffffff);
+	regmap_write(afe->regmap, AFE_IRQ_MCU_CLR, 0xffffffff);
+
+	/* reset sgen */
+	regmap_write(afe->regmap, AFE_SINEGEN_CON0, 0x0);
+	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON2,
+			   INNER_LOOP_BACK_MODE_MASK_SFT,
+			   0x3f << INNER_LOOP_BACK_MODE_SFT);
+
+	/* cache only */
+	regcache_cache_only(afe->regmap, true);
+	regcache_mark_dirty(afe->regmap);
+
+skip_regmap:
+	mt8186_afe_disable_cgs(afe);
+	mt8186_afe_disable_clock(afe);
+
+	return 0;
+}
+
+static int mt8186_afe_runtime_resume(struct device *dev)
+{
+	struct mtk_base_afe *afe = dev_get_drvdata(dev);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	int ret;
+
+	ret = mt8186_afe_enable_clock(afe);
+	if (ret)
+		return ret;
+
+	ret = mt8186_afe_enable_cgs(afe);
+	if (ret)
+		return ret;
+
+	if (!afe->regmap || afe_priv->pm_runtime_bypass_reg_ctl)
+		goto skip_regmap;
+
+	regcache_cache_only(afe->regmap, false);
+	regcache_sync(afe->regmap);
+
+	/* enable audio sys DCM for power saving */
+	regmap_update_bits(afe_priv->infracfg, PERI_BUS_DCM_CTRL, BIT(29), BIT(29));
+	regmap_update_bits(afe->regmap, AUDIO_TOP_CON0, BIT(29), BIT(29));
+
+	/* force cpu use 8_24 format when writing 32bit data */
+	regmap_update_bits(afe->regmap, AFE_MEMIF_CON0, CPU_HD_ALIGN_MASK_SFT, 0);
+
+	/* set all output port to 24bit */
+	regmap_write(afe->regmap, AFE_CONN_24BIT, 0xffffffff);
+	regmap_write(afe->regmap, AFE_CONN_24BIT_1, 0xffffffff);
+
+	/* enable AFE */
+	regmap_update_bits(afe->regmap, AFE_DAC_CON0, AUDIO_AFE_ON_MASK_SFT, BIT(0));
+
+skip_regmap:
+	return 0;
+}
+
+static int mt8186_afe_component_probe(struct snd_soc_component *component)
+{
+	mtk_afe_add_sub_dai_control(component);
+	mt8186_add_misc_control(component);
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver mt8186_afe_component = {
+	.name = AFE_PCM_NAME,
+	.pcm_construct = mtk_afe_pcm_new,
+	.pointer = mtk_afe_pcm_pointer,
+	.probe = mt8186_afe_component_probe,
+};
+
+static int mt8186_dai_memif_register(struct mtk_base_afe *afe)
+{
+	struct mtk_base_afe_dai *dai;
+
+	dai = devm_kzalloc(afe->dev, sizeof(*dai), GFP_KERNEL);
+	if (!dai)
+		return -ENOMEM;
+
+	list_add(&dai->list, &afe->sub_dais);
+
+	dai->dai_drivers = mt8186_memif_dai_driver;
+	dai->num_dai_drivers = ARRAY_SIZE(mt8186_memif_dai_driver);
+
+	dai->controls = mt8186_pcm_kcontrols;
+	dai->num_controls = ARRAY_SIZE(mt8186_pcm_kcontrols);
+	dai->dapm_widgets = mt8186_memif_widgets;
+	dai->num_dapm_widgets = ARRAY_SIZE(mt8186_memif_widgets);
+	dai->dapm_routes = mt8186_memif_routes;
+	dai->num_dapm_routes = ARRAY_SIZE(mt8186_memif_routes);
+	return 0;
+}
+
+typedef int (*dai_register_cb)(struct mtk_base_afe *);
+static const dai_register_cb dai_register_cbs[] = {
+	mt8186_dai_adda_register,
+	mt8186_dai_i2s_register,
+	mt8186_dai_tdm_register,
+	mt8186_dai_hw_gain_register,
+	mt8186_dai_src_register,
+	mt8186_dai_pcm_register,
+	mt8186_dai_hostless_register,
+	mt8186_dai_memif_register,
+};
+
+static int mt8186_afe_pcm_dev_probe(struct platform_device *pdev)
+{
+	struct mtk_base_afe *afe;
+	struct mt8186_afe_private *afe_priv;
+	struct resource *res;
+	struct reset_control *rstc;
+	struct device *dev = &pdev->dev;
+	int i, ret, irq_id;
+
+	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(34));
+	if (ret)
+		return ret;
+
+	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
+	if (!afe)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, afe);
+
+	afe->platform_priv = devm_kzalloc(dev, sizeof(*afe_priv), GFP_KERNEL);
+	if (!afe->platform_priv)
+		return -ENOMEM;
+
+	afe_priv = afe->platform_priv;
+	afe->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	afe->base_addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(afe->base_addr))
+		return PTR_ERR(afe->base_addr);
+
+	/* init audio related clock */
+	ret = mt8186_init_clock(afe);
+	if (ret) {
+		dev_err(dev, "init clock error, ret %d\n", ret);
+		return ret;
+	}
+
+	/* init memif */
+	afe->memif_32bit_supported = 0;
+	afe->memif_size = MT8186_MEMIF_NUM;
+	afe->memif = devm_kcalloc(dev, afe->memif_size, sizeof(*afe->memif),
+				  GFP_KERNEL);
+
+	if (!afe->memif)
+		return -ENOMEM;
+
+	for (i = 0; i < afe->memif_size; i++) {
+		afe->memif[i].data = &memif_data[i];
+		afe->memif[i].irq_usage = memif_irq_usage[i];
+		afe->memif[i].const_irq = 1;
+	}
+
+	mutex_init(&afe->irq_alloc_lock);	/* needed when dynamic irq */
+
+	/* init irq */
+	afe->irqs_size = MT8186_IRQ_NUM;
+	afe->irqs = devm_kcalloc(dev, afe->irqs_size, sizeof(*afe->irqs),
+				 GFP_KERNEL);
+
+	if (!afe->irqs)
+		return -ENOMEM;
+
+	for (i = 0; i < afe->irqs_size; i++)
+		afe->irqs[i].irq_data = &irq_data[i];
+
+	/* request irq */
+	irq_id = platform_get_irq(pdev, 0);
+	if (irq_id <= 0)
+		return dev_err_probe(dev, irq_id < 0 ? irq_id : -ENXIO,
+				     "no irq found");
+
+	ret = devm_request_irq(dev, irq_id, mt8186_afe_irq_handler,
+			       IRQF_TRIGGER_NONE,
+			       "Afe_ISR_Handle", (void *)afe);
+	if (ret)
+		return dev_err_probe(dev, ret, "could not request_irq for Afe_ISR_Handle\n");
+
+	ret = enable_irq_wake(irq_id);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "enable_irq_wake %d\n", irq_id);
+
+	/* init sub_dais */
+	INIT_LIST_HEAD(&afe->sub_dais);
+
+	for (i = 0; i < ARRAY_SIZE(dai_register_cbs); i++) {
+		ret = dai_register_cbs[i](afe);
+		if (ret)
+			return dev_err_probe(dev, ret, "dai register i %d fail\n", i);
+	}
+
+	/* init dai_driver and component_driver */
+	ret = mtk_afe_combine_sub_dai(afe);
+	if (ret)
+		return dev_err_probe(dev, ret, "mtk_afe_combine_sub_dai fail\n");
+
+	/* reset controller to reset audio regs before regmap cache */
+	rstc = devm_reset_control_get_exclusive(dev, "audiosys");
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "could not get audiosys reset\n");
+
+	ret = reset_control_reset(rstc);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to trigger audio reset\n");
+
+	/* enable clock for regcache get default value from hw */
+	afe_priv->pm_runtime_bypass_reg_ctl = true;
+	pm_runtime_enable(dev);
+	ret = pm_runtime_get_sync(dev);
+	if (ret) {
+		dev_err(dev, "failed to resume device: %d\n", ret);
+		goto err_pm_disable;
+	}
+
+	afe->regmap = devm_regmap_init_mmio(dev, afe->base_addr,
+					    &mt8186_afe_regmap_config);
+	if (IS_ERR(afe->regmap)) {
+		ret = PTR_ERR(afe->regmap);
+		goto err_pm_disable;
+	}
+
+	/* others */
+	afe->mtk_afe_hardware = &mt8186_afe_hardware;
+	afe->memif_fs = mt8186_memif_fs;
+	afe->irq_fs = mt8186_irq_fs;
+	afe->get_dai_fs = mt8186_get_dai_fs;
+	afe->get_memif_pbuf_size = mt8186_get_memif_pbuf_size;
+
+	afe->runtime_resume = mt8186_afe_runtime_resume;
+	afe->runtime_suspend = mt8186_afe_runtime_suspend;
+
+	/* register platform */
+	dev_info(dev, "%s(), devm_snd_soc_register_component\n", __func__);
+
+	ret = devm_snd_soc_register_component(dev,
+					      &mt8186_afe_component,
+					      afe->dai_drivers,
+					      afe->num_dai_drivers);
+	if (ret) {
+		dev_err(dev, "err_dai_component\n");
+		goto err_pm_disable;
+	}
+
+	ret = pm_runtime_put_sync(dev);
+	if (ret) {
+		pm_runtime_get_noresume(dev);
+		dev_err(dev, "failed to suspend device: %d\n", ret);
+		goto err_pm_disable;
+	}
+	afe_priv->pm_runtime_bypass_reg_ctl = false;
+
+	regcache_cache_only(afe->regmap, true);
+	regcache_mark_dirty(afe->regmap);
+
+	return 0;
+
+err_pm_disable:
+	pm_runtime_put_noidle(dev);
+	pm_runtime_set_suspended(dev);
+	pm_runtime_disable(dev);
+
+	return ret;
+}
+
+static int mt8186_afe_pcm_dev_remove(struct platform_device *pdev)
+{
+	struct mtk_base_afe *afe = platform_get_drvdata(pdev);
+
+	pm_runtime_disable(&pdev->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		mt8186_afe_runtime_suspend(&pdev->dev);
+
+	mt8186_deinit_clock(afe);
+
+	return 0;
+}
+
+static const struct of_device_id mt8186_afe_pcm_dt_match[] = {
+	{ .compatible = "mediatek,mt8186-sound", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mt8186_afe_pcm_dt_match);
+
+static const struct dev_pm_ops mt8186_afe_pm_ops = {
+	SET_RUNTIME_PM_OPS(mt8186_afe_runtime_suspend,
+			   mt8186_afe_runtime_resume, NULL)
+};
+
+static struct platform_driver mt8186_afe_pcm_driver = {
+	.driver = {
+		   .name = "mt8186-audio",
+		   .of_match_table = mt8186_afe_pcm_dt_match,
+		   .pm = &mt8186_afe_pm_ops,
+	},
+	.probe = mt8186_afe_pcm_dev_probe,
+	.remove = mt8186_afe_pcm_dev_remove,
+};
+
+module_platform_driver(mt8186_afe_pcm_driver);
+
+MODULE_DESCRIPTION("Mediatek ALSA SoC AFE platform driver for 8186");
+MODULE_AUTHOR("Jiaxin Yu <jiaxin.yu@mediatek.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/sound/soc/mediatek/mt8186/mt8186-interconnection.h b/sound/soc/mediatek/mt8186/mt8186-interconnection.h
new file mode 100644
index 000000000000..5b188d93ebd3
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-interconnection.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Mediatek MT8186 audio driver interconnection definition
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+ */
+
+#ifndef _MT8186_INTERCONNECTION_H_
+#define _MT8186_INTERCONNECTION_H_
+
+/* in port define */
+#define I_I2S0_CH1 0
+#define I_I2S0_CH2 1
+#define I_ADDA_UL_CH1 3
+#define I_ADDA_UL_CH2 4
+#define I_DL1_CH1 5
+#define I_DL1_CH2 6
+#define I_DL2_CH1 7
+#define I_DL2_CH2 8
+#define I_PCM_1_CAP_CH1 9
+#define I_GAIN1_OUT_CH1 10
+#define I_GAIN1_OUT_CH2 11
+#define I_GAIN2_OUT_CH1 12
+#define I_GAIN2_OUT_CH2 13
+#define I_PCM_2_CAP_CH1 14
+#define I_ADDA_UL_CH3 17
+#define I_ADDA_UL_CH4 18
+#define I_DL12_CH1 19
+#define I_DL12_CH2 20
+#define I_DL12_CH3 5
+#define I_DL12_CH4 6
+#define I_PCM_2_CAP_CH2 21
+#define I_PCM_1_CAP_CH2 22
+#define I_DL3_CH1 23
+#define I_DL3_CH2 24
+#define I_I2S2_CH1 25
+#define I_I2S2_CH2 26
+#define I_I2S2_CH3 27
+#define I_I2S2_CH4 28
+
+/* in port define >= 32 */
+#define I_32_OFFSET 32
+#define I_CONNSYS_I2S_CH1 (34 - I_32_OFFSET)
+#define I_CONNSYS_I2S_CH2 (35 - I_32_OFFSET)
+#define I_SRC_1_OUT_CH1 (36 - I_32_OFFSET)
+#define I_SRC_1_OUT_CH2 (37 - I_32_OFFSET)
+#define I_SRC_2_OUT_CH1 (38 - I_32_OFFSET)
+#define I_SRC_2_OUT_CH2 (39 - I_32_OFFSET)
+#define I_DL4_CH1 (40 - I_32_OFFSET)
+#define I_DL4_CH2 (41 - I_32_OFFSET)
+#define I_DL5_CH1 (42 - I_32_OFFSET)
+#define I_DL5_CH2 (43 - I_32_OFFSET)
+#define I_DL6_CH1 (44 - I_32_OFFSET)
+#define I_DL6_CH2 (45 - I_32_OFFSET)
+#define I_DL7_CH1 (46 - I_32_OFFSET)
+#define I_DL7_CH2 (47 - I_32_OFFSET)
+#define I_DL8_CH1 (48 - I_32_OFFSET)
+#define I_DL8_CH2 (49 - I_32_OFFSET)
+#define I_TDM_IN_CH1 (56 - I_32_OFFSET)
+#define I_TDM_IN_CH2 (57 - I_32_OFFSET)
+#define I_TDM_IN_CH3 (58 - I_32_OFFSET)
+#define I_TDM_IN_CH4 (59 - I_32_OFFSET)
+#define I_TDM_IN_CH5 (60 - I_32_OFFSET)
+#define I_TDM_IN_CH6 (61 - I_32_OFFSET)
+#define I_TDM_IN_CH7 (62 - I_32_OFFSET)
+#define I_TDM_IN_CH8 (63 - I_32_OFFSET)
+
+#endif
diff --git a/sound/soc/mediatek/mt8186/mt8186-misc-control.c b/sound/soc/mediatek/mt8186/mt8186-misc-control.c
new file mode 100644
index 000000000000..f892188ca80d
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-misc-control.c
@@ -0,0 +1,294 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// MediaTek ALSA SoC Audio Misc Control
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include <linux/regmap.h>
+#include <sound/soc.h>
+
+#include "../common/mtk-afe-fe-dai.h"
+#include "../common/mtk-afe-platform-driver.h"
+#include "mt8186-afe-common.h"
+
+#define SGEN_MUTE_CH1_KCONTROL_NAME "Audio_SineGen_Mute_Ch1"
+#define SGEN_MUTE_CH2_KCONTROL_NAME "Audio_SineGen_Mute_Ch2"
+
+static const char * const mt8186_sgen_mode_str[] = {
+	"I0I1",   "I2",     "I3I4",   "I5I6",
+	"I7I8",   "I9I22",  "I10I11", "I12I13",
+	"I14I21", "I15I16", "I17I18", "I19I20",
+	"I23I24", "I25I26", "I27I28", "I33",
+	"I34I35", "I36I37", "I38I39", "I40I41",
+	"I42I43", "I44I45", "I46I47", "I48I49",
+	"I56I57", "I58I59", "I60I61", "I62I63",
+	"O0O1",   "O2",     "O3O4",   "O5O6",
+	"O7O8",   "O9O10",  "O11",    "O12",
+	"O13O14", "O15O16", "O17O18", "O19O20",
+	"O21O22", "O23O24", "O25",    "O28O29",
+	"O34",    "O35",    "O32O33", "O36O37",
+	"O38O39", "O30O31", "O40O41", "O42O43",
+	"O44O45", "O46O47", "O48O49", "O50O51",
+	"O58O59", "O60O61", "O62O63", "O64O65",
+	"O66O67", "O68O69", "O26O27", "OFF",
+};
+
+static const int mt8186_sgen_mode_idx[] = {
+	0, 2, 4, 6,
+	8, 22, 10, 12,
+	14, -1, 18, 20,
+	24, 26, 28, 33,
+	34, 36, 38, 40,
+	42, 44, 46, 48,
+	56, 58, 60, 62,
+	128, 130, 132, 134,
+	135, 138, 139, 140,
+	142, 144, 166, 148,
+	150, 152, 153, 156,
+	162, 163, 160, 164,
+	166, -1, 168, 170,
+	172, 174, 176, 178,
+	186, 188, 190, 192,
+	194, 196, -1, -1,
+};
+
+static const char * const mt8186_sgen_rate_str[] = {
+	"8K", "11K", "12K", "16K",
+	"22K", "24K", "32K", "44K",
+	"48K", "88k", "96k", "176k",
+	"192k"
+};
+
+static const int mt8186_sgen_rate_idx[] = {
+	0, 1, 2, 4,
+	5, 6, 8, 9,
+	10, 11, 12, 13,
+	14
+};
+
+/* this order must match reg bit amp_div_ch1/2 */
+static const char * const mt8186_sgen_amp_str[] = {
+	"1/128", "1/64", "1/32", "1/16", "1/8", "1/4", "1/2", "1" };
+static const char * const mt8186_sgen_mute_str[] = {
+	"Off", "On"
+};
+
+static int mt8186_sgen_get(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+
+	ucontrol->value.integer.value[0] = afe_priv->sgen_mode;
+
+	return 0;
+}
+
+static int mt8186_sgen_set(struct snd_kcontrol *kcontrol,
+			   struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int mode;
+	int mode_idx;
+
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
+	mode = ucontrol->value.integer.value[0];
+	mode_idx = mt8186_sgen_mode_idx[mode];
+
+	dev_dbg(afe->dev, "%s(), mode %d, mode_idx %d\n",
+		__func__, mode, mode_idx);
+
+	if (mode_idx >= 0) {
+		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON2,
+				   INNER_LOOP_BACK_MODE_MASK_SFT,
+				   mode_idx << INNER_LOOP_BACK_MODE_SFT);
+		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
+				   DAC_EN_MASK_SFT, BIT(DAC_EN_SFT));
+	} else {
+		/* disable sgen */
+		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
+				   DAC_EN_MASK_SFT, 0);
+		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON2,
+				   INNER_LOOP_BACK_MODE_MASK_SFT,
+				   0x3f << INNER_LOOP_BACK_MODE_SFT);
+	}
+
+	afe_priv->sgen_mode = mode;
+
+	return 0;
+}
+
+static int mt8186_sgen_rate_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+
+	ucontrol->value.integer.value[0] = afe_priv->sgen_rate;
+
+	return 0;
+}
+
+static int mt8186_sgen_rate_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int rate;
+
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
+	rate = ucontrol->value.integer.value[0];
+
+	dev_dbg(afe->dev, "%s(), rate %d\n", __func__, rate);
+
+	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
+			   SINE_MODE_CH1_MASK_SFT,
+			   mt8186_sgen_rate_idx[rate] << SINE_MODE_CH1_SFT);
+
+	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
+			   SINE_MODE_CH2_MASK_SFT,
+			   mt8186_sgen_rate_idx[rate] << SINE_MODE_CH2_SFT);
+
+	afe_priv->sgen_rate = rate;
+
+	return 0;
+}
+
+static int mt8186_sgen_amplitude_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+
+	ucontrol->value.integer.value[0] = afe_priv->sgen_amplitude;
+	return 0;
+}
+
+static int mt8186_sgen_amplitude_set(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct mt8186_afe_private *afe_priv = afe->platform_priv;
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int amplitude;
+
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
+	amplitude = ucontrol->value.integer.value[0];
+	if (amplitude > AMP_DIV_CH1_MASK) {
+		dev_err(afe->dev, "%s(), amplitude %d invalid\n", __func__, amplitude);
+		return -EINVAL;
+	}
+
+	dev_dbg(afe->dev, "%s(), amplitude %d\n", __func__, amplitude);
+
+	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
+			   AMP_DIV_CH1_MASK_SFT,
+			   amplitude << AMP_DIV_CH1_SFT);
+	regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
+			   AMP_DIV_CH2_MASK_SFT,
+			   amplitude << AMP_DIV_CH2_SFT);
+
+	afe_priv->sgen_amplitude = amplitude;
+
+	return 0;
+}
+
+static int mt8186_sgen_mute_get(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	int mute;
+
+	regmap_read(afe->regmap, AFE_SINEGEN_CON0, &mute);
+
+	if (strcmp(kcontrol->id.name, SGEN_MUTE_CH1_KCONTROL_NAME) == 0)
+		return (mute >> MUTE_SW_CH1_SFT) & MUTE_SW_CH1_MASK;
+
+	return (mute >> MUTE_SW_CH2_SFT) & MUTE_SW_CH2_MASK;
+}
+
+static int mt8186_sgen_mute_set(struct snd_kcontrol *kcontrol,
+				struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
+	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
+	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
+	int mute;
+
+	if (ucontrol->value.enumerated.item[0] >= e->items)
+		return -EINVAL;
+
+	mute = ucontrol->value.integer.value[0];
+
+	dev_dbg(afe->dev, "%s(), kcontrol name %s, mute %d\n",
+		__func__, kcontrol->id.name, mute);
+
+	if (strcmp(kcontrol->id.name, SGEN_MUTE_CH1_KCONTROL_NAME) == 0) {
+		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
+				   MUTE_SW_CH1_MASK_SFT,
+				   mute << MUTE_SW_CH1_SFT);
+	} else {
+		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
+				   MUTE_SW_CH2_MASK_SFT,
+				   mute << MUTE_SW_CH2_SFT);
+	}
+
+	return 0;
+}
+
+static const struct soc_enum mt8186_afe_sgen_enum[] = {
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_sgen_mode_str),
+			    mt8186_sgen_mode_str),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_sgen_rate_str),
+			    mt8186_sgen_rate_str),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_sgen_amp_str),
+			    mt8186_sgen_amp_str),
+	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_sgen_mute_str),
+			    mt8186_sgen_mute_str),
+};
+
+static const struct snd_kcontrol_new mt8186_afe_sgen_controls[] = {
+	SOC_ENUM_EXT("Audio_SineGen_Switch", mt8186_afe_sgen_enum[0],
+		     mt8186_sgen_get, mt8186_sgen_set),
+	SOC_ENUM_EXT("Audio_SineGen_SampleRate", mt8186_afe_sgen_enum[1],
+		     mt8186_sgen_rate_get, mt8186_sgen_rate_set),
+	SOC_ENUM_EXT("Audio_SineGen_Amplitude", mt8186_afe_sgen_enum[2],
+		     mt8186_sgen_amplitude_get, mt8186_sgen_amplitude_set),
+	SOC_ENUM_EXT(SGEN_MUTE_CH1_KCONTROL_NAME, mt8186_afe_sgen_enum[3],
+		     mt8186_sgen_mute_get, mt8186_sgen_mute_set),
+	SOC_ENUM_EXT(SGEN_MUTE_CH2_KCONTROL_NAME, mt8186_afe_sgen_enum[3],
+		     mt8186_sgen_mute_get, mt8186_sgen_mute_set),
+	SOC_SINGLE("Audio_SineGen_Freq_Div_Ch1", AFE_SINEGEN_CON0,
+		   FREQ_DIV_CH1_SFT, FREQ_DIV_CH1_MASK, 0),
+	SOC_SINGLE("Audio_SineGen_Freq_Div_Ch2", AFE_SINEGEN_CON0,
+		   FREQ_DIV_CH2_SFT, FREQ_DIV_CH2_MASK, 0),
+};
+
+int mt8186_add_misc_control(struct snd_soc_component *component)
+{
+	snd_soc_add_component_controls(component,
+				       mt8186_afe_sgen_controls,
+				       ARRAY_SIZE(mt8186_afe_sgen_controls));
+
+	return 0;
+}
diff --git a/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c b/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
new file mode 100644
index 000000000000..94e1128e8128
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-mt6366-common.c
@@ -0,0 +1,59 @@
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
+		dev_info(rtd->dev, "failed to snd_soc_dapm_sync\n");
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
+		if (ret < 0) {
+			dev_err_probe(card->dev, ret, "get dai link codecs fail\n");
+			return ret;
+		}
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
diff --git a/sound/soc/mediatek/mt8186/mt8186-reg.h b/sound/soc/mediatek/mt8186/mt8186-reg.h
new file mode 100644
index 000000000000..53c3eb7283d8
--- /dev/null
+++ b/sound/soc/mediatek/mt8186/mt8186-reg.h
@@ -0,0 +1,2913 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * mt8186-reg.h  --  Mediatek 8186 audio driver reg definition
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
+ */
+
+#ifndef _MT8186_REG_H_
+#define _MT8186_REG_H_
+
+/* reg bit enum */
+enum {
+	MT8186_MEMIF_PBUF_SIZE_32_BYTES,
+	MT8186_MEMIF_PBUF_SIZE_64_BYTES,
+	MT8186_MEMIF_PBUF_SIZE_128_BYTES,
+	MT8186_MEMIF_PBUF_SIZE_256_BYTES,
+	MT8186_MEMIF_PBUF_SIZE_NUM,
+};
+
+/*****************************************************************************
+ *                  R E G I S T E R       D E F I N I T I O N
+ *****************************************************************************/
+/* AUDIO_TOP_CON0 */
+#define RESERVED_SFT					31
+#define RESERVED_MASK_SFT				BIT(31)
+#define AHB_IDLE_EN_INT_SFT				30
+#define AHB_IDLE_EN_INT_MASK_SFT			BIT(30)
+#define AHB_IDLE_EN_EXT_SFT				29
+#define AHB_IDLE_EN_EXT_MASK_SFT			BIT(29)
+#define PDN_NLE_SFT					28
+#define PDN_NLE_MASK_SFT				BIT(28)
+#define PDN_TML_SFT					27
+#define PDN_TML_MASK_SFT				BIT(27)
+#define PDN_DAC_PREDIS_SFT				26
+#define PDN_DAC_PREDIS_MASK_SFT				BIT(26)
+#define PDN_DAC_SFT					25
+#define PDN_DAC_MASK_SFT				BIT(25)
+#define PDN_ADC_SFT					24
+#define PDN_ADC_MASK_SFT				BIT(24)
+#define PDN_TDM_CK_SFT					20
+#define PDN_TDM_CK_MASK_SFT				BIT(20)
+#define PDN_APLL_TUNER_SFT				19
+#define PDN_APLL_TUNER_MASK_SFT				BIT(19)
+#define PDN_APLL2_TUNER_SFT				18
+#define PDN_APLL2_TUNER_MASK_SFT			BIT(18)
+#define APB3_SEL_SFT					14
+#define APB3_SEL_MASK_SFT				BIT(14)
+#define APB_R2T_SFT					13
+#define APB_R2T_MASK_SFT				BIT(13)
+#define APB_W2T_SFT					12
+#define APB_W2T_MASK_SFT				BIT(12)
+#define PDN_24M_SFT					9
+#define PDN_24M_MASK_SFT				BIT(9)
+#define PDN_22M_SFT					8
+#define PDN_22M_MASK_SFT				BIT(8)
+#define PDN_AFE_SFT					2
+#define PDN_AFE_MASK_SFT				BIT(2)
+
+/* AUDIO_TOP_CON1 */
+#define PDN_3RD_DAC_HIRES_SFT				31
+#define PDN_3RD_DAC_HIRES_MASK_SFT			BIT(31)
+#define PDN_3RD_DAC_TML_SFT				30
+#define PDN_3RD_DAC_TML_MASK_SFT			BIT(30)
+#define PDN_3RD_DAC_PREDIS_SFT				29
+#define PDN_3RD_DAC_PREDIS_MASK_SFT			BIT(29)
+#define PDN_3RD_DAC_SFT					28
+#define PDN_3RD_DAC_MASK_SFT				BIT(28)
+#define I2S_SOFT_RST5_SFT				22
+#define I2S_SOFT_RST5_MASK_SFT				BIT(22)
+#define PDN_ADDA6_ADC_HIRES_SFT				21
+#define PDN_ADDA6_ADC_HIRES_MASK_SFT			BIT(21)
+#define PDN_ADDA6_ADC_SFT				20
+#define PDN_ADDA6_ADC_MASK_SFT				BIT(20)
+#define PDN_ADC_HIRES_TML_SFT				17
+#define PDN_ADC_HIRES_TML_MASK_SFT			BIT(17)
+#define PDN_ADC_HIRES_SFT				16
+#define PDN_ADC_HIRES_MASK_SFT				BIT(16)
+#define PDN_DAC_HIRES_SFT				15
+#define PDN_DAC_HIRES_MASK_SFT				BIT(15)
+#define PDN_GENERAL2_ASRC_SFT				14
+#define PDN_GENERAL2_ASRC_MASK_SFT			BIT(14)
+#define PDN_GENERAL1_ASRC_SFT				13
+#define PDN_GENERAL1_ASRC_MASK_SFT			BIT(13)
+#define PDN_CONNSYS_I2S_ASRC_SFT			12
+#define PDN_CONNSYS_I2S_ASRC_MASK_SFT			BIT(12)
+#define I2S4_BCLK_SW_CG_SFT				7
+#define I2S4_BCLK_SW_CG_MASK_SFT			BIT(7)
+#define I2S3_BCLK_SW_CG_SFT				6
+#define I2S3_BCLK_SW_CG_MASK_SFT			BIT(6)
+#define I2S2_BCLK_SW_CG_SFT				5
+#define I2S2_BCLK_SW_CG_MASK_SFT			BIT(5)
+#define I2S1_BCLK_SW_CG_SFT				4
+#define I2S1_BCLK_SW_CG_MASK_SFT			BIT(4)
+#define I2S_SOFT_RST2_SFT				2
+#define I2S_SOFT_RST2_MASK_SFT				BIT(2)
+#define I2S_SOFT_RST_SFT				1
+#define I2S_SOFT_RST_MASK_SFT				BIT(1)
+
+/* AUDIO_TOP_CON3 */
+#define BUSY_SFT					31
+#define BUSY_MASK_SFT					BIT(31)
+#define OS_DISABLE_SFT					30
+#define OS_DISABLE_MASK_SFT				BIT(30)
+#define CG_DISABLE_SFT					29
+#define CG_DISABLE_MASK_SFT				BIT(29)
+#define CLEAR_FLAG_SFT					0
+#define CLEAR_FLAG_MASK_SFT				BIT(0)
+
+/* AFE_DAC_CON0 */
+#define VUL12_ON_SFT					31
+#define VUL12_ON_MASK_SFT				BIT(31)
+#define MOD_DAI_ON_SFT					30
+#define MOD_DAI_ON_MASK_SFT				BIT(30)
+#define DAI_ON_SFT					29
+#define DAI_ON_MASK_SFT					BIT(29)
+#define DAI2_ON_SFT					28
+#define DAI2_ON_MASK_SFT				BIT(28)
+#define VUL6_ON_SFT					23
+#define VUL6_ON_MASK_SFT				BIT(23)
+#define VUL5_ON_SFT					22
+#define VUL5_ON_MASK_SFT				BIT(22)
+#define VUL4_ON_SFT					21
+#define VUL4_ON_MASK_SFT				BIT(21)
+#define VUL3_ON_SFT					20
+#define VUL3_ON_MASK_SFT				BIT(20)
+#define VUL2_ON_SFT					19
+#define VUL2_ON_MASK_SFT				BIT(19)
+#define VUL_ON_SFT					18
+#define VUL_ON_MASK_SFT					BIT(18)
+#define AWB2_ON_SFT					17
+#define AWB2_ON_MASK_SFT				BIT(17)
+#define AWB_ON_SFT					16
+#define AWB_ON_MASK_SFT					BIT(16)
+#define DL12_ON_SFT					15
+#define DL12_ON_MASK_SFT				BIT(15)
+#define DL8_ON_SFT					11
+#define DL8_ON_MASK_SFT					BIT(11)
+#define DL7_ON_SFT					10
+#define DL7_ON_MASK_SFT					BIT(10)
+#define DL6_ON_SFT					9
+#define DL6_ON_MASK_SFT					BIT(9)
+#define DL5_ON_SFT					8
+#define DL5_ON_MASK_SFT					BIT(8)
+#define DL4_ON_SFT					7
+#define DL4_ON_MASK_SFT					BIT(7)
+#define DL3_ON_SFT					6
+#define DL3_ON_MASK_SFT					BIT(6)
+#define DL2_ON_SFT					5
+#define DL2_ON_MASK_SFT					BIT(5)
+#define DL1_ON_SFT					4
+#define DL1_ON_MASK_SFT					BIT(4)
+#define AUDIO_AFE_ON_SFT				0
+#define AUDIO_AFE_ON_MASK_SFT				BIT(0)
+
+/* AFE_DAC_MON */
+#define AFE_ON_RETM_SFT					0
+#define AFE_ON_RETM_MASK_SFT				BIT(0)
+
+/* AFE_I2S_CON */
+#define BCK_NEG_EG_LATCH_SFT				30
+#define BCK_NEG_EG_LATCH_MASK_SFT			BIT(30)
+#define BCK_INV_SFT					29
+#define BCK_INV_MASK_SFT				BIT(29)
+#define I2SIN_PAD_SEL_SFT				28
+#define I2SIN_PAD_SEL_MASK_SFT				BIT(28)
+#define I2S_LOOPBACK_SFT				20
+#define I2S_LOOPBACK_MASK_SFT				BIT(20)
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_SFT		17
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK_SFT		BIT(17)
+#define I2S1_HD_EN_SFT					12
+#define I2S1_HD_EN_MASK_SFT				BIT(12)
+#define I2S_OUT_MODE_SFT				8
+#define I2S_OUT_MODE_MASK_SFT				GENMASK(11, 8)
+#define INV_PAD_CTRL_SFT				7
+#define INV_PAD_CTRL_MASK_SFT				BIT(7)
+#define I2S_BYPSRC_SFT					6
+#define I2S_BYPSRC_MASK_SFT				BIT(6)
+#define INV_LRCK_SFT					5
+#define INV_LRCK_MASK_SFT				BIT(5)
+#define I2S_FMT_SFT					3
+#define I2S_FMT_MASK_SFT				BIT(3)
+#define I2S_SRC_SFT					2
+#define I2S_SRC_MASK_SFT				BIT(2)
+#define I2S_WLEN_SFT					1
+#define I2S_WLEN_MASK_SFT				BIT(1)
+#define I2S_EN_SFT					0
+#define I2S_EN_MASK_SFT					BIT(0)
+
+/* AFE_I2S_CON1 */
+#define I2S2_LR_SWAP_SFT				31
+#define I2S2_LR_SWAP_MASK_SFT				BIT(31)
+#define I2S2_SEL_O19_O20_SFT				18
+#define I2S2_SEL_O19_O20_MASK_SFT			BIT(18)
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_SFT		17
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK_SFT		BIT(17)
+#define I2S2_SEL_O03_O04_SFT				16
+#define I2S2_SEL_O03_O04_MASK_SFT			BIT(16)
+#define I2S2_HD_EN_SFT					12
+#define I2S2_HD_EN_MASK_SFT				BIT(12)
+#define I2S2_OUT_MODE_SFT				8
+#define I2S2_OUT_MODE_MASK_SFT				GENMASK(11, 8)
+#define INV_LRCK_SFT					5
+#define INV_LRCK_MASK_SFT				BIT(5)
+#define I2S2_FMT_SFT					3
+#define I2S2_FMT_MASK_SFT				BIT(3)
+#define I2S2_WLEN_SFT					1
+#define I2S2_WLEN_MASK_SFT				BIT(1)
+#define I2S2_EN_SFT					0
+#define I2S2_EN_MASK_SFT				BIT(0)
+
+/* AFE_I2S_CON2 */
+#define I2S3_LR_SWAP_SFT				31
+#define I2S3_LR_SWAP_MASK_SFT				BIT(31)
+#define I2S3_UPDATE_WORD_SFT				24
+#define I2S3_UPDATE_WORD_MASK_SFT			GENMASK(28, 24)
+#define I2S3_BCK_INV_SFT				23
+#define I2S3_BCK_INV_MASK_SFT				BIT(23)
+#define I2S3_FPGA_BIT_TEST_SFT				22
+#define I2S3_FPGA_BIT_TEST_MASK_SFT			BIT(22)
+#define I2S3_FPGA_BIT_SFT				21
+#define I2S3_FPGA_BIT_MASK_SFT				BIT(21)
+#define I2S3_LOOPBACK_SFT				20
+#define I2S3_LOOPBACK_MASK_SFT				BIT(20)
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_SFT		17
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK_SFT		BIT(17)
+#define I2S3_HD_EN_SFT					12
+#define I2S3_HD_EN_MASK_SFT				BIT(12)
+#define I2S3_OUT_MODE_SFT				8
+#define I2S3_OUT_MODE_MASK_SFT				GENMASK(11, 8)
+#define I2S3_FMT_SFT					3
+#define I2S3_FMT_MASK_SFT				BIT(3)
+#define I2S3_WLEN_SFT					1
+#define I2S3_WLEN_MASK_SFT				BIT(1)
+#define I2S3_EN_SFT					0
+#define I2S3_EN_MASK_SFT				BIT(0)
+
+/* AFE_I2S_CON3 */
+#define I2S4_LR_SWAP_SFT				31
+#define I2S4_LR_SWAP_MASK_SFT				BIT(31)
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_SFT		17
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK_SFT		BIT(17)
+#define I2S4_HD_EN_SFT					12
+#define I2S4_HD_EN_MASK_SFT				BIT(12)
+#define I2S4_OUT_MODE_SFT				8
+#define I2S4_OUT_MODE_MASK_SFT				GENMASK(11, 8)
+#define INV_LRCK_SFT					5
+#define INV_LRCK_MASK_SFT				BIT(5)
+#define I2S4_FMT_SFT					3
+#define I2S4_FMT_MASK_SFT				BIT(3)
+#define I2S4_WLEN_SFT					1
+#define I2S4_WLEN_MASK_SFT				BIT(1)
+#define I2S4_EN_SFT					0
+#define I2S4_EN_MASK_SFT				BIT(0)
+
+/* AFE_I2S_CON4 */
+#define I2S_LOOPBACK_SFT				20
+#define I2S_LOOPBACK_MASK				0x1
+#define I2S_LOOPBACK_MASK_SFT				BIT(20)
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_SFT		17
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK		0x1
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK_SFT		BIT(17)
+#define INV_LRCK_SFT					5
+#define INV_LRCK_MASK					0x1
+#define INV_LRCK_MASK_SFT				BIT(5)
+
+/* AFE_CONNSYS_I2S_CON */
+#define BCK_NEG_EG_LATCH_SFT				30
+#define BCK_NEG_EG_LATCH_MASK_SFT			BIT(30)
+#define BCK_INV_SFT					29
+#define BCK_INV_MASK_SFT				BIT(29)
+#define I2SIN_PAD_SEL_SFT				28
+#define I2SIN_PAD_SEL_MASK_SFT				BIT(28)
+#define I2S_LOOPBACK_SFT				20
+#define I2S_LOOPBACK_MASK_SFT				BIT(20)
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_SFT		17
+#define I2S_ONOFF_NOT_RESET_CK_ENABLE_MASK_SFT		BIT(17)
+#define I2S_MODE_SFT					8
+#define I2S_MODE_MASK_SFT				GENMASK(11, 8)
+#define INV_PAD_CTRL_SFT				7
+#define INV_PAD_CTRL_MASK_SFT				BIT(7)
+#define I2S_BYPSRC_SFT					6
+#define I2S_BYPSRC_MASK_SFT				BIT(6)
+#define INV_LRCK_SFT					5
+#define INV_LRCK_MASK_SFT				BIT(5)
+#define I2S_FMT_SFT					3
+#define I2S_FMT_MASK_SFT				BIT(3)
+#define I2S_SRC_SFT					2
+#define I2S_SRC_MASK_SFT				BIT(2)
+#define I2S_WLEN_SFT					1
+#define I2S_WLEN_MASK_SFT				BIT(1)
+#define I2S_EN_SFT					0
+#define I2S_EN_MASK_SFT					BIT(0)
+
+/* AFE_ASRC_2CH_CON2 */
+#define CHSET_O16BIT_SFT				19
+#define CHSET_O16BIT_MASK_SFT				BIT(19)
+#define CHSET_CLR_IIR_HISTORY_SFT			17
+#define CHSET_CLR_IIR_HISTORY_MASK_SFT			BIT(17)
+#define CHSET_IS_MONO_SFT				16
+#define CHSET_IS_MONO_MASK_SFT				BIT(16)
+#define CHSET_IIR_EN_SFT				11
+#define CHSET_IIR_EN_MASK_SFT				BIT(11)
+#define CHSET_IIR_STAGE_SFT				8
+#define CHSET_IIR_STAGE_MASK_SFT			GENMASK(10, 8)
+#define CHSET_STR_CLR_SFT				5
+#define CHSET_STR_CLR_MASK_SFT				BIT(5)
+#define CHSET_ON_SFT					2
+#define CHSET_ON_MASK_SFT				BIT(2)
+#define COEFF_SRAM_CTRL_SFT				1
+#define COEFF_SRAM_CTRL_MASK_SFT			BIT(1)
+#define ASM_ON_SFT					0
+#define ASM_ON_MASK_SFT					BIT(0)
+
+/* AFE_GAIN1_CON0 */
+#define GAIN1_SAMPLE_PER_STEP_SFT			8
+#define GAIN1_SAMPLE_PER_STEP_MASK_SFT			GENMASK(15, 8)
+#define GAIN1_MODE_SFT					4
+#define GAIN1_MODE_MASK_SFT				GENMASK(7, 4)
+#define GAIN1_ON_SFT					0
+#define GAIN1_ON_MASK_SFT				BIT(0)
+
+/* AFE_GAIN1_CON1 */
+#define GAIN1_TARGET_SFT				0
+#define GAIN1_TARGET_MASK				0xfffffff
+#define GAIN1_TARGET_MASK_SFT				GENMASK(27, 0)
+
+/* AFE_GAIN2_CON0 */
+#define GAIN2_SAMPLE_PER_STEP_SFT			8
+#define GAIN2_SAMPLE_PER_STEP_MASK_SFT			GENMASK(15, 8)
+#define GAIN2_MODE_SFT					4
+#define GAIN2_MODE_MASK_SFT				GENMASK(7, 4)
+#define GAIN2_ON_SFT					0
+#define GAIN2_ON_MASK_SFT				BIT(0)
+
+/* AFE_GAIN2_CON1 */
+#define GAIN2_TARGET_SFT				0
+#define GAIN2_TARGET_MASK				0xfffffff
+#define GAIN2_TARGET_MASK_SFT				GENMASK(27, 0)
+
+/* AFE_GAIN1_CUR */
+#define AFE_GAIN1_CUR_SFT				0
+#define AFE_GAIN1_CUR_MASK_SFT				GENMASK(27, 0)
+
+/* AFE_GAIN2_CUR */
+#define AFE_GAIN2_CUR_SFT				0
+#define AFE_GAIN2_CUR_MASK_SFT				GENMASK(27, 0)
+
+/* PCM_INTF_CON1 */
+#define PCM_FIX_VALUE_SEL_SFT				31
+#define PCM_FIX_VALUE_SEL_MASK_SFT			BIT(31)
+#define PCM_BUFFER_LOOPBACK_SFT				30
+#define PCM_BUFFER_LOOPBACK_MASK_SFT			BIT(30)
+#define PCM_PARALLEL_LOOPBACK_SFT			29
+#define PCM_PARALLEL_LOOPBACK_MASK_SFT			BIT(29)
+#define PCM_SERIAL_LOOPBACK_SFT				28
+#define PCM_SERIAL_LOOPBACK_MASK_SFT			BIT(28)
+#define PCM_DAI_PCM_LOOPBACK_SFT			27
+#define PCM_DAI_PCM_LOOPBACK_MASK_SFT			BIT(27)
+#define PCM_I2S_PCM_LOOPBACK_SFT			26
+#define PCM_I2S_PCM_LOOPBACK_MASK_SFT			BIT(26)
+#define PCM_SYNC_DELSEL_SFT				25
+#define PCM_SYNC_DELSEL_MASK_SFT			BIT(25)
+#define PCM_TX_LR_SWAP_SFT				24
+#define PCM_TX_LR_SWAP_MASK_SFT				BIT(24)
+#define PCM_SYNC_OUT_INV_SFT				23
+#define PCM_SYNC_OUT_INV_MASK_SFT			BIT(23)
+#define PCM_BCLK_OUT_INV_SFT				22
+#define PCM_BCLK_OUT_INV_MASK_SFT			BIT(22)
+#define PCM_SYNC_IN_INV_SFT				21
+#define PCM_SYNC_IN_INV_MASK_SFT			BIT(21)
+#define PCM_BCLK_IN_INV_SFT				20
+#define PCM_BCLK_IN_INV_MASK_SFT			BIT(20)
+#define PCM_TX_LCH_RPT_SFT				19
+#define PCM_TX_LCH_RPT_MASK_SFT				BIT(19)
+#define PCM_VBT_16K_MODE_SFT				18
+#define PCM_VBT_16K_MODE_MASK_SFT			BIT(18)
+#define PCM_EXT_MODEM_SFT				17
+#define PCM_EXT_MODEM_MASK_SFT				BIT(17)
+#define PCM_24BIT_SFT					16
+#define PCM_24BIT_MASK_SFT				BIT(16)
+#define PCM_WLEN_SFT					14
+#define PCM_WLEN_MASK_SFT				GENMASK(15, 14)
+#define PCM_SYNC_LENGTH_SFT				9
+#define PCM_SYNC_LENGTH_MASK_SFT			GENMASK(13, 9)
+#define PCM_SYNC_TYPE_SFT				8
+#define PCM_SYNC_TYPE_MASK_SFT				BIT(8)
+#define PCM_BT_MODE_SFT					7
+#define PCM_BT_MODE_MASK_SFT				BIT(7)
+#define PCM_BYP_ASRC_SFT				6
+#define PCM_BYP_ASRC_MASK_SFT				BIT(6)
+#define PCM_SLAVE_SFT					5
+#define PCM_SLAVE_MASK_SFT				BIT(5)
+#define PCM_MODE_SFT					3
+#define PCM_MODE_MASK_SFT				GENMASK(4, 3)
+#define PCM_FMT_SFT					1
+#define PCM_FMT_MASK_SFT				GENMASK(2, 1)
+#define PCM_EN_SFT					0
+#define PCM_EN_MASK_SFT					BIT(0)
+
+/* PCM_INTF_CON2 */
+#define PCM1_TX_FIFO_OV_SFT				31
+#define PCM1_TX_FIFO_OV_MASK_SFT			BIT(31)
+#define PCM1_RX_FIFO_OV_SFT				30
+#define PCM1_RX_FIFO_OV_MASK_SFT			BIT(30)
+#define PCM2_TX_FIFO_OV_SFT				29
+#define PCM2_TX_FIFO_OV_MASK_SFT			BIT(29)
+#define PCM2_RX_FIFO_OV_SFT				28
+#define PCM2_RX_FIFO_OV_MASK_SFT			BIT(28)
+#define PCM1_SYNC_GLITCH_SFT				27
+#define PCM1_SYNC_GLITCH_MASK_SFT			BIT(27)
+#define PCM2_SYNC_GLITCH_SFT				26
+#define PCM2_SYNC_GLITCH_MASK_SFT			BIT(26)
+#define TX3_RCH_DBG_MODE_SFT				17
+#define TX3_RCH_DBG_MODE_MASK_SFT			BIT(17)
+#define PCM1_PCM2_LOOPBACK_SFT				16
+#define PCM1_PCM2_LOOPBACK_MASK_SFT			BIT(16)
+#define DAI_PCM_LOOPBACK_CH_SFT				14
+#define DAI_PCM_LOOPBACK_CH_MASK_SFT			GENMASK(15, 14)
+#define I2S_PCM_LOOPBACK_CH_SFT				12
+#define I2S_PCM_LOOPBACK_CH_MASK_SFT			GENMASK(13, 12)
+#define TX_FIX_VALUE_SFT				0
+#define TX_FIX_VALUE_MASK_SFT				GENMASK(7, 0)
+
+/* PCM2_INTF_CON */
+#define PCM2_TX_FIX_VALUE_SFT				24
+#define PCM2_TX_FIX_VALUE_MASK_SFT			GENMASK(31, 24)
+#define PCM2_FIX_VALUE_SEL_SFT				23
+#define PCM2_FIX_VALUE_SEL_MASK_SFT			BIT(23)
+#define PCM2_BUFFER_LOOPBACK_SFT			22
+#define PCM2_BUFFER_LOOPBACK_MASK_SFT			BIT(22)
+#define PCM2_PARALLEL_LOOPBACK_SFT			21
+#define PCM2_PARALLEL_LOOPBACK_MASK_SFT			BIT(21)
+#define PCM2_SERIAL_LOOPBACK_SFT			20
+#define PCM2_SERIAL_LOOPBACK_MASK_SFT			BIT(20)
+#define PCM2_DAI_PCM_LOOPBACK_SFT			19
+#define PCM2_DAI_PCM_LOOPBACK_MASK_SFT			BIT(19)
+#define PCM2_I2S_PCM_LOOPBACK_SFT			18
+#define PCM2_I2S_PCM_LOOPBACK_MASK_SFT			BIT(18)
+#define PCM2_SYNC_DELSEL_SFT				17
+#define PCM2_SYNC_DELSEL_MASK_SFT			BIT(17)
+#define PCM2_TX_LR_SWAP_SFT				16
+#define PCM2_TX_LR_SWAP_MASK_SFT			BIT(16)
+#define PCM2_SYNC_IN_INV_SFT				15
+#define PCM2_SYNC_IN_INV_MASK_SFT			BIT(15)
+#define PCM2_BCLK_IN_INV_SFT				14
+#define PCM2_BCLK_IN_INV_MASK_SFT			BIT(14)
+#define PCM2_TX_LCH_RPT_SFT				13
+#define PCM2_TX_LCH_RPT_MASK_SFT			BIT(13)
+#define PCM2_VBT_16K_MODE_SFT				12
+#define PCM2_VBT_16K_MODE_MASK_SFT			BIT(12)
+#define PCM2_LOOPBACK_CH_SEL_SFT			10
+#define PCM2_LOOPBACK_CH_SEL_MASK_SFT			GENMASK(11, 10)
+#define PCM2_TX2_BT_MODE_SFT				8
+#define PCM2_TX2_BT_MODE_MASK_SFT			BIT(8)
+#define PCM2_BT_MODE_SFT				7
+#define PCM2_BT_MODE_MASK_SFT				BIT(7)
+#define PCM2_AFIFO_SFT					6
+#define PCM2_AFIFO_MASK_SFT				BIT(6)
+#define PCM2_WLEN_SFT					5
+#define PCM2_WLEN_MASK_SFT				BIT(5)
+#define PCM2_MODE_SFT					3
+#define PCM2_MODE_MASK_SFT				GENMASK(4, 3)
+#define PCM2_FMT_SFT					1
+#define PCM2_FMT_MASK_SFT				GENMASK(2, 1)
+#define PCM2_EN_SFT					0
+#define PCM2_EN_MASK_SFT				BIT(0)
+
+// AFE_CM1_CON
+#define CHANNEL_MERGE0_DEBUG_MODE_SFT			(31)
+#define CHANNEL_MERGE0_DEBUG_MODE_MASK_SFT		BIT(31)
+#define VUL3_BYPASS_CM_SFT				(30)
+#define VUL3_BYPASS_CM_MASK				(0x1)
+#define VUL3_BYPASS_CM_MASK_SFT				BIT(30)
+#define CM1_DEBUG_MODE_SEL_SFT				(29)
+#define CM1_DEBUG_MODE_SEL_MASK_SFT			BIT(29)
+#define CHANNEL_MERGE0_UPDATE_CNT_SFT			(16)
+#define CHANNEL_MERGE0_UPDATE_CNT_MASK_SFT		GENMASK(28, 16)
+#define CM1_FS_SELECT_SFT				(8)
+#define CM1_FS_SELECT_MASK_SFT				GENMASK(12, 8)
+#define CHANNEL_MERGE0_CHNUM_SFT			(3)
+#define CHANNEL_MERGE0_CHNUM_MASK_SFT			GENMASK(7, 3)
+#define CHANNEL_MERGE0_BYTE_SWAP_SFT			(1)
+#define CHANNEL_MERGE0_BYTE_SWAP_MASK_SFT		BIT(1)
+#define CHANNEL_MERGE0_EN_SFT				(0)
+#define CHANNEL_MERGE0_EN_MASK_SFT			BIT(0)
+
+/* AFE_ADDA_MTKAIF_CFG0 */
+#define MTKAIF_RXIF_CLKINV_ADC_SFT			31
+#define MTKAIF_RXIF_CLKINV_ADC_MASK_SFT			BIT(31)
+#define MTKAIF_RXIF_BYPASS_SRC_SFT			17
+#define MTKAIF_RXIF_BYPASS_SRC_MASK_SFT			BIT(17)
+#define MTKAIF_RXIF_PROTOCOL2_SFT			16
+#define MTKAIF_RXIF_PROTOCOL2_MASK_SFT			BIT(16)
+#define MTKAIF_TXIF_BYPASS_SRC_SFT			5
+#define MTKAIF_TXIF_BYPASS_SRC_MASK_SFT			BIT(5)
+#define MTKAIF_TXIF_PROTOCOL2_SFT			4
+#define MTKAIF_TXIF_PROTOCOL2_MASK_SFT			BIT(4)
+#define MTKAIF_TXIF_8TO5_SFT				2
+#define MTKAIF_TXIF_8TO5_MASK_SFT			BIT(2)
+#define MTKAIF_RXIF_8TO5_SFT				1
+#define MTKAIF_RXIF_8TO5_MASK_SFT			BIT(1)
+#define MTKAIF_IF_LOOPBACK1_SFT				0
+#define MTKAIF_IF_LOOPBACK1_MASK_SFT			BIT(0)
+
+/* AFE_ADDA_MTKAIF_RX_CFG2 */
+#define MTKAIF_RXIF_DETECT_ON_PROTOCOL2_SFT		16
+#define MTKAIF_RXIF_DETECT_ON_PROTOCOL2_MASK_SFT	BIT(16)
+#define MTKAIF_RXIF_DELAY_CYCLE_SFT			12
+#define MTKAIF_RXIF_DELAY_CYCLE_MASK_SFT		GENMASK(15, 12)
+#define MTKAIF_RXIF_DELAY_DATA_SFT			8
+#define MTKAIF_RXIF_DELAY_DATA_MASK			0x1
+#define MTKAIF_RXIF_DELAY_DATA_MASK_SFT			BIT(8)
+#define MTKAIF_RXIF_FIFO_RSP_PROTOCOL2_SFT		4
+#define MTKAIF_RXIF_FIFO_RSP_PROTOCOL2_MASK_SFT		GENMASK(6, 4)
+
+/* AFE_ADDA_DL_SRC2_CON0 */
+#define DL_2_INPUT_MODE_CTL_SFT				28
+#define DL_2_INPUT_MODE_CTL_MASK_SFT			GENMASK(31, 28)
+#define DL_2_CH1_SATURATION_EN_CTL_SFT			27
+#define DL_2_CH1_SATURATION_EN_CTL_MASK_SFT		BIT(27)
+#define DL_2_CH2_SATURATION_EN_CTL_SFT			26
+#define DL_2_CH2_SATURATION_EN_CTL_MASK_SFT		BIT(26)
+#define DL_2_OUTPUT_SEL_CTL_SFT				24
+#define DL_2_OUTPUT_SEL_CTL_MASK_SFT			GENMASK(25, 24)
+#define DL_2_FADEIN_0START_EN_SFT			16
+#define DL_2_FADEIN_0START_EN_MASK_SFT			GENMASK(17, 16)
+#define DL_DISABLE_HW_CG_CTL_SFT			15
+#define DL_DISABLE_HW_CG_CTL_MASK_SFT			BIT(15)
+#define C_DATA_EN_SEL_CTL_PRE_SFT			14
+#define C_DATA_EN_SEL_CTL_PRE_MASK_SFT			BIT(14)
+#define DL_2_SIDE_TONE_ON_CTL_PRE_SFT			13
+#define DL_2_SIDE_TONE_ON_CTL_PRE_MASK_SFT		BIT(13)
+#define DL_2_MUTE_CH1_OFF_CTL_PRE_SFT			12
+#define DL_2_MUTE_CH1_OFF_CTL_PRE_MASK_SFT		BIT(12)
+#define DL_2_MUTE_CH2_OFF_CTL_PRE_SFT			11
+#define DL_2_MUTE_CH2_OFF_CTL_PRE_MASK_SFT		BIT(11)
+#define DL2_ARAMPSP_CTL_PRE_SFT				9
+#define DL2_ARAMPSP_CTL_PRE_MASK_SFT			GENMASK(10, 9)
+#define DL_2_IIRMODE_CTL_PRE_SFT			6
+#define DL_2_IIRMODE_CTL_PRE_MASK_SFT			GENMASK(8, 6)
+#define DL_2_VOICE_MODE_CTL_PRE_SFT			5
+#define DL_2_VOICE_MODE_CTL_PRE_MASK_SFT		BIT(5)
+#define D2_2_MUTE_CH1_ON_CTL_PRE_SFT			4
+#define D2_2_MUTE_CH1_ON_CTL_PRE_MASK_SFT		BIT(4)
+#define D2_2_MUTE_CH2_ON_CTL_PRE_SFT			3
+#define D2_2_MUTE_CH2_ON_CTL_PRE_MASK_SFT		BIT(3)
+#define DL_2_IIR_ON_CTL_PRE_SFT				2
+#define DL_2_IIR_ON_CTL_PRE_MASK_SFT			BIT(2)
+#define DL_2_GAIN_ON_CTL_PRE_SFT			1
+#define DL_2_GAIN_ON_CTL_PRE_MASK_SFT			BIT(1)
+#define DL_2_SRC_ON_CTL_PRE_SFT				0
+#define DL_2_SRC_ON_CTL_PRE_MASK_SFT			BIT(0)
+
+/* AFE_ADDA_DL_SRC2_CON1 */
+#define DL_2_GAIN_CTL_PRE_SFT				16
+#define DL_2_GAIN_CTL_PRE_MASK				0xffff
+#define DL_2_GAIN_CTL_PRE_MASK_SFT			GENMASK(31, 16)
+#define DL_2_GAIN_MODE_CTL_SFT				0
+#define DL_2_GAIN_MODE_CTL_MASK_SFT			BIT(0)
+
+/* AFE_ADDA_UL_SRC_CON0 */
+#define ULCF_CFG_EN_CTL_SFT				31
+#define ULCF_CFG_EN_CTL_MASK_SFT			BIT(31)
+#define UL_DMIC_PHASE_SEL_CH1_SFT			27
+#define UL_DMIC_PHASE_SEL_CH1_MASK_SFT			GENMASK(29, 27)
+#define UL_DMIC_PHASE_SEL_CH2_SFT			24
+#define UL_DMIC_PHASE_SEL_CH2_MASK_SFT			GENMASK(26, 24)
+#define UL_MODE_3P25M_CH2_CTL_SFT			22
+#define UL_MODE_3P25M_CH2_CTL_MASK_SFT			BIT(22)
+#define UL_MODE_3P25M_CH1_CTL_SFT			21
+#define UL_MODE_3P25M_CH1_CTL_MASK_SFT			BIT(21)
+#define UL_VOICE_MODE_CH1_CH2_CTL_SFT			17
+#define UL_VOICE_MODE_CH1_CH2_CTL_MASK_SFT		GENMASK(19, 17)
+#define UL_AP_DMIC_ON_SFT				16
+#define UL_AP_DMIC_ON_MASK_SFT				BIT(16)
+#define DMIC_LOW_POWER_CTL_SFT				14
+#define DMIC_LOW_POWER_CTL_MASK_SFT			GENMASK(15, 14)
+#define UL_DISABLE_HW_CG_CTL_SFT			12
+#define UL_DISABLE_HW_CG_CTL_MASK_SFT			BIT(12)
+#define UL_IIR_ON_TMP_CTL_SFT				10
+#define UL_IIR_ON_TMP_CTL_MASK_SFT			BIT(10)
+#define UL_IIRMODE_CTL_SFT				7
+#define UL_IIRMODE_CTL_MASK_SFT				GENMASK(9, 7)
+#define DIGMIC_4P33M_SEL_SFT				6
+#define DIGMIC_4P33M_SEL_MASK_SFT			BIT(6)
+#define DIGMIC_3P25M_1P625M_SEL_SFT			5
+#define DIGMIC_3P25M_1P625M_SEL_MASK_SFT		BIT(5)
+#define UL_LOOP_BACK_MODE_SFT				2
+#define UL_LOOP_BACK_MODE_MASK_SFT			BIT(2)
+#define UL_SDM_3_LEVEL_SFT				1
+#define UL_SDM_3_LEVEL_MASK_SFT				BIT(1)
+#define UL_SRC_ON_CTL_SFT				0
+#define UL_SRC_ON_CTL_MASK_SFT				BIT(0)
+
+/* AFE_ADDA_UL_SRC_CON1 */
+#define C_DAC_EN_CTL_SFT				27
+#define C_DAC_EN_CTL_MASK_SFT				BIT(27)
+#define C_MUTE_SW_CTL_SFT				26
+#define C_MUTE_SW_CTL_MASK_SFT				BIT(26)
+#define ASDM_SRC_SEL_CTL_SFT				25
+#define ASDM_SRC_SEL_CTL_MASK_SFT			BIT(25)
+#define C_AMP_DIV_CH2_CTL_SFT				21
+#define C_AMP_DIV_CH2_CTL_MASK_SFT			GENMASK(23, 21)
+#define C_FREQ_DIV_CH2_CTL_SFT				16
+#define C_FREQ_DIV_CH2_CTL_MASK_SFT			GENMASK(20, 16)
+#define C_SINE_MODE_CH2_CTL_SFT				12
+#define C_SINE_MODE_CH2_CTL_MASK_SFT			GENMASK(15, 12)
+#define C_AMP_DIV_CH1_CTL_SFT				9
+#define C_AMP_DIV_CH1_CTL_MASK_SFT			GENMASK(11, 9)
+#define C_FREQ_DIV_CH1_CTL_SFT				4
+#define C_FREQ_DIV_CH1_CTL_MASK_SFT			GENMASK(8, 4)
+#define C_SINE_MODE_CH1_CTL_SFT				0
+#define C_SINE_MODE_CH1_CTL_MASK_SFT			GENMASK(3, 0)
+
+/* AFE_ADDA_TOP_CON0 */
+#define C_LOOP_BACK_MODE_CTL_SFT			12
+#define C_LOOP_BACK_MODE_CTL_MASK_SFT			GENMASK(15, 12)
+#define ADDA_UL_GAIN_MODE_SFT				8
+#define ADDA_UL_GAIN_MODE_MASK_SFT			GENMASK(9, 8)
+#define C_EXT_ADC_CTL_SFT				0
+#define C_EXT_ADC_CTL_MASK_SFT				BIT(0)
+
+/* AFE_ADDA_UL_DL_CON0 */
+#define AFE_ADDA_UL_LR_SWAP_SFT				31
+#define AFE_ADDA_UL_LR_SWAP_MASK_SFT			BIT(31)
+#define AFE_ADDA_CKDIV_RST_SFT				30
+#define AFE_ADDA_CKDIV_RST_MASK_SFT			BIT(30)
+#define AFE_ADDA_FIFO_AUTO_RST_SFT			29
+#define AFE_ADDA_FIFO_AUTO_RST_MASK_SFT			BIT(29)
+#define AFE_ADDA_UL_FIFO_DIGMIC_TESTIN_SFT		21
+#define AFE_ADDA_UL_FIFO_DIGMIC_TESTIN_MASK_SFT		GENMASK(22, 21)
+#define AFE_ADDA_UL_FIFO_DIGMIC_WDATA_TESTEN_SFT	20
+#define AFE_ADDA_UL_FIFO_DIGMIC_WDATA_TESTEN_MASK_SFT	BIT(20)
+#define AFE_ADDA6_UL_LR_SWAP_SFT			15
+#define AFE_ADDA6_UL_LR_SWAP_MASK_SFT			BIT(15)
+#define AFE_ADDA6_CKDIV_RST_SFT				14
+#define AFE_ADDA6_CKDIV_RST_MASK_SFT			BIT(14)
+#define AFE_ADDA6_FIFO_AUTO_RST_SFT			13
+#define AFE_ADDA6_FIFO_AUTO_RST_MASK_SFT		BIT(13)
+#define AFE_ADDA6_UL_FIFO_DIGMIC_TESTIN_SFT		5
+#define AFE_ADDA6_UL_FIFO_DIGMIC_TESTIN_MASK_SFT	GENMASK(6, 5)
+#define AFE_ADDA6_UL_FIFO_DIGMIC_WDATA_TESTEN_SFT	4
+#define AFE_ADDA6_UL_FIFO_DIGMIC_WDATA_TESTEN_MASK_SFT	BIT(4)
+#define ADDA_AFE_ON_SFT					0
+#define ADDA_AFE_ON_MASK_SFT				BIT(0)
+
+/* AFE_SIDETONE_CON0 */
+#define R_RDY_SFT					30
+#define R_RDY_MASK_SFT					BIT(30)
+#define W_RDY_SFT					29
+#define W_RDY_MASK_SFT					BIT(29)
+#define R_W_EN_SFT					25
+#define R_W_EN_MASK_SFT					BIT(25)
+#define R_W_SEL_SFT					24
+#define R_W_SEL_MASK_SFT				BIT(24)
+#define SEL_CH2_SFT					23
+#define SEL_CH2_MASK_SFT				BIT(23)
+#define SIDE_TONE_COEFFICIENT_ADDR_SFT			16
+#define SIDE_TONE_COEFFICIENT_ADDR_MASK_SFT		GENMASK(20, 16)
+#define SIDE_TONE_COEFFICIENT_SFT			0
+#define SIDE_TONE_COEFFICIENT_MASK_SFT			GENMASK(15, 0)
+
+/* AFE_SIDETONE_COEFF */
+#define SIDE_TONE_COEFF_SFT				0
+#define SIDE_TONE_COEFF_MASK_SFT			GENMASK(15, 0)
+
+/* AFE_SIDETONE_CON1 */
+#define STF_BYPASS_MODE_SFT				31
+#define STF_BYPASS_MODE_MASK_SFT			BIT(31)
+#define STF_BYPASS_MODE_O28_O29_SFT			30
+#define STF_BYPASS_MODE_O28_O29_MASK_SFT		BIT(30)
+#define STF_BYPASS_MODE_I2S4_SFT			29
+#define STF_BYPASS_MODE_I2S4_MASK_SFT			BIT(29)
+#define STF_BYPASS_MODE_DL3_SFT				27
+#define STF_BYPASS_MODE_DL3_MASK_SFT			BIT(27)
+#define STF_BYPASS_MODE_I2S7_SFT			26
+#define STF_BYPASS_MODE_I2S7_MASK_SFT			BIT(26)
+#define STF_BYPASS_MODE_I2S9_SFT			25
+#define STF_BYPASS_MODE_I2S9_MASK_SFT			BIT(25)
+#define STF_O19O20_OUT_EN_SEL_SFT			13
+#define STF_O19O20_OUT_EN_SEL_MASK_SFT			BIT(13)
+#define STF_SOURCE_FROM_O19O20_SFT			12
+#define STF_SOURCE_FROM_O19O20_MASK_SFT			BIT(12)
+#define SIDE_TONE_ON_SFT				8
+#define SIDE_TONE_ON_MASK_SFT				BIT(8)
+#define SIDE_TONE_HALF_TAP_NUM_SFT			0
+#define SIDE_TONE_HALF_TAP_NUM_MASK_SFT			GENMASK(5, 0)
+
+/* AFE_SIDETONE_GAIN */
+#define POSITIVE_GAIN_SFT				16
+#define POSITIVE_GAIN_MASK_SFT				GENMASK(18, 16)
+#define SIDE_TONE_GAIN_SFT				0
+#define SIDE_TONE_GAIN_MASK_SFT				GENMASK(15, 0)
+
+/* AFE_ADDA_DL_SDM_DCCOMP_CON */
+#define USE_3RD_SDM_SFT					28
+#define USE_3RD_SDM_MASK_SFT				BIT(28)
+#define DL_FIFO_START_POINT_SFT				24
+#define DL_FIFO_START_POINT_MASK_SFT			GENMASK(26, 24)
+#define DL_FIFO_SWAP_SFT				20
+#define DL_FIFO_SWAP_MASK_SFT				BIT(20)
+#define C_AUDSDM1ORDSELECT_CTL_SFT			19
+#define C_AUDSDM1ORDSELECT_CTL_MASK_SFT			BIT(19)
+#define C_SDM7BITSEL_CTL_SFT				18
+#define C_SDM7BITSEL_CTL_MASK_SFT			BIT(18)
+#define GAIN_AT_SDM_RST_PRE_CTL_SFT			15
+#define GAIN_AT_SDM_RST_PRE_CTL_MASK_SFT		BIT(15)
+#define DL_DCM_AUTO_IDLE_EN_SFT				14
+#define DL_DCM_AUTO_IDLE_EN_MASK_SFT			BIT(14)
+#define AFE_DL_SRC_DCM_EN_SFT				13
+#define AFE_DL_SRC_DCM_EN_MASK_SFT			BIT(13)
+#define AFE_DL_POST_SRC_DCM_EN_SFT			12
+#define AFE_DL_POST_SRC_DCM_EN_MASK_SFT			BIT(12)
+#define AUD_SDM_MONO_SFT				9
+#define AUD_SDM_MONO_MASK_SFT				BIT(9)
+#define AUD_DC_COMP_EN_SFT				8
+#define AUD_DC_COMP_EN_MASK_SFT				BIT(8)
+#define ATTGAIN_CTL_SFT					0
+#define ATTGAIN_CTL_MASK_SFT				GENMASK(5, 0)
+
+/* AFE_SINEGEN_CON0 */
+#define DAC_EN_SFT					26
+#define DAC_EN_MASK					0x1
+#define DAC_EN_MASK_SFT					BIT(26)
+#define MUTE_SW_CH2_SFT					25
+#define MUTE_SW_CH2_MASK				0x1
+#define MUTE_SW_CH2_MASK_SFT				BIT(25)
+#define MUTE_SW_CH1_SFT					24
+#define MUTE_SW_CH1_MASK				0x1
+#define MUTE_SW_CH1_MASK_SFT				BIT(24)
+#define SINE_MODE_CH2_SFT				20
+#define SINE_MODE_CH2_MASK				0xf
+#define SINE_MODE_CH2_MASK_SFT				GENMASK(23, 20)
+#define AMP_DIV_CH2_SFT					17
+#define AMP_DIV_CH2_MASK				0x7
+#define AMP_DIV_CH2_MASK_SFT				GENMASK(19, 17)
+#define FREQ_DIV_CH2_SFT				12
+#define FREQ_DIV_CH2_MASK				0x1f
+#define FREQ_DIV_CH2_MASK_SFT				GENMASK(16, 12)
+#define SINE_MODE_CH1_SFT				8
+#define SINE_MODE_CH1_MASK				0xf
+#define SINE_MODE_CH1_MASK_SFT				GENMASK(11, 8)
+#define AMP_DIV_CH1_SFT					5
+#define AMP_DIV_CH1_MASK				0x7
+#define AMP_DIV_CH1_MASK_SFT				GENMASK(7, 5)
+#define FREQ_DIV_CH1_SFT				0
+#define FREQ_DIV_CH1_MASK				0x1f
+#define FREQ_DIV_CH1_MASK_SFT				GENMASK(4, 0)
+
+/* AFE_SINEGEN_CON2 */
+#define INNER_LOOP_BACK_MODE_SFT			0
+#define INNER_LOOP_BACK_MODE_MASK_SFT			GENMASK(7, 0)
+
+/* AFE_HD_ENGEN_ENABLE */
+#define AFE_24M_ON_SFT					1
+#define AFE_24M_ON_MASK_SFT				BIT(1)
+#define AFE_22M_ON_SFT					0
+#define AFE_22M_ON_MASK_SFT				BIT(0)
+
+/* AFE_ADDA_DL_NLE_FIFO_MON */
+#define DL_NLE_FIFO_WBIN_SFT				8
+#define DL_NLE_FIFO_WBIN_MASK_SFT			GENMASK(11, 8)
+#define DL_NLE_FIFO_RBIN_SFT				4
+#define DL_NLE_FIFO_RBIN_MASK_SFT			GENMASK(7, 4)
+#define DL_NLE_FIFO_RDACTIVE_SFT			3
+#define DL_NLE_FIFO_RDACTIVE_MASK_SFT			BIT(3)
+#define DL_NLE_FIFO_STARTRD_SFT				2
+#define DL_NLE_FIFO_STARTRD_MASK_SFT			BIT(2)
+#define DL_NLE_FIFO_RD_EMPTY_SFT			1
+#define DL_NLE_FIFO_RD_EMPTY_MASK_SFT			BIT(1)
+#define DL_NLE_FIFO_WR_FULL_SFT				0
+#define DL_NLE_FIFO_WR_FULL_MASK_SFT			BIT(0)
+
+/* AFE_DL1_CON0 */
+#define DL1_MODE_SFT					24
+#define DL1_MODE_MASK					0xf
+#define DL1_MODE_MASK_SFT				GENMASK(27, 24)
+#define DL1_MINLEN_SFT					20
+#define DL1_MINLEN_MASK					0xf
+#define DL1_MINLEN_MASK_SFT				GENMASK(23, 20)
+#define DL1_MAXLEN_SFT					16
+#define DL1_MAXLEN_MASK					0xf
+#define DL1_MAXLEN_MASK_SFT				GENMASK(19, 16)
+#define DL1_SW_CLEAR_BUF_EMPTY_SFT			15
+#define DL1_SW_CLEAR_BUF_EMPTY_MASK			0x1
+#define DL1_SW_CLEAR_BUF_EMPTY_MASK_SFT			BIT(15)
+#define DL1_PBUF_SIZE_SFT				12
+#define DL1_PBUF_SIZE_MASK				0x3
+#define DL1_PBUF_SIZE_MASK_SFT				GENMASK(13, 12)
+#define DL1_MONO_SFT					8
+#define DL1_MONO_MASK					0x1
+#define DL1_MONO_MASK_SFT				BIT(8)
+#define DL1_NORMAL_MODE_SFT				5
+#define DL1_NORMAL_MODE_MASK				0x1
+#define DL1_NORMAL_MODE_MASK_SFT			BIT(5)
+#define DL1_HALIGN_SFT					4
+#define DL1_HALIGN_MASK					0x1
+#define DL1_HALIGN_MASK_SFT				BIT(4)
+#define DL1_HD_MODE_SFT					0
+#define DL1_HD_MODE_MASK				0x3
+#define DL1_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_DL2_CON0 */
+#define DL2_MODE_SFT					24
+#define DL2_MODE_MASK					0xf
+#define DL2_MODE_MASK_SFT				GENMASK(27, 24)
+#define DL2_MINLEN_SFT					20
+#define DL2_MINLEN_MASK					0xf
+#define DL2_MINLEN_MASK_SFT				GENMASK(23, 20)
+#define DL2_MAXLEN_SFT					16
+#define DL2_MAXLEN_MASK					0xf
+#define DL2_MAXLEN_MASK_SFT				GENMASK(19, 16)
+#define DL2_SW_CLEAR_BUF_EMPTY_SFT			15
+#define DL2_SW_CLEAR_BUF_EMPTY_MASK			0x1
+#define DL2_SW_CLEAR_BUF_EMPTY_MASK_SFT			BIT(15)
+#define DL2_PBUF_SIZE_SFT				12
+#define DL2_PBUF_SIZE_MASK				0x3
+#define DL2_PBUF_SIZE_MASK_SFT				GENMASK(13, 12)
+#define DL2_MONO_SFT					8
+#define DL2_MONO_MASK					0x1
+#define DL2_MONO_MASK_SFT				BIT(8)
+#define DL2_NORMAL_MODE_SFT				5
+#define DL2_NORMAL_MODE_MASK				0x1
+#define DL2_NORMAL_MODE_MASK_SFT			BIT(5)
+#define DL2_HALIGN_SFT					4
+#define DL2_HALIGN_MASK					0x1
+#define DL2_HALIGN_MASK_SFT				BIT(4)
+#define DL2_HD_MODE_SFT					0
+#define DL2_HD_MODE_MASK				0x3
+#define DL2_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_DL3_CON0 */
+#define DL3_MODE_SFT					24
+#define DL3_MODE_MASK					0xf
+#define DL3_MODE_MASK_SFT				GENMASK(27, 24)
+#define DL3_MINLEN_SFT					20
+#define DL3_MINLEN_MASK					0xf
+#define DL3_MINLEN_MASK_SFT				GENMASK(23, 20)
+#define DL3_MAXLEN_SFT					16
+#define DL3_MAXLEN_MASK					0xf
+#define DL3_MAXLEN_MASK_SFT				GENMASK(19, 16)
+#define DL3_SW_CLEAR_BUF_EMPTY_SFT			15
+#define DL3_SW_CLEAR_BUF_EMPTY_MASK			0x1
+#define DL3_SW_CLEAR_BUF_EMPTY_MASK_SFT			BIT(15)
+#define DL3_PBUF_SIZE_SFT				12
+#define DL3_PBUF_SIZE_MASK				0x3
+#define DL3_PBUF_SIZE_MASK_SFT				GENMASK(13, 12)
+#define DL3_MONO_SFT					8
+#define DL3_MONO_MASK					0x1
+#define DL3_MONO_MASK_SFT				BIT(8)
+#define DL3_NORMAL_MODE_SFT				5
+#define DL3_NORMAL_MODE_MASK				0x1
+#define DL3_NORMAL_MODE_MASK_SFT			BIT(5)
+#define DL3_HALIGN_SFT					4
+#define DL3_HALIGN_MASK					0x1
+#define DL3_HALIGN_MASK_SFT				BIT(4)
+#define DL3_HD_MODE_SFT					0
+#define DL3_HD_MODE_MASK				0x3
+#define DL3_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_DL4_CON0 */
+#define DL4_MODE_SFT					24
+#define DL4_MODE_MASK					0xf
+#define DL4_MODE_MASK_SFT				GENMASK(27, 24)
+#define DL4_MINLEN_SFT					20
+#define DL4_MINLEN_MASK					0xf
+#define DL4_MINLEN_MASK_SFT				GENMASK(23, 20)
+#define DL4_MAXLEN_SFT					16
+#define DL4_MAXLEN_MASK					0xf
+#define DL4_MAXLEN_MASK_SFT				GENMASK(19, 16)
+#define DL4_SW_CLEAR_BUF_EMPTY_SFT			15
+#define DL4_SW_CLEAR_BUF_EMPTY_MASK			0x1
+#define DL4_SW_CLEAR_BUF_EMPTY_MASK_SFT			BIT(15)
+#define DL4_PBUF_SIZE_SFT				12
+#define DL4_PBUF_SIZE_MASK				0x3
+#define DL4_PBUF_SIZE_MASK_SFT				GENMASK(13, 12)
+#define DL4_MONO_SFT					8
+#define DL4_MONO_MASK					0x1
+#define DL4_MONO_MASK_SFT				BIT(8)
+#define DL4_NORMAL_MODE_SFT				5
+#define DL4_NORMAL_MODE_MASK				0x1
+#define DL4_NORMAL_MODE_MASK_SFT			BIT(5)
+#define DL4_HALIGN_SFT					4
+#define DL4_HALIGN_MASK					0x1
+#define DL4_HALIGN_MASK_SFT				BIT(4)
+#define DL4_HD_MODE_SFT					0
+#define DL4_HD_MODE_MASK				0x3
+#define DL4_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_DL5_CON0 */
+#define DL5_MODE_SFT					24
+#define DL5_MODE_MASK					0xf
+#define DL5_MODE_MASK_SFT				GENMASK(27, 24)
+#define DL5_MINLEN_SFT					20
+#define DL5_MINLEN_MASK					0xf
+#define DL5_MINLEN_MASK_SFT				GENMASK(23, 20)
+#define DL5_MAXLEN_SFT					16
+#define DL5_MAXLEN_MASK					0xf
+#define DL5_MAXLEN_MASK_SFT				GENMASK(19, 16)
+#define DL5_SW_CLEAR_BUF_EMPTY_SFT			15
+#define DL5_SW_CLEAR_BUF_EMPTY_MASK			0x1
+#define DL5_SW_CLEAR_BUF_EMPTY_MASK_SFT			BIT(15)
+#define DL5_PBUF_SIZE_SFT				12
+#define DL5_PBUF_SIZE_MASK				0x3
+#define DL5_PBUF_SIZE_MASK_SFT				GENMASK(13, 12)
+#define DL5_MONO_SFT					8
+#define DL5_MONO_MASK					0x1
+#define DL5_MONO_MASK_SFT				BIT(8)
+#define DL5_NORMAL_MODE_SFT				5
+#define DL5_NORMAL_MODE_MASK				0x1
+#define DL5_NORMAL_MODE_MASK_SFT			BIT(5)
+#define DL5_HALIGN_SFT					4
+#define DL5_HALIGN_MASK					0x1
+#define DL5_HALIGN_MASK_SFT				BIT(4)
+#define DL5_HD_MODE_SFT					0
+#define DL5_HD_MODE_MASK				0x3
+#define DL5_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_DL6_CON0 */
+#define DL6_MODE_SFT					24
+#define DL6_MODE_MASK					0xf
+#define DL6_MODE_MASK_SFT				GENMASK(27, 24)
+#define DL6_MINLEN_SFT					20
+#define DL6_MINLEN_MASK					0xf
+#define DL6_MINLEN_MASK_SFT				GENMASK(23, 20)
+#define DL6_MAXLEN_SFT					16
+#define DL6_MAXLEN_MASK					0xf
+#define DL6_MAXLEN_MASK_SFT				GENMASK(19, 16)
+#define DL6_SW_CLEAR_BUF_EMPTY_SFT			15
+#define DL6_SW_CLEAR_BUF_EMPTY_MASK			0x1
+#define DL6_SW_CLEAR_BUF_EMPTY_MASK_SFT			BIT(15)
+#define DL6_PBUF_SIZE_SFT				12
+#define DL6_PBUF_SIZE_MASK				0x3
+#define DL6_PBUF_SIZE_MASK_SFT				GENMASK(13, 12)
+#define DL6_MONO_SFT					8
+#define DL6_MONO_MASK					0x1
+#define DL6_MONO_MASK_SFT				BIT(8)
+#define DL6_NORMAL_MODE_SFT				5
+#define DL6_NORMAL_MODE_MASK				0x1
+#define DL6_NORMAL_MODE_MASK_SFT			BIT(5)
+#define DL6_HALIGN_SFT					4
+#define DL6_HALIGN_MASK					0x1
+#define DL6_HALIGN_MASK_SFT				BIT(4)
+#define DL6_HD_MODE_SFT					0
+#define DL6_HD_MODE_MASK				0x3
+#define DL6_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_DL7_CON0 */
+#define DL7_MODE_SFT					24
+#define DL7_MODE_MASK					0xf
+#define DL7_MODE_MASK_SFT				GENMASK(27, 24)
+#define DL7_MINLEN_SFT					20
+#define DL7_MINLEN_MASK					0xf
+#define DL7_MINLEN_MASK_SFT				GENMASK(23, 20)
+#define DL7_MAXLEN_SFT					16
+#define DL7_MAXLEN_MASK					0xf
+#define DL7_MAXLEN_MASK_SFT				GENMASK(19, 16)
+#define DL7_SW_CLEAR_BUF_EMPTY_SFT			15
+#define DL7_SW_CLEAR_BUF_EMPTY_MASK			0x1
+#define DL7_SW_CLEAR_BUF_EMPTY_MASK_SFT			BIT(15)
+#define DL7_PBUF_SIZE_SFT				12
+#define DL7_PBUF_SIZE_MASK				0x3
+#define DL7_PBUF_SIZE_MASK_SFT				GENMASK(13, 12)
+#define DL7_MONO_SFT					8
+#define DL7_MONO_MASK					0x1
+#define DL7_MONO_MASK_SFT				BIT(8)
+#define DL7_NORMAL_MODE_SFT				5
+#define DL7_NORMAL_MODE_MASK				0x1
+#define DL7_NORMAL_MODE_MASK_SFT			BIT(5)
+#define DL7_HALIGN_SFT					4
+#define DL7_HALIGN_MASK					0x1
+#define DL7_HALIGN_MASK_SFT				BIT(4)
+#define DL7_HD_MODE_SFT					0
+#define DL7_HD_MODE_MASK				0x3
+#define DL7_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_DL8_CON0 */
+#define DL8_MODE_SFT					24
+#define DL8_MODE_MASK					0xf
+#define DL8_MODE_MASK_SFT				GENMASK(27, 24)
+#define DL8_MINLEN_SFT					20
+#define DL8_MINLEN_MASK					0xf
+#define DL8_MINLEN_MASK_SFT				GENMASK(23, 20)
+#define DL8_MAXLEN_SFT					16
+#define DL8_MAXLEN_MASK					0xf
+#define DL8_MAXLEN_MASK_SFT				GENMASK(19, 16)
+#define DL8_SW_CLEAR_BUF_EMPTY_SFT			15
+#define DL8_SW_CLEAR_BUF_EMPTY_MASK			0x1
+#define DL8_SW_CLEAR_BUF_EMPTY_MASK_SFT			BIT(15)
+#define DL8_PBUF_SIZE_SFT				12
+#define DL8_PBUF_SIZE_MASK				0x3
+#define DL8_PBUF_SIZE_MASK_SFT				GENMASK(13, 12)
+#define DL8_MONO_SFT					8
+#define DL8_MONO_MASK					0x1
+#define DL8_MONO_MASK_SFT				BIT(8)
+#define DL8_NORMAL_MODE_SFT				5
+#define DL8_NORMAL_MODE_MASK				0x1
+#define DL8_NORMAL_MODE_MASK_SFT			BIT(5)
+#define DL8_HALIGN_SFT					4
+#define DL8_HALIGN_MASK					0x1
+#define DL8_HALIGN_MASK_SFT				BIT(4)
+#define DL8_HD_MODE_SFT					0
+#define DL8_HD_MODE_MASK				0x3
+#define DL8_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_DL12_CON0 */
+#define DL12_MODE_SFT					24
+#define DL12_MODE_MASK					0xf
+#define DL12_MODE_MASK_SFT				GENMASK(27, 24)
+#define DL12_MINLEN_SFT					20
+#define DL12_MINLEN_MASK				0xf
+#define DL12_MINLEN_MASK_SFT				GENMASK(23, 20)
+#define DL12_MAXLEN_SFT					16
+#define DL12_MAXLEN_MASK				0xf
+#define DL12_MAXLEN_MASK_SFT				GENMASK(19, 16)
+#define DL12_SW_CLEAR_BUF_EMPTY_SFT			15
+#define DL12_SW_CLEAR_BUF_EMPTY_MASK			0x1
+#define DL12_SW_CLEAR_BUF_EMPTY_MASK_SFT		BIT(15)
+#define DL12_PBUF_SIZE_SFT				12
+#define DL12_PBUF_SIZE_MASK				0x3
+#define DL12_PBUF_SIZE_MASK_SFT				GENMASK(13, 12)
+#define DL12_4CH_EN_SFT					11
+#define DL12_4CH_EN_MASK				0x1
+#define DL12_4CH_EN_MASK_SFT				BIT(11)
+#define DL12_MONO_SFT					8
+#define DL12_MONO_MASK					0x1
+#define DL12_MONO_MASK_SFT				BIT(8)
+#define DL12_NORMAL_MODE_SFT				5
+#define DL12_NORMAL_MODE_MASK				0x1
+#define DL12_NORMAL_MODE_MASK_SFT			BIT(5)
+#define DL12_HALIGN_SFT					4
+#define DL12_HALIGN_MASK				0x1
+#define DL12_HALIGN_MASK_SFT				BIT(4)
+#define DL12_HD_MODE_SFT				0
+#define DL12_HD_MODE_MASK				0x3
+#define DL12_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_AWB_CON0 */
+#define AWB_MODE_SFT					24
+#define AWB_MODE_MASK					0xf
+#define AWB_MODE_MASK_SFT				GENMASK(27, 24)
+#define AWB_SW_CLEAR_BUF_FULL_SFT			15
+#define AWB_SW_CLEAR_BUF_FULL_MASK			0x1
+#define AWB_SW_CLEAR_BUF_FULL_MASK_SFT			BIT(15)
+#define AWB_R_MONO_SFT					9
+#define AWB_R_MONO_MASK					0x1
+#define AWB_R_MONO_MASK_SFT				BIT(9)
+#define AWB_MONO_SFT					8
+#define AWB_MONO_MASK					0x1
+#define AWB_MONO_MASK_SFT				BIT(8)
+#define AWB_WR_SIGN_SFT					6
+#define AWB_WR_SIGN_MASK				0x1
+#define AWB_WR_SIGN_MASK_SFT				BIT(6)
+#define AWB_NORMAL_MODE_SFT				5
+#define AWB_NORMAL_MODE_MASK				0x1
+#define AWB_NORMAL_MODE_MASK_SFT			BIT(5)
+#define AWB_HALIGN_SFT					4
+#define AWB_HALIGN_MASK					0x1
+#define AWB_HALIGN_MASK_SFT				BIT(4)
+#define AWB_HD_MODE_SFT					0
+#define AWB_HD_MODE_MASK				0x3
+#define AWB_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_AWB2_CON0 */
+#define AWB2_MODE_SFT					24
+#define AWB2_MODE_MASK					0xf
+#define AWB2_MODE_MASK_SFT				GENMASK(27, 24)
+#define AWB2_SW_CLEAR_BUF_FULL_SFT			15
+#define AWB2_SW_CLEAR_BUF_FULL_MASK			0x1
+#define AWB2_SW_CLEAR_BUF_FULL_MASK_SFT			BIT(15)
+#define AWB2_R_MONO_SFT					9
+#define AWB2_R_MONO_MASK				0x1
+#define AWB2_R_MONO_MASK_SFT				BIT(9)
+#define AWB2_MONO_SFT					8
+#define AWB2_MONO_MASK					0x1
+#define AWB2_MONO_MASK_SFT				BIT(8)
+#define AWB2_WR_SIGN_SFT				6
+#define AWB2_WR_SIGN_MASK				0x1
+#define AWB2_WR_SIGN_MASK_SFT				BIT(6)
+#define AWB2_NORMAL_MODE_SFT				5
+#define AWB2_NORMAL_MODE_MASK				0x1
+#define AWB2_NORMAL_MODE_MASK_SFT			BIT(5)
+#define AWB2_HALIGN_SFT					4
+#define AWB2_HALIGN_MASK				0x1
+#define AWB2_HALIGN_MASK_SFT				BIT(4)
+#define AWB2_HD_MODE_SFT				0
+#define AWB2_HD_MODE_MASK				0x3
+#define AWB2_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_VUL_CON0 */
+#define VUL_MODE_SFT					24
+#define VUL_MODE_MASK					0xf
+#define VUL_MODE_MASK_SFT				GENMASK(27, 24)
+#define VUL_SW_CLEAR_BUF_FULL_SFT			15
+#define VUL_SW_CLEAR_BUF_FULL_MASK			0x1
+#define VUL_SW_CLEAR_BUF_FULL_MASK_SFT			BIT(15)
+#define VUL_R_MONO_SFT					9
+#define VUL_R_MONO_MASK					0x1
+#define VUL_R_MONO_MASK_SFT				BIT(9)
+#define VUL_MONO_SFT					8
+#define VUL_MONO_MASK					0x1
+#define VUL_MONO_MASK_SFT				BIT(8)
+#define VUL_WR_SIGN_SFT					6
+#define VUL_WR_SIGN_MASK				0x1
+#define VUL_WR_SIGN_MASK_SFT				BIT(6)
+#define VUL_NORMAL_MODE_SFT				5
+#define VUL_NORMAL_MODE_MASK				0x1
+#define VUL_NORMAL_MODE_MASK_SFT			BIT(5)
+#define VUL_HALIGN_SFT					4
+#define VUL_HALIGN_MASK					0x1
+#define VUL_HALIGN_MASK_SFT				BIT(4)
+#define VUL_HD_MODE_SFT					0
+#define VUL_HD_MODE_MASK				0x3
+#define VUL_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_VUL12_CON0 */
+#define VUL12_MODE_SFT					24
+#define VUL12_MODE_MASK					0xf
+#define VUL12_MODE_MASK_SFT				GENMASK(27, 24)
+#define VUL12_SW_CLEAR_BUF_FULL_SFT			15
+#define VUL12_SW_CLEAR_BUF_FULL_MASK			0x1
+#define VUL12_SW_CLEAR_BUF_FULL_MASK_SFT		BIT(15)
+#define VUL12_4CH_EN_SFT				11
+#define VUL12_4CH_EN_MASK				0x1
+#define VUL12_4CH_EN_MASK_SFT				BIT(11)
+#define VUL12_R_MONO_SFT				9
+#define VUL12_R_MONO_MASK				0x1
+#define VUL12_R_MONO_MASK_SFT				BIT(9)
+#define VUL12_MONO_SFT					8
+#define VUL12_MONO_MASK					0x1
+#define VUL12_MONO_MASK_SFT				BIT(8)
+#define VUL12_WR_SIGN_SFT				6
+#define VUL12_WR_SIGN_MASK				0x1
+#define VUL12_WR_SIGN_MASK_SFT				BIT(6)
+#define VUL12_NORMAL_MODE_SFT				5
+#define VUL12_NORMAL_MODE_MASK				0x1
+#define VUL12_NORMAL_MODE_MASK_SFT			BIT(5)
+#define VUL12_HALIGN_SFT				4
+#define VUL12_HALIGN_MASK				0x1
+#define VUL12_HALIGN_MASK_SFT				BIT(4)
+#define VUL12_HD_MODE_SFT				0
+#define VUL12_HD_MODE_MASK				0x3
+#define VUL12_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_VUL2_CON0 */
+#define VUL2_MODE_SFT					24
+#define VUL2_MODE_MASK					0xf
+#define VUL2_MODE_MASK_SFT				GENMASK(27, 24)
+#define VUL2_SW_CLEAR_BUF_FULL_SFT			15
+#define VUL2_SW_CLEAR_BUF_FULL_MASK			0x1
+#define VUL2_SW_CLEAR_BUF_FULL_MASK_SFT			BIT(15)
+#define VUL2_R_MONO_SFT					9
+#define VUL2_R_MONO_MASK				0x1
+#define VUL2_R_MONO_MASK_SFT				BIT(9)
+#define VUL2_MONO_SFT					8
+#define VUL2_MONO_MASK					0x1
+#define VUL2_MONO_MASK_SFT				BIT(8)
+#define VUL2_WR_SIGN_SFT				6
+#define VUL2_WR_SIGN_MASK				0x1
+#define VUL2_WR_SIGN_MASK_SFT				BIT(6)
+#define VUL2_NORMAL_MODE_SFT				5
+#define VUL2_NORMAL_MODE_MASK				0x1
+#define VUL2_NORMAL_MODE_MASK_SFT			BIT(5)
+#define VUL2_HALIGN_SFT					4
+#define VUL2_HALIGN_MASK				0x1
+#define VUL2_HALIGN_MASK_SFT				BIT(4)
+#define VUL2_HD_MODE_SFT				0
+#define VUL2_HD_MODE_MASK				0x3
+#define VUL2_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_VUL3_CON0 */
+#define VUL3_MODE_SFT					24
+#define VUL3_MODE_MASK					0xf
+#define VUL3_MODE_MASK_SFT				GENMASK(27, 24)
+#define VUL3_SW_CLEAR_BUF_FULL_SFT			15
+#define VUL3_SW_CLEAR_BUF_FULL_MASK			0x1
+#define VUL3_SW_CLEAR_BUF_FULL_MASK_SFT			BIT(15)
+#define VUL3_R_MONO_SFT					9
+#define VUL3_R_MONO_MASK				0x1
+#define VUL3_R_MONO_MASK_SFT				BIT(9)
+#define VUL3_MONO_SFT					8
+#define VUL3_MONO_MASK					0x1
+#define VUL3_MONO_MASK_SFT				BIT(8)
+#define VUL3_WR_SIGN_SFT				6
+#define VUL3_WR_SIGN_MASK				0x1
+#define VUL3_WR_SIGN_MASK_SFT				BIT(6)
+#define VUL3_NORMAL_MODE_SFT				5
+#define VUL3_NORMAL_MODE_MASK				0x1
+#define VUL3_NORMAL_MODE_MASK_SFT			BIT(5)
+#define VUL3_HALIGN_SFT					4
+#define VUL3_HALIGN_MASK				0x1
+#define VUL3_HALIGN_MASK_SFT				BIT(4)
+#define VUL3_HD_MODE_SFT				0
+#define VUL3_HD_MODE_MASK				0x3
+#define VUL3_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_VUL4_CON0 */
+#define VUL4_MODE_SFT					24
+#define VUL4_MODE_MASK					0xf
+#define VUL4_MODE_MASK_SFT				GENMASK(27, 24)
+#define VUL4_SW_CLEAR_BUF_FULL_SFT			15
+#define VUL4_SW_CLEAR_BUF_FULL_MASK			0x1
+#define VUL4_SW_CLEAR_BUF_FULL_MASK_SFT			BIT(15)
+#define VUL4_R_MONO_SFT					9
+#define VUL4_R_MONO_MASK				0x1
+#define VUL4_R_MONO_MASK_SFT				BIT(9)
+#define VUL4_MONO_SFT					8
+#define VUL4_MONO_MASK					0x1
+#define VUL4_MONO_MASK_SFT				BIT(8)
+#define VUL4_WR_SIGN_SFT				6
+#define VUL4_WR_SIGN_MASK				0x1
+#define VUL4_WR_SIGN_MASK_SFT				BIT(6)
+#define VUL4_NORMAL_MODE_SFT				5
+#define VUL4_NORMAL_MODE_MASK				0x1
+#define VUL4_NORMAL_MODE_MASK_SFT			BIT(5)
+#define VUL4_HALIGN_SFT					4
+#define VUL4_HALIGN_MASK				0x1
+#define VUL4_HALIGN_MASK_SFT				BIT(4)
+#define VUL4_HD_MODE_SFT				0
+#define VUL4_HD_MODE_MASK				0x3
+#define VUL4_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_VUL5_CON0 */
+#define VUL5_MODE_SFT					24
+#define VUL5_MODE_MASK					0xf
+#define VUL5_MODE_MASK_SFT				GENMASK(27, 24)
+#define VUL5_SW_CLEAR_BUF_FULL_SFT			15
+#define VUL5_SW_CLEAR_BUF_FULL_MASK			0x1
+#define VUL5_SW_CLEAR_BUF_FULL_MASK_SFT			BIT(15)
+#define VUL5_R_MONO_SFT					9
+#define VUL5_R_MONO_MASK				0x1
+#define VUL5_R_MONO_MASK_SFT				BIT(9)
+#define VUL5_MONO_SFT					8
+#define VUL5_MONO_MASK					0x1
+#define VUL5_MONO_MASK_SFT				BIT(8)
+#define VUL5_WR_SIGN_SFT				6
+#define VUL5_WR_SIGN_MASK				0x1
+#define VUL5_WR_SIGN_MASK_SFT				BIT(6)
+#define VUL5_NORMAL_MODE_SFT				5
+#define VUL5_NORMAL_MODE_MASK				0x1
+#define VUL5_NORMAL_MODE_MASK_SFT			BIT(5)
+#define VUL5_HALIGN_SFT					4
+#define VUL5_HALIGN_MASK				0x1
+#define VUL5_HALIGN_MASK_SFT				BIT(4)
+#define VUL5_HD_MODE_SFT				0
+#define VUL5_HD_MODE_MASK				0x3
+#define VUL5_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_VUL6_CON0 */
+#define VUL6_MODE_SFT					24
+#define VUL6_MODE_MASK					0xf
+#define VUL6_MODE_MASK_SFT				GENMASK(27, 24)
+#define VUL6_SW_CLEAR_BUF_FULL_SFT			15
+#define VUL6_SW_CLEAR_BUF_FULL_MASK			0x1
+#define VUL6_SW_CLEAR_BUF_FULL_MASK_SFT			BIT(15)
+#define VUL6_R_MONO_SFT					9
+#define VUL6_R_MONO_MASK				0x1
+#define VUL6_R_MONO_MASK_SFT				BIT(9)
+#define VUL6_MONO_SFT					8
+#define VUL6_MONO_MASK					0x1
+#define VUL6_MONO_MASK_SFT				BIT(8)
+#define VUL6_WR_SIGN_SFT				6
+#define VUL6_WR_SIGN_MASK				0x1
+#define VUL6_WR_SIGN_MASK_SFT				BIT(6)
+#define VUL6_NORMAL_MODE_SFT				5
+#define VUL6_NORMAL_MODE_MASK				0x1
+#define VUL6_NORMAL_MODE_MASK_SFT			BIT(5)
+#define VUL6_HALIGN_SFT					4
+#define VUL6_HALIGN_MASK				0x1
+#define VUL6_HALIGN_MASK_SFT				BIT(4)
+#define VUL6_HD_MODE_SFT				0
+#define VUL6_HD_MODE_MASK				0x3
+#define VUL6_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_DAI_CON0 */
+#define DAI_MODE_SFT					24
+#define DAI_MODE_MASK					0x3
+#define DAI_MODE_MASK_SFT				GENMASK(25, 24)
+#define DAI_SW_CLEAR_BUF_FULL_SFT			15
+#define DAI_SW_CLEAR_BUF_FULL_MASK			0x1
+#define DAI_SW_CLEAR_BUF_FULL_MASK_SFT			BIT(15)
+#define DAI_DUPLICATE_WR_SFT				10
+#define DAI_DUPLICATE_WR_MASK				0x1
+#define DAI_DUPLICATE_WR_MASK_SFT			BIT(10)
+#define DAI_MONO_SFT					8
+#define DAI_MONO_MASK					0x1
+#define DAI_MONO_MASK_SFT				BIT(8)
+#define DAI_WR_SIGN_SFT					6
+#define DAI_WR_SIGN_MASK				0x1
+#define DAI_WR_SIGN_MASK_SFT				BIT(6)
+#define DAI_NORMAL_MODE_SFT				5
+#define DAI_NORMAL_MODE_MASK				0x1
+#define DAI_NORMAL_MODE_MASK_SFT			BIT(5)
+#define DAI_HALIGN_SFT					4
+#define DAI_HALIGN_MASK					0x1
+#define DAI_HALIGN_MASK_SFT				BIT(4)
+#define DAI_HD_MODE_SFT					0
+#define DAI_HD_MODE_MASK				0x3
+#define DAI_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_MOD_DAI_CON0 */
+#define MOD_DAI_MODE_SFT				24
+#define MOD_DAI_MODE_MASK				0x3
+#define MOD_DAI_MODE_MASK_SFT				GENMASK(25, 24)
+#define MOD_DAI_SW_CLEAR_BUF_FULL_SFT			15
+#define MOD_DAI_SW_CLEAR_BUF_FULL_MASK			0x1
+#define MOD_DAI_SW_CLEAR_BUF_FULL_MASK_SFT		BIT(15)
+#define MOD_DAI_DUPLICATE_WR_SFT			10
+#define MOD_DAI_DUPLICATE_WR_MASK			0x1
+#define MOD_DAI_DUPLICATE_WR_MASK_SFT			BIT(10)
+#define MOD_DAI_MONO_SFT				8
+#define MOD_DAI_MONO_MASK				0x1
+#define MOD_DAI_MONO_MASK_SFT				BIT(8)
+#define MOD_DAI_WR_SIGN_SFT				6
+#define MOD_DAI_WR_SIGN_MASK				0x1
+#define MOD_DAI_WR_SIGN_MASK_SFT			BIT(6)
+#define MOD_DAI_NORMAL_MODE_SFT				5
+#define MOD_DAI_NORMAL_MODE_MASK			0x1
+#define MOD_DAI_NORMAL_MODE_MASK_SFT			BIT(5)
+#define MOD_DAI_HALIGN_SFT				4
+#define MOD_DAI_HALIGN_MASK				0x1
+#define MOD_DAI_HALIGN_MASK_SFT				BIT(4)
+#define MOD_DAI_HD_MODE_SFT				0
+#define MOD_DAI_HD_MODE_MASK				0x3
+#define MOD_DAI_HD_MODE_MASK_SFT			GENMASK(1, 0)
+
+/* AFE_DAI2_CON0 */
+#define DAI2_MODE_SFT					24
+#define DAI2_MODE_MASK					0xf
+#define DAI2_MODE_MASK_SFT				GENMASK(27, 24)
+#define DAI2_SW_CLEAR_BUF_FULL_SFT			15
+#define DAI2_SW_CLEAR_BUF_FULL_MASK			0x1
+#define DAI2_SW_CLEAR_BUF_FULL_MASK_SFT			BIT(15)
+#define DAI2_DUPLICATE_WR_SFT				10
+#define DAI2_DUPLICATE_WR_MASK				0x1
+#define DAI2_DUPLICATE_WR_MASK_SFT			BIT(10)
+#define DAI2_MONO_SFT					8
+#define DAI2_MONO_MASK					0x1
+#define DAI2_MONO_MASK_SFT				BIT(8)
+#define DAI2_WR_SIGN_SFT				6
+#define DAI2_WR_SIGN_MASK				0x1
+#define DAI2_WR_SIGN_MASK_SFT				BIT(6)
+#define DAI2_NORMAL_MODE_SFT				5
+#define DAI2_NORMAL_MODE_MASK				0x1
+#define DAI2_NORMAL_MODE_MASK_SFT			BIT(5)
+#define DAI2_HALIGN_SFT					4
+#define DAI2_HALIGN_MASK				0x1
+#define DAI2_HALIGN_MASK_SFT				BIT(4)
+#define DAI2_HD_MODE_SFT				0
+#define DAI2_HD_MODE_MASK				0x3
+#define DAI2_HD_MODE_MASK_SFT				GENMASK(1, 0)
+
+/* AFE_MEMIF_CON0 */
+#define CPU_COMPACT_MODE_SFT				2
+#define CPU_COMPACT_MODE_MASK_SFT			BIT(2)
+#define CPU_HD_ALIGN_SFT				1
+#define CPU_HD_ALIGN_MASK_SFT				BIT(1)
+#define SYSRAM_SIGN_SFT					0
+#define SYSRAM_SIGN_MASK_SFT				BIT(0)
+
+/* AFE_IRQ_MCU_CON0 */
+#define IRQ31_MCU_ON_SFT				31
+#define IRQ31_MCU_ON_MASK				0x1
+#define IRQ31_MCU_ON_MASK_SFT				BIT(31)
+#define IRQ26_MCU_ON_SFT				26
+#define IRQ26_MCU_ON_MASK				0x1
+#define IRQ26_MCU_ON_MASK_SFT				BIT(26)
+#define IRQ25_MCU_ON_SFT				25
+#define IRQ25_MCU_ON_MASK				0x1
+#define IRQ25_MCU_ON_MASK_SFT				BIT(25)
+#define IRQ24_MCU_ON_SFT				24
+#define IRQ24_MCU_ON_MASK				0x1
+#define IRQ24_MCU_ON_MASK_SFT				BIT(24)
+#define IRQ23_MCU_ON_SFT				23
+#define IRQ23_MCU_ON_MASK				0x1
+#define IRQ23_MCU_ON_MASK_SFT				BIT(23)
+#define IRQ22_MCU_ON_SFT				22
+#define IRQ22_MCU_ON_MASK				0x1
+#define IRQ22_MCU_ON_MASK_SFT				BIT(22)
+#define IRQ21_MCU_ON_SFT				21
+#define IRQ21_MCU_ON_MASK				0x1
+#define IRQ21_MCU_ON_MASK_SFT				BIT(21)
+#define IRQ20_MCU_ON_SFT				20
+#define IRQ20_MCU_ON_MASK				0x1
+#define IRQ20_MCU_ON_MASK_SFT				BIT(20)
+#define IRQ19_MCU_ON_SFT				19
+#define IRQ19_MCU_ON_MASK				0x1
+#define IRQ19_MCU_ON_MASK_SFT				BIT(19)
+#define IRQ18_MCU_ON_SFT				18
+#define IRQ18_MCU_ON_MASK				0x1
+#define IRQ18_MCU_ON_MASK_SFT				BIT(18)
+#define IRQ17_MCU_ON_SFT				17
+#define IRQ17_MCU_ON_MASK				0x1
+#define IRQ17_MCU_ON_MASK_SFT				BIT(17)
+#define IRQ16_MCU_ON_SFT				16
+#define IRQ16_MCU_ON_MASK				0x1
+#define IRQ16_MCU_ON_MASK_SFT				BIT(16)
+#define IRQ15_MCU_ON_SFT				15
+#define IRQ15_MCU_ON_MASK				0x1
+#define IRQ15_MCU_ON_MASK_SFT				BIT(15)
+#define IRQ14_MCU_ON_SFT				14
+#define IRQ14_MCU_ON_MASK				0x1
+#define IRQ14_MCU_ON_MASK_SFT				BIT(14)
+#define IRQ13_MCU_ON_SFT				13
+#define IRQ13_MCU_ON_MASK				0x1
+#define IRQ13_MCU_ON_MASK_SFT				BIT(13)
+#define IRQ12_MCU_ON_SFT				12
+#define IRQ12_MCU_ON_MASK				0x1
+#define IRQ12_MCU_ON_MASK_SFT				BIT(12)
+#define IRQ11_MCU_ON_SFT				11
+#define IRQ11_MCU_ON_MASK				0x1
+#define IRQ11_MCU_ON_MASK_SFT				BIT(11)
+#define IRQ10_MCU_ON_SFT				10
+#define IRQ10_MCU_ON_MASK				0x1
+#define IRQ10_MCU_ON_MASK_SFT				BIT(10)
+#define IRQ9_MCU_ON_SFT					9
+#define IRQ9_MCU_ON_MASK				0x1
+#define IRQ9_MCU_ON_MASK_SFT				BIT(9)
+#define IRQ8_MCU_ON_SFT					8
+#define IRQ8_MCU_ON_MASK				0x1
+#define IRQ8_MCU_ON_MASK_SFT				BIT(8)
+#define IRQ7_MCU_ON_SFT					7
+#define IRQ7_MCU_ON_MASK				0x1
+#define IRQ7_MCU_ON_MASK_SFT				BIT(7)
+#define IRQ6_MCU_ON_SFT					6
+#define IRQ6_MCU_ON_MASK				0x1
+#define IRQ6_MCU_ON_MASK_SFT				BIT(6)
+#define IRQ5_MCU_ON_SFT					5
+#define IRQ5_MCU_ON_MASK				0x1
+#define IRQ5_MCU_ON_MASK_SFT				BIT(5)
+#define IRQ4_MCU_ON_SFT					4
+#define IRQ4_MCU_ON_MASK				0x1
+#define IRQ4_MCU_ON_MASK_SFT				BIT(4)
+#define IRQ3_MCU_ON_SFT					3
+#define IRQ3_MCU_ON_MASK				0x1
+#define IRQ3_MCU_ON_MASK_SFT				BIT(3)
+#define IRQ2_MCU_ON_SFT					2
+#define IRQ2_MCU_ON_MASK				0x1
+#define IRQ2_MCU_ON_MASK_SFT				BIT(2)
+#define IRQ1_MCU_ON_SFT					1
+#define IRQ1_MCU_ON_MASK				0x1
+#define IRQ1_MCU_ON_MASK_SFT				BIT(1)
+#define IRQ0_MCU_ON_SFT					0
+#define IRQ0_MCU_ON_MASK				0x1
+#define IRQ0_MCU_ON_MASK_SFT				BIT(0)
+
+/* AFE_IRQ_MCU_CON1 */
+#define IRQ7_MCU_MODE_SFT				28
+#define IRQ7_MCU_MODE_MASK				0xf
+#define IRQ7_MCU_MODE_MASK_SFT				GENMASK(31, 28)
+#define IRQ6_MCU_MODE_SFT				24
+#define IRQ6_MCU_MODE_MASK				0xf
+#define IRQ6_MCU_MODE_MASK_SFT				GENMASK(27, 24)
+#define IRQ5_MCU_MODE_SFT				20
+#define IRQ5_MCU_MODE_MASK				0xf
+#define IRQ5_MCU_MODE_MASK_SFT				GENMASK(23, 20)
+#define IRQ4_MCU_MODE_SFT				16
+#define IRQ4_MCU_MODE_MASK				0xf
+#define IRQ4_MCU_MODE_MASK_SFT				GENMASK(19, 16)
+#define IRQ3_MCU_MODE_SFT				12
+#define IRQ3_MCU_MODE_MASK				0xf
+#define IRQ3_MCU_MODE_MASK_SFT				GENMASK(15, 12)
+#define IRQ2_MCU_MODE_SFT				8
+#define IRQ2_MCU_MODE_MASK				0xf
+#define IRQ2_MCU_MODE_MASK_SFT				GENMASK(11, 8)
+#define IRQ1_MCU_MODE_SFT				4
+#define IRQ1_MCU_MODE_MASK				0xf
+#define IRQ1_MCU_MODE_MASK_SFT				GENMASK(7, 4)
+#define IRQ0_MCU_MODE_SFT				0
+#define IRQ0_MCU_MODE_MASK				0xf
+#define IRQ0_MCU_MODE_MASK_SFT				GENMASK(3, 0)
+
+/* AFE_IRQ_MCU_CON2 */
+#define IRQ15_MCU_MODE_SFT				28
+#define IRQ15_MCU_MODE_MASK				0xf
+#define IRQ15_MCU_MODE_MASK_SFT				GENMASK(31, 28)
+#define IRQ14_MCU_MODE_SFT				24
+#define IRQ14_MCU_MODE_MASK				0xf
+#define IRQ14_MCU_MODE_MASK_SFT				GENMASK(27, 24)
+#define IRQ13_MCU_MODE_SFT				20
+#define IRQ13_MCU_MODE_MASK				0xf
+#define IRQ13_MCU_MODE_MASK_SFT				GENMASK(23, 20)
+#define IRQ12_MCU_MODE_SFT				16
+#define IRQ12_MCU_MODE_MASK				0xf
+#define IRQ12_MCU_MODE_MASK_SFT				GENMASK(19, 16)
+#define IRQ11_MCU_MODE_SFT				12
+#define IRQ11_MCU_MODE_MASK				0xf
+#define IRQ11_MCU_MODE_MASK_SFT				GENMASK(15, 12)
+#define IRQ10_MCU_MODE_SFT				8
+#define IRQ10_MCU_MODE_MASK				0xf
+#define IRQ10_MCU_MODE_MASK_SFT				GENMASK(11, 8)
+#define IRQ9_MCU_MODE_SFT				4
+#define IRQ9_MCU_MODE_MASK				0xf
+#define IRQ9_MCU_MODE_MASK_SFT				GENMASK(7, 4)
+#define IRQ8_MCU_MODE_SFT				0
+#define IRQ8_MCU_MODE_MASK				0xf
+#define IRQ8_MCU_MODE_MASK_SFT				GENMASK(3, 0)
+
+/* AFE_IRQ_MCU_CON3 */
+#define IRQ23_MCU_MODE_SFT				28
+#define IRQ23_MCU_MODE_MASK				0xf
+#define IRQ23_MCU_MODE_MASK_SFT				GENMASK(31, 28)
+#define IRQ22_MCU_MODE_SFT				24
+#define IRQ22_MCU_MODE_MASK				0xf
+#define IRQ22_MCU_MODE_MASK_SFT				GENMASK(27, 24)
+#define IRQ21_MCU_MODE_SFT				20
+#define IRQ21_MCU_MODE_MASK				0xf
+#define IRQ21_MCU_MODE_MASK_SFT				GENMASK(23, 20)
+#define IRQ20_MCU_MODE_SFT				16
+#define IRQ20_MCU_MODE_MASK				0xf
+#define IRQ20_MCU_MODE_MASK_SFT				GENMASK(19, 16)
+#define IRQ19_MCU_MODE_SFT				12
+#define IRQ19_MCU_MODE_MASK				0xf
+#define IRQ19_MCU_MODE_MASK_SFT				GENMASK(15, 12)
+#define IRQ18_MCU_MODE_SFT				8
+#define IRQ18_MCU_MODE_MASK				0xf
+#define IRQ18_MCU_MODE_MASK_SFT				GENMASK(11, 8)
+#define IRQ17_MCU_MODE_SFT				4
+#define IRQ17_MCU_MODE_MASK				0xf
+#define IRQ17_MCU_MODE_MASK_SFT				GENMASK(7, 4)
+#define IRQ16_MCU_MODE_SFT				0
+#define IRQ16_MCU_MODE_MASK				0xf
+#define IRQ16_MCU_MODE_MASK_SFT				GENMASK(3, 0)
+
+/* AFE_IRQ_MCU_CON4 */
+#define IRQ26_MCU_MODE_SFT				8
+#define IRQ26_MCU_MODE_MASK				0xf
+#define IRQ26_MCU_MODE_MASK_SFT				GENMASK(11, 8)
+#define IRQ25_MCU_MODE_SFT				4
+#define IRQ25_MCU_MODE_MASK				0xf
+#define IRQ25_MCU_MODE_MASK_SFT				GENMASK(7, 4)
+#define IRQ24_MCU_MODE_SFT				0
+#define IRQ24_MCU_MODE_MASK				0xf
+#define IRQ24_MCU_MODE_MASK_SFT				GENMASK(3, 0)
+
+/* AFE_IRQ_MCU_CLR */
+#define IRQ31_MCU_CLR_SFT				31
+#define IRQ31_MCU_CLR_MASK_SFT				BIT(31)
+#define IRQ26_MCU_CLR_SFT				26
+#define IRQ26_MCU_CLR_MASK_SFT				BIT(26)
+#define IRQ25_MCU_CLR_SFT				25
+#define IRQ25_MCU_CLR_MASK_SFT				BIT(25)
+#define IRQ24_MCU_CLR_SFT				24
+#define IRQ24_MCU_CLR_MASK_SFT				BIT(24)
+#define IRQ23_MCU_CLR_SFT				23
+#define IRQ23_MCU_CLR_MASK_SFT				BIT(23)
+#define IRQ22_MCU_CLR_SFT				22
+#define IRQ22_MCU_CLR_MASK_SFT				BIT(22)
+#define IRQ21_MCU_CLR_SFT				21
+#define IRQ21_MCU_CLR_MASK_SFT				BIT(21)
+#define IRQ20_MCU_CLR_SFT				20
+#define IRQ20_MCU_CLR_MASK_SFT				BIT(20)
+#define IRQ19_MCU_CLR_SFT				19
+#define IRQ19_MCU_CLR_MASK_SFT				BIT(19)
+#define IRQ18_MCU_CLR_SFT				18
+#define IRQ18_MCU_CLR_MASK_SFT				BIT(18)
+#define IRQ17_MCU_CLR_SFT				17
+#define IRQ17_MCU_CLR_MASK_SFT				BIT(17)
+#define IRQ16_MCU_CLR_SFT				16
+#define IRQ16_MCU_CLR_MASK_SFT				BIT(16)
+#define IRQ15_MCU_CLR_SFT				15
+#define IRQ15_MCU_CLR_MASK_SFT				BIT(15)
+#define IRQ14_MCU_CLR_SFT				14
+#define IRQ14_MCU_CLR_MASK_SFT				BIT(14)
+#define IRQ13_MCU_CLR_SFT				13
+#define IRQ13_MCU_CLR_MASK_SFT				BIT(13)
+#define IRQ12_MCU_CLR_SFT				12
+#define IRQ12_MCU_CLR_MASK_SFT				BIT(12)
+#define IRQ11_MCU_CLR_SFT				11
+#define IRQ11_MCU_CLR_MASK_SFT				BIT(11)
+#define IRQ10_MCU_CLR_SFT				10
+#define IRQ10_MCU_CLR_MASK_SFT				BIT(10)
+#define IRQ9_MCU_CLR_SFT				9
+#define IRQ9_MCU_CLR_MASK_SFT				BIT(9)
+#define IRQ8_MCU_CLR_SFT				8
+#define IRQ8_MCU_CLR_MASK_SFT				BIT(8)
+#define IRQ7_MCU_CLR_SFT				7
+#define IRQ7_MCU_CLR_MASK_SFT				BIT(7)
+#define IRQ6_MCU_CLR_SFT				6
+#define IRQ6_MCU_CLR_MASK_SFT				BIT(6)
+#define IRQ5_MCU_CLR_SFT				5
+#define IRQ5_MCU_CLR_MASK_SFT				BIT(5)
+#define IRQ4_MCU_CLR_SFT				4
+#define IRQ4_MCU_CLR_MASK_SFT				BIT(4)
+#define IRQ3_MCU_CLR_SFT				3
+#define IRQ3_MCU_CLR_MASK_SFT				BIT(3)
+#define IRQ2_MCU_CLR_SFT				2
+#define IRQ2_MCU_CLR_MASK_SFT				BIT(2)
+#define IRQ1_MCU_CLR_SFT				1
+#define IRQ1_MCU_CLR_MASK_SFT				BIT(1)
+#define IRQ0_MCU_CLR_SFT				0
+#define IRQ0_MCU_CLR_MASK_SFT				BIT(0)
+
+/* AFE_IRQ_MCU_EN */
+#define IRQ31_MCU_EN_SFT				31
+#define IRQ30_MCU_EN_SFT				30
+#define IRQ29_MCU_EN_SFT				29
+#define IRQ28_MCU_EN_SFT				28
+#define IRQ27_MCU_EN_SFT				27
+#define IRQ26_MCU_EN_SFT				26
+#define IRQ25_MCU_EN_SFT				25
+#define IRQ24_MCU_EN_SFT				24
+#define IRQ23_MCU_EN_SFT				23
+#define IRQ22_MCU_EN_SFT				22
+#define IRQ21_MCU_EN_SFT				21
+#define IRQ20_MCU_EN_SFT				20
+#define IRQ19_MCU_EN_SFT				19
+#define IRQ18_MCU_EN_SFT				18
+#define IRQ17_MCU_EN_SFT				17
+#define IRQ16_MCU_EN_SFT				16
+#define IRQ15_MCU_EN_SFT				15
+#define IRQ14_MCU_EN_SFT				14
+#define IRQ13_MCU_EN_SFT				13
+#define IRQ12_MCU_EN_SFT				12
+#define IRQ11_MCU_EN_SFT				11
+#define IRQ10_MCU_EN_SFT				10
+#define IRQ9_MCU_EN_SFT					9
+#define IRQ8_MCU_EN_SFT					8
+#define IRQ7_MCU_EN_SFT					7
+#define IRQ6_MCU_EN_SFT					6
+#define IRQ5_MCU_EN_SFT					5
+#define IRQ4_MCU_EN_SFT					4
+#define IRQ3_MCU_EN_SFT					3
+#define IRQ2_MCU_EN_SFT					2
+#define IRQ1_MCU_EN_SFT					1
+#define IRQ0_MCU_EN_SFT					0
+
+/* AFE_IRQ_MCU_SCP_EN */
+#define IRQ31_MCU_SCP_EN_SFT				31
+#define IRQ30_MCU_SCP_EN_SFT				30
+#define IRQ29_MCU_SCP_EN_SFT				29
+#define IRQ28_MCU_SCP_EN_SFT				28
+#define IRQ27_MCU_SCP_EN_SFT				27
+#define IRQ26_MCU_SCP_EN_SFT				26
+#define IRQ25_MCU_SCP_EN_SFT				25
+#define IRQ24_MCU_SCP_EN_SFT				24
+#define IRQ23_MCU_SCP_EN_SFT				23
+#define IRQ22_MCU_SCP_EN_SFT				22
+#define IRQ21_MCU_SCP_EN_SFT				21
+#define IRQ20_MCU_SCP_EN_SFT				20
+#define IRQ19_MCU_SCP_EN_SFT				19
+#define IRQ18_MCU_SCP_EN_SFT				18
+#define IRQ17_MCU_SCP_EN_SFT				17
+#define IRQ16_MCU_SCP_EN_SFT				16
+#define IRQ15_MCU_SCP_EN_SFT				15
+#define IRQ14_MCU_SCP_EN_SFT				14
+#define IRQ13_MCU_SCP_EN_SFT				13
+#define IRQ12_MCU_SCP_EN_SFT				12
+#define IRQ11_MCU_SCP_EN_SFT				11
+#define IRQ10_MCU_SCP_EN_SFT				10
+#define IRQ9_MCU_SCP_EN_SFT				9
+#define IRQ8_MCU_SCP_EN_SFT				8
+#define IRQ7_MCU_SCP_EN_SFT				7
+#define IRQ6_MCU_SCP_EN_SFT				6
+#define IRQ5_MCU_SCP_EN_SFT				5
+#define IRQ4_MCU_SCP_EN_SFT				4
+#define IRQ3_MCU_SCP_EN_SFT				3
+#define IRQ2_MCU_SCP_EN_SFT				2
+#define IRQ1_MCU_SCP_EN_SFT				1
+#define IRQ0_MCU_SCP_EN_SFT				0
+
+/* AFE_IRQ_MCU_DSP_EN */
+#define IRQ31_MCU_DSP_EN_SFT				31
+#define IRQ30_MCU_DSP_EN_SFT				30
+#define IRQ29_MCU_DSP_EN_SFT				29
+#define IRQ28_MCU_DSP_EN_SFT				28
+#define IRQ27_MCU_DSP_EN_SFT				27
+#define IRQ26_MCU_DSP_EN_SFT				26
+#define IRQ25_MCU_DSP_EN_SFT				25
+#define IRQ24_MCU_DSP_EN_SFT				24
+#define IRQ23_MCU_DSP_EN_SFT				23
+#define IRQ22_MCU_DSP_EN_SFT				22
+#define IRQ21_MCU_DSP_EN_SFT				21
+#define IRQ20_MCU_DSP_EN_SFT				20
+#define IRQ19_MCU_DSP_EN_SFT				19
+#define IRQ18_MCU_DSP_EN_SFT				18
+#define IRQ17_MCU_DSP_EN_SFT				17
+#define IRQ16_MCU_DSP_EN_SFT				16
+#define IRQ15_MCU_DSP_EN_SFT				15
+#define IRQ14_MCU_DSP_EN_SFT				14
+#define IRQ13_MCU_DSP_EN_SFT				13
+#define IRQ12_MCU_DSP_EN_SFT				12
+#define IRQ11_MCU_DSP_EN_SFT				11
+#define IRQ10_MCU_DSP_EN_SFT				10
+#define IRQ9_MCU_DSP_EN_SFT				9
+#define IRQ8_MCU_DSP_EN_SFT				8
+#define IRQ7_MCU_DSP_EN_SFT				7
+#define IRQ6_MCU_DSP_EN_SFT				6
+#define IRQ5_MCU_DSP_EN_SFT				5
+#define IRQ4_MCU_DSP_EN_SFT				4
+#define IRQ3_MCU_DSP_EN_SFT				3
+#define IRQ2_MCU_DSP_EN_SFT				2
+#define IRQ1_MCU_DSP_EN_SFT				1
+#define IRQ0_MCU_DSP_EN_SFT				0
+
+/* AFE_AUD_PAD_TOP */
+#define AUD_PAD_TOP_MON_SFT				15
+#define AUD_PAD_TOP_MON_MASK_SFT			GENMASK(31, 15)
+#define AUD_PAD_TOP_FIFO_RSP_SFT			4
+#define AUD_PAD_TOP_FIFO_RSP_MASK_SFT			GENMASK(7, 4)
+#define RG_RX_PROTOCOL2_SFT				3
+#define RG_RX_PROTOCOL2_MASK_SFT			BIT(3)
+#define RESERVDED_01_SFT				1
+#define RESERVDED_01_MASK_SFT				GENMASK(2, 1)
+#define RG_RX_FIFO_ON_SFT				0
+#define RG_RX_FIFO_ON_MASK_SFT				BIT(0)
+
+/* AFE_ADDA_MTKAIF_SYNCWORD_CFG */
+#define RG_ADDA6_MTKAIF_RX_SYNC_WORD2_DISABLE_SFT	23
+#define RG_ADDA6_MTKAIF_RX_SYNC_WORD2_DISABLE_MASK_SFT	BIT(23)
+
+/* AFE_ADDA_MTKAIF_RX_CFG0 */
+#define MTKAIF_RXIF_VOICE_MODE_SFT			20
+#define MTKAIF_RXIF_VOICE_MODE_MASK_SFT			GENMASK(23, 20)
+#define MTKAIF_RXIF_DETECT_ON_SFT			16
+#define MTKAIF_RXIF_DETECT_ON_MASK_SFT			BIT(16)
+#define MTKAIF_RXIF_DATA_BIT_SFT			8
+#define MTKAIF_RXIF_DATA_BIT_MASK_SFT			GENMASK(10, 8)
+#define MTKAIF_RXIF_FIFO_RSP_SFT			4
+#define MTKAIF_RXIF_FIFO_RSP_MASK_SFT			GENMASK(6, 4)
+#define MTKAIF_RXIF_DATA_MODE_SFT			0
+#define MTKAIF_RXIF_DATA_MODE_MASK_SFT			BIT(0)
+
+/* GENERAL_ASRC_MODE */
+#define GENERAL2_ASRCOUT_MODE_SFT			12
+#define GENERAL2_ASRCOUT_MODE_MASK			0xf
+#define GENERAL2_ASRCOUT_MODE_MASK_SFT			GENMASK(15, 12)
+#define GENERAL2_ASRCIN_MODE_SFT			8
+#define GENERAL2_ASRCIN_MODE_MASK			0xf
+#define GENERAL2_ASRCIN_MODE_MASK_SFT			GENMASK(11, 8)
+#define GENERAL1_ASRCOUT_MODE_SFT			4
+#define GENERAL1_ASRCOUT_MODE_MASK			0xf
+#define GENERAL1_ASRCOUT_MODE_MASK_SFT			GENMASK(7, 4)
+#define GENERAL1_ASRCIN_MODE_SFT			0
+#define GENERAL1_ASRCIN_MODE_MASK			0xf
+#define GENERAL1_ASRCIN_MODE_MASK_SFT			GENMASK(3, 0)
+
+/* GENERAL_ASRC_EN_ON */
+#define GENERAL2_ASRC_EN_ON_SFT				1
+#define GENERAL2_ASRC_EN_ON_MASK_SFT			BIT(1)
+#define GENERAL1_ASRC_EN_ON_SFT				0
+#define GENERAL1_ASRC_EN_ON_MASK_SFT			BIT(0)
+
+/* AFE_GENERAL1_ASRC_2CH_CON0 */
+#define G_SRC_CHSET_STR_CLR_SFT				4
+#define G_SRC_CHSET_STR_CLR_MASK_SFT			BIT(4)
+#define G_SRC_CHSET_ON_SFT				2
+#define G_SRC_CHSET_ON_MASK_SFT				BIT(2)
+#define G_SRC_COEFF_SRAM_CTRL_SFT			1
+#define G_SRC_COEFF_SRAM_CTRL_MASK_SFT			BIT(1)
+#define G_SRC_ASM_ON_SFT				0
+#define G_SRC_ASM_ON_MASK_SFT				BIT(0)
+
+/* AFE_GENERAL1_ASRC_2CH_CON3 */
+#define G_SRC_ASM_FREQ_4_SFT				0
+#define G_SRC_ASM_FREQ_4_MASK_SFT			GENMASK(23, 0)
+
+/* AFE_GENERAL1_ASRC_2CH_CON4 */
+#define G_SRC_ASM_FREQ_5_SFT				0
+#define G_SRC_ASM_FREQ_5_MASK_SFT			GENMASK(23, 0)
+
+/* AFE_GENERAL1_ASRC_2CH_CON13 */
+#define G_SRC_COEFF_SRAM_ADR_SFT			0
+#define G_SRC_COEFF_SRAM_ADR_MASK_SFT			GENMASK(5, 0)
+
+/* AFE_GENERAL1_ASRC_2CH_CON2 */
+#define G_SRC_CHSET_O16BIT_SFT				19
+#define G_SRC_CHSET_O16BIT_MASK_SFT			BIT(19)
+#define G_SRC_CHSET_CLR_IIR_HISTORY_SFT			17
+#define G_SRC_CHSET_CLR_IIR_HISTORY_MASK_SFT		BIT(17)
+#define G_SRC_CHSET_IS_MONO_SFT				16
+#define G_SRC_CHSET_IS_MONO_MASK_SFT			BIT(16)
+#define G_SRC_CHSET_IIR_EN_SFT				11
+#define G_SRC_CHSET_IIR_EN_MASK_SFT			BIT(11)
+#define G_SRC_CHSET_IIR_STAGE_SFT			8
+#define G_SRC_CHSET_IIR_STAGE_MASK_SFT			GENMASK(10, 8)
+#define G_SRC_CHSET_STR_CLR_RU_SFT			5
+#define G_SRC_CHSET_STR_CLR_RU_MASK_SFT			BIT(5)
+#define G_SRC_CHSET_ON_SFT				2
+#define G_SRC_CHSET_ON_MASK_SFT				BIT(2)
+#define G_SRC_COEFF_SRAM_CTRL_SFT			1
+#define G_SRC_COEFF_SRAM_CTRL_MASK_SFT			BIT(1)
+#define G_SRC_ASM_ON_SFT				0
+#define G_SRC_ASM_ON_MASK_SFT				BIT(0)
+
+/* AFE_ADDA_DL_SDM_DITHER_CON */
+#define AFE_DL_SDM_DITHER_64TAP_EN_SFT			20
+#define AFE_DL_SDM_DITHER_64TAP_EN_MASK_SFT		BIT(20)
+#define AFE_DL_SDM_DITHER_EN_SFT			16
+#define AFE_DL_SDM_DITHER_EN_MASK_SFT			BIT(16)
+#define AFE_DL_SDM_DITHER_GAIN_SFT			0
+#define AFE_DL_SDM_DITHER_GAIN_MASK_SFT			GENMASK(7, 0)
+
+/* AFE_ADDA_DL_SDM_AUTO_RESET_CON */
+#define SDM_AUTO_RESET_TEST_ON_SFT			31
+#define SDM_AUTO_RESET_TEST_ON_MASK_SFT			BIT(31)
+#define AFE_DL_USE_NEW_2ND_SDM_SFT			28
+#define AFE_DL_USE_NEW_2ND_SDM_MASK_SFT			BIT(28)
+#define SDM_AUTO_RESET_COUNT_TH_SFT			0
+#define SDM_AUTO_RESET_COUNT_TH_MASK_SFT		GENMASK(23, 0)
+
+/* AFE_ASRC_2CH_CON0 */
+#define CON0_CHSET_STR_CLR_SFT				4
+#define CON0_CHSET_STR_CLR_MASK_SFT			BIT(4)
+#define CON0_ASM_ON_SFT					0
+#define CON0_ASM_ON_MASK_SFT				BIT(0)
+
+/* AFE_ASRC_2CH_CON5 */
+#define CALI_EN_SFT					0
+#define CALI_EN_MASK_SFT				BIT(0)
+
+/* FPGA_CFG4 */
+#define IRQ_COUNTER_SFT					3
+#define IRQ_COUNTER_MASK_SFT				GENMASK(31, 3)
+#define IRQ_CLK_COUNTER_CLEAN_SFT			2
+#define IRQ_CLK_COUNTER_CLEAN_MASK_SFT			BIT(2)
+#define IRQ_CLK_COUNTER_PAUSE_SFT			1
+#define IRQ_CLK_COUNTER_PAUSE_MASK_SFT			BIT(1)
+#define IRQ_CLK_COUNTER_ON_SFT				0
+#define IRQ_CLK_COUNTER_ON_MASK_SFT			BIT(0)
+
+/* FPGA_CFG5 */
+#define WR_MSTR_ON_SFT					16
+#define WR_MSTR_ON_MASK_SFT				GENMASK(28, 16)
+#define WR_AG_SEL_SFT					0
+#define WR_AG_SEL_MASK_SFT				GENMASK(12, 0)
+
+/* FPGA_CFG6 */
+#define WR_MSTR_REQ_REAL_SFT				16
+#define WR_MSTR_REQ_REAL_MASK_SFT			GENMASK(28, 16)
+#define WR_MSTR_REQ_IN_SFT				0
+#define WR_MSTR_REQ_IN_MASK_SFT				GENMASK(12, 0)
+
+/* FPGA_CFG7 */
+#define MEM1_WDATA_MON0_SFT				0
+#define MEM1_WDATA_MON0_MASK_SFT			GENMASK(31, 0)
+
+/* FPGA_CFG8 */
+#define MEM1_WDATA_MON1_SFT				0
+#define MEM1_WDATA_MON1_MASK_SFT			GENMASK(31, 0)
+
+/* FPGA_CFG9 */
+#define MEM_WE_SFT					31
+#define MEM_WE_MASK_SFT					BIT(31)
+#define AFE_HREADY_SFT					30
+#define AFE_HREADY_MASK_SFT				BIT(30)
+#define MEM_WR_REQ_SFT					29
+#define MEM_WR_REQ_MASK_SFT				BIT(29)
+#define WR_AG_REG_MON_SFT				16
+#define WR_AG_REG_MON_MASK_SFT				GENMASK(28, 16)
+#define HCLK_CK_SFT					15
+#define HCLK_CK_MASK_SFT				BIT(15)
+#define MEM_RD_REQ_SFT					14
+#define MEM_RD_REQ_MASK_SFT				BIT(14)
+#define RD_AG_REQ_MON_SFT				0
+#define RD_AG_REQ_MON_MASK_SFT				GENMASK(13, 0)
+
+/* FPGA_CFG10 */
+#define MEM_BYTE_0_SFT					0
+#define MEM_BYTE_0_MASK_SFT				GENMASK(31, 0)
+
+/* FPGA_CFG11 */
+#define MEM_BYTE_1_SFT					0
+#define MEM_BYTE_1_MASK_SFT				GENMASK(31, 0)
+
+/* FPGA_CFG12 */
+#define RDATA_CNT_SFT					30
+#define RDATA_CNT_MASK_SFT				GENMASK(31, 30)
+#define MS2_HREADY_SFT					29
+#define MS2_HREADY_MASK_SFT				BIT(29)
+#define MS1_HREADY_SFT					28
+#define MS1_HREADY_MASK_SFT				BIT(28)
+#define AG_SEL_SFT					0
+#define AG_SEL_MASK_SFT					GENMASK(25, 0)
+
+/* FPGA_CFG13 */
+#define AFE_ST_SFT					27
+#define AFE_ST_MASK_SFT					GENMASK(31, 27)
+#define AG_IN_SERVICE_SFT				0
+#define AG_IN_SERVICE_MASK_SFT				GENMASK(25, 0)
+
+/* ETDM_IN1_CON0 */
+#define ETDM_IN1_CON0_REG_ETDM_IN_EN_SFT			0
+#define ETDM_IN1_CON0_REG_ETDM_IN_EN_MASK_SFT			BIT(0)
+#define ETDM_IN1_CON0_REG_SYNC_MODE_SFT				1
+#define ETDM_IN1_CON0_REG_SYNC_MODE_MASK_SFT			BIT(1)
+#define ETDM_IN1_CON0_REG_LSB_FIRST_SFT				3
+#define ETDM_IN1_CON0_REG_LSB_FIRST_MASK_SFT			BIT(3)
+#define ETDM_IN1_CON0_REG_SOFT_RST_SFT				4
+#define ETDM_IN1_CON0_REG_SOFT_RST_MASK_SFT			BIT(4)
+#define ETDM_IN1_CON0_REG_SLAVE_MODE_SFT			5
+#define ETDM_IN1_CON0_REG_SLAVE_MODE_MASK_SFT			BIT(5)
+#define ETDM_IN1_CON0_REG_FMT_SFT				6
+#define ETDM_IN1_CON0_REG_FMT_MASK_SFT				GENMASK(8, 6)
+#define ETDM_IN1_CON0_REG_LRCK_EDGE_SEL_SFT			10
+#define ETDM_IN1_CON0_REG_LRCK_EDGE_SEL_MASK_SFT		BIT(10)
+#define ETDM_IN1_CON0_REG_BIT_LENGTH_SFT			11
+#define ETDM_IN1_CON0_REG_BIT_LENGTH_MASK_SFT			GENMASK(15, 11)
+#define ETDM_IN1_CON0_REG_WORD_LENGTH_SFT			16
+#define ETDM_IN1_CON0_REG_WORD_LENGTH_MASK_SFT			GENMASK(20, 16)
+#define ETDM_IN1_CON0_REG_CH_NUM_SFT				23
+#define ETDM_IN1_CON0_REG_CH_NUM_MASK_SFT			GENMASK(27, 23)
+#define ETDM_IN1_CON0_REG_RELATCH_1X_EN_SEL_DOMAIN_SFT		28
+#define ETDM_IN1_CON0_REG_RELATCH_1X_EN_SEL_DOMAIN_MASK_SFT	GENMASK(31, 28)
+#define ETDM_IN1_CON0_REG_VALID_TOGETHER_SFT			31
+#define ETDM_IN1_CON0_REG_VALID_TOGETHER_MASK_SFT		BIT(31)
+#define ETDM_IN_CON0_CTRL_MASK					0x1f9ff9e2
+
+/* ETDM_IN1_CON1 */
+#define ETDM_IN1_CON1_REG_INITIAL_COUNT_SFT			0
+#define ETDM_IN1_CON1_REG_INITIAL_COUNT_MASK_SFT		GENMASK(4, 0)
+#define ETDM_IN1_CON1_REG_INITIAL_POINT_SFT			5
+#define ETDM_IN1_CON1_REG_INITIAL_POINT_MASK_SFT		GENMASK(9, 5)
+#define ETDM_IN1_CON1_REG_LRCK_AUTO_OFF_SFT			10
+#define ETDM_IN1_CON1_REG_LRCK_AUTO_OFF_MASK_SFT		BIT(10)
+#define ETDM_IN1_CON1_REG_BCK_AUTO_OFF_SFT			11
+#define ETDM_IN1_CON1_REG_BCK_AUTO_OFF_MASK_SFT			BIT(11)
+#define ETDM_IN1_CON1_REG_INITIAL_LRCK_SFT			13
+#define ETDM_IN1_CON1_REG_INITIAL_LRCK_MASK_SFT			BIT(13)
+#define ETDM_IN1_CON1_REG_LRCK_RESET_SFT			15
+#define ETDM_IN1_CON1_REG_LRCK_RESET_MASK_SFT			BIT(15)
+#define ETDM_IN1_CON1_PINMUX_MCLK_CTRL_OE_SFT			16
+#define ETDM_IN1_CON1_PINMUX_MCLK_CTRL_OE_MASK_SFT		BIT(16)
+#define ETDM_IN1_CON1_REG_OUTPUT_CR_EN_SFT			18
+#define ETDM_IN1_CON1_REG_OUTPUT_CR_EN_MASK_SFT			BIT(18)
+#define ETDM_IN1_CON1_REG_LR_ALIGN_SFT				19
+#define ETDM_IN1_CON1_REG_LR_ALIGN_MASK_SFT			BIT(19)
+#define ETDM_IN1_CON1_REG_LRCK_WIDTH_SFT			20
+#define ETDM_IN1_CON1_REG_LRCK_WIDTH_MASK_SFT			GENMASK(29, 20)
+#define ETDM_IN1_CON1_REG_DIRECT_INPUT_MASTER_BCK_SFT		30
+#define ETDM_IN1_CON1_REG_DIRECT_INPUT_MASTER_BCK_MASK_SFT	BIT(30)
+#define ETDM_IN1_CON1_REG_LRCK_AUTO_MODE_SFT			31
+#define ETDM_IN1_CON1_REG_LRCK_AUTO_MODE_MASK_SFT		BIT(31)
+#define ETDM_IN_CON1_CTRL_MASK					0xbff10000
+
+/* ETDM_IN1_CON2 */
+#define ETDM_IN1_CON2_REG_UPDATE_POINT_SFT			0
+#define ETDM_IN1_CON2_REG_UPDATE_POINT_MASK_SFT			GENMASK(4, 0)
+#define ETDM_IN1_CON2_REG_UPDATE_GAP_SFT			5
+#define ETDM_IN1_CON2_REG_UPDATE_GAP_MASK_SFT			GENMASK(9, 5)
+#define ETDM_IN1_CON2_REG_CLOCK_SOURCE_SEL_SFT			10
+#define ETDM_IN1_CON2_REG_CLOCK_SOURCE_SEL_MASK_SFT		GENMASK(12, 10)
+#define ETDM_IN1_CON2_REG_AGENT_USE_ETDM_BCK_SFT		13
+#define ETDM_IN1_CON2_REG_AGENT_USE_ETDM_BCK_MASK_SFT		BIT(13)
+#define ETDM_IN1_CON2_REG_CK_EN_SEL_AUTO_SFT			14
+#define ETDM_IN1_CON2_REG_CK_EN_SEL_AUTO_MASK_SFT		BIT(14)
+#define ETDM_IN1_CON2_REG_MULTI_IP_ONE_DATA_CH_NUM_SFT		15
+#define ETDM_IN1_CON2_REG_MULTI_IP_ONE_DATA_CH_NUM_MASK_SFT	GENMASK(19, 15)
+#define ETDM_IN1_CON2_REG_MASK_AUTO_SFT				20
+#define ETDM_IN1_CON2_REG_MASK_AUTO_MASK_SFT			BIT(20)
+#define ETDM_IN1_CON2_REG_MASK_NUM_SFT				21
+#define ETDM_IN1_CON2_REG_MASK_NUM_MASK_SFT			GENMASK(25, 21)
+#define ETDM_IN1_CON2_REG_UPDATE_POINT_AUTO_SFT			26
+#define ETDM_IN1_CON2_REG_UPDATE_POINT_AUTO_MASK_SFT		BIT(26)
+#define ETDM_IN1_CON2_REG_SDATA_DELAY_0P5T_EN_SFT		27
+#define ETDM_IN1_CON2_REG_SDATA_DELAY_0P5T_EN_MASK_SFT		BIT(27)
+#define ETDM_IN1_CON2_REG_SDATA_DELAY_BCK_INV_SFT		28
+#define ETDM_IN1_CON2_REG_SDATA_DELAY_BCK_INV_MASK_SFT		BIT(28)
+#define ETDM_IN1_CON2_REG_LRCK_DELAY_0P5T_EN_SFT		29
+#define ETDM_IN1_CON2_REG_LRCK_DELAY_0P5T_EN_MASK_SFT		BIT(29)
+#define ETDM_IN1_CON2_REG_LRCK_DELAY_BCK_INV_SFT		30
+#define ETDM_IN1_CON2_REG_LRCK_DELAY_BCK_INV_MASK_SFT		BIT(30)
+#define ETDM_IN1_CON2_REG_MULTI_IP_MODE_SFT			31
+#define ETDM_IN1_CON2_REG_MULTI_IP_MODE_MASK_SFT		BIT(31)
+#define ETDM_IN_CON2_CTRL_MASK					0x800f8000
+#define ETDM_IN_CON2_MULTI_IP_CH(x)				(((x) - 1) << 15)
+#define ETDM_IN_CON2_MULTI_IP_2CH_MODE				BIT(31)
+
+/* ETDM_IN1_CON3 */
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_0_SFT			0
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_0_MASK_SFT		BIT(0)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_1_SFT			1
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_1_MASK_SFT		BIT(1)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_2_SFT			2
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_2_MASK_SFT		BIT(2)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_3_SFT			3
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_3_MASK_SFT		BIT(3)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_4_SFT			4
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_4_MASK_SFT		BIT(4)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_5_SFT			5
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_5_MASK_SFT		BIT(5)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_6_SFT			6
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_6_MASK_SFT		BIT(6)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_7_SFT			7
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_7_MASK_SFT		BIT(7)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_8_SFT			8
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_8_MASK_SFT		BIT(8)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_9_SFT			9
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_9_MASK_SFT		BIT(9)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_10_SFT			10
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_10_MASK_SFT		BIT(10)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_11_SFT			11
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_11_MASK_SFT		BIT(11)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_12_SFT			12
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_12_MASK_SFT		BIT(12)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_13_SFT			13
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_13_MASK_SFT		BIT(13)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_14_SFT			14
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_14_MASK_SFT		BIT(14)
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_15_SFT			15
+#define ETDM_IN1_CON3_REG_DISABLE_OUT_15_MASK_SFT		BIT(15)
+#define ETDM_IN1_CON3_REG_RJ_DATA_RIGHT_ALIGN_SFT		16
+#define ETDM_IN1_CON3_REG_RJ_DATA_RIGHT_ALIGN_MASK_SFT		BIT(16)
+#define ETDM_IN1_CON3_REG_MONITOR_SEL_SFT			17
+#define ETDM_IN1_CON3_REG_MONITOR_SEL_MASK_SFT			GENMASK(18, 17)
+#define ETDM_IN1_CON3_REG_CNT_UPPER_LIMIT_SFT			19
+#define ETDM_IN1_CON3_REG_CNT_UPPER_LIMIT_MASK_SFT		GENMASK(24, 19)
+#define ETDM_IN1_CON3_REG_COMPACT_SAMPLE_END_DIS_SFT		25
+#define ETDM_IN1_CON3_REG_COMPACT_SAMPLE_END_DIS_MASK_SFT	BIT(25)
+#define ETDM_IN1_CON3_REG_FS_TIMING_SEL_SFT			26
+#define ETDM_IN1_CON3_REG_FS_TIMING_SEL_MASK_SFT		GENMASK(30, 26)
+#define ETDM_IN1_CON3_REG_SAMPLE_END_MODE_SFT			31
+#define ETDM_IN1_CON3_REG_SAMPLE_END_MODE_MASK_SFT		BIT(31)
+#define ETDM_IN_CON3_CTRL_MASK					(0x7c000000)
+#define ETDM_IN_CON3_FS(x)					(((x) & 0x1f) << 26)
+
+/* ETDM_IN1_CON4 */
+#define ETDM_IN1_CON4_REG_DSD_MODE_SFT				0
+#define ETDM_IN1_CON4_REG_DSD_MODE_MASK_SFT			GENMASK(5, 0)
+#define ETDM_IN1_CON4_REG_DSD_REPACK_AUTO_MODE_SFT		8
+#define ETDM_IN1_CON4_REG_DSD_REPACK_AUTO_MODE_MASK_SFT		BIT(8)
+#define ETDM_IN1_CON4_REG_REPACK_WORD_LENGTH_SFT		9
+#define ETDM_IN1_CON4_REG_REPACK_WORD_LENGTH_MASK_SFT		GENMASK(10, 9)
+#define ETDM_IN1_CON4_REG_ASYNC_RESET_SFT			11
+#define ETDM_IN1_CON4_REG_ASYNC_RESET_MASK_SFT			BIT(11)
+#define ETDM_IN1_CON4_REG_DSD_CHNUM_SFT				12
+#define ETDM_IN1_CON4_REG_DSD_CHNUM_MASK_SFT			GENMASK(15, 12)
+#define ETDM_IN1_CON4_REG_SLAVE_BCK_INV_SFT			16
+#define ETDM_IN1_CON4_REG_SLAVE_BCK_INV_MASK_SFT		BIT(16)
+#define ETDM_IN1_CON4_REG_SLAVE_LRCK_INV_SFT			17
+#define ETDM_IN1_CON4_REG_SLAVE_LRCK_INV_MASK_SFT		BIT(17)
+#define ETDM_IN1_CON4_REG_MASTER_BCK_INV_SFT			18
+#define ETDM_IN1_CON4_REG_MASTER_BCK_INV_MASK_SFT		BIT(18)
+#define ETDM_IN1_CON4_REG_MASTER_LRCK_INV_SFT			19
+#define ETDM_IN1_CON4_REG_MASTER_LRCK_INV_MASK_SFT		BIT(19)
+#define ETDM_IN1_CON4_REG_RELATCH_1X_EN_SEL_SFT			20
+#define ETDM_IN1_CON4_REG_RELATCH_1X_EN_SEL_MASK_SFT		GENMASK(24, 20)
+#define ETDM_IN1_CON4_REG_SAMPLE_END_POINT_SFT			25
+#define ETDM_IN1_CON4_REG_SAMPLE_END_POINT_MASK_SFT		GENMASK(29, 25)
+#define ETDM_IN1_CON4_REG_WAIT_LAST_SAMPLE_SFT			30
+#define ETDM_IN1_CON4_REG_WAIT_LAST_SAMPLE_MASK_SFT		BIT(30)
+#define ETDM_IN1_CON4_REG_MASTER_BCK_FORCE_ON_SFT		31
+#define ETDM_IN1_CON4_REG_MASTER_BCK_FORCE_ON_MASK_SFT		BIT(31)
+#define ETDM_IN_CON4_CTRL_MASK					0x1ff0000
+#define ETDM_IN_CON4_FS(x)					(((x) & 0x1f) << 20)
+#define ETDM_IN_CON4_CON0_MASTER_LRCK_INV			BIT(19)
+#define ETDM_IN_CON4_CON0_MASTER_BCK_INV			BIT(18)
+#define ETDM_IN_CON4_CON0_SLAVE_LRCK_INV			BIT(17)
+#define ETDM_IN_CON4_CON0_SLAVE_BCK_INV				BIT(16)
+
+/* ETDM_IN1_CON5 */
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_0_SFT			0
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_0_MASK_SFT		BIT(0)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_1_SFT			1
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_1_MASK_SFT		BIT(1)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_2_SFT			2
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_2_MASK_SFT		BIT(2)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_3_SFT			3
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_3_MASK_SFT		BIT(3)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_4_SFT			4
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_4_MASK_SFT		BIT(4)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_5_SFT			5
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_5_MASK_SFT		BIT(5)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_6_SFT			6
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_6_MASK_SFT		BIT(6)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_7_SFT			7
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_7_MASK_SFT		BIT(7)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_8_SFT			8
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_8_MASK_SFT		BIT(8)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_9_SFT			9
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_9_MASK_SFT		BIT(9)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_10_SFT			10
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_10_MASK_SFT		BIT(10)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_11_SFT			11
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_11_MASK_SFT		BIT(11)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_12_SFT			12
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_12_MASK_SFT		BIT(12)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_13_SFT			13
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_13_MASK_SFT		BIT(13)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_14_SFT			14
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_14_MASK_SFT		BIT(14)
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_15_SFT			15
+#define ETDM_IN1_CON5_REG_ODD_FLAG_EN_15_MASK_SFT		BIT(15)
+#define ETDM_IN1_CON5_REG_LR_SWAP_0_SFT				16
+#define ETDM_IN1_CON5_REG_LR_SWAP_0_MASK_SFT			BIT(16)
+#define ETDM_IN1_CON5_REG_LR_SWAP_1_SFT				17
+#define ETDM_IN1_CON5_REG_LR_SWAP_1_MASK_SFT			BIT(17)
+#define ETDM_IN1_CON5_REG_LR_SWAP_2_SFT				18
+#define ETDM_IN1_CON5_REG_LR_SWAP_2_MASK_SFT			BIT(18)
+#define ETDM_IN1_CON5_REG_LR_SWAP_3_SFT				19
+#define ETDM_IN1_CON5_REG_LR_SWAP_3_MASK_SFT			BIT(19)
+#define ETDM_IN1_CON5_REG_LR_SWAP_4_SFT				20
+#define ETDM_IN1_CON5_REG_LR_SWAP_4_MASK_SFT			BIT(20)
+#define ETDM_IN1_CON5_REG_LR_SWAP_5_SFT				21
+#define ETDM_IN1_CON5_REG_LR_SWAP_5_MASK_SFT			BIT(21)
+#define ETDM_IN1_CON5_REG_LR_SWAP_6_SFT				22
+#define ETDM_IN1_CON5_REG_LR_SWAP_6_MASK_SFT			BIT(22)
+#define ETDM_IN1_CON5_REG_LR_SWAP_7_SFT				23
+#define ETDM_IN1_CON5_REG_LR_SWAP_7_MASK_SFT			BIT(23)
+#define ETDM_IN1_CON5_REG_LR_SWAP_8_SFT				24
+#define ETDM_IN1_CON5_REG_LR_SWAP_8_MASK_SFT			BIT(24)
+#define ETDM_IN1_CON5_REG_LR_SWAP_9_SFT				25
+#define ETDM_IN1_CON5_REG_LR_SWAP_9_MASK_SFT			BIT(25)
+#define ETDM_IN1_CON5_REG_LR_SWAP_10_SFT			26
+#define ETDM_IN1_CON5_REG_LR_SWAP_10_MASK_SFT			BIT(26)
+#define ETDM_IN1_CON5_REG_LR_SWAP_11_SFT			27
+#define ETDM_IN1_CON5_REG_LR_SWAP_11_MASK_SFT			BIT(27)
+#define ETDM_IN1_CON5_REG_LR_SWAP_12_SFT			28
+#define ETDM_IN1_CON5_REG_LR_SWAP_12_MASK_SFT			BIT(28)
+#define ETDM_IN1_CON5_REG_LR_SWAP_13_SFT			29
+#define ETDM_IN1_CON5_REG_LR_SWAP_13_MASK_SFT			BIT(29)
+#define ETDM_IN1_CON5_REG_LR_SWAP_14_SFT			30
+#define ETDM_IN1_CON5_REG_LR_SWAP_14_MASK_SFT			BIT(30)
+#define ETDM_IN1_CON5_REG_LR_SWAP_15_SFT			31
+#define ETDM_IN1_CON5_REG_LR_SWAP_15_MASK_SFT			BIT(31)
+
+/* ETDM_IN1_CON6 */
+#define ETDM_IN1_CON6_LCH_DATA_REG_SFT				0
+#define ETDM_IN1_CON6_LCH_DATA_REG_MASK_SFT			GENMASK(31, 0)
+
+/* ETDM_IN1_CON7 */
+#define ETDM_IN1_CON7_RCH_DATA_REG_SFT				0
+#define ETDM_IN1_CON7_RCH_DATA_REG_MASK_SFT			GENMASK(31, 0)
+
+/* ETDM_IN1_CON8 */
+#define ETDM_IN1_CON8_REG_AFIFO_THRESHOLD_SFT			29
+#define ETDM_IN1_CON8_REG_AFIFO_THRESHOLD_MASK_SFT		GENMASK(30, 29)
+#define ETDM_IN1_CON8_REG_CK_EN_SEL_MANUAL_SFT			16
+#define ETDM_IN1_CON8_REG_CK_EN_SEL_MANUAL_MASK_SFT		GENMASK(25, 16)
+#define ETDM_IN1_CON8_REG_AFIFO_SW_RESET_SFT			15
+#define ETDM_IN1_CON8_REG_AFIFO_SW_RESET_MASK_SFT		BIT(15)
+#define ETDM_IN1_CON8_REG_AFIFO_RESET_SEL_SFT			14
+#define ETDM_IN1_CON8_REG_AFIFO_RESET_SEL_MASK_SFT		BIT(14)
+#define ETDM_IN1_CON8_REG_AFIFO_AUTO_RESET_DIS_SFT		9
+#define ETDM_IN1_CON8_REG_AFIFO_AUTO_RESET_DIS_MASK_SFT		BIT(9)
+#define ETDM_IN1_CON8_REG_ETDM_USE_AFIFO_SFT			8
+#define ETDM_IN1_CON8_REG_ETDM_USE_AFIFO_MASK_SFT		BIT(8)
+#define ETDM_IN1_CON8_REG_AFIFO_CLOCK_DOMAIN_SEL_SFT		5
+#define ETDM_IN1_CON8_REG_AFIFO_CLOCK_DOMAIN_SEL_MASK_SFT	GENMASK(7, 5)
+#define ETDM_IN1_CON8_REG_AFIFO_MODE_SFT			0
+#define ETDM_IN1_CON8_REG_AFIFO_MODE_MASK_SFT			GENMASK(4, 0)
+#define ETDM_IN_CON8_FS(x)					(((x) & 0x1f) << 0)
+#define ETDM_IN_CON8_CTRL_MASK					0x13f
+
+#define AUDIO_TOP_CON0					0x0000
+#define AUDIO_TOP_CON1					0x0004
+#define AUDIO_TOP_CON2					0x0008
+#define AUDIO_TOP_CON3					0x000c
+#define AFE_DAC_CON0					0x0010
+#define AFE_I2S_CON					0x0018
+#define AFE_CONN0					0x0020
+#define AFE_CONN1					0x0024
+#define AFE_CONN2					0x0028
+#define AFE_CONN3					0x002c
+#define AFE_CONN4					0x0030
+#define AFE_I2S_CON1					0x0034
+#define AFE_I2S_CON2					0x0038
+#define AFE_I2S_CON3					0x0040
+#define AFE_CONN5					0x0044
+#define AFE_CONN_24BIT					0x0048
+#define AFE_DL1_CON0					0x004c
+#define AFE_DL1_BASE_MSB				0x0050
+#define AFE_DL1_BASE					0x0054
+#define AFE_DL1_CUR_MSB					0x0058
+#define AFE_DL1_CUR					0x005c
+#define AFE_DL1_END_MSB					0x0060
+#define AFE_DL1_END					0x0064
+#define AFE_DL2_CON0					0x0068
+#define AFE_DL2_BASE_MSB				0x006c
+#define AFE_DL2_BASE					0x0070
+#define AFE_DL2_CUR_MSB					0x0074
+#define AFE_DL2_CUR					0x0078
+#define AFE_DL2_END_MSB					0x007c
+#define AFE_DL2_END					0x0080
+#define AFE_DL3_CON0					0x0084
+#define AFE_DL3_BASE_MSB				0x0088
+#define AFE_DL3_BASE					0x008c
+#define AFE_DL3_CUR_MSB					0x0090
+#define AFE_DL3_CUR					0x0094
+#define AFE_DL3_END_MSB					0x0098
+#define AFE_DL3_END					0x009c
+#define AFE_CONN6					0x00bc
+#define AFE_DL4_CON0					0x00cc
+#define AFE_DL4_BASE_MSB				0x00d0
+#define AFE_DL4_BASE					0x00d4
+#define AFE_DL4_CUR_MSB					0x00d8
+#define AFE_DL4_CUR					0x00dc
+#define AFE_DL4_END_MSB					0x00e0
+#define AFE_DL4_END					0x00e4
+#define AFE_DL12_CON0					0x00e8
+#define AFE_DL12_BASE_MSB				0x00ec
+#define AFE_DL12_BASE					0x00f0
+#define AFE_DL12_CUR_MSB				0x00f4
+#define AFE_DL12_CUR					0x00f8
+#define AFE_DL12_END_MSB				0x00fc
+#define AFE_DL12_END					0x0100
+#define AFE_ADDA_DL_SRC2_CON0				0x0108
+#define AFE_ADDA_DL_SRC2_CON1				0x010c
+#define AFE_ADDA_UL_SRC_CON0				0x0114
+#define AFE_ADDA_UL_SRC_CON1				0x0118
+#define AFE_ADDA_TOP_CON0				0x0120
+#define AFE_ADDA_UL_DL_CON0				0x0124
+#define AFE_ADDA_SRC_DEBUG				0x012c
+#define AFE_ADDA_SRC_DEBUG_MON0				0x0130
+#define AFE_ADDA_SRC_DEBUG_MON1				0x0134
+#define AFE_ADDA_UL_SRC_MON0				0x0148
+#define AFE_ADDA_UL_SRC_MON1				0x014c
+#define AFE_SECURE_CON0					0x0150
+#define AFE_SRAM_BOUND					0x0154
+#define AFE_SECURE_CON1					0x0158
+#define AFE_SECURE_CONN0				0x015c
+#define AFE_VUL_CON0					0x0170
+#define AFE_VUL_BASE_MSB				0x0174
+#define AFE_VUL_BASE					0x0178
+#define AFE_VUL_CUR_MSB					0x017c
+#define AFE_VUL_CUR					0x0180
+#define AFE_VUL_END_MSB					0x0184
+#define AFE_VUL_END					0x0188
+#define AFE_SIDETONE_DEBUG				0x01d0
+#define AFE_SIDETONE_MON				0x01d4
+#define AFE_SINEGEN_CON2				0x01dc
+#define AFE_SIDETONE_CON0				0x01e0
+#define AFE_SIDETONE_COEFF				0x01e4
+#define AFE_SIDETONE_CON1				0x01e8
+#define AFE_SIDETONE_GAIN				0x01ec
+#define AFE_SINEGEN_CON0				0x01f0
+#define AFE_TOP_CON0					0x0200
+#define AFE_VUL2_CON0					0x020c
+#define AFE_VUL2_BASE_MSB				0x0210
+#define AFE_VUL2_BASE					0x0214
+#define AFE_VUL2_CUR_MSB				0x0218
+#define AFE_VUL2_CUR					0x021c
+#define AFE_VUL2_END_MSB				0x0220
+#define AFE_VUL2_END					0x0224
+#define AFE_VUL3_CON0					0x0228
+#define AFE_VUL3_BASE_MSB				0x022c
+#define AFE_VUL3_BASE					0x0230
+#define AFE_VUL3_CUR_MSB				0x0234
+#define AFE_VUL3_CUR					0x0238
+#define AFE_VUL3_END_MSB				0x023c
+#define AFE_VUL3_END					0x0240
+#define AFE_BUSY					0x0244
+#define AFE_BUS_CFG					0x0250
+#define AFE_ADDA_PREDIS_CON0				0x0260
+#define AFE_ADDA_PREDIS_CON1				0x0264
+#define AFE_I2S_MON					0x027c
+#define AFE_ADDA_IIR_COEF_02_01				0x0290
+#define AFE_ADDA_IIR_COEF_04_03				0x0294
+#define AFE_ADDA_IIR_COEF_06_05				0x0298
+#define AFE_ADDA_IIR_COEF_08_07				0x029c
+#define AFE_ADDA_IIR_COEF_10_09				0x02a0
+#define AFE_IRQ_MCU_CON1				0x02e4
+#define AFE_IRQ_MCU_CON2				0x02e8
+#define AFE_DAC_MON					0x02ec
+#define AFE_IRQ_MCU_CON3				0x02f0
+#define AFE_IRQ_MCU_CON4				0x02f4
+#define AFE_IRQ_MCU_CNT0				0x0300
+#define AFE_IRQ_MCU_CNT6				0x0304
+#define AFE_IRQ_MCU_CNT8				0x0308
+#define AFE_IRQ_MCU_DSP2_EN				0x030c
+#define AFE_IRQ0_MCU_CNT_MON				0x0310
+#define AFE_IRQ6_MCU_CNT_MON				0x0314
+#define AFE_VUL4_CON0					0x0358
+#define AFE_VUL4_BASE_MSB				0x035c
+#define AFE_VUL4_BASE					0x0360
+#define AFE_VUL4_CUR_MSB				0x0364
+#define AFE_VUL4_CUR					0x0368
+#define AFE_VUL4_END_MSB				0x036c
+#define AFE_VUL4_END					0x0370
+#define AFE_VUL12_CON0					0x0374
+#define AFE_VUL12_BASE_MSB				0x0378
+#define AFE_VUL12_BASE					0x037c
+#define AFE_VUL12_CUR_MSB				0x0380
+#define AFE_VUL12_CUR					0x0384
+#define AFE_VUL12_END_MSB				0x0388
+#define AFE_VUL12_END					0x038c
+#define AFE_IRQ3_MCU_CNT_MON				0x0398
+#define AFE_IRQ4_MCU_CNT_MON				0x039c
+#define AFE_IRQ_MCU_CON0				0x03a0
+#define AFE_IRQ_MCU_STATUS				0x03a4
+#define AFE_IRQ_MCU_CLR					0x03a8
+#define AFE_IRQ_MCU_CNT1				0x03ac
+#define AFE_IRQ_MCU_CNT2				0x03b0
+#define AFE_IRQ_MCU_EN					0x03b4
+#define AFE_IRQ_MCU_MON2				0x03b8
+#define AFE_IRQ_MCU_CNT5				0x03bc
+#define AFE_IRQ1_MCU_CNT_MON				0x03c0
+#define AFE_IRQ2_MCU_CNT_MON				0x03c4
+#define AFE_IRQ5_MCU_CNT_MON				0x03cc
+#define AFE_IRQ_MCU_DSP_EN				0x03d0
+#define AFE_IRQ_MCU_SCP_EN				0x03d4
+#define AFE_IRQ_MCU_CNT7				0x03dc
+#define AFE_IRQ7_MCU_CNT_MON				0x03e0
+#define AFE_IRQ_MCU_CNT3				0x03e4
+#define AFE_IRQ_MCU_CNT4				0x03e8
+#define AFE_IRQ_MCU_CNT11				0x03ec
+#define AFE_APLL1_TUNER_CFG				0x03f0
+#define AFE_APLL2_TUNER_CFG				0x03f4
+#define AFE_IRQ_MCU_MISS_CLR				0x03f8
+#define AFE_CONN33					0x0408
+#define AFE_IRQ_MCU_CNT12				0x040c
+#define AFE_GAIN1_CON0					0x0410
+#define AFE_GAIN1_CON1					0x0414
+#define AFE_GAIN1_CON2					0x0418
+#define AFE_GAIN1_CON3					0x041c
+#define AFE_CONN7					0x0420
+#define AFE_GAIN1_CUR					0x0424
+#define AFE_GAIN2_CON0					0x0428
+#define AFE_GAIN2_CON1					0x042c
+#define AFE_GAIN2_CON2					0x0430
+#define AFE_GAIN2_CON3					0x0434
+#define AFE_CONN8					0x0438
+#define AFE_GAIN2_CUR					0x043c
+#define AFE_CONN9					0x0440
+#define AFE_CONN10					0x0444
+#define AFE_CONN11					0x0448
+#define AFE_CONN12					0x044c
+#define AFE_CONN13					0x0450
+#define AFE_CONN14					0x0454
+#define AFE_CONN15					0x0458
+#define AFE_CONN16					0x045c
+#define AFE_CONN17					0x0460
+#define AFE_CONN18					0x0464
+#define AFE_CONN19					0x0468
+#define AFE_CONN20					0x046c
+#define AFE_CONN21					0x0470
+#define AFE_CONN22					0x0474
+#define AFE_CONN23					0x0478
+#define AFE_CONN24					0x047c
+#define AFE_CONN_RS					0x0494
+#define AFE_CONN_DI					0x0498
+#define AFE_CONN25					0x04b0
+#define AFE_CONN26					0x04b4
+#define AFE_CONN27					0x04b8
+#define AFE_CONN28					0x04bc
+#define AFE_CONN29					0x04c0
+#define AFE_CONN30					0x04c4
+#define AFE_CONN31					0x04c8
+#define AFE_CONN32					0x04cc
+#define AFE_SRAM_DELSEL_CON1				0x04f4
+#define AFE_CONN56					0x0500
+#define AFE_CONN57					0x0504
+#define AFE_CONN58					0x0508
+#define AFE_CONN59					0x050c
+#define AFE_CONN56_1					0x0510
+#define AFE_CONN57_1					0x0514
+#define AFE_CONN58_1					0x0518
+#define AFE_CONN59_1					0x051c
+#define PCM_INTF_CON1					0x0530
+#define PCM_INTF_CON2					0x0538
+#define PCM2_INTF_CON					0x053c
+#define AFE_CM1_CON					0x0550
+#define AFE_CONN34					0x0580
+#define FPGA_CFG0					0x05b0
+#define FPGA_CFG1					0x05b4
+#define FPGA_CFG2					0x05c0
+#define FPGA_CFG3					0x05c4
+#define AUDIO_TOP_DBG_CON				0x05c8
+#define AUDIO_TOP_DBG_MON0				0x05cc
+#define AUDIO_TOP_DBG_MON1				0x05d0
+#define AFE_IRQ8_MCU_CNT_MON				0x05e4
+#define AFE_IRQ11_MCU_CNT_MON				0x05e8
+#define AFE_IRQ12_MCU_CNT_MON				0x05ec
+#define AFE_IRQ_MCU_CNT9				0x0600
+#define AFE_IRQ_MCU_CNT10				0x0604
+#define AFE_IRQ_MCU_CNT13				0x0608
+#define AFE_IRQ_MCU_CNT14				0x060c
+#define AFE_IRQ_MCU_CNT15				0x0610
+#define AFE_IRQ_MCU_CNT16				0x0614
+#define AFE_IRQ_MCU_CNT17				0x0618
+#define AFE_IRQ_MCU_CNT18				0x061c
+#define AFE_IRQ_MCU_CNT19				0x0620
+#define AFE_IRQ_MCU_CNT20				0x0624
+#define AFE_IRQ_MCU_CNT21				0x0628
+#define AFE_IRQ_MCU_CNT22				0x062c
+#define AFE_IRQ_MCU_CNT23				0x0630
+#define AFE_IRQ_MCU_CNT24				0x0634
+#define AFE_IRQ_MCU_CNT25				0x0638
+#define AFE_IRQ_MCU_CNT26				0x063c
+#define AFE_IRQ9_MCU_CNT_MON				0x0660
+#define AFE_IRQ10_MCU_CNT_MON				0x0664
+#define AFE_IRQ13_MCU_CNT_MON				0x0668
+#define AFE_IRQ14_MCU_CNT_MON				0x066c
+#define AFE_IRQ15_MCU_CNT_MON				0x0670
+#define AFE_IRQ16_MCU_CNT_MON				0x0674
+#define AFE_IRQ17_MCU_CNT_MON				0x0678
+#define AFE_IRQ18_MCU_CNT_MON				0x067c
+#define AFE_IRQ19_MCU_CNT_MON				0x0680
+#define AFE_IRQ20_MCU_CNT_MON				0x0684
+#define AFE_IRQ21_MCU_CNT_MON				0x0688
+#define AFE_IRQ22_MCU_CNT_MON				0x068c
+#define AFE_IRQ23_MCU_CNT_MON				0x0690
+#define AFE_IRQ24_MCU_CNT_MON				0x0694
+#define AFE_IRQ25_MCU_CNT_MON				0x0698
+#define AFE_IRQ26_MCU_CNT_MON				0x069c
+#define AFE_IRQ31_MCU_CNT_MON				0x06a0
+#define AFE_GENERAL_REG0				0x0800
+#define AFE_GENERAL_REG1				0x0804
+#define AFE_GENERAL_REG2				0x0808
+#define AFE_GENERAL_REG3				0x080c
+#define AFE_GENERAL_REG4				0x0810
+#define AFE_GENERAL_REG5				0x0814
+#define AFE_GENERAL_REG6				0x0818
+#define AFE_GENERAL_REG7				0x081c
+#define AFE_GENERAL_REG8				0x0820
+#define AFE_GENERAL_REG9				0x0824
+#define AFE_GENERAL_REG10				0x0828
+#define AFE_GENERAL_REG11				0x082c
+#define AFE_GENERAL_REG12				0x0830
+#define AFE_GENERAL_REG13				0x0834
+#define AFE_GENERAL_REG14				0x0838
+#define AFE_GENERAL_REG15				0x083c
+#define AFE_CBIP_CFG0					0x0840
+#define AFE_CBIP_MON0					0x0844
+#define AFE_CBIP_SLV_MUX_MON0				0x0848
+#define AFE_CBIP_SLV_DECODER_MON0			0x084c
+#define AFE_ADDA6_MTKAIF_MON0				0x0854
+#define AFE_ADDA6_MTKAIF_MON1				0x0858
+#define AFE_AWB_CON0					0x085c
+#define AFE_AWB_BASE_MSB				0x0860
+#define AFE_AWB_BASE					0x0864
+#define AFE_AWB_CUR_MSB					0x0868
+#define AFE_AWB_CUR					0x086c
+#define AFE_AWB_END_MSB					0x0870
+#define AFE_AWB_END					0x0874
+#define AFE_AWB2_CON0					0x0878
+#define AFE_AWB2_BASE_MSB				0x087c
+#define AFE_AWB2_BASE					0x0880
+#define AFE_AWB2_CUR_MSB				0x0884
+#define AFE_AWB2_CUR					0x0888
+#define AFE_AWB2_END_MSB				0x088c
+#define AFE_AWB2_END					0x0890
+#define AFE_DAI_CON0					0x0894
+#define AFE_DAI_BASE_MSB				0x0898
+#define AFE_DAI_BASE					0x089c
+#define AFE_DAI_CUR_MSB					0x08a0
+#define AFE_DAI_CUR					0x08a4
+#define AFE_DAI_END_MSB					0x08a8
+#define AFE_DAI_END					0x08ac
+#define AFE_DAI2_CON0					0x08b0
+#define AFE_DAI2_BASE_MSB				0x08b4
+#define AFE_DAI2_BASE					0x08b8
+#define AFE_DAI2_CUR_MSB				0x08bc
+#define AFE_DAI2_CUR					0x08c0
+#define AFE_DAI2_END_MSB				0x08c4
+#define AFE_DAI2_END					0x08c8
+#define AFE_MEMIF_CON0					0x08cc
+#define AFE_CONN0_1					0x0900
+#define AFE_CONN1_1					0x0904
+#define AFE_CONN2_1					0x0908
+#define AFE_CONN3_1					0x090c
+#define AFE_CONN4_1					0x0910
+#define AFE_CONN5_1					0x0914
+#define AFE_CONN6_1					0x0918
+#define AFE_CONN7_1					0x091c
+#define AFE_CONN8_1					0x0920
+#define AFE_CONN9_1					0x0924
+#define AFE_CONN10_1					0x0928
+#define AFE_CONN11_1					0x092c
+#define AFE_CONN12_1					0x0930
+#define AFE_CONN13_1					0x0934
+#define AFE_CONN14_1					0x0938
+#define AFE_CONN15_1					0x093c
+#define AFE_CONN16_1					0x0940
+#define AFE_CONN17_1					0x0944
+#define AFE_CONN18_1					0x0948
+#define AFE_CONN19_1					0x094c
+#define AFE_CONN20_1					0x0950
+#define AFE_CONN21_1					0x0954
+#define AFE_CONN22_1					0x0958
+#define AFE_CONN23_1					0x095c
+#define AFE_CONN24_1					0x0960
+#define AFE_CONN25_1					0x0964
+#define AFE_CONN26_1					0x0968
+#define AFE_CONN27_1					0x096c
+#define AFE_CONN28_1					0x0970
+#define AFE_CONN29_1					0x0974
+#define AFE_CONN30_1					0x0978
+#define AFE_CONN31_1					0x097c
+#define AFE_CONN32_1					0x0980
+#define AFE_CONN33_1					0x0984
+#define AFE_CONN34_1					0x0988
+#define AFE_CONN_RS_1					0x098c
+#define AFE_CONN_DI_1					0x0990
+#define AFE_CONN_24BIT_1				0x0994
+#define AFE_CONN_REG					0x0998
+#define AFE_CONN35					0x09a0
+#define AFE_CONN36					0x09a4
+#define AFE_CONN37					0x09a8
+#define AFE_CONN38					0x09ac
+#define AFE_CONN35_1					0x09b0
+#define AFE_CONN36_1					0x09b4
+#define AFE_CONN37_1					0x09b8
+#define AFE_CONN38_1					0x09bc
+#define AFE_CONN39					0x09c0
+#define AFE_CONN40					0x09c4
+#define AFE_CONN41					0x09c8
+#define AFE_CONN42					0x09cc
+#define AFE_CONN39_1					0x09e0
+#define AFE_CONN40_1					0x09e4
+#define AFE_CONN41_1					0x09e8
+#define AFE_CONN42_1					0x09ec
+#define AFE_I2S_CON4					0x09f8
+#define AFE_CONN60					0x0a64
+#define AFE_CONN61					0x0a68
+#define AFE_CONN62					0x0a6c
+#define AFE_CONN63					0x0a70
+#define AFE_CONN64					0x0a74
+#define AFE_CONN65					0x0a78
+#define AFE_CONN66					0x0a7c
+#define AFE_ADDA6_TOP_CON0				0x0a80
+#define AFE_ADDA6_UL_SRC_CON0				0x0a84
+#define AFE_ADDA6_UL_SRC_CON1				0x0a88
+#define AFE_ADDA6_SRC_DEBUG				0x0a8c
+#define AFE_ADDA6_SRC_DEBUG_MON0			0x0a90
+#define AFE_ADDA6_ULCF_CFG_02_01			0x0aa0
+#define AFE_ADDA6_ULCF_CFG_04_03			0x0aa4
+#define AFE_ADDA6_ULCF_CFG_06_05			0x0aa8
+#define AFE_ADDA6_ULCF_CFG_08_07			0x0aac
+#define AFE_ADDA6_ULCF_CFG_10_09			0x0ab0
+#define AFE_ADDA6_ULCF_CFG_12_11			0x0ab4
+#define AFE_ADDA6_ULCF_CFG_14_13			0x0ab8
+#define AFE_ADDA6_ULCF_CFG_16_15			0x0abc
+#define AFE_ADDA6_ULCF_CFG_18_17			0x0ac0
+#define AFE_ADDA6_ULCF_CFG_20_19			0x0ac4
+#define AFE_ADDA6_ULCF_CFG_22_21			0x0ac8
+#define AFE_ADDA6_ULCF_CFG_24_23			0x0acc
+#define AFE_ADDA6_ULCF_CFG_26_25			0x0ad0
+#define AFE_ADDA6_ULCF_CFG_28_27			0x0ad4
+#define AFE_ADDA6_ULCF_CFG_30_29			0x0ad8
+#define AFE_ADD6A_UL_SRC_MON0				0x0ae4
+#define AFE_ADDA6_UL_SRC_MON1				0x0ae8
+#define AFE_CONN43					0x0af8
+#define AFE_CONN43_1					0x0afc
+#define AFE_MOD_DAI_CON0				0x0b00
+#define AFE_MOD_DAI_BASE_MSB				0x0b04
+#define AFE_MOD_DAI_BASE				0x0b08
+#define AFE_MOD_DAI_CUR_MSB				0x0b0c
+#define AFE_MOD_DAI_CUR					0x0b10
+#define AFE_MOD_DAI_END_MSB				0x0b14
+#define AFE_MOD_DAI_END					0x0b18
+#define AFE_AWB_RCH_MON					0x0b70
+#define AFE_AWB_LCH_MON					0x0b74
+#define AFE_VUL_RCH_MON					0x0b78
+#define AFE_VUL_LCH_MON					0x0b7c
+#define AFE_VUL12_RCH_MON				0x0b80
+#define AFE_VUL12_LCH_MON				0x0b84
+#define AFE_VUL2_RCH_MON				0x0b88
+#define AFE_VUL2_LCH_MON				0x0b8c
+#define AFE_DAI_DATA_MON				0x0b90
+#define AFE_MOD_DAI_DATA_MON				0x0b94
+#define AFE_DAI2_DATA_MON				0x0b98
+#define AFE_AWB2_RCH_MON				0x0b9c
+#define AFE_AWB2_LCH_MON				0x0ba0
+#define AFE_VUL3_RCH_MON				0x0ba4
+#define AFE_VUL3_LCH_MON				0x0ba8
+#define AFE_VUL4_RCH_MON				0x0bac
+#define AFE_VUL4_LCH_MON				0x0bb0
+#define AFE_VUL5_RCH_MON				0x0bb4
+#define AFE_VUL5_LCH_MON				0x0bb8
+#define AFE_VUL6_RCH_MON				0x0bbc
+#define AFE_VUL6_LCH_MON				0x0bc0
+#define AFE_DL1_RCH_MON					0x0bc4
+#define AFE_DL1_LCH_MON					0x0bc8
+#define AFE_DL2_RCH_MON					0x0bcc
+#define AFE_DL2_LCH_MON					0x0bd0
+#define AFE_DL12_RCH1_MON				0x0bd4
+#define AFE_DL12_LCH1_MON				0x0bd8
+#define AFE_DL12_RCH2_MON				0x0bdc
+#define AFE_DL12_LCH2_MON				0x0be0
+#define AFE_DL3_RCH_MON					0x0be4
+#define AFE_DL3_LCH_MON					0x0be8
+#define AFE_DL4_RCH_MON					0x0bec
+#define AFE_DL4_LCH_MON					0x0bf0
+#define AFE_DL5_RCH_MON					0x0bf4
+#define AFE_DL5_LCH_MON					0x0bf8
+#define AFE_DL6_RCH_MON					0x0bfc
+#define AFE_DL6_LCH_MON					0x0c00
+#define AFE_DL7_RCH_MON					0x0c04
+#define AFE_DL7_LCH_MON					0x0c08
+#define AFE_DL8_RCH_MON					0x0c0c
+#define AFE_DL8_LCH_MON					0x0c10
+#define AFE_VUL5_CON0					0x0c14
+#define AFE_VUL5_BASE_MSB				0x0c18
+#define AFE_VUL5_BASE					0x0c1c
+#define AFE_VUL5_CUR_MSB				0x0c20
+#define AFE_VUL5_CUR					0x0c24
+#define AFE_VUL5_END_MSB				0x0c28
+#define AFE_VUL5_END					0x0c2c
+#define AFE_VUL6_CON0					0x0c30
+#define AFE_VUL6_BASE_MSB				0x0c34
+#define AFE_VUL6_BASE					0x0c38
+#define AFE_VUL6_CUR_MSB				0x0c3c
+#define AFE_VUL6_CUR					0x0c40
+#define AFE_VUL6_END_MSB				0x0c44
+#define AFE_VUL6_END					0x0c48
+#define AFE_ADDA_DL_SDM_DCCOMP_CON			0x0c50
+#define AFE_ADDA_DL_SDM_TEST				0x0c54
+#define AFE_ADDA_DL_DC_COMP_CFG0			0x0c58
+#define AFE_ADDA_DL_DC_COMP_CFG1			0x0c5c
+#define AFE_ADDA_DL_SDM_FIFO_MON			0x0c60
+#define AFE_ADDA_DL_SRC_LCH_MON				0x0c64
+#define AFE_ADDA_DL_SRC_RCH_MON				0x0c68
+#define AFE_ADDA_DL_SDM_OUT_MON				0x0c6c
+#define AFE_ADDA_DL_SDM_DITHER_CON			0x0c70
+#define AFE_ADDA_DL_SDM_AUTO_RESET_CON			0x0c74
+#define AFE_CONNSYS_I2S_CON				0x0c78
+#define AFE_CONNSYS_I2S_MON				0x0c7c
+#define AFE_ASRC_2CH_CON0				0x0c80
+#define AFE_ASRC_2CH_CON1				0x0c84
+#define AFE_ASRC_2CH_CON2				0x0c88
+#define AFE_ASRC_2CH_CON3				0x0c8c
+#define AFE_ASRC_2CH_CON4				0x0c90
+#define AFE_ASRC_2CH_CON5				0x0c94
+#define AFE_ASRC_2CH_CON6				0x0c98
+#define AFE_ASRC_2CH_CON7				0x0c9c
+#define AFE_ASRC_2CH_CON8				0x0ca0
+#define AFE_ASRC_2CH_CON9				0x0ca4
+#define AFE_ASRC_2CH_CON10				0x0ca8
+#define AFE_ASRC_2CH_CON12				0x0cb0
+#define AFE_ASRC_2CH_CON13				0x0cb4
+#define AFE_ADDA6_IIR_COEF_02_01			0x0ce0
+#define AFE_ADDA6_IIR_COEF_04_03			0x0ce4
+#define AFE_ADDA6_IIR_COEF_06_05			0x0ce8
+#define AFE_ADDA6_IIR_COEF_08_07			0x0cec
+#define AFE_ADDA6_IIR_COEF_10_09			0x0cf0
+#define AFE_CONN67					0x0cf4
+#define AFE_CONN68					0x0cf8
+#define AFE_CONN69					0x0cfc
+#define AFE_SE_PROT_SIDEBAND				0x0d38
+#define AFE_SE_DOMAIN_SIDEBAND0				0x0d3c
+#define AFE_ADDA_PREDIS_CON2				0x0d40
+#define AFE_ADDA_PREDIS_CON3				0x0d44
+#define AFE_SE_DOMAIN_SIDEBAND1				0x0d54
+#define AFE_SE_DOMAIN_SIDEBAND2				0x0d58
+#define AFE_SE_DOMAIN_SIDEBAND3				0x0d5c
+#define AFE_CONN44					0x0d70
+#define AFE_CONN45					0x0d74
+#define AFE_CONN46					0x0d78
+#define AFE_CONN47					0x0d7c
+#define AFE_CONN44_1					0x0d80
+#define AFE_CONN45_1					0x0d84
+#define AFE_CONN46_1					0x0d88
+#define AFE_CONN47_1					0x0d8c
+#define AFE_HD_ENGEN_ENABLE				0x0dd0
+#define AFE_ADDA_DL_NLE_FIFO_MON			0x0dfc
+#define AFE_ADDA_MTKAIF_CFG0				0x0e00
+#define AFE_CONN67_1					0x0e04
+#define AFE_CONN68_1					0x0e08
+#define AFE_CONN69_1					0x0e0c
+#define AFE_ADDA_MTKAIF_SYNCWORD_CFG			0x0e14
+#define AFE_ADDA_MTKAIF_RX_CFG0				0x0e20
+#define AFE_ADDA_MTKAIF_RX_CFG1				0x0e24
+#define AFE_ADDA_MTKAIF_RX_CFG2				0x0e28
+#define AFE_ADDA_MTKAIF_MON0				0x0e34
+#define AFE_ADDA_MTKAIF_MON1				0x0e38
+#define AFE_AUD_PAD_TOP					0x0e40
+#define AFE_DL_NLE_R_CFG0				0x0e44
+#define AFE_DL_NLE_R_CFG1				0x0e48
+#define AFE_DL_NLE_L_CFG0				0x0e4c
+#define AFE_DL_NLE_L_CFG1				0x0e50
+#define AFE_DL_NLE_R_MON0				0x0e54
+#define AFE_DL_NLE_R_MON1				0x0e58
+#define AFE_DL_NLE_R_MON2				0x0e5c
+#define AFE_DL_NLE_L_MON0				0x0e60
+#define AFE_DL_NLE_L_MON1				0x0e64
+#define AFE_DL_NLE_L_MON2				0x0e68
+#define AFE_DL_NLE_GAIN_CFG0				0x0e6c
+#define AFE_ADDA6_MTKAIF_CFG0				0x0e70
+#define AFE_ADDA6_MTKAIF_RX_CFG0			0x0e74
+#define AFE_ADDA6_MTKAIF_RX_CFG1			0x0e78
+#define AFE_ADDA6_MTKAIF_RX_CFG2			0x0e7c
+#define AFE_GENERAL1_ASRC_2CH_CON0			0x0e80
+#define AFE_GENERAL1_ASRC_2CH_CON1			0x0e84
+#define AFE_GENERAL1_ASRC_2CH_CON2			0x0e88
+#define AFE_GENERAL1_ASRC_2CH_CON3			0x0e8c
+#define AFE_GENERAL1_ASRC_2CH_CON4			0x0e90
+#define AFE_GENERAL1_ASRC_2CH_CON5			0x0e94
+#define AFE_GENERAL1_ASRC_2CH_CON6			0x0e98
+#define AFE_GENERAL1_ASRC_2CH_CON7			0x0e9c
+#define AFE_GENERAL1_ASRC_2CH_CON8			0x0ea0
+#define AFE_GENERAL1_ASRC_2CH_CON9			0x0ea4
+#define AFE_GENERAL1_ASRC_2CH_CON10			0x0ea8
+#define AFE_GENERAL1_ASRC_2CH_CON12			0x0eb0
+#define AFE_GENERAL1_ASRC_2CH_CON13			0x0eb4
+#define GENERAL_ASRC_MODE				0x0eb8
+#define GENERAL_ASRC_EN_ON				0x0ebc
+#define AFE_CONN48					0x0ec0
+#define AFE_CONN49					0x0ec4
+#define AFE_CONN50					0x0ec8
+#define AFE_CONN51					0x0ecc
+#define AFE_CONN52					0x0ed0
+#define AFE_CONN53					0x0ed4
+#define AFE_CONN54					0x0ed8
+#define AFE_CONN55					0x0edc
+#define AFE_CONN48_1					0x0ee0
+#define AFE_CONN49_1					0x0ee4
+#define AFE_CONN50_1					0x0ee8
+#define AFE_CONN51_1					0x0eec
+#define AFE_CONN52_1					0x0ef0
+#define AFE_CONN53_1					0x0ef4
+#define AFE_CONN54_1					0x0ef8
+#define AFE_CONN55_1					0x0efc
+#define AFE_GENERAL2_ASRC_2CH_CON0			0x0f00
+#define AFE_GENERAL2_ASRC_2CH_CON1			0x0f04
+#define AFE_GENERAL2_ASRC_2CH_CON2			0x0f08
+#define AFE_GENERAL2_ASRC_2CH_CON3			0x0f0c
+#define AFE_GENERAL2_ASRC_2CH_CON4			0x0f10
+#define AFE_GENERAL2_ASRC_2CH_CON5			0x0f14
+#define AFE_GENERAL2_ASRC_2CH_CON6			0x0f18
+#define AFE_GENERAL2_ASRC_2CH_CON7			0x0f1c
+#define AFE_GENERAL2_ASRC_2CH_CON8			0x0f20
+#define AFE_GENERAL2_ASRC_2CH_CON9			0x0f24
+#define AFE_GENERAL2_ASRC_2CH_CON10			0x0f28
+#define AFE_GENERAL2_ASRC_2CH_CON12			0x0f30
+#define AFE_GENERAL2_ASRC_2CH_CON13			0x0f34
+#define AFE_DL5_CON0					0x0f4c
+#define AFE_DL5_BASE_MSB				0x0f50
+#define AFE_DL5_BASE					0x0f54
+#define AFE_DL5_CUR_MSB					0x0f58
+#define AFE_DL5_CUR					0x0f5c
+#define AFE_DL5_END_MSB					0x0f60
+#define AFE_DL5_END					0x0f64
+#define AFE_DL6_CON0					0x0f68
+#define AFE_DL6_BASE_MSB				0x0f6c
+#define AFE_DL6_BASE					0x0f70
+#define AFE_DL6_CUR_MSB					0x0f74
+#define AFE_DL6_CUR					0x0f78
+#define AFE_DL6_END_MSB					0x0f7c
+#define AFE_DL6_END					0x0f80
+#define AFE_DL7_CON0					0x0f84
+#define AFE_DL7_BASE_MSB				0x0f88
+#define AFE_DL7_BASE					0x0f8c
+#define AFE_DL7_CUR_MSB					0x0f90
+#define AFE_DL7_CUR					0x0f94
+#define AFE_DL7_END_MSB					0x0f98
+#define AFE_DL7_END					0x0f9c
+#define AFE_DL8_CON0					0x0fa0
+#define AFE_DL8_BASE_MSB				0x0fa4
+#define AFE_DL8_BASE					0x0fa8
+#define AFE_DL8_CUR_MSB					0x0fac
+#define AFE_DL8_CUR					0x0fb0
+#define AFE_DL8_END_MSB					0x0fb4
+#define AFE_DL8_END					0x0fb8
+#define AFE_SE_SECURE_CON				0x1004
+#define AFE_PROT_SIDEBAND_MON				0x1008
+#define AFE_DOMAIN_SIDEBAND0_MON			0x100c
+#define AFE_DOMAIN_SIDEBAND1_MON			0x1010
+#define AFE_DOMAIN_SIDEBAND2_MON			0x1014
+#define AFE_DOMAIN_SIDEBAND3_MON			0x1018
+#define AFE_SECURE_MASK_CONN0				0x1020
+#define AFE_SECURE_MASK_CONN1				0x1024
+#define AFE_SECURE_MASK_CONN2				0x1028
+#define AFE_SECURE_MASK_CONN3				0x102c
+#define AFE_SECURE_MASK_CONN4				0x1030
+#define AFE_SECURE_MASK_CONN5				0x1034
+#define AFE_SECURE_MASK_CONN6				0x1038
+#define AFE_SECURE_MASK_CONN7				0x103c
+#define AFE_SECURE_MASK_CONN8				0x1040
+#define AFE_SECURE_MASK_CONN9				0x1044
+#define AFE_SECURE_MASK_CONN10				0x1048
+#define AFE_SECURE_MASK_CONN11				0x104c
+#define AFE_SECURE_MASK_CONN12				0x1050
+#define AFE_SECURE_MASK_CONN13				0x1054
+#define AFE_SECURE_MASK_CONN14				0x1058
+#define AFE_SECURE_MASK_CONN15				0x105c
+#define AFE_SECURE_MASK_CONN16				0x1060
+#define AFE_SECURE_MASK_CONN17				0x1064
+#define AFE_SECURE_MASK_CONN18				0x1068
+#define AFE_SECURE_MASK_CONN19				0x106c
+#define AFE_SECURE_MASK_CONN20				0x1070
+#define AFE_SECURE_MASK_CONN21				0x1074
+#define AFE_SECURE_MASK_CONN22				0x1078
+#define AFE_SECURE_MASK_CONN23				0x107c
+#define AFE_SECURE_MASK_CONN24				0x1080
+#define AFE_SECURE_MASK_CONN25				0x1084
+#define AFE_SECURE_MASK_CONN26				0x1088
+#define AFE_SECURE_MASK_CONN27				0x108c
+#define AFE_SECURE_MASK_CONN28				0x1090
+#define AFE_SECURE_MASK_CONN29				0x1094
+#define AFE_SECURE_MASK_CONN30				0x1098
+#define AFE_SECURE_MASK_CONN31				0x109c
+#define AFE_SECURE_MASK_CONN32				0x10a0
+#define AFE_SECURE_MASK_CONN33				0x10a4
+#define AFE_SECURE_MASK_CONN34				0x10a8
+#define AFE_SECURE_MASK_CONN35				0x10ac
+#define AFE_SECURE_MASK_CONN36				0x10b0
+#define AFE_SECURE_MASK_CONN37				0x10b4
+#define AFE_SECURE_MASK_CONN38				0x10b8
+#define AFE_SECURE_MASK_CONN39				0x10bc
+#define AFE_SECURE_MASK_CONN40				0x10c0
+#define AFE_SECURE_MASK_CONN41				0x10c4
+#define AFE_SECURE_MASK_CONN42				0x10c8
+#define AFE_SECURE_MASK_CONN43				0x10cc
+#define AFE_SECURE_MASK_CONN44				0x10d0
+#define AFE_SECURE_MASK_CONN45				0x10d4
+#define AFE_SECURE_MASK_CONN46				0x10d8
+#define AFE_SECURE_MASK_CONN47				0x10dc
+#define AFE_SECURE_MASK_CONN48				0x10e0
+#define AFE_SECURE_MASK_CONN49				0x10e4
+#define AFE_SECURE_MASK_CONN50				0x10e8
+#define AFE_SECURE_MASK_CONN51				0x10ec
+#define AFE_SECURE_MASK_CONN52				0x10f0
+#define AFE_SECURE_MASK_CONN53				0x10f4
+#define AFE_SECURE_MASK_CONN54				0x10f8
+#define AFE_SECURE_MASK_CONN55				0x10fc
+#define AFE_SECURE_MASK_CONN56				0x1100
+#define AFE_SECURE_MASK_CONN57				0x1104
+#define AFE_SECURE_MASK_CONN0_1				0x1108
+#define AFE_SECURE_MASK_CONN1_1				0x110c
+#define AFE_SECURE_MASK_CONN2_1				0x1110
+#define AFE_SECURE_MASK_CONN3_1				0x1114
+#define AFE_SECURE_MASK_CONN4_1				0x1118
+#define AFE_SECURE_MASK_CONN5_1				0x111c
+#define AFE_SECURE_MASK_CONN6_1				0x1120
+#define AFE_SECURE_MASK_CONN7_1				0x1124
+#define AFE_SECURE_MASK_CONN8_1				0x1128
+#define AFE_SECURE_MASK_CONN9_1				0x112c
+#define AFE_SECURE_MASK_CONN10_1			0x1130
+#define AFE_SECURE_MASK_CONN11_1			0x1134
+#define AFE_SECURE_MASK_CONN12_1			0x1138
+#define AFE_SECURE_MASK_CONN13_1			0x113c
+#define AFE_SECURE_MASK_CONN14_1			0x1140
+#define AFE_SECURE_MASK_CONN15_1			0x1144
+#define AFE_SECURE_MASK_CONN16_1			0x1148
+#define AFE_SECURE_MASK_CONN17_1			0x114c
+#define AFE_SECURE_MASK_CONN18_1			0x1150
+#define AFE_SECURE_MASK_CONN19_1			0x1154
+#define AFE_SECURE_MASK_CONN20_1			0x1158
+#define AFE_SECURE_MASK_CONN21_1			0x115c
+#define AFE_SECURE_MASK_CONN22_1			0x1160
+#define AFE_SECURE_MASK_CONN23_1			0x1164
+#define AFE_SECURE_MASK_CONN24_1			0x1168
+#define AFE_SECURE_MASK_CONN25_1			0x116c
+#define AFE_SECURE_MASK_CONN26_1			0x1170
+#define AFE_SECURE_MASK_CONN27_1			0x1174
+#define AFE_SECURE_MASK_CONN28_1			0x1178
+#define AFE_SECURE_MASK_CONN29_1			0x117c
+#define AFE_SECURE_MASK_CONN30_1			0x1180
+#define AFE_SECURE_MASK_CONN31_1			0x1184
+#define AFE_SECURE_MASK_CONN32_1			0x1188
+#define AFE_SECURE_MASK_CONN33_1			0x118c
+#define AFE_SECURE_MASK_CONN34_1			0x1190
+#define AFE_SECURE_MASK_CONN35_1			0x1194
+#define AFE_SECURE_MASK_CONN36_1			0x1198
+#define AFE_SECURE_MASK_CONN37_1			0x119c
+#define AFE_SECURE_MASK_CONN38_1			0x11a0
+#define AFE_SECURE_MASK_CONN39_1			0x11a4
+#define AFE_SECURE_MASK_CONN40_1			0x11a8
+#define AFE_SECURE_MASK_CONN41_1			0x11ac
+#define AFE_SECURE_MASK_CONN42_1			0x11b0
+#define AFE_SECURE_MASK_CONN43_1			0x11b4
+#define AFE_SECURE_MASK_CONN44_1			0x11b8
+#define AFE_SECURE_MASK_CONN45_1			0x11bc
+#define AFE_SECURE_MASK_CONN46_1			0x11c0
+#define AFE_SECURE_MASK_CONN47_1			0x11c4
+#define AFE_SECURE_MASK_CONN48_1			0x11c8
+#define AFE_SECURE_MASK_CONN49_1			0x11cc
+#define AFE_SECURE_MASK_CONN50_1			0x11d0
+#define AFE_SECURE_MASK_CONN51_1			0x11d4
+#define AFE_SECURE_MASK_CONN52_1			0x11d8
+#define AFE_SECURE_MASK_CONN53_1			0x11dc
+#define AFE_SECURE_MASK_CONN54_1			0x11e0
+#define AFE_SECURE_MASK_CONN55_1			0x11e4
+#define AFE_SECURE_MASK_CONN56_1			0x11e8
+#define AFE_CONN60_1					0x11f0
+#define AFE_CONN61_1					0x11f4
+#define AFE_CONN62_1					0x11f8
+#define AFE_CONN63_1					0x11fc
+#define AFE_CONN64_1					0x1220
+#define AFE_CONN65_1					0x1224
+#define AFE_CONN66_1					0x1228
+#define FPGA_CFG4					0x1230
+#define FPGA_CFG5					0x1234
+#define FPGA_CFG6					0x1238
+#define FPGA_CFG7					0x123c
+#define FPGA_CFG8					0x1240
+#define FPGA_CFG9					0x1244
+#define FPGA_CFG10					0x1248
+#define FPGA_CFG11					0x124c
+#define FPGA_CFG12					0x1250
+#define FPGA_CFG13					0x1254
+#define ETDM_IN1_CON0					0x1430
+#define ETDM_IN1_CON1					0x1434
+#define ETDM_IN1_CON2					0x1438
+#define ETDM_IN1_CON3					0x143c
+#define ETDM_IN1_CON4					0x1440
+#define ETDM_IN1_CON5					0x1444
+#define ETDM_IN1_CON6					0x1448
+#define ETDM_IN1_CON7					0x144c
+#define ETDM_IN1_CON8					0x1450
+#define ETDM_OUT1_CON0					0x1454
+#define ETDM_OUT1_CON1					0x1458
+#define ETDM_OUT1_CON2					0x145c
+#define ETDM_OUT1_CON3					0x1460
+#define ETDM_OUT1_CON4					0x1464
+#define ETDM_OUT1_CON5					0x1468
+#define ETDM_OUT1_CON6					0x146c
+#define ETDM_OUT1_CON7					0x1470
+#define ETDM_OUT1_CON8					0x1474
+#define ETDM_IN1_MON					0x1478
+#define ETDM_OUT1_MON					0x147c
+#define ETDM_0_3_COWORK_CON0				0x18b0
+#define ETDM_0_3_COWORK_CON1				0x18b4
+#define ETDM_0_3_COWORK_CON3				0x18bc
+
+#define AFE_MAX_REGISTER				ETDM_0_3_COWORK_CON3
+
+#define AFE_IRQ_STATUS_BITS				0x87FFFFFF
+#define AFE_IRQ_CNT_SHIFT				0
+#define AFE_IRQ_CNT_MASK				0x3ffff
+#endif
-- 
2.25.1

