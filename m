Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AEA4CEB7E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 13:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiCFMT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 07:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCFMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 07:19:27 -0500
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11E311140;
        Sun,  6 Mar 2022 04:18:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6AD8C5802B4;
        Sun,  6 Mar 2022 07:18:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 06 Mar 2022 07:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=m9Zg33CwkxLAO0J/WxcneNphNUWbcCPDXzRgvb
        MpS/s=; b=V7GflugNVOEZE8oHq6kfrHx9o42Lj4yucIrtPfSmw3WL8d/Zeg1fL8
        +bHwn9fbafl6x9UiQEElbdPO4qVKb7d5aV6aDMiIr5EIY6KHxn7oGG361Mp1zoa3
        F9W4bCogGSIqUCtCGvzITRSA0yzHXUaD4+OR16XVMFcYl3N0IteS5LmpowY7M0CX
        JBnpDzMpChM49XVv7ZldyFu+nRwqoKdeSx43YPokVXPHRZqjy3Pd8d5i1eJQjP7W
        IIZM3QtlSBL5BQNoGKeYl1HiPw+xi2+b189F4owTCZNIMkRgMPbRq9mrvg69RAEJ
        KIpN+RkJsvtdEXQqVpOYLeWdJfp8BlOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=m9Zg33CwkxLAO0J/WxcneNphNUWbc
        CPDXzRgvbMpS/s=; b=KuhxlSQDUuiItNs5e32MVt1QJzZ1JMdoYKMNEwZdRM6Tg
        XKmTGE76XUbpJIQHf8tpfORps5X6r/Eu9LcUp3YYS1Yvl+pmeSjZQc1Dux5cgd7q
        DKG2U/NS6Hd7VJGaVvkp6/WxHM6v/oCi2xRCUL0bLLEIIwuFEIVlLALVpHaWO46t
        dfweuV+xD/rom1VxMfCjzFVlhcM//IjQmVgLVy3BfayibxwDry7s3i4eZGoImIHb
        VYVI3jCtT3lJ2L0xPPJwT8XOkC/SL/on/RlMZLWB3l8OVBqrQ6cWBuZ3DSQ03O/C
        ClHCadW1UJ6x27O9nah3okXjBUSkGr7foIFP6kwCA==
X-ME-Sender: <xms:l6YkYkvJQ8RGHWUjpqKHncsRXGRqlLqSVS2PQ3PlpKLRKj6ranPsSQ>
    <xme:l6YkYhcz0FpUemcYZv1MEzyxbXQm3xdjOGMVIypkPR5Vs6kqndooyGWKhMygFqaGO
    MO6nEOyKyXp76iy50Y>
X-ME-Received: <xmr:l6YkYvzCILuKtcwKUKI9kgt7642hDKYTxEvvsofgfFXbEdlmUpbYfuqs6J6B2i717f6Xzd-XAWmUC6gWyIoGdoeEDjcWco3JTCPWg3xfj1FnCBx7JQIiclbOC8AJQGM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudduvddgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epudffjeekveelgffgkeekveejffegkeejtdejtdeftefhleduheekhefgueetkefhnecu
    ffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggv
    vh
X-ME-Proxy: <xmx:l6YkYnPZVKnH31GNspv9hVCxURRhzk4e8-o2RFnnbOvr3jxkLwOXSw>
    <xmx:l6YkYk-sxcApURTzz9Wu63wHT1SglM_6ZcFTTzDnsgAgneDgUe95_g>
    <xmx:l6YkYvXzs4gxMKfU1aHjUZ7MGicTvWIrtckYr2_pkWObv3dXoouyKg>
    <xmx:mKYkYvY8b23vK-XTD-RCLy8gPjXAe-dh6yO7rJR1duapHsOOQvSOAg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 6 Mar 2022 07:18:30 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Krzysztof Kozlowsk <krzysztof.kozlowski@canonical.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <kettenis@openbsd.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: nvmem: Add apple,efuses
Date:   Sun,  6 Mar 2022 13:18:15 +0100
Message-Id: <20220306121816.70537-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple SoCs come with eFuses used to store factory-programmed data
such as calibration settings for the PCIe and Type-C PHY.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v1 -> v2:
  - fixed indentation issue pointed out by Krzysztof Kozlowski

 .../bindings/nvmem/apple,efuses.yaml          | 50 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/apple,efuses.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
new file mode 100644
index 000000000000..5ec8f2bdb3a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/apple,efuses.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple SoC eFuse-based NVMEM
+
+description: |
+  Apple SoCs such as the M1 contain factory-programmed eFuses used to e.g. store
+  calibration data for the PCIe and the Type-C PHY or unique chip identifiers
+  such as the ECID.
+
+maintainers:
+  - Sven Peter <sven@svenpeter.dev>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,t8103-efuses
+          - apple,t6000-efuses
+      - const: apple,efuses
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
+    efuse@3d2bc000 {
+        compatible = "apple,t8103-efuses", "apple,efuses";
+        reg = <0x3d2bc000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        ecid: efuse@500 {
+            reg = <0x500 0x8>;
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 05fd080b82f3..f70d8525cbd4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1771,6 +1771,7 @@ F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+F:	Documentation/devicetree/bindings/nvmem/apple,efuses.yaml
 F:	Documentation/devicetree/bindings/pci/apple,pcie.yaml
 F:	Documentation/devicetree/bindings/pinctrl/apple,pinctrl.yaml
 F:	Documentation/devicetree/bindings/power/apple*
-- 
2.25.1

