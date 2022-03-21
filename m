Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8C44E2D61
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350810AbiCUQKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350699AbiCUQJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:09:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA7A28E1B;
        Mon, 21 Mar 2022 09:08:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h189so88173wmh.3;
        Mon, 21 Mar 2022 09:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=1tacB+H58ZcVKBVcWE3u+TMM2y65iIDEoWk8hI94hWs=;
        b=SfJl/86cPzI9BaAZjLQH92XV0QTa7gDPuhbb5TKYkBAPkXhgYHgg/SkSZv1fN8VAZp
         Rz/ktPfjE6lBQh7PbOblW2I++fpm7FDMhphs7/6SjkSAOCmnoQ+HKvYmjylJkGz5Ohau
         8JWnmCfHYKL38JXs/VhJZpPs7m13CvKphbkCQ6pdsSYEKjhFTudHwuAA6n54Y0arDY/P
         /fjf7eNbn1fNvr3mKRmVzMQEJMG0EuIl5qLx2G2daLd4uoUcN18CxF0Ajos5BrtsopqS
         w/mxh8oRe1lDZ3+K++anmVtC5X4ECq4vLq+MB94MNGPgi/N0yCkwzb8iiUJAR/MJCNGK
         Z2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1tacB+H58ZcVKBVcWE3u+TMM2y65iIDEoWk8hI94hWs=;
        b=UZ9MwKPqWDZCFaY8YDfHwOCdl6WyPNCXbFMg4e3HABpqrZX2UGckSFrG7HC1SfWtYw
         oLVPFu+1/AGr4bzDfyVU/hJgz3Mc2jXF9V+t//0pn/YDHbLTFT5XBgQd6hMXiBIrhjJ4
         3R3Ay72AUTJ98ZeRLXvlEtgudXZ/+S4cxrygHVCQcuoT2jL6Yq3CrQneQY0p0Vvmcpzi
         nHvZFWBziOD22WGOGg4GGIhsLnO3yvh4r1l0FWzTlSa5icRvSNZiub4Irqnm20vlFxnv
         KLZ8MMUajiiznNQ7aTzqZXrQ0h1bTAso9bC1Q/zXafDp8K4kkVRdnEv20Y4MITL/xpEI
         2O2Q==
X-Gm-Message-State: AOAM533MXcEr0FMUYBjQPEHfSqjKuQBN3ufDN6HQ7IR2zJmhVnJ1+lza
        r/O8uMKRTvjHYpC5QAdsvq5PBG7FonI=
X-Google-Smtp-Source: ABdhPJz4UYKT8iwzmtMpkQ+eSWmqC2tIqo5+yQvBGG8VilUzWnk/ilfjk4DBImJ0XiK9YJuRxKvqtQ==
X-Received: by 2002:a05:600c:3ac7:b0:38b:f9c6:27b8 with SMTP id d7-20020a05600c3ac700b0038bf9c627b8mr19741082wms.75.1647878903706;
        Mon, 21 Mar 2022 09:08:23 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:23 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 08/18] clk: qcom: krait-cc: convert to parent_data API
Date:   Mon, 21 Mar 2022 16:38:45 +0100
Message-Id: <20220321153855.12082-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321153855.12082-1-ansuelsmth@gmail.com>
References: <20220321153855.12082-1-ansuelsmth@gmail.com>
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

Modernize the krait-cc driver to parent-data API and refactor to drop
any use of clk_names. From Documentation all the required clocks should
be declared in DTS so fw_name can be correctly used to get the parents
for all the muxes. Name is also declared to save compatibility with old
implementation. Also fix the parent order of the sec_mux that was wrong
and incorrectly report the wrong safe parent if it's not hardcoded.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/krait-cc.c | 126 +++++++++++++++++++-----------------
 1 file changed, 66 insertions(+), 60 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 4d4b657d33c3..645ad9e8dd73 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -69,21 +69,22 @@ static int krait_notifier_register(struct device *dev, struct clk *clk,
 	return ret;
 }
 
-static int
+static struct clk *
 krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 {
 	struct krait_div2_clk *div;
+	static struct clk_parent_data p_data[1];
 	struct clk_init_data init = {
-		.num_parents = 1,
+		.num_parents = ARRAY_SIZE(p_data),
 		.ops = &krait_div2_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
-	const char *p_names[1];
 	struct clk *clk;
+	char *parent_name;
 
 	div = devm_kzalloc(dev, sizeof(*div), GFP_KERNEL);
 	if (!div)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	div->width = 2;
 	div->shift = 6;
@@ -93,43 +94,49 @@ krait_add_div(struct device *dev, int id, const char *s, unsigned int offset)
 
 	init.name = kasprintf(GFP_KERNEL, "hfpll%s_div", s);
 	if (!init.name)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
-	init.parent_names = p_names;
-	p_names[0] = kasprintf(GFP_KERNEL, "hfpll%s", s);
-	if (!p_names[0]) {
-		kfree(init.name);
-		return -ENOMEM;
+	init.parent_data = p_data;
+	parent_name = kasprintf(GFP_KERNEL, "hfpll%s", s);
+	if (!parent_name) {
+		clk = ERR_PTR(-ENOMEM);
+		goto err_parent_name;
 	}
 
+	p_data[0].fw_name = parent_name;
+	p_data[0].name = parent_name;
+
 	clk = devm_clk_register(dev, &div->hw);
-	kfree(p_names[0]);
+
+	kfree(parent_name);
+err_parent_name:
 	kfree(init.name);
 
-	return PTR_ERR_OR_ZERO(clk);
+	return clk;
 }
 
-static int
+static struct clk *
 krait_add_sec_mux(struct device *dev, int id, const char *s,
 		  unsigned int offset, bool unique_aux)
 {
 	int ret;
 	struct krait_mux_clk *mux;
-	static const char *sec_mux_list[] = {
-		"acpu_aux",
-		"qsb",
+	static struct clk_parent_data sec_mux_list[2] = {
+		{ .name = "qsb", .fw_name = "qsb" },
+		{},
 	};
 	struct clk_init_data init = {
-		.parent_names = sec_mux_list,
+		.parent_data = sec_mux_list,
 		.num_parents = ARRAY_SIZE(sec_mux_list),
 		.ops = &krait_mux_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
 	struct clk *clk;
+	char *parent_name;
 
 	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	mux->offset = offset;
 	mux->lpl = id >= 0;
@@ -141,44 +148,51 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
 
 	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
 	if (!init.name)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	if (unique_aux) {
-		sec_mux_list[0] = kasprintf(GFP_KERNEL, "acpu%s_aux", s);
-		if (!sec_mux_list[0]) {
+		parent_name = kasprintf(GFP_KERNEL, "acpu%s_aux", s);
+		if (!parent_name) {
 			clk = ERR_PTR(-ENOMEM);
 			goto err_aux;
 		}
+		sec_mux_list[1].fw_name = parent_name;
+		sec_mux_list[1].name = parent_name;
+	} else {
+		sec_mux_list[1].name = "apu_aux";
 	}
 
 	clk = devm_clk_register(dev, &mux->hw);
+	if (IS_ERR(clk))
+		goto err_clk;
 
 	ret = krait_notifier_register(dev, clk, mux);
 	if (ret)
-		goto unique_aux;
+		clk = ERR_PTR(ret);
 
-unique_aux:
+err_clk:
 	if (unique_aux)
-		kfree(sec_mux_list[0]);
+		kfree(parent_name);
 err_aux:
 	kfree(init.name);
-	return PTR_ERR_OR_ZERO(clk);
+	return clk;
 }
 
 static struct clk *
-krait_add_pri_mux(struct device *dev, int id, const char *s,
-		  unsigned int offset)
+krait_add_pri_mux(struct device *dev, struct clk *hfpll_div, struct clk *sec_mux,
+		  int id, const char *s, unsigned int offset)
 {
 	int ret;
 	struct krait_mux_clk *mux;
-	const char *p_names[3];
+	static struct clk_parent_data p_data[3];
 	struct clk_init_data init = {
-		.parent_names = p_names,
-		.num_parents = ARRAY_SIZE(p_names),
+		.parent_data = p_data,
+		.num_parents = ARRAY_SIZE(p_data),
 		.ops = &krait_mux_clk_ops,
 		.flags = CLK_SET_RATE_PARENT,
 	};
 	struct clk *clk;
+	char *hfpll_name;
 
 	mux = devm_kzalloc(dev, sizeof(*mux), GFP_KERNEL);
 	if (!mux)
@@ -196,36 +210,29 @@ krait_add_pri_mux(struct device *dev, int id, const char *s,
 	if (!init.name)
 		return ERR_PTR(-ENOMEM);
 
-	p_names[0] = kasprintf(GFP_KERNEL, "hfpll%s", s);
-	if (!p_names[0]) {
+	hfpll_name = kasprintf(GFP_KERNEL, "hfpll%s", s);
+	if (!hfpll_name) {
 		clk = ERR_PTR(-ENOMEM);
-		goto err_p0;
+		goto err_hfpll;
 	}
 
-	p_names[1] = kasprintf(GFP_KERNEL, "hfpll%s_div", s);
-	if (!p_names[1]) {
-		clk = ERR_PTR(-ENOMEM);
-		goto err_p1;
-	}
+	p_data[0].fw_name = hfpll_name;
+	p_data[0].name = hfpll_name;
 
-	p_names[2] = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
-	if (!p_names[2]) {
-		clk = ERR_PTR(-ENOMEM);
-		goto err_p2;
-	}
+	p_data[1].hw = __clk_get_hw(hfpll_div);
+	p_data[2].hw = __clk_get_hw(sec_mux);
 
 	clk = devm_clk_register(dev, &mux->hw);
+	if (IS_ERR(clk))
+		goto err_clk;
 
 	ret = krait_notifier_register(dev, clk, mux);
 	if (ret)
-		goto err_p3;
-err_p3:
-	kfree(p_names[2]);
-err_p2:
-	kfree(p_names[1]);
-err_p1:
-	kfree(p_names[0]);
-err_p0:
+		clk = ERR_PTR(ret);
+
+err_clk:
+	kfree(hfpll_name);
+err_hfpll:
 	kfree(init.name);
 	return clk;
 }
@@ -233,11 +240,10 @@ krait_add_pri_mux(struct device *dev, int id, const char *s,
 /* id < 0 for L2, otherwise id == physical CPU number */
 static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
 {
-	int ret;
 	unsigned int offset;
 	void *p = NULL;
 	const char *s;
-	struct clk *clk;
+	struct clk *hfpll_div, *sec_mux, *clk;
 
 	if (id >= 0) {
 		offset = 0x4501 + (0x1000 * id);
@@ -249,19 +255,19 @@ static struct clk *krait_add_clks(struct device *dev, int id, bool unique_aux)
 		s = "_l2";
 	}
 
-	ret = krait_add_div(dev, id, s, offset);
-	if (ret) {
-		clk = ERR_PTR(ret);
+	hfpll_div = krait_add_div(dev, id, s, offset);
+	if (IS_ERR(hfpll_div)) {
+		clk = hfpll_div;
 		goto err;
 	}
 
-	ret = krait_add_sec_mux(dev, id, s, offset, unique_aux);
-	if (ret) {
-		clk = ERR_PTR(ret);
+	sec_mux = krait_add_sec_mux(dev, id, s, offset, unique_aux);
+	if (IS_ERR(sec_mux)) {
+		clk = sec_mux;
 		goto err;
 	}
 
-	clk = krait_add_pri_mux(dev, id, s, offset);
+	clk = krait_add_pri_mux(dev, hfpll_div, sec_mux, id, s, offset);
 err:
 	kfree(p);
 	return clk;
-- 
2.34.1

