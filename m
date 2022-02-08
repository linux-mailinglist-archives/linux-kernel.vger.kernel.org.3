Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4D94AD988
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348931AbiBHNU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358359AbiBHMlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 07:41:20 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F65C03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 04:41:19 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i30so18631883pfk.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 04:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VHqh/ijWzTkcfpqZcH5Nz4N1ISUlPyaJ60Q4OawbBT8=;
        b=VnE41xebylDSIYGhpkKNh6ZSVZj7DTmMZVRnyN0MXW4J5q0SI5huCttg3YkTT/ADYt
         3DheENGasIAUHE7ketk881llrCYZtC31y558+C3G/eh93+rEmIPR374s5tVphnYIuS50
         EcGL+mY2csHY5WHy0gsEFrhBXtCv3+HUfvyEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VHqh/ijWzTkcfpqZcH5Nz4N1ISUlPyaJ60Q4OawbBT8=;
        b=2ldXuYTg2wYxcLTywfZslyQ6/gTsgg23wAv+rM7vfcyS+QAbElKcsMI3ffXcgTxUFg
         eJgpfYiZNKWjXKLH1vezuAa7YAe+V3dcslrDlKGnfa2SpUhrkuhZvpVgWogRJGSwVIEW
         T5228Vgj6JPHG52/dIygcO+ZNx+M6EpVhriSkZqwoAhHkOo7o+ovex1+BJAY4H0ibEbP
         n7dvdRjjrZNilGck/f/vd7ioUkqZzxRHF8dT2mPchdj6boh8RQXINIpKSU+2v/shlhHM
         08N+0X/GOcKQMgXPD3qmPoeowisxIpbEmQRUqAzlrtOdbeWgSwTvqP6dIoieby3OO3ig
         PByA==
X-Gm-Message-State: AOAM532wt8hoAymxHF9kl36kIOlHcbCdLtoVzDSBSZnPxXW1QXVO6Xek
        94e8XQCYnLzpujJy0x/sNt4t9A==
X-Google-Smtp-Source: ABdhPJzo0Dp/SCBcUkYHyRIcTeVZXRqv8ziFNxicZ9SLxGT7dPNBKPsfl76t0sK8wZgzQsmDxW8paw==
X-Received: by 2002:a65:4b82:: with SMTP id t2mr3342176pgq.607.1644324079445;
        Tue, 08 Feb 2022 04:41:19 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:41b6:813e:c823:609c])
        by smtp.gmail.com with ESMTPSA id h11sm15056939pfe.214.2022.02.08.04.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:41:19 -0800 (PST)
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
Subject: [PATCH v3 14/31] clk: mediatek: pll: Clean up included headers
Date:   Tue,  8 Feb 2022 20:40:17 +0800
Message-Id: <20220208124034.414635-15-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
In-Reply-To: <20220208124034.414635-1-wenst@chromium.org>
References: <20220208124034.414635-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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

Also, copy the MHZ macro from clk-mtk.h, and drop clk-mtk.h from the
included headers.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-pll.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index b54e33b75d4e..8439d37e354d 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -4,17 +4,19 @@
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
 
+#define MHZ			(1000 * 1000)
+
 #define REG_CON0		0
 #define REG_CON1		4
 
-- 
2.35.0.263.gb82422642f-goog

