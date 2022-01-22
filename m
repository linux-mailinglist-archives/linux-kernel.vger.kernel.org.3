Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68432496B56
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiAVJTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbiAVJSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:18:41 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C774C061763
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:29 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id x37so7096055pfh.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y7ikYR2DO0KTQJWDZKewH0oM7Rmj3LYjnAGwR2+oJK8=;
        b=MK5yUJ0QuCGEKf3Fc/Pxxv6kVp2sCxxGWLo2+2smGGBR2K/o7OHOjjJgu2n+G57HdW
         eAjYKu6r69okMTLnUNRSORWTYe+o4pIcmJH6zpYeOFj361NZkjOI+OknPUS5cKY/PrsO
         D/j75AnvdU5gV234xvjW9KODPrnuFljn+y8n8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y7ikYR2DO0KTQJWDZKewH0oM7Rmj3LYjnAGwR2+oJK8=;
        b=JhVK8pP9Vuu/PPmKIkdXZUz6iueQJ5eNZVSR+TjHGAiNOjPYkedQSnUm2D0Ju7KuTU
         k2VhqW+eWscdCXEfmk8zdb7MQotT7pM6lb2KzTuoo8dWo1cB+NaIYEcoa6IOnkHIXLHp
         j5sUvxHh4bZBtQolOc1Q8iARk+nygboTySxc4iof7XMwqzFvjt1E21cY31daawSp11mW
         eXtC15NsUdrOLBbq8j8Vzm/scQXz5pdZHRI/LV9xkClh/r78NL5OQIlArCrVMczpByFC
         mDWouyp+bNs73d225b2SC+L5B2E7WxPJm3ose4TXfxalfqnPUjG3xf48IsmQbvZD7mQ+
         pO+w==
X-Gm-Message-State: AOAM532rVKXDbtg7TqegNVXCeMMgQ2Vp0lHrD0dBjGrUxxO879RJlLZY
        G3aQBmja+2v4TMFJyGne8T8K+A==
X-Google-Smtp-Source: ABdhPJzqwpvGnrOLvq1Wc8tRhNv6bldrv9fnylHIYcV+GIPyjQgEr0P19blEPg/NwRaCCyKvYFaDxw==
X-Received: by 2002:a63:b204:: with SMTP id x4mr5614276pge.224.1642843109114;
        Sat, 22 Jan 2022 01:18:29 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:28 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/31] clk: mediatek: mtk: Clean up included headers
Date:   Sat, 22 Jan 2022 17:17:20 +0800
Message-Id: <20220122091731.283592-21-wenst@chromium.org>
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

On the header side, replace headers that are included purely for data
structure definitions with forward declarations. This decreases the
amount of preprocessing and compilation effort required for each
inclusion.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mtk.c | 13 ++++++-------
 drivers/clk/mediatek/clk-mtk.h | 12 ++++++------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index cd76e1d80242..d2c50186cceb 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -4,17 +4,16 @@
  * Author: James Liao <jamesjj.liao@mediatek.com>
  */
 
-#include <linux/of.h>
-#include <linux/of_address.h>
+#include <linux/bitops.h>
+#include <linux/clk-provider.h>
 #include <linux/err.h>
 #include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/clkdev.h>
-#include <linux/module.h>
 #include <linux/mfd/syscon.h>
-#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
 
 #include "clk-mtk.h"
 #include "clk-gate.h"
diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 4fa658f5d934..7f902581a115 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -7,19 +7,19 @@
 #ifndef __DRV_CLK_MTK_H
 #define __DRV_CLK_MTK_H
 
-#include <linux/regmap.h>
-#include <linux/bitops.h>
 #include <linux/clk-provider.h>
-#include <linux/platform_device.h>
-
-struct clk;
-struct clk_onecell_data;
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
 
 #define MAX_MUX_GATE_BIT	31
 #define INVALID_MUX_GATE_BIT	(MAX_MUX_GATE_BIT + 1)
 
 #define MHZ (1000 * 1000)
 
+struct platform_device;
+
 struct mtk_fixed_clk {
 	int id;
 	const char *name;
-- 
2.35.0.rc0.227.g00780c9af4-goog

