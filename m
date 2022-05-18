Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7140552B924
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 13:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbiERLtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbiERLtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:49:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D50179C20;
        Wed, 18 May 2022 04:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652874549; x=1684410549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K3dlaykSFHWsDcu0MDylqIPhXIfyaCnFB+tcjTZ90bk=;
  b=0/BJbn0FOSB3K1VOewPVdlF1qEyQJoslbd5KLV2i1kg6/+e4Lp6u24oP
   V6+vjFNKU0eo5djPBTep+UviQC1X7GSZ74uB4REc/x1zyUZWsm2TlrSWr
   mXtiaugn4TAepmoHj+O5mahs2yNUlEYal1qSLrhOiaR8mXE6kTYM2WjTR
   aoccFnAQ916V1HZ8GzRe4GZLKcufioMdNMIkfzojDUhzayQbVAiCMhDYC
   a6KXnRKsibYGoSyA+OU9f/MVPVYdT8ZVtTuwvgfac1b9NmIsuQnNDnw5C
   Ppf0J67ja0LbRaQ6q4qHgC/S2DYMnQ7EdrW9JQtYae7lQPXoBDbhyAPIp
   A==;
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="164583737"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 May 2022 04:49:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 18 May 2022 04:49:09 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Wed, 18 May 2022 04:49:07 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Date:   Wed, 18 May 2022 14:51:28 +0300
Message-ID: <20220518115129.908787-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220518115129.908787-1-claudiu.beznea@microchip.com>
References: <20220518115129.908787-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document Microchip OTP controller.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 .../nvmem/microchip,sama7g5-otpc.yaml         | 50 +++++++++++++++++++
 .../nvmem/microchip,sama7g5-otpc.h            | 12 +++++
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
 create mode 040000 include/dt-bindings/nvmem
 create mode 100644 include/dt-bindings/nvmem/microchip,sama7g5-otpc.h

diff --git a/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
new file mode 100644
index 000000000000..c3c96fd0baac
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/microchip,sama7g5-otpc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip SAMA7G5 OTP Controller (OTPC)
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea@microchip.com>
+
+description: |
+  OTP controller drives a NVMEM memory where system specific data
+  (e.g. calibration data for analog cells, hardware configuration
+  settings, chip identifiers) or user specific data could be stored.
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
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/nvmem/microchip,sama7g5-otpc.h>
+
+    otpc: efuse@e8c00000 {
+        compatible = "microchip,sama7g5-otpc", "syscon";
+        reg = <0xe8c00000 0xec>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        temperature_calib: calib@1 {
+            reg = <OTP_PKT(1) 76>;
+        };
+    };
+
+...
diff --git a/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h b/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
new file mode 100644
index 000000000000..f570b23165a2
--- /dev/null
+++ b/include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
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
+#endif
-- 
2.34.1

