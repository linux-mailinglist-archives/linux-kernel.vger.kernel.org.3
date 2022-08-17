Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4874596E69
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239425AbiHQMYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiHQMYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:24:03 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3E9491DF
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:24:03 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HBro3U026619;
        Wed, 17 Aug 2022 07:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=hw05yTEBpCg1eF0uoWUssozLZPLdtapR5617P3hmzbM=;
 b=YZiK07evJYppCnBQN9ZiRked6cN4KMt0pzYaPN9bmvH7ln9CvJMl/o5bZ9OX+IC8NbGy
 6aF6VchooEOqm3nocHdBPS5inmIfn4rpWP4MpIh62jMbUIH2QbRYKOMSduVxu61AQyii
 nTEiftPGCWPPkA+N54Ae1bfeEpRr5kl5pBqtfFgYSh48RzfA+Gmk3s4xVgL1MnvwSf5e
 BSE5EasqGgThwj7X49Nr1Y+kPAbZs2m9bax+zMMGypMFDNoTtOovd/4w8PJIcL9F0qkY
 HUt5rGFsapHBoZ5qbQ65pirbiHb/YFNMmzTXHUyvZEfd1mwbfu+u0M2cT2go4QsR8P2Q uw== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpcueb-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 07:23:51 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 17 Aug
 2022 07:23:47 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Wed, 17 Aug 2022 07:23:47 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D7EFD7C;
        Wed, 17 Aug 2022 12:23:47 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 4/5] ASoC: cs42l42: Fix comment typo in cs42l42_slow_start_put()
Date:   Wed, 17 Aug 2022 13:23:46 +0100
Message-ID: <20220817122347.1356773-5-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817122347.1356773-1-rf@opensource.cirrus.com>
References: <20220817122347.1356773-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bwlO0wCL2w4iOvtaaE1caDFVOCu5u-HZ
X-Proofpoint-GUID: bwlO0wCL2w4iOvtaaE1caDFVOCu5u-HZ
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "much change together" to "must change together".

It's probably obvious what was meant but it's nice to fix it.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2235c17a0247..a84d873e29df 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -403,7 +403,7 @@ static int cs42l42_slow_start_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	u8 val;
 
-	/* all bits of SLOW_START_EN much change together */
+	/* all bits of SLOW_START_EN must change together */
 	switch (ucontrol->value.integer.value[0]) {
 	case 0:
 		val = 0;
-- 
2.30.2

