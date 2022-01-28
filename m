Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCBE849EFE5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 01:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344663AbiA1AiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 19:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241595AbiA1AiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 19:38:18 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5346BC061714;
        Thu, 27 Jan 2022 16:38:18 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id k14so3938373qtq.10;
        Thu, 27 Jan 2022 16:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U0ZtMbfGNf5bI/1AePHt7T+pCQPNUqP752Ba3r+02dM=;
        b=ky3S5f7lhADSWWb9ST7r5M95iARgFNUMQiSs99hEtWaw9Cp2LuMvM2peP/BugzC8Qt
         hL9HrtWe8moyMoNhZNvQiBjznS0tyEp0+rY8HYfYN3VoUS9cBnnKNVKYMZvPiwqJ3hic
         rb+I9nYH8h0r66PhJaB8YPjBF9DzPXWTqulCSkokuNa48FoUim3pIGSCvAdRruR0m7or
         ZEFoVTctqzAl3Jqh0xysji9bV1mN4IQwTUN8w0vgoz9hC+t+leeHidi4OkC03NIkFhF6
         WMPV9PjfvLSKgDZRSQ/1m6rui25WgB5iCND4dEom4YN5aYnGka/J8MzSpBSV/2uSjfvw
         hwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U0ZtMbfGNf5bI/1AePHt7T+pCQPNUqP752Ba3r+02dM=;
        b=75pljKZn7xxl+fqETECsICeU5NGkHHJr7+FiJQYAgCOuEa8nEH2wwghWncm7Q8EE9i
         9zWrzylcVAPiTVKuGKLR6rBC2gHkrrCyhfTSnKlE7x1tY7hcDpwz5j+lKu8Sge9/nFp7
         kGkQ7UhL1KtDf7kiSK8HRcyMkRX4XP//ALgowpPqefBA8Az4rt0Nu6xSD7xkKK0sdgqF
         08zNlCF1clPyiGP4H5sPHdX+9LH/HrNXMuTe6QAYy8lMUVhLK3R9Z1vuCuNbmuVCxKB+
         sxNyaNFaphYRypYGYbk3CkyrmZeRGxXIAyaGXfPFvPYYpIvmHWjIO80Q4IF8wFBLjzsD
         /vRg==
X-Gm-Message-State: AOAM532wZsUnvcrZq+6Y3TWxY3BFK5I2ssDUQImps9j8gCuHzaHBWyK2
        QewXwh69KaynrBeMcQ4+kM4=
X-Google-Smtp-Source: ABdhPJwRZPAqYv4oJNy1fNafX2Qj6lvpf2KHx++EeZKTn31dh+x8Mtfsyq8oYEbbM/XWJw5lq3VWrw==
X-Received: by 2002:ac8:5e0d:: with SMTP id h13mr4763623qtx.97.1643330297428;
        Thu, 27 Jan 2022 16:38:17 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id t1sm2142883qtc.48.2022.01.27.16.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 16:38:17 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] arm64: dts: rockchip: add Quartz64-A sdmmc1 node
Date:   Thu, 27 Jan 2022 19:38:07 -0500
Message-Id: <20220128003809.3291407-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220128003809.3291407-1-pgwipeout@gmail.com>
References: <20220128003809.3291407-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sdmmc1 node on Quartz64-A supports the optional wifi module from
Pine64.
Add the sdmmc1 node and requisite sdio_pwrseq to enable wifi support on
the Quartz64-A.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---

Changelog:
v2:
- drop status = "okay" from sdio_pwrseq
- drop disable-wp from sdmmc1
- move reset-gpios to be alphabetical in sdio_pwrseq

---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 33c2c18caaa9..c5a79046a9d0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -91,6 +91,17 @@ simple-audio-card,codec {
 		};
 	};
 
+	sdio_pwrseq: sdio-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk817 1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <5000000>;
+		reset-gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_LOW>;
+	};
+
 	vcc12v_dcin: vcc12v_dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -147,6 +158,17 @@ vcc_sys: vcc_sys {
 		regulator-max-microvolt = <4400000>;
 		vin-supply = <&vbus>;
 	};
+
+	/* sourced from vcc_sys, sdio module operates internally at 3.3v */
+	vcc_wl: vcc_wl {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_wl";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc_sys>;
+	};
 };
 
 &cpu0 {
@@ -475,6 +497,12 @@ pmic_int_l: pmic-int-l {
 		};
 	};
 
+	sdio-pwrseq {
+		wifi_enable_h: wifi-enable-h {
+			rockchip,pins = <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	vcc_sd {
 		vcc_sd_h: vcc-sd-h {
 			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -516,6 +544,21 @@ &sdmmc0 {
 	status = "okay";
 };
 
+&sdmmc1 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&sdio_pwrseq>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&sdmmc1_bus4 &sdmmc1_cmd &sdmmc1_clk>;
+	sd-uhs-sdr104;
+	vmmc-supply = <&vcc_wl>;
+	vqmmc-supply = <&vcc_1v8>;
+	status = "okay";
+};
+
 &spdif {
 	status = "okay";
 };
-- 
2.25.1

