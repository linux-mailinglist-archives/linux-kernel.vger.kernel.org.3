Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8D84AD914
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350456AbiBHNQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:16:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358234AbiBHMlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:41:13 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2780CC03FECA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:41:13 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i17so18616518pfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1TZM8PREBca7FhBIqkK5TTjacax9psRQ+lcxgoGzOac=;
        b=IZq5kTRtSIhS2WplXP6OWmMM9gugZL0etNS2hOiiAKeUTokmQNLVM3QCZUd+xo6w1b
         vRhhg+kgnMMqqvJQ3MJg3SeG7GhOho2JnIxPw15s1+uVDvVltw9+xVruBsV1ATn3GY8M
         8TFoRv3HgNjLs4CFru8cGPXiRQzotHrFeftDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1TZM8PREBca7FhBIqkK5TTjacax9psRQ+lcxgoGzOac=;
        b=SnSBsV+dqZoyZ0raXeVOqjR+sNSLwa28RdFos4RiD//G3FfyfEHOUGohNXVecIwdtn
         MY9LMPmXRwftkfPT67TsJ7FlYuDxk5W07oZ/Ywk6Nf7gmZ5h2ibSGlxQu4hQl9HCOIqm
         nqxLI+L1DUr5HXFxNZ7+CCaTFGtNL4Od0i/EdTOygtwnh9y3x1PCzFrg9vJeTyeDweRf
         eDg7coS5LK3K7iKh2uSKxs69PQE8IuBAaoc3RNN4kEokJnxfLWrJRFdJ0v/jVRN03nyc
         7I29Soxp5Z0bB3e3Gv5H1jUvqXUPc+XspZgAnH+c/b/vr2pUxRkAUArUS47+JZph+151
         PmXg==
X-Gm-Message-State: AOAM530/5eWfmRDMrQlE/+QaRU+dvwv5+hDDG/tyVF6xCQJC9P5gyVSN
        1Q9Njc8RhNW3eMAdpR+9Zp7DjQ==
X-Google-Smtp-Source: ABdhPJzGbRmwB7Ijypv5ad/Be1a0AHal20/jqqhu5PrT8YWb6VHkulJZxUxHpXwmHTgsZ58Jrbt7Ow==
X-Received: by 2002:aa7:94a9:: with SMTP id a9mr4258241pfl.78.1644324072723;
        Tue, 08 Feb 2022 04:41:12 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:41:12 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/31] clk: mediatek: mux: Clean up included headers
Date:   Tue,  8 Feb 2022 20:40:14 +0800
Message-Id: <20220208124034.414635-12-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208124034.414635-1-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mux.c | 11 +++++++----
 drivers/clk/mediatek/clk-mux.h |  8 +++++++-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 2d4d8dc0120a..01af6a52711a 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -4,13 +4,16 @@
  * Author: Owen Chen <owen.chen@mediatek.com>
  */
 
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/slab.h>
+#include <linux/clk-provider.h>
+#include <linux/compiler_types.h>
+#include <linux/container_of.h>
+#include <linux/err.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
 
-#include "clk-mtk.h"
 #include "clk-mux.h"
 
 struct mtk_clk_mux {
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index 38a2b6014b08..903a3c937959 100644
--- a/drivers/clk/mediatek/clk-mux.h
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -7,7 +7,13 @@
 #ifndef __DRV_CLK_MTK_MUX_H
 #define __DRV_CLK_MTK_MUX_H
 
-#include <linux/clk-provider.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+struct clk;
+struct clk_onecell_data;
+struct clk_ops;
+struct device_node;
 
 struct mtk_mux {
 	int id;
-- 
2.35.0.263.gb82422642f-goog

