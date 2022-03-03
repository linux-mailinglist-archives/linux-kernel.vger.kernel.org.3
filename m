Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8374CC3F7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiCCRda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235655AbiCCRcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:32:55 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD15919E0B8;
        Thu,  3 Mar 2022 09:31:54 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223509T2013880;
        Thu, 3 Mar 2022 11:31:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=4eGzIDYtnF1ZJ7ItCxqOSnRC0d6QLyqAmjli4+VrIM4=;
 b=LuPbN9hsZRet/dmn/kH38mErDCQRrlIAWn2NlJf+KQySd1Jh2DoPuXSEhQ84YPrrgVg/
 NvSVkdGjN31stihZ5Ph4r+9tAwLfyRcyBG3vEZ4BpUUW13eMJ9S25j+bGd+QyocgW2nU
 rZni9sPBViBOnFE/OFoKffKt4qmnH4sPaYbdT46BagfWVU1IsHkwertbXopqHo+tgTin
 K7exULuIjR2GOgzZnzZIJmdZpyJu21h41K4BQi8uxVf4w1fgwi1SoM5XYV+36+ZCJXMQ
 H36ggTBoBNwjyUMvIKcrWXKeBcAdl+IrOaF7sbWtb+GDnZcnvoG/eu81hKAQvcVDM3gW MA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8ybn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Mar 2022 11:31:05 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:31:04 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Thu, 3 Mar 2022 17:31:04 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id BBB242A1;
        Thu,  3 Mar 2022 17:31:03 +0000 (UTC)
From:   Lucas Tanure <tanureal@opensource.cirrus.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: [PATCH 04/20] ASoC: cs35l41: Remove unnecessary param
Date:   Thu, 3 Mar 2022 17:30:43 +0000
Message-ID: <20220303173059.269657-5-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: RBm-16dzIMir7j9eIV36zMW3CPgjb9Oh
X-Proofpoint-GUID: RBm-16dzIMir7j9eIV36zMW3CPgjb9Oh
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cs35l41_private is not used on cs35l41_handle_pdata

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index 05de94fd2e55..6b784a62df0c 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -1115,9 +1115,7 @@ static const struct snd_soc_component_driver soc_component_dev_cs35l41 = {
 	.set_sysclk = cs35l41_component_set_sysclk,
 };
 
-static int cs35l41_handle_pdata(struct device *dev,
-				struct cs35l41_platform_data *pdata,
-				struct cs35l41_private *cs35l41)
+static int cs35l41_handle_pdata(struct device *dev, struct cs35l41_platform_data *pdata)
 {
 	struct cs35l41_irq_cfg *irq_gpio1_config = &pdata->irq_config1;
 	struct cs35l41_irq_cfg *irq_gpio2_config = &pdata->irq_config2;
@@ -1260,7 +1258,7 @@ int cs35l41_probe(struct cs35l41_private *cs35l41,
 	if (pdata) {
 		cs35l41->pdata = *pdata;
 	} else {
-		ret = cs35l41_handle_pdata(cs35l41->dev, &cs35l41->pdata, cs35l41);
+		ret = cs35l41_handle_pdata(cs35l41->dev, &cs35l41->pdata);
 		if (ret != 0)
 			return ret;
 	}
-- 
2.35.1

