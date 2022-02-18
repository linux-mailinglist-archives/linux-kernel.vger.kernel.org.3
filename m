Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282454BAE8B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbiBRAcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:32:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiBRAcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:32:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F80B9D55;
        Thu, 17 Feb 2022 16:31:33 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o24so11774245wro.3;
        Thu, 17 Feb 2022 16:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mDdreRXJ1jcR3nb7IeEbosk47g+037b18zNC6xkXo6k=;
        b=Yl4FthzV4r0l1kAee3K+r9PsxkMDJSxVHujMUCrTAUO+YdMzQBu3KkV10XKa5E9JUV
         yhFq9hO7q7z9FaY6lnJgt1E/s3vjTJ7OCdTEwbXyRjlE65Csx5fXztJW4Srxk1mRMzbT
         t+nly6tqTpGVAmlVqadR3cVwF5XTFTVtvMGrTkqcwtw8LkdTG3vZgkqsNwikd16Ltotx
         a9vaiAD8PZMbIR3oyPhfu+/vAmrK7iPqPY0y+VKlx9i+mDm1qU5L+tw5UcuHj7GHhynR
         YpXiOgwP3BF71fYSHaD5xFTJ+bEdqDYIBLvp6MJ0sbjLNcSt56gF7AEH/Ll/m6oLUgmS
         jkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mDdreRXJ1jcR3nb7IeEbosk47g+037b18zNC6xkXo6k=;
        b=VQDVqgSUzMcd4nMbFR94uNuBNaRc6oJJGRP0Bs6TN47oPLrS08QgzgxgGi6hjTTAwm
         ig0Izi3i+lK8GMZw12BwBfoclKiaxjsZyMjRaG/IUC/dQH7yabQWwuor3zI3MjMhNzo7
         Sp0KRGaOsGOs6Va4wMTY/13zfxKqOdXCVeo6RC2gZ22AVieFijhwWFkboWhxrgkCPf3P
         tXMyjxxUk11CfHtc1NGq1qu8CLxJ1kB0YCSA29xO1fa8eD2tvF5DJNIVPWxKiKrRZqe1
         llMredgDRWIvFVP33EFYjxkpjVDNwYsd7aXKs3QpVpX5vCpwPKDixZg+VK9iDCVFESZM
         JmHw==
X-Gm-Message-State: AOAM532m1f9nol+QSejJw26F80ieH60QwvjNuRnogDGXYra//AqBlnMC
        EUXxp0/jRNB6mbu6i12JrwM=
X-Google-Smtp-Source: ABdhPJxiQabqx3iNKad3cJKTJdRI1dFeCrBmzD46RcH3cR5/tA1wtp09VbS7UOggL6fQk/N6Mp9Rpg==
X-Received: by 2002:a05:6000:2c6:b0:1e4:a103:3986 with SMTP id o6-20020a05600002c600b001e4a1033986mr4289475wry.58.1645144212578;
        Thu, 17 Feb 2022 16:30:12 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id d29sm3640406wra.63.2022.02.17.16.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 16:30:12 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v2 18/18] ARM: dts: qcom: add ipq8065 dtsi
Date:   Fri, 18 Feb 2022 01:29:56 +0100
Message-Id: <20220218002956.6590-19-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220218002956.6590-1-ansuelsmth@gmail.com>
References: <20220218002956.6590-1-ansuelsmth@gmail.com>
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

