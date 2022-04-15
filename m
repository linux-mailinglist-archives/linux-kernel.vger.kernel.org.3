Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F4D502F70
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 21:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349483AbiDOUA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiDOUAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:00:55 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F55F65D39;
        Fri, 15 Apr 2022 12:58:25 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 4ACDECE283;
        Fri, 15 Apr 2022 19:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1650052674; bh=XR3x02W34XEAuW/nfCwO3TJ6os9cCNDFJLW+eipqfJk=;
        h=From:To:Cc:Subject:Date;
        b=KzV0G2K173sA7rYKVQ8gxJIUYdmGv8xJUNnqaoVp/20TP/5Pdf5YKJnt30IuYVb9K
         EY3z4L9U++QcBuFK62/1erknrM8I+708ltcZIkM3mbhvOoN/A0fv7MzzqAy/gCY+O6
         BYLsmobq7l017qdsYIbf4cOetSKsMLXdJ7F+7Ltw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: qcom: socinfo: Sort out 8974PRO names
Date:   Fri, 15 Apr 2022 21:54:49 +0200
Message-Id: <20220415195449.617040-1-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        FROM_SUSPICIOUS_NTLD_FP,PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8974PRO is commonly used for referring to Snapdragon 801, compared to
MSM8974 which is Snapdragon 800.

The Snapdragon 801 has three variants with different clock speeds, with
the -AA, -AB and -AC suffix.

Adjust the names in socinfo to reflect this.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 drivers/soc/qcom/socinfo.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index 146ff934fdc8..cee579a267a6 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -236,24 +236,24 @@ static const struct soc_id soc_id[] = {
 	{ 184, "APQ8074" },
 	{ 185, "MSM8274" },
 	{ 186, "MSM8674" },
-	{ 194, "MSM8974PRO" },
+	{ 194, "MSM8974PRO-AC" },
 	{ 198, "MSM8126" },
 	{ 199, "APQ8026" },
 	{ 200, "MSM8926" },
 	{ 205, "MSM8326" },
 	{ 206, "MSM8916" },
 	{ 207, "MSM8994" },
-	{ 208, "APQ8074-AA" },
-	{ 209, "APQ8074-AB" },
-	{ 210, "APQ8074PRO" },
-	{ 211, "MSM8274-AA" },
-	{ 212, "MSM8274-AB" },
-	{ 213, "MSM8274PRO" },
-	{ 214, "MSM8674-AA" },
-	{ 215, "MSM8674-AB" },
-	{ 216, "MSM8674PRO" },
-	{ 217, "MSM8974-AA" },
-	{ 218, "MSM8974-AB" },
+	{ 208, "APQ8074PRO-AA" },
+	{ 209, "APQ8074PRO-AB" },
+	{ 210, "APQ8074PRO-AC" },
+	{ 211, "MSM8274PRO-AA" },
+	{ 212, "MSM8274PRO-AB" },
+	{ 213, "MSM8274PRO-AC" },
+	{ 214, "MSM8674PRO-AA" },
+	{ 215, "MSM8674PRO-AB" },
+	{ 216, "MSM8674PRO-AC" },
+	{ 217, "MSM8974PRO-AA" },
+	{ 218, "MSM8974PRO-AB" },
 	{ 219, "APQ8028" },
 	{ 220, "MSM8128" },
 	{ 221, "MSM8228" },
-- 
2.35.1

