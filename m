Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1A1539003
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 13:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343918AbiEaLpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 07:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343894AbiEaLpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 07:45:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5200A915A5
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:45:38 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id z17so7873782wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 04:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ysOdFy7JHZK3UBBDBfJdbJbrtIA4C2hQ/aDw2BjlBdM=;
        b=KWxM/rUJRj4uHbly0OCSVRrHV2yLvmgrpjVJyKz85AVaZpdFs4PA7DALPMgT7vwffY
         QJn/cLRgXwa/GzGAjTreATmkk6uYk1GZazoFJPiQcHrFhFzYAC7xE56r3X9B6/PGWASJ
         HVpycM3cbcrxswpCOloxzMEG0K2QjHq30HeQJFMGTmqjLBEwjfIa+3gxWYWHBPd/VFj0
         OzWs4P8OuKp6dWi9tHUEgc0kKXHwTv1RWOuZ86ren1b8i+rdNAFUucroQaPjCa+C29gb
         cNq5luqAdHWgX5dQqpAfR++cET8p05ns2AgBt36FAXbMNEmZ5ns7Wur7G32fgWOgKel3
         I3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ysOdFy7JHZK3UBBDBfJdbJbrtIA4C2hQ/aDw2BjlBdM=;
        b=igZq4gNYXijm6gfRr/73xIsD2DCaO+TQvSud9lNE8QTNkmCQ4a9veO2znBRAovIM0y
         5R5unBTkWXY99fTmWlkqUtDIfkbX3v85PEqIH4tvqSbHrf1EyzTxI9saKN9LsCxq6KvG
         i+9iXuqi5kXzCQgTHzIUNaCKXnOzUI9BDsNdQdHdSVCnKk7dxgwQi8A+iklF7MEtwxDG
         dt+Q//BZ5gxxiNBd7rriCCqfBuUv7Wo88DaK5mV+MCOe/YE+SB3uynXQMqLeEOUNqngk
         2kJmrwv+x5+6YxKuMzP+gC3iOZv7VJfSsWcgEqbuQAj9X3+dkYGpa3uFI2PKHXfd5Vpl
         pRuA==
X-Gm-Message-State: AOAM533Z/7Zsx8ECb7ti+0+ZukE9AFhzsCOVK76HpRz3cmd8STl+VDta
        435UFGfGrcCUCeBEHhZj/S0VZA==
X-Google-Smtp-Source: ABdhPJycyKUCddhvZ2P1lhmISgVMlGFmiDF5qyKUACKLyZ+M1suUOsfu5L1KnHN6R4G8Y6EBpmlIUA==
X-Received: by 2002:a05:600c:2305:b0:397:44a4:d3cb with SMTP id 5-20020a05600c230500b0039744a4d3cbmr22829021wmo.115.1653997536833;
        Tue, 31 May 2022 04:45:36 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id e15-20020a056000178f00b002102f2fac37sm7695660wrg.51.2022.05.31.04.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 04:45:36 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND 2/2] arm64: dts: mediatek: mt8195: add ssusb support
Date:   Tue, 31 May 2022 13:45:26 +0200
Message-Id: <20220531114526.144275-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220531114526.144275-1-fparent@baylibre.com>
References: <20220531114526.144275-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SSUSB support for MT8195. In order to not break any boards, this
commit also enable SSUSB for every board that has xhci0 enabled. The
boards are configured as host-only, in order to not change the current
behavior of the interface.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8195-demo.dts |  5 +++
 arch/arm64/boot/dts/mediatek/mt8195-evb.dts  |  5 +++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi     | 37 ++++++++++++++------
 3 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
index 4fbd99eb496a..317922fdb72c 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-demo.dts
@@ -400,6 +400,11 @@ &pmic {
 	interrupts-extended = <&pio 222 IRQ_TYPE_LEVEL_HIGH>;
 };
 
+&ssusb {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins>;
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
index db25a515e420..d49ae8605e67 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8195-evb.dts
@@ -138,6 +138,11 @@ pins {
 	};
 };
 
+&ssusb {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &u3phy0 {
 	status="okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index b57e620c2c72..d076a376bdcc 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -555,25 +555,40 @@ spis1: spi@1101e000 {
 			status = "disabled";
 		};
 
-		xhci0: usb@11200000 {
-			compatible = "mediatek,mt8195-xhci",
-				     "mediatek,mtk-xhci";
-			reg = <0 0x11200000 0 0x1000>,
+		ssusb: usb@11201000 {
+			compatible ="mediatek,mt8195-mtu3", "mediatek,mtu3";
+			reg = <0 0x11201000 0 0x2dff>,
 			      <0 0x11203e00 0 0x0100>;
 			reg-names = "mac", "ippc";
-			interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH 0>;
 			phys = <&u2port0 PHY_TYPE_USB2>,
 			       <&u3port0 PHY_TYPE_USB3>;
-			assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
-					  <&topckgen CLK_TOP_SSUSB_XHCI>;
-			assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
-						 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
 			clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB>,
 				 <&topckgen CLK_TOP_SSUSB_REF>,
-				 <&apmixedsys CLK_APMIXED_USB1PLL>,
 				 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>;
-			clock-names = "sys_ck", "ref_ck", "mcu_ck", "xhci_ck";
+			clock-names = "sys_ck", "ref_ck", "mcu_ck";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
 			status = "disabled";
+
+			xhci0: usb@11200000 {
+				compatible = "mediatek,mt8195-xhci",
+					     "mediatek,mtk-xhci";
+				reg = <0 0x11200000 0 0x1000>;
+				reg-names = "mac";
+				interrupts = <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH 0>;
+				assigned-clocks = <&topckgen CLK_TOP_USB_TOP>,
+						  <&topckgen CLK_TOP_SSUSB_XHCI>;
+				assigned-clock-parents = <&topckgen CLK_TOP_UNIVPLL_D5_D4>,
+							 <&topckgen CLK_TOP_UNIVPLL_D5_D4>;
+				clocks = <&infracfg_ao CLK_INFRA_AO_SSUSB>,
+					 <&topckgen CLK_TOP_SSUSB_REF>,
+					 <&apmixedsys CLK_APMIXED_USB1PLL>,
+					 <&infracfg_ao CLK_INFRA_AO_SSUSB_XHCI>;
+				clock-names = "sys_ck", "ref_ck", "mcu_ck", "xhci_ck";
+				status = "disabled";
+			};
 		};
 
 		mmc0: mmc@11230000 {
-- 
2.36.1

