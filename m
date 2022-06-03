Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1534753CDDC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344290AbiFCRNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344276AbiFCRNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:13:00 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F86933883;
        Fri,  3 Jun 2022 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654276379; x=1685812379;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XWRmseNj/TXPSSv5UXCm5K5PY9LHAlx8KYtaV8T5AWI=;
  b=d4DlocTqUmU3tVZJCLV6mmEa9dMMXvMRsEiNtfjROV1BOK3aJroA77Ab
   l0wkC+d3QJIrRNM6dIj3MEmOFTn3c9JulW/AK/uo8Do3FrP4V9efBUSiH
   QYNe21W6DBXtE9CQb4ZZTk0dRKpibbm6wUy/b+n7yFysLsLoW4TUHTWn+
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Jun 2022 10:12:59 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 10:12:58 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 3 Jun 2022 10:12:58 -0700
Received: from hu-harshq-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 3 Jun 2022 10:12:53 -0700
From:   Harsh Agarwal <quic_harshq@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        <ahalaney@redhat.com>, Harsh Agarwal <quic_harshq@quicinc.com>
Subject: [PATCH v2 1/3] dt-bindings: usb: dwc3: Add support for multiport related properties
Date:   Fri, 3 Jun 2022 22:42:40 +0530
Message-ID: <1654276362-28930-2-git-send-email-quic_harshq@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654276362-28930-1-git-send-email-quic_harshq@quicinc.com>
References: <1654276362-28930-1-git-send-email-quic_harshq@quicinc.com>
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

Added support for multiport, mport, num_usb2_phy and num_usb3_phy
properties. These properties are used to support devices having
a multiport controller.

Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
---
 .../devicetree/bindings/usb/snps,dwc3.yaml         | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index d41265b..fdf3655 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -343,6 +343,34 @@ properties:
       This port is used with the 'usb-role-switch' property  to connect the
       dwc3 to type C connector.
 
+  multiport:
+    description:
+      If a single USB controller supports multiple ports, then it's referred to as
+      a multiport controller. Each port of the multiport controller can support
+      either High Speed or Super Speed or both and have their own PHY phandles. Each
+      port is represented by "mport" node and all the "mport" nodes are grouped
+      together inside the "multiport" node where individual "mport" node defines the
+      PHYs supported by that port.
+    required:
+      - mport
+
+  num_usb2_phy:
+    description: Total number of HS-PHYs defined by the multiport controller.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  num_usb3_phy:
+    description: Total number of SS-PHYs defined by the multiport controller.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  mport:
+    description: Each mport node represents one port of the multiport controller.
+    oneOf:
+       - required:
+         - usb-phy
+       - required:
+          - phys
+          - phy-names
+
 unevaluatedProperties: false
 
 required:
@@ -371,4 +399,31 @@ examples:
       snps,dis_u2_susphy_quirk;
       snps,dis_enblslpm_quirk;
     };
+  - |
+    usb@4a000000 {
+      compatible = "snps,dwc3";
+      reg = <0x4a000000 0xcfff>;
+      interrupts = <0 92 4>;
+
+      multiport {
+
+        MP_1: mport1 {
+          usb-phy = <&usb2_phy0>, <&usb3_phy0>;
+          /* Can define Generic PHYs also */
+        };
+
+        MP_2: mport2 {
+          usb-phy = <&usb2_phy1>, <&usb3_phy1>;
+        };
+
+        MP_3: mport3 {
+          usb-phy = <&usb2_phy2>;
+        };
+
+        MP_4: mport4 {
+          usb-phy = <&usb2_phy3>;
+        };
+
+      };
+    };
 ...
-- 
2.7.4

