Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88C0E4913B5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244559AbiARBji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:39:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244331AbiARBic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:32 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49CCC061748;
        Mon, 17 Jan 2022 17:38:30 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id z22so72915954edd.12;
        Mon, 17 Jan 2022 17:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yq6uO2vAiuohupuAuJSXxHBEg2PcebW3PTJtMbsfnEk=;
        b=lIBF57VlGnr3aIoO/JGsACy3o/DHCCYVu6FZgXhPxFijl+K2X76BFITh7dEtUJrOfz
         6cTODEDp8agJaY2cuJWdvQ4/76LWi6+snBKiuCo/mNdRfmrww64P/SpTuCMxMVS+L5dJ
         EEj5V0PRFh4qZ8MWzTuDVEN1sHrjpPO9olAWAqHpuqa6eW6WkSMCj1J965vqivmJDCdP
         jV1A3LAXhx/KISuwRC1bEdXnphyCHVwVjKRmV2LMVNGGlZ/Rbf57ohcLKN/+7E47tKvH
         oufJLLmG914Ugf2wlhAmnHV48hP5ekJIipK+hM9Sx0f0PTsluusnvrMtoq7XfBRjAfOY
         ZAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yq6uO2vAiuohupuAuJSXxHBEg2PcebW3PTJtMbsfnEk=;
        b=6WnOqz4iq1GI9lJTVcNnb4huTJwNR8w/YDr6/oMRMFz162OiWuxDbUC29mJKRjLyan
         sk3bJz2PQ9M+80DHytsnoTjmXHn38dAoWb6TWfXo4V4eNoKa8ZsKES/hlLO8lavE0hz3
         mqpuhQBUXR1HXy7WIx2PnoE8X1M0AKFULCsP//vSkm01/soHbIrt/9zdvb5yediDUjMj
         IaPx164umfs9y5jZSG6QHGBAl2efW5hKADcu+k69RsLjLkI5cnLH48I9bCREGDf9VXYQ
         VVYQLxpZGaLRKfBIbO+E0DG0wgrm+DkUT6DeNecbII/+16xs88RTLVtzdxjPJ2zoMQrH
         +1Zg==
X-Gm-Message-State: AOAM533E4FGUrN51Uw5kPzW2Shahe91YEzujRu0bGGHyo+z8gOZXR6q2
        yJapz6SfuHdF3Y+68/AZ2Qs=
X-Google-Smtp-Source: ABdhPJzcYIjuie0jisHVA8f3uzam1sAyJFmay5apbW/YLydbNBGQ/dBIBPt7WVrRP3LYFdscEci9Iw==
X-Received: by 2002:a50:9dc1:: with SMTP id l1mr22802037edk.231.1642469908794;
        Mon, 17 Jan 2022 17:38:28 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:28 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 17/17] ARM: dts: qcom: add ipq8065 dtsi
Date:   Tue, 18 Jan 2022 02:20:51 +0100
Message-Id: <20220118012051.21691-22-ansuelsmth@gmail.com>
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

