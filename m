Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B76546F1E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350910AbiFJVNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350885AbiFJVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:13:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C012959D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:13:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwP-0007ES-Kg; Fri, 10 Jun 2022 23:13:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwM-007eRZ-0b; Fri, 10 Jun 2022 23:13:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwJ-00FTco-PH; Fri, 10 Jun 2022 23:13:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     kernel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] mmc: dw_mmc: rockchip: Obviously always return success in remove callback
Date:   Fri, 10 Jun 2022 23:12:55 +0200
Message-Id: <20220610211257.102071-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
References: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; h=from:subject; bh=X7sBJEOoF/EYAe4rLWNuktAtosW9B7BT2XqynC8bowU=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBio7PMozMORTXicDL+cWiZL0+Ts8EeeJIr5sgKtzDj DWI0AU+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYqOzzAAKCRDB/BR4rcrsCbr8B/ 4ww4MPsxCrFYZhS1rElYQwerv5C4lY5BjWqgaBlcfsraeppQaP3NeMAtMU8YGxvP9lldcNhQqsg1Zg B57X+QdbcI2rv0HmXmMqmYWkX/UM0RYx7I/Y5r5qSwKQMPOBqOfO3029045FWVIadBfGBdGbgBdLww +CjUaCrqJ+vLzDc82IF03Q/704NBHMBwhClKK2XoSsKWamtnzlwTbYMI3oY+S0qHlKCQMCg5W7gWUp XnWLvmw1JBRu7Peru8eGNWTfilc6Yn3PP5tb5CBDkPZfLx0DKjOmskOSAbXHfA+gd9yU3RInfwlTfK bsO36Y+eUJ1xkr3eY5zxqU2HvakH99
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
 drivers/mmc/host/dw_mmc-rockchip.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index f825487aa739..2a99f15f527f 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -377,7 +377,9 @@ static int dw_mci_rockchip_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-	return dw_mci_pltfm_remove(pdev);
+	dw_mci_pltfm_remove(pdev);
+
+	return 0;
 }
 
 static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
-- 
2.36.1

