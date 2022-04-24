Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C673150D317
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiDXQIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 12:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbiDXQIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 12:08:06 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BB4112;
        Sun, 24 Apr 2022 09:05:03 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 41BA95C018D;
        Sun, 24 Apr 2022 12:05:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 24 Apr 2022 12:05:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1650816303; x=1650902703; bh=ma
        QbKuXc1jreez0GCBOLzIJ/NLqx6OH4BtXyW7KPHOQ=; b=YnjQk3QQ9bzbk6cY8p
        5o3vov2urmVEyXrmJzWYthm3zdHlpRRYge8vXivoLshzNFpzuQDdgV0vkta4fbQu
        f3Yk0cKXs8Sp3HYjLovxJ7Xp1YyweU4BMv6MJg2/Wdqu6s17ul8Xtkyt663xlYQv
        CRy8ItbAnsxjIqYlT1gPCZJLGPh4CKVa95N94RxOt1cAFcnIeyOyXf3cpdEg6oyz
        fqTPVvOq+qHvqxj58ReqksCAHbiV2jBQhxxxazZpwxtp6DU8iB1WmDFkz98ZPx5D
        96iArAZ6O+nRdbbrKgUodsou5r0pMu8l7gIhTzGl62nB/m/BoAgL/URXmjdtMIhq
        blMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1650816303; x=1650902703; bh=maQbKuXc1jreez0GCBOLzIJ/NLqx6OH4BtX
        yW7KPHOQ=; b=TyThZjxJprKep1puD5y+yDx8sx5s8uMHNMX3d3onjGOzARn/nar
        hoxR9mJ1F6PXMOMWd16Ax0K+oe2f2khuMIs5fbCg4Q18L3GoNGgd63qLHMEL3URS
        d7j615zSBcR/3uHIf2/p7ObQksQVqIOxv7XKeBCgpPSTwmFYuLAk0wTwCxssU2LP
        K2948num3Q1pY9Or/zQwzLKEj5cQ25i2qqoYng1hQl6GiO13c6NXjXAhlmCelpA/
        yufb2edHJNI5ofciGkxhdbumMk5HBSDbBNJWfFenhGpx0CUUUxLNtUOAnBChd2+3
        NX5P2o2sEUHyVr6dyrkZopH0Skul9Zgv9mg==
X-ME-Sender: <xms:LnVlYgkjRQX25WNoUJyilf_vBqkFP3dF-imya0YaxDcywi-Btxr-9Q>
    <xme:LnVlYv0cLL63XnC2EdqjSeDXPdGAcEQsiuYm-IU2ZGe5Ctq7MVEU_9Cs8jpifIxJy
    fEZ_cGuh_aOFffVIA>
X-ME-Received: <xmr:LnVlYur9b7HgGknhV3vpQFXL7fhnlpTqm-RAsD01x2bJISpuFOLoX15fQJ_eZM0W5HVZUlgD2sFuL50hygfaoEyXcGEgx5dbKsZbwbOC-wG097xSYQ0nQN0YeByJ5ywgAoLD5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdelgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefghfevhffgheejhefgkeehueffgeehffejgeehueduueeffffhhfeu
    iefhueffhfenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhho
    lhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:LnVlYsnEam8PWYs7o2UYdIEYfyVXE1yBfZfXoIJMcaOF2OvevtwTHw>
    <xmx:LnVlYu0j0lDoytBHict2z-jALP9neeAvMJX4FDod7DP0aQaMuueWDg>
    <xmx:LnVlYjvWIltSHLGgnZITzLIgkfuO4GTfnkcgLQr-AK3IypI8RwFT6w>
    <xmx:L3VlYopcVcwTx3KOgyHvIi4daDnxd623iE7hf8naLixJznLdlUMh9g>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Apr 2022 12:05:01 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Ondrej Jirman <x@xff.cz>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 1/4] dt-bindings: input: Add the PinePhone keyboard binding
Date:   Sun, 24 Apr 2022 11:04:54 -0500
Message-Id: <20220424160458.60370-2-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220424160458.60370-1-samuel@sholland.org>
References: <20220424160458.60370-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add devicetree support for the PinePhone keyboard case, which provides a
matrix keyboard interface and a proxied I2C bus.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

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

