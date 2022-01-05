Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A166484DF5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 07:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiAEGEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 01:04:08 -0500
Received: from box.trvn.ru ([194.87.146.52]:45923 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237636AbiAEGEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 01:04:02 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 946F84206B;
        Wed,  5 Jan 2022 11:04:00 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1641362641; bh=7qZ33c7U2ffXr+klqsI55vzDEMsVG+TTv1mDnFLdpF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xjbLgN+GR0nr71wVMgAzLfLPuv0fFXKiRbZ2vynmWRPjKXm4heoU5aob/7NTjX2cB
         Cr3cxpPTh+WI19bjPSsF0Ottz0mvMVp6TBAXfvlueNMZSnS37O+RZSBMrmqEkG0G/i
         tBB0xKYoPvnWZ5h/WX34p8u/EcujbLNSelCfIg8VbLL+ysMx3VfddsA3GRxLMFHjal
         ys3gocG8OJXiK5d5ti37Syf7gpqLpioUCKUbCfHwunmKDhi7Hs843PyiZyfAAJ9AhH
         QfvnBuIXcWL1mBKM00RFJ70sLfTamVrDZfjaj2HjD1wU7ulWwgSqkgNVsRQQxzd/2u
         66ZAk/GutYOFQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, Michael.Srba@seznam.cz,
        linus.walleij@linaro.org, broonie@kernel.org, luca@z3ntu.xyz,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 4/6] input: zinitix: Add compatible for bt532
Date:   Wed,  5 Jan 2022 11:03:21 +0500
Message-Id: <20220105060323.7928-5-nikita@trvn.ru>
In-Reply-To: <20220105060323.7928-1-nikita@trvn.ru>
References: <20220105060323.7928-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zinitix BT532 is another touch controller that seem to implement the
same interface as an already supported BT541. Add it to the driver.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/input/touchscreen/zinitix.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/zinitix.c b/drivers/input/touchscreen/zinitix.c
index e84e4c3b1b3a..7c82c4f5fa6b 100644
--- a/drivers/input/touchscreen/zinitix.c
+++ b/drivers/input/touchscreen/zinitix.c
@@ -571,6 +571,7 @@ static SIMPLE_DEV_PM_OPS(zinitix_pm_ops, zinitix_suspend, zinitix_resume);
 
 #ifdef CONFIG_OF
 static const struct of_device_id zinitix_of_match[] = {
+	{ .compatible = "zinitix,bt532" },
 	{ .compatible = "zinitix,bt541" },
 	{ }
 };
-- 
2.30.2

