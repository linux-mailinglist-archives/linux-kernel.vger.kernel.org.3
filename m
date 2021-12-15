Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB5D476425
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 22:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhLOVDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 16:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhLOVDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 16:03:12 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E269C061757;
        Wed, 15 Dec 2021 13:03:08 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id z9so23231795qtj.9;
        Wed, 15 Dec 2021 13:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z18VL31coTBk76De+PcvAvUu+q+yeDGJv5K7mB9qqFw=;
        b=J9XNv/fYF4yS+FKG6kZSUlwuAusLvMKrtMDyPR8xCHge5JwdPgXyNqGbO3WZ2k57S6
         gNGfa6c5M34B0eePU/pjcgxU6ULW07Pq5f4GcF1/WEysrwnDc0o1hx2mUT07I19B6u5c
         CmA4Y4Pz7L7kjg+j+tNUWsgMvUs2zrVv12uQ8Aey4oLRo7tqlKQX6JVMsXX1Ku6L13pc
         cJx5n7mxBm85gfqxhBhwCnP+d1DbXXvMOVUm3s1mINYqi9V8eyhJrP1D6d4VOR+8GcrE
         CcDnKvfpaYdhpw5Sfmm9Vju8LIBdm1navTKdX8rGtxgm5rKZGdDVQ+AybCnCxAlgEwM8
         kJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z18VL31coTBk76De+PcvAvUu+q+yeDGJv5K7mB9qqFw=;
        b=mMxOsnhzTh3qfnIPlNib3n3+bt0UQtAE7CvSgucf4XRv9ye7uKI4KX81+Gv+Lf2nWJ
         WYFGMThJbsMvAw9xr46flCHFw3OvWr/HtACNu9be+tm+2qgGDl9NBG1pRCJXLCUsPgxJ
         LFLADk7UAWU7z/V0TvqnaJEAZXHyP5p9u5p0fX8p7SsQxhfi6ERmYT43UhJYIizwjf2D
         7JxSHjjKyGo5c5iR7st+Hev7o26cjX5vZDIByu5HA2GFTVEG7B0Js7qP5zD+RK6SCz26
         Tk+CUcj7uz8uK3bHdxwVLS4KFo1+lefQ674J+x2TRVKsKmpOQ9lDH5LZHokPsZu3BgQ0
         vPJg==
X-Gm-Message-State: AOAM531jl/FojUyNvw72cyS347u/eGS+NyIiGjUY8FD4hsLZT+7v5uWh
        enob+PahwP2IIUUR9oAOuTg=
X-Google-Smtp-Source: ABdhPJwRLjnZxRAdAtPRk7bkReWkOSFDrqr33VbRi2bU1fO9JuxHDWcLtRB4jmdGyPjrw1tAYqQV6w==
X-Received: by 2002:a05:622a:1310:: with SMTP id v16mr14127043qtk.431.1639602187353;
        Wed, 15 Dec 2021 13:03:07 -0800 (PST)
Received: from master-x64.sparksnet (c-98-233-193-225.hsd1.md.comcast.net. [98.233.193.225])
        by smtp.gmail.com with ESMTPSA id a20sm1644356qkh.63.2021.12.15.13.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:03:06 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 7/8] arm64: dts: rockchip: add usb2 nodes to rk3568 device tree
Date:   Wed, 15 Dec 2021 16:02:51 -0500
Message-Id: <20211215210252.120923-8-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211215210252.120923-1-pgwipeout@gmail.com>
References: <20211215210252.120923-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the requisite nodes to the rk3568 device tree to enable the usb2
device controllers.
Includes the usb2phy nodes, usb2phy grf nodes, and usb2 controller
nodes.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Tested-by: Michael Riesch <michael.riesch@wolfvision.net>

---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 98 ++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 46d9552f6028..2c2b1014e53b 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -204,6 +204,50 @@ gic: interrupt-controller@fd400000 {
 		msi-controller;
 	};
 
+	usb_host0_ehci: usb@fd800000 {
+		compatible = "generic-ehci";
+		reg = <0x0 0xfd800000 0x0 0x40000>;
+		interrupts = <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_USB2HOST0>, <&cru HCLK_USB2HOST0_ARB>,
+			 <&cru PCLK_USB>;
+		phys = <&u2phy1_otg>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host0_ohci: usb@fd840000 {
+		compatible = "generic-ohci";
+		reg = <0x0 0xfd840000 0x0 0x40000>;
+		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_USB2HOST0>, <&cru HCLK_USB2HOST0_ARB>,
+			 <&cru PCLK_USB>;
+		phys = <&u2phy1_otg>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host1_ehci: usb@fd880000 {
+		compatible = "generic-ehci";
+		reg = <0x0 0xfd880000 0x0 0x40000>;
+		interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_USB2HOST1>, <&cru HCLK_USB2HOST1_ARB>,
+			 <&cru PCLK_USB>;
+		phys = <&u2phy1_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
+	usb_host1_ohci: usb@fd8c0000 {
+		compatible = "generic-ohci";
+		reg = <0x0 0xfd8c0000 0x0 0x40000>;
+		interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_USB2HOST1>, <&cru HCLK_USB2HOST1_ARB>,
+			 <&cru PCLK_USB>;
+		phys = <&u2phy1_host>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
 	pmugrf: syscon@fdc20000 {
 		compatible = "rockchip,rk3568-pmugrf", "syscon", "simple-mfd";
 		reg = <0x0 0xfdc20000 0x0 0x10000>;
@@ -219,6 +263,16 @@ grf: syscon@fdc60000 {
 		reg = <0x0 0xfdc60000 0x0 0x10000>;
 	};
 
+	usb2phy0_grf: syscon@fdca0000 {
+		compatible = "rockchip,rk3568-usb2phy-grf", "syscon";
+		reg = <0x0 0xfdca0000 0x0 0x8000>;
+	};
+
+	usb2phy1_grf: syscon@fdca8000 {
+		compatible = "rockchip,rk3568-usb2phy-grf", "syscon";
+		reg = <0x0 0xfdca8000 0x0 0x8000>;
+	};
+
 	pmucru: clock-controller@fdd00000 {
 		compatible = "rockchip,rk3568-pmucru";
 		reg = <0x0 0xfdd00000 0x0 0x1000>;
@@ -1077,6 +1131,50 @@ pwm15: pwm@fe700030 {
 		status = "disabled";
 	};
 
+	u2phy0: usb2phy@fe8a0000 {
+		compatible = "rockchip,rk3568-usb2phy";
+		reg = <0x0 0xfe8a0000 0x0 0x10000>;
+		clocks = <&pmucru CLK_USBPHY0_REF>;
+		clock-names = "phyclk";
+		clock-output-names = "clk_usbphy0_480m";
+		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,usbgrf = <&usb2phy0_grf>;
+		#clock-cells = <0>;
+		status = "disabled";
+
+		u2phy0_host: host-port {
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		u2phy0_otg: otg-port {
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+	};
+
+	u2phy1: usb2phy@fe8b0000 {
+		compatible = "rockchip,rk3568-usb2phy";
+		reg = <0x0 0xfe8b0000 0x0 0x10000>;
+		clocks = <&pmucru CLK_USBPHY1_REF>;
+		clock-names = "phyclk";
+		clock-output-names = "clk_usbphy1_480m";
+		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
+		rockchip,usbgrf = <&usb2phy1_grf>;
+		#clock-cells = <0>;
+		status = "disabled";
+
+		u2phy1_host: host-port {
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
+		u2phy1_otg: otg-port {
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3568-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.25.1

