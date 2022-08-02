Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0064C587BE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236514AbiHBMA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiHBMAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:00:25 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82F69FCB;
        Tue,  2 Aug 2022 05:00:20 -0700 (PDT)
X-QQ-mid: bizesmtp69t1659441611tje44xmm
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:00:09 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: XBN7tc9DADIKwFDRMhjwgYDGxT/7Eqfc4EJtctmAPm/id6XC9fhdQYD0p2L7L
        hGAXVEegul9Do+46IrWtcM5AGFgGh7L3nNe8QH/DGGEN4QXcQg+EJDa7/N1hvuJ8gjNi96p
        nEXrFeSkpSC2c7jnKFONv/FLXs23spIJCr4i6N3KqKoZJMJBO2D8m2SYzYfubsRur63gM8N
        u9l51F6BlOsiN1kN1xi4FupUnaGKrGvvooz6J9d0XIRh/IRaUZtTeAY+AsRyfg8xHfZeRIT
        VX/B1RZLTDbs/2PK58xZVP8e7aPqDaqtANp3cSthg6MPqmFnsjvetqlsZAgyJ0Cd0dIF08e
        BhVQINOMPElj/zwH2twoCStEhfmERfR0OEA5d60glGHGbJc7Jj3Wmgu2CnuUQ==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     ngupta@vflare.org
Cc:     minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] block/zram: Fix comment typo
Date:   Wed,  3 Aug 2022 04:00:07 +0800
Message-Id: <20220802200007.4866-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_MSPIKE_H2,RDNS_DYNAMIC,SPF_PASS,T_SPF_HELO_TEMPERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `range' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 92cb929a45b7..0db84d3fc585 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -174,7 +174,7 @@ static inline bool valid_io_request(struct zram *zram,
 
 	end = start + (size >> SECTOR_SHIFT);
 	bound = zram->disksize >> SECTOR_SHIFT;
-	/* out of range range */
+	/* out of range */
 	if (unlikely(start >= bound || end > bound || start > end))
 		return false;
 
-- 
2.35.1

