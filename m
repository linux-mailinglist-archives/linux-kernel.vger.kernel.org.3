Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A654C4BADCE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiBQX6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:58:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiBQX6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:58:05 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801F83E5EC;
        Thu, 17 Feb 2022 15:57:35 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l67-20020a1c2546000000b00353951c3f62so5176785wml.5;
        Thu, 17 Feb 2022 15:57:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BZu919Ht8qcY64r+yFTBDeFPrzAizwLZFgHrPpz3SME=;
        b=N2LHTsH2M0bumRGjP4bIJ6/lUhLMOfzcqcDNUOx9zvJ8J0DW9LuHi2m40C2tx2V1xV
         CSL95dcnRN13NcLiXmE7d0oalvp4Ibnt74Qctre0VdZbn1AQIXHllCfEOEMT0juD21D3
         cV7Y0696Wj3VAJl0H9mGj5ccOq0eID7Ic1gWrOYHEIyI84k81ejIzPVpCr08xBvQnsMW
         qldntm6dZrEZG0ubS2xHBPyP3q+g+ImZM+D+NzYTnqSUrcf029K6mllwUo8JCYWXX5WA
         4uqOifV2WI56ZnlgjPF4H8b33iepzAuYL6g7LAdW4XNgx4GcZRl5nLS06RKEImy8thSD
         TcvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZu919Ht8qcY64r+yFTBDeFPrzAizwLZFgHrPpz3SME=;
        b=uhb3HQCHpF97orc15jP23cOqqJGKIjjhFOpDu3+laAu6UgVtTC7ZEOEEz6ynlhH5Mb
         +SAMds+3nKBW7DK7317h3j/+9hnBd58wNaD1ItV6xbu0BP0LjDYnM6mBUxL99xGs63Bz
         +w0yOHgr6nhPmv8zJ7sd5FTVqtgBk3+F5wpqQt4AcdUsM+f8UcVp0Re0pGueNLy32/qA
         5pbylUO02l3wFJhENfEDwA/ByzS9xYuY3SuelWDUx6QY/RDRyYbeaUreq3/HOOuP+Zos
         QvBTptz6jMY3IwgutStPmzVLH4pxzo7F+DHhJlzrpv3d2QRVdbTSnYSgBpkqoVuSyrZ4
         HALw==
X-Gm-Message-State: AOAM531HxmnB6pFinSyWHXQhSwSibp2OxfYjnZGUVp3V18L+IhIBa2gr
        rSV6DrK8sXMoZAMhF+/cKnUKLH/jsS8=
X-Google-Smtp-Source: ABdhPJwC4DqZ7MbBZFwg+a1ZSohHjHYye175apzrVYTXBetGxljesQ3+Fq9zKwPohcir0gQty+Px7g==
X-Received: by 2002:a05:600c:2552:b0:37b:c7dd:d376 with SMTP id e18-20020a05600c255200b0037bc7ddd376mr8045462wma.113.1645142234305;
        Thu, 17 Feb 2022 15:57:14 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id r2sm3691694wmq.24.2022.02.17.15.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:57:13 -0800 (PST)
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
Subject: [PATCH v4 10/16] clk: qcom: clk-rcg: add clk_rcg_floor_ops ops
Date:   Fri, 18 Feb 2022 00:56:57 +0100
Message-Id: <20220217235703.26641-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217235703.26641-1-ansuelsmth@gmail.com>
References: <20220217235703.26641-1-ansuelsmth@gmail.com>
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
---
 drivers/clk/qcom/clk-rcg.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

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
-- 
2.34.1

