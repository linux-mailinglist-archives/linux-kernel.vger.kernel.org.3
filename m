Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03097506475
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 08:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348796AbiDSGcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 02:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbiDSGcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 02:32:17 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C02824595;
        Mon, 18 Apr 2022 23:29:35 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23J6TNl9113316;
        Tue, 19 Apr 2022 01:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650349763;
        bh=HzppkN7J13v++U+2V8ppDtlcFEoREbbLAFk/k+lsDF0=;
        h=From:To:CC:Subject:Date;
        b=XAHCX79G7wwBXcsZetogYqwKISwtxcv7JDRPpkA/7GPuW2Df04RS8i3oHSI/rDlMA
         2Gs2YSipyXsSmwXAA1IGXSb2BF8PHih2RD36ysbtJD6XTNVej7lLonb7Sef8IMTV1t
         o/pP9CGe5ppCDqbCnYjcclaMCfoCpNM607OvirUI=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23J6TNQn089631
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Apr 2022 01:29:23 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 19
 Apr 2022 01:29:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 19 Apr 2022 01:29:23 -0500
Received: from ula0132425.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23J6TIAC058735;
        Tue, 19 Apr 2022 01:29:19 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH] arm64: dts: ti: k3-am625-sk: Add ECAP APWM nodes
Date:   Tue, 19 Apr 2022 11:59:02 +0530
Message-ID: <20220419062902.196526-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

AM62 has 3 ECAP instances with 1 APWM each. Add DT nodes for the same.
Keep them disabled in am625-sk dts as these pins can be repurposed in
user exp connector.

Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 27 ++++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 12 +++++++++++
 2 files changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
index 4b6ba98dd0a2..dd972fcdaedb 100644
--- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
@@ -530,4 +530,31 @@ mailbox0_cluster0: mailbox@29000000 {
 		ti,mbox-num-users = <4>;
 		ti,mbox-num-fifos = <16>;
 	};
+
+	ecap0: pwm@23100000 {
+		compatible = "ti,am3352-ecap";
+		#pwm-cells = <3>;
+		reg = <0x00 0x23100000 0x00 0x100>;
+		power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 51 0>;
+		clock-names = "fck";
+	};
+
+	ecap1: pwm@23110000 {
+		compatible = "ti,am3352-ecap";
+		#pwm-cells = <3>;
+		reg = <0x00 0x23110000 0x00 0x100>;
+		power-domains = <&k3_pds 52 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 52 0>;
+		clock-names = "fck";
+	};
+
+	ecap2: pwm@23120000 {
+		compatible = "ti,am3352-ecap";
+		#pwm-cells = <3>;
+		reg = <0x00 0x23120000 0x00 0x100>;
+		power-domains = <&k3_pds 53 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 53 0>;
+		clock-names = "fck";
+	};
 };
diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 5fc35898a1e2..2c5e0e5b826b 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -477,3 +477,15 @@ partition@3fc0000 {
 		};
 	};
 };
+
+&ecap0 {
+	status = "disabled";
+};
+
+&ecap1 {
+	status = "disabled";
+};
+
+&ecap2 {
+	status = "disabled";
+};
-- 
2.35.3

