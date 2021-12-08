Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2BC46DBA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 19:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbhLHS6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 13:58:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbhLHS6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 13:58:38 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3687BC061746;
        Wed,  8 Dec 2021 10:55:06 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id g14so11318073edb.8;
        Wed, 08 Dec 2021 10:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aA9QuHSkCt8/8c94t58aibqLeTAdnjq+lN5RU1wTu9I=;
        b=CDnKIbNFxMnUsgfOfTLgQgZKNJEKfe9HevvvbpC+yxyrXH/vwAiGzG5rTXetNwiSvb
         lhR6LcJZODHOBM26KUBqQmmrnX/A3ikfnHgiQTRyOacDFxNB0UDLPS9o49Cg8wqWuzIN
         97hFHzOyP6Vo9gDfWbtrX0GrfFLq7vVF9wB9W66J8XNdbuzgt8HGUKU4niHbqrPBDb22
         y5T7rXZBRfM7d2haGnWIp6pwRZxxKquwrmz6mce3wALlwEL2k7GH8xrss2TkFysiSfBy
         q+vbx5IG4ZbAoCE/uV+fxeNyEl77WsBH6lFofDxfsUx8fRrewq6r6WWJiujbnnUixQYf
         KGXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aA9QuHSkCt8/8c94t58aibqLeTAdnjq+lN5RU1wTu9I=;
        b=MEBG+3pFj1QAVQ2vUj5HKXfYXfDP1wQuKH4EmBIBYDwj9Rxp+Rzs0x6nPCiodqh1/H
         AnM4OVq9+IOkpvaFdIrOmL2ZNUU+0ntx0xEmGz67z8oH+zXkLY0H1WsaUUewiq3imK7q
         bTXx4qJS2xWDniwb3fMsBp0IVeKoaUJJ674bwFCqnIafnXoqpZY+U52MNthj6WTy2caP
         091H06rJNxxvqTxRya1gnr6qhMrdz3oaJG1jEIlJ2Y+WlI+6ZCzGipJXYpCYhUw6iQKy
         bQEmBFZ62edGUgUqVW96wKugj3MQX/Y6a1ff5M0pwOzibDnXPWbbXaaU2t+rULcMYCHY
         /zfA==
X-Gm-Message-State: AOAM532ZylpVcHsUzXdil1bLKJ80Z0e5U8vpxiQwvDKRbbGX9tVF2RXl
        UUZMSXruys+bMMKXs/HVS1w=
X-Google-Smtp-Source: ABdhPJza71ZrvjJteVg1jbj/NBpHYxyQxQSQXiWu0g/XJGxBEfFwOeN6ncCFwjXLI9OOsWi5jWpHAg==
X-Received: by 2002:a17:906:eb8a:: with SMTP id mh10mr9119926ejb.198.1638989704522;
        Wed, 08 Dec 2021 10:55:04 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g18sm1862273ejt.36.2021.12.08.10.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 10:55:04 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        p.zabel@pengutronix.de, yifeng.zhao@rock-chips.com,
        kever.yang@rock-chips.com, cl@rock-chips.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 4/4] arm64: dts: rockchip: add naneng combo phy nodes for rk3568
Date:   Wed,  8 Dec 2021 19:54:49 +0100
Message-Id: <20211208185449.16763-5-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211208185449.16763-1-jbx6244@gmail.com>
References: <20211208185449.16763-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yifeng Zhao <yifeng.zhao@rock-chips.com>

Add the core dt-node for the rk3568's naneng combo phys.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V4:
  rename node name
  remove reset-names
  move #phy-cells
  add rockchip,rk3568-pipe-grf
  add rockchip,rk3568-pipe-phy-grf
---
 arch/arm64/boot/dts/rockchip/rk3568.dtsi | 21 +++++++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 47 ++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 2fd313a29..f11ab963b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -8,6 +8,11 @@
 / {
 	compatible = "rockchip,rk3568";
 
+	pipe_phy_grf0: syscon@fdc70000 {
+		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
+		reg = <0x0 0xfdc70000 0x0 0x1000>;
+	};
+
 	qos_pcie3x1: qos@fe190080 {
 		compatible = "rockchip,rk3568-qos", "syscon";
 		reg = <0x0 0xfe190080 0x0 0x20>;
@@ -71,6 +76,22 @@
 			queue0 {};
 		};
 	};
+
+	combphy0: phy@fe820000 {
+		compatible = "rockchip,rk3568-naneng-combphy";
+		reg = <0x0 0xfe820000 0x0 0x100>;
+		clocks = <&pmucru CLK_PCIEPHY0_REF>,
+			 <&cru PCLK_PIPEPHY0>,
+			 <&cru PCLK_PIPE>;
+		clock-names = "ref", "apb", "pipe";
+		assigned-clocks = <&pmucru CLK_PCIEPHY0_REF>;
+		assigned-clock-rates = <100000000>;
+		resets = <&cru SRST_P_PIPEPHY0>, <&cru SRST_PIPEPHY0>;
+		rockchip,pipe-grf = <&pipegrf>;
+		rockchip,pipe-phy-grf = <&pipe_phy_grf0>;
+		#phy-cells = <1>;
+		status = "disabled";
+	};
 };
 
 &cpu0_opp_table {
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 46d9552f6..2096fd820 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -214,11 +214,26 @@
 		};
 	};
 
+	pipegrf: syscon@fdc50000 {
+		compatible = "rockchip,rk3568-pipe-grf", "syscon";
+		reg = <0x0 0xfdc50000 0x0 0x1000>;
+	};
+
 	grf: syscon@fdc60000 {
 		compatible = "rockchip,rk3568-grf", "syscon", "simple-mfd";
 		reg = <0x0 0xfdc60000 0x0 0x10000>;
 	};
 
+	pipe_phy_grf1: syscon@fdc80000 {
+		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
+		reg = <0x0 0xfdc80000 0x0 0x1000>;
+	};
+
+	pipe_phy_grf2: syscon@fdc90000 {
+		compatible = "rockchip,rk3568-pipe-phy-grf", "syscon";
+		reg = <0x0 0xfdc90000 0x0 0x1000>;
+	};
+
 	pmucru: clock-controller@fdd00000 {
 		compatible = "rockchip,rk3568-pmucru";
 		reg = <0x0 0xfdd00000 0x0 0x1000>;
@@ -1077,6 +1092,38 @@
 		status = "disabled";
 	};
 
+	combphy1: phy@fe830000 {
+		compatible = "rockchip,rk3568-naneng-combphy";
+		reg = <0x0 0xfe830000 0x0 0x100>;
+		clocks = <&pmucru CLK_PCIEPHY1_REF>,
+			 <&cru PCLK_PIPEPHY1>,
+			 <&cru PCLK_PIPE>;
+		clock-names = "ref", "apb", "pipe";
+		assigned-clocks = <&pmucru CLK_PCIEPHY1_REF>;
+		assigned-clock-rates = <100000000>;
+		resets = <&cru SRST_P_PIPEPHY1>, <&cru SRST_PIPEPHY1>;
+		rockchip,pipe-grf = <&pipegrf>;
+		rockchip,pipe-phy-grf = <&pipe_phy_grf1>;
+		#phy-cells = <1>;
+		status = "disabled";
+	};
+
+	combphy2: phy@fe840000 {
+		compatible = "rockchip,rk3568-naneng-combphy";
+		reg = <0x0 0xfe840000 0x0 0x100>;
+		clocks = <&pmucru CLK_PCIEPHY2_REF>,
+			 <&cru PCLK_PIPEPHY2>,
+			 <&cru PCLK_PIPE>;
+		clock-names = "ref", "apb", "pipe";
+		assigned-clocks = <&pmucru CLK_PCIEPHY2_REF>;
+		assigned-clock-rates = <100000000>;
+		resets = <&cru SRST_P_PIPEPHY2>, <&cru SRST_PIPEPHY2>;
+		rockchip,pipe-grf = <&pipegrf>;
+		rockchip,pipe-phy-grf = <&pipe_phy_grf2>;
+		#phy-cells = <1>;
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3568-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.20.1

