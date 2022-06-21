Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026F7552F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 11:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347303AbiFUJtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 05:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiFUJts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 05:49:48 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EAF27B22;
        Tue, 21 Jun 2022 02:49:42 -0700 (PDT)
X-QQ-mid: bizesmtp75t1655804969tsjh4bcg
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 17:49:25 +0800 (CST)
X-QQ-SSF: 0100000000700030B000B00A0000000
X-QQ-FEAT: FXvDfBZI5O4XzwHJcwonh32Ii7bk32q2ji7yURaEycrIRNPucCS1KFehgDMuS
        2VcTDoMN/PcwsPpa4H9835AWoeG37jbP6YExaarvi3XPI00wFqxYlMcU6f/KcKFlqeSVJcg
        JopVkrb1mb+uv61/FiN4cGZPphUuuWwZPp+wHaPuh0aWyxpNawhNp+oyjFb+AsVkYkRJF2w
        ZCdU1Reup/RREOL8bY9TblpgfvQUR6ZBEvYOQ50IBzgh6GeiXvQHizy88zUu/6rA2tz445j
        U+J/liCt866/SSJxOLFY7GY2SYGdZeJi1v4Fm7O9CfHdTPwYxwKl6mts7lmx53Zbe56Bf15
        TBgatPX46/PJaxCPr4GKG/viQQW/w==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiangjian@cdjrlc.com
Subject: [PATCH] firmware: qcom_scm: drop unexpected word "the"
Date:   Tue, 21 Jun 2022 17:49:24 +0800
Message-Id: <20220621094924.83135-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped

> * will cause the the boot stages to enter download mode, unless

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/firmware/qcom_scm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 3163660fa8e2..4623d2919ed0 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -1337,7 +1337,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
 
 	/*
 	 * If requested enable "download mode", from this point on warmboot
-	 * will cause the the boot stages to enter download mode, unless
+	 * will cause the boot stages to enter download mode, unless
 	 * disabled below by a clean shutdown/reboot.
 	 */
 	if (download_mode)
-- 
2.17.1

