Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB46579692
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 11:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiGSJpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 05:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbiGSJo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 05:44:26 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B32B27B06
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 02:44:25 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E3D84200C18;
        Tue, 19 Jul 2022 11:44:23 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 63E05200BFE;
        Tue, 19 Jul 2022 11:44:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id B690C180222C;
        Tue, 19 Jul 2022 17:44:21 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH -next 4/5] ASoC: fsl_easrc: use snd_pcm_format_t type for sample_format
Date:   Tue, 19 Jul 2022 17:27:43 +0800
Message-Id: <1658222864-25378-5-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658222864-25378-1-git-send-email-shengjiu.wang@nxp.com>
References: <1658222864-25378-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse warning:
sound/soc/fsl/fsl_easrc.c:562:33: sparse: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/fsl/fsl_easrc.c:563:34: sparse: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/fsl/fsl_easrc.c:565:38: sparse: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/fsl/fsl_easrc.c:566:39: sparse: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/fsl/fsl_easrc.c:608:33: sparse: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/fsl/fsl_easrc.c:609:34: sparse: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/fsl/fsl_easrc.c:615:40: sparse: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/fsl/fsl_easrc.c:616:41: sparse: warning: restricted snd_pcm_format_t degrades to integer

sound/soc/fsl/fsl_easrc.c:1465:51: sparse: warning: incorrect type in assignment (different base types)
sound/soc/fsl/fsl_easrc.c:1465:51: sparse:    expected unsigned int sample_format
sound/soc/fsl/fsl_easrc.c:1465:51: sparse:    got restricted snd_pcm_format_t [usertype] format
sound/soc/fsl/fsl_easrc.c:1467:52: sparse: warning: incorrect type in assignment (different base types)
sound/soc/fsl/fsl_easrc.c:1467:52: sparse:    expected unsigned int sample_format
sound/soc/fsl/fsl_easrc.c:1467:52: sparse:    got restricted snd_pcm_format_t [usertype] asrc_format
sound/soc/fsl/fsl_easrc.c:1470:52: sparse: warning: incorrect type in assignment (different base types)
sound/soc/fsl/fsl_easrc.c:1470:52: sparse:    expected unsigned int sample_format
sound/soc/fsl/fsl_easrc.c:1470:52: sparse:    got restricted snd_pcm_format_t [usertype] format
sound/soc/fsl/fsl_easrc.c:1472:51: sparse: warning: incorrect type in assignment (different base types)
sound/soc/fsl/fsl_easrc.c:1472:51: sparse:    expected unsigned int sample_format
sound/soc/fsl/fsl_easrc.c:1472:51: sparse:    got restricted snd_pcm_format_t [usertype] asrc_format
sound/soc/fsl/fsl_easrc.c:1484:41: sparse: warning: incorrect type in argument 2 (different base types)
sound/soc/fsl/fsl_easrc.c:1484:41: sparse:    expected restricted snd_pcm_format_t [usertype] *in_raw_format
sound/soc/fsl/fsl_easrc.c:1484:41: sparse:    got unsigned int *
sound/soc/fsl/fsl_easrc.c:1485:41: sparse: warning: incorrect type in argument 3 (different base types)
sound/soc/fsl/fsl_easrc.c:1485:41: sparse:    expected restricted snd_pcm_format_t [usertype] *out_raw_format
sound/soc/fsl/fsl_easrc.c:1485:41: sparse:    got unsigned int *
sound/soc/fsl/fsl_easrc.c:1937:60: sparse: warning: incorrect type in argument 3 (different base types)
sound/soc/fsl/fsl_easrc.c:1937:60: sparse:    expected unsigned int [usertype] *out_value
sound/soc/fsl/fsl_easrc.c:1937:60: sparse:    got restricted snd_pcm_format_t *
sound/soc/fsl/fsl_easrc.c:1943:49: sparse: warning: restricted snd_pcm_format_t degrades to integer

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 7 ++++---
 sound/soc/fsl/fsl_easrc.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index ea96b0fb6b20..3f301f1a0acc 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -476,7 +476,8 @@ static int fsl_easrc_prefilter_config(struct fsl_asrc *easrc,
 	struct fsl_asrc_pair *ctx;
 	struct device *dev;
 	u32 inrate, outrate, offset = 0;
-	u32 in_s_rate, out_s_rate, in_s_fmt, out_s_fmt;
+	u32 in_s_rate, out_s_rate;
+	snd_pcm_format_t in_s_fmt, out_s_fmt;
 	int ret, i;
 
 	if (!easrc)
@@ -1934,13 +1935,13 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = of_property_read_u32(np, "fsl,asrc-format", &easrc->asrc_format);
+	ret = of_property_read_u32(np, "fsl,asrc-format", (u32 *)&easrc->asrc_format);
 	if (ret) {
 		dev_err(dev, "failed to asrc format\n");
 		return ret;
 	}
 
-	if (!(FSL_EASRC_FORMATS & (1ULL << easrc->asrc_format))) {
+	if (!(FSL_EASRC_FORMATS & (1ULL << (__force u32)easrc->asrc_format))) {
 		dev_warn(dev, "unsupported format, switching to S24_LE\n");
 		easrc->asrc_format = SNDRV_PCM_FORMAT_S24_LE;
 	}
diff --git a/sound/soc/fsl/fsl_easrc.h b/sound/soc/fsl/fsl_easrc.h
index 86d5c360d4f5..7c70dac52713 100644
--- a/sound/soc/fsl/fsl_easrc.h
+++ b/sound/soc/fsl/fsl_easrc.h
@@ -569,7 +569,7 @@ struct fsl_easrc_io_params {
 	unsigned int access_len;
 	unsigned int fifo_wtmk;
 	unsigned int sample_rate;
-	unsigned int sample_format;
+	snd_pcm_format_t sample_format;
 	unsigned int norm_rate;
 };
 
-- 
2.34.1

