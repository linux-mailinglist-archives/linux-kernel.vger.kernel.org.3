Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BE0578324
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiGRNGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235297AbiGRNGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:06:11 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2279F27B13;
        Mon, 18 Jul 2022 06:05:57 -0700 (PDT)
X-QQ-mid: bizesmtp68t1658149514tg33k5r2
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:05:12 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: zK0nlCs2Z6F0XWAXfajss1mrNUJaV93pCFwwXEUP9sXFncfoo/WJ+14nRjR/S
        MuMytYRoBLnO7dnliRdC2Xd/nBedLfWWD+JrsYRaBfvwwp+mtTp4lo/RyEOY+31Prpy3k/B
        lcxlVUIUOePuwTN07rt+qVCO4A7KYAShEV1owhlqdfN05a8AwFZashVP+T/+i4z26yb1aTr
        ZrGMsibdhNkhNHhG17RiN92V5qaGJHAVFhBDw7WcZ2Up/5A8/0iSIGEGelXGHerjn+EgIbz
        NvX4g4vkC6TIt/V6ZuKKQBmYuGOUPZK2uh8iTBrXKwfNjLxTdtB78Xfn0hnwUeLY/Pw4Ord
        mH5s/RqYUBy+f0ArkqPIARcK4cwaZHJYDcdrDQPJ1P+nxXdGpSTtecmu7CTwDD98F7fmNJ1
        UjS0zLL6jG4=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     s.shtylyov@omp.ru, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ata: pata_macio: Fix comment typo
Date:   Fri, 15 Jul 2022 13:03:16 +0800
Message-Id: <20220715050316.25278-1-wangborong@cdjrlc.com>
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

The double `to' is duplicated in line 669, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/ata/pata_macio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index bfea2be2959a..076212fdb9d9 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -666,7 +666,7 @@ static u8 pata_macio_bmdma_status(struct ata_port *ap)
 	 * a multi-block transfer.
 	 *
 	 * - The dbdma fifo hasn't yet finished flushing to
-	 * to system memory when the disk interrupt occurs.
+	 * system memory when the disk interrupt occurs.
 	 *
 	 */
 
-- 
2.35.1

