Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47B8F489921
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235688AbiAJNCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234464AbiAJNA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:00:59 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DBCC03400C;
        Mon, 10 Jan 2022 04:59:55 -0800 (PST)
Date:   Mon, 10 Jan 2022 12:59:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1641819592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSF1I+eyMOiYen7vFo64VXCbA7tJh3eJdjMbbky58Uc=;
        b=HsXej0Z078IJwXpzVSBVEDgvcI2dBrs275jfXg7FZjlgzH1GerqTaoV2WggJJsTCe67V5K
        unmopUVOmhuJUhjwkATKrH0JaOcKlMLaet765Yj9fQmT6HWvIXqbzGGAVVXVf00AvXLszK
        FGdE4/72EDE9ZpfH1iKcJiAE4+qrLNbjPf5iISixNXRAsBdBeFfxDgjkl9mBFkXsSvTwKh
        Ym25ColquADOYSzMoY5DNq6MaaOXbV106QBjYFycmKNXn7ZaC1g7lgwKxzYNOLEAhCvDPd
        o5BXCPOJ/QdIlosNn+RSudz/PG+n9IhA0+1A4lB86vHS1Cfv2aiX/I5NaZ0fJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1641819592;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSF1I+eyMOiYen7vFo64VXCbA7tJh3eJdjMbbky58Uc=;
        b=SvxvwnzcXNLNQGwj2+p1kWY75oCS+X7HRrTZDjFVgaEfMK5oOCarkULw1zWXye04AvQPO5
        T4TP4Qhg2JDJirCQ==
From:   "tip-bot2 for Romain Perier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] dt-bindings: timer: Add Mstar MSC313e timer
 devicetree bindings documentation
Cc:     Romain Perier <romain.perier@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211217195727.8955-5-romain.perier@gmail.com>
References: <20211217195727.8955-5-romain.perier@gmail.com>
MIME-Version: 1.0
Message-ID: <164181959116.16921.9126681287517696683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7647204c2e81b28b4a7c4eec7d539f998d48eaf0
Gitweb:        https://git.kernel.org/tip/7647204c2e81b28b4a7c4eec7d539f998d48eaf0
Author:        Romain Perier <romain.perier@gmail.com>
AuthorDate:    Fri, 17 Dec 2021 20:57:25 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 20 Dec 2021 13:28:47 +01:00

dt-bindings: timer: Add Mstar MSC313e timer devicetree bindings documentation

This adds the documentation for the devicetree bindings of the Mstar
MSC313e timer driver, found from MSC313e SoCs and newer.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20211217195727.8955-5-romain.perier@gmail.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml b/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
new file mode 100644
index 0000000..03d5dba
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/mstar,msc313e-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Mstar MSC313e Timer Device Tree Bindings
+
+maintainers:
+  - Daniel Palmer <daniel@0x0f.com>
+  - Romain Perier <romain.perier@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - mstar,msc313e-timer
+      - sstar,ssd20xd-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    timer@6040 {
+        compatible = "mstar,msc313e-timer";
+        reg = <0x6040 0x40>;
+        clocks = <&xtal_div2>;
+        interrupts-extended = <&intc_fiq GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+    };
+...
