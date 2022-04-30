Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BE4515D12
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352137AbiD3M4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbiD3M4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:56:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA7A60AA5;
        Sat, 30 Apr 2022 05:53:19 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n10so2628832ejk.5;
        Sat, 30 Apr 2022 05:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qQHp5HtdzpGu2u7npAjmiOBiFIiFXdFVAgc4KgBu3V0=;
        b=hxZJ1Xggho6ovzXV+Z55jxBgGNCDKN6/bAQZH8ATQDFvNpbAU0hPv+W/fgcFNq1mA7
         LfT8m7VrHrV2NQdVVnEdMuCYavw17uvlXGQ8Gp/egYKfD5lopBpOwTeKdpBlAeLo72UC
         uugUPhWhwa+avAJLdEwhmk2lcTS8cBObfVU/eyXW2Ae8ctR5eqqpVEWyRiK+AYEamv0U
         n8XClKt8hlNCHui0SzPnMCgRPG1jhYPcm98M8HhP5eDYyJlGpM0Tju5gFy/rJI9dfuLt
         B6Dh73kAqiO/cY/n7Dco12peIp5Sn0yzOuk5kAM4/YENmDPiyuVR6mv0iMQihowolHnf
         MHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qQHp5HtdzpGu2u7npAjmiOBiFIiFXdFVAgc4KgBu3V0=;
        b=dDDXhZhl2KxQZcmbmq7eRi48o6x80GJYQJRHr0Ct70+xfVWtryBtQOI5mS3V4cslQa
         sMiZJYgIS7uLQ9GrvZ+dS0CZFKDIbTrJY90hrlZ3dKy1c9x2YDbN6xUy6w5SDwbLT0eG
         Oy6QC2FeVLl4T2yTiQPwPHjFjytNeJiaZS2+GQ9fC+vHIfNRf7N+2kdfSbtdjuszpIBv
         bJ9kx6lbc2N6CzPxsF0K2XiQQVBOOu7vI2wh+yCG9mupkG17CKNTLQ6fYPMksocuAQmq
         0HCvLtS1zKECiK/CPH4uEAD6Il1QKcvabrDUKdihbpJ5GMkToRg3AL/UxNA4BpyGeHkS
         c4EA==
X-Gm-Message-State: AOAM530kIvqakAm5kT4HdfcpVsLNz2oq/Lrr1EUVZ7luOa52zFK7BRJA
        GpcOSF05ihyktMAcXAp6GiGlN8xnq0s=
X-Google-Smtp-Source: ABdhPJw5TykKCl8ZZD5YKi4a+JnFVOpeJekWxBLzqw6pvBJzJHzSNQnkfB9wlv+aC6wgGr2Fp0cIXw==
X-Received: by 2002:a17:906:7948:b0:6da:64ed:178e with SMTP id l8-20020a170906794800b006da64ed178emr3843533ejo.523.1651323197664;
        Sat, 30 Apr 2022 05:53:17 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id jl25-20020a17090775d900b006f3ef214dc5sm1597209ejc.43.2022.04.30.05.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 05:53:17 -0700 (PDT)
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
Subject: [PATCH v2 2/3] clk: qcom: clk-krait: unlock spin after mux completion
Date:   Sat, 30 Apr 2022 07:44:57 +0200
Message-Id: <20220430054458.31321-3-ansuelsmth@gmail.com>
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

Unlock spinlock after the mux switch is completed to prevent any corner
case of mux request while the switch still needs to be done.

Fixes: 4d7dc77babfe ("clk: qcom: Add support for Krait clocks")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/clk-krait.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
index 59f1af415b58..90046428693c 100644
--- a/drivers/clk/qcom/clk-krait.c
+++ b/drivers/clk/qcom/clk-krait.c
@@ -32,11 +32,16 @@ static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
 		regval |= (sel & mux->mask) << (mux->shift + LPL_SHIFT);
 	}
 	krait_set_l2_indirect_reg(mux->offset, regval);
-	spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
 
 	/* Wait for switch to complete. */
 	mb();
 	udelay(1);
+
+	/*
+	 * Unlock now to make sure the mux register is not
+	 * modified while switching to the new parent.
+	 */
+	spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
 }
 
 static int krait_mux_set_parent(struct clk_hw *hw, u8 index)
-- 
2.34.1

