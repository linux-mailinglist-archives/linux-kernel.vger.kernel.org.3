Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47FB5546F1C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350920AbiFJVNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350884AbiFJVNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:13:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87CEC21AC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:13:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwP-0007EQ-A1; Fri, 10 Jun 2022 23:13:13 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwL-007eRR-K2; Fri, 10 Jun 2022 23:13:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwJ-00FTci-D7; Fri, 10 Jun 2022 23:13:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     kernel@pengutronix.de, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mmc: dw_mmc: exynos: Obviously always return success in remove callback
Date:   Fri, 10 Jun 2022 23:12:53 +0200
Message-Id: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171; h=from:subject; bh=BRwj7xwGwlRzPBbTfi1y6IsL5WQeCl3kon3cuPiA4x8=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBio7PFmJ2wmL2gWS1HcC1y6c3VYDRsXBzbViHOxx0m f/APl0eJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYqOzxQAKCRDB/BR4rcrsCcIOB/ 9jMfHMsc6Uy0I1iYhcfcv3qVW6zLOx71pr6WjFWokedg82aakk2yg6YD3SYFm0peyZ3gvIoYceuyH6 q4u5fIa6CzL1iORfXmFd4DHJIaOWQZ604o54ZGUdJFv7kcWdKjd7tiLHreOrmRG+mwxvZsZL5u+pp1 RNsxOckrqNwdHEPjTg6yqunaUBwrZ+ruzOM2eDn7lxiczsaUuDVkrTAh0zP/kaEnTVpXxAy0oyl2Fz FvGHFh6B0BuQgZxP/eaxEtK5MCHaegv9wYnzBOSgvBjTBVuyyL8vjBWd0Eql9rloW3UusMJBSJGF8T Hj96drPuyQMmqsOwW4YUsjVn2aPM0f
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
 drivers/mmc/host/dw_mmc-exynos.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index ca5be4445ae0..9f20ac524c8b 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -670,7 +670,9 @@ static int dw_mci_exynos_remove(struct platform_device *pdev)
 	pm_runtime_set_suspended(&pdev->dev);
 	pm_runtime_put_noidle(&pdev->dev);
 
-	return dw_mci_pltfm_remove(pdev);
+	dw_mci_pltfm_remove(pdev);
+
+	return 0;
 }
 
 static const struct dev_pm_ops dw_mci_exynos_pmops = {

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.36.1

