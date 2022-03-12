Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FE94D700F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 17:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232253AbiCLRAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 12:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCLRAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 12:00:02 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4859D4D0;
        Sat, 12 Mar 2022 08:58:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 96D1E5C0101;
        Sat, 12 Mar 2022 11:58:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 12 Mar 2022 11:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=3Z4lX7yd1Z+rbqj8SWtm2FLJJwtkYQaLa5pn68
        7U3Rg=; b=CpaiZybiXJDaDndnp5Ecq5tk+LnWD6jBobM9gIb43584TA/OkiOcT1
        dfGBGf/uhKpgQoBEfLfWJVpj/+P5hgyaPXaK1Q0HGliXfYYtCjw+FnIiSkK1mC5T
        NtIj4wyBc+W8QAVLN8Yw+2KerSe1ibizS9f/lu756Uwgevs7fxx2SqMxDrqPRR9O
        tCsjl4ixKxXFGMK8Z1xuSTRGxkpRaD2teMHgBC6p5EzbcfAz6PiAsiQM5ptIYcIy
        L60JlipNAYJ8+ByeSfIIXyyGbQ8gEWSOYGJJaeiFM3y1cf25ZPC4gdDHZjbsb8mH
        hHp7GfzvMXCzHaPPgkYgDTw8yXqj7sGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=3Z4lX7yd1Z+rbqj8SWtm2FLJJwtkY
        QaLa5pn687U3Rg=; b=eHhMB8/fWiDJgkWcVdh/lWt+g8LHoUbSo9xVc5qpraU0j
        R8kjS3l43r5HE627DlYAGKjIb+mxNnwqyjcC+me2d25SS0aNDSVW1ZLfG29ucecF
        t59oTbvZ6TNxl45YB+/Gr0Lqyxxvqm0EVeQkG7IAlnD96bAM/PBg8cvQqUxBh5Kp
        g6RqmR3Z3VxSnrpzbC8ecTrErseF2775Kpdpd9DqteQDtoCDUjS5y5LDQUbj51tu
        jkjzNDagq38Ng2WtDZRPgbIwCZC/mSqyfy3GICFikNYoOeh8Uh0UJH0DQBuScw8B
        VF74FNTkNzerACVtI19nM51U1MHNJ+1HRj2i3JoHA==
X-ME-Sender: <xms:SdEsYsdSXi7plI7ez42rh1YHwjVYFq2nAo112wiYq5XrXXgLtCEEAA>
    <xme:SdEsYuMk8qWv4IJ3Ik8fyqf62CWqOJ48hP2JV7T_n6R8Zo0KzIPdB_pf0y4ucpu0v
    Pur92gZQO3aKvMERwY>
X-ME-Received: <xmr:SdEsYtj-4QeePqf9VQX4BUdWs2lF7r4ySW2RnkuX-hG4fj79T7rI7xV54HSI669_LzVEpBzdiJr_BDpq5sIY57JByMH_s35DnGAw03reJc0mkxWg1tegyRMcqkKg3c0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvgedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epudffjeekveelgffgkeekveejffegkeejtdejtdeftefhleduheekhefgueetkefhnecu
    ffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvhgvnhesshhvvghnphgvthgvrhdruggv
    vh
X-ME-Proxy: <xmx:SdEsYh_-MuqET3fOftH_pg2LcotGcyjQSlMf5vIJ3hEkBsfBPe9bAA>
    <xmx:SdEsYovR3eo32FYJfCvarLG1r_krNbHqTCTFS4QyEdaGq3PjGGlZDQ>
    <xmx:SdEsYoG2v4EUgVRVcgNh9HzrXAHaJundzGEm_7ixEUTNxqHj_kcgFg>
    <xmx:StEsYqLkD8Ac-vtCgDYPGPgipaHBRd4l_1_NN4CVbJkL5zKcDkLaKQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Mar 2022 11:58:48 -0500 (EST)
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
Subject: [PATCH v3 1/2] dt-bindings: nvmem: Add apple,efuses
Date:   Sat, 12 Mar 2022 17:58:36 +0100
Message-Id: <20220312165837.40687-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apple SoCs come with eFuses used to store factory-programmed data
such as calibration settings for the PCIe and Type-C PHY.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
v2 -> v3:
  - added r-b tag
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
index e127c2fb08a7..24deb0e8f731 100644
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

