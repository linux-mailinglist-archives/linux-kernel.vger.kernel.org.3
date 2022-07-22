Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB3B957E4BA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbiGVQtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235893AbiGVQtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:49:07 -0400
Received: from out28-172.mail.aliyun.com (out28-172.mail.aliyun.com [115.124.28.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF3A93C0E;
        Fri, 22 Jul 2022 09:48:56 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.3241718|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0235158-0.00320354-0.973281;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047212;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=23;RT=23;SR=0;TI=SMTPD_---.Ob0cnML_1658508529;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Ob0cnML_1658508529)
          by smtp.aliyun-inc.com;
          Sat, 23 Jul 2022 00:48:50 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
Subject: [PATCH 2/3] dt-bindings: SPI: Add Ingenic SFC bindings.
Date:   Sat, 23 Jul 2022 00:48:29 +0800
Message-Id: <1658508510-15400-3-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SFC bindings for the X1000 SoC, the X1600 SoC, the X1830 SoC,
and the X2000 SoC from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 .../devicetree/bindings/spi/ingenic,sfc.yaml       | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/ingenic,sfc.yaml

diff --git a/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml b/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
new file mode 100644
index 00000000..b7c4cf4
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/spi/ingenic,sfc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bindings for SFC in Ingenic SoCs
+
+maintainers:
+  - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
+
+description:
+  The SPI Flash Controller in Ingenic SoCs.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - ingenic,x1000-sfc
+          - ingenic,x1600-sfc
+          - ingenic,x2000-sfc
+      - items:
+          - enum:
+              - ingenic,x1830-sfc
+          - const: ingenic,x1000-sfc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: sfc
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/ingenic,x1000-cgu.h>
+
+	sfc: spi@13440000 {
+		compatible = "ingenic,x1000-sfc";
+		reg = <0x13440000 0x1000>;
+
+		interrupt-parent = <&intc>;
+		interrupts = <7>;
+
+		clocks = <&cgu X1000_CLK_SFC>;
+		clock-names = "sfc";
+
+		status = "disabled";
+	};
+...
-- 
2.7.4

