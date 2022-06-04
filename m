Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FA953D735
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbiFDOZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Jun 2022 10:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiFDOY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jun 2022 10:24:57 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345F014004
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jun 2022 07:24:52 -0700 (PDT)
X-QQ-mid: bizesmtp68t1654352617t4yqybdr
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Jun 2022 22:23:28 +0800 (CST)
X-QQ-SSF: 01000000002000B0G000B00A0000000
X-QQ-FEAT: W6nSwEQQYT+fJeeHxWyLLCrAI6fpDvAZJ+0LiDPEuL6vJzOmX4Cf9TAfjSTBp
        jNt8DSLip+ocrZuTQHE2NocktaU0aaEtA4VlG878L/SVsQq4ulQttRS7G+qfQs61hlcPloo
        t3s6jGCxhr6XuM8sBpvPhyb0gsUQ6JlBcxpFyaFLXM4iG7ZKkRokyjZSMGqbtkmKivS8KTN
        ubIzfdj4GGBe89z2MJuXRnMMr86o/nTriycDwYQv23lsTExii1UHw4yOCqiRukNRTxwhikw
        cDg+fZH984cOV+u+88WPfUUFqNGDPLL7tZUaywA5TDFeT0rlPQ2hjl+0fbqIHi7CC+sAdUT
        VWmIsdSAaiKoL39qYg=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     agross@kernel.org
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] soc: qcom: llcc: Fix syntax errors in comments
Date:   Sat,  4 Jun 2022 22:23:27 +0800
Message-Id: <20220604142327.14714-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_XBL,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'and'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/soc/qcom/llcc-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 4b143cf7b4ce..38d7296315a2 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -382,7 +382,7 @@ static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
  * llcc_slice_getd - get llcc slice descriptor
  * @uid: usecase_id for the client
  *
- * A pointer to llcc slice descriptor will be returned on success and
+ * A pointer to llcc slice descriptor will be returned on success
  * and error pointer is returned on failure
  */
 struct llcc_slice_desc *llcc_slice_getd(u32 uid)
-- 
2.36.1

