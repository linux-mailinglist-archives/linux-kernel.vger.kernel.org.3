Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC86656B61B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 11:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbiGHJ5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 05:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbiGHJ5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 05:57:41 -0400
Received: from out29-170.mail.aliyun.com (out29-170.mail.aliyun.com [115.124.29.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1A783F02
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 02:57:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5469381|-1;BR=01201311R151S63rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.11328-0.00592779-0.880792;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047190;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.ONXoFOV_1657274256;
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.ONXoFOV_1657274256)
          by smtp.aliyun-inc.com;
          Fri, 08 Jul 2022 17:57:37 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     myungjoo.ham@samsung.com, cw00.choi@samsung.com
Cc:     linux-kernel@vger.kernel.org,
        allwinner-opensource-support@allwinnertech.com
Subject: [PATCH] extcon: Add EXTCON_DISP_CVBS and EXTCON_DISP_EDP
Date:   Fri,  8 Jul 2022 17:57:14 +0800
Message-Id: <20220708095714.127736-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add EXTCON_DISP_CVBS for Composite Video Broadcast Signal.
Add EXTCON_DISP_EDP for Embedded Display Port

[1] https://en.wikipedia.org/wiki/Composite_video
[2] https://en.wikipedia.org/wiki/DisplayPort#eDP

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/extcon/extcon.c | 10 ++++++++++
 include/linux/extcon.h  |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
index d3a32b8064994..774607a616f7b 100644
--- a/drivers/extcon/extcon.c
+++ b/drivers/extcon/extcon.c
@@ -167,6 +167,16 @@ static const struct __extcon_info {
 		.id = EXTCON_DISP_HMD,
 		.name = "HMD",
 	},
+	[EXTCON_DISP_CVBS] = {
+		.type = EXTCON_TYPE_DISP,
+		.id = EXTCON_DISP_CVBS,
+		.name = "CVBS",
+	},
+	[EXTCON_DISP_EDP] = {
+		.type = EXTCON_TYPE_DISP,
+		.id = EXTCON_DISP_EDP,
+		.name = "EDP",
+	},
 
 	/* Miscellaneous external connector */
 	[EXTCON_DOCK] = {
diff --git a/include/linux/extcon.h b/include/linux/extcon.h
index 685401d94d398..3c45c3846fe94 100644
--- a/include/linux/extcon.h
+++ b/include/linux/extcon.h
@@ -76,6 +76,8 @@
 #define EXTCON_DISP_VGA		43	/* Video Graphics Array */
 #define EXTCON_DISP_DP		44	/* Display Port */
 #define EXTCON_DISP_HMD		45	/* Head-Mounted Display */
+#define EXTCON_DISP_CVBS	46	/* Composite Video Broadcast Signal */
+#define EXTCON_DISP_EDP		47	/* Embedded Display Port */
 
 /* Miscellaneous external connector */
 #define EXTCON_DOCK		60
-- 
2.29.0

