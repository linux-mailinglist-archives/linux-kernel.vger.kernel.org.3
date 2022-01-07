Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FB648720B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 06:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbiAGFNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 00:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiAGFNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 00:13:41 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EF2C061245;
        Thu,  6 Jan 2022 21:13:41 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 202so4882688qkg.13;
        Thu, 06 Jan 2022 21:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0E8s9XkVMJfO71U0WZapgq3CBnEOczzCxvv2x4eTOI=;
        b=awhqnAkIp7trR8Jv9wraBB/3QMSgqaGlulcxwILOUKQ6xfuXvz9Cy8JIV1bqHeSk0B
         xnYQnCHZcvhNLYbBGUBPrlOIyR6Fve60BMqo0Egl92ueIIYwPolz+0ZcJfKwscAa4Zey
         tkW93zs0Ec5qd8bvHW3qA0sn2Lhok4E7VF92Zwsb8bCQspev1hIK5D8hOGo7s3IE+ZYF
         trPp6C4CZVfhFh+BZtLHqWE1xOvEyq6KPMMGIPBqBp+RV84KxSSRrc8uPIain2/P5NNw
         VmS6NhpD4RsKkEsJI6FVNMx/UxyyOdwZPUDG7VNJ+eDYKanizAGZGNYaJtaiPs++iD15
         np0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0E8s9XkVMJfO71U0WZapgq3CBnEOczzCxvv2x4eTOI=;
        b=7zC7SEP/e/BNONGwncWtcTnOo9biTKN0+eifucjjQM/4+3myhpliADhdWoWhokB62g
         V3RRZTwaHS3tL6cWrbF/Nt0Qkdz2dgPO7AK6z2hbgFEc3BglUMoLmU7IAHl+/uZU0WBw
         MDzchk/nZ/IXshzljB7Xag2iVISvI+sWXdN1Y6VA58xKHCC1Lz8P59+G8E8fBQNWmLks
         i4gT88zPb3BLM20zKKVAqG/Any1QIO4qcBCPvdUwZyDy7Us8SPQfkSaKbUyfA5WRQ3vc
         FIdW2+d2OqP5UP9O3OfI2qvhLjpxjJK5GEKepFeYM1v3n5xdrWu2CGLF/jUSZmEozNmX
         n3og==
X-Gm-Message-State: AOAM530n0l2yEIg9WiK5ML81n6STTSHSYpDSBydTI5AJYjcE8nxul0Rs
        wBt8YgSh1e0zb5SzcOn5NUc=
X-Google-Smtp-Source: ABdhPJwKGvck88HMWuNcgtplD8fVqm2IP/5UhmLKJ/hHRmQaUGaAF0uj1u94MoiOsIW91+gruO6WtQ==
X-Received: by 2002:a05:620a:24ca:: with SMTP id m10mr43698820qkn.649.1641532420494;
        Thu, 06 Jan 2022 21:13:40 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id d15sm1651461qka.3.2022.01.06.21.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 21:13:40 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: dts: rockchip: add pine64 touch panel display to rockpro64
Date:   Fri,  7 Jan 2022 00:13:34 -0500
Message-Id: <20220107051335.3812535-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220107051335.3812535-1-pgwipeout@gmail.com>
References: <20220107051335.3812535-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Pine64 touch panel is a panel consisting of the Feiyang fy07024di26a30d
panel with a Goodix gt911 touch screen.
Add the device tree nodes to the rockpro64 to permit attaching this display to
the device.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 80 ++++++++++++++++++-
 1 file changed, 76 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
index 83db4ca67334..158befb9a48c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
@@ -20,6 +20,15 @@ chosen {
 		stdout-path = "serial2:1500000n8";
 	};
 
+	/* enable for panel backlight support */
+	backlight: backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm0 0 1000000 0>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <5>;
+		status = "disabled";
+	};
+
 	clkin_gmac: external-gmac-clock {
 		compatible = "fixed-clock";
 		clock-frequency = <125000000>;
@@ -220,6 +229,14 @@ vdd_log: vdd-log {
 		regulator-max-microvolt = <1700000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
+
+	avdd: avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "avdd";
+		regulator-min-microvolt = <11000000>;
+		regulator-max-microvolt = <11000000>;
+		vin-supply = <&vcc3v3_s0>;
+	};
 };
 
 &cpu_l0 {
@@ -301,6 +318,11 @@ &hdmi {
 	status = "okay";
 };
 
+/* force hdmi to vopb */
+&hdmi_in_vopl {
+	status = "disabled";
+};
+
 &hdmi_sound {
 	status = "okay";
 };
@@ -400,8 +422,6 @@ regulator-state-mem {
 
 			vcc3v0_touch: LDO_REG2 {
 				regulator-name = "vcc3v0_touch";
-				regulator-always-on;
-				regulator-boot-on;
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-state-mem {
@@ -490,8 +510,6 @@ regulator-state-mem {
 
 			vcc3v3_s0: SWITCH_REG2 {
 				regulator-name = "vcc3v3_s0";
-				regulator-always-on;
-				regulator-boot-on;
 				regulator-state-mem {
 					regulator-off-in-suspend;
 				};
@@ -565,6 +583,19 @@ fusb0: typec-portc@22 {
 		vbus-supply = <&vcc5v0_typec>;
 		status = "okay";
 	};
+
+	/* enable for pine64 touch screen support */
+	touch: touchscreen@5d {
+		compatible = "goodix,gt911";
+		reg = <0x5d>;
+		AVDD28-supply = <&vcc3v0_touch>;
+		VDDIO-supply = <&vcc3v0_touch>;
+		interrupt-parent = <&gpio4>;
+		interrupts = <RK_PD5 IRQ_TYPE_EDGE_FALLING>;
+		irq-gpios = <&gpio4 RK_PD5 GPIO_ACTIVE_HIGH>;
+		reset-gpios = <&gpio4 RK_PD6 GPIO_ACTIVE_HIGH>;
+		status = "disabled";
+	};
 };
 
 &i2s0 {
@@ -600,6 +631,47 @@ &io_domains {
 	gpio1830-supply = <&vcc_3v0>;
 };
 
+/* enable for pine64 panel display support */
+&mipi_dsi {
+	status = "disabled";
+	clock-master;
+
+	ports {
+		mipi_out: port@1 {
+			reg = <1>;
+
+			mipi_out_panel: endpoint {
+				remote-endpoint = <&mipi_in_panel>;
+			};
+		};
+	};
+
+	mipi_panel: panel@0 {
+		compatible = "feiyang,fy07024di26a30d";
+		reg = <0>;
+		avdd-supply = <&avdd>;
+		backlight = <&backlight>;
+		dvdd-supply = <&vcc3v3_s0>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				mipi_in_panel: endpoint {
+					remote-endpoint = <&mipi_out_panel>;
+				};
+			};
+		};
+	};
+};
+
+/* force dsi to vopl */
+&mipi_in_vopb {
+	status="disabled";
+};
+
 &pcie0 {
 	ep-gpios = <&gpio2 RK_PD4 GPIO_ACTIVE_HIGH>;
 	num-lanes = <4>;
-- 
2.32.0

