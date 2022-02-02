Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0961E4A7204
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344490AbiBBNuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344509AbiBBNtz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:49:55 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED579C06173D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:49:54 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id z131so18323818pgz.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FrZ/0MdvYKx4iaQqido6RE0SQZOpyPkZyyEsJWJ6uvQ=;
        b=kr16j1M0ul8lOBTGXLrQNyQAn0031+sSYig0cCR7kjq/VDai6jwZxUPCannWakW7ov
         t6eL4uUJmLgO2yfgvEwb8IVL01LHyy6huvnflt/lirwoirOJb6TT6YYCKkTo8SDSFA3G
         B8xh+k350+mauwcTQQcRRUHrq0wnUKHmsd0Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FrZ/0MdvYKx4iaQqido6RE0SQZOpyPkZyyEsJWJ6uvQ=;
        b=0WMRxBYEmSXU0jsq6V4MqwQNF9JCO1UnPEobhhDurasL8G21BvfKLFf6BIF7F0tkwm
         2C53bzpc7mwmQpYyDkhuOS8OhLvaCvtuKqOLm+B54U6osVOCqvh1zyDFE/bAlazW/BIO
         5XctkX+4rBwWKMeAi7kSrBspTEjEMkYvWd6BSgLk5/t2l1O9WMSwM0Kw0zOSDtmLpfjG
         +mHx2gtx+ngbhBIacnhmumOHgMxXkaQB1m5W3HNUlKpOjZ9MztZQbfinbKjTZjIXwbae
         wClu1lKNR/wcJRJnWYLq82wTSYp/RlYsqK0DUQ2lx9EmxlUgial2tmCITKsEoA9OCP1z
         /H2g==
X-Gm-Message-State: AOAM532TNPv56AUDdbTTIbDn9OCOceDgBq/4S6qxjAKyU+yo8+GkJJIS
        xn2TMJ/BtnDGG9ppofqHnjizOQ==
X-Google-Smtp-Source: ABdhPJz6RliNQTrYa3nwSg3QqKgNI7uqG/4+XpmghPiK9Jj3ex4tFYMUF5mHVSMN/zT1r/+Ay6SMtg==
X-Received: by 2002:a05:6a00:238b:: with SMTP id f11mr1606430pfc.73.1643809794541;
        Wed, 02 Feb 2022 05:49:54 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:49:54 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/31] clk: mediatek: cpumux: Clean up included headers
Date:   Wed,  2 Feb 2022 21:48:11 +0800
Message-Id: <20220202134834.690675-9-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202134834.690675-1-wenst@chromium.org>
References: <20220202134834.690675-1-wenst@chromium.org>
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
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
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
2.35.0.rc2.247.g8bbb082509-goog

