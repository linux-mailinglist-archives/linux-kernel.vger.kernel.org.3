Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C1A57D217
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 18:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiGUQ5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 12:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiGUQ5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 12:57:20 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0053189A6D;
        Thu, 21 Jul 2022 09:57:18 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,183,1654527600"; 
   d="scan'208";a="126927672"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 22 Jul 2022 01:57:18 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3FDFC400854E;
        Fri, 22 Jul 2022 01:57:14 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 1/2] dt-bindings: pinctrl: rzg2l-pinctrl: Add macros for IRQ0-7
Date:   Thu, 21 Jul 2022 17:57:00 +0100
Message-Id: <20220721165701.17888-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721165701.17888-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220721165701.17888-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add macros for IRQ0-7 which map to SPI1-8 so that it can be used in dts/i.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* New patch
---
 include/dt-bindings/pinctrl/rzg2l-pinctrl.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/dt-bindings/pinctrl/rzg2l-pinctrl.h b/include/dt-bindings/pinctrl/rzg2l-pinctrl.h
index c78ed5e5efb7..6aae2ac206d6 100644
--- a/include/dt-bindings/pinctrl/rzg2l-pinctrl.h
+++ b/include/dt-bindings/pinctrl/rzg2l-pinctrl.h
@@ -20,4 +20,14 @@
 /* Convert a port and pin label to its global pin index */
 #define RZG2L_GPIO(port, pin)	((port) * RZG2L_PINS_PER_PORT + (pin))
 
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
 #endif /* __DT_BINDINGS_RZG2L_PINCTRL_H */
-- 
2.25.1

