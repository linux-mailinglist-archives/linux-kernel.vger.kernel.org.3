Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28CD0510CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356146AbiDZXgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356126AbiDZXgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:36:24 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5163B3191D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:33:15 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-e2fa360f6dso307116fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mPLQqqv78H4vpATnizZrr8k/pThUI48bHzxuZTk6fwo=;
        b=wX1c0JS3y92QFPGUeiWHj+woXNrE7erTJk1Ex1Fdj0oLhGeW9WijdzMooVfBdRU8/w
         xsy7sCPjHKmvPO6vxB5Gj0LrX9a4k5539SnsgDlw9uIP/3YZSbfSfPOODmfkhe+xjtuB
         qNDjL4sT24F6tM7p+iqXuUJk/mMzofIPrc/1ZZojc77kJmhbZuiKPWZrKvwALm3tqiBB
         yyi/tKSqfNHHhA7CmBivBsydaiVENxDTGhckVAMknF2PZIIkGxbkhyTDJZrwWs43AmUx
         4riM15Fj3ccawuBPlYgeJt4IiZZUo/LvlxRCzE0qA9SXNCYbwcn1XLtmRJxkK6+cOoab
         u7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mPLQqqv78H4vpATnizZrr8k/pThUI48bHzxuZTk6fwo=;
        b=ROqOKfbIbS3QP+GIJXwtYHBa5+bO1LmaPfjvw4FRzdDvrAlUVFsR/zQc9WC6wWjGzI
         wIL/1pslw+TUOkAkCv0TYd/hl7SohrgiLsMgbCknLGdzzQlGS3onuPA4QKvRcfDSZVZv
         qtnY4Q7r+g7PFINVwwGUQqggqe8Xj1kRzRq+2Lb4GGSSw8DEONgJ8mmtqUCQr7nx0OcD
         w4jf9UmWGu9DMp44xr/cq8Wi9ldE5OJphWn65OHYucWY4+HdJI+CPwCWQjXv8zec0ESI
         WzJCTbc7z8Oe1JBm/6vcnWDw5xXRQi/REqIWEDN5a2Bgy31NDAsUqjCwdCEbCrteq8Cw
         zsLg==
X-Gm-Message-State: AOAM531cCeJwSF2cLQEYgmqSzf2ppJ7HgQb9rJcSzRFBt5OfbGGddx6c
        Sqc4zBIqPMVN24RwFdt8Yn8YDg==
X-Google-Smtp-Source: ABdhPJyFzx5w7Bc5hjOwS1ur3aTP5yIT4qlqeVoSB/Ri8LWJ2hKuoMOgzDxIeA7qxam0MS/2BSW8mg==
X-Received: by 2002:a05:6870:471f:b0:e9:5b13:3881 with SMTP id b31-20020a056870471f00b000e95b133881mr3603134oaq.106.1651015994714;
        Tue, 26 Apr 2022 16:33:14 -0700 (PDT)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id k2-20020a4adfa2000000b0033a3381a7f1sm6151658ook.44.2022.04.26.16.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 16:33:14 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] soc: qcom: rpmhpd: add sc8280xp & sa8540p rpmh power-domains
Date:   Tue, 26 Apr 2022 16:35:08 -0700
Message-Id: <20220426233508.1762345-4-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
References: <20220426233508.1762345-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm sc8280xp platform has 13 and the sa8540p platform has 11
power-domains. Add compatibles, the typically used ones power-domains
and their relevant active-only variants, to the RPMh power-domain
driver.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added QPHY
- Split out sa8540
- Sorted the entries alphabetically

 drivers/soc/qcom/rpmhpd.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index f8d28e902942..05fff8691ee3 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -180,6 +180,36 @@ static struct rpmhpd mxc_ao = {
 	.res_name = "mxc.lvl",
 };
 
+static struct rpmhpd nsp = {
+	.pd = { .name = "nsp", },
+	.res_name = "nsp.lvl",
+};
+
+static struct rpmhpd qphy = {
+	.pd = { .name = "qphy", },
+	.res_name = "qphy.lvl",
+};
+
+/* SA8540P RPMH powerdomains */
+static struct rpmhpd *sa8540p_rpmhpds[] = {
+	[SC8280XP_CX] = &cx,
+	[SC8280XP_CX_AO] = &cx_ao,
+	[SC8280XP_EBI] = &ebi,
+	[SC8280XP_GFX] = &gfx,
+	[SC8280XP_LCX] = &lcx,
+	[SC8280XP_LMX] = &lmx,
+	[SC8280XP_MMCX] = &mmcx,
+	[SC8280XP_MMCX_AO] = &mmcx_ao,
+	[SC8280XP_MX] = &mx,
+	[SC8280XP_MX_AO] = &mx_ao,
+	[SC8280XP_NSP] = &nsp,
+};
+
+static const struct rpmhpd_desc sa8540p_desc = {
+	.rpmhpds = sa8540p_rpmhpds,
+	.num_pds = ARRAY_SIZE(sa8540p_rpmhpds),
+};
+
 /* SDM845 RPMH powerdomains */
 static struct rpmhpd *sdm845_rpmhpds[] = {
 	[SDM845_CX] = &cx_w_mx_parent,
@@ -378,10 +408,33 @@ static const struct rpmhpd_desc sc8180x_desc = {
 	.num_pds = ARRAY_SIZE(sc8180x_rpmhpds),
 };
 
+/* SC8280xp RPMH powerdomains */
+static struct rpmhpd *sc8280xp_rpmhpds[] = {
+	[SC8280XP_CX] = &cx,
+	[SC8280XP_CX_AO] = &cx_ao,
+	[SC8280XP_EBI] = &ebi,
+	[SC8280XP_GFX] = &gfx,
+	[SC8280XP_LCX] = &lcx,
+	[SC8280XP_LMX] = &lmx,
+	[SC8280XP_MMCX] = &mmcx,
+	[SC8280XP_MMCX_AO] = &mmcx_ao,
+	[SC8280XP_MX] = &mx,
+	[SC8280XP_MX_AO] = &mx_ao,
+	[SC8280XP_NSP] = &nsp,
+	[SC8280XP_QPHY] = &qphy,
+};
+
+static const struct rpmhpd_desc sc8280xp_desc = {
+	.rpmhpds = sc8280xp_rpmhpds,
+	.num_pds = ARRAY_SIZE(sc8280xp_rpmhpds),
+};
+
 static const struct of_device_id rpmhpd_match_table[] = {
+	{ .compatible = "qcom,sa8540p-rpmhpd", .data = &sa8540p_desc },
 	{ .compatible = "qcom,sc7180-rpmhpd", .data = &sc7180_desc },
 	{ .compatible = "qcom,sc7280-rpmhpd", .data = &sc7280_desc },
 	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
+	{ .compatible = "qcom,sc8280xp-rpmhpd", .data = &sc8280xp_desc },
 	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
 	{ .compatible = "qcom,sdx55-rpmhpd", .data = &sdx55_desc},
 	{ .compatible = "qcom,sdx65-rpmhpd", .data = &sdx65_desc},
-- 
2.35.1

