Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001C755521B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377246AbiFVROg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376884AbiFVROa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:14:30 -0400
Received: from smtpbg.qq.com (smtpbg138.qq.com [106.55.201.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D450F181;
        Wed, 22 Jun 2022 10:14:22 -0700 (PDT)
X-QQ-mid: bizesmtp77t1655918057thu6uhkw
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 01:14:12 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000B00A0000000
X-QQ-FEAT: Mx1dxJbW4IXP7rlgheUkzUkLNtOUD44MqeChcj6eQrJrKN5C/vCDW5O5zzKa8
        IkJ9lzekdTPreXpN5Hrc+ImgAyGXTyUSW6Z8VmY3afiJpzxyC0Ycmvrrs+I76lKAXFZ6x0N
        2p+XklaYYojNrEEdREOdaeqS6ViMY+p3Ll6s5Zh0DI6AjNELLW3NnvMMbEKQh/Yld2Q/Afe
        rt2Q5iMO+FlqvF6myLATFkB7DKK+nxLhO32lkSTJLEEWNsO+2+vse8qaBIgldC9EA0HE8a+
        yIw7K2e0koug1UM94m5pL+qy+yV1Bgu7KPegYsjabuqGH6ws6BVU8e3OgPXdA0yhQc8pWh8
        NDVd1zf41ICLwQd+34=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     sre@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] power: supply: ab8500_fg: drop unexpected word 'is' in the comments
Date:   Thu, 23 Jun 2022 01:14:10 +0800
Message-Id: <20220622171410.5467-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam10
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'is' in the comments that need to be dropped

file - drivers/power/supply/ab8500_fg.c
line - 415

* The capacity filter is is reset to zero.

changed to:

* The capacity filter is reset to zero.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/power/supply/ab8500_fg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 4339fa9ff009..12eafeca83e1 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -412,7 +412,7 @@ static int ab8500_fg_add_cap_sample(struct ab8500_fg *di, int sample)
  * ab8500_fg_clear_cap_samples() - Clear average filter
  * @di:		pointer to the ab8500_fg structure
  *
- * The capacity filter is is reset to zero.
+ * The capacity filter is reset to zero.
  */
 static void ab8500_fg_clear_cap_samples(struct ab8500_fg *di)
 {
-- 
2.17.1

