Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454DC55532F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 20:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377643AbiFVSRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 14:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377591AbiFVSRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 14:17:42 -0400
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 749643DDE4;
        Wed, 22 Jun 2022 11:17:40 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,212,1650898800"; 
   d="scan'208";a="123780499"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 23 Jun 2022 03:17:39 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 6404040C7F2E;
        Thu, 23 Jun 2022 03:17:36 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/2] dt-bindings: clock: r9a07g043-cpg: Add Renesas RZ/Five CPG Clock and Reset Definitions
Date:   Wed, 22 Jun 2022 19:17:22 +0100
Message-Id: <20220622181723.13033-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220622181723.13033-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220622181723.13033-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Renesas RZ/Five SoC has almost the same clock structure compared to the
Renesas RZ/G2UL SoC, re-use the r9a07g043-cpg.h header file and just
amend the RZ/Five CPG clock and reset definitions.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/dt-bindings/clock/r9a07g043-cpg.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/dt-bindings/clock/r9a07g043-cpg.h b/include/dt-bindings/clock/r9a07g043-cpg.h
index 27e232733096..77cde8effdc7 100644
--- a/include/dt-bindings/clock/r9a07g043-cpg.h
+++ b/include/dt-bindings/clock/r9a07g043-cpg.h
@@ -108,6 +108,15 @@
 #define R9A07G043_ADC_ADCLK		76
 #define R9A07G043_ADC_PCLK		77
 #define R9A07G043_TSU_PCLK		78
+#define R9A07G043_NCEPLDM_DM_CLK	79	/* RZ/Five Only */
+#define R9A07G043_NCEPLDM_ACLK		80	/* RZ/Five Only */
+#define R9A07G043_NCEPLDM_TCK		81	/* RZ/Five Only */
+#define R9A07G043_NCEPLMT_ACLK		82	/* RZ/Five Only */
+#define R9A07G043_NCEPLIC_ACLK		83	/* RZ/Five Only */
+#define R9A07G043_AX45MP_CORE0_CLK	84	/* RZ/Five Only */
+#define R9A07G043_AX45MP_ACLK		85	/* RZ/Five Only */
+#define R9A07G043_IAX45_CLK		86	/* RZ/Five Only */
+#define R9A07G043_IAX45_PCLK		87	/* RZ/Five Only */
 
 /* R9A07G043 Resets */
 #define R9A07G043_CA55_RST_1_0		0	/* RZ/G2UL Only */
@@ -180,5 +189,16 @@
 #define R9A07G043_ADC_PRESETN		67
 #define R9A07G043_ADC_ADRST_N		68
 #define R9A07G043_TSU_PRESETN		69
+#define R9A07G043_NCEPLDM_DTM_PWR_RST_N	70	/* RZ/Five Only */
+#define R9A07G043_NCEPLDM_ARESETN	71	/* RZ/Five Only */
+#define R9A07G043_NCEPLMT_POR_RSTN	72	/* RZ/Five Only */
+#define R9A07G043_NCEPLMT_ARESETN	73	/* RZ/Five Only */
+#define R9A07G043_NCEPLIC_ARESETN	74	/* RZ/Five Only */
+#define R9A07G043_AX45MP_ARESETNM	75	/* RZ/Five Only */
+#define R9A07G043_AX45MP_ARESETNS	76	/* RZ/Five Only */
+#define R9A07G043_AX45MP_L2_RESETN	77	/* RZ/Five Only */
+#define R9A07G043_AX45MP_CORE0_RESETN	78	/* RZ/Five Only */
+#define R9A07G043_IAX45_RESETN		79	/* RZ/Five Only */
+
 
 #endif /* __DT_BINDINGS_CLOCK_R9A07G043_CPG_H__ */
-- 
2.25.1

