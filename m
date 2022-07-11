Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B8C2570C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 23:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiGKVHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 17:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKVGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 17:06:46 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6FE72ED3;
        Mon, 11 Jul 2022 14:06:45 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id mf4so9723158ejc.3;
        Mon, 11 Jul 2022 14:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NvqH53z3vfF6U45ZTWaGu0TE308tKtxhxwmMlElMdBE=;
        b=qYvIvMcpLeWDoKMI/RLevejKWOs/kEIkWr8bMRdXO4c5POuhJGQf1bga7kZ75FfUFI
         QsaNnlLx4Xbbw+R6EZbrgn7IrHbK+MCHxAN41CgqdYCx0R3Zs6SkSNNGW4Biav6AvQBB
         xEg36YoY6VTY1gVaelNJUR/Ft+AhOn4PpV2aLANEIs7urxD5OODsJ3BlFsSzyIKXyyyA
         5VUtOTgZKHOCIUWWwxmcErrIY06BG/7cpNQfEugh/BNGRcfTwKRb+upgZqgU+iQppHmv
         rCHQ/jdGJeBuyiQLbjmj962Y0auQcpmyYhgalIvXAP4sSyDpvlWYr9xLH+UYaNnuFiVH
         fJHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NvqH53z3vfF6U45ZTWaGu0TE308tKtxhxwmMlElMdBE=;
        b=ukytmXfYKCwzPgSh68O/p9XiTdtZPzcZxbimEElvfJHbMqVRaG55PDC8nRvdzZTqae
         8lJfAo4Ovn13f/oOyr4DV398+oGB7VVW8zq2X+7/sjxZrL5tWoVzOq8ZRMkzhF4iSZ6Y
         0jRf9RFTF1+g3Pyc0TTHQKt3F6ZTLAL8/ifksrIQRDYrzjUYawisFeuwZ3U6oKPwKD2z
         ETwCWH6oMWlnqzPRfgLckiqXcSVXetl2V+t6H4jLZNnt+XBF3mD+fnZhBzEW+z+108F+
         5MAUg73lNy8ntwBN5qGdjhmQ4n9gT+iBJvWRItbkugP9cgCmK12l7l4wFMxQ611Y4jPZ
         Uv/A==
X-Gm-Message-State: AJIora8M9Mx7p7cB6JLbElhcfFuSLIO2zGzVidIEyLMtM99ShUm+cFEB
        UN/ej46a0Gvxn36a0cmnZSc=
X-Google-Smtp-Source: AGRyM1s937WdgEeYwZkVmEzHdo1tCO78QyCuWBMwTdXsFbD93r+Moi+/aQECuJSlpc5HRaOOy9Esqg==
X-Received: by 2002:a17:907:a042:b0:72b:4fac:1ddf with SMTP id gz2-20020a170907a04200b0072b4fac1ddfmr8602337ejc.285.1657573603837;
        Mon, 11 Jul 2022 14:06:43 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-104.zg.cable.xnet.hr. [94.253.165.104])
        by smtp.googlemail.com with ESMTPSA id lb17-20020a170907785100b0072a430d2abdsm3052562ejc.91.2022.07.11.14.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 14:06:43 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        konrad.dybcio@somainline.org, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 7/7] clk: qcom: apss-ipq-pll: add support for IPQ8074
Date:   Mon, 11 Jul 2022 23:06:34 +0200
Message-Id: <20220711210634.3042092-7-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711210634.3042092-1-robimarko@gmail.com>
References: <20220711210634.3042092-1-robimarko@gmail.com>
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

Add support for IPQ8074 since it uses the same PLL setup, however it uses
slightly different Alpha PLL config.

Alpha PLL config was obtained by dumping PLL registers from a running
device.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Drop hardcoded compatible check for IPQ6018 to do the PLL config and
utilize match data provided by previous commit
* Add IPQ8074 Alpha PLL config using match data
* Update commit description to reflect changes
---
 drivers/clk/qcom/apss-ipq-pll.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index a4016f3854c2..a5aea27eb867 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -49,6 +49,18 @@ static const struct alpha_pll_config ipq6018_pll_config = {
 	.test_ctl_hi_val = 0x4000,
 };
 
+static const struct alpha_pll_config ipq8074_pll_config = {
+	.l = 0x48,
+	.config_ctl_val = 0x200d4828,
+	.config_ctl_hi_val = 0x6,
+	.early_output_mask = BIT(3),
+	.aux2_output_mask = BIT(2),
+	.aux_output_mask = BIT(1),
+	.main_output_mask = BIT(0),
+	.test_ctl_val = 0x1c000000,
+	.test_ctl_hi_val = 0x4000,
+};
+
 static const struct regmap_config ipq_pll_regmap_config = {
 	.reg_bits		= 32,
 	.reg_stride		= 4,
@@ -89,6 +101,7 @@ static int apss_ipq_pll_probe(struct platform_device *pdev)
 
 static const struct of_device_id apss_ipq_pll_match_table[] = {
 	{ .compatible = "qcom,ipq6018-a53pll", .data = &ipq6018_pll_config },
+	{ .compatible = "qcom,ipq8074-a53pll", .data = &ipq8074_pll_config },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, apss_ipq_pll_match_table);
-- 
2.36.1

