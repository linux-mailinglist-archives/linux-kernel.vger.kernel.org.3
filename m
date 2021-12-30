Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86226481D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbhL3PDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240572AbhL3PDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:03:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35D3C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 07:03:09 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxP-0000cL-0V; Thu, 30 Dec 2021 16:03:07 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxL-007VKa-Rc; Thu, 30 Dec 2021 16:03:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n2wxK-0007g8-Kw; Thu, 30 Dec 2021 16:03:02 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Kamel Bouhara <kamel.bouhara@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 03/23] counter: microchip-tcb-capture: Drop unused platform_set_drvdata()
Date:   Thu, 30 Dec 2021 16:02:40 +0100
Message-Id: <20211230150300.72196-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
References: <20211230150300.72196-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=861; h=from:subject; bh=p8o8yROvlaWuN65D0M/ICHbvt+4EVEiwwzlgD5lBUF4=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBhzclYtICPBJku7BznPEoouEXs97mwzEf5mCrgFmTb 63gwHECJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYc3JWAAKCRDB/BR4rcrsCdVwB/ 9kYXdqlR7oYMwKLC1HbQQdklDRe/AWs7zoRCZHZHG88a2UMqpCbMJVuSlEJN/kSb9W/FS7RBXLyEQF 0ihPxn69N2IhqndrMpuBELPmnR6s0EUgOSA+cQCNfcHfXrWDzecEHpOfBaStwIqOPWtawbI4HOLXYB Q5A6H/FBYQa3+UzjUd70fSTEox3j2x4kWFt+jddMN6beuXvZc0NL5QineXHBnEQY8ccHRiM6mGEgc2 Gzo2jvC+gBy1++ps3xCY2RZpiKi+Y6dLBTyPUnhhzdtmyuDsy63IQOwc+ZCM+cWAAmdPM4xLjBtYh0 3pzuC5lxv8dcxq+5N/CcYvzcOlksML
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver doesn't ever use platform_get_drvdata, so drop this unused
call.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/microchip-tcb-capture.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index 0ab1b2716784..bb69f2e0ba93 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -307,8 +307,6 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, priv);
-
 	match = of_match_node(atmel_tc_of_match, np->parent);
 	tcb_config = match->data;
 	if (!tcb_config) {
-- 
2.34.1

