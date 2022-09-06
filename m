Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC025AF14B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbiIFQ4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbiIFQz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:55:56 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4448F968;
        Tue,  6 Sep 2022 09:42:21 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout1.routing.net (Postfix) with ESMTP id 6976E3FE7B;
        Tue,  6 Sep 2022 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1662482539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QRC0LjWCpKR80cgSMNrWil7cnZSqEOA34xP3hwF51bA=;
        b=yQY2J6tnXjlaWInCHefixbPylHoetaBROJ3AoCQimujPUctaCuHdUHSBpcVZTjss+MjWK8
        JXTGKTTLh8n0yPAnyHlQF4CK/XHZem4ZHn+Q5xCqmA5N5KasrCe+kpHYTKLb/f/f+vSYct
        cCWW1mCrOnySkO7Vk9X25GjVFA3NZmQ=
Received: from frank-G5.. (fttx-pool-80.245.76.100.bambit.de [80.245.76.100])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 8979F400CB;
        Tue,  6 Sep 2022 16:42:18 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: dts: rockchip: Add regulator suffix to BPI-R2-Pro
Date:   Tue,  6 Sep 2022 18:42:12 +0200
Message-Id: <20220906164212.84835-1-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: 96c322ae-13cf-4cf9-b3ca-76ac40a8fb3a
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

Add -regulator suffix to regulator names on Banana Pi R2 Pro board as
discussed on Mailinglist

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
https://patchwork.kernel.org/project/linux-rockchip/patch/20220825193836.54262-6-linux@fw-web.de/

v2: change _ to - in vcc5v0_usb node
---
 arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
index 7a8d55a898f5..950613595f42 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3568-bpi-r2-pro.dts
@@ -46,7 +46,7 @@ green_led: led-1 {
 		};
 	};
 
-	dc_12v: dc-12v {
+	dc_12v: dc-12v-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_12v";
 		regulator-always-on;
@@ -66,7 +66,7 @@ hdmi_con_in: endpoint {
 		};
 	};
 
-	vcc3v3_sys: vcc3v3-sys {
+	vcc3v3_sys: vcc3v3-sys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3_sys";
 		regulator-always-on;
@@ -76,7 +76,7 @@ vcc3v3_sys: vcc3v3-sys {
 		vin-supply = <&dc_12v>;
 	};
 
-	vcc5v0_sys: vcc5v0-sys {
+	vcc5v0_sys: vcc5v0-sys-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
@@ -146,7 +146,7 @@ vcc3v3_ngff: vcc3v3-ngff-regulator {
 		vin-supply = <&vcc3v3_pi6c_05>;
 	};
 
-	vcc5v0_usb: vcc5v0_usb {
+	vcc5v0_usb: vcc5v0-usb-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc5v0_usb";
 		regulator-always-on;
@@ -156,7 +156,7 @@ vcc5v0_usb: vcc5v0_usb {
 		vin-supply = <&dc_12v>;
 	};
 
-	vcc5v0_usb_host: vcc5v0-usb-host {
+	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA6 GPIO_ACTIVE_HIGH>;
@@ -168,7 +168,7 @@ vcc5v0_usb_host: vcc5v0-usb-host {
 		vin-supply = <&vcc5v0_usb>;
 	};
 
-	vcc5v0_usb_otg: vcc5v0-usb-otg {
+	vcc5v0_usb_otg: vcc5v0-usb-otg-regulator {
 		compatible = "regulator-fixed";
 		enable-active-high;
 		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
-- 
2.34.1

