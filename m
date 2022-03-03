Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7554CC3DB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235433AbiCCRcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbiCCRcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:32:04 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF8319E0AB;
        Thu,  3 Mar 2022 09:31:19 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223509T9013880;
        Thu, 3 Mar 2022 11:31:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=71ZP0HhkAgra+5pwRxbVCGp5wL/k4hevq9c+UZpjcWE=;
 b=dmgqtilpgWLGZoKLx0lW6vEB/f+pDn0QWDV/7sLfcaCMOV2O3CGWH0gQPxRARaTLqD3c
 ws0/y56Kfn0ghCEn2Oh73d99krpoQTwDZ6xl9JrfLt0M620ClR4uLNp0rt3dLkVyp0vE
 8klw9tGWxJuVVo7mj2J5fOSeNPVa8OMfS0gObEPtG6ScPyRnpwLY4srubCV/NkuVDafI
 5n6wAdfmAwJUAE4XFJSCcdzUPImCLY9U2eY8MTrR7V3wcCDyskMn3dGNNm+nCvOEsh0C
 0YUxCb++OBuPxg0TgyGTHulG0eT/M4dRTMlymjhxv5bL3MzYWfwJSdBUmEli+h1ygR0K fQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8ybn-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 11:31:10 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:31:08 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 17:31:08 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AB6592A1;
        Thu,  3 Mar 2022 17:31:07 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 15/20] hda: cs35l41: Remove unnecessary log
Date:   Thu, 3 Mar 2022 17:30:54 +0000
Message-ID: <20220303173059.269657-16-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 9qTLZvoXuQZkI6lwFnJFFrJhOp5BXCLB
X-Proofpoint-GUID: 9qTLZvoXuQZkI6lwFnJFFrJhOp5BXCLB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If regmap fails would fail during probe of the device.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 90c833a25599..f21d048e60ab 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -135,37 +135,31 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
 	const struct cs35l41_hda_reg_sequence *reg_seq = cs35l41->reg_seq;
 	struct regmap *reg = cs35l41->regmap;
-	int ret = 0;
 
 	switch (action) {
 	case HDA_GEN_PCM_ACT_OPEN:
-		ret = regmap_multi_reg_write(reg, cs35l41_hda_config,
-					     ARRAY_SIZE(cs35l41_hda_config));
+		regmap_multi_reg_write(reg, cs35l41_hda_config, ARRAY_SIZE(cs35l41_hda_config));
 		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
 				   CS35L41_AMP_EN_MASK, 1 << CS35L41_AMP_EN_SHIFT);
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
 		if (reg_seq->prepare)
-			ret = regmap_multi_reg_write(reg, reg_seq->prepare, reg_seq->num_prepare);
+			regmap_multi_reg_write(reg, reg_seq->prepare, reg_seq->num_prepare);
 		break;
 	case HDA_GEN_PCM_ACT_CLEANUP:
 		regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
 		if (reg_seq->cleanup)
-			ret = regmap_multi_reg_write(reg, reg_seq->cleanup, reg_seq->num_cleanup);
+			regmap_multi_reg_write(reg, reg_seq->cleanup, reg_seq->num_cleanup);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
 		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
 				   CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
 		if (reg_seq->close)
-			ret = regmap_multi_reg_write(reg, reg_seq->close, reg_seq->num_close);
+			regmap_multi_reg_write(reg, reg_seq->close, reg_seq->num_close);
 		break;
 	default:
-		ret = -EINVAL;
 		break;
 	}
-
-	if (ret)
-		dev_warn(cs35l41->dev, "Failed to apply multi reg write: %d\n", ret);
 }
 
 static int cs35l41_hda_channel_map(struct device *dev, unsigned int tx_num, unsigned int *tx_slot,
-- 
2.35.1

