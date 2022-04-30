Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB54515D14
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241952AbiD3M4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiD3M4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:56:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB1A60AAA;
        Sat, 30 Apr 2022 05:53:18 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i19so20009394eja.11;
        Sat, 30 Apr 2022 05:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qDkW5nE/uuJ/Z7IiY96dISQWO6W0w+uLl2SRDnr1tyo=;
        b=TF3OH95Mk6sx/ukpPzDLZAWThjxkqbSUjSzy8qdnWy0RWIAb7dhgSYWJo9BMLUnbwe
         tUlgRUPN9JJgSNQqFtttfN0EyGR04Fl/3dZO+ZtLUsUp2tM/hczGD8LxdiH7LxrUeb3h
         OXyiLt7q6fhu2vsOV5ya+jk5PgnMOW+59NPAnLA/a9Ttc50ZqElIg2Y/DBTCxpjzeKaA
         pGEvJQp11Pbin260SmwnXH21IikFwU03ME/OKLHMnyYfHiinrU+Vg8K/b5QYBHp6k55/
         Lk3AVOEyJ6XPBwY106JaDdBqw5iG8xGfcbaO3gAuiB10R4hT1FVBkTcV5rlJ+YpOQib/
         PkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qDkW5nE/uuJ/Z7IiY96dISQWO6W0w+uLl2SRDnr1tyo=;
        b=ionjc4ZHkkX7RgSJD2KTjkFpTpEvC3tG+qe5RrWGNVHl8RrDUO0rDW3AOx/wJoNcSl
         FZToivbFUHWWuM6+gmd08XhocqzgZ89FzM+2/CXSgqePXEvYEdqS99lPpVgkhkmZKe+W
         JB9q+Si/z6J7QnKCgzi7RbRK7f04UX9sGE4XLJ8ttGWvpwzZ67YzNVLnCfhzMYrHCPha
         lUSsqgQr1G76J4CAwYYknYEXsSl5PKsZ7C9uKQkkCjMIvvc7oAEzK6/sF2MT486awZgz
         IUxtIoWyOSKnA0ExPuUPQFCgnKuE9FQYJmuNeVNwrrUNfCOi12V1K53Fl1kp+mlYu8A5
         /qgQ==
X-Gm-Message-State: AOAM5330v+JjzqeqEF4mqozqy8AYJCmF0Wr2Q3V80obGUdUx74z3bn3K
        0caRvAI9KUDuMf9utJpT9dj3GZ1VgyE=
X-Google-Smtp-Source: ABdhPJzOCXeYnaTR2xDY+g0h7VFvbibtZi3+y88Um1MJneQyNSYAXRUd67PtfIuqj+ArTbrRAKNzCw==
X-Received: by 2002:a17:907:9622:b0:6f3:9797:8eaf with SMTP id gb34-20020a170907962200b006f397978eafmr3823374ejc.96.1651323196654;
        Sat, 30 Apr 2022 05:53:16 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id jl25-20020a17090775d900b006f3ef214dc5sm1597209ejc.43.2022.04.30.05.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:53:16 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 1/3] clk: qcom: clk-hfpll: use poll_timeout macro
Date:   Sat, 30 Apr 2022 07:44:56 +0200
Message-Id: <20220430054458.31321-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220430054458.31321-1-ansuelsmth@gmail.com>
References: <20220430054458.31321-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use regmap_read_poll_timeout macro instead of do-while structure to tidy
things up. Also set a timeout to prevent any sort of system stall.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/clk-hfpll.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/qcom/clk-hfpll.c b/drivers/clk/qcom/clk-hfpll.c
index e847d586a73a..7dd17c184b69 100644
--- a/drivers/clk/qcom/clk-hfpll.c
+++ b/drivers/clk/qcom/clk-hfpll.c
@@ -72,13 +72,16 @@ static void __clk_hfpll_enable(struct clk_hw *hw)
 	regmap_update_bits(regmap, hd->mode_reg, PLL_RESET_N, PLL_RESET_N);
 
 	/* Wait for PLL to lock. */
-	if (hd->status_reg) {
-		do {
-			regmap_read(regmap, hd->status_reg, &val);
-		} while (!(val & BIT(hd->lock_bit)));
-	} else {
+	if (hd->status_reg)
+		/*
+		 * Busy wait. Should never timeout, we add a timeout to
+		 * prevent any sort of stall.
+		 */
+		regmap_read_poll_timeout(regmap, hd->status_reg, val,
+					 !(val & BIT(hd->lock_bit)), 0,
+					 100 * USEC_PER_MSEC);
+	else
 		udelay(60);
-	}
 
 	/* Enable PLL output. */
 	regmap_update_bits(regmap, hd->mode_reg, PLL_OUTCTRL, PLL_OUTCTRL);
-- 
2.34.1

