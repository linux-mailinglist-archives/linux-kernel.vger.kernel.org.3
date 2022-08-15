Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E135928DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 06:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbiHOEes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 00:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiHOEen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 00:34:43 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942FF14D21;
        Sun, 14 Aug 2022 21:34:42 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1650C3200754;
        Mon, 15 Aug 2022 00:34:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 15 Aug 2022 00:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660538080; x=1660624480; bh=ZS
        xEvGyrB6oDsjk8O9SkFaf2hh3bJF3tpg+kGnGDcDM=; b=I/QJe0JP656h626rPp
        o1Mjn/3punpiO398RO4DtHOsAT4+IPzySnt2SsP8haiSLnSEJWOsRKu1+fJu9472
        HzE8/dWnp5Tr3Sa3fUPRq27Vr31qBr94IkL+PFHFczFMBuXSoGRWwmqdg0tKa+9l
        WopS3eS/+iv8QfVCAOVSx5uyIJVqP/sxmp+EhDKCnl9w4/U2f+IXupm7JAKPVaz3
        ehu+YrccY9GsOGiQ8OTk+MtxtTXdZ4ep419ipy/gklxuu77OfcOgFfhFeJBxPHzE
        iEnEISlp0HI+qXM3v+Le/yHwJjGAfHkDDunTduD7QhGOnhoMnaEOkUGHgSASitd8
        klFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660538080; x=1660624480; bh=ZSxEvGyrB6oDs
        jk8O9SkFaf2hh3bJF3tpg+kGnGDcDM=; b=XxyxXqr16cYo0DvpvkXZm6Mejo0At
        rDJST+FmSc39aTRU7R6JjEUfkJowvVzoTXMruNgofff7kG2XiWNbfPB2fCgKWeX8
        WVbXQkw4Q/A1Ho/Ny09cfJMh3+x0hHekBABkMfl2ejIYPHDOJ+dkaxa0SawtLiGq
        nGzWJWCaSLSjMu3Yuz1H4F/g7QMOTu2pnaB7Hiej8eU4IzlY6OaiVc5VAj4oH3lK
        ZEUH2kUAN2KAwfQC7cu7NI4OCBmIDKVE7xPhPwuJVTDlcVWPZQq4wcjftIF2lWhl
        3SzdJSuYXMOomJppGIjcLBx5wsFBOYu+KQmREoD8SCNKtGy0BjfDXaI6w==
X-ME-Sender: <xms:4Mz5YjyxkQT7h8zYZwl2PtxKrBHiimxsW_FQ0zDfU659__HBjUOOKQ>
    <xme:4Mz5YrR6iooIGlgrYJgOyKG79TVpkDMXOaFR9gvNX0fL6NmBew4dnTCfAa3VjUD4G
    vr_1X8pGL8ftJ5iHA>
X-ME-Received: <xmr:4Mz5YtVOhJTbg6nu2Vyvs73OVmLT7wdaWyBUn0nDX26GBdelvVjiMHronqlxCa9iVW6roY_xCPc-Xu1Cb8-pjpyMWC8Gsl4W0b9zBrllGAj4Es29kcVeaVHCDsmoB-YhWwOOCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgffhvefhgfehjeehgfekheeuffegheffjeegheeuudeufeffhffh
    ueeihfeufffhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhh
    ohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:4Mz5YthaaMLgNqGozPeU3fnX3LF8_tpw1-62OVeJddFYo9ozMUsy2g>
    <xmx:4Mz5YlCCcNOJqCCAS9Rcf1ZFyExYNAHaMOjy-ghea4Z6v7pG58tiIQ>
    <xmx:4Mz5YmL4oR5jq3k1h4OFeagWjzqm0kaiEEN6__oT5B0skXftpEkjug>
    <xmx:4Mz5Yp5IPC2DL2znfFJQTIFLBtrdqbszx-ozl74qETdd9Or7_m1T9g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 00:34:39 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v3 1/4] regulator: dt-bindings: Add Allwinner D1 LDOs
Date:   Sun, 14 Aug 2022 23:34:32 -0500
Message-Id: <20220815043436.20170-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220815043436.20170-1-samuel@sholland.org>
References: <20220815043436.20170-1-samuel@sholland.org>
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

The Allwinner D1 SoC contains two pairs of in-package LDOs. One pair is
for general purpose use. LDOA generally powers the board's 1.8 V rail.
LDOB generally powers the in-package DRAM, where applicable.

The other pair of LDOs powers the analog power domains inside the SoC,
including the audio codec, thermal sensor, and ADCs. These LDOs require
a 0.9 V bandgap voltage reference. The calibration value for the voltage
reference is stored in an eFuse, accessed via an NVMEM cell.

Neither LDO control register is in its own MMIO range; instead, each
regulator device relies on a regmap/syscon exported by its parent.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Add "reg" property to bindings
 - Add "unevaluatedProperties: true" to regulator nodes
 - Minor changes to regulator node name patterns
 - Remove system-ldos example (now added in patch 3)

Changes in v2:
 - Remove syscon property from bindings
 - Update binding examples to fix warnings and provide context

 .../allwinner,sun20i-d1-analog-ldos.yaml      | 74 +++++++++++++++++++
 .../allwinner,sun20i-d1-system-ldos.yaml      | 37 ++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml

diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
new file mode 100644
index 000000000000..d6964b44ef21
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-analog-ldos.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner D1 Analog LDOs
+
+description:
+  Allwinner D1 contains a set of LDOs which are designed to supply analog power
+  inside and outside the SoC. They are controlled by a register within the audio
+  codec MMIO space, but which is not part of the audio codec clock/reset domain.
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun20i-d1-analog-ldos
+
+  reg:
+    maxItems: 1
+
+  nvmem-cells:
+    items:
+      - description: NVMEM cell for the calibrated bandgap reference trim value
+
+  nvmem-cell-names:
+    items:
+      - const: bg_trim
+
+patternProperties:
+  "^(a|hp)ldo$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - nvmem-cells
+  - nvmem-cell-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    audio-codec@2030000 {
+        compatible = "simple-mfd", "syscon";
+        reg = <0x2030000 0x1000>;
+        ranges;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        regulators@2030348 {
+            compatible = "allwinner,sun20i-d1-analog-ldos";
+            reg = <0x2030348 0x4>;
+            nvmem-cells = <&bg_trim>;
+            nvmem-cell-names = "bg_trim";
+
+            reg_aldo: aldo {
+                regulator-min-microvolt = <1800000>;
+                regulator-max-microvolt = <1800000>;
+            };
+
+            reg_hpldo: hpldo {
+                regulator-min-microvolt = <1800000>;
+                regulator-max-microvolt = <1800000>;
+            };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
new file mode 100644
index 000000000000..e3e2810fb3d7
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/regulator/allwinner,sun20i-d1-system-ldos.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner D1 System LDOs
+
+description:
+  Allwinner D1 contains a pair of general-purpose LDOs which are designed to
+  supply power inside and outside the SoC. They are controlled by a register
+  within the system control MMIO space.
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun20i-d1-system-ldos
+
+  reg:
+    maxItems: 1
+
+patternProperties:
+  "^ldo[ab]$":
+    type: object
+    $ref: regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+...
-- 
2.35.1

