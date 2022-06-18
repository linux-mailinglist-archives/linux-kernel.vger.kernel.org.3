Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC5755063C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237183AbiFRRF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Jun 2022 13:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbiFRRFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jun 2022 13:05:52 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D85D13CC7;
        Sat, 18 Jun 2022 10:05:50 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.west.internal (Postfix) with ESMTP id 1451D2B04FD3;
        Sat, 18 Jun 2022 12:57:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 18 Jun 2022 12:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655571475; x=1655578675; bh=Lu
        uTEOR7u8NT8qYDU7Co2XhnytDZp9bAeyNqtTvivAI=; b=I+NKbH2UzJQD7LwNbu
        48/kHbp+OJfJzlFvpxrna3+TNwvimC0bxK8GS5+ZlugvePSNbqNZ42AbVrI9D6Mp
        KAEnUYE9j2Q3D0wM7UpEsBgk1runnXjwKgUCFkN/ATEMiwgN+uoAIQ1OdvZBZWtz
        C1z8q2IJqmtjO1AIwKlmx/nDTLZm0Fpbb79M0Re6/CN0JDi3U1vpGBOkHid+YF1B
        UWCqPNREwGowLnqPLiXmg7yoIH86wAKPadtjmAjAiO2LyDOdjhWff1fG8IgVjRWH
        LhCdY/7SJZkwddKACo3kt5pDtkJ9Ssyd6K3Os7yVEg++HHm9YyGq85uyW65xN+ef
        ipzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655571475; x=1655578675; bh=LuuTEOR7u8NT8
        qYDU7Co2XhnytDZp9bAeyNqtTvivAI=; b=V3ooU6RxgAIaaHHt8r9oOpumS88aq
        +JFpq2fSMlb7BmLTBWphYLDy/1BaGV3oXDNje9+tIStvpLKmzMl122zIxFOO/asK
        ZY4US6rCoF+CZ8liKhDVoP79VOKwyvuyh1oRZUt3sQ4zsbHfY1jMvbkd5e4ZOJe+
        oza0f5ZMH2F1sRZXJKCr4JAqcGmK8jhhbDa5zIkicyzl4OwFLypDfCXBcDsN99wV
        qnsqx31yqPSjh6yhzeNzwl2slqLvRz84k3qd+ComPeho5pL8qQ6ILsYNwC6wd2oG
        luas6shGVTwtSQ+dfz5tfuh/vLJ17OY2oPrqyABkopqhbMwJAbonO86ww==
X-ME-Sender: <xms:EgSuYmM2eowiuCaHX0YA5bAGlcA7w4ZZTXYbfbydTA3VIADhexul9Q>
    <xme:EgSuYk82IOKJlJLwwNxxvHi76_iDwgltsz3MhgGUUXWTIiVc0tJVQS3BqWguDP2lD
    ngSEisZifPkYJF9yQ>
X-ME-Received: <xmr:EgSuYtRxtsK3ibbTl8yQ4bNs9Qam0FEJQOYkfgs8r24KWjE89erjigd-SVXNAVBCoiXj6urV4qvs1lKza5DDpldyH0Jf5AuhcnZEhe_hHX4DupyrHMzQKP4KTNNh9NxL0A8h5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedruddvjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefghfevhffgheejhefgkeehueffgeehffejgeehueduueeffffh
    hfeuiefhueffhfenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehs
    hhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:EgSuYmtbRt6nURH8oqyvdNGXjo8KN1E7bvi6JP7zyBw89dYiPnavhg>
    <xmx:EgSuYufS_iY_hnMPj4ht_bMO8c3KqzLS_I80YR9AtrV_HubgPW2OBA>
    <xmx:EgSuYq3y1cv-y9cfLq57qu-spKzucbLDDwSh9eFAzEiBp4Dmb7n0Gw>
    <xmx:EwSuYs-M6Pk_9yPIXItjnT3k_s-PxHmL-C7XqQQtVhL5pBT8IuanqM3Rd9Y>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jun 2022 12:57:53 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Ondrej Jirman <x@xff.cz>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Colin Ian King <colin.king@intel.com>,
        David Gow <davidgow@google.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        "fengping.yu" <fengping.yu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v4 1/4] dt-bindings: input: Add the PinePhone keyboard binding
Date:   Sat, 18 Jun 2022 11:57:44 -0500
Message-Id: <20220618165747.55709-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220618165747.55709-1-samuel@sholland.org>
References: <20220618165747.55709-1-samuel@sholland.org>
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

Add devicetree support for the PinePhone keyboard case, which provides a
matrix keyboard interface and a proxied I2C bus.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v3)

Changes in v3:
 - Replace unevaluatedProperties with additionalProperties
 - Rename i2c-bus to i2c

Changes in v2:
 - Drop keymap DT properties
 - Add vbat-supply property

 .../input/pine64,pinephone-keyboard.yaml      | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml

diff --git a/Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml b/Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml
new file mode 100644
index 000000000000..e4a0ac0fff9a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/pine64,pinephone-keyboard.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pine64 PinePhone keyboard device tree bindings
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+description:
+  A keyboard accessory is available for the Pine64 PinePhone and PinePhone Pro.
+  It connects via I2C, providing a raw scan matrix, a flashing interface, and a
+  subordinate I2C bus for communication with a battery charger IC.
+
+properties:
+  compatible:
+    const: pine64,pinephone-keyboard
+
+  reg:
+    const: 0x15
+
+  interrupts:
+    maxItems: 1
+
+  vbat-supply:
+    description: Supply for the keyboard MCU
+
+  wakeup-source: true
+
+  i2c:
+    $ref: /schemas/i2c/i2c-controller.yaml#
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      keyboard@15 {
+        compatible = "pine64,pinephone-keyboard";
+        reg = <0x15>;
+        interrupt-parent = <&r_pio>;
+        interrupts = <0 12 IRQ_TYPE_EDGE_FALLING>; /* PL12 */
+
+        i2c {
+          #address-cells = <1>;
+          #size-cells = <0>;
+
+          charger@75 {
+            reg = <0x75>;
+          };
+        };
+      };
+    };
-- 
2.35.1

