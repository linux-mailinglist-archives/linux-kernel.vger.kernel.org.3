Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166F9552F97
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348780AbiFUKVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 06:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346086AbiFUKU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 06:20:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FE5228709
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 03:20:56 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25L7wQ93011194;
        Tue, 21 Jun 2022 05:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=fB9ln2+/kLOhJUlPJhQ32wpqQpdn6uB0gaQIeYvrdh4=;
 b=DkP1GMkrKOomvn/RG5WREXq0wJB2ELm8h7p8L84ANWCB6oja9bzHSDirDmALrgpBAfx8
 ghwBrwMU+L0xeMbEvJqpjQkM8SXvS3lOnhp7l7VBB8/cIKFN5Lz0DUt5SATDLUV5LUjX
 v20/HPY559khAaPyJvk8n1Dmgk9XupEDGBP6SohHVJanNFepBd7N9+Idh/O780TrbFaB
 Vvo915+Xa4W9L+4419ztN1Zj3bzXHhtkEZP0VIipw7104TVPOen3dHJAvALsLlnZMtbL
 FuxvwRWnzsez8aIMGC7x1XvV+FPPM0buxJyjBL+7va4OQvn2o9gLsY5BlOQ/AoBwKVbr QA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3gsc41bcxp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jun 2022 05:20:45 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 21 Jun
 2022 11:20:42 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Tue, 21 Jun 2022 11:20:42 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1C162478;
        Tue, 21 Jun 2022 10:20:42 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
        <lgirdwood@gmail.com>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/4] ASoC: cs35l41: Correct some control names
Date:   Tue, 21 Jun 2022 11:20:40 +0100
Message-ID: <20220621102041.1713504-3-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220621102041.1713504-1-ckeepax@opensource.cirrus.com>
References: <20220621102041.1713504-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: astuIhIZfLIGurtNCJkGU_1qrz48YpmV
X-Proofpoint-ORIG-GUID: astuIhIZfLIGurtNCJkGU_1qrz48YpmV
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various boolean controls on cs35l41 are missing the required "Switch" in
the name, add these.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index a115ea35b92d4..8766e19d85f11 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -333,7 +333,7 @@ static const struct snd_kcontrol_new cs35l41_aud_controls[] = {
 	SOC_SINGLE("HW Noise Gate Enable", CS35L41_NG_CFG, 8, 63, 0),
 	SOC_SINGLE("HW Noise Gate Delay", CS35L41_NG_CFG, 4, 7, 0),
 	SOC_SINGLE("HW Noise Gate Threshold", CS35L41_NG_CFG, 0, 7, 0),
-	SOC_SINGLE("Aux Noise Gate CH1 Enable",
+	SOC_SINGLE("Aux Noise Gate CH1 Switch",
 		   CS35L41_MIXER_NGATE_CH1_CFG, 16, 1, 0),
 	SOC_SINGLE("Aux Noise Gate CH1 Entry Delay",
 		   CS35L41_MIXER_NGATE_CH1_CFG, 8, 15, 0),
@@ -341,15 +341,15 @@ static const struct snd_kcontrol_new cs35l41_aud_controls[] = {
 		   CS35L41_MIXER_NGATE_CH1_CFG, 0, 7, 0),
 	SOC_SINGLE("Aux Noise Gate CH2 Entry Delay",
 		   CS35L41_MIXER_NGATE_CH2_CFG, 8, 15, 0),
-	SOC_SINGLE("Aux Noise Gate CH2 Enable",
+	SOC_SINGLE("Aux Noise Gate CH2 Switch",
 		   CS35L41_MIXER_NGATE_CH2_CFG, 16, 1, 0),
 	SOC_SINGLE("Aux Noise Gate CH2 Threshold",
 		   CS35L41_MIXER_NGATE_CH2_CFG, 0, 7, 0),
-	SOC_SINGLE("SCLK Force", CS35L41_SP_FORMAT, CS35L41_SCLK_FRC_SHIFT, 1, 0),
-	SOC_SINGLE("LRCLK Force", CS35L41_SP_FORMAT, CS35L41_LRCLK_FRC_SHIFT, 1, 0),
-	SOC_SINGLE("Invert Class D", CS35L41_AMP_DIG_VOL_CTRL,
+	SOC_SINGLE("SCLK Force Switch", CS35L41_SP_FORMAT, CS35L41_SCLK_FRC_SHIFT, 1, 0),
+	SOC_SINGLE("LRCLK Force Switch", CS35L41_SP_FORMAT, CS35L41_LRCLK_FRC_SHIFT, 1, 0),
+	SOC_SINGLE("Invert Class D Switch", CS35L41_AMP_DIG_VOL_CTRL,
 		   CS35L41_AMP_INV_PCM_SHIFT, 1, 0),
-	SOC_SINGLE("Amp Gain ZC", CS35L41_AMP_GAIN_CTRL,
+	SOC_SINGLE("Amp Gain ZC Switch", CS35L41_AMP_GAIN_CTRL,
 		   CS35L41_AMP_GAIN_ZC_SHIFT, 1, 0),
 	WM_ADSP2_PRELOAD_SWITCH("DSP1", 1),
 	WM_ADSP_FW_CONTROL("DSP1", 0),
-- 
2.30.2

