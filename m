Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5BE4C5646
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 14:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiBZNxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 08:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbiBZNxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 08:53:31 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB71E76E2B;
        Sat, 26 Feb 2022 05:52:50 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g20so11119183edw.6;
        Sat, 26 Feb 2022 05:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jeyetmRTaaeleewY1sQlJw1tf2j502t0LB04L3uIBFc=;
        b=e2QJj9ns73IETsCuHNTugdyePDR3LxklrRjC0HOJVNk6yfA6p8sTaB3JR/zo73TZaw
         hmZt6qoNu4ee/cPyucDEBYZwoGuRuXHt2ZZcGeNHwHkp2Lc0UiEV1Zrj2k9dy/7Zv+EH
         4rs9S1cVp3RY/3gxWrjmnFodta4MgQsP3Ol+AX5Edd/rJSRz1OrE2KY1NTNEvft3Ziyw
         bD8jU87BTZEuP7OmGT4exKJQ6olNirGBG401x9tc54uIUHoy9OLm5YFo5kp67uzL/OEa
         +DGQniQE4+nV8XlhtPYiF+nG5wqlsXcsAZzem89ZT5UZRiXHhJYplBrHzZZhI9AhTnAP
         QARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jeyetmRTaaeleewY1sQlJw1tf2j502t0LB04L3uIBFc=;
        b=ae22KsetaZVfE1atDL/geRnlUhjdTt0oIoxhNJkBMJ1IxHRb6VnIsyovJHr1XRBgEj
         nr2HjduBPs8b8RU5ak8vANDD6BPoenuK3+/Ph4V0hdg39SkVhBOnxOKinRiX9fHaff/f
         b8bJ0yvJujFR4vctUUdkrT6UzL/e6PO4EtKCl7DGBJKlCVjexQig1Unurkq3W19I+xWA
         zNTXizoFZnKr1hrZxwF+kTqF3ELptcXK0fnoQbk9eQumMZxmUDZsG6rIRqw7nRX+Lm2a
         FCPGIAfL1zTlF1XdgVKhcarxt5dOwJjxsZUbtlEyIe8UnVFGx62pQWfDMamMLf2yd9tF
         1DNA==
X-Gm-Message-State: AOAM531Tv2KkcrsFFRDpE4FCCpXCeFvMIX64SYuuPPUgYRhPJjtE6Jw7
        HRxDj286vrpgKUXoKXoJJwU=
X-Google-Smtp-Source: ABdhPJzRI9CzjFoZ4nPXLakbYu3GGkTzHypBhHfLspPKRVsrJG7J1MDy+fe5nXjvpvi4ojI4ZOo8IA==
X-Received: by 2002:a05:6402:1cae:b0:410:d3ae:3c8a with SMTP id cz14-20020a0564021cae00b00410d3ae3c8amr11263886edb.215.1645883569258;
        Sat, 26 Feb 2022 05:52:49 -0800 (PST)
Received: from Ansuel-xps.localdomain (host-95-251-226-220.retail.telecomitalia.it. [95.251.226.220])
        by smtp.googlemail.com with ESMTPSA id j21-20020aa7c415000000b004127ac9ddc3sm2836369edq.50.2022.02.26.05.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 05:52:48 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/15] clk: qcom: clk-rcg: add clk_rcg_floor_ops ops
Date:   Sat, 26 Feb 2022 14:52:29 +0100
Message-Id: <20220226135235.10051-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220226135235.10051-1-ansuelsmth@gmail.com>
References: <20220226135235.10051-1-ansuelsmth@gmail.com>
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

Add clk_rcg_floor_ops for clock that can't provide a stable freq and
require to use a floor freq to provide the requested frequency.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Reviewed-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/qcom/clk-rcg.c | 24 ++++++++++++++++++++++++
 drivers/clk/qcom/clk-rcg.h |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/clk/qcom/clk-rcg.c b/drivers/clk/qcom/clk-rcg.c
index a9d181d6be21..88845baa7f84 100644
--- a/drivers/clk/qcom/clk-rcg.c
+++ b/drivers/clk/qcom/clk-rcg.c
@@ -526,6 +526,19 @@ static int clk_rcg_set_rate(struct clk_hw *hw, unsigned long rate,
 	return __clk_rcg_set_rate(rcg, f);
 }
 
+static int clk_rcg_set_floor_rate(struct clk_hw *hw, unsigned long rate,
+				  unsigned long parent_rate)
+{
+	struct clk_rcg *rcg = to_clk_rcg(hw);
+	const struct freq_tbl *f;
+
+	f = qcom_find_freq_floor(rcg->freq_tbl, rate);
+	if (!f)
+		return -EINVAL;
+
+	return __clk_rcg_set_rate(rcg, f);
+}
+
 static int clk_rcg_bypass_set_rate(struct clk_hw *hw, unsigned long rate,
 				unsigned long parent_rate)
 {
@@ -816,6 +829,17 @@ const struct clk_ops clk_rcg_ops = {
 };
 EXPORT_SYMBOL_GPL(clk_rcg_ops);
 
+const struct clk_ops clk_rcg_floor_ops = {
+	.enable = clk_enable_regmap,
+	.disable = clk_disable_regmap,
+	.get_parent = clk_rcg_get_parent,
+	.set_parent = clk_rcg_set_parent,
+	.recalc_rate = clk_rcg_recalc_rate,
+	.determine_rate = clk_rcg_determine_rate,
+	.set_rate = clk_rcg_set_floor_rate,
+};
+EXPORT_SYMBOL_GPL(clk_rcg_floor_ops);
+
 const struct clk_ops clk_rcg_bypass_ops = {
 	.enable = clk_enable_regmap,
 	.disable = clk_disable_regmap,
diff --git a/drivers/clk/qcom/clk-rcg.h b/drivers/clk/qcom/clk-rcg.h
index 99efcc7f8d88..00cea508d49e 100644
--- a/drivers/clk/qcom/clk-rcg.h
+++ b/drivers/clk/qcom/clk-rcg.h
@@ -86,6 +86,7 @@ struct clk_rcg {
 };
 
 extern const struct clk_ops clk_rcg_ops;
+extern const struct clk_ops clk_rcg_floor_ops;
 extern const struct clk_ops clk_rcg_bypass_ops;
 extern const struct clk_ops clk_rcg_bypass2_ops;
 extern const struct clk_ops clk_rcg_pixel_ops;
-- 
2.34.1

