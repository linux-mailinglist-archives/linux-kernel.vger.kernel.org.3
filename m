Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D49496B44
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 10:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbiAVJS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 04:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbiAVJSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 04:18:10 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EE0C061751
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:09 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id my12-20020a17090b4c8c00b001b528ba1cd7so6262726pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jan 2022 01:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vNUxjw49tFByvcP8t/7//e7iEPYHFps9QVk8zZRKtaU=;
        b=FphTI/EUT+pYQ6+s8N+x8etvO1gp8ydoS32Ye8uTFtcA0dTunlpW4uIwQ8xsAMAxcJ
         59qGp9DBrlbRSSwNDb82LSehk5xTkcD/mHbvAFeT676O/lkQPLP6mUPFmHnuvbvCzsH0
         CmhrQYDiTI3PF6wwTPqVw2KJy6h1l7YA5ZCvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNUxjw49tFByvcP8t/7//e7iEPYHFps9QVk8zZRKtaU=;
        b=le4TDv1n+VLNQSYidb9jexrc93AM8WUJgcAjr83zBXZacS6UowHx/JArAs+P4Z2Itp
         cS9Bxk+ix0fdKi2uDrSeZ06cH60QEgDFjq0wMekuUDb0gQscFreQy1tAT4HFEpMLmKsS
         T4fkY0RA1H8t6LPYQ7xTN6+p14Gn/EYsLbtBU2qOKbgGBNuVsZBYosf8gyxnkHv0L2r7
         CmPAFZ0lVZfu0PYFPY6erLtDtDSPUIHiydENHFMt6PRn1/SAY1hG916arPoijJ+Dzokg
         HidkRjzSKhq75XCMsQ40i52bb6IhcSjcyp6CDdwZ7iazFWSLvZqklzZ1U74hTYTiGkJP
         Beqw==
X-Gm-Message-State: AOAM530KfdkXPZ+7Z4vQetRm3pn1up4JU0MtrXb3ekvx0agluKTpCn6g
        8gTGQ4CDkJGQ5XBzd1WVKlkvvw==
X-Google-Smtp-Source: ABdhPJzt50XykWx+0tWjlGukGzZMOR/XsM+FWIFaNqeZRK3fs6wk/ktZqv15RMlzys50RaboRzuhyQ==
X-Received: by 2002:a17:90a:5e05:: with SMTP id w5mr4443843pjf.57.1642843089091;
        Sat, 22 Jan 2022 01:18:09 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:349f:9373:45d9:eb26])
        by smtp.gmail.com with ESMTPSA id s1sm1608100pjn.42.2022.01.22.01.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jan 2022 01:18:08 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/31] clk: mediatek: mux: Clean up included headers
Date:   Sat, 22 Jan 2022 17:17:11 +0800
Message-Id: <20220122091731.283592-12-wenst@chromium.org>
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
2.35.0.rc0.227.g00780c9af4-goog

