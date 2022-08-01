Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758DB58639D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 06:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbiHAEsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 00:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239564AbiHAEsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 00:48:07 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA2713E39;
        Sun, 31 Jul 2022 21:48:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id A18873200033;
        Mon,  1 Aug 2022 00:48:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 01 Aug 2022 00:48:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1659329280; x=1659415680; bh=fAK6s3ZdE6AiXPO4P8BCPzpZX
        rbBn6incsq8p4u7UdE=; b=g1rNoQYNHJJtJoXQFi9U/xz9aJMXTcAs2QMEsys4B
        QcBzNNx7hR2i6cptRC37m5LZpeSC+LfG11MoiqXd7LpvMOPJuL0vjAw1ATVQPxl7
        KJmxsI23EjNVa9pS5+iidZYpvpOlry1k4IUaSPv+4rKQY79npRWYvLfORp1aP4tU
        Su3CDF9GNOUm/a8IhEsILUJC5loOiCylxoZb4Xu1uyeUXwIshMo8fGnAVsMr+0d/
        +f1MccEuuHEpn/H0nGp8CmPl4O2T/WaJmT/tTY1jSmnT6G/xdmpy3UXJV8GNhhhw
        KmDfJ8YuSB6VDKLDQI41qFTAgfPkDjWbV6pxHyrsWmAww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1659329280; x=1659415680; bh=fAK6s3ZdE6AiXPO4P8BCPzpZXrbBn6incsq
        8p4u7UdE=; b=goS6aVjfO+iS1ZlTdhBg8Yw1eJDutz7wBzgybSXTwW6MGFn17mD
        7KuXfMiynnI30HoAoLoTbBfHGEhlXFdWU5WGTnIKsWLmA3a2W3jmjKEmiedeXbw5
        OCMynmY3vqU65NiWHC60rwwzo+WpFoC3WiDeiiIOpQy5/fd3U8Dl0ObG3oINTuZ5
        l3As+hZJgDhzfknlgqwrM9N6zMd2KLvKhTvon9yRTRnmCuYj18E9c93QTG+IU48b
        9aQuvs1dhaxooBwy2dFDQBeKDOD2uBaOsCCjZ3NZaKrY87NjzqfusjukNIjzJv0w
        2G/wBMzLXSThhvpmvVcxX3ut8gqL4z9tuLg==
X-ME-Sender: <xms:_1rnYjdR6hOqnxnGharXIzv9z7QYsLZWG3C5Zh5TYuXUUhFtH9xCRg>
    <xme:_1rnYpMaZtgtniI6J2vbuBU95ezTVNmHR1oz3CGj6l98kmY4C_Avay-sN7BboLCkF
    trJqDDOp67RvvjY2Q>
X-ME-Received: <xmr:_1rnYsi6PdCr-JuROnI06XNMYlTQNhsCzjwK-emVdTqjyZfppAqlb0Ksueui_exqpXDY2FHCtIWWq0pSzBLO61QraK_agOMhcv85C4BMT4CnapaaX3mYTxRoPgktww9GWirpAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddvvddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepfeduffffueetveefudehueelgefgvdfffeelledtjeegudeiudehffdt
    jefhgefhnecuffhomhgrihhnpeguvghvihgtvghtrhgvvgdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhl
    lhgrnhgurdhorhhg
X-ME-Proxy: <xmx:_1rnYk-jWwUGQAuoEN-lFewxDACPocorAHOhEmmnnIUaSGtOVQS-5Q>
    <xmx:_1rnYvtG1ednBxD4ph5BZ-yaOMVjB-WUFr7s9A_OpNDd0BfRoCqH5Q>
    <xmx:_1rnYjFX3-1dU4XT3CpdYw7vL0JgvYgAdUyh60n7IYuRSWlqpiQiiQ>
    <xmx:AFvnYtI1bNDKQlsGNQ9iIc7-XoKBTtER5UpBpPfs6OO7Ecs4wNlytA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Aug 2022 00:47:59 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH 1/2] regulator: dt-bindings: Add Allwinner D1 LDOs
Date:   Sun, 31 Jul 2022 23:47:57 -0500
Message-Id: <20220801044758.12679-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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
regulator device relies on a syscon exported by some "host" device node.
Getting the register via a syscon avoids a dependency on the subsystem/
driver for that host device (e.g. a functioning thermal sensor should
not depend on having the audio codec driver loaded).

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 .../allwinner,sun20i-d1-analog-ldos.yaml      | 77 +++++++++++++++++++
 .../allwinner,sun20i-d1-system-ldos.yaml      | 55 +++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml

diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
new file mode 100644
index 000000000000..df648c56123d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-analog-ldos.yaml
@@ -0,0 +1,77 @@
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
+  codec MMIO space, but which is not part of the audio codec clock/reset domain,
+  and so is exposed as a syscon.
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
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of the device containing the power register
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
+  - syscon
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sid: efuse {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        bg_trim: bg-trim@28 {
+            reg = <0x28 0x4>;
+            bits = <16, 8>;
+        };
+    };
+
+    ldos-analog {
+        compatible = "allwinner,sun20i-d1-analog-ldos";
+        nvmem-cells = <&bg_trim>;
+        nvmem-cell-names = "bg_trim";
+        syscon = <&codec>;
+
+        reg_aldo: aldo {
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+        };
+
+        reg_hpldo: hpldo {
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
new file mode 100644
index 000000000000..13b2e8c84f1d
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/allwinner,sun20i-d1-system-ldos.yaml
@@ -0,0 +1,55 @@
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
+  within the system controller MMIO space.
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun20i-d1-system-ldos
+
+  syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle of the device containing the LDO control register
+
+patternProperties:
+  "^(ldoa|ldob)$":
+    type: object
+    $ref: regulator.yaml#
+
+required:
+  - compatible
+  - syscon
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    ldos-system {
+        compatible = "allwinner,sun20i-d1-system-ldos";
+        syscon = <&syscon>;
+
+        reg_ldoa: ldoa {
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <1800000>;
+        };
+
+        reg_ldob: ldob {
+            regulator-name = "vcc-dram";
+            regulator-min-microvolt = <1500000>;
+            regulator-max-microvolt = <1500000>;
+        };
+    };
+
+...
-- 
2.35.1

