Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22FF6578354
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbiGRNNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiGRNNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:13:13 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D30B26ACA;
        Mon, 18 Jul 2022 06:13:08 -0700 (PDT)
X-QQ-mid: bizesmtp83t1658149984tre39sf5
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:13:02 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: K7bvHD+wU+ODPZ6pAxLdvXy8GCHKvgZj3DA0p4xcotsBo1o6j3aCtMgjF+2Xo
        c852LUKQzF6a/aejg22u+pILzPsDrhv99xFi+PENaxaj0LVb0aZ6Kq9UikH9dmjaCyJW4Ak
        QHgm1uAN1dd3fP4IO8qifPgmJrbrXAD7Mv7BL3yyW4AmS/dBVW1D5WIuiiAv9l2RIt+r2VX
        V+QAHpQsMyORsFvkU1KtUDxdyEjZjgpnXVz+E/gSR1D4zyhwfqEbeqIQn5e+wJ3lIiiAPGI
        zd+pGLUQ6LWwZTyKNigMyXne5pqT4oghZDPGdjx6/JkIX6LGY2jy82E7DWuPAQPJhcnf2lM
        rEXhIRtYLT2QY5yNZNEp02dfbzUUMmVqRbmJYEDKpxxgI82Hd8VTN5UlbT6aHIQD+nMF6MY
        Nbq2tePsS3g=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] power: supply: ab8500: Fix comment typo
Date:   Fri, 15 Jul 2022 13:11:00 +0800
Message-Id: <20220715051100.28207-1-wangborong@cdjrlc.com>
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

The double `the' is duplicated in line 1967, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/power/supply/ab8500_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/ab8500_charger.c b/drivers/power/supply/ab8500_charger.c
index d04d087caa50..9b479a1e5362 100644
--- a/drivers/power/supply/ab8500_charger.c
+++ b/drivers/power/supply/ab8500_charger.c
@@ -1964,7 +1964,7 @@ static int ab8500_charger_get_ext_psy_data(struct device *dev, void *data)
  * Due to a asic bug it is necessary to lower the input current to the vbus
  * charger when charging with at some specific levels. This issue is only valid
  * for below a certain battery voltage. This function makes sure that the
- * the allowed current limit isn't exceeded.
+ * allowed current limit isn't exceeded.
  */
 static void ab8500_charger_check_vbat_work(struct work_struct *work)
 {
-- 
2.35.1

