Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A353852CB0D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbiESE2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiESE2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:28:30 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEA752B0D;
        Wed, 18 May 2022 21:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652934507; x=1684470507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=qvbvLhVScimkHnlHK7CN1dr8SHlBZa93m82JcYL5Xgs=;
  b=u/AdLK2ysEQKO6FHCa9ZFDDhrulIeCieVPnfz6uC+Q5ZiwvB3j4FuMnZ
   zzOkSfF5/jyN5A/GoLxX2nTkwg+egG1iDhGRDRRAm82gSXa6ArJ8OyiHW
   74t6vgJJD5q4HUuYDUMwsZgJ7/4YjfQ16MatFRf2zCPfcOcC/WLif9PtB
   Q=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 18 May 2022 21:28:27 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 21:28:26 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 21:28:25 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 18 May 2022 21:28:19 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v6 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy override params bindings
Date:   Thu, 19 May 2022 09:58:07 +0530
Message-ID: <1652934489-23386-2-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1652934489-23386-1-git-send-email-quic_kriskura@quicinc.com>
References: <1652934489-23386-1-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>

Add device tree bindings for SNPS phy tuning parameters.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 1ce251d..daeeb04 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -53,6 +53,102 @@ properties:
   vdda33-supply:
     description: phandle to the regulator 3.3V supply node.
 
+  qcom,hs-disconnect-bp:
+    description:
+      This adjusts the voltage level for the threshold used to
+      detect a disconnect event at the host. Possible values are.
+      The values defined are in multiples of basis points (1bp = 0.01%).
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: -272
+    maximum: 2156
+
+  qcom,squelch-detector-bp:
+    description:
+      This adjusts the voltage level for the threshold used to
+      detect valid high-speed data.
+      The values defined are in multiples of basis points (1bp = 0.01%).
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: -2090
+    maximum: 1590
+
+  qcom,hs-amplitude-bp:
+    description:
+      This adjusts the high-speed DC level voltage.
+      The values defined are in multiples of basis points (1bp = 0.01%).
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: -660
+    maximum: 2670
+
+  qcom,pre-emphasis-duration-bp:
+    description:
+      This signal controls the duration for which the
+      HS pre-emphasis current is sourced onto DP<#> or DM<#>.
+      The HS Transmitter pre-emphasis duration is defined in terms of
+      unit amounts. One unit of pre-emphasis duration is approximately
+      650 ps and is defined as 1X pre-emphasis duration.
+      The values defined are in multiples of basis points (1bp = 0.01%).
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: 10000
+    maximum: 20000
+
+  qcom,pre-emphasis-amplitude-bp:
+    description:
+      This signal controls the amount of current sourced to
+      DP<#> and DM<#> after a J-to-K or K-to-J transition.
+      The HS Transmitter pre-emphasis current is defined in terms of unit
+      amounts. One unit amount is approximately 2 mA and is defined as
+      1X pre-emphasis current.
+      The values defined are in multiples of basis points (1bp = 0.01%).
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: 10000
+    maximum: 40000
+
+  qcom,hs-rise-fall-time-bp:
+    description:
+      This adjusts the rise/fall times of the high-speed waveform.
+      The values defined are in multiples of basis points (1bp = 0.01%).
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: -4100
+    maximum: 5430
+
+  qcom,hs-crossover-voltage-microvolt:
+    description:
+      This adjusts the voltage at which the DP<#> and DM<#>
+      signals cross while transmitting in HS mode.
+      The values defined are in milli volts. The hardware accepts only
+      discrete values. The value closest to the provided input will be
+      chosen as the override value for this param.
+    minimum: -31000
+    maximum: 28000
+
+  qcom,hs-output-impedance-micro-ohms:
+    description:
+      In some applications, there can be significant series resistance
+      on the D+ and D- paths between the transceiver and cable. This adjusts
+      the driver source impedance to compensate for added series
+      resistance on the USB. The values defined are in milli ohms.
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: -2300000
+    maximum: 6100000
+
+  qcom,ls-fs-output-impedance-bp:
+    description:
+      This adjusts the low- and full-speed single-ended source
+      impedance while driving high. The following adjustment values are based
+      on nominal process, voltage, and temperature.
+      The values defined are in multiples of basis points (1bp = 0.01%).
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: -1053
+    maximum: 1310
+
 required:
   - compatible
   - reg
-- 
2.7.4

