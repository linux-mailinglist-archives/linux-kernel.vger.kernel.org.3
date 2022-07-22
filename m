Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81D457E37D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiGVPMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiGVPMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:12:10 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C9A0951EC;
        Fri, 22 Jul 2022 08:12:09 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,186,1654527600"; 
   d="scan'208";a="127045517"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jul 2022 00:12:09 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 90C7B432D9F0;
        Sat, 23 Jul 2022 00:12:05 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v3 1/3] dt-bindings: interrupt-controller: Add macros for NMI and IRQ0-7 interrupts present on RZ/G2L SoC
Date:   Fri, 22 Jul 2022 16:11:53 +0100
Message-Id: <20220722151155.21100-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220722151155.21100-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220722151155.21100-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macros for NMI and IRQ0-7 interrupts which map to SPI0-8 present on
RZ/G2L (and alike) SoC's so that these can be used in the first cell of

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3:
* New patch as suggested by Biju and Geert.
---
 .../interrupt-controller/irqc-rzg2l.h         | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 include/dt-bindings/interrupt-controller/irqc-rzg2l.h

diff --git a/include/dt-bindings/interrupt-controller/irqc-rzg2l.h b/include/dt-bindings/interrupt-controller/irqc-rzg2l.h
new file mode 100644
index 000000000000..34ce778885a1
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/irqc-rzg2l.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * This header provides constants for Renesas RZ/G2L family IRQC bindings.
+ *
+ * Copyright (C) 2022 Renesas Electronics Corp.
+ *
+ */
+
+#ifndef __DT_BINDINGS_IRQC_RZG2L_H
+#define __DT_BINDINGS_IRQC_RZG2L_H
+
+/* NMI maps to SPI0 */
+#define RZG2L_NMI	0
+
+/* IRQ0-7 map to SPI1-8 */
+#define RZG2L_IRQ0	1
+#define RZG2L_IRQ1	2
+#define RZG2L_IRQ2	3
+#define RZG2L_IRQ3	4
+#define RZG2L_IRQ4	5
+#define RZG2L_IRQ5	6
+#define RZG2L_IRQ6	7
+#define RZG2L_IRQ7	8
+
+#endif /* __DT_BINDINGS_IRQC_RZG2L_H */
-- 
2.25.1

