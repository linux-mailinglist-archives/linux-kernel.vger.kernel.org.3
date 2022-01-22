Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F38496B4B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbiAVJSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:18:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiAVJSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:18:16 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254C1C06173D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:16 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id p125so10272225pga.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Kc6foonKZ2qx7qyPXvjxQG3lzal7VzJVK7KIYAvJnU=;
        b=RHT7W3/ZsxsUmr+8O1nsTAlt6tlW1+Dhp4h5kBzotqI3R6YbBJVuKnijdIFU9OMx6M
         UX3bVws4jV0tIF5PgNS580YUHpdXwlzudiOHTYlMouBxtGezlIsxaT7N1ttLXEh3UOsw
         Y9XYHMLApFpuxg98NlVVPZjBGx8Db/2LkavQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Kc6foonKZ2qx7qyPXvjxQG3lzal7VzJVK7KIYAvJnU=;
        b=i4SI9jQn+9RTvBxsivS+D9z6sFS7Csnhi00tNLFMOVVuj7NPHxjSYYTvuh11bY4Fwa
         WiF1rY0HxlfSp+rRDKGCBxcUj1Ps+TtRulMFskPWgwnL0/HUSzxY9NJAduQA1STagxK0
         3w/8xgAt7BahlaBLVkFmAenlrjhacDsm6jCYpbjeq4xqgzfg87UbwAN6BkKVjhuNkPl2
         7h8TxV/0VSh1+aY7MGAICbFlKLkfPSNdkj9YzN/jzo/ON6RXcCqCXON7oqxtSfjgXOEY
         WpLSp4h/A3oxOngaCn/4C1raB+xXxQl9i240ZPjopP0PEQgF+FGzrPwNWgBO4xirLtQr
         fpBg==
X-Gm-Message-State: AOAM533XRFLS3T6SUTAOYrgb90qIsFpU72MujBGbUY99XgFSGEgZqDo3
        p87//0ytAZaqy/QVAQGxKkEhQQ==
X-Google-Smtp-Source: ABdhPJy8nbK4n66ql++9II+COsZy//czwDilD2Qwh2Dtb/rurvA7kS9mqeUDD4jcA4hNweQ1+uLf7Q==
X-Received: by 2002:a63:6b42:: with SMTP id g63mr5394978pgc.345.1642843095714;
        Sat, 22 Jan 2022 01:18:15 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:15 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 14/31] clk: mediatek: pll: Clean up included headers
Date:   Sat, 22 Jan 2022 17:17:14 +0800
Message-Id: <20220122091731.283592-15-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220122091731.283592-1-wenst@chromium.org>
References: <20220122091731.283592-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some included headers aren't actually used anywhere, while other headers
with the declaration of functions and structures aren't directly
included.

Get rid of the unused ones, and add the ones that should be included
directly.

Also, expand the MHZ macro with spelled-out "1000 * 1000" to be able
to not include clk-mtk.h. The existing ternary operator is rewritten
in a shortened form to accommodate the expanded macro.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-pll.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 081e0df8203e..9698d1c97cd6 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -4,15 +4,15 @@
  * Author: James Liao <jamesjj.liao@mediatek.com>
  */
 
-#include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/clk-provider.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
+#include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/of_address.h>
 #include <linux/slab.h>
-#include <linux/clkdev.h>
-#include <linux/delay.h>
 
-#include "clk-mtk.h"
 #include "clk-pll.h"
 
 #define REG_CON0		0
@@ -162,7 +162,7 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
 static void mtk_pll_calc_values(struct mtk_clk_pll *pll, u32 *pcw, u32 *postdiv,
 		u32 freq, u32 fin)
 {
-	unsigned long fmin = pll->data->fmin ? pll->data->fmin : (1000 * MHZ);
+	unsigned long fmin = pll->data->fmin ?: (1000 * 1000 * 1000);
 	const struct mtk_pll_div_table *div_table = pll->data->div_table;
 	u64 _pcw;
 	int ibits;
-- 
2.35.0.rc0.227.g00780c9af4-goog

