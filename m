Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B739596E68
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 14:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239440AbiHQMYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 08:24:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiHQMYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 08:24:07 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBD84B0C0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 05:24:06 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HBro3T026619;
        Wed, 17 Aug 2022 07:23:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=xQ3qvl9IMuy/CeupuXMZunDSLtXwsJGURkPujaWBUU0=;
 b=XFSQX9Yr+vUpg5KZK/AbF+IOT2pQDvuD90KZj38i7U5pZNgzXfuEZWyAnUyPMFoDMvxn
 98wkx0fGurxAXcvuJsAoJjRiTClgT4R+o/683GtzGHK1lti8/oTyl+lzPO5xi4ClUpAI
 +UjEZkep3lTNna9pv4LSxd+xPAs6TpfJxaOwzzYFG52J5vNzAiINXxoc64LaDKplkL+P
 EkSwskT6KBSkhSIDSH5SzAhf16ncax326NjDOOR5h5AZIlLhfpnVqr8VvSDAew1XdM0L
 VQ3PdQWrwVKLc7dbw2GWrPkrNtn73fk0Vxp/kNW1YOHZ8HzBviXMvTVCM+A+TRlif5mo UQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3hx8cpcueb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 07:23:50 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Wed, 17 Aug
 2022 07:23:47 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.9 via Frontend
 Transport; Wed, 17 Aug 2022 07:23:47 -0500
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.95])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B9BE6B0E;
        Wed, 17 Aug 2022 12:23:47 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/5] ASoC: cs42l42: Add include dependencies to cs42l42.h
Date:   Wed, 17 Aug 2022 13:23:44 +0100
Message-ID: <20220817122347.1356773-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220817122347.1356773-1-rf@opensource.cirrus.com>
References: <20220817122347.1356773-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: A17s6qErAzGztvenkHtPWOst6oX6nLOc
X-Proofpoint-GUID: A17s6qErAzGztvenkHtPWOst6oX6nLOc
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

Make cs42l42.h include the other headers it depends on instead of
assuming that the .c file already included them.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.h b/sound/soc/codecs/cs42l42.h
index 5f50970375d4..1d53e0e050ee 100644
--- a/sound/soc/codecs/cs42l42.h
+++ b/sound/soc/codecs/cs42l42.h
@@ -12,7 +12,12 @@
 #ifndef __CS42L42_H__
 #define __CS42L42_H__
 
+#include <dt-bindings/sound/cs42l42.h>
+#include <linux/device.h>
+#include <linux/gpio.h>
 #include <linux/mutex.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <sound/jack.h>
 #include <sound/cs42l42.h>
 
-- 
2.30.2

