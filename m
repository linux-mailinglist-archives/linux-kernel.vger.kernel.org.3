Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FBA5471804
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 04:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbhLLDbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 22:31:46 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:23778 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231739AbhLLDbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 22:31:46 -0500
X-QQ-mid: bizesmtp44t1639279893tyegqbh1
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sun, 12 Dec 2021 11:31:31 +0800 (CST)
X-QQ-SSF: 01000000002000D0H000B00A0000000
X-QQ-FEAT: 0Eq+cbWb7Ry7/jAxm8gwmVC9mbJg0mY/635Z9qzeOdBngML0iVXek9d6sxMvW
        3V4nN1DD90wC95P57Hs+flcHRQ+JVxvm2nN55Wo3/n4lH0cMED07ziKywywxBpNYNOBK4PS
        cJjt5LFfIVkRaSPTFM7J++Pa2Ls562mt5Pc26+IJhlxDSfBPzdi0HP3sVZCYZsiRU6/wCXl
        XJhZGgQ88FBfu4smuc6Kd4v0fYNorSPa99CFKmZSJ1jM5RWkHiAcZJ548ojEQ+a91uhR6vn
        l1aqpCcrMYio5YbkHe55kcKa2kA+xA2eFgHz0xqAtGsttwwR0Sp0qS9gQUJdZFbNeyKUXC7
        l4+Z0RPOZbfYzN1HgipxAxh2JkKkZFBCvppcnOv
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] cpuidle: tegra: fix typo in a comment
Date:   Sun, 12 Dec 2021 11:31:30 +0800
Message-Id: <20211212033130.64032-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `that' in the comment in line 275 is repeated. Remove one
of them from the comment.

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
2.34.1

