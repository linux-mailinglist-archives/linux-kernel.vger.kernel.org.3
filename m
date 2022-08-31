Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F495A76C5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 08:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiHaGjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 02:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230299AbiHaGjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 02:39:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2914FBD747;
        Tue, 30 Aug 2022 23:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661927943; x=1693463943;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9A047Y9A36oZIF5oyOmklCZ/mCHkfIM11RsfqujTooQ=;
  b=DZneOlEJqOLZYfRb25zsqWsJ4tto9xrCb3OQAUd0g1BguKPYnFjJt/1R
   64sFdnudvcOl0PxG5Czn5xbgiaVxuWHIuzOdXTamEo9f4n5CCirfHIfPP
   EX1K9lDGmdh/reWGGFcEXCRxEhBrg0qUCiFTS1g26snNwQjkngm13OpOT
   mVhnGDrlAwJQZtKu17w4lH599YTV3fqet1+LF31/9iLMH7JJtZ++cw5kU
   9jW9cgiu4ncOI9pX6MIARRkZtwzez5kT9yxB8xeEN/68dqJgcFnLrsqmL
   TQn7gKaSdkS2RUKuZ8EtA0w+b2qaJK/7GKQRad6B2xUHcap4NjsVFXjMN
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,277,1654585200"; 
   d="scan'208";a="174943673"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 23:39:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 23:39:00 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 30 Aug 2022 23:38:59 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <UNGLinuxDriver@microchip.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: lan9662-otpc: document Lan9662 OTPC
Date:   Wed, 31 Aug 2022 08:42:37 +0200
Message-ID: <20220831064238.102267-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220831064238.102267-1-horatiu.vultur@microchip.com>
References: <20220831064238.102267-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Lan9662 OTP controller.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../nvmem/microchip,lan9662-otpc.yaml         | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
new file mode 100644
index 000000000000..def20733cf60
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/microchip,lan9662-otpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN9662 OTP Controller (OTPC)
+
+maintainers:
+  - Horatiu Vultur <horatiu.vultur@microchip.com>
+
+description: |
+  OTP controller drives a NVMEM memory where system specific data
+  (e.g. hardware configuration settings, chip identifiers) or
+  user specific data could be stored.
+
+allOf:
+  - $ref: nvmem.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: microchip,lan9662-otpc
+          - const: microchip,lan9668-otpc
+      - enum:
+          - microchip,lan9662-otpc
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    otpc: otp@e0021000 {
+        compatible = "microchip,lan9662-otpc";
+        reg = <0xe0021000 0x300>;
+    };
+
+...
-- 
2.33.0

