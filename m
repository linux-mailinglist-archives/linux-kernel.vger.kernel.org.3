Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB34C538CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244812AbiEaIUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244803AbiEaIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:20:37 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0F894192;
        Tue, 31 May 2022 01:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653985236; x=1685521236;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=BoRHEhmXOmNIOBa5CqhzjrVqvcyzix0+s0h6h6w44iU=;
  b=oUOSW/Yzvk8AyWOMgnubd1rvX5kKTp7nDb65bcRp0/jMAhpJ3a1/PFvE
   eOfpOBCh/whTg0tCR9F98wROQJh60aX7XUwwsCvMqyfSNwh5+PWz3QhXE
   55Svn1j9ppGR6EODb1HWlo3AlODyKEsOhQgOC1CRMdeuabCxNq6EmwO7c
   k=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 31 May 2022 01:20:35 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 01:20:34 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 01:20:34 -0700
Received: from hu-harshq-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 01:20:30 -0700
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
        Harsh Agarwal <quic_harshq@quicinc.com>
Subject: [PATCH 1/3] dt-bindings: usb: dwc3: Add support for multiport related properties
Date:   Tue, 31 May 2022 13:50:15 +0530
Message-ID: <1653985217-20953-2-git-send-email-quic_harshq@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653985217-20953-1-git-send-email-quic_harshq@quicinc.com>
References: <1653985217-20953-1-git-send-email-quic_harshq@quicinc.com>
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

Added support for multiport, mport, num-ssphy and num-hsphy
properties. These properties are used to support devices having
a multiport controller.

Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
---
 .../devicetree/bindings/usb/snps,dwc3.yaml         | 55 ++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index f4471f8..9d916c72 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -341,6 +341,34 @@ properties:
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
@@ -369,4 +397,31 @@ examples:
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
+        MP_1: mport@1 {
+          usb-phy = <&usb2_phy0>, <&usb3_phy0>;
+          /* Can define Generic PHYs also */
+        };
+
+        MP_2: mport@2 {
+          usb-phy = <&usb2_phy1>, <&usb3_phy1>;
+        };
+
+        MP_3: mport@3 {
+          usb-phy = <&usb2_phy2>;
+        };
+
+        MP_4: mport@4 {
+          usb-phy = <&usb2_phy3>;
+        };
+
+      };
+    };
 ...
-- 
2.7.4

