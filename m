Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E96C483DE0
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiADIMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiADIMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:12:05 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA4BC061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 00:12:04 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id s1so74485552wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 00:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjC9RoatGf4NuVo6mZRinaRaNOZbl6EwcNrtjHiT4O4=;
        b=6ScPUR6RRUF4Hkoa6MmmfZ0Jm19OyRs5f/VHCuLH3o3qfhAhnqHb565uq5tXaACcdI
         x8D0QB84cRQaHye70QlbPApmyxr9DFZiz6uIb4D1VA9HvBZxFlt1dtA+MSyRqjPYkckI
         Xr8lRHaagCRg2zY92rQSigDefATaIiyPTEgfz+uaBFquyZoP5rpys+9oLaUDk/VDGL/Q
         JZOEje4yn+C96isl5CfXCDFWoXShitrc38EsrTFF1EVyLxq0q3eHY1vbA7ufrdzPv/0i
         2wzQXSxVvczstzmy5UmtBMY24rEhGB5yFC5ud1HU+y6iLboyDkv+QdTYLLV4NDvWvlZd
         bWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EjC9RoatGf4NuVo6mZRinaRaNOZbl6EwcNrtjHiT4O4=;
        b=QUQpAGRM2jgv8WP9Okf14wHGxEKSiXeJ+CtsyjHvzGLvWlHM6JLVj4a1bukWRceNyQ
         QkG1FkxsKs/286C5NcsBu60D1Sf4XiiaSmge5Vz1XrkWSaSNa78VoiEgIk2fydU7qonu
         6+lPD8+fa3eo1Rs19Q/T2HCPWNAwdJpA2slptj/SHJti6zIUfXWtoVaxOi9zQd7lbDUE
         MqYoKbxrZ6kvBm9l9n5KeKOmfBZ7qPf1qFjaJbKHQlWq+PnRuMhdZ7VZL7b19dlg9i9R
         XBUd0QJoucxl0ZE+cpg73kFmyjXq2YQVFyYty49zg1Mi9waIWNMQcCx4iZQgYRVaX5Yh
         JJrg==
X-Gm-Message-State: AOAM531smVA4d53gga+QppsiCOgCtIC05yIeI66K4+fHep8hVmZ3w2hu
        DlTSokCwB4o+Qvm02M9AKP5z2Q==
X-Google-Smtp-Source: ABdhPJxngzms95ImKdpuvaRPcAr7DbG1IH2gK3IFD3//AZsi/g458BwAO4hwAJC5ygGk+OCzXSJeYw==
X-Received: by 2002:a05:6000:1a8a:: with SMTP id f10mr42207306wry.248.1641283923156;
        Tue, 04 Jan 2022 00:12:03 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f6da:6ac:481:1df0])
        by smtp.gmail.com with ESMTPSA id j3sm36608295wrt.14.2022.01.04.00.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 00:12:02 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-oxnas@groups.io
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] ARM: dts: ox810se: Add Ethernet support
Date:   Tue,  4 Jan 2022 09:11:55 +0100
Message-Id: <20220104081155.91120-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220103175638.89625-1-narmstrong@baylibre.com>
References: <20220103175638.89625-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for the embedded Synopsys DWMAC Ethernet controller.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm/boot/dts/ox810se-wd-mbwe.dts |  4 ++++
 arch/arm/boot/dts/ox810se.dtsi        | 18 ++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/ox810se-wd-mbwe.dts b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
index 7e2fcb220aea..c59e06ff2423 100644
--- a/arch/arm/boot/dts/ox810se-wd-mbwe.dts
+++ b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
@@ -103,6 +103,10 @@ rtc0: rtc@48 {
 	};
 };
 
+&etha {
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/ox810se.dtsi b/arch/arm/boot/dts/ox810se.dtsi
index 0755e5864c4a..96c0745f7b70 100644
--- a/arch/arm/boot/dts/ox810se.dtsi
+++ b/arch/arm/boot/dts/ox810se.dtsi
@@ -81,6 +81,24 @@ soc {
 		ranges;
 		interrupt-parent = <&intc>;
 
+		etha: ethernet@40400000 {
+			compatible = "oxsemi,ox810se-dwmac", "snps,dwmac";
+			reg = <0x40400000 0x2000>;
+			interrupts = <8>;
+			interrupt-names = "macirq";
+			mac-address = [000000000000]; /* Filled in by U-Boot */
+			phy-mode = "rgmii";
+
+			clocks = <&stdclk 6>, <&gmacclk>;
+			clock-names = "gmac", "stmmaceth";
+			resets = <&reset 6>;
+
+			/* Regmap for sys registers */
+			oxsemi,sys-ctrl = <&sys>;
+
+			status = "disabled";
+		};
+
 		apb-bridge@44000000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
-- 
2.25.1

