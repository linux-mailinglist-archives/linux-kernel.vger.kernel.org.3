Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A74521138
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 11:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239111AbiEJJqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 05:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbiEJJqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 05:46:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B1B3B28E;
        Tue, 10 May 2022 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652175757; x=1683711757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N1UY2lJOSZCEdX0it7pW1fnpV7O7kbLRhnZYTAMVwNE=;
  b=MIFMlatB0SWhmkJ0902NNRcQxAulofZxLRT0LViayzJW0bDKQSyklCEz
   puLauTpiA6YKmZ9oLMfvHcBzXpzovUCzLhbfAt3wm4Wlt43M/53PfWPBx
   O6OVw0TxdmccUKEic+nwmEa0qhdRaIwE0LrtipZ2VBd9dMus3b9RknAXO
   2txLVRWI00mFlvUAQotREJk+M3GqOkINAsITGil1bDqBvjHAcAfkXyTCn
   jjARJ6CJ7miL6PY7NwYnl0sy6epnJSxetcDmZn23N2IVRSZjYr8RoMhVy
   MzTmsmRtgJYDt3nlAQELD+xDUBnNeL6ICAongZoaLyGy4eyI5S3BXAL3s
   w==;
X-IronPort-AV: E=Sophos;i="5.91,214,1647327600"; 
   d="scan'208";a="155418765"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 May 2022 02:42:36 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 10 May 2022 02:42:36 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 10 May 2022 02:42:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Date:   Tue, 10 May 2022 12:44:56 +0300
Message-ID: <20220510094457.4070764-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220510094457.4070764-1-claudiu.beznea@microchip.com>
References: <20220510094457.4070764-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Microchip OTP controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../bindings/nvmem/microchip-otpc.yaml        | 55 +++++++++++++++++++
 include/dt-bindings/nvmem/microchip,otpc.h    | 18 ++++++
 2 files changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip-otpc.yaml
 create mode 040000 include/dt-bindings/nvmem
 create mode 100644 include/dt-bindings/nvmem/microchip,otpc.h

diff --git a/Documentation/devicetree/bindings/nvmem/microchip-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip-otpc.yaml
new file mode 100644
index 000000000000..a8df7fee5c2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/microchip-otpc.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/microchip-otpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip SAMA7G5 OTP Controller (OTPC) device tree bindings
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description: |
+  This binding represents the OTP controller found on SAMA7G5 SoC.
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    items:
+      - const: microchip,sama7g5-otpc
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/at91.h>
+    #include <dt-bindings/nvmem/microchip,otpc.h>
+
+    otpc: efuse@e8c00000 {
+        compatible = "microchip,sama7g5-otpc", "syscon";
+        reg = <0xe8c00000 0xec>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        temperature_calib: calib@1 {
+            reg = <OTP_PKT(1) OTP_PKT_SAMA7G5_TEMP_CALIB_LEN>;
+        };
+    };
+
+...
diff --git a/include/dt-bindings/nvmem/microchip,otpc.h b/include/dt-bindings/nvmem/microchip,otpc.h
new file mode 100644
index 000000000000..44b6ed3b8f18
--- /dev/null
+++ b/include/dt-bindings/nvmem/microchip,otpc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _DT_BINDINGS_NVMEM_MICROCHIP_OTPC_H
+#define _DT_BINDINGS_NVMEM_MICROCHIP_OTPC_H
+
+/*
+ * Need to have it as a multiple of 4 as NVMEM memory is registered with
+ * stride = 4.
+ */
+#define OTP_PKT(id)			((id) * 4)
+
+/*
+ * Temperature calibration packet length for SAMA7G5: 1 words header,
+ * 18 words payload.
+ */
+#define OTP_PKT_SAMA7G5_TEMP_CALIB_LEN	(19 * 4)
+
+#endif
-- 
2.34.1

