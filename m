Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5668652A26E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 15:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346162AbiEQNAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 09:00:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347059AbiEQM7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:59:43 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F3E4EF47;
        Tue, 17 May 2022 05:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652792321; x=1684328321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ChdscaNYcNyAXcopz9BhhqP4M+pQrlts4cBNiLiQQeQ=;
  b=hu7r2NE7OjrMYLa42K01dBXIQ1HIb/2eqHPCoy8Td6vkKns6cNLtwoCK
   k+t46V4DolFnvJyQpdkxk1sXZEOSy0xRp7UtFKyD5hMy3sYdqyXpKJjvu
   etSRXeXDOArYRTVIv7NDNoIkpbCudVNRhchfspycWWHmB0gVGukwcxCV9
   nX9bpAFhpIuJfPmfqGdvtDyqehlXVqY4waSZ81l+Z4WOEaxxew5LVVTHG
   QEfvp+t/thSn5vuHHE/Rez0pxtSPz1cFQ0vBGe0php/QxbYvSS1wnSeRt
   qZGIWG6eBeueoSIG7MlDZ3EtHUCblIS+Af6Ik9Jw7Z/pXRQmUmF5YI2fU
   A==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="156388537"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2022 05:58:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 17 May 2022 05:58:36 -0700
Received: from ROB-ULT-M18063.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 17 May 2022 05:58:34 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <srinivas.kandagatla@linaro.org>, <robh+dt@kernel.org>,
        <krzk+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: microchip-otpc: document Microchip OTPC
Date:   Tue, 17 May 2022 15:58:21 +0300
Message-ID: <20220517125822.579580-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220517125822.579580-1-claudiu.beznea@microchip.com>
References: <20220517125822.579580-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 .../nvmem/microchip-sama7g5,otpc.yaml         | 50 +++++++++++++++++++
 .../nvmem/microchip-sama7g5,otpc.h            | 12 +++++
 2 files changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/microchip-sama7g5,otpc.yaml
 create mode 040000 include/dt-bindings/nvmem
 create mode 100644 include/dt-bindings/nvmem/microchip-sama7g5,otpc.h

diff --git a/Documentation/devicetree/bindings/nvmem/microchip-sama7g5,otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip-sama7g5,otpc.yaml
new file mode 100644
index 000000000000..e0cbdd8a47aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/microchip-sama7g5,otpc.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/microchip-sama7g5,otpc.yaml#
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
+    #include <dt-bindings/nvmem/microchip-sama7g5,otpc.h>
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
diff --git a/include/dt-bindings/nvmem/microchip-sama7g5,otpc.h b/include/dt-bindings/nvmem/microchip-sama7g5,otpc.h
new file mode 100644
index 000000000000..f570b23165a2
--- /dev/null
+++ b/include/dt-bindings/nvmem/microchip-sama7g5,otpc.h
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

