Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE255781F0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiGRMOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbiGRMOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:14:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BFC1BEA2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 05:14:33 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPdh-0005dj-6e; Mon, 18 Jul 2022 14:14:17 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPdg-001i4I-A7; Mon, 18 Jul 2022 14:14:16 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oDPdf-005xVl-CK; Mon, 18 Jul 2022 14:14:15 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     kernel@pengutronix.de, Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] interconnect: imx: Make imx_icc_unregister() return void
Date:   Mon, 18 Jul 2022 14:14:09 +0200
Message-Id: <20220718121409.171773-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220718121409.171773-1-u.kleine-koenig@pengutronix.de>
References: <20220718121409.171773-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3164; h=from:subject; bh=7KukAtvH5Bq30kuEwIg28LJ8PMRL6qo8BHa0A2/HLbM=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi1U6L0VFV3l2yU6+MVs4rL1Au6U6sq+5+aOG/8TLT qP+54gSJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtVOiwAKCRDB/BR4rcrsCQAkB/ sExEC9/a27LpzoAmm9arvb2mSjacbH8owpFfCIgl8F7PQfxRwhHjc/VjVMcRUT/MeeZmW7PYgoTYQp ea0+dM9bMjLYCbwOcFUBJDta9yJkHl1YCMk5r/LqB8i61ZOrJF4XilbKfNHMk6uHkg/t3tPirVSIqA DRZAL6KBkXgczR0l3x8tOlWFRrhKu+xEN0jh5Ub+6oQoCfjCzYe2+z8PasllWb5KgkTjLMeWi3jEN8 TP7Wm38wOcOsMDTDgZ6Z0fCNFbD6J3uS48fb4baB2hZ36qLlOPzOddEfa7qtLGZ5m34Hq5/A6Y3xm6 6UYB8QCu+wKFP3YjFC4eXGhITtsIN3
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

