Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E285A1A71
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 22:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243792AbiHYUhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 16:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235039AbiHYUgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 16:36:55 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEEFB7EC3;
        Thu, 25 Aug 2022 13:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661459815; x=1692995815;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LBevIAHgSqMYiw3E6VyoUV5+sLMM3CLXoMdyzz13uTQ=;
  b=shvSvNkrvOQeDYcy46Gyt05BuihBFyh2Xeo7fbNkrgutt770aL27Z4Mb
   d17x+uvsfWDXcNmF1zz8mj/zV1IOeIV9q8YUEafTdDXRux9/3UgqxLykJ
   BE3VG+LzI2Tv55kIEz47UzzQrwqLTLGNW+1rlrmvS7P6X2PLZ8QxoAYtB
   unEB61vWok2U0OZfnOUZ+8ipgDnO7uV6ktbRJxbF/DSKTTU9UBhW8Qn1i
   hro6Gsr15I7Aa7q3/PwpQQdakFfvAZAiDxCJQ69qbX/LhtxdctmW6eNvY
   KNSefl9u/EGxNfrj+9C9NGLq8o8juk3Wqz/RpSLZEv0oICLHKzuKEYtS9
   g==;
X-IronPort-AV: E=Sophos;i="5.93,264,1654585200"; 
   d="scan'208";a="110790085"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Aug 2022 13:36:54 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 25 Aug 2022 13:36:52 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 25 Aug 2022 13:36:51 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <UNGLinuxDriver@microchip.com>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: lan9662-otpc: document Lan9662 OTPC
Date:   Thu, 25 Aug 2022 22:40:40 +0200
Message-ID: <20220825204041.1485731-2-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220825204041.1485731-1-horatiu.vultur@microchip.com>
References: <20220825204041.1485731-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Lan9662 OTP controller.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 .../nvmem/microchip,lan9662-otpc.yaml         | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
new file mode 100644
index 000000000000..3307f6a7a373
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/microchip,lan9662-otpc.yaml
@@ -0,0 +1,42 @@
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
+    items:
+      - const: microchip,lan9662-otpc
+      - const: microchip,lan9668-otpc
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

