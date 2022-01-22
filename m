Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7ED496B37
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbiAVJSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbiAVJR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:17:56 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3600EC06173D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:17:56 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id s61-20020a17090a69c300b001b4d0427ea2so15446290pjj.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kbKt7ttJEIbn2PG8GXADqtWmeHu+9XOdvvWCDvq3ah8=;
        b=HNsD0ReKRNDG4ZtQO0GD+qXHMUslr6wilW+RBb24z8L0AosEtrU+AKZV6wZk1k2g5d
         UDAFJ5iY2XaAbthYJ2P8V+dhnsYtH7/gnu5QJ65OVnxpI1rg7GoU2RG4CPdtmgyNecYK
         NgI9nutHRuVY/OYbPkUE6pQDesSxO+GaEEcRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kbKt7ttJEIbn2PG8GXADqtWmeHu+9XOdvvWCDvq3ah8=;
        b=UCJ04wkoCw5/hmBpoka5du2fcGhogEmkHPLlWutYMzq5/ioLc01nySf0De59jbTUD4
         fJ2aHk1NBdQIaq4UBdpLo5SSeN1sB/6WOLHi1LhoRb+taCH3jhtmOHrx+p9tKrClCAT5
         88Qv66MnsrmvozPsp6lmcCx0kckSpr364tDv7WgWI6wHQJp52O+syK5Bt6KAvFfmQbUv
         U+fw4kyTvVJpoz1hJHsiqeE35V8SgkAe8WguybZMp1SylW0RWSRnIqOJPk4bvi0M+3Uj
         6F3ViYx+3eDqoEMuQaGcCkcCszCHIAx9Tw0xziFa7SFCl3dyJffN3JsoRI36E07BY1Wf
         Oxcw==
X-Gm-Message-State: AOAM531lYCdJa4wAtnr8FI7xrfBLJ1wTO5X/jdhys6aVmiudju217kLa
        1dfLXz4+SQZXd5OpjfsD/QXY5uLN2EKQgA==
X-Google-Smtp-Source: ABdhPJz1mN6Vyg0MLeNqvqpKaPRCRA2I5Ia0lsjKPddm7l0OSH/TgsnehVCnbgfVwGDtbynaaYk9iQ==
X-Received: by 2002:a17:903:110c:b0:149:9004:4e7c with SMTP id n12-20020a170903110c00b0014990044e7cmr6902111plh.167.1642843075780;
        Sat, 22 Jan 2022 01:17:55 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:17:55 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/31] clk: mediatek: gate: Clean up included headers
Date:   Sat, 22 Jan 2022 17:17:05 +0800
Message-Id: <20220122091731.283592-6-wenst@chromium.org>
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
2.35.0.rc0.227.g00780c9af4-goog

