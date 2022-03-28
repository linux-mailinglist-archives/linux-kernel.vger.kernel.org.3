Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888DB4E8EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238731AbiC1HJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiC1HJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:09:08 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FE952B0C;
        Mon, 28 Mar 2022 00:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648451248; x=1679987248;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=iKKjbMlhQ9O01nA5FHTsRYbYntbRkkX3eUwWUELIyZk=;
  b=h6QVNuRuGd311JegZxqMGR2AHWMGXVfjaxpKWyI34JcqPolVHH2LpUE2
   enZxYiloBRnldrN9OVZwW0wyHGL4/KzUyjtsY7qi0heSx+6pU9MnhtVAC
   OuHyuJD8rn+2OwMnscKTWYQFEjIh0uXYMcwRuZb8H9E/7wVX3n/Tkqly1
   c=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 28 Mar 2022 00:07:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 00:07:27 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 28 Mar 2022 00:07:27 -0700
Received: from mpubbise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 28 Mar 2022 00:07:23 -0700
From:   Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>, <swboyd@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_sibis@quicinc.com>,
        <kuabhs@chromium.org>, <quic_pillair@quicinc.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
Subject: [PATCH v10] arm64: dts: qcom: sc7280: Add WPSS remoteproc node
Date:   Mon, 28 Mar 2022 12:37:01 +0530
Message-ID: <20220328070701.28551-1-quic_mpubbise@quicinc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rakesh Pillai <quic_pillair@quicinc.com>

Add the WPSS remoteproc node in dts for
PIL loading.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Rakesh Pillai <quic_pillair@quicinc.com>
Signed-off-by: Manikanta Pubbisetty <quic_mpubbise@quicinc.com>
---
Changes from v9:
- Rebased on ToT

Changes from v8:
- Enable remoteproc_wpss from sc7280-idp.dtsi as the change is common for IDP and IDP2

Changes from v7:
- Remove wpss_mem from reserved memory. Its part of board dtsi.

Changes from v6:
- Swap the oder of two properties in wpss_mem reserved memory

Changes from v5:
- Update the clock names
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi |  4 ++
 arch/arm64/boot/dts/qcom/sc7280.dtsi     | 51 ++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index ecbf2b89d896..069ffbc37bc4 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -547,3 +547,7 @@ sw_ctrl: sw-ctrl {
 	};
 };
 
+&remoteproc_wpss {
+	status = "okay";
+};
+
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index f0b64be63c21..b757e8ad1199 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2842,6 +2842,57 @@ qspi: spi@88dc000 {
 			status = "disabled";
 		};
 
+		remoteproc_wpss: remoteproc@8a00000 {
+			compatible = "qcom,sc7280-wpss-pil";
+			reg = <0 0x08a00000 0 0x10000>;
+
+			interrupts-extended = <&intc GIC_SPI 587 IRQ_TYPE_EDGE_RISING>,
+					      <&wpss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&wpss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&wpss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&wpss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&wpss_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover",
+					  "stop-ack", "shutdown-ack";
+
+			clocks = <&gcc GCC_WPSS_AHB_BDG_MST_CLK>,
+				 <&gcc GCC_WPSS_AHB_CLK>,
+				 <&gcc GCC_WPSS_RSCP_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "ahb_bdg", "ahb",
+				      "rscp", "xo";
+
+			power-domains = <&rpmhpd SC7280_CX>,
+					<&rpmhpd SC7280_MX>;
+			power-domain-names = "cx", "mx";
+
+			memory-region = <&wpss_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&wpss_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			resets = <&aoss_reset AOSS_CC_WCSS_RESTART>,
+				 <&pdc_reset PDC_WPSS_SYNC_RESET>;
+			reset-names = "restart", "pdc_sync";
+
+			qcom,halt-regs = <&tcsr_mutex 0x37000>;
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_WPSS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_WPSS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "wpss";
+				qcom,remote-pid = <13>;
+			};
+		};
+
 		dc_noc: interconnect@90e0000 {
 			reg = <0 0x090e0000 0 0x5080>;
 			compatible = "qcom,sc7280-dc-noc";
-- 
2.35.1

