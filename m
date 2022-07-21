Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4390657C467
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 08:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiGUG3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 02:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiGUG3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 02:29:34 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3B17859D;
        Wed, 20 Jul 2022 23:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1658384972; x=1689920972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=QW7iVWh3gKfo67N28LuCB4Ni59WEXn3l8rPFrudan4w=;
  b=CGke+2AVe26beC2FATkeI0RclLgnHlq4BWrZkHhauzBP8k9CoB6mCWyz
   u4cudgCC1pT92X6pbiomRvdRhuAQdmq5LqnyFrah37Sa9Us77pyNoAZCe
   LdX31+Fy6DYcIyjKHRwsCNlWjTEDbBkj0ky+HfjjrE6JqRVeZQPjqORdf
   0=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Jul 2022 23:29:31 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 23:29:30 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 23:29:30 -0700
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 20 Jul 2022 23:29:24 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Doug Anderson" <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Vinod Koul <vkoul@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_vpulyala@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v11 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy override params bindings
Date:   Thu, 21 Jul 2022 11:59:12 +0530
Message-ID: <1658384954-9506-2-git-send-email-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658384954-9506-1-git-send-email-quic_kriskura@quicinc.com>
References: <1658384954-9506-1-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandeep Maheswaram <quic_c_sanm@quicinc.com>

Add device tree bindings for SNPS phy tuning parameters.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 88 ++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 7a0e6a9..565ce5f 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -53,6 +53,94 @@ properties:
   vdda33-supply:
     description: phandle to the regulator 3.3V supply node.
 
+  qcom,hs-disconnect-bp:
+    description:
+      This adjusts the voltage level for the threshold used to
+      detect a disconnect event at the host.
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: -272
+    maximum: 2156
+
+  qcom,squelch-detector-bp:
+    description:
+      This adjusts the voltage level for the threshold used to
+      detect valid high-speed data.
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: -2090
+    maximum: 1590
+
+  qcom,hs-amplitude-bp:
+    description:
+      This adjusts the high-speed DC level voltage.
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
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: 10000
+    maximum: 40000
+
+  qcom,hs-rise-fall-time-bp:
+    description:
+      This adjusts the rise/fall times of the high-speed waveform.
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: -4100
+    maximum: 5430
+
+  qcom,hs-crossover-voltage-microvolt:
+    description:
+      This adjusts the voltage at which the DP<#> and DM<#>
+      signals cross while transmitting in HS mode.
+      The hardware accepts only discrete values. The value closest to the
+      provided input will be chosen as the override value for this param.
+    minimum: -31000
+    maximum: 28000
+
+  qcom,hs-output-impedance-micro-ohms:
+    description:
+      In some applications, there can be significant series resistance
+      on the D+ and D- paths between the transceiver and cable. This adjusts
+      the driver source impedance to compensate for added series
+      resistance on the USB. The hardware accepts only discrete values. The
+      value closest to the provided input will be chosen as the override value
+      for this param.
+    minimum: -2300000
+    maximum: 6100000
+
+  qcom,ls-fs-output-impedance-bp:
+    description:
+      This adjusts the low- and full-speed single-ended source
+      impedance while driving high. The following adjustment values are based
+      on nominal process, voltage, and temperature.
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

