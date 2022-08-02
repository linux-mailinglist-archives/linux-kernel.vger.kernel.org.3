Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720A75876B9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 07:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbiHBFce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 01:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235717AbiHBFc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 01:32:29 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871AA1E3C2;
        Mon,  1 Aug 2022 22:32:26 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 062B3320084E;
        Tue,  2 Aug 2022 01:32:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Aug 2022 01:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1659418344; x=1659504744; bh=Cd
        xH8UECdWP/FcfgxxRpxsH2KZRjenbkyAWm1xRm+GE=; b=G4FKdF+nAkhHdDc9xU
        V11QudM9pIImMjuaM/1DmummhBzGUwRaxnApIpJO9PT+x8KJeUa4RFgyb8cLhSUb
        OdB7KHKZxTBtuMRSEc1x/eFPx21cpBReM3SJbtjPsts7kBVmKf+KeSeH6x4On0oL
        riHKBDio9FODZoJqxjgEeDECVSuuw/p/CtT/00y435ix+pR8oQJrA/Quyx2cs5rh
        yfRUGqlokjL/9oW6w60tbGRe7kUHjaLFciu13qnxPPLGlRUhFd6CAaudnNksciyX
        wELgA9FRSd6/af82YdqcRhffq2jfaaFsg45VI/dcChtbRo9ztElWRdyZX6TgWpWJ
        0rYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1659418344; x=1659504744; bh=CdxH8UECdWP/F
        cfgxxRpxsH2KZRjenbkyAWm1xRm+GE=; b=bf0f5UIm+QtFpyTXIdcU8+e1WUEMp
        5PN8EQ6pLBYw1Cjfqld+K7Mc4oganQYhXhavV53ZUqPtDcTr2N/2FnkmKkzkNd+6
        i0IIcCHOf73WdehybnnyJfE4gEGs28O7/6gnllHQVWUqkqJlMwNyfMhJRBHM7kHL
        QXlE4XRp+N4zmEANOUJlY8Q0IY3aZLqucV82g2mh5uqWUn55Q0fs+h7Lm0rumr1q
        tXZQSWvUoOsXPw7daooIMVemBJ7mC3sgEgpSfZ4r23BlBRSROLCcJahxQQXfesRu
        fIB0wY1dQnsFVtBOHkIhPrx/BifYd/L6hPyTn8Xu2dZ/knJfWdnPv+sDQ==
X-ME-Sender: <xms:6LboYntjXSyswG7dpbnN65VASWlEj1AROatO9kmmh1xe1_imxMYIkQ>
    <xme:6LboYof5fXLNulCrTcRzy6YvZEwQpmvdLonI7Je-fr9NjiIjhYl_5Gu0kJS2agmkQ
    1dCH3VpEVUQC3ykZg>
X-ME-Received: <xmr:6LboYqzgpv_sHiviXy7OMBl0Osi37KeiFL5DBlPyVQPWq4aP0F7KwiS6fahGOjF9-i6_sEGQmurWRzhR5t9F34Kag5olGxStXznrWbjIS_hOUmeaZvv8ptf6XTzOgVyKmg5KWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvgedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgffhvefhgfehjeehgfekheeuffegheffjeegheeuudeufeffhffh
    ueeihfeufffhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhh
    ohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:6LboYmOdW1PXiHbB8ONrGLvg-JfUaOfIclsboAhME8gZqUDSw0pKsg>
    <xmx:6LboYn-58Pr5wvr5dJ-FyJp0z99M9XcMWcvmMwCFo5o5m-JnLyKxgg>
    <xmx:6LboYmWxIcPI0jrK9ZqOuwnYFnPZoj9atmtawADvMGsztINbAOrO7g>
    <xmx:6LboYo2phNaSFdc1Ak3MTZcNOTyai23oVkejzsTGYaHn6yS8GLMc8g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Aug 2022 01:32:23 -0400 (EDT)
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
Subject: [PATCH v2 3/4] regulator: dt-bindings: Add Allwinner D1 LDOs
Date:   Tue,  2 Aug 2022 00:32:12 -0500
Message-Id: <20220802053213.3645-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220802053213.3645-1-samuel@sholland.org>
References: <20220802053213.3645-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v2:
 - Remove syscon property from bindings
 - Update binding examples to fix warnings and provide context

 .../allwinner,sun20i-d1-analog-ldos.yaml      | 65 +++++++++++++++++++
 .../allwinner,sun20i-d1-system-ldos.yaml      | 57 ++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml

diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
new file mode 100644
index 000000000000..19c984ef4e53
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
@@ -0,0 +1,65 @@
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
+  nvmem-cells:
+    items:
+      - description: NVMEM cell for the calibrated bandgap reference trim value
+
+  nvmem-cell-names:
+    items:
+      - const: bg_trim
+
+patternProperties:
+  "^(aldo|hpldo)$":
+    type: object
+    $ref: regulator.yaml#
+
+required:
+  - compatible
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
+
+        regulators {
+            compatible = "allwinner,sun20i-d1-analog-ldos";
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
index 000000000000..c95030a827d6
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
@@ -0,0 +1,57 @@
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
+patternProperties:
+  "^(ldoa|ldob)$":
+    type: object
+    $ref: regulator.yaml#
+
+required:
+  - compatible
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    syscon@3000000 {
+        compatible = "allwinner,sun20i-d1-system-control";
+        reg = <0x3000000 0x1000>;
+        ranges;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        regulators {
+            compatible = "allwinner,sun20i-d1-system-ldos";
+
+            reg_ldoa: ldoa {
+                regulator-min-microvolt = <1800000>;
+                regulator-max-microvolt = <1800000>;
+            };
+
+            reg_ldob: ldob {
+                regulator-name = "vcc-dram";
+                regulator-min-microvolt = <1500000>;
+                regulator-max-microvolt = <1500000>;
+            };
+        };
+    };
+
+...
-- 
2.35.1

