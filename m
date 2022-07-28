Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3997583C69
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiG1KqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236558AbiG1KpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:45:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34420664E3;
        Thu, 28 Jul 2022 03:44:23 -0700 (PDT)
Date:   Thu, 28 Jul 2022 10:44:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659005061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BvyQ53aTo6TzG6aGVr0rWTID5OlvrGNl2NWUlk432dU=;
        b=y563N3OfqLDAswrjy3oxY2bQD8Tql9gaslLcPV8xHQBp91gHh2UlUFe4c/+TlOSfMdOHFc
        bjbt0pHRh3sc+F0jgiUdMRq3MChBZP5ucM6gM6YLUMNNEwA1Yivjpr3n4DD+E6sxIiNjMp
        vhcAU5t6x5FWsB2Fx6akJ3cdLbI6UgtitTGNRAiHFgJAl+05gM+GJYmD7MFtt4TM3ANgTc
        jPQQFt27FQ2SAow07psnNUGrJTTTNVcU906a9RZxURLeEvbt2ZgbGYHQqCgggySaTHWLN1
        EJIj1zjbVuHlxMpzABs1kQgiykSh2cvRs5DyJ26Wolxi+h+UTyR+bo4ALT6Eow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659005061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BvyQ53aTo6TzG6aGVr0rWTID5OlvrGNl2NWUlk432dU=;
        b=RpBLNMtwG1KvVahOMEeci2cYalsfTbYkOc9HqYWszRbtSojjRq12wJUr0DNHJHGZnjuGQn
        o4j+aM6rKeVm9GCQ==
From:   "tip-bot2 for Linus Walleij" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: Add Nomadik MTU binding
Cc:     Lee Jones <lee.jones@linaro.org>, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220526213621.373727-1-linus.walleij@linaro.org>
References: <20220526213621.373727-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Message-ID: <165900506020.15455.5741050322919175591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d6513a34926f4f4b331be115819702ca2a4682fb
Gitweb:        https://git.kernel.org/tip/d6513a34926f4f4b331be115819702ca2a4682fb
Author:        Linus Walleij <linus.walleij@linaro.org>
AuthorDate:    Thu, 26 May 2022 23:36:21 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 14 Jun 2022 21:23:06 +02:00

dt-bindings: timer: Add Nomadik MTU binding

The Nomadik MTU timer has been used in devicetrees forever
but somehow we missed to add a binding for it. Fix it
by simply adding it.

Cc: Lee Jones <lee.jones@linaro.org>
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20220526213621.373727-1-linus.walleij@linaro.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml | 58 +++++++-
 1 file changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml

diff --git a/Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml b/Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml
new file mode 100644
index 0000000..901848d
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2022 Linaro Ltd.
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/timer/st,nomadik-mtu.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: ST Microelectronics Nomadik Multi-Timer Unit MTU Timer
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: This timer is found in the ST Microelectronics Nomadik
+  SoCs STn8800, STn8810 and STn8815 as well as in ST-Ericsson DB8500.
+
+properties:
+  compatible:
+    items:
+      - const: st,nomadik-mtu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: The first clock named TIMCLK clocks the actual timers and
+      the second clock clocks the digital interface to the interconnect.
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: timclk
+      - const: apb_pclk
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/mfd/dbx500-prcmu.h>
+    timer@a03c6000 {
+      compatible = "st,nomadik-mtu";
+      reg = <0xa03c6000 0x1000>;
+      interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
+
+      clocks = <&prcmu_clk PRCMU_TIMCLK>, <&prcc_pclk 6 6>;
+      clock-names = "timclk", "apb_pclk";
+    };
