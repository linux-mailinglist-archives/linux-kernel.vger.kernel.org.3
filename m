Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6486471312
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 10:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhLKJGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 04:06:51 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:38400 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229455AbhLKJGu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 04:06:50 -0500
X-QQ-mid: bizesmtp51t1639213589tbwl2pau
Received: from localhost.localdomain (unknown [182.132.179.213])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 11 Dec 2021 17:06:28 +0800 (CST)
X-QQ-SSF: 01000000008000D0H000B00A0000000
X-QQ-FEAT: ie7/mGF6PjxdogPfbWWDX7lv3icigX8bJipwRduE0TbOlEwBUh91eIai5nHA/
        baJiQkpR7urnnn9pVudrq6sQN+FzDVIPvEtWWtLZW6+DnccHf5ik/lohFkMizzz1kSXupFw
        TFSZk7WEjCoOehTH8iYTK+qCmMFfS8oi9MnKU8sGV2yUoNfSarJQUg4iSfDXEiPm//OuUY0
        Do8i4LLGf9piyDrRqfQnaEblHGM3SMkOLWd+SOFsxRAmOYTnrfJNUow4K95Bdc0KrXstTaR
        RbF4MhEH1yAngWvb6d1MveRDVSiLQNVg2aZqpGdkRwjKdLBH253bzOdHfVcgxw6ertapLct
        iFiRNJr2uhQL8F5gk1llZ0FWH9jeV97IMp8F6O+
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] soc: qcom: rpmh-rsc: Fix typo in a comment
Date:   Sat, 11 Dec 2021 17:06:26 +0800
Message-Id: <20211211090626.248801-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `for' in the comment in line 694 is repeated. Remove one
of them from the comment.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/soc/qcom/rpmh-rsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 3a12a482f6b2..01c2f50cb97e 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -691,7 +691,7 @@ static int find_slots(struct tcs_group *tcs, const struct tcs_request *msg,
  * @drv: The controller.
  * @msg: The data to be written to the controller.
  *
- * This should only be called for for sleep/wake state, never active-only
+ * This should only be called for sleep/wake state, never active-only
  * state.
  *
  * The caller must ensure that no other RPMH actions are happening and the
-- 
2.34.1


