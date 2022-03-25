Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C6B64E7905
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376823AbiCYQhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376830AbiCYQhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:37:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43D46353E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:35:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id j13so8599469plj.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vuo48/5UjA2yQzB+PByGgiIu31mZpEWOqyTsnJLyEqQ=;
        b=SzQxj8qNpsMaxeCLsWbqemfif+nS7Nx0yY3hFGwC+UVqnMu1eUnKrzuHJoXeDr8ZPx
         lbWaddUi/hK/qGA80WoKkqwJKWbl4OV7hMUpwpChw2Z1dkM/DA1PMyHgWgjWIr+5d/jO
         /jnajvyDobN+vohCnPYpKavXTpGA0BEBPAUbG697j8zOC0u/bkpA9PTbXu8esvdcyJ7W
         eph+5DSq1uxDQEInxAYWsORbYsxdxihI4fQw/esq/Oz+YzITfftGcWet+ScAiuPdDpXD
         0+7XUyCuW6192cgPd62C9bmEEA9ghTmB40DKVn919tlYmrnNRd+lG7692f2SM226TRbO
         3mWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vuo48/5UjA2yQzB+PByGgiIu31mZpEWOqyTsnJLyEqQ=;
        b=NJc95F0MtpLxG14WzUajohvWA0lUbok8Dg6PrWiKprJsDwilN/9hReJUa6M1+u+Ceq
         7tQP+gNJ3cYljClJ/digcV8Ezcl1iqsNYosikLU+SXqd9ETxitMBkfMC4cVrull0QKiL
         n6c7OyoZadrBTXXsy5l6cywXAB+z3mms5o6KfsaWumdPjAvtCoJPwSqPcgVyUSNm3Wv0
         uuMFTSRZERZaUVbk3Qzu3yI++mdHz/KcIBm2p5jBTGI2qnfTZgzfL92ASe0OhziIZwmA
         iUyZqZAQ550HQ+pV1kqeH2uohSnzstlaWnyhTppI4QuT9DlglluXD+Gi7obLYvL6Q2DB
         ESMg==
X-Gm-Message-State: AOAM530DztKVZFxYKxlJdMruh4UeyT47RtjkLXIAWSxPBAOeR5Qg8vbX
        1MY1GGH/Wd6REbL4JnI5Hk+Ilw==
X-Google-Smtp-Source: ABdhPJyc4Y08PpVXzp2jSoMl0/csbbpfohBnNxo5otTm+e88v/sKaDnS0hjJO54UoHNd/DJKXKyt9g==
X-Received: by 2002:a17:902:7405:b0:154:68e6:9bdb with SMTP id g5-20020a170902740500b0015468e69bdbmr12630282pll.15.1648226159061;
        Fri, 25 Mar 2022 09:35:59 -0700 (PDT)
Received: from localhost.localdomain ([223.233.78.42])
        by smtp.gmail.com with ESMTPSA id j6-20020a17090a588600b001c699d77503sm6264948pji.2.2022.03.25.09.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 09:35:58 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        bjorn.andersson@linaro.org, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v4 2/2] arm64: dts: qcom: sa8155p-adp: Enable ethernet node
Date:   Fri, 25 Mar 2022 22:05:37 +0530
Message-Id: <20220325163537.1579969-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325163537.1579969-1-bhupesh.sharma@linaro.org>
References: <20220325163537.1579969-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vinod Koul <vkoul@kernel.org>

Enable the ethernet node, add the phy node and pinctrl for ethernet.

Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
[bhsharma: Correct ethernet/rgmii related pinmuxs, specify multi-queues and
 plug in the PHY interrupt for WOL]
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8155p-adp.dts | 146 +++++++++++++++++++++++
 1 file changed, 146 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
index 8756c2b25c7e..e7b527a1cf7f 100644
--- a/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8155p-adp.dts
@@ -47,6 +47,65 @@ vreg_s4a_1p8: smps4 {
 
 		vin-supply = <&vreg_3p3>;
 	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xC>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+		snps,tx-sched-wrr;
+
+		queue0 {
+			snps,weight = <0x10>;
+			snps,dcb-algorithm;
+			snps,priority = <0x0>;
+		};
+
+		queue1 {
+			snps,weight = <0x11>;
+			snps,dcb-algorithm;
+			snps,priority = <0x1>;
+		};
+
+		queue2 {
+			snps,weight = <0x12>;
+			snps,dcb-algorithm;
+			snps,priority = <0x2>;
+		};
+
+		queue3 {
+			snps,weight = <0x13>;
+			snps,dcb-algorithm;
+			snps,priority = <0x3>;
+		};
+	};
 };
 
 &apps_rsc {
@@ -317,6 +376,44 @@ &remoteproc_cdsp {
 	firmware-name = "qcom/sa8155p/cdsp.mdt";
 };
 
+&ethernet {
+	status = "okay";
+
+	snps,reset-gpio = <&tlmm 79 GPIO_ACTIVE_LOW>;
+	snps,reset-active-low;
+	snps,reset-delays-us = <0 11000 70000>;
+
+	snps,ptp-ref-clk-rate = <250000000>;
+	snps,ptp-req-clk-rate = <96000000>;
+
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&ethernet_defaults>;
+
+	phy-handle = <&rgmii_phy>;
+	phy-mode = "rgmii";
+	max-speed = <1000>;
+
+	mdio {
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		compatible = "snps,dwmac-mdio";
+
+		/* Micrel KSZ9031RNZ PHY */
+		rgmii_phy: phy@7 {
+			reg = <0x7>;
+
+			interrupt-parent = <&tlmm>;
+			interrupts-extended = <&tlmm 124 IRQ_TYPE_EDGE_FALLING>; /* phy intr */
+			device_type = "ethernet-phy";
+			compatible = "ethernet-phy-ieee802.3-c22";
+		};
+	};
+};
+
 &uart2 {
 	status = "okay";
 };
@@ -407,4 +504,53 @@ mux {
 			drive-strength = <2>;
 		};
 	};
+
+	ethernet_defaults: ethernet-defaults {
+		mdc {
+			pins = "gpio7";
+			function = "rgmii";
+			bias-pull-up;
+		};
+
+		mdio {
+			pins = "gpio59";
+			function = "rgmii";
+			bias-pull-up;
+		};
+
+		rgmii-rx {
+			pins = "gpio117", "gpio118", "gpio119", "gpio120", "gpio115", "gpio116";
+			function = "rgmii";
+			bias-disable;
+			drive-strength = <2>;
+		};
+
+		rgmii-tx {
+			pins = "gpio122", "gpio4", "gpio5", "gpio6", "gpio114", "gpio121";
+			function = "rgmii";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+
+		phy-intr {
+			pins = "gpio124";
+			function = "emac_phy";
+			bias-disable;
+			drive-strength = <8>;
+		};
+
+		pps {
+			pins = "gpio81";
+			function = "emac_pps";
+			bias-disable;
+			drive-strength = <8>;
+		};
+
+		phy-reset {
+			pins = "gpio79";
+			function = "gpio";
+			bias-pull-up;
+			drive-strength = <16>;
+		};
+	};
 };
-- 
2.35.1

