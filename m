Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812134E2D39
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350744AbiCUQKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350669AbiCUQJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:09:46 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B70624F2D;
        Mon, 21 Mar 2022 09:08:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id o7-20020a05600c4fc700b0038c87edc21eso229851wmq.0;
        Mon, 21 Mar 2022 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=XhL5PcXPAVYZIaqVjbCyrF3IgCwpUk1BeN4L/hsgGTo=;
        b=TAwE5HW6hYVyPsz24A2O6MJaAg5DkdubLsxsGaW8MPzHT9izKqCVZtk9NE3ufH3Lrm
         v/zum8mDWlnL/t2LGk5gZp93yBImDtOs2d+OAz6lHeVUT0vjWJzLOQFnrhuSTST1Tl5m
         JRlyBrjTyyTqF6J68S7fDjwr8frjwd9pmRx/7kThZ6OOKqzqlh4WZdxzHVcZVhdwvfbz
         mQzE83JtQPGl5qMr3+P7pQywrM6gLobO91tnR7eLbHySbXzkpj3uBdHX0Art9ZGF5eSb
         kXBuef1YP8QEXm2ATeWz+J4VFk8nftiSZ+ba1/50v0lKAUlKwAhp08tgV2nr5ctrjpZ+
         xmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XhL5PcXPAVYZIaqVjbCyrF3IgCwpUk1BeN4L/hsgGTo=;
        b=QMbhqbjRQ915tAkRpAWXvM+Qy3TnXcZ9xJHwkWH/MNRjgv8AQ23OtKI13bj6HiqPsN
         t8fYQNjsupZ6fybV4DdH9oVBHDLd0yC8tUEtRyw8FrFUBNSPs0cnKrA00h8qsoWkw1g/
         pdPippii+DzBVGIfkGK3qy2xfx0ueyBkE2VuAEO7KqLz0EKPntRBmmiRUpcaC6YWMwmK
         uR56f+e4oTBSzMtYkHPwNBCkUp8fL2rhCewW7Jp0E1YNWZpdzwIp9i76ZoHbdcLOzDyM
         dh1jI8t1XwMFJq16Beo57DAmboD4flLrsUt+1YtW4D3tkVOoPydYKZO+/CjUxMdZXZUb
         mVcA==
X-Gm-Message-State: AOAM531m138QERqcQTdZEshnZzDqxMyMEjr5xfdNl5Qn1JqAdc3b6Krn
        pjEvbRqBfs5yAqZpeUw32c0i1KKv2og=
X-Google-Smtp-Source: ABdhPJyYkhegl30L+1lL5DkDI/Rh7twroqIbQpDVFtxsOnOOKPlDn9cLg3jSKRvxWcGWP+TaBsstFA==
X-Received: by 2002:a1c:f30b:0:b0:37b:b5de:c804 with SMTP id q11-20020a1cf30b000000b0037bb5dec804mr27432722wmq.166.1647878898645;
        Mon, 21 Mar 2022 09:08:18 -0700 (PDT)
Received: from Ansuel-xps.localdomain (93-42-69-170.ip85.fastwebnet.it. [93.42.69.170])
        by smtp.googlemail.com with ESMTPSA id az19-20020a05600c601300b0038cadf3aa69sm2603864wmb.36.2022.03.21.09.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 09:08:18 -0700 (PDT)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v5 03/18] clk: qcom: gcc-ipq806x: add PXO_SRC in clk table
Date:   Mon, 21 Mar 2022 16:38:40 +0100
Message-Id: <20220321153855.12082-4-ansuelsmth@gmail.com>
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

PXO_SRC is currently defined in the gcc include and referenced in the
ipq8064 DTSI. Correctly provide a clk after gcc probe to fix kernel
panic if a driver starts to actually use it.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/clk/qcom/gcc-ipq806x.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/qcom/gcc-ipq806x.c b/drivers/clk/qcom/gcc-ipq806x.c
index 27f6d7626abb..7271d3afdc89 100644
--- a/drivers/clk/qcom/gcc-ipq806x.c
+++ b/drivers/clk/qcom/gcc-ipq806x.c
@@ -26,6 +26,8 @@
 #include "clk-hfpll.h"
 #include "reset.h"
 
+static struct clk_regmap pxo = { };
+
 static struct clk_pll pll0 = {
 	.l_reg = 0x30c4,
 	.m_reg = 0x30c8,
@@ -2754,6 +2756,7 @@ static struct clk_dyn_rcg ubi32_core2_src_clk = {
 };
 
 static struct clk_regmap *gcc_ipq806x_clks[] = {
+	[PXO_SRC] = NULL,
 	[PLL0] = &pll0.clkr,
 	[PLL0_VOTE] = &pll0_vote,
 	[PLL3] = &pll3.clkr,
@@ -3083,6 +3086,10 @@ static int gcc_ipq806x_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	clk = clk_get(dev, "pxo");
+	pxo.hw = *__clk_get_hw(clk);
+	gcc_ipq806x_clks[PXO_SRC] = &pxo;
+
 	regmap = dev_get_regmap(dev, NULL);
 	if (!regmap)
 		return -ENODEV;
-- 
2.34.1

