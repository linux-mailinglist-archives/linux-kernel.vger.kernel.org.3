Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F8E496B46
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiAVJSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234111AbiAVJSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:18:12 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6A0C06173D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:11 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id g9-20020a17090a67c900b001b4f1d71e4fso11261449pjm.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=soaaam3hrgCVzQ6/QI7F3r+P2+uJDpqXG3CI212RPDk=;
        b=QyFbqM44aSrb34eI7sLJhVr+hT9Xtu0lkHQkKLNPHCtf1GU8JFK91tJXqMQ9bei7M7
         QytbwIPkuZ5AVIcsuR/+JT/ECDDm5VWuBZ1Pguckwoh8lDgLYF48js/ARCzFJQk5zOlY
         bwcq6LLeujCAyj+nV3sGiz5Nj1OKxjg1aOlO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=soaaam3hrgCVzQ6/QI7F3r+P2+uJDpqXG3CI212RPDk=;
        b=xAuWmZofmJW1EhIYp+CoQcjY+KKzHHhaed/mi9iXQhCD11vqVPwNgTA1zAXP9b9BYQ
         lQCLR3mfHAKp+zPHqUetLWGZCR9Mk9NPsQQO58VAcRy6ICFnWVzR1WJx9gY2aUOhVhAk
         WQ1YgKRL+Td+2wf+KXEOrmOy+oRfeZ4n1QpVGDRkTOkIDRlauK4qPUPqTVMs56US+f/R
         x3Er5Gwg+JFwRuK1sw3Tk7wf2hfY2NAaAzwj53aw2oEAh1/c8b9M+y332SrorfUmOAIb
         m9lhRJH4NVjHxqAdcVIaotE+q1N/6x68g1+lDHZPbUmmcvlcBM8NEz6lrbXhSPINTYd2
         N+zA==
X-Gm-Message-State: AOAM5311SJuwrNXxHugjwp8A5fdK2I5k4EnpMjYWA/o+jCYeBbPcJbQH
        7lGRXh7Ar6GqoKeE+clEFPO3Tw==
X-Google-Smtp-Source: ABdhPJzdpROET+8RI0Gyr57GHoVyoxvKKi9vA/0+ao7/0omPPQuT+tNYt69NCwuFKYCBbus3iiVFTg==
X-Received: by 2002:a17:90b:3b88:: with SMTP id pc8mr24965pjb.245.1642843091354;
        Sat, 22 Jan 2022 01:18:11 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:10 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/31] clk: mediatek: pll: Split definitions into separate header file
Date:   Sat, 22 Jan 2022 17:17:12 +0800
Message-Id: <20220122091731.283592-13-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the PLL type clk was implemented in the MediaTek clk driver
library, the data structure definitions and function declaration
were put in the common header file.

Since it is its own type of clk, and not all platform clk drivers
utilize it, having the definitions in the common header results
in wasted cycles during compilation.

Split out the related definitions and declarations into its own
header file, and include that only in the platform clk drivers that
need it.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt2701.c            |  5 +-
 drivers/clk/mediatek/clk-mt2712.c            |  3 +-
 drivers/clk/mediatek/clk-mt6765.c            |  3 +-
 drivers/clk/mediatek/clk-mt6779.c            |  3 +-
 drivers/clk/mediatek/clk-mt6797.c            |  3 +-
 drivers/clk/mediatek/clk-mt7622.c            |  5 +-
 drivers/clk/mediatek/clk-mt7629.c            |  5 +-
 drivers/clk/mediatek/clk-mt7986-apmixed.c    |  4 +-
 drivers/clk/mediatek/clk-mt8135.c            |  3 +-
 drivers/clk/mediatek/clk-mt8167.c            |  3 +-
 drivers/clk/mediatek/clk-mt8173.c            |  5 +-
 drivers/clk/mediatek/clk-mt8183.c            |  3 +-
 drivers/clk/mediatek/clk-mt8192.c            |  3 +-
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c |  1 +
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c |  1 +
 drivers/clk/mediatek/clk-mt8516.c            |  3 +-
 drivers/clk/mediatek/clk-mtk.h               | 39 --------------
 drivers/clk/mediatek/clk-pll.c               |  1 +
 drivers/clk/mediatek/clk-pll.h               | 55 ++++++++++++++++++++
 19 files changed, 91 insertions(+), 57 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-pll.h

diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 695be0f77427..1eb3e4563c3f 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -10,9 +10,10 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
-#include "clk-mtk.h"
-#include "clk-gate.h"
 #include "clk-cpumux.h"
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt2701-clk.h>
 
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index a3bd9a107209..ff72b9ab945b 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -13,8 +13,9 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-pll.h"
+#include "clk-mtk.h"
 
 #include <dt-bindings/clock/mt2712-clk.h>
 
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index d77ea5aff292..24829ca3bd1f 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -12,9 +12,10 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
-#include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-mtk.h"
 #include "clk-mux.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt6765-clk.h>
 
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 9825385c9f94..7b61664da18f 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -10,9 +10,10 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
+#include "clk-gate.h"
 #include "clk-mtk.h"
 #include "clk-mux.h"
-#include "clk-gate.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt6779-clk.h>
 
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 428eb24ffec5..02259e81625a 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -9,8 +9,9 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
-#include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt6797-clk.h>
 
diff --git a/drivers/clk/mediatek/clk-mt7622.c b/drivers/clk/mediatek/clk-mt7622.c
index ef5947e15c75..0e1fb30a1e98 100644
--- a/drivers/clk/mediatek/clk-mt7622.c
+++ b/drivers/clk/mediatek/clk-mt7622.c
@@ -11,9 +11,10 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
-#include "clk-mtk.h"
-#include "clk-gate.h"
 #include "clk-cpumux.h"
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt7622-clk.h>
 #include <linux/clk.h> /* for consumer */
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index a0ee079670c7..c0e023bf31eb 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -12,9 +12,10 @@
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 
-#include "clk-mtk.h"
-#include "clk-gate.h"
 #include "clk-cpumux.h"
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt7629-clk.h>
 
diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
index 98ec3887585f..21d4c82e782a 100644
--- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
@@ -10,9 +10,11 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
-#include "clk-mtk.h"
+
 #include "clk-gate.h"
+#include "clk-mtk.h"
 #include "clk-mux.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt7986-clk.h>
 #include <linux/clk.h>
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 9b4b645aea99..09ad272d51f1 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -11,8 +11,9 @@
 #include <linux/mfd/syscon.h>
 #include <dt-bindings/clock/mt8135-clk.h>
 
-#include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-pll.h"
 
 static DEFINE_SPINLOCK(mt8135_clk_lock);
 
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index e5ea10e31799..812b33a57530 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -12,8 +12,9 @@
 #include <linux/slab.h>
 #include <linux/mfd/syscon.h>
 
-#include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt8167-clk.h>
 
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index 8f898ac476c0..46b7655feeaa 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -8,9 +8,10 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 
-#include "clk-mtk.h"
-#include "clk-gate.h"
 #include "clk-cpumux.h"
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt8173-clk.h>
 
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 5046852eb0fd..68496554dd3d 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -11,9 +11,10 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include "clk-gate.h"
 #include "clk-mtk.h"
 #include "clk-mux.h"
-#include "clk-gate.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt8183-clk.h>
 
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index cbc7c6dbe0f4..5f998aab3bfd 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -12,9 +12,10 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
+#include "clk-gate.h"
 #include "clk-mtk.h"
 #include "clk-mux.h"
-#include "clk-gate.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt8192-clk.h>
 
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index 6156ceeed71e..5b1b7dc447eb 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -5,6 +5,7 @@
 
 #include "clk-gate.h"
 #include "clk-mtk.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt8195-clk.h>
 #include <linux/of_device.h>
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
index f1c84186346e..db449ff877d7 100644
--- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -4,6 +4,7 @@
 // Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
 
 #include "clk-mtk.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt8195-clk.h>
 #include <linux/clk-provider.h>
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index 9d4261ecc760..a37143f920ce 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -11,8 +11,9 @@
 #include <linux/slab.h>
 #include <linux/mfd/syscon.h>
 
-#include "clk-mtk.h"
 #include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt8516-clk.h>
 
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index bdec7dc5e07a..168220f85489 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -179,45 +179,6 @@ void mtk_clk_register_dividers(const struct mtk_clk_divider *mcds,
 struct clk_onecell_data *mtk_alloc_clk_data(unsigned int clk_num);
 void mtk_free_clk_data(struct clk_onecell_data *clk_data);
 
-#define HAVE_RST_BAR	BIT(0)
-#define PLL_AO		BIT(1)
-
-struct mtk_pll_div_table {
-	u32 div;
-	unsigned long freq;
-};
-
-struct mtk_pll_data {
-	int id;
-	const char *name;
-	u32 reg;
-	u32 pwr_reg;
-	u32 en_mask;
-	u32 pd_reg;
-	u32 tuner_reg;
-	u32 tuner_en_reg;
-	u8 tuner_en_bit;
-	int pd_shift;
-	unsigned int flags;
-	const struct clk_ops *ops;
-	u32 rst_bar_mask;
-	unsigned long fmin;
-	unsigned long fmax;
-	int pcwbits;
-	int pcwibits;
-	u32 pcw_reg;
-	int pcw_shift;
-	u32 pcw_chg_reg;
-	const struct mtk_pll_div_table *div_table;
-	const char *parent_name;
-	u32 en_reg;
-	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
-};
-
-void mtk_clk_register_plls(struct device_node *node,
-		const struct mtk_pll_data *plls, int num_plls,
-		struct clk_onecell_data *clk_data);
-
 struct clk *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg);
 
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index f04f724e12e5..64f59554bc9b 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 
 #include "clk-mtk.h"
+#include "clk-pll.h"
 
 #define REG_CON0		0
 #define REG_CON1		4
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
new file mode 100644
index 000000000000..d01b0c38311d
--- /dev/null
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Author: James Liao <jamesjj.liao@mediatek.com>
+ */
+
+#ifndef __DRV_CLK_MTK_PLL_H
+#define __DRV_CLK_MTK_PLL_H
+
+#include <linux/types.h>
+
+struct clk_ops;
+struct clk_onecell_data;
+struct device_node;
+
+struct mtk_pll_div_table {
+	u32 div;
+	unsigned long freq;
+};
+
+#define HAVE_RST_BAR	BIT(0)
+#define PLL_AO		BIT(1)
+
+struct mtk_pll_data {
+	int id;
+	const char *name;
+	u32 reg;
+	u32 pwr_reg;
+	u32 en_mask;
+	u32 pd_reg;
+	u32 tuner_reg;
+	u32 tuner_en_reg;
+	u8 tuner_en_bit;
+	int pd_shift;
+	unsigned int flags;
+	const struct clk_ops *ops;
+	u32 rst_bar_mask;
+	unsigned long fmin;
+	unsigned long fmax;
+	int pcwbits;
+	int pcwibits;
+	u32 pcw_reg;
+	int pcw_shift;
+	u32 pcw_chg_reg;
+	const struct mtk_pll_div_table *div_table;
+	const char *parent_name;
+	u32 en_reg;
+	u8 pll_en_bit; /* Assume 0, indicates BIT(0) by default */
+};
+
+void mtk_clk_register_plls(struct device_node *node,
+			   const struct mtk_pll_data *plls, int num_plls,
+			   struct clk_onecell_data *clk_data);
+
+#endif /* __DRV_CLK_MTK_PLL_H */
-- 
2.35.0.rc0.227.g00780c9af4-goog

