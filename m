Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C24913AB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244282AbiARBi5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244172AbiARBiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:38:22 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FE6C06173F;
        Mon, 17 Jan 2022 17:38:22 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 15so39679288edx.9;
        Mon, 17 Jan 2022 17:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5kW0BTzBa7RxEctZKpkaYeSrHPk0eadUX1ztDwCvuoQ=;
        b=k7gOr+SnGNPrWHQeM+HqDJZXWnHj34AkXHJ8BH5cW7Sn3SRtWHyq7RuuxB0ipGOI4U
         cUM2gvyJTCSaHsPyilct0rp80qKfvbNq+sg8dj/tjRvQ+S5Ket/7o6lKtB3mTnrvifFI
         kvzH7YHozNtxkC2ODIalxH0mNNcGSEheVGal2Lck9+lJlYHJmbf+x4ERAyakJzfBak9Q
         YcBcZaW4WcT13Sx3I3wR9/SDbgtgmUabaKnum8AUmmIiWZaZ7OH6v97BbkG9xI3OPF/x
         OvBlh9S+giF1NRoPqQGCTDSp/SMqsSgIs+v9Sl/g+FjBp3Bi2/lyXtq22slksD+TElY1
         Elpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5kW0BTzBa7RxEctZKpkaYeSrHPk0eadUX1ztDwCvuoQ=;
        b=fuBO5HbPstzErbce3m+TwSi+knsw+1amW0eZhD6FsF3zbrL3TUkcvbAD+4lc1u7MiX
         QTNvvdOO344EqLtDyr3/HGSujL+WySrrBzf4O812GiEXI4DLjhjMv0qH87LDDGR8cPMD
         IYGiOP3sojmZ5ZgeTl3WXXnA/GsSJmRU+k80ChEE6GoLB2Ff+JlybyF+Ncn+NfjkyCgk
         5wxi9CBRx80/k8eBluJWStK1+/RNLfzFio3zVo5N3jLhbRHP+KK/nHFcSKua3oh3PeVj
         mXtjAIQErOGGytp/OG4IByxYzYeAf/Z6BNghLsjB6nF9ikpOkMavcIthuFZM51VBTpdt
         hAtA==
X-Gm-Message-State: AOAM533XUuRX9Oo2qo+xUA/IP3xM3wS8HDA+RtDxTr6B2dtfhLOjtE9F
        Ov3zboqlJeKXTl7bUa4Xfx8WOf4+Jcc=
X-Google-Smtp-Source: ABdhPJyyFi8n86BOQIah81Mg03koD59bG+A4ybnl5q2CfA1aqgdoQFJ7WiOgKXSBUQYkPRN2vJuFIA==
X-Received: by 2002:a17:906:3089:: with SMTP id 9mr3420413ejv.97.1642469900789;
        Mon, 17 Jan 2022 17:38:20 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id kj18sm3990675ejc.139.2022.01.17.17.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:38:20 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 12/17] ARM: dts: qcom: add opp table for cpu and l2 for ipq8064
Date:   Tue, 18 Jan 2022 02:20:42 +0100
Message-Id: <20220118012051.21691-13-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220118012051.21691-1-ansuelsmth@gmail.com>
References: <20220118012051.21691-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add opp table for cpu and l2 cache. The l2 cache won't work as it would
require a dedicated cpufreq driver to scale cache with core.

Opp-level is set based on the logic of
0: idle level
1: normal level
2: turbo level

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 99 +++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 6f9075489e58..1e6297d6f302 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -48,6 +48,105 @@ L2: l2-cache {
 		};
 	};
 
+	opp_table_l2: opp_table_l2 {
+		compatible = "operating-points-v2";
+
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <100000>;
+			opp-level = <0>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt = <1100000>;
+			clock-latency-ns = <100000>;
+			opp-level = <1>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1150000>;
+			clock-latency-ns = <100000>;
+			opp-level = <2>;
+		};
+	};
+
+	opp_table0: opp_table0 {
+		compatible = "operating-points-v2-kryo-cpu";
+		nvmem-cells = <&speedbin_efuse>;
+
+		/*
+		 * Voltage thresholds are <target min max>
+		 */
+		opp-384000000 {
+			opp-hz = /bits/ 64 <384000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1000000 950000 1050000>;
+			opp-microvolt-speed0-pvs1-v0 = <925000 878750 971250>;
+			opp-microvolt-speed0-pvs2-v0 = <875000 831250 918750>;
+			opp-microvolt-speed0-pvs3-v0 = <800000 760000 840000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <100000>;
+			opp-level = <0>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1050000 997500 1102500>;
+			opp-microvolt-speed0-pvs1-v0 = <975000 926250 1023750>;
+			opp-microvolt-speed0-pvs2-v0 = <925000 878750 971250>;
+			opp-microvolt-speed0-pvs3-v0 = <850000 807500 892500>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <100000>;
+			opp-level = <1>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1100000 1045000 1155000>;
+			opp-microvolt-speed0-pvs1-v0 = <1025000 973750 1076250>;
+			opp-microvolt-speed0-pvs2-v0 = <995000 945250 1044750>;
+			opp-microvolt-speed0-pvs3-v0 = <900000 855000 945000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <100000>;
+			opp-level = <1>;
+		};
+
+		opp-1000000000 {
+			opp-hz = /bits/ 64 <1000000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1150000 1092500 1207500>;
+			opp-microvolt-speed0-pvs1-v0 = <1075000 1021250 1128750>;
+			opp-microvolt-speed0-pvs2-v0 = <1025000 973750 1076250>;
+			opp-microvolt-speed0-pvs3-v0 = <950000 902500 997500>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <100000>;
+			opp-level = <1>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1200000 1140000 1260000>;
+			opp-microvolt-speed0-pvs1-v0 = <1125000 1068750 1181250>;
+			opp-microvolt-speed0-pvs2-v0 = <1075000 1021250 1128750>;
+			opp-microvolt-speed0-pvs3-v0 = <1000000 950000 1050000>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <100000>;
+			opp-level = <2>;
+		};
+
+		opp-1400000000 {
+			opp-hz = /bits/ 64 <1400000000>;
+			opp-microvolt-speed0-pvs0-v0 = <1250000 1187500 1312500>;
+			opp-microvolt-speed0-pvs1-v0 = <1175000 1116250 1233750>;
+			opp-microvolt-speed0-pvs2-v0 = <1125000 1068750 1181250>;
+			opp-microvolt-speed0-pvs3-v0 = <1050000 997500 1102500>;
+			opp-supported-hw = <0x1>;
+			clock-latency-ns = <100000>;
+			opp-level = <2>;
+		};
+	};
+
 	thermal-zones {
 		sensor0-thermal {
 			polling-delay-passive = <0>;
-- 
2.33.1

