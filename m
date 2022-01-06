Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83C5E486102
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 08:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbiAFH3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 02:29:45 -0500
Received: from box.trvn.ru ([194.87.146.52]:54145 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235746AbiAFH3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 02:29:40 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 664184A109;
        Thu,  6 Jan 2022 12:29:07 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1641454147; bh=7qZ33c7U2ffXr+klqsI55vzDEMsVG+TTv1mDnFLdpF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qskUSr4qks9ZWq+TaEFvMs0ojFVfL/ybptyevOazcelP6LDzr4I3/1Oo4ze1zhzDx
         livPOZ/Ssx4Rak0fvxmo42NGpQBLPO6o+728081m+/fzT9iY5nqW+6NQ71ZdvAKJSn
         bJckYlO+obVKCgHVoBWzb2BujZCiZ80DwttCGOghI0cyY50CrU5uiWBzz+3lb3YIfK
         YTMBobest9y/KSzzsoMzrJdl1cZJWgdBjJxLTfTaPA9CG3Zez3cX5kY5YxjhXukdfF
         nwh/jLFtGe6zmkOIKacjVI0O8nCNeUwa7obPeOMSUtZ8U/IomOEZKTRQbY7z9cpSZJ
         myh2p3NIsUEnQ==
From:   Nikita Travkin <nikita@trvn.ru>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, Michael.Srba@seznam.cz,
        linus.walleij@linaro.org, broonie@kernel.org, luca@z3ntu.xyz,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v3 4/6] input: zinitix: Add compatible for bt532
Date:   Thu,  6 Jan 2022 12:28:38 +0500
Message-Id: <20220106072840.36851-5-nikita@trvn.ru>
In-Reply-To: <20220106072840.36851-1-nikita@trvn.ru>
References: <20220106072840.36851-1-nikita@trvn.ru>
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

