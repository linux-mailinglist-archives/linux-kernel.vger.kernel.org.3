Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61FEA4D1E86
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348784AbiCHRT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348869AbiCHRTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:19:50 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F74B53E0D;
        Tue,  8 Mar 2022 09:18:40 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 228FxhGa010224;
        Tue, 8 Mar 2022 11:17:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=KRAJ9KxNW31tRdXp2gGHGjjxvemKVJrgKmCNt9nj+dk=;
 b=Z36QJYH876K3r1GvJLg8beMAPodEjED7vWRdp602mtGnJpDmEk7BvJK5f2iGdD+85pe0
 TQu8BQTUw+N0hPKy75QZTTlcjz2zpveF9U9necxg9c2Sb4Imo1kxoEqPnjHhJVP3Hrsz
 f/y27nYY1LufF8rdZwsaoP3wMz1leX8OHTZuS3IL5LfE9eQ2LOrqjcufeHyJNK625EDl
 1QAUkl53qoFic6AfWXFp+3E8GmC2dm2iCGcE1TX29E5n56R1eF5/Dd9shGdVYpubs/Xq
 Xr848uODsXnBwH6tJZiqWoOAz17xihpNx2tM5Oj6v9BtDc3QOpcHlY5lItcR0LKul7BG kQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3em656mh5v-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Mar 2022 11:17:47 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 8 Mar
 2022 17:17:35 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Tue, 8 Mar 2022 17:17:35 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.38])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 31C7DB06;
        Tue,  8 Mar 2022 17:17:35 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH v3 11/16] ALSA: hda: cs35l41: Remove cs35l41_hda_reg_sequence struct
Date:   Tue, 8 Mar 2022 17:17:25 +0000
Message-ID: <20220308171730.454587-12-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
References: <20220308171730.454587-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Gd3zknG0q2_bnHddZt20dl7YXqrgMTft
X-Proofpoint-GUID: Gd3zknG0q2_bnHddZt20dl7YXqrgMTft
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove cs35l41_hd_reg_sequence as it adds a layer of flexibility not needed.
As cs35l41_hda_(start/stop)_bst is a single register, it can be replaced by
regmap_update_bits with usleep_range to wait for the same 3000us that
reg_sequence had.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/pci/hda/cs35l41_hda.c | 79 ++++++++++++++++---------------------
 sound/pci/hda/cs35l41_hda.h | 14 -------
 2 files changed, 33 insertions(+), 60 deletions(-)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index 3b8167d1ccc1..08ce9b8005ec 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -32,14 +32,6 @@ static const struct reg_sequence cs35l41_hda_mute[] = {
 	{ CS35L41_AMP_DIG_VOL_CTRL,	0x0000A678 }, // AMP_VOL_PCM Mute
 };
 
-static const struct reg_sequence cs35l41_hda_start_bst[] = {
-	{ CS35L41_PWR_CTRL1,		0x00000001, 3000}, // set GLOBAL_EN = 1
-};
-
-static const struct reg_sequence cs35l41_hda_stop_bst[] = {
-	{ CS35L41_PWR_CTRL1,		0x00000000, 3000}, // set GLOBAL_EN = 0
-};
-
 // only on amps where GPIO1 is used to control ext. VSPK switch
 static const struct reg_sequence cs35l41_start_ext_vspk[] = {
 	{ 0x00000040,			0x00000055 },
@@ -109,31 +101,44 @@ static const struct reg_sequence cs35l41_reset_to_safe[] = {
 	{ 0x00000040,			0x00000033 },
 };
 
-static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_no_bst = {
-	.prepare	= cs35l41_safe_to_active,
-	.num_prepare	= ARRAY_SIZE(cs35l41_safe_to_active),
-	.cleanup	= cs35l41_active_to_safe,
-	.num_cleanup	= ARRAY_SIZE(cs35l41_active_to_safe),
-};
+static int cs35l41_hda_global_enable(struct cs35l41_hda *cs35l41, int enable)
+{
+	int ret;
 
-static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_ext_bst = {
-	.prepare	= cs35l41_start_ext_vspk,
-	.num_prepare	= ARRAY_SIZE(cs35l41_start_ext_vspk),
-	.cleanup	= cs35l41_stop_ext_vspk,
-	.num_cleanup	= ARRAY_SIZE(cs35l41_stop_ext_vspk),
-};
+	switch (cs35l41->hw_cfg.bst_type) {
+	case CS35L41_INT_BOOST:
+		ret = regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL1,
+					 CS35L41_GLOBAL_EN_MASK,
+					 enable << CS35L41_GLOBAL_EN_SHIFT);
+		usleep_range(3000, 3100);
+		break;
+	case CS35L41_EXT_BOOST:
+		if (enable)
+			ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_start_ext_vspk,
+						     ARRAY_SIZE(cs35l41_start_ext_vspk));
+		else
+			ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_stop_ext_vspk,
+						     ARRAY_SIZE(cs35l41_stop_ext_vspk));
+		break;
+	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
+		if (enable)
+			ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_safe_to_active,
+						     ARRAY_SIZE(cs35l41_safe_to_active));
+		else
+			ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41_active_to_safe,
+						     ARRAY_SIZE(cs35l41_active_to_safe));
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
 
-static const struct cs35l41_hda_reg_sequence cs35l41_hda_reg_seq_int_bst = {
-	.prepare	= cs35l41_hda_start_bst,
-	.num_prepare	= ARRAY_SIZE(cs35l41_hda_start_bst),
-	.cleanup	= cs35l41_hda_stop_bst,
-	.num_cleanup	= ARRAY_SIZE(cs35l41_hda_stop_bst),
+	return ret;
 };
 
 static void cs35l41_hda_playback_hook(struct device *dev, int action)
 {
 	struct cs35l41_hda *cs35l41 = dev_get_drvdata(dev);
-	const struct cs35l41_hda_reg_sequence *reg_seq = cs35l41->reg_seq;
 	struct regmap *reg = cs35l41->regmap;
 	int ret = 0;
 
@@ -145,19 +150,15 @@ static void cs35l41_hda_playback_hook(struct device *dev, int action)
 				   CS35L41_AMP_EN_MASK, 1 << CS35L41_AMP_EN_SHIFT);
 		break;
 	case HDA_GEN_PCM_ACT_PREPARE:
-		if (reg_seq->prepare)
-			ret = regmap_multi_reg_write(reg, reg_seq->prepare, reg_seq->num_prepare);
+		ret = cs35l41_hda_global_enable(cs35l41, 1);
 		break;
 	case HDA_GEN_PCM_ACT_CLEANUP:
 		regmap_multi_reg_write(reg, cs35l41_hda_mute, ARRAY_SIZE(cs35l41_hda_mute));
-		if (reg_seq->cleanup)
-			ret = regmap_multi_reg_write(reg, reg_seq->cleanup, reg_seq->num_cleanup);
+		ret = cs35l41_hda_global_enable(cs35l41, 0);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
 		regmap_update_bits(reg, CS35L41_PWR_CTRL2,
 				   CS35L41_AMP_EN_MASK, 0 << CS35L41_AMP_EN_SHIFT);
-		if (reg_seq->close)
-			ret = regmap_multi_reg_write(reg, reg_seq->close, reg_seq->num_close);
 		break;
 	default:
 		ret = -EINVAL;
@@ -221,7 +222,6 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 
 	switch (hw_cfg->bst_type) {
 	case CS35L41_INT_BOOST:
-		cs35l41->reg_seq = &cs35l41_hda_reg_seq_int_bst;
 		ret = cs35l41_boost_config(cs35l41->dev, cs35l41->regmap,
 					   hw_cfg->bst_ind, hw_cfg->bst_cap, hw_cfg->bst_ipk);
 		if (ret)
@@ -229,10 +229,6 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 		break;
 	case CS35L41_EXT_BOOST:
 	case CS35L41_EXT_BOOST_NO_VSPK_SWITCH:
-		if (hw_cfg->bst_type == CS35L41_EXT_BOOST)
-			cs35l41->reg_seq = &cs35l41_hda_reg_seq_ext_bst;
-		else
-			cs35l41->reg_seq = &cs35l41_hda_reg_seq_no_bst;
 		regmap_multi_reg_write(cs35l41->regmap, cs35l41_reset_to_safe,
 				       ARRAY_SIZE(cs35l41_reset_to_safe));
 		ret = regmap_update_bits(cs35l41->regmap, CS35L41_PWR_CTRL2, CS35L41_BST_EN_MASK,
@@ -511,15 +507,6 @@ int cs35l41_hda_probe(struct device *dev, const char *device_name, int id, int i
 	if (ret)
 		goto err;
 
-	if (cs35l41->reg_seq->probe) {
-		ret = regmap_multi_reg_write(cs35l41->regmap, cs35l41->reg_seq->probe,
-					     cs35l41->reg_seq->num_probe);
-		if (ret) {
-			dev_err(cs35l41->dev, "Fail to apply probe reg patch: %d\n", ret);
-			goto err;
-		}
-	}
-
 	ret = component_add(cs35l41->dev, &cs35l41_hda_comp_ops);
 	if (ret) {
 		dev_err(cs35l41->dev, "Register component failed: %d\n", ret);
diff --git a/sound/pci/hda/cs35l41_hda.h b/sound/pci/hda/cs35l41_hda.h
index 17f10764f174..44d9204ffdf1 100644
--- a/sound/pci/hda/cs35l41_hda.h
+++ b/sound/pci/hda/cs35l41_hda.h
@@ -27,24 +27,10 @@ enum cs35l41_hda_gpio_function {
 	CS35l41_SYNC,
 };
 
-struct cs35l41_hda_reg_sequence {
-	const struct reg_sequence *probe;
-	unsigned int num_probe;
-	const struct reg_sequence *open;
-	unsigned int num_open;
-	const struct reg_sequence *prepare;
-	unsigned int num_prepare;
-	const struct reg_sequence *cleanup;
-	unsigned int num_cleanup;
-	const struct reg_sequence *close;
-	unsigned int num_close;
-};
-
 struct cs35l41_hda {
 	struct device *dev;
 	struct regmap *regmap;
 	struct gpio_desc *reset_gpio;
-	const struct cs35l41_hda_reg_sequence *reg_seq;
 	struct cs35l41_hw_cfg hw_cfg;
 
 	int irq;
-- 
2.35.1

