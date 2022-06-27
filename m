Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B0D55DA54
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiF0LGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 07:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233832AbiF0LGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:06:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65438646A;
        Mon, 27 Jun 2022 04:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656327963; x=1687863963;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=OoPFRHqikt/yBEHB9HcY/GvSuduX5hDNnHB8YUjJssg=;
  b=FWH/C6CZHHv/wRyapK82KYvrx24BHAR2NOrLvXPrZifNPl3XJdziaxAJ
   Zd3Kfn+mWZGah7Lp31u3OvwURC63PBJYxkWP9PlTn55SqVEotvpLdjVWk
   Yw1FUMEzizOoBPh4eV1S4jwgiVnU0uRzgwaoXwqbxw6JzBDsx4RDMl1sG
   E7oWPmi/kBpjVwv4+XcgAPewvWd2ysO1tzaizNGV6aYdv0CXGSx84w4XS
   v3xBvpleNjfM3RZyR70ZSVci8BfRAmlH+8Q9+D2c0K5RwQUl6Ygf5EI7M
   jEMYm8v2Oj+G9RGQt8OAWJcqaY9x6vGXfqyaxMl9jhV4CecqH/nL07CUj
   g==;
X-IronPort-AV: E=Sophos;i="5.92,226,1650956400"; 
   d="scan'208";a="101875529"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jun 2022 04:06:02 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 27 Jun 2022 04:05:58 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Mon, 27 Jun 2022 04:05:54 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <alexandre.belloni@bootlin.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <nicolas.ferre@microchip.com>
CC:     <arnd@arndb.de>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <Kavyasree.Kotagiri@microchip.com>
Subject: [PATCH] ARM: dts: lan966x: Add mcan1 node.
Date:   Mon, 27 Jun 2022 16:35:52 +0530
Message-ID: <20220627110552.26315-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mcan1 node. By default, keep it disabled.

Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
---
 arch/arm/boot/dts/lan966x.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/lan966x.dtsi b/arch/arm/boot/dts/lan966x.dtsi
index 3cb02fffe716..25cfa89dde7b 100644
--- a/arch/arm/boot/dts/lan966x.dtsi
+++ b/arch/arm/boot/dts/lan966x.dtsi
@@ -473,6 +473,21 @@
 			status = "disabled";
 		};
 
+		can1: can@e0820000 {
+			compatible = "bosch,m_can";
+			reg = <0xe0820000 0xfc>, <0x00100000 0x8000>;
+			reg-names = "m_can", "message_ram";
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "int0", "int1";
+			clocks = <&clks GCK_ID_MCAN1>, <&clks GCK_ID_MCAN1>;
+			clock-names = "hclk", "cclk";
+			assigned-clocks = <&clks GCK_ID_MCAN1>;
+			assigned-clock-rates = <40000000>;
+			bosch,mram-cfg = <0x4000 0 0 64 0 0 32 32>;
+			status = "disabled";
+		};
+
 		reset: reset-controller@e200400c {
 			compatible = "microchip,lan966x-switch-reset";
 			reg = <0xe200400c 0x4>;
-- 
2.17.1

