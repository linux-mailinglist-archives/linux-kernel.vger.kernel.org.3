Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A3057017B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiGKMBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiGKMBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:01:47 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCAA37F8C;
        Mon, 11 Jul 2022 05:01:46 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26BB1qC9000697;
        Mon, 11 Jul 2022 14:01:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=jHypv5E2Ntg6iXVsvy1Ne3ieQ+rIz+C8sBC7FRD48UU=;
 b=vW4bZd/jCn66wdgq1ucTAX+nWsOI+ewsHPGNeO5MhBrjj+xAiq7wlzfmc9RGhvtLrOiM
 FTsrZ3RVO4AgsStSZD0TYONBvkYL5oubLWgdP2mQW6dEIief0UlMqt/fVX5gxyosAkPo
 IGHCrL3sVyNapt+qmzfdL6luVVqYPlDvW0ZsQdmlJz5bmi5vPFQILhm3SAxdx2ww/mub
 /3o3YVapTQC9N4UWBl4UJtfaIGfihpV9OZCrh1ZE7oOY7QxOc4mHeCwGt4y6bWcpXelL
 MGfkbacMha5LmsGoJBUHU5XXDf+iF/5aFG+v0tP2sHo+nYnCjU22fe6tc1tUv0q+rTfj Pw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3h6xtak5vd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 14:01:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0301F10002A;
        Mon, 11 Jul 2022 14:01:37 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id ED10E21ED2B;
        Mon, 11 Jul 2022 14:01:37 +0200 (CEST)
Received: from localhost (10.75.127.50) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Mon, 11 Jul
 2022 14:01:37 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <heikki.krogerus@linux.intel.com>, <gregkh@linuxfoundation.org>
CC:     <christophe.jaillet@wanadoo.fr>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v2 1/4] dt-bindings: usb: typec: add bindings for stm32g0 controller
Date:   Mon, 11 Jul 2022 14:01:19 +0200
Message-ID: <20220711120122.25804-2-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711120122.25804-1-fabrice.gasnier@foss.st.com>
References: <20220711120122.25804-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-11_17,2022-07-08_01,2022-06-22_01
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

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Krzysztof's review comments: update commit message, use ports, use
  unevaluatedProperties: false for usb-connector schema, define maxItems
  for power-domains, adopt generic node names, remove quotes
---
 .../bindings/usb/st,typec-stm32g0.yaml        | 90 +++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml

diff --git a/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
new file mode 100644
index 0000000000000..7b3a2c2124e38
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
@@ -0,0 +1,90 @@
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

