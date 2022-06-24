Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79805559DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 17:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbiFXPzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 11:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiFXPyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 11:54:53 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8839D220DD;
        Fri, 24 Jun 2022 08:54:52 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OACoqJ008409;
        Fri, 24 Jun 2022 17:54:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=7/bOI7TEIFVnFPcAJsm21Q38+kF86W/a+cDXQllSLJw=;
 b=DQ0lda7E7dCFGZyU+4r7q04qvD1IZIaacgx2zMzpkMY7nwVO2LSXUv5SywLtZE++4jl4
 MiXGUeXVy1bNHr6mPiaLs0utd1Exg5H3XBC4yaVlJ1UdRl5Vut1U8sW100bd915TZRUX
 Ncm66zHmr2sQRIX42+X9jp5ikENVtlnN15QVvtFa0Fp87s+GMXJlDzTMeNnH1qvI552N
 IbvaqKntn0i74DgfSangeEMY5SRtJWfUTNrZCCJ9MSwbQ9MpGM84U7N95DTSZuIC9ZBG
 1QwvIS+cIp7ThPwwrUMGw+v9FL5YP3EvAqrer5NsEHXF9NtSxYCZy8H11dms/QU6QQtt 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3gwbaqhn85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 17:54:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8C03E10003A;
        Fri, 24 Jun 2022 17:54:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 870C7226FB9;
        Fri, 24 Jun 2022 17:54:28 +0200 (CEST)
Received: from localhost (10.75.127.51) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 24 Jun
 2022 17:54:26 +0200
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <robh+dt@kernel.org>, <heikki.krogerus@linux.intel.com>,
        <gregkh@linuxfoundation.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <amelie.delaunay@foss.st.com>, <alexandre.torgue@foss.st.com>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH 1/4] dt-bindings: usb: typec: add bindings for stm32g0 controller
Date:   Fri, 24 Jun 2022 17:54:10 +0200
Message-ID: <20220624155413.399190-2-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
References: <20220624155413.399190-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_07,2022-06-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds DT schema documentation for the STM32G0 Type-C controller.
STM32G0 provides an integrated USB Type-C and power delivery interface.
It can be programmed with a firmware to handle UCSI protocol over I2C
interface. A GPIO is used as an interrupt line.
It may be used as a wakeup source, so use optional "wakeup-source" and
"power-domains" properties to support wakeup.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 .../bindings/usb/st,typec-stm32g0.yaml        | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml

diff --git a/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
new file mode 100644
index 0000000000000..b2729bd015a1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/st,typec-stm32g0.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/st,typec-stm32g0.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: STMicroelectronics STM32G0 Type-C controller bindings
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
+    allOf:
+      - $ref: ../connector/usb-connector.yaml#
+
+  firmware-name:
+    description: |
+      Should contain the name of the default firmware image
+      file located on the firmware search path
+
+  wakeup-source: true
+  power-domains: true
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
+    i2c5 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      stm32g0@53 {
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
+          port {
+            con_usb_c_ep: endpoint {
+              remote-endpoint = <&usbotg_hs_ep>;
+            };
+          };
+        };
+      };
+    };
+
+    usbotg_hs {
+      usb-role-switch;
+      port {
+        usbotg_hs_ep: endpoint {
+          remote-endpoint = <&con_usb_c_ep>;
+        };
+      };
+    };
+...
-- 
2.25.1

