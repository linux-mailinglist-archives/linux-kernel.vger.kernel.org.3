Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49804A7200
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344511AbiBBNtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344480AbiBBNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:49:49 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D852DC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:49:48 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id i186so16367144pfe.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MnC5wd+W1Uub0jyBTii0bw1jKUM0SD+MmltxaETPxmI=;
        b=ifkWBdljLlCdQrsnHb2AaA0xiVXH5i/9qcSv1GL6LW/PoUV26HY1RZyR5xcnjsOr+z
         uhIw6zBd7oLaRiZv9+E5Nf7YQ9SgfnPGAFRR4NBLw3veNFLU0UCkMO55TcQkWkEoldYV
         0nhn7rMWunukBQmGpuPAbvZXiLDhoeuy/Ko8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MnC5wd+W1Uub0jyBTii0bw1jKUM0SD+MmltxaETPxmI=;
        b=FoYuPUShf2sR/QU6gSC92eB5I8nIOHGBmghCzUnq0eVRPNfH7yUJy6o1OtBNrc5MCt
         bUqgtpGrMwqGMpTW+e7uqkM3wnyaMIQ3VSYj9nVGjCSqDZgTqw8m+xfZNzCnE7jVmuCh
         4fwMVemKH1LHbagHjLiXpIHmalZ2QC7DN4EeY6i+tAG0dNjRtPD3pgYHajrNrOWtYK+m
         hK8pgA6P99MrEzH3S7mgUEr5MevL0bUmxYTUyCHK/ubvgGfgPQIbxmjtk8zdY3T3I3SG
         rDovksK0be7OwzPLBTuG25ozxiFKOOlLU8WSe0i8rHuMSKUKua+79rAjDhad8JD8HBL3
         0MRQ==
X-Gm-Message-State: AOAM531jR5oHBh6OWK1lCZs+IEA14Od0VrnYB0xRkHoPuEAIU6L0nqrG
        diMr9CSVV2Kge/80TylqybQZBzbgrr6SYw==
X-Google-Smtp-Source: ABdhPJyE1fU1DE0Y18OMUQ3BYgMoazVLDzDLvc5zUeGVpD74dfmN2S3rdVUMXCpYNy7oMRTOlZT5Ow==
X-Received: by 2002:a65:400a:: with SMTP id f10mr24302297pgp.161.1643809788467;
        Wed, 02 Feb 2022 05:49:48 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:49:48 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/31] clk: mediatek: gate: Clean up included headers
Date:   Wed,  2 Feb 2022 21:48:08 +0800
Message-Id: <20220202134834.690675-6-wenst@chromium.org>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
In-Reply-To: <20220202134834.690675-1-wenst@chromium.org>
References: <20220202134834.690675-1-wenst@chromium.org>
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
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-gate.c | 11 +++--------
 drivers/clk/mediatek/clk-gate.h | 10 +++++++---
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/mediatek/clk-gate.c b/drivers/clk/mediatek/clk-gate.c
index ed1ad5535d41..e8881ae1489a 100644
--- a/drivers/clk/mediatek/clk-gate.c
+++ b/drivers/clk/mediatek/clk-gate.c
@@ -4,18 +4,13 @@
  * Author: James Liao <jamesjj.liao@mediatek.com>
  */
 
-#include <linux/of.h>
-#include <linux/of_address.h>
-
-#include <linux/io.h>
-#include <linux/slab.h>
-#include <linux/delay.h>
-#include <linux/clkdev.h>
 #include <linux/clk-provider.h>
-#include <linux/container_of.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
+#include <linux/printk.h>
 #include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/types.h>
 
 #include "clk-gate.h"
 
diff --git a/drivers/clk/mediatek/clk-gate.h b/drivers/clk/mediatek/clk-gate.h
index 344adffb6578..6b5738826a22 100644
--- a/drivers/clk/mediatek/clk-gate.h
+++ b/drivers/clk/mediatek/clk-gate.h
@@ -7,9 +7,13 @@
 #ifndef __DRV_CLK_GATE_H
 #define __DRV_CLK_GATE_H
 
-#include <linux/clk-provider.h>
-#include <linux/device.h>
-#include <linux/of.h>
+#include <linux/types.h>
+
+struct clk;
+struct clk_onecell_data;
+struct clk_ops;
+struct device;
+struct device_node;
 
 extern const struct clk_ops mtk_clk_gate_ops_setclr;
 extern const struct clk_ops mtk_clk_gate_ops_setclr_inv;
-- 
2.35.0.rc2.247.g8bbb082509-goog

