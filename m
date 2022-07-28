Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F35583AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbiG1JHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbiG1JHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:07:44 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 50524655A4;
        Thu, 28 Jul 2022 02:07:43 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 7A40C1E80D72;
        Thu, 28 Jul 2022 17:07:43 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MdfWvtsK_BEc; Thu, 28 Jul 2022 17:07:40 +0800 (CST)
Received: from localhost.localdomain.localdomain (unknown [219.141.250.2])
        (Authenticated sender: xupengfei@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 716AA1E80CF5;
        Thu, 28 Jul 2022 17:07:40 +0800 (CST)
From:   XU pengfei <xupengfei@nfschina.com>
To:     abel.vesa@linaro.org
Cc:     Kernel@nfschina.com, agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, xupengfei@nfschina.com
Subject: [PATCH v2] clk/qcom/gcc-sm6350: Remove unnecessary semicolon
Date:   Thu, 28 Jul 2022 17:07:20 +0800
Message-Id: <20220728090719.3056-1-xupengfei@nfschina.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <Yt5FAJiEv0WWuDNV@linaro.org>
References: <Yt5FAJiEv0WWuDNV@linaro.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary semicolon after qcom_cc_really_probe call.

Signed-off-by: XU pengfei <xupengfei@nfschina.com>
---
 drivers/clk/qcom/gcc-sm6350.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
index a4f7fba70393..69412400efa4 100644
--- a/drivers/clk/qcom/gcc-sm6350.c
+++ b/drivers/clk/qcom/gcc-sm6350.c
@@ -2558,7 +2558,7 @@ static int gcc_sm6350_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return qcom_cc_really_probe(pdev, &gcc_sm6350_desc, regmap);;
+	return qcom_cc_really_probe(pdev, &gcc_sm6350_desc, regmap);
 }
 
 static struct platform_driver gcc_sm6350_driver = {
-- 
2.18.2

