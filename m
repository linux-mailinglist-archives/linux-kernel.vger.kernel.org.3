Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2383E578315
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235207AbiGRNEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235204AbiGRNE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:04:27 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D89CE28;
        Mon, 18 Jul 2022 06:04:23 -0700 (PDT)
X-QQ-mid: bizesmtp91t1658149456tonqy3gs
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:04:15 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: e3eLb0+LQTlw9tctVu4zw/7QcaR2lQmQFRzWgW6Fw7bqIZ8Cr8YvHrzDUVKIA
        Ml+5IeX9x9lxO2QGaDOyKQtPYVZmj31efzlppnqSCwh+eHM6koAmEDNa5fhSwsgU1LRt1WR
        LjNAExggxbJz0PEvfYIukJ0vHQ2PZPsSb7D0saSrSxBWrnRzHl6/6TqyYpOeCLheWLRs/NH
        JNL6HkuCVfDCjrOKCmCQ+neUjEuRnlibNAAa+QTN0OAMjeWlRgI4r/bBF+/8vzQBzR4pEM3
        yl2dT7E2WOz2y3x1J1w9BVeeluE7Xlsj1eRBlD6vqVRnKQLGf9Qa4pHr/uYW4vjgiU/CTwO
        d9zFKkoFF/vApzP3k0QNmnSaIcVApHpBQdZvxw/ulEHQ5TTVNLXMu+ScoWfRNiJhQhSWxO5
        pPMZ+rJGBvU=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     daniel.lezcano@linaro.org
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] cpuidle: coupled: Fix comment typo
Date:   Fri, 15 Jul 2022 13:02:19 +0800
Message-Id: <20220715050219.24825-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `are' is duplicated in line 57, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/cpuidle/coupled.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/coupled.c b/drivers/cpuidle/coupled.c
index 74068742cef3..9acde71558d5 100644
--- a/drivers/cpuidle/coupled.c
+++ b/drivers/cpuidle/coupled.c
@@ -54,7 +54,7 @@
  * variable is not locked.  It is only written from the cpu that
  * it stores (or by the on/offlining cpu if that cpu is offline),
  * and only read after all the cpus are ready for the coupled idle
- * state are are no longer updating it.
+ * state are no longer updating it.
  *
  * Three atomic counters are used.  alive_count tracks the number
  * of cpus in the coupled set that are currently or soon will be
-- 
2.35.1

