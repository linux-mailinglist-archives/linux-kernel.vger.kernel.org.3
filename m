Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2DC504B57
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 05:30:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiDRDcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 23:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiDRDci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 23:32:38 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CB7B33
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 20:29:59 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 78B191A11AD;
        Mon, 18 Apr 2022 05:29:57 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 41AA11A1145;
        Mon, 18 Apr 2022 05:29:57 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 032D31800096;
        Mon, 18 Apr 2022 11:29:55 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     shengjiu.wang@gmail.com
Subject: [PATCH] ASoC: dmic: Add support for DSD data format
Date:   Mon, 18 Apr 2022 11:18:30 +0800
Message-Id: <1650251910-8932-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DSD format support in this generic dmic driver:
DSD_U8,
DSD_U16_LE,
DSD_U32_LE,

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/codecs/dmic.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index 5d079d90fd3b..d1a30ca4571a 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -82,7 +82,10 @@ static struct snd_soc_dai_driver dmic_dai = {
 		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = SNDRV_PCM_FMTBIT_S32_LE
 			| SNDRV_PCM_FMTBIT_S24_LE
-			| SNDRV_PCM_FMTBIT_S16_LE,
+			| SNDRV_PCM_FMTBIT_S16_LE
+			| SNDRV_PCM_FMTBIT_DSD_U8
+			| SNDRV_PCM_FMTBIT_DSD_U16_LE
+			| SNDRV_PCM_FMTBIT_DSD_U32_LE,
 	},
 	.ops    = &dmic_dai_ops,
 };
-- 
2.17.1

