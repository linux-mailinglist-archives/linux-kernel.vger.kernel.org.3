Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC8F4F9CF1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 20:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiDHSkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234857AbiDHSkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 14:40:20 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6257D140A3;
        Fri,  8 Apr 2022 11:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1649443084;
    s=strato-dkim-0002; d=goldelico.com;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=AififXgRpoTwo6DBtCzSPTWcO0jEFyMvLEtO2+QLpDU=;
    b=hi+5US5o4fK98V5wdUCXCfgcAH+LHAM+kfnEhexax0KWpkdMBuhTomWsoXV/+9JVgl
    4WW7iy3xEdcv79hkR78PAJKs997F7UJYhL0Nm0OWZffg5z9d2VDtD1SivgkoezEIgMI7
    leAmx2A8OnAPsW9FO93foEbY9QtqQSkNvVSF9eEEvedPHf+RJEANeyv0Bck/+6a4gCNg
    Z3JDYXz3nM9QZIm7Uzmwolv0fgnVgh4/VVq+RcayKypEyYKf13T9z0HNIQiX8IB9cH9k
    YTiyhSqaXsy1eK+1PhAsRPQvU2HzwncSfaNKFsJkJFQiOnbyyvoFRCyqMIbvIxZ+8rSy
    MFkQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1OAA2UMf2MwPVbgdr/a"
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
    by smtp.strato.de (RZmta 47.42.2 DYNA|AUTH)
    with ESMTPSA id k708cfy38Ic4snz
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Fri, 8 Apr 2022 20:38:04 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org, letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 08/18] MIPS: DTS: jz4780: fix lcd controllers as reported by dtbscheck
Date:   Fri,  8 Apr 2022 20:37:51 +0200
Message-Id: <a948ce9c6126eb9d5daf9a24e76cc6c01c22c685.1649443080.git.hns@goldelico.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <cover.1649443080.git.hns@goldelico.com>
References: <cover.1649443080.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/Volumes/CaseSensitive/master/arch/mips/boot/dts/ingenic/ci20.dtb: lcdc0@13050000: $nodename:0: 'lcdc0@13050000' does not match '^lcd-controller@[0-9a-f]+$'
	From schema: /Volumes/CaseSensitive/master/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
/Volumes/CaseSensitive/master/arch/mips/boot/dts/ingenic/ci20.dtb: lcdc0@13050000: clock-names:0: 'lcd_pclk' was expected
	From schema: /Volumes/CaseSensitive/master/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
/Volumes/CaseSensitive/master/arch/mips/boot/dts/ingenic/ci20.dtb: lcdc0@13050000: clock-names:1: 'lcd' was expected
	From schema: /Volumes/CaseSensitive/master/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
/Volumes/CaseSensitive/master/arch/mips/boot/dts/ingenic/ci20.dtb: lcdc1@130a0000: $nodename:0: 'lcdc1@130a0000' does not match '^lcd-controller@[0-9a-f]+$'
	From schema: /Volumes/CaseSensitive/master/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
/Volumes/CaseSensitive/master/arch/mips/boot/dts/ingenic/ci20.dtb: lcdc1@130a0000: clock-names:0: 'lcd_pclk' was expected
	From schema: /Volumes/CaseSensitive/master/Documentation/devicetree/bindings/display/ingenic,lcd.yaml
/Volumes/CaseSensitive/master/arch/mips/boot/dts/ingenic/ci20.dtb: lcdc1@130a0000: clock-names:1: 'lcd' was expected
	From schema: /Volumes/CaseSensitive/master/Documentation/devicetree/bindings/display/ingenic,lcd.yaml

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index c5124459678b7..8b95486c8afa7 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -457,12 +457,12 @@ hdmi: hdmi@10180000 {
 		status = "disabled";
 	};
 
-	lcdc0: lcdc0@13050000 {
+	lcdc0: lcd-controller@13050000 {
 		compatible = "ingenic,jz4780-lcd";
 		reg = <0x13050000 0x1800>;
 
-		clocks = <&cgu JZ4780_CLK_TVE>, <&cgu JZ4780_CLK_LCD0PIXCLK>;
-		clock-names = "lcd", "lcd_pclk";
+		clocks = <&cgu JZ4780_CLK_LCD0PIXCLK>, <&cgu JZ4780_CLK_TVE>;
+		clock-names = "lcd_pclk", "lcd";
 
 		interrupt-parent = <&intc>;
 		interrupts = <31>;
@@ -470,12 +470,12 @@ lcdc0: lcdc0@13050000 {
 		status = "disabled";
 	};
 
-	lcdc1: lcdc1@130a0000 {
+	lcdc1: lcd-controller@130a0000 {
 		compatible = "ingenic,jz4780-lcd";
 		reg = <0x130a0000 0x1800>;
 
-		clocks = <&cgu JZ4780_CLK_TVE>, <&cgu JZ4780_CLK_LCD1PIXCLK>;
-		clock-names = "lcd", "lcd_pclk";
+		clocks = <&cgu JZ4780_CLK_LCD1PIXCLK>, <&cgu JZ4780_CLK_TVE>;
+		clock-names = "lcd_pclk", "lcd";
 
 		interrupt-parent = <&intc>;
 		interrupts = <23>;
-- 
2.33.0

