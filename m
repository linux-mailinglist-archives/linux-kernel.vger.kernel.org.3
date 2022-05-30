Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C508F537911
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235137AbiE3KK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbiE3KKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:10:44 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B6617B9CD;
        Mon, 30 May 2022 03:10:43 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 24UAAexd128833;
        Mon, 30 May 2022 05:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1653905440;
        bh=Cm/WTKOlldbkP44G+tdNcj1+LV6mVnmxMofMT1CSrxs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=cn7lzY5dQMKePgVG3Y3V75kHu4lLwgA7pJ3WMVOAGo/jpted+wK7mgsw5nG002RXB
         SjxUPVyNDGjLcXKU1Xac0YVUGNqjiG35hJFQ9/QPZDwYKs0XH6weZiOFfKAZr3GcHr
         irK9vAU5FF8Y+CONaS4LTWURRAcYjBB8lM8g+PCM=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 24UAAe0u017197
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 May 2022 05:10:40 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 30
 May 2022 05:10:39 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 30 May 2022 05:10:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 24UAAcKa071835;
        Mon, 30 May 2022 05:10:39 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <robh+dt@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <lee.jones@linaro.org>, <rogerq@kernel.org>,
        <devicetree@vger.kernel.org>, <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <s-anna@ti.com>,
        Vijay Pothukuchi <vijayp@ti.com>,
        Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v4 2/3] arm64: dts: ti: k3-j721e-*: Add dts nodes for EHRPWMs
Date:   Mon, 30 May 2022 15:40:30 +0530
Message-ID: <20220530101031.11357-3-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220530101031.11357-1-r-ravikumar@ti.com>
References: <20220530101031.11357-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Pothukuchi <vijayp@ti.com>

Add dts nodes for 6 EHRPWM instances on SoC

Signed-off-by: Vijay Pothukuchi <vijayp@ti.com>
Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 .../dts/ti/k3-j721e-common-proc-board.dts     | 24 +++++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 62 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 24 +++++++
 3 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
index 2bc26a296496..f7d02fa4d6fc 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
@@ -995,3 +995,27 @@
 &main_mcan13 {
 	status = "disabled";
 };
+
+&main_ehrpwm0 {
+	status = "disabled";
+};
+
+&main_ehrpwm1 {
+	status = "disabled";
+};
+
+&main_ehrpwm2 {
+	status = "disabled";
+};
+
+&main_ehrpwm3 {
+	status = "disabled";
+};
+
+&main_ehrpwm4 {
+	status = "disabled";
+};
+
+&main_ehrpwm5 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 43b6cf5791ee..1ee00b73905d 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -66,7 +66,67 @@
 			#mux-control-cells = <1>;
 			mux-reg-masks = <0x4000 0x8000000>, /* USB0 to SERDES0/3 mux */
 					<0x4010 0x8000000>; /* USB1 to SERDES1/2 mux */
-	    };
+		};
+
+		ehrpwm_tbclk: clock-controller@4140 {
+			compatible = "ti,am654-ehrpwm-tbclk", "syscon";
+			reg = <0x4140 0x18>;
+			#clock-cells = <1>;
+		};
+	};
+
+	main_ehrpwm0: pwm@3000000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x3000000 0x0 0x100>;
+		power-domains = <&k3_pds 83 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 0>, <&k3_clks 83 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	main_ehrpwm1: pwm@3010000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x3010000 0x0 0x100>;
+		power-domains = <&k3_pds 84 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 1>, <&k3_clks 84 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	main_ehrpwm2: pwm@3020000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x3020000 0x0 0x100>;
+		power-domains = <&k3_pds 85 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 2>, <&k3_clks 85 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	main_ehrpwm3: pwm@3030000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x3030000 0x0 0x100>;
+		power-domains = <&k3_pds 86 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 3>, <&k3_clks 86 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	main_ehrpwm4: pwm@3040000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x3040000 0x0 0x100>;
+		power-domains = <&k3_pds 87 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 4>, <&k3_clks 87 0>;
+		clock-names = "tbclk", "fck";
+	};
+
+	main_ehrpwm5: pwm@3050000 {
+		compatible = "ti,am654-ehrpwm", "ti,am3352-ehrpwm";
+		#pwm-cells = <3>;
+		reg = <0x0 0x3050000 0x0 0x100>;
+		power-domains = <&k3_pds 88 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&ehrpwm_tbclk 5>, <&k3_clks 88 0>;
+		clock-names = "tbclk", "fck";
 	};
 
 	gic500: interrupt-controller@1800000 {
diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
index 80358cba6954..98a55778f3fe 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
@@ -1129,3 +1129,27 @@
 	memory-region = <&c71_0_dma_memory_region>,
 			<&c71_0_memory_region>;
 };
+
+&main_ehrpwm0 {
+	status = "disabled";
+};
+
+&main_ehrpwm1 {
+	status = "disabled";
+};
+
+&main_ehrpwm2 {
+	status = "disabled";
+};
+
+&main_ehrpwm3 {
+	status = "disabled";
+};
+
+&main_ehrpwm4 {
+	status = "disabled";
+};
+
+&main_ehrpwm5 {
+	status = "disabled";
+};
-- 
2.17.1

