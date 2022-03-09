Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 608C54D39F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 20:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237472AbiCITRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 14:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237587AbiCITQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 14:16:43 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DD01107CF;
        Wed,  9 Mar 2022 11:15:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i5-20020a1c3b05000000b00389d0a5c511so79928wma.5;
        Wed, 09 Mar 2022 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rvxNskdQWtyUr6Vm9iIgIimkL29t5f+RxTZipG1T+VQ=;
        b=c39/4GzPy2oVZNoAz78/HPNmTLijbQ+mfzhimSMxAX6+LbTTiIZlxeP5EMXcKUdWZ3
         wEgjwfu/XfF4k9s2mYWbMSBVKGNhgvQ2lZexV6ag3qBnHQWnsg6M5TAFikJPWgqWwut1
         QmGWAnziQdP3+/Rbja14Buwy/EjqIJH+Pqhlya+AoBssNjI3NB+2DG789s7ftRje/omk
         cSq/dnSj8U6+Q4xgR71m+dfGuhfSwVE7L/ZJO5H3OaEpW/9OU8jER/7x3wZGZ5wSfVHO
         MLdMYyQXc3TG9uJgIKXbVvk2A4WR1yIa3MtO3Nb7B7uNuIGkNX96TveDlKmLoHyntuVa
         CfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rvxNskdQWtyUr6Vm9iIgIimkL29t5f+RxTZipG1T+VQ=;
        b=DSoW/ieOw2bH1/p8GXAZpvvaCfiNCd/y6eqmwNyXExX4Cak3ptEa0yWiFQHoJ2030P
         vXpwFgXPhtlkjb5I1d294yjqNfPCg+OYroVO8zb8V6GaRHYrISzsKb0kMQq6HVYG8y8x
         +NrtbL52do7A1V/y0qVM6kxgdGQQ5DWFZ9lyTrWeR+vPW+Qhro6fmH/5LwyYrV+krd5+
         sp28tQ+pV7Nb0E5I7R2bs1QV+rYgTRy1jBUROAHjF6NvslrQlEZ7T5bPJ7qQMXHG5oHw
         8nMYRHfT4ZkI1rTeXnpKhhpuzRyJ6X+5Hlf+m2LojZ7ay3TQ38XDVPryTqCp/d3b6S3W
         bdOw==
X-Gm-Message-State: AOAM532WFNYK1CVHz6MQEWnICAVPK3j1FOSBON/BpQ0Q6nJDkSLRGaSi
        oDv1JQK93gZSLvgY3ohRW5o=
X-Google-Smtp-Source: ABdhPJz+lmwgptiZrX2N9sBzrnc+hmxlxkNE0ukzRfA2I9Ate30B2wRBv/AKHeCbB1ARRc8PSWk4zQ==
X-Received: by 2002:a7b:c40e:0:b0:389:c4e2:8398 with SMTP id k14-20020a7bc40e000000b00389c4e28398mr677413wmi.105.1646853341055;
        Wed, 09 Mar 2022 11:15:41 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-79-47-249-147.retail.telecomitalia.it. [79.47.249.147])
        by smtp.googlemail.com with ESMTPSA id w6-20020a5d6806000000b002036515dda7sm2396699wru.33.2022.03.09.11.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 11:15:40 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH v3 18/18] ARM: dts: qcom: add ipq8065 dtsi
Date:   Wed,  9 Mar 2022 20:01:52 +0100
Message-Id: <20220309190152.7998-19-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309190152.7998-1-ansuelsmth@gmail.com>
References: <20220309190152.7998-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many device are based on ipq8065 SoC. Ipq8065 is an evolution of the
ipq8064 SoC (also named ipq8064-v3.0 from qsdk) that has all the
improvement from ipq8064-v2.0 with the addition of a more powerful CPU
that can now be clocked to 1.7Ghz, a quicker L2 cache that can be
clocked to 1.4Ghz. It also shipped with more powerful regulators to
provide the required voltage to the CPUs and L2.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8065.dtsi | 168 ++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8065.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq8065.dtsi b/arch/arm/boot/dts/qcom-ipq8065.dtsi
new file mode 100644
index 000000000000..817d723b0c88
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq8065.dtsi
@@ -0,0 +1,168 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "qcom-ipq8064.dtsi"
+
+/ {
+	model = "Qualcomm IPQ8065";
+	compatible = "qcom,ipq8065", "qcom,ipq8064";
+
+	aliases {
+		serial0 = &gsbi4_serial;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		rsvd@41200000 {
+			reg = <0x41200000 0x300000>;
+			no-map;
+		};
+	};
+};
+
+&gsbi4 {
+	qcom,mode = <GSBI_PROT_I2C_UART>;
+	status = "okay";
+
+	serial@16340000 {
+		status = "okay";
+	};
+	/*
+	 * The i2c device on gsbi4 should not be enabled.
+	 * On ipq806x designs gsbi4 i2c is meant for exclusive
+	 * RPM usage. Turning this on in kernel manifests as
+	 * i2c failure for the RPM.
+	 */
+};
+
+&pcie0 {
+	compatible = "qcom,pcie-ipq8064-v2";
+};
+
+&pcie1 {
+	compatible = "qcom,pcie-ipq8064-v2";
+};
+
+&pcie2 {
+	compatible = "qcom,pcie-ipq8064-v2";
+};
+
+&sata {
+	ports-implemented = <0x1>;
+};
+
+&smb208_s2a {
+	regulator-min-microvolt = <775000>;
+	regulator-max-microvolt = <1275000>;
+};
+
+&smb208_s2b {
+	regulator-min-microvolt = <775000>;
+	regulator-max-microvolt = <1275000>;
+};
+
+&ss_phy_0 {
+	qcom,rx-eq = <2>;
+	qcom,tx-deamp_3_5db = <32>;
+	qcom,mpll = <5>;
+};
+
+&ss_phy_1 {
+	qcom,rx-eq = <2>;
+	qcom,tx-deamp_3_5db = <32>;
+	qcom,mpll = <5>;
+};
+
+&opp_table_l2 {
+	/delete-node/opp-1200000000;
+
+	opp-1400000000 {
+		opp-hz = /bits/ 64 <1400000000>;
+		opp-microvolt = <1150000>;
+		clock-latency-ns = <100000>;
+		opp-level = <2>;
+	};
+};
+
+&opp_table0 {
+	/*
+	 * On ipq8065 1.2 ghz freq is not present
+	 * Remove it to make cpufreq work and not
+	 * complain for missing definition
+	 */
+
+	/delete-node/opp-1200000000;
+
+	/*
+	 * Voltage thresholds are <target min max>
+	 */
+	opp-384000000 {
+		opp-microvolt-speed0-pvs0-v0 = <975000 926250 1023750>;
+		opp-microvolt-speed0-pvs1-v0 = <950000 902500 997500>;
+		opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
+		opp-microvolt-speed0-pvs3-v0 = <900000 855000 945000>;
+		opp-microvolt-speed0-pvs4-v0 = <875000 831250 918750>;
+		opp-microvolt-speed0-pvs5-v0 = <825000 783750 866250>;
+		opp-microvolt-speed0-pvs6-v0 = <775000 736250 813750>;
+	};
+
+	opp-600000000 {
+		opp-microvolt-speed0-pvs0-v0 = <1000000 950000 1050000>;
+		opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
+		opp-microvolt-speed0-pvs2-v0 = <950000 902500 997500>;
+		opp-microvolt-speed0-pvs3-v0 = <925000 878750 971250>;
+		opp-microvolt-speed0-pvs4-v0 = <900000 855000 945000>;
+		opp-microvolt-speed0-pvs5-v0 = <850000 807500 892500>;
+		opp-microvolt-speed0-pvs6-v0 = <800000 760000 840000>;
+	};
+
+	opp-800000000 {
+		opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
+		opp-microvolt-speed0-pvs1-v0 = <1025000 973750 1076250>;
+		opp-microvolt-speed0-pvs2-v0 = <1000000 950000 1050000>;
+		opp-microvolt-speed0-pvs3-v0 = <975000 926250 1023750>;
+		opp-microvolt-speed0-pvs4-v0 = <950000 902500 997500>;
+		opp-microvolt-speed0-pvs5-v0 = <900000 855000 945000>;
+		opp-microvolt-speed0-pvs6-v0 = <850000 807500 892500>;
+	};
+
+	opp-1000000000 {
+		opp-microvolt-speed0-pvs0-v0 = <1100000 1045000 1155000>;
+		opp-microvolt-speed0-pvs1-v0 = <1075000 1021250 1128750>;
+		opp-microvolt-speed0-pvs2-v0 = <1050000 997500 1102500>;
+		opp-microvolt-speed0-pvs3-v0 = <1025000 973750 1076250>;
+		opp-microvolt-speed0-pvs4-v0 = <1000000 950000 1050000>;
+		opp-microvolt-speed0-pvs5-v0 = <950000 902500 997500>;
+		opp-microvolt-speed0-pvs6-v0 = <900000 855000 945000>;
+	};
+
+	opp-1400000000 {
+		opp-microvolt-speed0-pvs0-v0 = <1175000 1116250 1233750>;
+		opp-microvolt-speed0-pvs1-v0 = <1150000 1092500 1207500>;
+		opp-microvolt-speed0-pvs2-v0 = <1125000 1068750 1181250>;
+		opp-microvolt-speed0-pvs3-v0 = <1100000 1045000 1155000>;
+		opp-microvolt-speed0-pvs4-v0 = <1075000 1021250 1128750>;
+		opp-microvolt-speed0-pvs5-v0 = <1025000 973750 1076250>;
+		opp-microvolt-speed0-pvs6-v0 = <975000 926250 1023750>;
+		opp-level = <1>;
+	};
+
+	opp-1725000000 {
+		opp-hz = /bits/ 64 <1725000000>;
+		opp-microvolt-speed0-pvs0-v0 = <1262500 1199375 1325625>;
+		opp-microvolt-speed0-pvs1-v0 = <1225000 1163750 1286250>;
+		opp-microvolt-speed0-pvs2-v0 = <1200000 1140000 1260000>;
+		opp-microvolt-speed0-pvs3-v0 = <1175000 1116250 1233750>;
+		opp-microvolt-speed0-pvs4-v0 = <1150000 1092500 1207500>;
+		opp-microvolt-speed0-pvs5-v0 = <1100000 1045000 1155000>;
+		opp-microvolt-speed0-pvs6-v0 = <1050000 997500 1102500>;
+		opp-supported-hw = <0x1>;
+		clock-latency-ns = <100000>;
+		opp-level = <2>;
+	};
+};
-- 
2.34.1

