Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F0D4FEF77
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbiDMGLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232949AbiDMGLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:11:02 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B7335AB2;
        Tue, 12 Apr 2022 23:08:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649830093; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HxLN/QLiCQ+RM6poc5lMejJm/4ZE30uuKJtac4LBa1V5YIJiCAFr7c3FRINtYpOmVJ09lRCoZRWkwJFuSAuSMk3hVHW15DGFA2NN0j9gRAOsUzks0FK1QV2508o2gYDJGh0Bpzs6Ps06ZKvhq4NvL1CG2w1+2I9vKBlwLOIf+8Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649830093; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=T64RVpELLCvs3awQZyxnL3gIGoe8/MngxdFI+qg8tng=; 
        b=j4KarLreEyuMgIcdcwe2dS62HthogvLpttpVLbqA3j1WcOGMEZSa6f+y7eWQjkXkBnnQnRf5E5/LyVB5qTwTgyCTetG0jTyYBIr1ey8iN2YwQUYscYXqTjJmrZBfb5M1Ky2C0lpl8SYQwJ2lXQZtzG6kyCHsm/P3Jr3ICkPiMJ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649830093;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=T64RVpELLCvs3awQZyxnL3gIGoe8/MngxdFI+qg8tng=;
        b=e1EJZvnsBx/+I/0ypgPmYvIjoMsAMQlAgjEYb44dH+dPy/0muQhz9ryLoS2z4YTo
        frPnjctYfZDuyWJR0Ro4xoXc6DReXNVxVDKP/pb2jP85AXYPgc8YpGzbVrh5I/pC6hN
        HMYAzP2FnI7wWwcNZXaAzGrJ30zduakDpChYxFPM=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649830092041237.3768558657706; Tue, 12 Apr 2022 23:08:12 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH 04/14] pinctrl: ralink: rename pinctrl-rt288x to pinctrl-rt2880
Date:   Wed, 13 Apr 2022 09:07:19 +0300
Message-Id: <20220413060729.27639-5-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413060729.27639-1-arinc.unal@arinc9.com>
References: <20220413060729.27639-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename "pinctrl-rt288x.c" to "pinctrl-rt2880.c" as this is the Ralink
RT2880 pinctrl subdriver. Rename PINCTRL_RT288X symbol to PINCTRL_RT2880.
Rename functions that include "rt288x" to "rt2880".

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/pinctrl/ralink/Kconfig                 |  4 ++--
 drivers/pinctrl/ralink/Makefile                |  2 +-
 .../{pinctrl-rt288x.c => pinctrl-rt2880.c}     | 18 +++++++++---------
 3 files changed, 12 insertions(+), 12 deletions(-)
 rename drivers/pinctrl/ralink/{pinctrl-rt288x.c => pinctrl-rt2880.c} (78%)

diff --git a/drivers/pinctrl/ralink/Kconfig b/drivers/pinctrl/ralink/Kconfig
index d0f0a8f2b9b7..aa82acfae827 100644
--- a/drivers/pinctrl/ralink/Kconfig
+++ b/drivers/pinctrl/ralink/Kconfig
@@ -17,8 +17,8 @@ config PINCTRL_MT7621
         depends on RALINK && SOC_MT7621
         select PINCTRL_RALINK
 
-config PINCTRL_RT288X
-        bool "RT288X pinctrl driver for RALINK/Mediatek SOCs"
+config PINCTRL_RT2880
+        bool "RT2880 pinctrl driver for RALINK/Mediatek SOCs"
         depends on RALINK && SOC_RT288X
         select PINCTRL_RALINK
 
diff --git a/drivers/pinctrl/ralink/Makefile b/drivers/pinctrl/ralink/Makefile
index 2c1323b74e96..0ebbe552526d 100644
--- a/drivers/pinctrl/ralink/Makefile
+++ b/drivers/pinctrl/ralink/Makefile
@@ -3,6 +3,6 @@ obj-$(CONFIG_PINCTRL_RALINK)   += pinctrl-ralink.o
 
 obj-$(CONFIG_PINCTRL_MT7620)   += pinctrl-mt7620.o
 obj-$(CONFIG_PINCTRL_MT7621)   += pinctrl-mt7621.o
-obj-$(CONFIG_PINCTRL_RT288X)   += pinctrl-rt288x.o
+obj-$(CONFIG_PINCTRL_RT2880)   += pinctrl-rt2880.o
 obj-$(CONFIG_PINCTRL_RT305X)   += pinctrl-rt305x.o
 obj-$(CONFIG_PINCTRL_RT3883)   += pinctrl-rt3883.o
diff --git a/drivers/pinctrl/ralink/pinctrl-rt288x.c b/drivers/pinctrl/ralink/pinctrl-rt2880.c
similarity index 78%
rename from drivers/pinctrl/ralink/pinctrl-rt288x.c
rename to drivers/pinctrl/ralink/pinctrl-rt2880.c
index db5c09ed5601..9c5e828af43a 100644
--- a/drivers/pinctrl/ralink/pinctrl-rt288x.c
+++ b/drivers/pinctrl/ralink/pinctrl-rt2880.c
@@ -34,27 +34,27 @@ static struct ralink_pmx_group rt2880_pinmux_data_act[] = {
 	{ 0 }
 };
 
-static int rt288x_pinctrl_probe(struct platform_device *pdev)
+static int rt2880_pinctrl_probe(struct platform_device *pdev)
 {
 	return ralink_pinctrl_init(pdev, rt2880_pinmux_data_act);
 }
 
-static const struct of_device_id rt288x_pinctrl_match[] = {
+static const struct of_device_id rt2880_pinctrl_match[] = {
 	{ .compatible = "ralink,rt2880-pinmux" },
 	{}
 };
-MODULE_DEVICE_TABLE(of, rt288x_pinctrl_match);
+MODULE_DEVICE_TABLE(of, rt2880_pinctrl_match);
 
-static struct platform_driver rt288x_pinctrl_driver = {
-	.probe = rt288x_pinctrl_probe,
+static struct platform_driver rt2880_pinctrl_driver = {
+	.probe = rt2880_pinctrl_probe,
 	.driver = {
 		.name = "rt2880-pinmux",
-		.of_match_table = rt288x_pinctrl_match,
+		.of_match_table = rt2880_pinctrl_match,
 	},
 };
 
-static int __init rt288x_pinctrl_init(void)
+static int __init rt2880_pinctrl_init(void)
 {
-	return platform_driver_register(&rt288x_pinctrl_driver);
+	return platform_driver_register(&rt2880_pinctrl_driver);
 }
-core_initcall_sync(rt288x_pinctrl_init);
+core_initcall_sync(rt2880_pinctrl_init);
-- 
2.25.1

