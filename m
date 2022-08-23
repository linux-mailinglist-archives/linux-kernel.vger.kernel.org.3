Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC33B59E8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343612AbiHWRJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245155AbiHWRJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:09:35 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3F78A1DD;
        Tue, 23 Aug 2022 06:36:27 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id p9so12409992pfq.13;
        Tue, 23 Aug 2022 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qkCUHHEjfjSKRNQH08mkmAjUm96MxGOjYlwpNmfHX0U=;
        b=qLjD8RrkXfDmKSsc6uvFpxxaOKcjFrlX4Ed+uag+3Zcut/RvJBrmAPkRQzyN2ThJDp
         HogTfLUISfd4IGGr7WwQ4FfKIWDNBiyTGKDGukrQvhEwF/fMh8SGC0Wsdt+L6rmQz94M
         XMphEOULUrmPEQTUtIz7qzhZpSNdsUDAxW8yo2/XsIHk6YEr8Ps7k9FTThxVaQEMBSnU
         Q+my5qp/br8t3pPgXgMN2AFRE73097pMSUkx/iq8c3xru2nAQPkku6i+4ku6hmjcQbzF
         6uuI9nJssK/+iKLSpWBlZTodGnB9dClR8ltHX+fTLzY4ARGl9rmgPEWceOFzJAdd3o51
         ty7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qkCUHHEjfjSKRNQH08mkmAjUm96MxGOjYlwpNmfHX0U=;
        b=j2dz7NUigDqfBmJ/raCF3JmWw8094BzWEWj07VlyidkIE0MX18ODfpQiXE3+LUYAkw
         uI7lgYtcEonvUCONaln2gI3omk62J2EQ5FEU/Ot8hYZ7yTGGv7KXxI1wGRxoT1e/qB/b
         ViRRj3KKQiw9/Q6PDxZ7Q5CNSYbE+8mwpjA3JJMTGjzK0QlleOQMdnuoHWd2QeOsuxyz
         gIvgTAey65kgtqPO5S2RsRIlSR6hxr5qk/ClpN1BwvC2FJI1eU3q0mDTYLFQZJqP+c97
         L64nWbxNaVk7k/ZuM5xUJdlVcqjqLq0C3OwaZSKwFQlFkScF5q6Yj8G2aG+GEVhP0vqD
         Y+jA==
X-Gm-Message-State: ACgBeo1U2XqDpG1txHUH3cqVE3Dnqigye2oEvZpXQ/Kosbzs2/M2AePf
        Uk25D5iNI4sL13zZKLiKKW8=
X-Google-Smtp-Source: AA6agR7efiQxwbLWixfzhjMKdtkgJvkshRWfVT7naWyUZWCL75aBLjGcDOpWiyrbZhAIN33BsfFWew==
X-Received: by 2002:a05:6a00:b53:b0:537:7f7:63a7 with SMTP id p19-20020a056a000b5300b0053707f763a7mr2134388pfo.2.1661261786624;
        Tue, 23 Aug 2022 06:36:26 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 203-20020a6215d4000000b005350ea966c7sm10812859pfv.154.2022.08.23.06.36.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 06:36:26 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: cui.jinpeng2@zte.com.cn
To:     krzysztof.kozlowski@linaro.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] soc: qcom: icc-bwmon: remove redundant ret variable
Date:   Tue, 23 Aug 2022 13:36:20 +0000
Message-Id: <20220823133620.211902-1-cui.jinpeng2@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Return value from devm_regmap_field_bulk_alloc() directly
instead of taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
---
 drivers/soc/qcom/icc-bwmon.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
index 47c2c3e7bb3f..9df47afb0d81 100644
--- a/drivers/soc/qcom/icc-bwmon.c
+++ b/drivers/soc/qcom/icc-bwmon.c
@@ -551,7 +551,6 @@ static int bwmon_init_regmap(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	void __iomem *base;
 	struct regmap *map;
-	int ret;
 
 	base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(base))
@@ -565,11 +564,10 @@ static int bwmon_init_regmap(struct platform_device *pdev,
 
 	BUILD_BUG_ON(ARRAY_SIZE(msm8998_bwmon_reg_fields) != F_NUM_FIELDS);
 	BUILD_BUG_ON(ARRAY_SIZE(sdm845_llcc_bwmon_reg_fields) != F_NUM_FIELDS);
-	ret = devm_regmap_field_bulk_alloc(dev, map, bwmon->regs,
+
+	return devm_regmap_field_bulk_alloc(dev, map, bwmon->regs,
 					   bwmon->data->regmap_fields,
 					   F_NUM_FIELDS);
-
-	return ret;
 }
 
 static int bwmon_probe(struct platform_device *pdev)
-- 
2.25.1

