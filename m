Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA35648F393
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiAOA4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231624AbiAOA4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:56:43 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D169C06161C;
        Fri, 14 Jan 2022 16:56:43 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id b3so5422233plc.7;
        Fri, 14 Jan 2022 16:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mv9y2F1yD1R3tg/trx+ktowkw03PiJgNgeaAhqzGrdM=;
        b=HaGJZIfudAm0DksoiMOEk6RTlXfGyZJrshYIC9K6AeXtdWWTSezKMTVoript6cW2yU
         Lcj7Hj4am2yemON+xxSTmTuw6JxSX8t3jY67K8ZV+amUYGTIe7nXWgdUzq7LbDoc+kgn
         zHRbTWlZ9UPwnHz11hAVoCgZC7zVG6zHyfKMs9ColIpWks3t4/Kplf54N7+P8/RGHTwv
         jLE3lngPQ9PQ68urJo7AiAWEnaBGu8nqGlYdvNJBPlf7/PFedrqDTc5W+6HMhDzILctK
         dAdqdr5W5rkGsZKeJGGy4XBm5McPjBmlNMr5K6hxKm+fsjyjSMhAwgYmJfRtwnJ3lNvx
         pWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mv9y2F1yD1R3tg/trx+ktowkw03PiJgNgeaAhqzGrdM=;
        b=iALqrZhOEofAx5FR4d3z9YUJQYi9+1RVa11vKosmx4dJ2oAr5CpyTBfqJzpnS4lox6
         1X6OCgeVmThNCxOj13h91m+cnuN2JAXKei4AIDle8T/8GPylXeVjmh6IGLkJH42FSmNa
         9AfUbz5RvMvaQEU0TJ04elFS+wU4n9kZ9d6VrU96dx8ngn88P/Sw06MdvuQpVyzn52KP
         MqsAM2je/maukWNsEMotqOIt82QE7QAgj3AU4Hyqy37VymfvptKolE24e81DVVpVynUR
         znXd3zm/gGXUoxJiw3qE+bESJYwnH7+HjlQ+e8o9skMhLkvdxPMpg0463Www98DxyXYQ
         Sj0w==
X-Gm-Message-State: AOAM530wjRYxWhXtTC986Mq3mghIFcgjD/WYXaOIt4zmoURdBhvel3oY
        qYzpe5pBdN+bS8CjgWXlhK2nQIUIL+E=
X-Google-Smtp-Source: ABdhPJwedNStvdSXf9tKnFjRCPPTyVOTy7aUqnbqlHGDropFhJHjjCju5BCP+wcobgYyHrLGMU6RXg==
X-Received: by 2002:a17:90b:1e4c:: with SMTP id pi12mr1298721pjb.224.1642208202437;
        Fri, 14 Jan 2022 16:56:42 -0800 (PST)
Received: from localhost.localdomain (1-171-7-64.dynamic-ip.hinet.net. [1.171.7.64])
        by smtp.gmail.com with ESMTPSA id j18sm5335570pgb.27.2022.01.14.16.56.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jan 2022 16:56:41 -0800 (PST)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, heikki.krogerus@linux.intel.com
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang@richtek.com
Subject: [PATCH v2 1/2] dt-bindings: usb: rt1719: Add binding for Richtek RT1719
Date:   Sat, 15 Jan 2022 08:56:30 +0800
Message-Id: <1642208191-7254-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1642208191-7254-1-git-send-email-u0084500@gmail.com>
References: <1642208191-7254-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add binding for Richtek RT1719.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 .../devicetree/bindings/usb/richtek,rt1719.yaml    | 85 ++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1719.yaml

diff --git a/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml b/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
new file mode 100644
index 00000000..65a93f7
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/richtek,rt1719.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/richtek,rt1719.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Richtek RT1719 sink-only Type-C PD controller bindings
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RT1719 is a sink-only USB Type-C contoller that complies with the latest
+  USB Type-C and PD standards. It does the USB Type-C detection including attach
+  and orientation. It integrates the physical layer of the USB BMC power
+  delivery protocol to allow up to 100W of power. The BMC PD block enables full
+  support for alternative interfaces of the Type-C specification.
+
+properties:
+  compatible:
+    enum:
+      - richtek,rt1719
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  wakeup-source:
+    description: enable IRQ remote wakeup, see power/wakeup-source.txt
+    type: boolean
+
+  connector:
+    type: object
+    $ref: ../connector/usb-connector.yaml#
+    description:
+      Properties for usb c connector.
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - connector
+  - interrupts
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c0 {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      rt1719@43 {
+        compatible = "richtek,rt1719";
+        reg = <0x43>;
+        interrupts-extended = <&gpio26 2 IRQ_TYPE_LEVEL_LOW>;
+        wakeup-source;
+
+        connector {
+          compatible = "usb-c-connector";
+          label = "USB-C";
+
+          ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+              reg = <0>;
+              endpoint {
+                remote-endpoint = <&usb_hs>;
+              };
+            };
+            port@1 {
+              reg = <1>;
+              endpoint {
+                remote-endpoint = <&usb_ss>;
+              };
+            };
+          };
+        };
+      };
+    };
+...
-- 
2.7.4

