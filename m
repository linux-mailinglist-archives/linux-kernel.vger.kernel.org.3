Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D957449F600
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347486AbiA1JJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347482AbiA1JHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:07:42 -0500
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECDBC061748
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:07:42 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3999:e79d:cb59:f2ec])
        by albert.telenet-ops.be with bizsmtp
        id o97e2600Y04fKGS0697eYM; Fri, 28 Jan 2022 10:07:40 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nDNEI-00BjuW-Fe; Fri, 28 Jan 2022 10:07:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nDNEI-005psK-0U; Fri, 28 Jan 2022 10:07:38 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/2] dt-bindings: timer: sifive,clint: Group interrupt tuples
Date:   Fri, 28 Jan 2022 10:07:36 +0100
Message-Id: <62bf4ee6613550c07a99d4bd226ab0d33acae4c4.1643360652.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643360652.git.geert@linux-m68k.org>
References: <cover.1643360652.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To improve human readability and enable automatic validation, the tuples
in "interrupts-extended" properties should be grouped using angle
brackets.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
v4:
  - Add Reviewed-by (this time for real ;-),

v3:
  - Add Reviewed-by,

v2:
  - Split in two patches.
---
 Documentation/devicetree/bindings/timer/sifive,clint.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
index fe4b73c3f269fc0f..e64f46339079fa3f 100644
--- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
+++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
@@ -57,10 +57,10 @@ examples:
   - |
     timer@2000000 {
       compatible = "sifive,fu540-c000-clint", "sifive,clint0";
-      interrupts-extended = <&cpu1intc 3 &cpu1intc 7
-                             &cpu2intc 3 &cpu2intc 7
-                             &cpu3intc 3 &cpu3intc 7
-                             &cpu4intc 3 &cpu4intc 7>;
+      interrupts-extended = <&cpu1intc 3>, <&cpu1intc 7>,
+                            <&cpu2intc 3>, <&cpu2intc 7>,
+                            <&cpu3intc 3>, <&cpu3intc 7>,
+                            <&cpu4intc 3>, <&cpu4intc 7>;
        reg = <0x2000000 0x10000>;
     };
 ...
-- 
2.25.1

