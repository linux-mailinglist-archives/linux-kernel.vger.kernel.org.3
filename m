Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAFF519F8A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 14:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349714AbiEDMgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 08:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349649AbiEDMge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 08:36:34 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCACD1581D;
        Wed,  4 May 2022 05:32:48 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y21so1537965edo.2;
        Wed, 04 May 2022 05:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nswliUYJDJdG6CmPVRzfwj66mOMfbOUhuBr9zAj+qHk=;
        b=hFOgjzNbM6cgHXf/rclnvi7ZV8yJ4g+3nLPVeylpuvEpvuHk407dzSMHFN+qXykJBw
         mJPpZcuithSCc7ZVcoAF6XZEihX3XKtwLfWRe6inqJtXAc+xTJ17RUP8+1nxNoI3VPkj
         eb67C6DEgkvO5+2zdwmH0CfCvGxP5uWC/yIBd06snDc0/GtIlYjEVfUidou1cvzkQIgd
         bPT/xzOcRR2dIIZNncD0dl1T794S5bR4Gkal1ZDt6iQwMEHM7tpj7bLU4+ew93EJR+9L
         C2JZmlUgvbiK1qSLcRuKHfQxqqzh6Xz9l/O49WrW68k0CgCQj0OmOQ+m6jdLdnhRlX06
         kA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nswliUYJDJdG6CmPVRzfwj66mOMfbOUhuBr9zAj+qHk=;
        b=5lUwsCdFCSfkJ6ueE0qpp959fDkKbERdgCt4gnr9vJDA+oZQPKAcboh/oKE1/AXC5s
         T7IXqrB3kV0S/VzdejDPqZNr2lkom8UQNe1ICH8MfwyT5PBaoCu1QMhH3JAqiA9Mv00w
         +QyY5JdCCKQBsREcii4dGu1TfiBvO4dAXkaMYdC+gbVbA33vTx7FQFxRwb1+J6SmY6NU
         YnL6S0WrAGx8dlFt0+lOjCwUoC+glCpHO6B+s1BlPQWi6ucFWy86py8SgPC0hL/dZJWp
         Xy/3KDria0rR5DQXXb2Llxyh52iRTZ0MLRi/kxV5hctT3xQ4Z9qduHXPQS8kYSQK5AEy
         T7OQ==
X-Gm-Message-State: AOAM532xbWEs0eK98XYyqgbFyLAlbKIJYp/AFODlTjp8IY2sWni0+jBG
        ovIU94vWI6sjYlBusWvEP5Q=
X-Google-Smtp-Source: ABdhPJxtddZCpjPMiVat9qF6Hh1mwfDMy6hkM45eYD1tDNP+R0MWTS1+y8jR32JJ3jLOsBhD4OHl5g==
X-Received: by 2002:a05:6402:35c7:b0:427:d231:3740 with SMTP id z7-20020a05640235c700b00427d2313740mr11838717edc.40.1651667567029;
        Wed, 04 May 2022 05:32:47 -0700 (PDT)
Received: from localhost.localdomain (185-177-124-12.hosted-by-worldstream.net. [185.177.124.12])
        by smtp.gmail.com with ESMTPSA id ig1-20020a1709072e0100b006f3ef214e7asm5688693ejc.224.2022.05.04.05.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 05:32:46 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 07/13] clk: mediatek: Add driver for MT6735 topckgen
Date:   Wed,  4 May 2022 16:25:56 +0400
Message-Id: <20220504122601.335495-8-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220504122601.335495-1-y.oudjana@protonmail.com>
References: <20220504122601.335495-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add a driver for MT6735 topckgen clocks.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 MAINTAINERS                                |    1 +
 drivers/clk/mediatek/Kconfig               |    7 +
 drivers/clk/mediatek/Makefile              |    1 +
 drivers/clk/mediatek/clk-mt6735-topckgen.c | 1159 ++++++++++++++++++++
 4 files changed, 1168 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt6735-topckgen.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1077712edb4b..d9d6449f910e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12443,6 +12443,7 @@ L:	linux-clk@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	drivers/clk/mediatek/clk-mt6735-apmixed.c
+F:	drivers/clk/mediatek/clk-mt6735-topckgen.c
 F:	include/dt-bindings/clock/mediatek,mt6735-apmixedsys.h
 F:	include/dt-bindings/clock/mediatek,mt6735-infracfg.h
 F:	include/dt-bindings/clock/mediatek,mt6735-pericfg.h
diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index ab364892f602..7c19e2d7bb02 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -124,6 +124,13 @@ config COMMON_CLK_MT6735_APMIXED
 	help
 	  This driver supports MediaTek MT6735 apmixedsys clocks.
 
+config COMMON_CLK_MT6735_TOPCKGEN
+	tristate "Clock driver for MediaTek MT6735 topckgen"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	help
+	  This driver supports MediaTek MT6735 topckgen clocks.
+
 config COMMON_CLK_MT6765
        bool "Clock driver for MediaTek MT6765"
        depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 7f45a22c6178..e8e892c4145f 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
 
 obj-$(CONFIG_COMMON_CLK_MT6735_APMIXED) += clk-mt6735-apmixed.o
+obj-$(CONFIG_COMMON_CLK_MT6735_TOPCKGEN) += clk-mt6735-topckgen.o
 obj-$(CONFIG_COMMON_CLK_MT6765) += clk-mt6765.o
 obj-$(CONFIG_COMMON_CLK_MT6765_AUDIOSYS) += clk-mt6765-audio.o
 obj-$(CONFIG_COMMON_CLK_MT6765_CAMSYS) += clk-mt6765-cam.o
diff --git a/drivers/clk/mediatek/clk-mt6735-topckgen.c b/drivers/clk/mediatek/clk-mt6735-topckgen.c
new file mode 100644
index 000000000000..444c87aed71e
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt6735-topckgen.c
@@ -0,0 +1,1159 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-mux.h"
+
+#include <dt-bindings/clock/mediatek,mt6735-topckgen.h>
+
+#define CLK_CFG_0		0x40
+#define CLK_CFG_0_SET		0x44
+#define CLK_CFG_0_CLR		0x48
+#define CLK_CFG_1		0x50
+#define CLK_CFG_1_SET		0x54
+#define CLK_CFG_1_CLR		0x58
+#define CLK_CFG_2		0x60
+#define CLK_CFG_2_SET		0x64
+#define CLK_CFG_2_CLR		0x68
+#define CLK_CFG_3		0x70
+#define CLK_CFG_3_SET		0x74
+#define CLK_CFG_3_CLR		0x78
+#define CLK_CFG_4		0x80
+#define CLK_CFG_4_SET		0x84
+#define CLK_CFG_4_CLR		0x88
+#define CLK_CFG_5		0x90
+#define CLK_CFG_5_SET		0x94
+#define CLK_CFG_5_CLR		0x98
+#define CLK_CFG_6		0xa0
+#define CLK_CFG_6_SET		0xa4
+#define CLK_CFG_6_CLR		0xa8
+#define CLK_CFG_7		0xb0
+#define CLK_CFG_7_SET		0xb4
+#define CLK_CFG_7_CLR		0xb8
+
+static DEFINE_SPINLOCK(mt6735_topckgen_lock);
+
+/* Some clocks with unknown details are modeled as fixed clocks */
+static const struct mtk_fixed_clk top_fixed_clks[] = {
+	{
+		/*
+		 * This clock is available as a parent option for multiple
+		 * muxes and seems like an alternative name for clk26m at first,
+		 * but it appears alongside it in several muxes which should
+		 * mean it is a separate clock.
+		 */
+		.id = AD_SYS_26M_CK,
+		.name = "ad_sys_26m_ck",
+		.parent = "clk26m",
+		.rate = 26 * MHZ,
+	},
+	{
+		/*
+		 * This clock is the parent of DMPLL divisors. It might be MEMPLL
+		 * or its parent, as DMPLL appears to be an alternative name for
+		 * MEMPLL.
+		 */
+		.id = CLKPH_MCK_O,
+		.name = "clkph_mck_o",
+		.parent = NULL
+	},
+	{
+		/*
+		 * DMPLL clock (dmpll_ck), controlled by DDRPHY.
+		 */
+		.id = DMPLL,
+		.name = "dmpll",
+		.parent = "clkph_mck_o"
+	},
+	{
+		/*
+		 * MIPI DPI clock. Parent option for dpi0_sel. Unknown parent.
+		 */
+		.id = DPI_CK,
+		.name = "dpi_ck",
+		.parent = NULL
+	},
+	{
+		/*
+		 * This clock is a child of WHPLL which is controlled by
+		 * the modem.
+		 */
+		.id = WHPLL_AUDIO_CK,
+		.name = "whpll_audio_ck",
+		.parent = NULL
+	},
+};
+
+static const struct mtk_fixed_factor top_divs[] = {
+	{
+		.id = SYSPLL_D2,
+		.name = "syspll_d2",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = SYSPLL_D3,
+		.name = "syspll_d3",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 3
+	},
+	{
+		.id = SYSPLL_D5,
+		.name = "syspll_d5",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 5
+	},
+	{
+		.id = SYSPLL1_D2,
+		.name = "syspll1_d2",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = SYSPLL1_D4,
+		.name = "syspll1_d4",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = SYSPLL1_D8,
+		.name = "syspll1_d8",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 8
+	},
+	{
+		.id = SYSPLL1_D16,
+		.name = "syspll1_d16",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 16
+	},
+	{
+		.id = SYSPLL2_D2,
+		.name = "syspll2_d2",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = SYSPLL2_D4,
+		.name = "syspll2_d4",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = SYSPLL3_D2,
+		.name = "syspll3_d2",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = SYSPLL3_D4,
+		.name = "syspll3_d4",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = SYSPLL4_D2,
+		.name = "syspll4_d2",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = SYSPLL4_D4,
+		.name = "syspll4_d4",
+		.parent_name = "mainpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = UNIVPLL_D2,
+		.name = "univpll_d2",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = UNIVPLL_D3,
+		.name = "univpll_d3",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 3
+	},
+	{
+		.id = UNIVPLL_D5,
+		.name = "univpll_d5",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 5
+	},
+	{
+		.id = UNIVPLL_D26,
+		.name = "univpll_d26",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 26
+	},
+	{
+		.id = UNIVPLL1_D2,
+		.name = "univpll1_d2",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = UNIVPLL1_D4,
+		.name = "univpll1_d4",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = UNIVPLL1_D8,
+		.name = "univpll1_d8",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 8
+	},
+	{
+		.id = UNIVPLL2_D2,
+		.name = "univpll2_d2",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = UNIVPLL2_D4,
+		.name = "univpll2_d4",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = UNIVPLL2_D8,
+		.name = "univpll2_d8",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 8
+	},
+	{
+		.id = UNIVPLL3_D2,
+		.name = "univpll3_d2",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = UNIVPLL3_D4,
+		.name = "univpll3_d4",
+		.parent_name = "univpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = MSDCPLL_D2,
+		.name = "msdcpll_d2",
+		.parent_name = "msdcpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = MSDCPLL_D4,
+		.name = "msdcpll_d4",
+		.parent_name = "msdcpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = MSDCPLL_D8,
+		.name = "msdcpll_d8",
+		.parent_name = "msdcpll",
+		.mult = 1,
+		.div = 8
+	},
+	{
+		.id = MSDCPLL_D16,
+		.name = "msdcpll_d16",
+		.parent_name = "msdcpll",
+		.mult = 1,
+		.div = 16
+	},
+	{
+		.id = VENCPLL_D3,
+		.name = "vencpll_d3",
+		.parent_name = "vencpll",
+		.mult = 1,
+		.div = 3
+	},
+	{
+		.id = TVDPLL_D2,
+		.name = "tvdpll_d2",
+		.parent_name = "tvdpll",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = TVDPLL_D4,
+		.name = "tvdpll_d4",
+		.parent_name = "tvdpll",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = DMPLL_D2,
+		.name = "dmpll_d2",
+		.parent_name = "clkph_mck_o",
+		.mult = 1,
+		.div = 2
+	},
+	{
+		.id = DMPLL_D4,
+		.name = "dmpll_d4",
+		.parent_name = "clkph_mck_o",
+		.mult = 1,
+		.div = 4
+	},
+	{
+		.id = DMPLL_D8,
+		.name = "dmpll_d8",
+		.parent_name = "clkph_mck_o",
+		.mult = 1,
+		.div = 8
+	},
+	{
+		.id = AD_SYS_26M_D2,
+		.name = "ad_sys_26m_d2",
+		.parent_name = "clk26m",
+		.mult = 1,
+		.div = 2
+	},
+};
+
+static const char * const axi_sel_parents[] = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll_d5",
+	"syspll1_d4",
+	"univpll_d5",
+	"univpll2_d2",
+	"dmpll",
+	"dmpll_d2"
+};
+
+static const char * const mem_sel_parents[] = {
+	"clk26m",
+	"dmpll"
+};
+
+static const char * const ddrphycfg_parents[] = {
+	"clk26m",
+	"syspll1_d8"
+};
+
+static const char * const mm_sel_parents[] = {
+	"clk26m",
+	"vencpll",
+	"syspll1_d2",
+	"syspll_d5",
+	"syspll1_d4",
+	"univpll_d5",
+	"univpll2_d2",
+	"dmpll"
+};
+
+static const char * const pwm_sel_parents[] = {
+	"clk26m",
+	"univpll2_d4",
+	"univpll3_d2",
+	"univpll1_d4"
+};
+
+static const char * const vdec_sel_parents[] = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll_d5",
+	"syspll1_d4",
+	"univpll_d5",
+	"syspll_d2",
+	"syspll2_d2",
+	"msdcpll_d2"
+};
+
+static const char * const mfg_sel_parents[] = {
+	"clk26m",
+	"mmpll",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"clk26m",
+	"syspll_d3",
+	"syspll1_d2",
+	"syspll_d5",
+	"univpll_d3",
+	"univpll1_d2"
+};
+
+static const char * const camtg_sel_parents[] = {
+	"clk26m",
+	"univpll_d26",
+	"univpll2_d2",
+	"syspll3_d2",
+	"syspll3_d4",
+	"msdcpll_d4"
+};
+
+static const char * const uart_sel_parents[] = {
+	"clk26m",
+	"univpll2_d8"
+};
+
+static const char * const spi_sel_parents[] = {
+	"clk26m",
+	"syspll3_d2",
+	"msdcpll_d8",
+	"syspll2_d4",
+	"syspll4_d2",
+	"univpll2_d4",
+	"univpll1_d8"
+};
+
+static const char * const usb20_sel_parents[] = {
+	"clk26m",
+	"univpll1_d8",
+	"univpll3_d4"
+};
+
+static const char * const msdc50_0_sel_parents[] = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll2_d2",
+	"syspll4_d2",
+	"univpll_d5",
+	"univpll1_d4"
+};
+
+static const char * const msdc30_0_sel_parents[] = {
+	"clk26m",
+	"msdcpll",
+	"msdcpll_d2",
+	"msdcpll_d4",
+	"syspll2_d2",
+	"syspll1_d4",
+	"univpll1_d4",
+	"univpll_d3",
+	"univpll_d26",
+	"syspll2_d4",
+	"univpll_d2"
+};
+
+static const char * const msdc30_1_2_sel_parents[] = {
+	"clk26m",
+	"univpll2_d2",
+	"msdcpll_d4",
+	"syspll2_d2",
+	"syspll1_d4",
+	"univpll1_d4",
+	"univpll_d26",
+	"syspll2_d4"
+};
+
+static const char * const msdc30_3_sel_parents[] = {
+	"clk26m",
+	"univpll2_d2",
+	"msdcpll_d4",
+	"syspll2_d2",
+	"syspll1_d4",
+	"univpll1_d4",
+	"univpll_d26",
+	"msdcpll_d16",
+	"syspll2_d4"
+};
+
+static const char * const audio_sel_parents[] = {
+	"clk26m",
+	"syspll3_d4",
+	"syspll4_d4",
+	"syspll1_d16"
+};
+
+static const char * const aud_intbus_sel_parents[] = {
+	"clk26m",
+	"syspll1_d4",
+	"syspll4_d2",
+	"dmpll_d4"
+};
+
+static const char * const pmicspi_sel_parents[] = {
+	"clk26m",
+	"syspll1_d8",
+	"syspll3_d4",
+	"syspll1_d16",
+	"univpll3_d4",
+	"univpll_d26",
+	"dmpll_d4",
+	"dmpll_d8"
+};
+
+static const char * const scp_sel_parents[] = {
+	"clk26m",
+	"syspll1_d8",
+	"dmpll_d2",
+	"dmpll_d4"
+};
+
+static const char * const atb_sel_parents[] = {
+	"clk26m",
+	"syspll1_d2",
+	"syspll_d5",
+	"dmpll"
+};
+
+static const char * const dpi0_sel_parents[] = {
+	"clk26m",
+	"tvdpll",
+	"tvdpll_d2",
+	"tvdpll_d4",
+	"dpi_ck"
+};
+
+static const char * const scam_sel_parents[] = {
+	"clk26m",
+	"syspll3_d2",
+	"univpll2_d4",
+	"vencpll_d3"
+};
+
+static const char * const mfg13m_sel_parents[] = {
+	"clk26m",
+	"ad_sys_26m_d2"
+};
+
+static const char * const aud_1_2_sel_parents[] = {
+	"clk26m",
+	"apll1"
+};
+
+static const char * const irda_sel_parents[] = {
+	"clk26m",
+	"univpll2_d4"
+};
+
+static const char * const irtx_sel_parents[] = {
+	"clk26m",
+	"ad_sys_26m_ck"
+};
+
+static const char * const disppwm_sel_parents[] = {
+	"clk26m",
+	"univpll2_d4",
+	"syspll4_d2_d8",
+	"ad_sys_26m_ck"
+};
+
+static const struct mtk_mux top_muxes[] = {
+	{
+		.id = AXI_SEL,
+		.name = "axi_sel",
+		.parent_names = axi_sel_parents,
+		.num_parents = ARRAY_SIZE(axi_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_0,
+		.set_ofs = CLK_CFG_0_SET,
+		.clr_ofs = CLK_CFG_0_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 3,
+
+		.ops = &mtk_mux_clr_set_upd_ops,
+	},
+	{
+		.id = MEM_SEL,
+		.name = "mem_sel",
+		.parent_names = mem_sel_parents,
+		.num_parents = ARRAY_SIZE(mem_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_0,
+		.set_ofs = CLK_CFG_0_SET,
+		.clr_ofs = CLK_CFG_0_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 1,
+
+		.ops = &mtk_mux_clr_set_upd_ops,
+	},
+	{
+		.id = DDRPHY_SEL,
+		.name = "ddrphycfg_sel",
+		.parent_names = ddrphycfg_parents,
+		.num_parents = ARRAY_SIZE(ddrphycfg_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_0,
+		.set_ofs = CLK_CFG_0_SET,
+		.clr_ofs = CLK_CFG_0_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 1,
+
+		.ops = &mtk_mux_clr_set_upd_ops,
+	},
+	{
+		.id = MM_SEL,
+		.name = "mm_sel",
+		.parent_names = mm_sel_parents,
+		.num_parents = ARRAY_SIZE(mm_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_0,
+		.set_ofs = CLK_CFG_0_SET,
+		.clr_ofs = CLK_CFG_0_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 3,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = PWM_SEL,
+		.name = "pwm_sel",
+		.parent_names = pwm_sel_parents,
+		.num_parents = ARRAY_SIZE(pwm_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_1,
+		.set_ofs = CLK_CFG_1_SET,
+		.clr_ofs = CLK_CFG_1_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 2,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = VDEC_SEL,
+		.name = "vdec_sel",
+		.parent_names = vdec_sel_parents,
+		.num_parents = ARRAY_SIZE(vdec_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_1,
+		.set_ofs = CLK_CFG_1_SET,
+		.clr_ofs = CLK_CFG_1_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 3,
+		.gate_shift = 15,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MFG_SEL,
+		.name = "mfg_sel",
+		.parent_names = mfg_sel_parents,
+		.num_parents = ARRAY_SIZE(mfg_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_1,
+		.set_ofs = CLK_CFG_1_SET,
+		.clr_ofs = CLK_CFG_1_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 4,
+		.gate_shift = 23,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = CAMTG_SEL,
+		.name = "camtg_sel",
+		.parent_names = camtg_sel_parents,
+		.num_parents = ARRAY_SIZE(camtg_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_1,
+		.set_ofs = CLK_CFG_1_SET,
+		.clr_ofs = CLK_CFG_1_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 3,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = UART_SEL,
+		.name = "uart_sel",
+		.parent_names = uart_sel_parents,
+		.num_parents = ARRAY_SIZE(uart_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_2,
+		.set_ofs = CLK_CFG_2_SET,
+		.clr_ofs = CLK_CFG_2_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 1,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = SPI_SEL,
+		.name = "spi_sel",
+		.parent_names = spi_sel_parents,
+		.num_parents = ARRAY_SIZE(spi_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_2,
+		.set_ofs = CLK_CFG_2_SET,
+		.clr_ofs = CLK_CFG_2_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 3,
+		.gate_shift = 15,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = USB20_SEL,
+		.name = "usb20_sel",
+		.parent_names = usb20_sel_parents,
+		.num_parents = ARRAY_SIZE(usb20_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_2,
+		.set_ofs = CLK_CFG_2_SET,
+		.clr_ofs = CLK_CFG_2_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 2,
+		.gate_shift = 23,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MSDC50_0_SEL,
+		.name = "msdc50_0_sel",
+		.parent_names = msdc50_0_sel_parents,
+		.num_parents = ARRAY_SIZE(msdc50_0_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_2,
+		.set_ofs = CLK_CFG_2_SET,
+		.clr_ofs = CLK_CFG_2_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 3,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MSDC30_0_SEL,
+		.name = "msdc30_0_sel",
+		.parent_names = msdc30_0_sel_parents,
+		.num_parents = ARRAY_SIZE(msdc30_0_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_3,
+		.set_ofs = CLK_CFG_3_SET,
+		.clr_ofs = CLK_CFG_3_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 4,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MSDC30_1_SEL,
+		.name = "msdc30_1_sel",
+		.parent_names = msdc30_1_2_sel_parents,
+		.num_parents = ARRAY_SIZE(msdc30_1_2_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_3,
+		.set_ofs = CLK_CFG_3_SET,
+		.clr_ofs = CLK_CFG_3_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 3,
+		.gate_shift = 15,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MSDC30_2_SEL,
+		.name = "msdc30_2_sel",
+		.parent_names = msdc30_1_2_sel_parents,
+		.num_parents = ARRAY_SIZE(msdc30_1_2_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_3,
+		.set_ofs = CLK_CFG_3_SET,
+		.clr_ofs = CLK_CFG_3_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 3,
+		.gate_shift = 23,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MSDC30_3_SEL,
+		.name = "msdc30_3_sel",
+		.parent_names = msdc30_3_sel_parents,
+		.num_parents = ARRAY_SIZE(msdc30_3_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_3,
+		.set_ofs = CLK_CFG_3_SET,
+		.clr_ofs = CLK_CFG_3_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 4,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = AUDIO_SEL,
+		.name = "audio_sel",
+		.parent_names = audio_sel_parents,
+		.num_parents = ARRAY_SIZE(audio_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_4,
+		.set_ofs = CLK_CFG_4_SET,
+		.clr_ofs = CLK_CFG_4_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 2,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = AUDINTBUS_SEL,
+		.name = "aud_intbus_sel",
+		.parent_names = aud_intbus_sel_parents,
+		.num_parents = ARRAY_SIZE(aud_intbus_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_4,
+		.set_ofs = CLK_CFG_4_SET,
+		.clr_ofs = CLK_CFG_4_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 2,
+		.gate_shift = 15,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = PMICSPI_SEL,
+		.name = "pmicspi_sel",
+		.parent_names = pmicspi_sel_parents,
+		.num_parents = ARRAY_SIZE(pmicspi_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_4,
+		.set_ofs = CLK_CFG_4_SET,
+		.clr_ofs = CLK_CFG_4_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 3,
+
+		.ops = &mtk_mux_clr_set_upd_ops,
+	},
+	{
+		.id = SCP_SEL,
+		.name = "scp_sel",
+		.parent_names = scp_sel_parents,
+		.num_parents = ARRAY_SIZE(scp_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_4,
+		.set_ofs = CLK_CFG_4_SET,
+		.clr_ofs = CLK_CFG_4_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 2,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = ATB_SEL,
+		.name = "atb_sel",
+		.parent_names = atb_sel_parents,
+		.num_parents = ARRAY_SIZE(atb_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_5,
+		.set_ofs = CLK_CFG_5_SET,
+		.clr_ofs = CLK_CFG_5_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 2,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = DPI0_SEL,
+		.name = "dpi0_sel",
+		.parent_names = dpi0_sel_parents,
+		.num_parents = ARRAY_SIZE(dpi0_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_5,
+		.set_ofs = CLK_CFG_5_SET,
+		.clr_ofs = CLK_CFG_5_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 3,
+		.gate_shift = 15,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = SCAM_SEL,
+		.name = "scam_sel",
+		.parent_names = scam_sel_parents,
+		.num_parents = ARRAY_SIZE(scam_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_5,
+		.set_ofs = CLK_CFG_5_SET,
+		.clr_ofs = CLK_CFG_5_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 2,
+		.gate_shift = 23,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = MFG13M_SEL,
+		.name = "mfg13m_sel",
+		.parent_names = mfg13m_sel_parents,
+		.num_parents = ARRAY_SIZE(mfg13m_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_5,
+		.set_ofs = CLK_CFG_5_SET,
+		.clr_ofs = CLK_CFG_5_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 1,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = AUD1_SEL,
+		.name = "aud_1_sel",
+		.parent_names = aud_1_2_sel_parents,
+		.num_parents = ARRAY_SIZE(aud_1_2_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_6,
+		.set_ofs = CLK_CFG_6_SET,
+		.clr_ofs = CLK_CFG_6_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 1,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = AUD2_SEL,
+		.name = "aud_2_sel",
+		.parent_names = aud_1_2_sel_parents,
+		.num_parents = ARRAY_SIZE(aud_1_2_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_6,
+		.set_ofs = CLK_CFG_6_SET,
+		.clr_ofs = CLK_CFG_6_CLR,
+
+		.mux_shift = 8,
+		.mux_width = 1,
+		.gate_shift = 15,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = IRDA_SEL,
+		.name = "irda_sel",
+		.parent_names = irda_sel_parents,
+		.num_parents = ARRAY_SIZE(irda_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_6,
+		.set_ofs = CLK_CFG_6_SET,
+		.clr_ofs = CLK_CFG_6_CLR,
+
+		.mux_shift = 16,
+		.mux_width = 1,
+		.gate_shift = 23,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = IRTX_SEL,
+		.name = "irtx_sel",
+		.parent_names = irtx_sel_parents,
+		.num_parents = ARRAY_SIZE(irtx_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_6,
+		.set_ofs = CLK_CFG_6_SET,
+		.clr_ofs = CLK_CFG_6_CLR,
+
+		.mux_shift = 24,
+		.mux_width = 1,
+		.gate_shift = 31,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+	{
+		.id = DISPPWM_SEL,
+		.name = "disppwm_sel",
+		.parent_names = disppwm_sel_parents,
+		.num_parents = ARRAY_SIZE(disppwm_sel_parents),
+		.flags = CLK_SET_RATE_PARENT,
+
+		.mux_ofs = CLK_CFG_7,
+		.set_ofs = CLK_CFG_7_SET,
+		.clr_ofs = CLK_CFG_7_CLR,
+
+		.mux_shift = 0,
+		.mux_width = 2,
+		.gate_shift = 7,
+
+		.ops = &mtk_mux_gate_clr_set_upd_ops,
+	},
+};
+
+int clk_mt6735_topckgen_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct clk_onecell_data *clk_data;
+	int ret;
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(top_fixed_clks) +
+				      ARRAY_SIZE(top_divs) +
+				      ARRAY_SIZE(top_muxes));
+	if (!clk_data)
+		return -ENOMEM;
+	platform_set_drvdata(pdev, clk_data);
+
+	ret = mtk_clk_register_fixed_clks(top_fixed_clks,
+					  ARRAY_SIZE(top_fixed_clks), clk_data);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register fixed clocks: %pe\n",
+			ERR_PTR(ret));
+		goto free_clk_data;
+	}
+
+	ret = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register dividers: %pe\n",
+			ERR_PTR(ret));
+		goto unregister_fixed_clks;
+	}
+
+	ret = mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes),
+				     pdev->dev.of_node, &mt6735_topckgen_lock,
+				     clk_data);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register muxes: %pe\n",
+			ERR_PTR(ret));
+		goto unregister_factors;
+	}
+
+	ret = of_clk_add_provider(pdev->dev.of_node, of_clk_src_onecell_get,
+					  clk_data);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"Failed to register clock provider: %pe\n",
+			ERR_PTR(ret));
+		goto unregister_muxes;
+	}
+
+	return 0;
+unregister_muxes:
+	mtk_clk_unregister_muxes(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
+unregister_factors:
+	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+unregister_fixed_clks:
+	mtk_clk_unregister_fixed_clks(top_fixed_clks,
+				      ARRAY_SIZE(top_fixed_clks), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+
+	return ret;
+}
+
+int clk_mt6735_topckgen_remove(struct platform_device *pdev)
+{
+	struct clk_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(pdev->dev.of_node);
+	mtk_clk_unregister_muxes(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
+	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+	mtk_clk_unregister_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
+				      clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
+static const struct of_device_id of_match_mt6735_topckgen[] = {
+	{ .compatible = "mediatek,mt6735-topckgen" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt6735_topckgen = {
+	.probe = clk_mt6735_topckgen_probe,
+	.remove = clk_mt6735_topckgen_remove,
+	.driver = {
+		.name = "clk-mt6735-topckgen",
+		.of_match_table = of_match_mt6735_topckgen,
+	},
+};
+module_platform_driver(clk_mt6735_topckgen);
+
+MODULE_AUTHOR("Yassine Oudjana <y.oudjana@protonmail.com>");
+MODULE_DESCRIPTION("Mediatek MT6735 topckgen clock driver");
+MODULE_LICENSE("GPL");
-- 
2.36.0

