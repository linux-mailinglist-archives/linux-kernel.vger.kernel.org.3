Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B4457830B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbiGRND7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235125AbiGRND5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:03:57 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EAFBE6;
        Mon, 18 Jul 2022 06:03:51 -0700 (PDT)
X-QQ-mid: bizesmtp83t1658149423t9q2gbh3
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:03:41 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: lp8jUtqYSiD/WYpSvM5rrExMkkikEIZnm7KBPA5G3bpbL0hf8ZxD/x6I1wG6q
        ae1EKSRHKwF9G5gGnV5lplDVJsQ4cCWpyYEsTKQdal0SNx1DZ5ToHQOZoi7171E2frPkQR5
        aNUFDjXSW7rBkToVv8UkwI59Ubuml4Cpk/J6jllr6LOsr1OFfaJuDB5g0iBdS023aJUbP0O
        Uw42VhAyeTpe6AVaWz/6boWuK2/h5MLHK/pqeSObcu5mjC5lM+QGSPlRA9b+OXtHZMo/2vf
        Hx9SEwqMB22ulu7NP81seeEcYCzbzre7cg+NrjVVR93YL+0dJCJfJKNRDOvNn6jlv9sgUmj
        mofKXQr5sm8WBaFMGvXB5KwyEs3DxP6UgllRMFYs2wVgzdGA62PXeNrxSvxYJT2d8CBj5ta
        SFoBkQfVG8k=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] cpuidle: tegra: Fix comment typo
Date:   Fri, 15 Jul 2022 13:01:44 +0800
Message-Id: <20220715050144.24638-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `that' is duplicated in line 275, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/cpuidle/cpuidle-tegra.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 9845629aeb6d..93ed4b8e164a 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -272,7 +272,7 @@ static int tegra114_enter_s2idle(struct cpuidle_device *dev,
  * LP2 | C7	(CPU core power gating)
  * LP2 | CC6	(CPU cluster power gating)
  *
- * Note that that the older CPUIDLE driver versions didn't explicitly
+ * Note that the older CPUIDLE driver versions didn't explicitly
  * differentiate the LP2 states because these states either used the same
  * code path or because CC6 wasn't supported.
  */
-- 
2.35.1

