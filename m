Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7D5579DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242174AbiGSMyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238118AbiGSMxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:53:33 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B530D91CD4;
        Tue, 19 Jul 2022 05:20:57 -0700 (PDT)
X-QQ-mid: bizesmtp67t1658233253tqmac519
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:20:51 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: DoD8xN2rKozy7eJFzlPaHWPsUxHWUwNDxTWrfpazRFpt+uKhsC0TgieNkVJ0j
        LNsIl3D5UlzeehNGmb57CxoEzjQZH32gmw5MiWiU1JwHi+JHjQhVjprlSvLigYmqFmhCk2U
        KcaFfe/PF28Jr5JvdYFpY25U6CwPM4QfC1wJG1Y97wRT0dryV56YbDZXWNYRn81Vtbbk7Ar
        GCcAonoMgav7yzC5q3yAsLUwNiB2ZZxRbaOkLQFHgBGaFD/1e4lEJEqO32ApTzaK992ntPh
        q0II6GIe5n6PW3CzFaGy39Ee0nPqbgdazR4qzV/c0mGBoaXw0H651oj4kIWueorALlqgo29
        JUQc48hi3keTELeIJmipW9Z4VZtCYGBbhVu+F/meqGZlFytctYNhID9DotPrDEqlnDjmlqB
        Ws55ZvQkmSc=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     linux@roeck-us.net
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] watchdog: Fix comment typo
Date:   Sat, 16 Jul 2022 12:18:56 +0800
Message-Id: <20220716041856.34449-1-wangborong@cdjrlc.com>
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

The double `and' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/watchdog/booke_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/booke_wdt.c b/drivers/watchdog/booke_wdt.c
index 5e4dc1a0f2c6..75da5cd02615 100644
--- a/drivers/watchdog/booke_wdt.c
+++ b/drivers/watchdog/booke_wdt.c
@@ -74,7 +74,7 @@ static unsigned long long period_to_sec(unsigned int period)
 /*
  * This procedure will find the highest period which will give a timeout
  * greater than the one required. e.g. for a bus speed of 66666666 and
- * and a parameter of 2 secs, then this procedure will return a value of 38.
+ * a parameter of 2 secs, then this procedure will return a value of 38.
  */
 static unsigned int sec_to_period(unsigned int secs)
 {
-- 
2.35.1

