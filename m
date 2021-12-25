Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B3847F318
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 12:54:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhLYLyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 06:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbhLYLyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 06:54:33 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D026C061759
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 03:54:33 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id k21so24208968lfu.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Dec 2021 03:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jekdnbYh9G4CN1Ds17WRd92yJsjR3300LoVLcZLYxzY=;
        b=gtIHbIqA7tKe8mwYwmT7QEQnRQ4hgKodDgKug7BZtIRF9wuciZgDtjYP9U/AYMdY+Y
         Jw+2CgatMFhonIoK+zFFOY9dkms/z0pAjJ1u/Lwf1pEHae0X108guZq80MKVJ/YiQZsM
         8PQJ6y/lndi3mQVXBISI34aIxVYBvq3TYbAVkEey5/rYSpYgMyYAnkjPD43SS9yrU/WL
         RjcNR3E6A/7HswKlal2RAEkB8e5izQfByjg0BGhs/y8EU1ucbqYr/ZuI3a9uSnPfx//m
         TQpJAnjfzsJ9yK+dRzg3Uvy2naOANDQbIgtkm2RehQSaa6v2fCWy+3e3UgpY7GjCjTVi
         nmBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jekdnbYh9G4CN1Ds17WRd92yJsjR3300LoVLcZLYxzY=;
        b=zv7SHzmKNrkAB+ezhIztfZDR5J2tEfKJKnpCoL2GSUz35NBwTkdJvfCoTx60dpII5r
         m2UK8ISnKDptMYeNMxaF8eXjPhcSfw0/AOoz4FuFT0zciGX2o4rEs/9k49O3v1DO+8x7
         cOQrb3b9OpkqJzljvBR1/aq+ro3rfITKXmDhpC9JWQ4CF59FP6ZsFs26q+LOiXvqjR7G
         A3ED3S/SSjDv8zkpdwWVTGOK6DqXhya0hmvWl81sl4mUQ8J2cm9Ge5bxcgP6JEJtGyHC
         q9vBaFsHPOUeq5bZ3HYu5n1o+UuYs7USykbEl0YD6pdGsXZy6WPhbedp2n6wYoNqDUGV
         H6qw==
X-Gm-Message-State: AOAM531etfeFqrql08Z4FsNBO5c9H0baQXg8En3J2w9lw/xOsS/JcVO9
        nC+QKj2mHzl3Vy02JwLJ3baaxA==
X-Google-Smtp-Source: ABdhPJxCJhS0qtre782NmekcMV3NiXQ1EiYU3QU6aZy5+paSlNVQbdi3FB+LAsBhurtMp4ZTMZJbBw==
X-Received: by 2002:a05:6512:1506:: with SMTP id bq6mr8765711lfb.444.1640433271070;
        Sat, 25 Dec 2021 03:54:31 -0800 (PST)
Received: from cobook.home (nikaet.starlink.ru. [94.141.168.29])
        by smtp.gmail.com with ESMTPSA id 9sm726678ljq.120.2021.12.25.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Dec 2021 03:54:30 -0800 (PST)
From:   Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH] arm64: dts: renesas: ulcb-kf: add KF HDMI output
Date:   Sat, 25 Dec 2021 14:53:09 +0300
Message-Id: <20211225115308.2152364-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds nodes needed to enable DRM video output over HDMI
connector located on KF board.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 arch/arm64/boot/dts/renesas/ulcb-kf.dtsi | 93 ++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
index 61bd4df09df0..a66301a4081d 100644
--- a/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
+++ b/arch/arm64/boot/dts/renesas/ulcb-kf.dtsi
@@ -51,6 +51,31 @@ wlan_en: regulator-wlan_en {
 		startup-delay-us = <70000>;
 		enable-active-high;
 	};
+
+	hdmi_1v8: regulator-hdmi-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "hdmi-1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	hdmi_3v3: regulator-hdmi-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "hdmi-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	hdmi1-out {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi1_con: endpoint {
+				remote-endpoint = <&adv7513_out>;
+			};
+		};
+	};
 };
 
 &can0 {
@@ -91,6 +116,58 @@ i2cswitch2: i2c-switch@71 {
 		reg = <0x71>;
 		reset-gpios = <&gpio5 3 GPIO_ACTIVE_LOW>;
 
+		/* HDMIoSDA, HDMIoSCL */
+		i2c@4 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <4>;
+
+			hdmi@3d {
+				compatible = "adi,adv7513";
+				reg = <0x3d>;
+
+				pinctrl-0 = <&hdmi1_pins>;
+				pinctrl-names = "default";
+
+				interrupt-parent = <&gpio2>;
+				interrupts = <14 IRQ_TYPE_LEVEL_LOW>;
+
+				clocks = <&cs2000>;
+				clock-names = "cec";
+
+				pd-gpios = <&gpio_exp_75 5 GPIO_ACTIVE_LOW>;
+
+				avdd-supply = <&hdmi_1v8>;
+				dvdd-supply = <&hdmi_1v8>;
+				pvdd-supply = <&hdmi_1v8>;
+				dvdd-3v-supply = <&hdmi_3v3>;
+				bgvdd-supply = <&hdmi_1v8>;
+
+				adi,input-depth = <8>;
+				adi,input-colorspace = "rgb";
+				adi,input-clock = "1x";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+						adv7513_in: endpoint {
+							remote-endpoint = <&du_out_rgb>;
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+						adv7513_out: endpoint {
+							remote-endpoint = <&hdmi1_con>;
+						};
+					};
+				};
+			};
+		};
+
 		/* Audio_SDA, Audio_SCL */
 		i2c@7 {
 			#address-cells = <1>;
@@ -236,6 +313,10 @@ gpio_exp_77: gpio@77 {
 	};
 };
 
+&du_out_rgb {
+	remote-endpoint = <&adv7513_in>;
+};
+
 &ohci0 {
 	dr_mode = "otg";
 	status = "okay";
@@ -289,6 +370,18 @@ usb0_pins: usb0 {
 		groups = "usb0";
 		function = "usb0";
 	};
+
+	hdmi1_pins: hdmi1 {
+		du {
+			groups = "du_rgb888", "du_sync", "du_clk_out_0", "du_disp";
+			function = "du";
+		};
+
+		adv7513-interrupt {
+			pins = "GP_2_14";
+			bias-pull-up;
+		};
+	};
 };
 
 &rcar_sound {
-- 
2.30.2

