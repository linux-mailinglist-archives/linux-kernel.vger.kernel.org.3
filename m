Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7282D4A7D0E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348472AbiBCBA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:00:27 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:50129 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbiBCBAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:00:24 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id E3E4A2B001A2;
        Wed,  2 Feb 2022 20:00:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 02 Feb 2022 20:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; bh=ghqGX3/+yOOHb2cOr1Jt9KBI+S4cLLds/M5rhcvfosE=; b=bqg5P
        3LfxBT9QfWHEeZu4P2PeC5KtJQcu477uZdXAKwDzwJ6zuYgmbeof372Lr4nz3KM+
        7TXIPrDgRyLwGADhiHsHwHp3NTMPd9S1lUR4dhT35qCjPR7O6XZ008FFftbfgAXd
        C4rHOPwbxNc3tqcECIrF/7bJvvXtYuhWrhY4nKKo3KOZlzq+yoqXMUFQu4svRYvR
        YNiuIN6eJd4rr+F123RclySMHAFqilbmYdIx85Q9fhKJ0sPZdmtqPiIQOhANb2GL
        3XZhwzjHzaDAOswYCc8acn5v22HFagluowvb6WAaIZrPA7JDUEK9+chH68CJeP65
        w+/2ODChvaKQj0CUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=ghqGX3/+yOOHb2cOr1Jt9KBI+S4cL
        Lds/M5rhcvfosE=; b=JvJGlb5IUQsk0DkjjbQKbnPcKjfpRbTct6esJ0QUjMGCZ
        R66US/8aSAwOn7VEt3bV1RGYi2i/VdQ0eXT/is3wtFXJ2L35hX2WZ8MCq8JxHhn8
        X+zpBjvcuBO68LEVO7+eMHhR+4sP9jPUmmKjWahIllTi6OSTj442Xw1cWj7C0FOJ
        HfHKMb2qC9Uo9zXN4yTKmYkl8jW6nIY0T8Q+CnFHToLRfKOMmP7Z227QMEiC1AgP
        j1ftJiyKFiTvb7g8d03ek2i3wuqDsYsGzxKC6O3wqE2NGqeDZvL+UzDyo1zo642T
        /mwTgIgckTUXsN8ifH+UQCj9iOxh5mF3ypUjVGGmA==
X-ME-Sender: <xms:JSn7YbWoye-gmceZB3uyNr1SnsXC3J_9TH6cUJ9Fv3AD0A8C-tIc7w>
    <xme:JSn7YTmPQQsq6RGQWZ-y4OZ0FQILEp8w0cvaRQAhiKtQxeGUEEgzNsYn3YM0Wl9jc
    hO6LNGIvO6MmPh9fg>
X-ME-Received: <xmr:JSn7YXaJgx98ge3DtOzx24_6B5pquH1CmE-rv6Dj7w0Ded3y7wGSm6vXgrdtpl_3G0I0ts_t69Y0R__sgQc8EBBgYZZB3XTj2vXVj_myvv6NOyP_Y6yqaP_gqn8VF8o1lGCvjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    evohgrshhtrghlqdfhgeduvddqtddvucdludehtddmnecujfgurhephffvufffkffoggfg
    sedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcujfholhhlrghnugcuoehsrghmuh
    gvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrghtthgvrhhnpeegffdtvdevgfel
    jeduveefgfefffejhfdtudeiudejueehtdelgefgjeeuffduueenucffohhmrghinhepug
    gvvhhitggvthhrvggvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:JSn7YWX3LOq0pdzQnjfyYXRKAsGnQ5kflGk0dzr6Jm2rGFSQQv0Qtw>
    <xmx:JSn7YVnYyf6mXcTbikgSAQjHEIfnn7WvTGvMs6aedO-6a0wKFbOA4g>
    <xmx:JSn7YTewQ_Uq4JX0bm6KlsD6VGAlgDOe0hebpfPL-BSrm17FMRbntA>
    <xmx:Jin7Ybc-EoVj_bUM2RpPx-BjAsaZP8AQsLT3wk5-gTtgouT9e9PgRiAJ1wU>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 20:00:20 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Pavel Machek <pavel@ucw.cz>, linux-leds@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 1/2] dt-bindings: leds: Add Allwinner R329/D1 LED controller
Date:   Wed,  2 Feb 2022 19:00:18 -0600
Message-Id: <20220203010020.9924-1-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Allwinner R329 and D1 SoCs contain an LED controller designed to
drive a series of RGB LED pixels. It supports PIO and DMA transfers, and
has configurable timing and pixel format.

Acked-by: Maxime Ripard <maxime@cerno.tech>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v4:
 - Use "default" instead of "maxItems" for timing properties

Changes in v3:
 - Removed quotes from enumeration values
 - Added vendor prefix to timing/format properties
 - Renamed "format" property to "pixel-format" for clarity
 - Dropped "vled-supply" as it is unrelated to the controller hardware

Changes in v2:
 - Fixed typo leading to duplicate t1h-ns property
 - Removed "items" layer in definition of dmas/dma-names
 - Replaced uint32 type reference with maxItems in timing properties

 .../leds/allwinner,sun50i-r329-ledc.yaml      | 137 ++++++++++++++++++
 1 file changed, 137 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/allwinner,sun50i-r329-ledc.yaml

diff --git a/Documentation/devicetree/bindings/leds/allwinner,sun50i-r329-ledc.yaml b/Documentation/devicetree/bindings/leds/allwinner,sun50i-r329-ledc.yaml
new file mode 100644
index 000000000000..3db3fe766e6a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/allwinner,sun50i-r329-ledc.yaml
@@ -0,0 +1,137 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/allwinner,sun50i-r329-ledc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner R329 LED Controller Bindings
+
+maintainers:
+  - Samuel Holland <samuel@sholland.org>
+
+description:
+  The LED controller found in Allwinner sunxi SoCs uses a one-wire serial
+  interface to drive up to 1024 RGB LEDs.
+
+properties:
+  compatible:
+    oneOf:
+      - const: allwinner,sun50i-r329-ledc
+      - items:
+          - enum:
+              - allwinner,sun20i-d1-ledc
+          - const: allwinner,sun50i-r329-ledc
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  clocks:
+    items:
+      - description: Bus clock
+      - description: Module clock
+
+  clock-names:
+    items:
+      - const: bus
+      - const: mod
+
+  resets:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+    description: TX DMA channel
+
+  dma-names:
+    const: tx
+
+  interrupts:
+    maxItems: 1
+
+  allwinner,pixel-format:
+    description: Pixel format (subpixel transmission order), default is "grb"
+    enum:
+      - bgr
+      - brg
+      - gbr
+      - grb
+      - rbg
+      - rgb
+
+  allwinner,t0h-ns:
+    default: 336
+    description: Length of high pulse when transmitting a "0" bit
+
+  allwinner,t0l-ns:
+    default: 840
+    description: Length of low pulse when transmitting a "0" bit
+
+  allwinner,t1h-ns:
+    default: 882
+    description: Length of high pulse when transmitting a "1" bit
+
+  allwinner,t1l-ns:
+    default: 294
+    description: Length of low pulse when transmitting a "1" bit
+
+  allwinner,treset-ns:
+    default: 300000
+    description: Minimum delay between transmission frames
+
+patternProperties:
+  "^multi-led@[0-9a-f]+$":
+    type: object
+    $ref: leds-class-multicolor.yaml#
+    properties:
+      reg:
+        minimum: 0
+        maximum: 1023
+        description: Index of the LED in the series (must be contiguous)
+
+    required:
+      - reg
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - dmas
+  - dma-names
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/leds/common.h>
+
+    ledc: led-controller@2008000 {
+      compatible = "allwinner,sun20i-d1-ledc",
+                   "allwinner,sun50i-r329-ledc";
+      reg = <0x2008000 0x400>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+      clocks = <&ccu 12>, <&ccu 34>;
+      clock-names = "bus", "mod";
+      resets = <&ccu 12>;
+      dmas = <&dma 42>;
+      dma-names = "tx";
+      interrupts = <36 IRQ_TYPE_LEVEL_HIGH>;
+
+      multi-led@0 {
+        reg = <0x0>;
+        color = <LED_COLOR_ID_RGB>;
+        function = LED_FUNCTION_INDICATOR;
+      };
+    };
+
+...
-- 
2.33.1

