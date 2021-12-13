Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4354D472269
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbhLMIYS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:24:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbhLMIYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:24:03 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014C7C0617A2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:24:03 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id v1so49769573edx.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 00:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8/8AKmWnw90DFb6B7PF4iq5fumUb+K6Z3Aw6VBfY+z8=;
        b=D9HefLZt+ts1nXZQn800eebajloSDymutWYMnZJwmzVTRpSnijW8g0RKq6BPaTS/q8
         CNTTtb1V9MPaeRnB3V57I+s2Qd7kmoKuATz1JJNWD4MZpCNfQsWQG9+4qfc8U6CFsyri
         YcYroSunyDeXypuGgG280DhT1podBpYMw4VPZMijTV1gGHUip7e3XIEfr6FElmrbOO/F
         eHWhQDGfb+jBeYBMrO2jBJ5piEX5jmTbm1LuQ3xfAqWU5n72DXXOnbR9MGvpSz8OX5xt
         ln7mKOdz2vOVrs+M+cTfdnK1tc5WiNrTW2s2t0Fot5JcK4AdTKxokH9ZYvPBpzSSusdp
         GSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8/8AKmWnw90DFb6B7PF4iq5fumUb+K6Z3Aw6VBfY+z8=;
        b=QvBP1xnxkUxqv4N8RSNgfh23dB2MjHwo16QZBuaGCK1ngyPxmBM5ECubdYHjR8gl06
         ph4jdRYrwXSMI90RPjnFTGMmARV7wlPHX/3eLXrcGO0fKl+3uQl/3QjjipmHBwoh9b2x
         hX/cmVl1NT5dcZA9cGfGoBEcc8Hxpf+78RTq3AcnyWXmEXRSUv8oolmO2fJprWal3TUx
         hOXBPaggpNmvXN/AYGyl9cZM40bFVvzni+xHuaw9kGgu1EorSlNMCMZi5J3S5XYp6XHi
         jhr24jfLYemOey1iOa6tu64uiJesjDbNYEDZRl8Q0NOMoyb7gvQgHTdHQGFgPtZysvHv
         hRPg==
X-Gm-Message-State: AOAM531aiAKoNH5FBjvHVR3xcT7ThTPLGyhhpdmITeFxq32BCOhr8HdW
        k9si1/aRHJ/3dH5Fu3/yDcTAsQ==
X-Google-Smtp-Source: ABdhPJx/KKlVqiepCCfPU+AAbJjN0Qv76YpnNjgnYbuAI8eYXASvrOr/cgVyAjFV8pn7/FxbMl7xmw==
X-Received: by 2002:a05:6402:40d2:: with SMTP id z18mr61860198edb.395.1639383841650;
        Mon, 13 Dec 2021 00:24:01 -0800 (PST)
Received: from localhost.localdomain ([2a02:a210:20c5:8c80:7d0a:cd68:c339:f426])
        by smtp.gmail.com with ESMTPSA id nb17sm5535561ejc.7.2021.12.13.00.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 00:24:01 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] arm64: dts: qcom: sm6350: Add CDSP nodes
Date:   Mon, 13 Dec 2021 09:22:07 +0100
Message-Id: <20211213082208.21492-8-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213082208.21492-1-luca.weiss@fairphone.com>
References: <20211213082208.21492-1-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required nodes for booting the CDSP on sm6350.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 122 +++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 2ae7899bdc39..a7158fe9e192 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -385,6 +385,30 @@ smp2p_adsp_in: slave-kernel {
 		};
 	};
 
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_CDSP
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		smp2p_cdsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_cdsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	smp2p-mpss {
 		compatible = "qcom,smp2p";
 		qcom,smem = <435>, <428>;
@@ -630,6 +654,104 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
 			};
 		};
 
+		cdsp: remoteproc@8300000 {
+			compatible = "qcom,sm6350-cdsp-pas";
+			reg = <0 0x08300000 0 0x10000>;
+
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
+					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd SM6350_CX>,
+					<&rpmhpd SM6350_MX>;
+			power-domain-names = "cx", "mx";
+
+			memory-region = <&pil_cdsp_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_cdsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_CDSP
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "cdsp";
+				qcom,remote-pid = <5>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "cdsp";
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&apps_smmu 0x1401 0x20>;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_smmu 0x1402 0x20>;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x1403 0x20>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x1404 0x20>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x1405 0x20>;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x1406 0x20>;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+						iommus = <&apps_smmu 0x1407 0x20>;
+					};
+
+					compute-cb@8 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <8>;
+						iommus = <&apps_smmu 0x1408 0x20>;
+					};
+
+					/* note: secure cb9 in downstream */
+				};
+			};
+		};
+
 		sdhc_2: sdhci@8804000 {
 			compatible = "qcom,sm6350-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0 0x08804000 0 0x1000>;
-- 
2.34.1

