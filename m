Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33204913B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244357AbiARBjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244293AbiARBi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:29 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F33AC06173F;
        Mon, 17 Jan 2022 17:38:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 30so72951616edv.3;
        Mon, 17 Jan 2022 17:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yq6uO2vAiuohupuAuJSXxHBEg2PcebW3PTJtMbsfnEk=;
        b=I5joL5GXCAlVOdaciFwFpLYC6GKkAt0ZnSwGZKS1C8X2qEmhyf4QwWL0iY8ONOXFEB
         HJS8WCZuwYfajwqkBpbA3Hn5br8DSY4aSME6gJuiQfyqhPuwncAAbnELYhYEXHkPmtZZ
         IszVrBMm3HfihPjLOIKOsgmL6Njkjk1U29sRR1Ve9RPXmuw1NaaWvpDhLqyFeKG46s0Y
         Oo5tqG8nE7vY4MEyySrrXuxktw84RipmO3HpbVhWkafpPCEnsxpQOn/Z+IKB/l6Ry3/t
         AJ8ZpTKRERQOYvQXT20NIqJT4erLlk4X3/SqBiLtSM40ZffoO+ZSQQLTSqpvoNVoBFzb
         O28w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yq6uO2vAiuohupuAuJSXxHBEg2PcebW3PTJtMbsfnEk=;
        b=qgdU7XsV/oV/5vjEiaztUvwpVxGkIRD4FUfyiitLAdAlz0tjBYLcugJ3aXXnF8QDQB
         jdHFAJx7icPjN/vV/ZHXmwaVL2Tl+cTG3ev2EmSHiEJ9rCBBFp+mAoZiRh/Q05ud49XA
         42ctYoihaPiubZV9q9PR1SgUAddUbKe6lD9WStPb1om+Mp4MvOif5hkjll6mHT1tTTL2
         c3LTddWxr6Jls+UWidqpW8ASM+a2fCf3RNnTlYbhfnqJGwskPPyy3+TGH1Yt0PVrrayl
         VKUvKagYUNTJnE4+5HWXWBH0KvionUpY5a52KyROv6kns0cozQDJnCcx8DAp3LFdDrVQ
         iinA==
X-Gm-Message-State: AOAM533ALnQLG90dDQCjOqX0x9BY0RRZTHz3aiCOL4ZReC0xd+iB/5yK
        pyUfaXJls2LZ2QAhyxqu2no=
X-Google-Smtp-Source: ABdhPJxFpMZkANvax5+ymg2Ulb7JFuSzMN8Vq/jQl0CoBy1CSb2Cl6R19w9J0onuZMf2JgGHZOnwhQ==
X-Received: by 2002:a05:6402:43ca:: with SMTP id p10mr22254842edc.74.1642469907570;
        Mon, 17 Jan 2022 17:38:27 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:27 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 16/16] ARM: dts: qcom: add ipq8065 dtsi
Date:   Tue, 18 Jan 2022 02:20:50 +0100
Message-Id: <20220118012051.21691-21-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.33.1

