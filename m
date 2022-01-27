Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564A449E5C2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243065AbiA0PRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:17:23 -0500
Received: from out28-218.mail.aliyun.com ([115.124.28.218]:53184 "EHLO
        out28-218.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242915AbiA0PRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:17:13 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5576189|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0234192-0.00181788-0.974763;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=icenowy@nucleisys.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.Mj85P.G_1643296629;
Received: from ice-e5v2.lan(mailfrom:icenowy@nucleisys.com fp:SMTPD_---.Mj85P.G_1643296629)
          by smtp.aliyun-inc.com(33.45.46.134);
          Thu, 27 Jan 2022 23:17:10 +0800
From:   Icenowy Zheng <icenowy@nucleisys.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, Icenowy Zheng <icenowy@nucleisys.com>
Subject: [PATCH 08/12] dt-bindings: riscv: add binding for Nuclei platform boards
Date:   Thu, 27 Jan 2022 23:16:43 +0800
Message-Id: <20220127151647.2375449-9-icenowy@nucleisys.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220127151647.2375449-1-icenowy@nucleisys.com>
References: <20220127151647.2375449-1-icenowy@nucleisys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we added support for RISC-V SoCs from Nuclei, add device tree binding
for the currently supported board-bitstream combo (DemoSoC with UX600 on
DDR200T board).

Signed-off-by: Icenowy Zheng <icenowy@nucleisys.com>
---
 .../devicetree/bindings/riscv/nuclei.yaml     | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/riscv/nuclei.yaml

diff --git a/Documentation/devicetree/bindings/riscv/nuclei.yaml b/Documentation/devicetree/bindings/riscv/nuclei.yaml
new file mode 100644
index 000000000000..4760568c7bde
--- /dev/null
+++ b/Documentation/devicetree/bindings/riscv/nuclei.yaml
@@ -0,0 +1,27 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/riscv/nuclei.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nuclei SoC-based boards
+
+maintainers:
+  - Icenowy Zheng <icenowy@nucleisys.com>
+
+description:
+  Nuclei SoC-based boards
+
+properties:
+  $nodename:
+    const: '/'
+  compatible:
+    oneOf:
+      - items:
+          - const: nuclei,demosoc-ux600-ddr200t
+          - const: nuclei,demosoc-ux600
+          - const: nuclei,demosoc
+
+additionalProperties: true
+
+...
-- 
2.30.2

