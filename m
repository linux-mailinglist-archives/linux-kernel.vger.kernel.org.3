Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD9A54E37D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377493AbiFPOfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiFPOfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:35:02 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A22120A5;
        Thu, 16 Jun 2022 07:34:56 -0700 (PDT)
X-QQ-mid: bizesmtp81t1655389959t3qlb9eq
Received: from localhost.localdomain ( [153.0.97.30])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 16 Jun 2022 22:32:35 +0800 (CST)
X-QQ-SSF: 01000000003000D0I000B00A0000000
X-QQ-FEAT: Lg5IqoGaTUjbL3PLubDSpHKxYIBIqmoLpF7UXENKR/1iBB8hXmAN+cf7h3TS/
        OeAqv0rj6e4J0JKyGqkzxSY2aNXDlXkZ1B5Y5OT6c6RETSBFI5LjQIYQAV1Oe6Spp/KACY2
        vf07GiwvhPWn2RDeYqCsenUR/cknqgs/m+vMdfgi4bGXB92hSGR4IIncxQ8GFbAPImJ6vHH
        HxHj8jCYFxyqNyszMObqHi4W4MfXPVrqOPUov3xnnnlD3VULvb6m/M7MES+qokod2KIw/Cq
        fHyabLHxRLRHytdtVukGtS0jxH2vG+bG3/Xj0vEwHdz1Ssc+lQeLh9AV5yTLCXqP538ztBd
        DpkLFJWFhLAWRb2qKw0Bk5csEYkrw==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     axboe@kernel.dk
Cc:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] drbd: Fix typo in comment
Date:   Thu, 16 Jun 2022 22:32:27 +0800
Message-Id: <20220616143227.4004-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'and'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/block/drbd/drbd_bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_bitmap.c b/drivers/block/drbd/drbd_bitmap.c
index 9e060e49b3f8..8afdde400e37 100644
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
2.36.1

