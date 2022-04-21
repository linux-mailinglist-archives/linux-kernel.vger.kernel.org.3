Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBEE2509768
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384789AbiDUGXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiDUGXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:23:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E313DE1;
        Wed, 20 Apr 2022 23:20:12 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23L6K1w3085688;
        Thu, 21 Apr 2022 01:20:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650522001;
        bh=Zb6hy1mU9VhZmpYtG3YtsYUZK/kNtHDTPxAdvz7jqO0=;
        h=From:To:CC:Subject:Date;
        b=LQ7dQ+RqMDkm6op1V6CEhKVNIGZ/N+civS72m140my55ZOrpha7rwTf5pdRMe3IK/
         oNUrPV6iW2++MfXvrfsc17wW0ZrneVN/PSFUXdjyePJGPAdMVwSXZEZHOczr+m3Qrg
         NdWT3ayUhKXRYMR0bf0Nb3ZsehwWnovi6kwmgyEg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23L6K0LG128019
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 01:20:00 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 01:20:00 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 01:20:00 -0500
Received: from ula0132425.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23L6JuoJ022048;
        Thu, 21 Apr 2022 01:19:56 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am62-mcu: Enable MCU GPIO module
Date:   Thu, 21 Apr 2022 11:49:38 +0530
Message-ID: <20220421061938.122317-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AM62 has x1 GPIO module and associated interrupt router in MCU Domain.
Add DT nodes for the same.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
index d103824c963f..45343381ad0b 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi
@@ -53,4 +53,32 @@ mcu_spi1: spi@4b10000 {
 		power-domains = <&k3_pds 148 TI_SCI_PD_EXCLUSIVE>;
 		clocks = <&k3_clks 148 0>;
 	};
+
+	mcu_gpio_intr: interrupt-controller@4210000 {
+		compatible = "ti,sci-intr";
+		reg = <0x00 0x04210000 0x00 0x200>;
+		ti,intr-trigger-type = <1>;
+		interrupt-controller;
+		interrupt-parent = <&gic500>;
+		#interrupt-cells = <1>;
+		ti,sci = <&dmsc>;
+		ti,sci-dev-id = <5>;
+		ti,interrupt-ranges = <0 104 4>;
+	};
+
+	mcu_gpio0: gpio@4201000 {
+		compatible = "ti,am64-gpio", "ti,keystone-gpio";
+		reg = <0x0 0x4201000 0x0 0x100>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-parent = <&mcu_gpio_intr>;
+		interrupts = <30>, <31>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		ti,ngpio = <24>;
+		ti,davinci-gpio-unbanked = <0>;
+		power-domains = <&k3_pds 79 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 79 0>;
+		clock-names = "gpio";
+	};
 };
-- 
2.36.0

