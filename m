Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED21449D713
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbiA0BAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:00:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234211AbiA0BAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:00:31 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B3BC06173B;
        Wed, 26 Jan 2022 17:00:31 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id e16so1239276qtq.6;
        Wed, 26 Jan 2022 17:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GxAKjAaT7xRmtbaC3UIIpwOLw+3uTtc8mu7tmoAjfy4=;
        b=Zz5yz1+UVMMTvLCtOtyv1ZgzZJE+2Lbq65e1LjBY2npGuew1iHnyPapsTtMOi75TUT
         OfHJYobE6UF154PgmJ07u8oVnSikBFm32KgAAf4mtcRE647MF4g+YG4nBr6+6dhU4AMR
         ZL9cs3fdTfoSbP5Re4bP3QUTpj+If2aBNL1cbldtmqrUa127ilFC6P2DZoEUOtm/0y33
         tobH1jDchHq7J0Kcwyj/26mufSQ+K42HYBfc04EGwlCLOVI5iVztHPK9bn4joRWodAK1
         4diVKf38TynRJDKMTWjngeHPelD3K13PgZtiMMDysSNIS0+N7ANcGX34PEGrquNOou7i
         e6aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GxAKjAaT7xRmtbaC3UIIpwOLw+3uTtc8mu7tmoAjfy4=;
        b=7Q9xJILXcuq2HoV7Xxi9xQq5DZxmhSeD/z5W5jFY/PPYWqqKOoiifVHwhhOMNiYb7t
         l8qttxQmynNqNWbmxdE47NHUbkltskAzLLvmkh8cg3xFbVwcQecmc7WXgFU/DazQvfyN
         nezOMeQfU2iYI4nb3byQgQG8FtTyjqRT7PUKw2v3Q84Q3gN5AYGC5Do2VBV7fMswb7VS
         83W6HmyPw9rzerO6yBbrjqveCnS3L9kp/vs7n6IbqfCl41iB5A58TmBVNYiRvaJlKfpi
         pBwzWNb+qJgRZcKSj8oA7pEklmvfs3EapsS4cbJ0gS5h5HnQSHwUJ8ULH36r09hsyB1j
         5jqw==
X-Gm-Message-State: AOAM533bqMicg1KiEuf940wLsvMqwLpFB2BmcVBUXSFrau85CVSpjqSO
        rK7cg2WedLNfybOuKUyzzNk=
X-Google-Smtp-Source: ABdhPJwg/dm6qzEciVkoxXvVnll6gPik2tZHun90f4n5bDYY8SUlJCOcYtpp5q5msQBnzLhJSOiGrQ==
X-Received: by 2002:ac8:578e:: with SMTP id v14mr1045070qta.345.1643245230206;
        Wed, 26 Jan 2022 17:00:30 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.dc.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id n2sm483389qti.59.2022.01.26.17.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:00:30 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: rockchip: add Quartz64-A sdmmc1 node
Date:   Wed, 26 Jan 2022 20:00:23 -0500
Message-Id: <20220127010023.3169415-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127010023.3169415-1-pgwipeout@gmail.com>
References: <20220127010023.3169415-1-pgwipeout@gmail.com>
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
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 33c2c18caaa9..1d73ac6557c5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -91,6 +91,18 @@ simple-audio-card,codec {
 		};
 	};
 
+	sdio_pwrseq: sdio-pwrseq {
+		status = "okay";
+		compatible = "mmc-pwrseq-simple";
+		clocks = <&rk817 1>;
+		clock-names = "ext_clock";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_enable_h>;
+		reset-gpios = <&gpio2 RK_PC2 GPIO_ACTIVE_LOW>;
+		post-power-on-delay-ms = <100>;
+		power-off-delay-us = <5000000>;
+	};
+
 	vcc12v_dcin: vcc12v_dcin {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc12v_dcin";
@@ -147,6 +159,17 @@ vcc_sys: vcc_sys {
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
@@ -475,6 +498,12 @@ pmic_int_l: pmic-int-l {
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
@@ -516,6 +545,22 @@ &sdmmc0 {
 	status = "okay";
 };
 
+&sdmmc1 {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	disable-wp;
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

