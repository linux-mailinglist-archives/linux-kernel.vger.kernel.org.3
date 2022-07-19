Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8077457A80C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240168AbiGSUIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240071AbiGSUIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:08:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4268E27164;
        Tue, 19 Jul 2022 13:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658261317; x=1689797317;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FasC4V80K7TyyLJEQ5bRDbhHy1iDPFBH5XCAovlrHe8=;
  b=vd4UxhSwLJ4lkFzHkNweQqm1NkvrT3pfEYqfhjpsTUQFcQd3FKb/LEwc
   KV9JlI0L3AOsqiQBqD8idujCiBrnRGnSGnpJZy7oksv6NmnmYDNE4li7Q
   EpE+GVdFUeq+imzAXQUvPmMH9GXgeX80+mNZpuox8cRErR6hLXjnyMTKV
   cu6Pmh29uU6a13ZcuEKZMzYH4rOnv1DEOmep0jSxYfnHEawDT+zJ0bGKq
   /CF8WSCs60qvVnx7xmJ3jrqk5tTZLg/YOyTYgsG8CGzxir20+jIs0v1U3
   eV4Ny/0+aTDHEsTadFN1LswLgfdwL+/5fL7SwLdfntINlxAMIFzH8pW+O
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="105217576"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Jul 2022 13:08:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 19 Jul 2022 13:08:36 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 19 Jul 2022 13:08:34 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <claudiu.beznea@microchip.com>, <nicolas.ferre@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <maxime.chevallier@bootlin.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH v2 3/3] ARM: dts: lan966x: Enable network driver on pcb8291
Date:   Tue, 19 Jul 2022 22:11:58 +0200
Message-ID: <20220719201158.1696168-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220719201158.1696168-1-horatiu.vultur@microchip.com>
References: <20220719201158.1696168-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pcb8291 has 2 ports that are connected to the internal ports
of the switch. Enable them in DT.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 arch/arm/boot/dts/lan966x-pcb8291.dts | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts b/arch/arm/boot/dts/lan966x-pcb8291.dts
index ab80558de259..228ae16e4737 100644
--- a/arch/arm/boot/dts/lan966x-pcb8291.dts
+++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
@@ -4,6 +4,7 @@
  */
 /dts-v1/;
 #include "lan966x.dtsi"
+#include "dt-bindings/phy/phy-lan966x-serdes.h"
 
 / {
 	model = "Microchip EVB - LAN9662";
@@ -55,6 +56,40 @@ usart3: serial@200 {
 	};
 };
 
+&mdio1 {
+	status = "okay";
+};
+
+&phy0 {
+	status = "okay";
+};
+
+&phy1 {
+	status = "okay";
+};
+
+&port0 {
+	status = "okay";
+	phy-handle = <&phy0>;
+	phy-mode = "gmii";
+	phys = <&serdes 0 CU(0)>;
+};
+
+&port1 {
+	status = "okay";
+	phy-handle = <&phy1>;
+	phy-mode = "gmii";
+	phys = <&serdes 1 CU(1)>;
+};
+
+&serdes {
+	status = "okay";
+};
+
+&switch {
+	status = "okay";
+};
+
 &watchdog {
 	status = "okay";
 };
-- 
2.33.0

