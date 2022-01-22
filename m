Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90770496B4E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbiAVJSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiAVJSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:18:04 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5692C06174E
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:02 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so15446440pjj.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CMFXap+xL0bvLvySfgNMrXOP9tSLXVuWtG0WsgxxBN8=;
        b=no9YI2kI8gyzTudRYKHgPiFbPAcXOXr00kj1lm3Q/qLeY4IIWESiil9gsKxq18DvLG
         mGuKrkF7ZZyQQOddq9+HibOon3iYZ7aJFs12iYxPjSIDscNDS/Kt1h0okxcmKDQO8nuU
         e4W6Hh7ISgKoKsXRsZBXhN2rOJofin6Xvf5pU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CMFXap+xL0bvLvySfgNMrXOP9tSLXVuWtG0WsgxxBN8=;
        b=4GIGUtAAhw2yljmb+RU0OWak70XGeRtSahFq87p1tFlK1HlNK9N2oyXSv75CY1Siam
         +q3WUeyLe1s1FeBgfSkIihuI8n4tuPggp91z/o+rFUbyzz+D+CYmbpxjevsIBGic0yXV
         gmf0mERsMLqMYWZnm9zmyjrYB5AwgKGLbRge3Hut33tKcyCSTLXh8PgM8Y+GRgHuknSQ
         jkpjSEYmv3Psw26g+kwLAJ0oO0zngQUvNKRX+fu6hyGx9vtLdBzbQF6dAgFB3E0ovsP9
         Y3RrzWX83W5G5Fu7UUa547+NsYxT/ztPorvuyFyLtbpT3EpIQrbEo73VJn9b8KxcqplR
         2AVA==
X-Gm-Message-State: AOAM530U/jl7uA6EkUV4ZKXo6A8yNyGNCIQBqRDtUU0UiEDfFSuRt9Z3
        MfSyRYak89iTmXYMoYFzPHtomg==
X-Google-Smtp-Source: ABdhPJxN30OUYMrT52RzBfbw6qmJzTZhPQfO212jPVtLlFlXIYBizp9DWGFMnLERH3nnKeEUo3eQbw==
X-Received: by 2002:a17:902:dacf:b0:14b:2225:2f06 with SMTP id q15-20020a170902dacf00b0014b22252f06mr4851994plx.123.1642843082396;
        Sat, 22 Jan 2022 01:18:02 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:01 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/31] clk: mediatek: cpumux: Clean up included headers
Date:   Sat, 22 Jan 2022 17:17:08 +0800
Message-Id: <20220122091731.283592-9-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some headers with the declaration of functions and structures aren't
directly included. Explicitly include them so that future changes to
other headers would not result in an unexpected build break.

On the header side, add forward declarations for any data structures
whose pointers are used in function signatures. No headers are
required.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-cpumux.c | 3 +++
 drivers/clk/mediatek/clk-cpumux.h | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/clk/mediatek/clk-cpumux.c b/drivers/clk/mediatek/clk-cpumux.c
index 344c6399b22f..658aee789f44 100644
--- a/drivers/clk/mediatek/clk-cpumux.c
+++ b/drivers/clk/mediatek/clk-cpumux.c
@@ -5,8 +5,11 @@
  */
 
 #include <linux/clk-provider.h>
+#include <linux/container_of.h>
+#include <linux/err.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
 #include <linux/slab.h>
 
 #include "clk-mtk.h"
diff --git a/drivers/clk/mediatek/clk-cpumux.h b/drivers/clk/mediatek/clk-cpumux.h
index a538f2bbef0d..b07e89f7c283 100644
--- a/drivers/clk/mediatek/clk-cpumux.h
+++ b/drivers/clk/mediatek/clk-cpumux.h
@@ -7,6 +7,10 @@
 #ifndef __DRV_CLK_CPUMUX_H
 #define __DRV_CLK_CPUMUX_H
 
+struct clk_onecell_data;
+struct device_node;
+struct mtk_composite;
+
 int mtk_clk_register_cpumuxes(struct device_node *node,
 			      const struct mtk_composite *clks, int num,
 			      struct clk_onecell_data *clk_data);
-- 
2.35.0.rc0.227.g00780c9af4-goog

