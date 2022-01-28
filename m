Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3660C49F5E3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbiA1JEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236881AbiA1JEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:04:04 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61761C061748
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:04:04 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:3999:e79d:cb59:f2ec])
        by laurent.telenet-ops.be with bizsmtp
        id o9402600N04fKGS01940tA; Fri, 28 Jan 2022 10:04:01 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nDNAm-00BjtB-14; Fri, 28 Jan 2022 10:04:00 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nDNAl-005poq-In; Fri, 28 Jan 2022 10:03:59 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 2/2] dt-bindings: interrupt-controller: sifive,plic: Group interrupt tuples
Date:   Fri, 28 Jan 2022 10:03:58 +0100
Message-Id: <211705e74a2ce77de43d036c5dea032484119bf7.1643360419.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1643360419.git.geert@linux-m68k.org>
References: <cover.1643360419.git.geert@linux-m68k.org>
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
  - No changes,

v3:
  - Add Reviewed-by,

v2:
  - Split in two patches.
---
 .../interrupt-controller/sifive,plic-1.0.0.yaml       | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
index 57c06126c99502fa..0dfa6b26e09910a8 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
@@ -91,12 +91,11 @@ examples:
       #interrupt-cells = <1>;
       compatible = "sifive,fu540-c000-plic", "sifive,plic-1.0.0";
       interrupt-controller;
-      interrupts-extended = <
-        &cpu0_intc 11
-        &cpu1_intc 11 &cpu1_intc 9
-        &cpu2_intc 11 &cpu2_intc 9
-        &cpu3_intc 11 &cpu3_intc 9
-        &cpu4_intc 11 &cpu4_intc 9>;
+      interrupts-extended = <&cpu0_intc 11>,
+                            <&cpu1_intc 11>, <&cpu1_intc 9>,
+                            <&cpu2_intc 11>, <&cpu2_intc 9>,
+                            <&cpu3_intc 11>, <&cpu3_intc 9>,
+                            <&cpu4_intc 11>, <&cpu4_intc 9>;
       reg = <0xc000000 0x4000000>;
       riscv,ndev = <10>;
     };
-- 
2.25.1

