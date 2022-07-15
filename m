Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CBA576843
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 22:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbiGOUhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 16:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiGOUhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 16:37:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC6384EFA
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 13:37:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3Z-0004u2-Sr; Fri, 15 Jul 2022 22:37:01 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3Z-001BFu-4w; Fri, 15 Jul 2022 22:37:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oCS3Y-005PyZ-3F; Fri, 15 Jul 2022 22:37:00 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] interconnect: imx: Make imx_icc_unregister() return void
Date:   Fri, 15 Jul 2022 22:36:52 +0200
Message-Id: <20220715203652.89912-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220715203652.89912-1-u.kleine-koenig@pengutronix.de>
References: <20220715203652.89912-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3164; h=from:subject; bh=7KukAtvH5Bq30kuEwIg28LJ8PMRL6qo8BHa0A2/HLbM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi0c+s0VFV3l2yU6+MVs4rL1Au6U6sq+5+aOG/8TLT qP+54gSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtHPrAAKCRDB/BR4rcrsCZtiB/ 9expsimli0HRq4gZeoNwXXHWa4FF8Vi+Gx33WCUGQSEO0uNn7xgHpwXJ+/OdUZHxEHtd91a/z8b6tp FokDkOWE43yZytFeV/ijQtsrKu0WWxqMjcNCrZYhFapYNwk0Qe3IKHexvcnLRcyuqc0BT5gMjv1jzI zt3OI5iATd75X93YPw/JRLHESRzvHkbZw5gTeQA5N2NE+Z1BpFZGFp1rSYQNaaQoJatKsThWL+U6OY 0Yleds6GaTdRLpIlBRszfuCDQSo2H5dQvK6TSaWuYqztHVh4NViL3/98u8C2ruw3Arxg1Pa/T/GXgc erOvv92Vkx41h9uTWkqj34Xwq2Nz8G
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function imx_icc_unregister() returns zero unconditionally. Make it
return void.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/interconnect/imx/imx.c    | 4 +---
 drivers/interconnect/imx/imx.h    | 2 +-
 drivers/interconnect/imx/imx8mm.c | 4 +++-
 drivers/interconnect/imx/imx8mn.c | 4 +++-
 drivers/interconnect/imx/imx8mq.c | 4 +++-
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/imx/imx.c b/drivers/interconnect/imx/imx.c
index 4c70530e3064..e96794acad59 100644
--- a/drivers/interconnect/imx/imx.c
+++ b/drivers/interconnect/imx/imx.c
@@ -274,15 +274,13 @@ int imx_icc_register(struct platform_device *pdev,
 }
 EXPORT_SYMBOL_GPL(imx_icc_register);
 
-int imx_icc_unregister(struct platform_device *pdev)
+void imx_icc_unregister(struct platform_device *pdev)
 {
 	struct icc_provider *provider = platform_get_drvdata(pdev);
 
 	imx_icc_unregister_nodes(provider);
 
 	icc_provider_del(provider);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(imx_icc_unregister);
 
diff --git a/drivers/interconnect/imx/imx.h b/drivers/interconnect/imx/imx.h
index 75da51076c68..b533c9a99710 100644
--- a/drivers/interconnect/imx/imx.h
+++ b/drivers/interconnect/imx/imx.h
@@ -56,6 +56,6 @@ struct imx_icc_node_desc {
 int imx_icc_register(struct platform_device *pdev,
 		     struct imx_icc_node_desc *nodes,
 		     int nodes_count);
-int imx_icc_unregister(struct platform_device *pdev);
+void imx_icc_unregister(struct platform_device *pdev);
 
 #endif /* __DRIVERS_INTERCONNECT_IMX_H */
diff --git a/drivers/interconnect/imx/imx8mm.c b/drivers/interconnect/imx/imx8mm.c
index 1083490bb391..fa9639c6ea37 100644
--- a/drivers/interconnect/imx/imx8mm.c
+++ b/drivers/interconnect/imx/imx8mm.c
@@ -88,7 +88,9 @@ static int imx8mm_icc_probe(struct platform_device *pdev)
 
 static int imx8mm_icc_remove(struct platform_device *pdev)
 {
-	return imx_icc_unregister(pdev);
+	imx_icc_unregister(pdev);
+
+	return 0;
 }
 
 static struct platform_driver imx8mm_icc_driver = {
diff --git a/drivers/interconnect/imx/imx8mn.c b/drivers/interconnect/imx/imx8mn.c
index ad97e55fd4e5..3b11571c23d0 100644
--- a/drivers/interconnect/imx/imx8mn.c
+++ b/drivers/interconnect/imx/imx8mn.c
@@ -77,7 +77,9 @@ static int imx8mn_icc_probe(struct platform_device *pdev)
 
 static int imx8mn_icc_remove(struct platform_device *pdev)
 {
-	return imx_icc_unregister(pdev);
+	imx_icc_unregister(pdev);
+
+	return 0;
 }
 
 static struct platform_driver imx8mn_icc_driver = {
diff --git a/drivers/interconnect/imx/imx8mq.c b/drivers/interconnect/imx/imx8mq.c
index d7768d3c6d8a..fb19b90d6767 100644
--- a/drivers/interconnect/imx/imx8mq.c
+++ b/drivers/interconnect/imx/imx8mq.c
@@ -87,7 +87,9 @@ static int imx8mq_icc_probe(struct platform_device *pdev)
 
 static int imx8mq_icc_remove(struct platform_device *pdev)
 {
-	return imx_icc_unregister(pdev);
+	imx_icc_unregister(pdev);
+
+	return 0;
 }
 
 static struct platform_driver imx8mq_icc_driver = {
-- 
2.36.1

