Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55B65A2036
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 07:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244856AbiHZFKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 01:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244538AbiHZFKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 01:10:07 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03403275DA;
        Thu, 25 Aug 2022 22:10:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4B6A13200A1A;
        Fri, 26 Aug 2022 01:10:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 26 Aug 2022 01:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1661490602; x=1661577002; bh=lg
        MUYAy9j4HMAzVd6ulb5pY9oKdUbr3uOMOw2xD/sDA=; b=DpPNMSmHU0i37Vmbcc
        qCoHGnn+LrspEAmECTrWmummsYrYWJf9mb9q+xXbTsDrpMAV5XYiWrLwNGRmUw5n
        otrnEMz0lL9PX+ff+ibQ8+mfj1/SREJq/irGU9Z+V/uQaFL6FfzfwDsETiud4Yef
        4K/9UN3QIkFjRj4X4M9IA09BWyURU5Sv06GqnKct5rJjrVTWOki7QYFbnYzxJ3gC
        ctI96I5pUC9kepWgrxCTs9FYiR50Ey4DKhTw9FJ0NTXbD5jAzSTlzvAodtAC5O5l
        6L+cGFB/GnbIBg4F2VhVMG5s+1R4baYzTNub+Ltaqq/vALXNz34U1qt3uDfEeYXW
        LO9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1661490602; x=1661577002; bh=lgMUYAy9j4HMA
        zVd6ulb5pY9oKdUbr3uOMOw2xD/sDA=; b=HdOFS5T2V1Zn0gW2HR2TDHlGpXR9f
        jpRm6qNysvjwWQCuw4sgw1HE/25CuGLB2QlSesn4brA+SqM4q+BXPAPXds9ut8Bt
        zMB3edJwf4rsnXzTEvX0Fg4uOz79RyVu0k8HLpNnp1xOOVbESIABrmB29tyToRWb
        ZxzWt5pbwUfIWbWj4lRQa0sz9JgXCMroJXKFYL2YKTUPSyrJ4TDdqTbij1WkJ3Lf
        EwFlM6qI185JoCUDr8UUX3csloaQVgRh0lL5JxPdiXUCZy9jxNFG0TiHUDy6hEXx
        DNXRl0Mx9RNQRVlnD7g7e9CfQD12AQZX/Sp1lg3WNJjp3xXz/rbPpm5Gw==
X-ME-Sender: <xms:qlUIYxseD6rLT8TxSLogbtleYlWuixK5tIf5IgZCls-aAP-gzZjmvw>
    <xme:qlUIY6cvVnDF00ZR9SgdwgIbo1nfUGpmq9dTtPrucH3aGWX91d1Fkylz86tpLvdCL
    Fbe3ygEwxc-atFfQw>
X-ME-Received: <xmr:qlUIY0ys1vqhUiultf3p3OgysMd1GhbRbuCZssKDWZBcUSFUOybu17Atc6M4p1a7w6buwrBblpNOKwMKz_vAxxqXjDTxrBCTAQux5oibGGRsNO8KspfWjCn7ct3vyP7uWgel5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejgedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:qlUIY4MQJ6-pd4xuotE1dE2OI9_UQ5pQq-I8Y0pJ0g7oWH1g_TFcug>
    <xmx:qlUIYx9-f7vuFwGJ1vGihx_81H5K3tXk_lxLTMr78Zeaj6QpbzFHXA>
    <xmx:qlUIY4UpEwgxXlw3FXsXX9OjMd7Z2TCW4ICn9_RnS2SPr3dxlLY5Yg>
    <xmx:qlUIYy3WzfBMGpC62woSvziMxyaELkQdIhL1KM877PiSs3_CVkjxuQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Aug 2022 01:10:01 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-leds@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 6/6] riscv: dts: allwinner: d1: Add RGB LEDs to boards
Date:   Fri, 26 Aug 2022 00:09:42 -0500
Message-Id: <20220826050942.20067-7-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220826050942.20067-1-samuel@sholland.org>
References: <20220826050942.20067-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some D1-based boards feature an onboard RGB LED. Enable them.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v5:
 - New patch for v5

 .../boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts | 12 ++++++++++++
 arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts   | 13 +++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
index ca36a5d75a7f..02d13e987e02 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-lichee-rv-dock.dts
@@ -25,6 +25,18 @@ &ehci1 {
 	status = "okay";
 };
 
+&ledc {
+	pinctrl-0 = <&ledc_pc0_pin>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	multi-led@0 {
+		reg = <0x0>;
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+	};
+};
+
 &lradc {
 	status = "okay";
 
diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
index df865ee15fcf..099075462998 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1-nezha.dts
@@ -5,6 +5,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
 
 #include "sun20i-d1.dtsi"
 #include "sun20i-d1-common-regulators.dtsi"
@@ -90,6 +91,18 @@ pcf8574a: gpio@38 {
 	};
 };
 
+&ledc {
+	pinctrl-0 = <&ledc_pc0_pin>;
+	pinctrl-names = "default";
+	status = "okay";
+
+	multi-led@0 {
+		reg = <0x0>;
+		color = <LED_COLOR_ID_RGB>;
+		function = LED_FUNCTION_STATUS;
+	};
+};
+
 &lradc {
 	status = "okay";
 
-- 
2.35.1

