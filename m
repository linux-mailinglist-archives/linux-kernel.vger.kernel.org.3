Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6EF4A723C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiBBNwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344632AbiBBNuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:50:24 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20504C061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:50:19 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id v3so18378453pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 05:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r6U16I5h4NQIjHAoaMFFGHeoaBszozzi/qTuoY6Zxwc=;
        b=mW+92Gk+2VySYb/AfQ9MCdHff8aHAQmOwUwW4znhKb8lsVxKFTjYUvLHGRGAeAoufe
         ClXBe4+x/DLP2gWSqwN5azWWea5MVH52cj+FPbJB4BU6Wm9i2loDIkA2YT/eNy9PQi8L
         pFXuGZf780EuBWYfwCRlCbCHOJpKEtlPfVy+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r6U16I5h4NQIjHAoaMFFGHeoaBszozzi/qTuoY6Zxwc=;
        b=Y7+sD9NsfwG5g22Kc56Br7Uq3yP1QpxloDscKiLMeSLXjsEOcsMZfhipmMldtLb47i
         VACPkeM3fc0SmwLaiNFZzWyzRqQhp+WHsNpj2lW53lWyO7ID3UW2o/A2Hy+8T+ROhjrq
         eDFdeVUsLgVxDUxDH5wmuwqJ9NVC7KcAX+S1H5ct569troJFnCrrG78oLsR+pMi0fH2h
         WP05nlZl3Zahlqt4pKg7/aCB1XnDCJlE4ij8koTJ+uuZKQt247ib62oDm5Z8y+JlZmsO
         Avy1D+LR4JACTHL0Aikz7IpG9zY6Ij5+QwycEIVuW6IyfIUQAIltDQISYfyYGF/90Soe
         MTMA==
X-Gm-Message-State: AOAM532U55rn13ReTVuBP07qVnz4xaxvZutpN7NOvltcIuYPglva2bj0
        8koGuT8+y3LLsA5JA0A2cS0B4Q==
X-Google-Smtp-Source: ABdhPJxpwUACsdmtBArNe8Uc2yPifRus+Qkti7/z+fL5OuoV24IhqhLUkZIBSHII1LdUHWVjcaw8Qw==
X-Received: by 2002:aa7:9f1b:: with SMTP id g27mr30524486pfr.30.1643809818708;
        Wed, 02 Feb 2022 05:50:18 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:78b5:214c:c81:b9aa])
        by smtp.gmail.com with ESMTPSA id w19sm27335684pfu.47.2022.02.02.05.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 05:50:18 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/31] clk: mediatek: mtk: Clean up included headers
Date:   Wed,  2 Feb 2022 21:48:23 +0800
Message-Id: <20220202134834.690675-21-wenst@chromium.org>
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
 drivers/clk/mediatek/clk-mtk.c | 13 ++++++-------
 drivers/clk/mediatek/clk-mtk.h | 12 ++++++------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index f108786caeda..5618c84e4e08 100644
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
2.35.0.rc2.247.g8bbb082509-goog

