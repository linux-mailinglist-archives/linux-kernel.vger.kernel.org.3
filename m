Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFAC57DC7F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiGVIex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiGVIev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:34:51 -0400
Received: from mo-csw.securemx.jp (mo-csw1114.securemx.jp [210.130.202.156])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DC39EC42;
        Fri, 22 Jul 2022 01:34:50 -0700 (PDT)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 26M8YHbO004356; Fri, 22 Jul 2022 17:34:17 +0900
X-Iguazu-Qid: 2wHHCGtN6yCYJPGagK
X-Iguazu-QSIG: v=2; s=0; t=1658478857; q=2wHHCGtN6yCYJPGagK; m=nVA3CjmG/8lyNcuw0V5v1MshkB+vWVTzQZb1hzhV+1o=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
        by relay.securemx.jp (mx-mr1112) id 26M8YFCv023985
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 22 Jul 2022 17:34:15 +0900
X-SA-MID: 39258142
From:   Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
To:     Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Jonathan Corbet <corbet@lwn.net>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, yuji2.ishikawa@toshiba.co.jp
Subject: [PATCH v2 1/5] dt-bindings: soc: visconti: Add Toshiba Visconti DNN image processing accelerator bindings
Date:   Fri, 22 Jul 2022 17:28:54 +0900
X-TSB-HOP2: ON
Message-Id: <20220722082858.17880-2-yuji2.ishikawa@toshiba.co.jp>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220722082858.17880-1-yuji2.ishikawa@toshiba.co.jp>
References: <20220722082858.17880-1-yuji2.ishikawa@toshiba.co.jp>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds the Device Tree binding documentation that allows to describe
the DNN image processing accelerator found in Toshiba Visconti SoCs.

Signed-off-by: Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../soc/visconti/toshiba,visconti-dnn.yaml    | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/visconti/toshiba,visconti-dnn.yaml

diff --git a/Documentation/devicetree/bindings/soc/visconti/toshiba,visconti-dnn.yaml b/Documentation/devicetree/bindings/soc/visconti/toshiba,visconti-dnn.yaml
new file mode 100644
index 000000000..28576a55e
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/visconti/toshiba,visconti-dnn.yaml
@@ -0,0 +1,54 @@
+# SPDX-LIcense-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/visconti/toshiba,visconti-dnn.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Toshiba Visconti DNN image processing accelerator
+
+maintainers:
+  - Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+
+description: |
+  Toshiba Visconti DNN image processing accelerator.
+  Visconti5 have up to 2 DNN units.
+
+properties:
+  compatible:
+    items:
+      - const: toshiba,visconti-dnn
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  index:
+    enum: [0, 1]
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - index
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        dnn0: dnn@14280000 {
+            compatible = "toshiba,visconti-dnn";
+            reg = <0 0x14280000 0 0x8000>;
+            interrupts = <GIC_SPI 201 IRQ_TYPE_LEVEL_HIGH>;
+            index = <0>;
+            status = "disabled";
+        };
+    };
-- 
2.17.1


