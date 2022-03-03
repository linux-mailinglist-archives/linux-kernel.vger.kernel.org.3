Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E654CB6C9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 07:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiCCGOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 01:14:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiCCGOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 01:14:41 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9349114560C;
        Wed,  2 Mar 2022 22:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646288036; x=1677824036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=zyPTvh1c8RPn8sc5rNOcCfJp4uV5whVdkZZ2y239PwE=;
  b=gs4xzdJREQuiMzdO/0cvc7b5y+YhAmPwwOanBGsTxyzX32ttLOewj0Ki
   hC7/bYppqb0go9dqkWsiHUhtcA9ZLr71HjWlXfwSJFqFp74Ft59YvjGMM
   FHjM3ViBX6gzj+mU1q1gr9iLJmUe02rQSDHJJ0vgtTodQ/249wiNgmBWn
   o=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 02 Mar 2022 22:13:56 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 22:13:56 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Mar 2022 22:13:55 -0800
Received: from c-sanm-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 2 Mar 2022 22:13:50 -0800
From:   Sandeep Maheswaram <quic_c_sanm@quicinc.com>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wcheng@codeaurora.org>,
        "Stephen Boyd" <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>
Subject: [PATCH v2 1/3] dt-bindings: phy: qcom,usb-snps-femto-v2: Add phy override params bindings
Date:   Thu, 3 Mar 2022 11:43:29 +0530
Message-ID: <1646288011-32242-2-git-send-email-quic_c_sanm@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1646288011-32242-1-git-send-email-quic_c_sanm@quicinc.com>
References: <1646288011-32242-1-git-send-email-quic_c_sanm@quicinc.com>
MIME-Version: 1.0
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

Add device tree bindings for SNPS phy tuning parameters.

Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
---
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       | 125 +++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
index 0dfe691..227c097 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-snps-femto-v2.yaml
@@ -50,6 +50,131 @@ properties:
   vdda33-supply:
     description: phandle to the regulator 3.3V supply node.
 
+  qcom,hs-disconnect:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This adjusts the voltage level for the threshold used to
+      detect a disconnect event at the host. Possible values are.
+      7 -> +21.56%
+      6 -> +17.43%
+      5 -> +13.32%
+      4 -> +9.73%
+      3 -> +6.3
+      2 -> +3.17%
+      1 -> 0, Design default%
+      0 -> -2.72%
+
+  qcom,squelch-detector:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This adjusts the voltage level for the threshold used to
+      detect valid high-speed data. Possible values are
+      7-> -20.90%
+      6-> -15.60%
+      5-> -10.30%
+      4-> -5.30%
+      3-> 0, Design default%
+      2-> +5.30%
+      1-> +10.60%
+      0-> +15.90%
+
+  qcom,hs-amplitude:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This adjusts the high-speed DC level voltage.
+      Possible values are
+      15-> +26.70%
+      14-> +24.30%
+      13-> +22.20%
+      12-> +20.00%
+      11-> +17.80%
+      10-> +15.60%
+      9-> +13.30%
+      8-> +11.10%
+      7-> +8.90%
+      6-> +6.50%
+      5-> +4.40%
+      4-> +2.30%
+      3-> 0, Design default%
+      2-> -2.20%
+      1-> -4.40%
+      0-> -6.60%
+
+  qcom,pre-emphasis-duration:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This signal controls the duration for which the
+      HS pre-emphasis current is sourced onto DP<#> or DM<#>.
+      The HS Transmitter pre-emphasis duration is defined in terms of
+      unit amounts. One unit of pre-emphasis duration is approximately
+      650 ps and is defined as 1X pre-emphasis duration.
+      Possible values are
+      1-> 1x, short pre-emphasis current duration
+      0-> 2x, long pre-emphasis current duration
+
+  qcom,pre-emphasis-amplitude:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This signal controls the amount of current sourced to
+      DP<#> and DM<#> after a J-to-K or K-to-J transition.
+      The HS Transmitter pre-emphasis current is defined in terms of unit
+      amounts. One unit amount is approximately 2 mA and is defined as
+      1X pre-emphasis current.
+      Possible values are
+      3-> HS Transmitter pre-emphasis circuit sources 3x pre-emphasis
+      current.
+      2-> (design default) HS Transmitter pre-emphasis circuit sources 2x
+      pre-emphasis current.
+      1-> HS Transmitter pre-emphasis circuit sources 1x pre-emphasis
+      current.
+      0-> HS Transmitter pre-emphasis circuit sources 4x pre-emphasis
+      current.
+
+  qcom,hs-rise-fall-time:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This adjusts the rise/fall times of the high-speed waveform.
+      Possible values are
+      3-> -41.0%
+      2-> 0, Design default
+      1-> +28.1
+      0-> +54.3%
+
+  qcom,hs-crossover-voltage:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This adjusts the voltage at which the DP<#> and DM<#>
+      signals cross while transmitting in HS mode.
+      Possible values are
+      3-> 0, Default setting
+      2-> +28 mV
+      1-> -31 mV
+      0-> Reserved
+
+  qcom,hs-output-impedance:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      In some applications, there can be significant series resistance
+      on the D+ and D- paths between the transceiver and cable. This adjusts
+      the driver source impedance to compensate for added series
+      resistance on the USB.
+      3-> Source impedance is decreased by approximately 2.3 ohms
+      2-> 0, Design default
+      1-> Source impedance is increased by approximately 2.6 ohms
+      0-> Source impedance is increased by approximately 6.1 ohms
+
+  qcom,ls-fs-output-impedance:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      This adjusts the low- and full-speed single-ended source
+      impedance while driving high. The following adjustment values are based
+      on nominal process, voltage, and temperature.
+      15-> -10.53%
+      7-> -5.57%
+      3-> 0, Design default
+      1-> +6.12%
+      0-> +13.10%
+
 required:
   - compatible
   - reg
-- 
2.7.4

