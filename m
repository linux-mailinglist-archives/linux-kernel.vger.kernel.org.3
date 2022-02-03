Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB524A7DCD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 03:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348969AbiBCCRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 21:17:54 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:35819 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348959AbiBCCRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 21:17:48 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id AD76F2B0019B;
        Wed,  2 Feb 2022 21:17:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Feb 2022 21:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; bh=gNf3/vlWylyrdfT/3jLa7uO+I61X7m
        5VTn6xdD42vs4=; b=kQpu+NYSJHyubmEszRsxMHgq7XiYzEJQkxuSgqgFOTe3bI
        HMYa9QTY5Rl9u7ebwLAMUP0tktkQz/DF95TmBLbSsZVj/DWfP8kba88OVL3vcEyE
        WJFELDzJXxUHJZ1EMu03FWX0qPq02/3Hxcv4Y0v23GtyeCmd6hmKwj9CGsZUZtlc
        w7RRB+HNEdVRsQnk+F+CWB6X8Iq4/pf/uI8OWLh4ytiqkK5QNXNMgUGjjDjhXCKm
        CWqo9W5dpwVQgwoswpV1TTOfKVba2bXPQKWYByAz9xCWFQ2ie8u+JtCyd3D2zXaE
        Pw0o9vmIK7lSZPzySO7xAdIt6h1ikAWJMlbPzOYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gNf3/v
        lWylyrdfT/3jLa7uO+I61X7m5VTn6xdD42vs4=; b=fIrHf7sPrRleras+bUD6oj
        +NfQBkoENB4kMSqcuXLwjbG5VoqxownYWSZ3u0e8nV0srDPw220X134A06i7Ijss
        OM1WhuKwhTyiXhMm2UnqEvo6QcHhfru7PpWiIY/2bM9GNFQQkE9c/B0Uo2kv3Bgb
        t2kdeoiJgWCRobwOPJqdBb+cLLPnEDgnZVPQr5tNiL5xAFrRDITmBa2qbH4Ma+l2
        dw3OLVkx9JS8w6U/rciWtYZpq5SH4wnHxYnS2xjI4AijK1HxGHI04Uw+sJe+QJMQ
        w4f81fX4V2/kYV+HAMTGlbFlZXCb/PYTtDTw82osp+Pdo8A0sGctPLsz1yrOA0hw
        ==
X-ME-Sender: <xms:Sjv7YVIY8uu5Zhz9z5UfCPoVhgtILQByx9tgzIjy1308fF1xGlHqGQ>
    <xme:Sjv7YRIjfMfFzGrDl9jTya2lYpOD3FB-LqN5ejmIbUbnBMciILYS6u8oDE0ngEDhz
    p4jtuOz_xhLCxtZdg>
X-ME-Received: <xmr:Sjv7YdtyVV9x6xnug5l5ZgnMgdGJyBfNHv_GI9Vy8NW7cjD9QYS70nJDYWDSRxNcMolfG89X_KRoV96xDba4zDJAAx2wgXbq0ZmCZNIY-RUTjNYd-fdmylYNLbnNlAN0_90scQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Sjv7YWYVWm0TsWKSN9mITK_qTxhVqNQXevgnwapEiD6GSpfL6Ti38A>
    <xmx:Sjv7YcaE4OjdAcfITKlAcPU9XNAVmsv3AvrmdFq3neOnB0eUV5sb_w>
    <xmx:Sjv7YaAIUXq3l0Sn9MY03726CGmiy50T02NAXlhgaxCRhobld5IYww>
    <xmx:Sjv7YcqCspaosfgZ62aak7hux8M9Be4ISPdif81ba6i-NrXsWmICFtKbJMc>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 21:17:45 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Michael Turquette <mturquette@baylibre.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 2/6] dt-bindings: rtc: sun6i: Add H616, R329, and D1 support
Date:   Wed,  2 Feb 2022 20:17:32 -0600
Message-Id: <20220203021736.13434-3-samuel@sholland.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220203021736.13434-1-samuel@sholland.org>
References: <20220203021736.13434-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These new RTC variants all have a single alarm, like the R40 variant.

For the new SoCs, start requiring a complete list of input clocks. The
H616 has three required clocks. The R329 also has three required clocks
(but one is different), plus an optional crystal oscillator input. The
D1 RTC is identical to the one in the R329.

And since these new SoCs will have a well-defined output clock order as
well, they do not need the clock-output-names property.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

Changes in v3:
 - Add/fix several maxItems attributes for clocks and clock-items

Changes in v2:
 - Properly update the DT binding clocks and clock-names properties.

 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml | 76 ++++++++++++++++++-
 include/dt-bindings/clock/sun6i-rtc.h         | 10 +++
 2 files changed, 83 insertions(+), 3 deletions(-)
 create mode 100644 include/dt-bindings/clock/sun6i-rtc.h

diff --git a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
index a88d46ffb457..0b767fec39d8 100644
--- a/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
+++ b/Documentation/devicetree/bindings/rtc/allwinner,sun6i-a31-rtc.yaml
@@ -24,9 +24,14 @@ properties:
           - allwinner,sun8i-v3-rtc
           - allwinner,sun50i-h5-rtc
           - allwinner,sun50i-h6-rtc
+          - allwinner,sun50i-h616-rtc
+          - allwinner,sun50i-r329-rtc
       - items:
           - const: allwinner,sun50i-a64-rtc
           - const: allwinner,sun8i-h3-rtc
+      - items:
+          - const: allwinner,sun20i-d1-rtc
+          - const: allwinner,sun50i-r329-rtc
 
   reg:
     maxItems: 1
@@ -38,7 +43,12 @@ properties:
       - description: RTC Alarm 1
 
   clocks:
-    maxItems: 1
+    minItems: 1
+    maxItems: 4
+
+  clock-names:
+    minItems: 1
+    maxItems: 4
 
   clock-output-names:
     minItems: 1
@@ -98,7 +108,68 @@ allOf:
       properties:
         compatible:
           contains:
-            const: allwinner,sun8i-r40-rtc
+            const: allwinner,sun50i-h616-rtc
+
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 3
+          items:
+            - description: Bus clock for register access
+            - description: 24 MHz oscillator
+            - description: 32 kHz clock from the CCU
+
+        clock-names:
+          minItems: 3
+          maxItems: 3
+          items:
+            - const: bus
+            - const: hosc
+            - const: pll-32k
+
+      required:
+        - clocks
+        - clock-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-r329-rtc
+
+    then:
+      properties:
+        clocks:
+          minItems: 3
+          maxItems: 4
+          items:
+            - description: Bus clock for register access
+            - description: 24 MHz oscillator
+            - description: AHB parent for internal SPI clock
+            - description: External 32768 Hz oscillator
+
+        clock-names:
+          minItems: 3
+          maxItems: 4
+          items:
+            - const: bus
+            - const: hosc
+            - const: ahb
+            - const: ext-osc32k
+
+      required:
+        - clocks
+        - clock-names
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - allwinner,sun8i-r40-rtc
+              - allwinner,sun50i-h616-rtc
+              - allwinner,sun50i-r329-rtc
 
     then:
       properties:
@@ -117,7 +188,6 @@ required:
   - compatible
   - reg
   - interrupts
-  - clock-output-names
 
 additionalProperties: false
 
diff --git a/include/dt-bindings/clock/sun6i-rtc.h b/include/dt-bindings/clock/sun6i-rtc.h
new file mode 100644
index 000000000000..c845493e4d37
--- /dev/null
+++ b/include/dt-bindings/clock/sun6i-rtc.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: (GPL-2.0+ or MIT) */
+
+#ifndef _DT_BINDINGS_CLK_SUN6I_RTC_H_
+#define _DT_BINDINGS_CLK_SUN6I_RTC_H_
+
+#define CLK_OSC32K		0
+#define CLK_OSC32K_FANOUT	1
+#define CLK_IOSC		2
+
+#endif /* _DT_BINDINGS_CLK_SUN6I_RTC_H_ */
-- 
2.33.1

