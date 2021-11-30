Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59FF6463B8C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 17:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238833AbhK3QVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 11:21:51 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:42027 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234552AbhK3QVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:21:48 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6E760580129;
        Tue, 30 Nov 2021 11:18:24 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 30 Nov 2021 11:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=yqwoBj/vWfeXNQgCvpj+YqonSU
        yi2vtvBoiOZzTnEUE=; b=ULWafKAXsOC4xDUqQoDhiXfx1RWMiIAmrDWWBX8qzl
        ni1OfFtOpZGeBIq3Xtk5YCO1Z4gsTP0Id5qI+f6HBeLqD8GwOlb7ns1KsPr+t3Th
        fFw9/oCNEHG+1kVB1TYPluxJrBGS1ZneiC3Jpm/xzLbB9+cAi2AqAVyzN0Hjju9f
        Pi+SCnzMdp8PeeUOqCtibzozOwPQF2241J+bw/oBDOGO9sg3YGxEkJzK5xxbQ/Iz
        R7FbJcMEwTllpHYOe32I+a3FKJiyeDTd7Z6WuyzjewarXZDcmQnO8JGeHwJ0RLrS
        7BygfMfp2EzuWMtaUO57b8CsjFpBra3z1l4iEUU0Rv0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yqwoBj/vWfeXNQgCv
        pj+YqonSUyi2vtvBoiOZzTnEUE=; b=a5sCJf0LHQjoYtkMzotyeH+cK5YxpoWrx
        9t2t8wogWoaYqXwU9bNjtjhyEflfUsIBw+L2EjjtKIbO70yPz44tin3eGChm6aIO
        diIdIg48lZt6qizBn9TfxEsqS6KSGULMM+JLXKJoXazFWbxzTThgoeAd38udFGP3
        Ghq+atmLLvrvpSKM2VjDmC2UxmAHFcEnvq5oyHyP9tcYAuv+aHxUsqccf9ej3z09
        3CkwbSdt3UL4IyDwuNgnAwTTCOweCTWX4fNiddiM9ZJGPJLYy0XjqHJJwlfGPwnK
        PH1SyuUifM3mlsQk6bL63Xy7ByN5T8JG2lD+IXRbvLUdxvXRPjEog==
X-ME-Sender: <xms:zk6mYZfODQkcXoBDMklRzjYFNRhtv4EW7LjcB9gb3fb0MIM2kL_qyg>
    <xme:zk6mYXO8pu-tHKb6yuDlCR_d1Hc1EjqetkBmhNXXRRiCEj4pl8Lo4BanRVetnqKp6
    B2ZR8dYKURBTc0jCT8>
X-ME-Received: <xmr:zk6mYSjnsUKyGfGrA21nJvKgRPs2PxnozFlFufvkzEoWPlLwcJq_iHq7zWDLFH9ue18HxWPAOqv9jcZlx2eyqiuqFC8fq8r2PdTt1fjJvSAtXSA64iDZYaa-7bNUig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddriedugdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhvvghnucfrvght
    vghruceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrghtthgvrhhnpe
    duffejkeevlefggfekkeevjeffgeekjedtjedtfeethfeludehkeehgfeuteekhfenucff
    ohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:zk6mYS_IMEmtmXTbC9SM0zfNK-3G0PYuW5JvOQk4PvHM90D-hw5Hkg>
    <xmx:zk6mYVs6N4df1vEWS4r8xesFb-3QktPtoyXBCXG96x-vdu2BVxruhA>
    <xmx:zk6mYRE3vGdO-relrVef_wyVif1EenhIS0qmn33aTTXRMfrOUcZMcQ>
    <xmx:0E6mYREwgmGM23QNvd__2xfwrX1MDAwYojBx2RIRm8XG2Jjbsyl7Aw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Nov 2021 11:18:20 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Sven Peter <sven@svenpeter.dev>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Janne Grunau <j@jannau.net>,
        Mark Kettenis <kettenis@openbsd.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: watchdog: Add Apple Watchdog
Date:   Tue, 30 Nov 2021 17:18:08 +0100
Message-Id: <20211130161809.64591-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple SoCs come with a simple embedded watchdog. This watchdog is also
required in order to reset the SoC.

Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v1 --> v2:
  - add Mark's and Rob's r-b tags

 .../bindings/watchdog/apple,wdt.yaml          | 52 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/watchdog/apple,wdt.yaml

diff --git a/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
new file mode 100644
index 000000000000..e58c56a6fdf6
--- /dev/null
+++ b/Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/watchdog/apple,wdt.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoC Watchdog
+
+allOf:
+  - $ref: "watchdog.yaml#"
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-wdt
+          - apple,t6000-wdt
+      - const: apple,wdt
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/apple-aic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    wdt: watchdog@50000000 {
+        compatible = "apple,t8103-wdt", "apple,wdt";
+        reg = <0x50000000 0x4000>;
+        clocks = <&clk>;
+        interrupts = <AIC_IRQ 123 IRQ_TYPE_LEVEL_HIGH>;
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 360e9aa0205d..859201bbd4e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1750,6 +1750,7 @@ F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
+F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
-- 
2.25.1

