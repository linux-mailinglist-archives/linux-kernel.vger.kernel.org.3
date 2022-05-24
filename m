Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140BB53329A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 22:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241709AbiEXUtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 16:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241696AbiEXUtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 16:49:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A967737B9
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:49:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id g184so17269242pgc.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 13:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e9ahkSLTtuvwLRoOkp0E00xXCsWuniaEqLjpRE+FmXM=;
        b=AXCr0XgSkVrF9pCBmMIp3f38r3JJf2AjRX5w1UCFvFugMSOA8Se7MLQ1xl6emdyIx8
         LeVkeS3aM38TUQ7nGBZOro8M5oQFFf+AWzi00HrtsjExVGtL7W9u/n55/660ncvC6u71
         yFlf5B3NV8qkExYAo9G9O3AQ+mBqAJgEvCy1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e9ahkSLTtuvwLRoOkp0E00xXCsWuniaEqLjpRE+FmXM=;
        b=E5UhYBN/+3DmUp8wlMJsCk4/KojaGCoz8ID2n7L4Oj4PuUoIpaC48cpTO/CLbM2zYc
         ABRbW0+lniumbjKgnN7gp1tJLmU2GNUctXJhpQ+jtUwUHUD+L/uT4Ep/nxHtS6rtQ1dJ
         J1XGjb5ejiXatJNnFNI4WL3GpWZ+kS4Y/brFxqKsRv7VkJgwbEwRGqDFoeRC3sMFTWr4
         IGJh6WFofdNN3ZHSyMSRTIfjF2lURyBb8AvbLGHJ/Rv3ASpTwrJ2TFfDTUnzOD3nVbkQ
         8W9UCZHLd3pKf7RkFxbr+AZtbXozcQmTuXOdks43frMjotAnNWt2NOV9ZriZSNi9YZAy
         dsQA==
X-Gm-Message-State: AOAM532nRk69pp7Dv1upCA3bjO/1IXxGJU6HxFgQzx4GPUsEvfwvbGOw
        dgRkH9U6JYzSUw8wcgsePF/cLQ==
X-Google-Smtp-Source: ABdhPJwCz55uI2qGOYgI22kmaw7O/6E1G/+i+42mFsW1jnbNomUOjxKNl3/aN6OfdEf3gmO/FAvfvQ==
X-Received: by 2002:a63:4204:0:b0:3f6:4a4f:5a96 with SMTP id p4-20020a634204000000b003f64a4f5a96mr23128307pga.10.1653425355851;
        Tue, 24 May 2022 13:49:15 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:e1fc:e14a:1559:6e05])
        by smtp.gmail.com with ESMTPSA id n11-20020a65450b000000b003fa5b550303sm3988813pgq.68.2022.05.24.13.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 13:49:15 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7280: Add touchscreen to villager
Date:   Tue, 24 May 2022 13:48:49 -0700
Message-Id: <20220524134840.1.I80072b8815ac08c12af8f379a33cc2d83693dc51@changeid>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the touchscreen to the sc7280-herobrine-villager device
tree. Note that the touchscreen on villager actually uses the reset
line and thus we use the more specific "elan,ekth6915" compatible
which allows us to specify the reset.

The fact that villager's touchscreen uses the reset line can be
contrasted against the touchscreen for CRD/herobrine-r1. On those
boards, even though the touchscreen goes to the display, it's not
hooked up to anything there.

In order to keep the line parked on herobrine/CRD, we'll move the
pullup from the qcard.dtsi file to the specific boards. This allows us
to disable the pullup in the villager device tree since the pin is an
output.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
This uses bindings introduced in the patch ("dt-bindings: HID:
i2c-hid: elan: Introduce bindings for Elan eKTH6915") [1].

[1] https://lore.kernel.org/r/20220523142257.v2.1.Iedc61f9ef220a89af6a031200a7850a27a440134@changeid

 .../boot/dts/qcom/sc7280-herobrine-crd.dts    | 11 ++++++++
 .../qcom/sc7280-herobrine-herobrine-r1.dts    | 11 ++++++++
 .../dts/qcom/sc7280-herobrine-villager-r0.dts | 25 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi    |  1 -
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
index a4ac33c4fd59..b79d84d7870a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-crd.dts
@@ -134,6 +134,17 @@ &sdhc_2 {
 	status = "okay";
 };
 
+/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
+
+/*
+ * This pin goes to the display panel but then doesn't actually do anything
+ * on the panel itself (it doesn't connect to the touchscreen controller).
+ * We'll set a pullup here just to park the line.
+ */
+&ts_rst_conn {
+	bias-pull-up;
+};
+
 /* PINCTRL - BOARD-SPECIFIC */
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
index b69ca09d9bfb..c1647a85a371 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
@@ -128,6 +128,17 @@ &sdhc_2 {
 	status = "okay";
 };
 
+/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
+
+/*
+ * This pin goes to the display panel but then doesn't actually do anything
+ * on the panel itself (it doesn't connect to the touchscreen controller).
+ * We'll set a pullup here just to park the line.
+ */
+&ts_rst_conn {
+	bias-pull-up;
+};
+
 /* PINCTRL - BOARD-SPECIFIC */
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
index d3d6ffad4eff..950b69448109 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-villager-r0.dts
@@ -46,6 +46,25 @@ trackpad: trackpad@2c {
 	};
 };
 
+ts_i2c: &i2c13 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ap_ts: touchscreen@10 {
+		compatible = "elan,ekth6915";
+		reg = <0x10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_conn>, <&ts_rst_conn>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
+
+		reset-gpios = <&tlmm 54 GPIO_ACTIVE_LOW>;
+
+		vcc33-supply = <&ts_avdd>;
+	};
+};
+
 &ap_sar_sensor_i2c {
 	status = "okay";
 };
@@ -81,6 +100,12 @@ &sdhc_1 {
 	status = "okay";
 };
 
+/* PINCTRL - ADDITIONS TO NODES IN PARENT DEVICE TREE FILES */
+
+&ts_rst_conn {
+	bias-disable;
+};
+
 /* PINCTRL - BOARD-SPECIFIC */
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index d59002d4492e..404936c6bf20 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -604,7 +604,6 @@ ts_int_conn: ts-int-conn {
 	ts_rst_conn: ts-rst-conn {
 		pins = "gpio54";
 		function = "gpio";
-		bias-pull-up;
 		drive-strength = <2>;
 	};
 };
-- 
2.36.1.124.g0e6072fb45-goog

