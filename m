Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B26B47069A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244295AbhLJRFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:05:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49654 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S243786AbhLJRFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:05:18 -0500
X-UUID: 2945bd9733b1425aa312e50bd984b4f9-20211211
X-UUID: 2945bd9733b1425aa312e50bd984b4f9-20211211
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 296904445; Sat, 11 Dec 2021 01:01:41 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 11 Dec 2021 01:01:40 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Dec
 2021 01:01:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:01:39 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        "Yong Wu" <yong.wu@mediatek.com>, JB Tsai <jb.tsai@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [PATCH v4 3/8] dt-bindings: arm: mediatek: Add new document bindings for APU
Date:   Sat, 11 Dec 2021 01:01:08 +0800
Message-ID: <20211210170113.30063-4-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210170113.30063-1-flora.fu@mediatek.com>
References: <20211210170113.30063-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the apusys bindings.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>

---
 .../arm/mediatek/mediatek,apusys.yaml         | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
new file mode 100644
index 000000000000..7643c66dfaa2
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apusys.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright (C) 2021 MediaTek Inc.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/mediatek/mediatek,apusys.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek APUSYS Controller
+
+maintainers:
+  - Flora Fu <flora.fu@mediatek.com>
+
+description:
+  The MediaTek apusys controller provides functional configurations and clocks
+  to the system.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - mediatek,mt8192-apu-conn
+          - mediatek,mt8192-apu-vcore
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    apu_conn: apu_conn@19020000 {
+        compatible = "mediatek,mt8192-apu-conn", "syscon";
+        reg = <0x19020000 0x1000>;
+        #clock-cells = <1>;
+    };
+
+  - |
+    apu_vcore: apu_vcore@19029000 {
+        compatible = "mediatek,mt8192-apu-vcore", "syscon";
+        reg = <0x19029000 0x1000>;
+        #clock-cells = <1>;
+    };
-- 
2.18.0

