Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B74495387B6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 21:25:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbiE3TZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 15:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233280AbiE3TZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 15:25:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DCE27CF7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 12:25:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0i-0002B6-1a; Mon, 30 May 2022 21:25:04 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0i-005Vcr-MP; Mon, 30 May 2022 21:25:03 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nvl0g-00D9rw-0T; Mon, 30 May 2022 21:25:02 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] mfd: t7l66xb: Drop platform disable callback
Date:   Mon, 30 May 2022 21:24:28 +0200
Message-Id: <20220530192430.2108217-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
References: <20220530192430.2108217-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1967; h=from:subject; bh=KLS92mnV4uioYj/VXMUTsR46ZBmBliG9+/eL2gP9ruw=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBilRnXL6djC0HTLnCmADRIVxAOSHSiiZ6SBlf3VJfo CiWeBBOJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYpUZ1wAKCRDB/BR4rcrsCfDsB/ wLoUOUI8uudFz8mpFN+y9dH9kL85D3x7wUOkeky3+K8KTiTJwNHoLA1nNDxYXG89rJgLEoWguFDTY2 yQglOdlnrvK3StcEEBHEDlV7K53macBN73DyFCMGpaw+lnmxnMNqazQJNFbl7L+0ekAAFFwPcpmyrH An3CdQZVd8RedcFYi897xtwhD1sS6ZhcciNAwyAt4cAWMV6xOdyTFVC47nGyviJm/hSytgRTxSxVtD /rLSKuvsNT/KWctVvj5kDYwpyrVf7xJBUdOkXWhzfK+4tx1ljZwxqZvcdo//g4NWKVHTZk1td4kxfu Xfcd3oSP68pNo5tHQXMVzJuFxWOz6W
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the in-tree instantiations of struct t7l66xb_platform_data
provides a disable callback. So better don't dereference this function
pointer unconditionally. As there is no user, drop it completely instead
of calling it conditional.

This is a preparation for making platform remove callbacks return void.

Fixes: 1f192015ca5b ("mfd: driver for the T7L66XB TMIO SoC")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Technically this fixes the first commit introducing a struct
t7l66xb_platform_data without a disable callback, but ...
---
 drivers/mfd/t7l66xb.c       | 6 +-----
 include/linux/mfd/t7l66xb.h | 1 -
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mfd/t7l66xb.c b/drivers/mfd/t7l66xb.c
index 5369c67e3280..663ffd4b8570 100644
--- a/drivers/mfd/t7l66xb.c
+++ b/drivers/mfd/t7l66xb.c
@@ -397,11 +397,8 @@ static int t7l66xb_probe(struct platform_device *dev)
 
 static int t7l66xb_remove(struct platform_device *dev)
 {
-	struct t7l66xb_platform_data *pdata = dev_get_platdata(&dev->dev);
 	struct t7l66xb *t7l66xb = platform_get_drvdata(dev);
-	int ret;
 
-	ret = pdata->disable(dev);
 	clk_disable_unprepare(t7l66xb->clk48m);
 	clk_put(t7l66xb->clk48m);
 	clk_disable_unprepare(t7l66xb->clk32k);
@@ -412,8 +409,7 @@ static int t7l66xb_remove(struct platform_device *dev)
 	mfd_remove_devices(&dev->dev);
 	kfree(t7l66xb);
 
-	return ret;
-
+	return 0;
 }
 
 static struct platform_driver t7l66xb_platform_driver = {
diff --git a/include/linux/mfd/t7l66xb.h b/include/linux/mfd/t7l66xb.h
index 69632c1b07bd..ae3e7a5c5219 100644
--- a/include/linux/mfd/t7l66xb.h
+++ b/include/linux/mfd/t7l66xb.h
@@ -12,7 +12,6 @@
 
 struct t7l66xb_platform_data {
 	int (*enable)(struct platform_device *dev);
-	int (*disable)(struct platform_device *dev);
 	int (*suspend)(struct platform_device *dev);
 	int (*resume)(struct platform_device *dev);
 
-- 
2.36.1

