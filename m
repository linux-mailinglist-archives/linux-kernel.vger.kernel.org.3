Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD3E579D83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbiGSMwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241766AbiGSMuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 08:50:18 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97C28FD64;
        Tue, 19 Jul 2022 05:19:59 -0700 (PDT)
X-QQ-mid: bizesmtp84t1658232992tcyg0vfy
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 20:16:30 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: 4rCmCcmdMHdi35qznvqNxxvnEWdSiRmmST1u+A2o6peXFM/RSPwShRDt80gHA
        y5DVAxaORbKKdxdxy0RXOWPAkhqBXotrr90r8Qf4Fi65bbCAqQWvR+03tN+lHkZi7TSZNv9
        YoX+BR/arF0CSkVM85USAgAIDuf0wu4iiLQdvhsq4Ocr/CJpCJofS+HLnDok5GJZIB1rDqi
        J6rFXe2FhiUBBzfDsiDdyKVIREWrAb0bSisepF97ZleNonM52r0awyxf0NnR5e1YOOBqY1N
        v3oRZHhM6xhmec09WOtHr94pWHAVP9DKk/Ty1NJKxSCEDjcfjcqjrQSma+V3qWnFgCzR5Sl
        y6VHSuQJNuBjinDlb9d4ay4X9oLx2CXW8D7CFc8MQzb1KZKp3V2Y1HdEIWxfmHri3jJ+1RU
        4xvtfeMJsrs=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     axboe@kernel.dk
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] block/drbd: Fix comment typo
Date:   Sat, 16 Jul 2022 12:14:34 +0800
Message-Id: <20220716041434.33148-1-wangborong@cdjrlc.com>
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

The double `and' is duplicated in line 89, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/block/drbd/drbd_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 7d9db33363de..736416186c2f 100644
--- a/drivers/block/drbd/drbd_bitmap.c
+++ b/drivers/block/drbd/drbd_bitmap.c
@@ -86,7 +86,7 @@ struct drbd_bitmap {
 
 	/* exclusively to be used by __al_write_transaction(),
 	 * drbd_bm_mark_for_writeout() and
-	 * and drbd_bm_write_hinted() -> bm_rw() called from there.
+	 * drbd_bm_write_hinted() -> bm_rw() called from there.
 	 */
 	unsigned int n_bitmap_hints;
 	unsigned int al_bitmap_hints[AL_UPDATES_PER_TRANSACTION];
-- 
2.35.1

