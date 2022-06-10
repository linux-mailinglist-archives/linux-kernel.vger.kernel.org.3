Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3388A546F15
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350875AbiFJVNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350872AbiFJVNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:13:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8006246
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:13:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwP-0007ER-A1; Fri, 10 Jun 2022 23:13:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwL-007eRT-Kl; Fri, 10 Jun 2022 23:13:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwJ-00FTcl-JW; Fri, 10 Jun 2022 23:13:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mmc: dw_mmc: hi3789cv200: Obviously always return success in remove callback
Date:   Fri, 10 Jun 2022 23:12:54 +0200
Message-Id: <20220610211257.102071-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
References: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1161; h=from:subject; bh=viNGkUvqfRnsE+HfCQ1CcM0mjXBb4xEa/v9l9EqPujE=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBio7PJor4jUz6P2o8yDT2w2Hh3DDuDDinpPHs5VxyS RyGv8HWJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYqOzyQAKCRDB/BR4rcrsCXU1CA CN7Uwlar/bp45saE9xZ1+7fRHeDjz+HEiYwy4slkyCiavvs6H9oYugz/gvptadLy5rRAoRNAabMRCJ dvrpOwe9P1KU2y5bxX1N3u1o5AXCW5yIcQOI9FP+U4L6Ja0w0c4ciD7Kjrg21/38hahFA4Jax8+R32 f+v5KvgUY+2NYhediqPzH62pzzJKO0ZJFnsLcdK32UTXvmY8qZu0Cjv4inXtO9bsQjgEc6ykdoMNAw xMMGe9lMcIhYkRIfQtVLzDBcWAXLd86p4khn51qUzXEITCW6Q0d44KgywsAOlmrZmZw1ZZH+UeW0iu 6tB1vY9sSKWSc2Y39tffTexarJ0L00
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dw_mci_pltfm_remove() returns 0 unconditionally and returning an error
in a platform remove callback isn't very sensible. (The only effect of
the latter is that the device core emits a generic warning and then
removes the device anyhow.)

So return 0 unconditionally to make it obvious there is no error
forwarded to the upper layers.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mmc/host/dw_mmc-hi3798cv200.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
index e9437ef8ef19..6f22fe054087 100644
--- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
+++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
@@ -179,7 +179,9 @@ static int dw_mci_hi3798cv200_remove(struct platform_device *pdev)
 	clk_disable_unprepare(priv->drive_clk);
 	clk_disable_unprepare(priv->sample_clk);
 
-	return dw_mci_pltfm_remove(pdev);
+	dw_mci_pltfm_remove(pdev);
+
+	return 0;
 }
 
 static const struct of_device_id dw_mci_hi3798cv200_match[] = {
-- 
2.36.1

