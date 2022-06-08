Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E690E543A97
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbiFHRh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiFHRhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:37:52 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8346465C9;
        Wed,  8 Jun 2022 10:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654709869; x=1686245869;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=wMhDGPbL04Z+5AIvG+x6eCJD9ycH6ebgF9SegAsK34w=;
  b=iRvVShwGxXuyMshvg01obCgO9RYs9MPEOaY2tCEBjE3B8EJAO2MBj6EL
   GdpQQhvOWGAvODlRUsyalksf9TRZt0si/Fqsa0DzJnXlarhKe7pFBMn2L
   34HJYnVforRqqrNFcN6kc8eH9zUiGJZ0qYmsp5XbKLl4P2Ln06jiwvrfZ
   k=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Jun 2022 10:37:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 10:37:48 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 10:37:48 -0700
Received: from hu-harshq-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 8 Jun 2022 10:37:43 -0700
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
Subject: [PATCH v3 1/3] dt-bindings: usb: dwc3: Add support for multiport related properties
Date:   Wed, 8 Jun 2022 23:06:25 +0530
Message-ID: <1654709787-23686-2-git-send-email-quic_harshq@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654709787-23686-1-git-send-email-quic_harshq@quicinc.com>
References: <1654709787-23686-1-git-send-email-quic_harshq@quicinc.com>
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

Added support for multiport, mport, num_usb2_phy and num_usb3_phy
properties. These properties are used to support devices having
a multiport controller.

Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
---
 .../devicetree/bindings/usb/snps,dwc3.yaml         | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
index d41265b..9332fa2 100644
--- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
@@ -343,6 +343,32 @@ properties:
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
+      - required:
+        - usb-phy
+      - required:
+        - phys
+        - phy-names
+
 unevaluatedProperties: false
 
 required:
@@ -371,4 +397,31 @@ examples:
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

