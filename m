Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1547B3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240845AbhLTTdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:33:39 -0500
Received: from aposti.net ([89.234.176.197]:38760 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237942AbhLTTde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:33:34 -0500
From:   Paul Cercueil <paul@crapouillou.net>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     list@opendingux.net, linux-mips@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 1/2] dt-bindings: clk/ingenic: Add MDMA and BDMA clocks
Date:   Mon, 20 Dec 2021 19:33:18 +0000
Message-Id: <20211220193319.114974-2-paul@crapouillou.net>
In-Reply-To: <20211220193319.114974-1-paul@crapouillou.net>
References: <20211220193319.114974-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Ingenic JZ4760 and JZ4770 both have an extra DMA core named BDMA
dedicated to the NAND and BCH controller, but which can also do
memory-to-memory transfers. The JZ4760 additionally has a DMA core named
MDMA dedicated to memory-to-memory transfers. The programming manual for
the JZ4770 does have a bit for a MDMA clock, but does not seem to have
the hardware wired in.

Add macros for the MDMA and BDMA clocks to the dt-bindings include
files, so that they can be used within Device Tree files.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v3: New patch

 include/dt-bindings/clock/ingenic,jz4760-cgu.h | 2 ++
 include/dt-bindings/clock/ingenic,jz4770-cgu.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/dt-bindings/clock/ingenic,jz4760-cgu.h b/include/dt-bindings/clock/ingenic,jz4760-cgu.h
index 4bb2e19c4743..9fb04ebac6de 100644
--- a/include/dt-bindings/clock/ingenic,jz4760-cgu.h
+++ b/include/dt-bindings/clock/ingenic,jz4760-cgu.h
@@ -50,5 +50,7 @@
 #define JZ4760_CLK_LPCLK_DIV	41
 #define JZ4760_CLK_TVE		42
 #define JZ4760_CLK_LPCLK	43
+#define JZ4760_CLK_MDMA		44
+#define JZ4760_CLK_BDMA		45
 
 #endif /* __DT_BINDINGS_CLOCK_JZ4760_CGU_H__ */
diff --git a/include/dt-bindings/clock/ingenic,jz4770-cgu.h b/include/dt-bindings/clock/ingenic,jz4770-cgu.h
index d68a7695a1f8..0b475e8ae321 100644
--- a/include/dt-bindings/clock/ingenic,jz4770-cgu.h
+++ b/include/dt-bindings/clock/ingenic,jz4770-cgu.h
@@ -54,5 +54,6 @@
 #define JZ4770_CLK_OTG_PHY	45
 #define JZ4770_CLK_EXT512	46
 #define JZ4770_CLK_RTC		47
+#define JZ4770_CLK_BDMA		48
 
 #endif /* __DT_BINDINGS_CLOCK_JZ4770_CGU_H__ */
-- 
2.34.1

