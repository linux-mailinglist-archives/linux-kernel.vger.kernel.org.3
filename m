Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8D6546F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 23:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350888AbiFJVNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 17:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350873AbiFJVNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 17:13:20 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359FE1139
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 14:13:19 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwM-0007ET-Sn; Fri, 10 Jun 2022 23:13:10 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwM-007eRc-2V; Fri, 10 Jun 2022 23:13:08 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nzlwJ-00FTcr-VC; Fri, 10 Jun 2022 23:13:07 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] mmc: sdhci-of-arasan: Obviously always return success in remove callback
Date:   Fri, 10 Jun 2022 23:12:56 +0200
Message-Id: <20220610211257.102071-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
References: <20220610211257.102071-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1514; h=from:subject; bh=4mF/yvCZvZim6IRItQzqfJKbygUWPODGaWd7tQugb+k=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBio7PPNwF0ygfJn1htE00Mxq3NiXsl6zlx8wuX0cxJ eectjlyJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYqOzzwAKCRDB/BR4rcrsCerCB/ 9+OmMxyxw27OjkgnbafMBIpF1tlL2OY2CljwjkaAYQyqpdm0oIKu1hHws6bGk/SmoDmhqWCa0aA5ek R2t74vDmN9NG3zhEEzWLoqTO++Qu4c4Y63Lj1i8mvX7Ktcq9Rmd513dPQD71ab+DrNX0iv6SvoCAaA Zqfna43Z8WBWc/wXXci61EtpgBUmtc/dZZzwcnAd6KUQcKTILnGN16NS9vI6tLcy0hYrts8k24e1AK yuRSMF+Ta1Ys/hUD98/z7xRHXL4ACmyfWLA/8QDUH9ZE82fgRWpmJynkb64owHbRdUIPBjegsMPFlY gCSTYby5QTn4WgcLZZ+mwc5RlF0R73
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

sdhci_pltfm_unregister() returns 0 unconditionally and returning an
error in a platform remove callback isn't very sensible. (The only
effect of the latter is that the device core emits a generic warning and
then removes the device anyhow.)

So return 0 unconditionally to make it obvious there is no error
forwarded to the upper layers.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/mmc/host/sdhci-of-arasan.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 757801dfc308..3997cad1f793 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -1733,7 +1733,6 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 static int sdhci_arasan_remove(struct platform_device *pdev)
 {
-	int ret;
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
@@ -1747,11 +1746,11 @@ static int sdhci_arasan_remove(struct platform_device *pdev)
 
 	sdhci_arasan_unregister_sdclk(&pdev->dev);
 
-	ret = sdhci_pltfm_unregister(pdev);
+	sdhci_pltfm_unregister(pdev);
 
 	clk_disable_unprepare(clk_ahb);
 
-	return ret;
+	return 0;
 }
 
 static struct platform_driver sdhci_arasan_driver = {
-- 
2.36.1

