Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2375A47FB98
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbhL0Jq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235863AbhL0Jps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:45:48 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88AF2C0617A0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:45:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZU-0006YC-G3; Mon, 27 Dec 2021 10:45:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZS-006u8k-3n; Mon, 27 Dec 2021 10:45:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n1mZR-0005TM-20; Mon, 27 Dec 2021 10:45:33 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Patrick Havelange <patrick.havelange@essensium.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: [PATCH v2 02/23] counter: ftm-quaddec: Drop unused platform_set_drvdata()
Date:   Mon, 27 Dec 2021 10:45:05 +0100
Message-Id: <20211227094526.698714-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
References: <20211227094526.698714-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=Nuc6uojLK2l78VEJRC17DzBz/PbGGLv4T5mYODCGJkE=; m=qa0/nnsbHdKDuWY5QI5nC4IISJUbD9bjLmxbmrIZnvk=; p=IfE2j3nOQwuWinlapNulwSDtKLZYNVCeEO4YIGFLRlo=; g=7b74987636ca0013f74dda498ee0d0e05ddc7c66
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHJimEACgkQwfwUeK3K7AnMPAgAhUq WVuVT6YhuYp8sgdiMBobxnrSBgFpZSz72JmfmQuEPfkeO9kG7lOZbgeTVVVR3OerUmVmDvewIXUcl PZn6R5xxmD56slEor7NZkwZK+h0et1Be+q8sOzZzhQQZVuitPCZuk4+UUPsaHxChq1YkAz6fJnAWs UO4p1ZI+Br9WBbJYvnVyCRu7JcsiQKv3XDnEa4MlLReleQBxBv8T1XGvf/D7u5D2KJSaJafSQCNLr E+40d1RHuEVKSFhbmWoRWgWxQNPgD6YqT/9P8Z3Uc2wDEGK/sdiAWs9pmu6DoJ7f/rHIZlso+U2TF brWH3dGRJ8aYNW+B8w9nRFE8tLeFwww==
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

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/counter/ftm-quaddec.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index 5ef0478709cd..9272f7b58beb 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -269,8 +269,6 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 	if (!ftm)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, ftm);
-
 	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!io) {
 		dev_err(&pdev->dev, "Failed to get memory region\n");
-- 
2.33.0

