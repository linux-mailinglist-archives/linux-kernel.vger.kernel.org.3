Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CBC476426
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhLOVD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbhLOVDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:03:12 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDC0C06175B;
        Wed, 15 Dec 2021 13:03:09 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id a11so21370505qkh.13;
        Wed, 15 Dec 2021 13:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eZzjv6PEcKc8tKRxH0kjZUoCXyO3M8rdYy6VBQjMZIk=;
        b=j/cbQ7ZkNwbCC4EnPjBRyMUYWeEcRvj1dQ2i+c2ancEl6Kw5PCtNOXjz2wR25eyXoY
         WBKYz6vds2J4v7pSSAx6xqfGLhUvuHYBa/KeVHXlsNIJTiCDY6Y2nkFV+m7Rn9RfhEt1
         Y0E/bkmZZdY9mMpZTM0fNEaywocnxf4FmSm11UOnBBKLFGhm7FzI4YsePYARb5mxAibk
         ueujdVekwICe6DthNPzT42QAWB8mlhY1Yxik6i2ugk65ALKVM3skLDsiael+IF023Evo
         ncHq2G0b7HOiETEHH/GpbL52PtuxqsC6Y860j3jIezesYi525qkx/hYDA77Ukra6HiHp
         U1kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZzjv6PEcKc8tKRxH0kjZUoCXyO3M8rdYy6VBQjMZIk=;
        b=4BsZlwluAZWoYcLzt6iO7PSUJlpC9SrTec+QyW69I1zUg4uXDUOpxN2EGvYq00z1VX
         R3U3fvDHI8Hu7oVbyXMkvasHVBjYnFPjnXRuDvtIl6TLbJYyMUMlUcQG3Et283uLAyUB
         ZkpzkPBcEov6KKVGBE4wpHNrM9GWTAa8g8zR7Pu4nlLLPSEKuLTP0klGz0YPtGODJ345
         KJJNUf1csmuq1u9n+ipObcGtOU90M0qlshfogwlSDRNWQoCpIxCd+SwAXFw6rYEWSIzq
         tfp4Hw89FVXxQ9tB05Mr7dJ96eiwhqMuoXqzLTbLtvAfKHl1D0eOZWfZkJteZV0iwHGW
         kXmw==
X-Gm-Message-State: AOAM533MYqTYfZYsOTVWyEL8lz9l1o3YYKnhf5Ipacct8/y9KemK5bSV
        6AnoqaSoUcMSRjOwIu0JC/c=
X-Google-Smtp-Source: ABdhPJzR1emnZ2WdfeP0+0vXOW/jlCE4yfiLz/eq6GEZ9SkRx5xm+EuQbaRIYJbqmRQAUnEFLhHvtA==
X-Received: by 2002:a05:620a:1253:: with SMTP id a19mr10174631qkl.293.1639602188652;
        Wed, 15 Dec 2021 13:03:08 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.md.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id a20sm1644356qkh.63.2021.12.15.13.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:03:08 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] arm64: dts: rockchip: add Quartz64-A usb2 support
Date:   Wed, 15 Dec 2021 16:02:52 -0500
Message-Id: <20211215210252.120923-9-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215210252.120923-1-pgwipeout@gmail.com>
References: <20211215210252.120923-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the nodes and regulators to enable usb2 support on the Quartz64
Model A.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net>

---
 .../boot/dts/rockchip/rk3566-quartz64-a.dts   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
index 4d4b2a301b1a..e5a70ff4e920 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
@@ -124,6 +124,22 @@ vcc5v0_usb: vcc5v0_usb {
 		vin-supply = <&vcc12v_dcin>;
 	};
 
+	/* all four ports are controlled by one gpio
+	 * the host ports are sourced from vcc5v0_usb
+	 * the otg port is sourced from vcc5v0_midu
+	 */
+	vcc5v0_usb20_host: vcc5v0_usb20_host {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb20_host";
+		enable-active-high;
+		gpio = <&gpio4 RK_PB5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc5v0_usb20_host_en>;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v0_usb>;
+	};
+
 	vcc3v3_sd: vcc3v3_sd {
 		compatible = "regulator-fixed";
 		enable-active-low;
@@ -477,6 +493,12 @@ pmic_int_l: pmic-int-l {
 		};
 	};
 
+	usb2 {
+		vcc5v0_usb20_host_en: vcc5v0-usb20-host-en {
+			rockchip,pins = <4 RK_PB5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	vcc_sd {
 		vcc_sd_h: vcc-sd-h {
 			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
@@ -546,3 +568,33 @@ bluetooth {
 &uart2 {
 	status = "okay";
 };
+
+&u2phy1_host {
+	phy-supply = <&vcc5v0_usb20_host>;
+	status = "okay";
+};
+
+&u2phy1_otg {
+	phy-supply = <&vcc5v0_usb20_host>;
+	status = "okay";
+};
+
+&u2phy1 {
+	status = "okay";
+};
+
+&usb_host0_ehci {
+	status = "okay";
+};
+
+&usb_host0_ohci {
+	status = "okay";
+};
+
+&usb_host1_ehci {
+	status = "okay";
+};
+
+&usb_host1_ohci {
+	status = "okay";
+};
-- 
2.25.1

