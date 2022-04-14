Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF37501A2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 19:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245757AbiDNRmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343561AbiDNRmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:42:43 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC16CBE65;
        Thu, 14 Apr 2022 10:40:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1649957997; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=oIzejjUmH+pgkTOsabERwvBmbs3BGw89sc/ntUWoXz8EQHqw3wB+A/0xJoA/vCK2UumCnYEAcEbao3swgKDnHG2xhOrXIA5RHK+ZI2ORSeRd86JU/L0Ag3d1HnPzGF0fsqnEzuAiCpa6kqAm7evUKxo7aIH6Bc9xGJEe6/Ki4uc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1649957997; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=8miZcTOH0rWiGd+6wcqTTPeMsb9x57xBzzuSkUegm3c=; 
        b=f79w8zfBqO6/kTe//cMnyz+lzO4KluiRk5WvpHKQK7PxQ4se+tOPdw7tDyE1KAlJ0XsjUTVpQJh1YBFeY6PyJiDUs5qRE9lSKHZ9YAt7OROctDH/Qi+rYrVyPyaYWgbqT1BPcko/LSI/02GzWM3kKXgH5Sex/4694n5z3TDzSgc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=arinc9.com;
        spf=pass  smtp.mailfrom=arinc.unal@arinc9.com;
        dmarc=pass header.from=<arinc.unal@arinc9.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1649957997;
        s=zmail; d=arinc9.com; i=arinc.unal@arinc9.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Reply-To;
        bh=8miZcTOH0rWiGd+6wcqTTPeMsb9x57xBzzuSkUegm3c=;
        b=WTi5pB8hmR93vNGwPpg59Oodh1g6+G1UJtC02v/QcxtfkxPcMW6EDTc8RGY1blxm
        bF6BRnuZW54/dn6HYom/HLyqpLvlHak3qs96RfDOkaBXxKpGPTaatR6adqEkbyM4FPD
        2cnE3CHdO/m/Ht/DP8adhgEXu2H7+mKFJn3S2zu8=
Received: from arinc9-PC.localdomain (85.117.236.245 [85.117.236.245]) by mx.zohomail.com
        with SMTPS id 1649957995568600.5755065695765; Thu, 14 Apr 2022 10:39:55 -0700 (PDT)
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Joe Perches <joe@perches.com>
Cc:     erkin.bozoglu@xeront.com,
        =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: [PATCH v2 04/14] pinctrl: ralink: rename pinctrl-rt288x to pinctrl-rt2880
Date:   Thu, 14 Apr 2022 20:39:06 +0300
Message-Id: <20220414173916.5552-5-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220414173916.5552-1-arinc.unal@arinc9.com>
References: <20220414173916.5552-1-arinc.unal@arinc9.com>
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
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
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

