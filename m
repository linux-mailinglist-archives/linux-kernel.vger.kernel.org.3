Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33994CCB31
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 02:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiCDBNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 20:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiCDBMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 20:12:51 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4ACE179A38;
        Thu,  3 Mar 2022 17:12:04 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id e22so5524479qvf.9;
        Thu, 03 Mar 2022 17:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RZ20cZByPmP2cAEILKOqMRtPG8kY2S8o8lNfMJWK8Zw=;
        b=pkLEh4SiuXRflhcjHEsoGtQ6RTF2GvifZQKSInOqEL8gTrqjpEfqtQ2WQeVweRCOLF
         aKTyKVredHbJTUWT8oXAGjzQWFRRougy+S7FtkYEZk75Q/bCX8fOUuLQ9x8RNcFkMrjl
         mIsylHA41tXq0O0trJ6qQ5NleAQ9ax8Z5ZY/Vt8EXl5LpNAeisqmtfST4RGN3/roST/f
         Y+Mimt63hwUHrlUbva91u5Wj4kcdWpWFqco0uebIKIG2VZ3JyRXhzmb/Gfph9BUmj+Iq
         HZvz8LtO36sc5ZtFBz56ILkj9zcI+DOA/v0vlEW592QNWlCnEY+wVUmQT0MJZJoCzJex
         +NmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RZ20cZByPmP2cAEILKOqMRtPG8kY2S8o8lNfMJWK8Zw=;
        b=ob/7u7N4g7NzQUKqHp16KCtb+NbZHOqoWQUd47/A0i6xQHkbGVDz4eXU5DIg/WAZ/N
         rnIq+ZZyPw1pzOisovFeoEDZuUY/jveqesf5bSwwtAS3g7CT46jghfap8Cpe/VvuxylQ
         o/fCEYJdzCJQseJED+v03lfe7ye7JVt6hHX1wFbWJs+xzT2RyrkoN+ZBKw8j0MqnXtPf
         ELsoZUieUNogyg8VbYLnYcbB0a/r8SSNJFP3LeDR8SgG7UQNUx25MXdAceRhtcj+dO1L
         ruKIRe3TaD8n3X2wTlXe2VxjBlHtdQ4PbM5lKWO/hkTu7G3FwfehzaSok+ymT1RN+Ux0
         emjQ==
X-Gm-Message-State: AOAM533pZe00oLDDZf7YKrDoQwEPFABbNcx257y8Y8kP0t4w+SHdxjD1
        gduyg/FGhYnY6xbX8V7KaOY=
X-Google-Smtp-Source: ABdhPJx+rBIdFD9P/7Ietgk+dzJCFBVOKhE6pfzCjDjFYjqbGkwNLrmrpFfmIkkAIs/pexrXjEJ48A==
X-Received: by 2002:ad4:5f08:0:b0:435:386d:1aa5 with SMTP id fo8-20020ad45f08000000b00435386d1aa5mr3663321qvb.47.1646356323804;
        Thu, 03 Mar 2022 17:12:03 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h14-20020ac8584e000000b002ddf8b971b2sm2687639qth.87.2022.03.03.17.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 17:12:03 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     krzysztof.kozlowski@canonical.com
Cc:     alim.akhtar@samsung.com, cgel.zte@gmail.com,
        chi.minghao@zte.com.cn, cw00.choi@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        mturquette@baylibre.com, s.nawrocki@samsung.com, sboyd@kernel.org,
        tomasz.figa@gmail.com, zealci@zte.com.cn
Subject: [PATCH] clk/samsung: Use of_device_get_match_data()
Date:   Fri,  4 Mar 2022 01:11:55 +0000
Message-Id: <20220304011155.2061393-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <77a147f9-794c-83ca-070b-fb17d665ed8f@canonical.com>
References: <77a147f9-794c-83ca-070b-fb17d665ed8f@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

Use of_device_get_match_data() to simplify the code.

Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
---
 drivers/clk/samsung/clk-exynos-clkout.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos-clkout.c b/drivers/clk/samsung/clk-exynos-clkout.c
index e6d6cbf8c4e6..feed1a347c09 100644
--- a/drivers/clk/samsung/clk-exynos-clkout.c
+++ b/drivers/clk/samsung/clk-exynos-clkout.c
@@ -81,19 +81,13 @@ MODULE_DEVICE_TABLE(of, exynos_clkout_ids);
 static int exynos_clkout_match_parent_dev(struct device *dev, u32 *mux_mask)
 {
 	const struct exynos_clkout_variant *variant;
-	const struct of_device_id *match;
 
 	if (!dev->parent) {
 		dev_err(dev, "not instantiated from MFD\n");
 		return -EINVAL;
 	}
 
-	match = of_match_device(exynos_clkout_ids, dev->parent);
-	if (!match) {
-		dev_err(dev, "cannot match parent device\n");
-		return -EINVAL;
-	}
-	variant = match->data;
+	variant = of_device_get_match_data(dev->parent);
 
 	*mux_mask = variant->mux_mask;
 
-- 
2.25.1

