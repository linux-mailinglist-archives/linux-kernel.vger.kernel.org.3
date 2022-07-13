Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5554C57360F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 14:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236347AbiGMMJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 08:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236348AbiGMMJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 08:09:15 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A63099A682;
        Wed, 13 Jul 2022 05:09:14 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26DAL7Uw002441;
        Wed, 13 Jul 2022 14:09:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=03MrTYHz9E1RnPfUmzk5doRoqAFETO2nHzzN60QH1u8=;
 b=F2wbiBc051D8/pWpYHvGLyno8XUwlYtD552WOAH7N+DPo7eANom7K7WKcBq3e89LycQ7
 oD9MH7sC58u1+TVi5akMFPXLkEpjBP6dIM950135vc0QE+W62lpiZbcmnqJVd1BXEYLH
 LheBGpJ6Wqd6HvFP5svKhEXAyad3xgynKxbCLaRK3bsXbhBt058vjPu+pPeN30ymxNDh
 dypW0Us5ZKPjG0SOy9ywI3VUKmSKZWlhfJVdKCXEfKQCv0xyb0u8kaBkSzhLQQQ4zoHb
 4O2fdxp7xyMu7c5R4S/6tNnb0BEhLqgaeQWoXDsLehF2lQDTcB7k0jCt9RQ5ZuI3vML/ kA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h9173su8s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Jul 2022 14:09:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B8CF110002A;
        Wed, 13 Jul 2022 14:09:02 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AF05E21ED52;
        Wed, 13 Jul 2022 14:09:02 +0200 (CEST)
Received: from localhost (10.75.127.47) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Wed, 13 Jul
 2022 14:09:02 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <christophe.jaillet@wanadoo.fr>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v3 1/3] dt-bindings: usb: typec: add bindings for stm32g0 controller
Date:   Wed, 13 Jul 2022 14:08:40 +0200
Message-ID: <20220713120842.560902-2-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713120842.560902-1-fabrice.gasnier@foss.st.com>
References: <20220713120842.560902-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-12_14,2022-07-13_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT schema documentation for the STM32G0 Type-C PD (Power Delivery)
controller.
STM32G0 provides an integrated USB Type-C and power delivery interface.
It can be programmed with a firmware to handle UCSI protocol over I2C
interface. A GPIO is used as an interrupt line.
It may be used as a wakeup source, so use optional "wakeup-source" and
"power-domains" properties to support wakeup.
The firmware itself may be flashed or later updated (optional). Choice is
let to the application to allow firmware update. A default firmware could
be already programmed in production and be customized (to not allow it).
So the firmware-name is made optional to represent this option.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- Add connector to the required properties as pointed out by Krzysztof.
  Update commit message to explain why the firmware-name is optional.
Changes in v2:
- Krzysztof's review comments: update commit message, use ports, use
  unevaluatedProperties: false for usb-connector schema, define maxItems
  for power-domains, adopt generic node names, remove quotes
---
 .../bindings/usb/st,typec-stm32g0.yaml        | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml

diff --git a/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
new file mode 100644
index 0000000000000..1cb68cabe17df
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/usb/st,typec-stm32g0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32G0 USB Type-C PD controller
+
+description: |
+  The STM32G0 MCU can be programmed to control Type-C connector(s) through I2C
+  typically using the UCSI protocol over I2C, with a dedicated alert
+  (interrupt) pin.
+
+maintainers:
+  - Fabrice Gasnier <fabrice.gasnier@foss.st.com>
+
+properties:
+  compatible:
+    const: st,stm32g0-typec
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  connector:
+    type: object
+    $ref: /schemas/connector/usb-connector.yaml#
+    unevaluatedProperties: false
+
+  firmware-name:
+    description: |
+      Should contain the name of the default firmware image
+      file located on the firmware search path
+
+  wakeup-source: true
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - connector
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      typec@53 {
+        compatible = "st,stm32g0-typec";
+        reg = <0x53>;
+        /* Alert pin on GPIO PE12 */
+        interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-parent = <&gpioe>;
+
+        /* Example with one type-C connector */
+        connector {
+          compatible = "usb-c-connector";
+          label = "USB-C";
+
+          ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            port@0 {
+              reg = <0>;
+              con_usb_c_ep: endpoint {
+                remote-endpoint = <&usb_ep>;
+              };
+            };
+          };
+        };
+      };
+    };
+
+    usb {
+      usb-role-switch;
+      port {
+        usb_ep: endpoint {
+          remote-endpoint = <&con_usb_c_ep>;
+        };
+      };
+    };
+...
-- 
2.25.1

