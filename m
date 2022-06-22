Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C5C554966
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351027AbiFVKOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 06:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351214AbiFVKNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 06:13:55 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F14425280;
        Wed, 22 Jun 2022 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1655892834; x=1687428834;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=N444SvRB40SKbqAwsQm2TSEKlF7bTgWg3nWfEMVWa7E=;
  b=fMjb4uD4tnc+HtMhW5eNqYvkMbxrIIMZfiFwDz8bp57MlPaQx2vxAqG7
   EYUAlx9vSHIN/BFg+ai3UbM4XeTJDQPZ1uXKR7nkFz3TTMSHeZ0Eyk+P3
   tDB/xiq3SSINoEQ/GeMacEh7/Eyf9dWNhRxLDenPb/g0WaYPgwwy2a6nO
   A=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Jun 2022 03:13:54 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 03:13:53 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 03:13:52 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 22 Jun 2022 03:13:47 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        <devicetree@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Subject: [PATCH 2/2] ASoC: qcom: Add driver support for audioreach solution
Date:   Wed, 22 Jun 2022 15:43:19 +0530
Message-ID: <1655892799-29641-3-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1655892799-29641-1-git-send-email-quic_srivasam@quicinc.com>
References: <1655892799-29641-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Machine driver support for audioreach solution, which uses
ADSP in SC7280 based paltforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
---
 sound/soc/qcom/sc7280.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
index 34cdb99..abe261c 100644
--- a/sound/soc/qcom/sc7280.c
+++ b/sound/soc/qcom/sc7280.c
@@ -19,9 +19,11 @@
 #include "../codecs/rt5682s.h"
 #include "common.h"
 #include "lpass.h"
+#include "qdsp6/q6afe.h"
 
 #define DEFAULT_MCLK_RATE              19200000
 #define RT5682_PLL_FREQ (48000 * 512)
+#define MI2S_BCLK_RATE		1536000
 
 struct sc7280_snd_data {
 	struct snd_soc_card card;
@@ -79,6 +81,7 @@ static int sc7280_headset_init(struct snd_soc_pcm_runtime *rtd)
 	case MI2S_PRIMARY:
 	case LPASS_CDC_DMA_RX0:
 	case LPASS_CDC_DMA_TX3:
+	case TX_CODEC_DMA_TX_3:
 		for_each_rtd_codec_dais(rtd, i, codec_dai) {
 			rval = snd_soc_component_set_jack(component, &pdata->hs_jack, NULL);
 			if (rval != 0 && rval != -ENOTSUPP) {
@@ -164,10 +167,14 @@ static int sc7280_init(struct snd_soc_pcm_runtime *rtd)
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
 	case LPASS_CDC_DMA_TX3:
+	case TX_CODEC_DMA_TX_3:
 		return sc7280_headset_init(rtd);
 	case LPASS_CDC_DMA_RX0:
 	case LPASS_CDC_DMA_VA_TX0:
 	case MI2S_SECONDARY:
+	case RX_CODEC_DMA_RX_0:
+	case SECONDARY_MI2S_RX:
+	case VA_CODEC_DMA_TX_0:
 		return 0;
 	case LPASS_DP_RX:
 		return sc7280_hdmi_init(rtd);
@@ -195,6 +202,10 @@ static int sc7280_snd_hw_params(struct snd_pcm_substream *substream,
 	switch (cpu_dai->id) {
 	case LPASS_CDC_DMA_TX3:
 	case LPASS_CDC_DMA_RX0:
+	case RX_CODEC_DMA_RX_0:
+	case SECONDARY_MI2S_RX:
+	case TX_CODEC_DMA_TX_3:
+	case VA_CODEC_DMA_TX_0:
 		for_each_rtd_codec_dais(rtd, i, codec_dai) {
 			sruntime = snd_soc_dai_get_stream(codec_dai, substream->stream);
 			if (sruntime != ERR_PTR(-ENOTSUPP))
@@ -245,6 +256,9 @@ static int sc7280_snd_prepare(struct snd_pcm_substream *substream)
 	switch (cpu_dai->id) {
 	case LPASS_CDC_DMA_RX0:
 	case LPASS_CDC_DMA_TX3:
+	case RX_CODEC_DMA_RX_0:
+	case TX_CODEC_DMA_TX_3:
+	case VA_CODEC_DMA_TX_0:
 		return sc7280_snd_swr_prepare(substream);
 	default:
 		break;
@@ -263,6 +277,9 @@ static int sc7280_snd_hw_free(struct snd_pcm_substream *substream)
 	switch (cpu_dai->id) {
 	case LPASS_CDC_DMA_RX0:
 	case LPASS_CDC_DMA_TX3:
+	case RX_CODEC_DMA_RX_0:
+	case TX_CODEC_DMA_TX_3:
+	case VA_CODEC_DMA_TX_0:
 		if (sruntime && data->stream_prepared[cpu_dai->id]) {
 			sdw_disable_stream(sruntime);
 			sdw_deprepare_stream(sruntime);
@@ -291,6 +308,10 @@ static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
 					       SNDRV_PCM_STREAM_PLAYBACK);
 		}
 		break;
+	case SECONDARY_MI2S_RX:
+		snd_soc_dai_set_sysclk(cpu_dai, Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
+					       0, SNDRV_PCM_STREAM_PLAYBACK);
+		break;
 	default:
 		break;
 	}
@@ -298,14 +319,26 @@ static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
 
 static int sc7280_snd_startup(struct snd_pcm_substream *substream)
 {
+	unsigned int fmt = SND_SOC_DAIFMT_CBS_CFS;
+	unsigned int codec_dai_fmt = SND_SOC_DAIFMT_CBS_CFS;
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
+	struct snd_soc_dai *codec_dai = asoc_rtd_to_codec(rtd, 0);
 	int ret = 0;
 
 	switch (cpu_dai->id) {
 	case MI2S_PRIMARY:
 		ret = sc7280_rt5682_init(rtd);
 		break;
+	case SECONDARY_MI2S_RX:
+		codec_dai_fmt |= SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_I2S;
+
+		snd_soc_dai_set_sysclk(cpu_dai, Q6AFE_LPASS_CLK_ID_SEC_MI2S_IBIT,
+			MI2S_BCLK_RATE, SNDRV_PCM_STREAM_PLAYBACK);
+
+		snd_soc_dai_set_fmt(cpu_dai, fmt);
+		snd_soc_dai_set_fmt(codec_dai, codec_dai_fmt);
+		break;
 	default:
 		break;
 	}
@@ -361,6 +394,7 @@ static int sc7280_snd_platform_probe(struct platform_device *pdev)
 
 static const struct of_device_id sc7280_snd_device_id[]  = {
 	{ .compatible = "google,sc7280-herobrine" },
+	{ .compatible = "google,sc7280-audioreach-herobrine" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, sc7280_snd_device_id);
-- 
2.7.4

