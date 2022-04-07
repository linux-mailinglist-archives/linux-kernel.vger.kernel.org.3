Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F9A4F83AB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344872AbiDGPkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344858AbiDGPkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:40:39 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BBB1B7B4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:38:35 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 237FGtj7010987;
        Thu, 7 Apr 2022 10:38:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=UjykvzUh2yttPVC3FFI1GJ+d5P2prlyxQC8ykG4n7sQ=;
 b=fRJvXqN8Wu6nZ+GIXmhS2fn10nWnylZl+cv9hyK0piv+ipqkZrkMii2sGEsr4uvzOscn
 9GxXTJjLSg+5++q0vdWEkpBWdDUD2jYdhVTdSAm8rlGGCh5Fnwd3W9SFAPGv0O6wQQBf
 CEd4BAsssW0L6I5JuF3FykaZgXyilMn4suGFYrBYFqwIhCM5BhLRMjzzDSozrXvxUEBn
 oDcSHnFZtsdCOajRfZdy7BBqwqxw5UgL2rNxkrCr8g/eRAPyTgV50ZmO6Br/3WIvgzfZ
 iPCbf8ARAraeU3uoG9w0K2avvZP1AIU5wzxdcIGTl84i/JOqRhMblepvZQGWe20gvn6+ 4Q== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3f6jwnxnvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 07 Apr 2022 10:38:18 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 7 Apr
 2022 16:38:17 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.24 via Frontend
 Transport; Thu, 7 Apr 2022 16:38:17 +0100
Received: from AUSNPC0LSNW1-debian.cirrus.com (AUSNPC0LSNW1.ad.cirrus.com [198.61.65.88])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1230946A;
        Thu,  7 Apr 2022 15:38:16 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <peter.ujfalusi@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <ranjani.sridharan@linux.intel.com>
CC:     <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: SOF: Kconfig: Make SND_SOC_SOF_HDA_PROBES tristate
Date:   Thu, 7 Apr 2022 16:38:13 +0100
Message-ID: <20220407153813.1231866-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: B4yOzWpazVgc6L5sHf2qOyFj5y7r6tbT
X-Proofpoint-GUID: B4yOzWpazVgc6L5sHf2qOyFj5y7r6tbT
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

SND_SOC_SOF_HDA_PROBES must be tristate because the code it builds
depends on code that is tristate.

If SND_SOC_SOF_HDA_PROBES is bool it leads to the following build
inconsistency:

SND_SOC_SOF_HDA_COMMON=m
  which selects SND_SOC_SOF_HDA_PROBES
    but since this is a bool SND_SOC_SOF_HDA_PROBES=y

SND_SOC_SOF_HDA_PROBES=y
  selects SND_SOC_SOF_DEBUG_PROBES=y
    so sof-client-probes.c is built into the kernel.

sof-client-probes.c calls functions in sof-client.c, but

SND_SOC_SOF=m
  sof-client.c is built into a loadable module.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/sof/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 172419392b33..0def2aa5581d 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -260,7 +260,7 @@ config SND_SOC_SOF_HDA
 	  'select' statements at a higher level.
 
 config SND_SOC_SOF_HDA_PROBES
-	bool
+	tristate
 	select SND_SOC_SOF_DEBUG_PROBES
 	help
 	  The option enables the data probing for Intel(R) Skylake and newer
-- 
2.30.2

