Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F76549C83
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343567AbiFMTAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244572AbiFMS7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:59:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFDC43AE6
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 09:16:18 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DBuxUh006945;
        Mon, 13 Jun 2022 11:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=oaA7oUhxhYUv3GT9ya+N4kfY6bFaVDi56FfyAbH3CmY=;
 b=TGsnFcqGzzZtTnHDKYCMYRBijkKHSpjBSY5vb/RMpXj1vXoOgQTYsDCIiWVcGO3OsD2l
 eWo15uyZNjCYVraF6AgYar1i6YQWduzXtVE5qop3cegmdixRsNkNPiElDP7h2sEpooXr
 VeSbIyOBa+HEs/ZjE+pmWx7XxpvN6O0reA7lRJdSRsN6tYY2hiQDxfkTgkwwhBuMQby+
 tcHdz5pS7H53eaA234Mrfy/IjGJV0s+3pOFWhb7xPppyvZPbNo5+QTvJYpRewuLNPx11
 ugAw56x4rlr9cZ43MhqHXyKATg9j/ffLvNXtqi4AITGLMeHjI/23DWpjwelr15RvhVUd jQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gmqfq24mu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Jun 2022 11:15:54 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 17:15:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 13 Jun 2022 17:15:52 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D5098458;
        Mon, 13 Jun 2022 16:15:52 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <broonie@kernel.org>, <samuel@sholland.org>
CC:     <matthias.bgg@gmail.com>, <wens@csie.org>,
        <jernej.skrabec@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-sunxi@lists.linux.dev>, <lgirdwood@gmail.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: mediatek: mt8186: Use new direct clock defines
Date:   Mon, 13 Jun 2022 17:15:52 +0100
Message-ID: <20220613161552.481337-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613161552.481337-1-ckeepax@opensource.cirrus.com>
References: <20220613161552.481337-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: l8ShZbS2HEhRTIrTc26Mw8OO2G2WDCou
X-Proofpoint-GUID: l8ShZbS2HEhRTIrTc26Mw8OO2G2WDCou
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update this driver to the new direct clock producer/consumer defines. It
appears this driver was added with the inversion taken account of but
still uses the CODEC defines so no inversion of the producer/consumer
is necessary.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---

Note this patch is completely untested, I don't have hardware and the
mt8186 doesn't seem to be included in any makefiles at the moment so I
can't build test either. But the change is trivial and I am pretty
confident I have read the code correctly. It would be good if someone
from Mediatek could have a quick look over though.

Thanks,
Charles

 sound/soc/mediatek/mt8186/mt8186-dai-tdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
index dfff209b60da4..c6ead7c252f01 100644
--- a/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
+++ b/sound/soc/mediatek/mt8186/mt8186-dai-tdm.c
@@ -585,10 +585,10 @@ static int mtk_dai_tdm_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
-	case SND_SOC_DAIFMT_CBP_CFP:
+	case SND_SOC_DAIFMT_BP_FP:
 		tdm_priv->slave_mode = false;
 		break;
-	case SND_SOC_DAIFMT_CBC_CFC:
+	case SND_SOC_DAIFMT_BC_FC:
 		tdm_priv->slave_mode = true;
 		break;
 	default:
-- 
2.30.2

