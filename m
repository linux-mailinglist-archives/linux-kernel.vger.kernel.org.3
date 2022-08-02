Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7601E587BFE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 14:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiHBMJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 08:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232045AbiHBMJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 08:09:33 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FE04F1A7;
        Tue,  2 Aug 2022 05:09:28 -0700 (PDT)
X-QQ-mid: bizesmtp76t1659442158tl4ifvqu
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 20:09:17 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: ILHsT53NKPjzRmTit0GU3fJ5fD9yXL9AWZcz39KDuhH6s8obukrOWdzd3TQVs
        HOXAPrMJ/kaYifa88oGVNsNifXuBMKM6/x6eu9GvRMYgkzSPtQhglQgEMcoXxbvi91luWtA
        ahjQGAdVX4FTMWukuq0G7xkdNZATPQbsYzU0/1tOyRFwHfF8x66G6RdXQmdH05R6NsD1SLi
        fUY2nD77lg+G7p5qEHuXrAP1xYPwhiTQ7fjPGDm9h8mC80WBdurxqBLc7/Xdtd/UP9iSZSl
        5ky9N1MhHpKHJOzrH8irTHDPgi+ggIjMwy/X4ibv5lBAUbPYZKCzHmUkvylTtCDZWV4ZeDp
        +IlPulr2oe7CLHr4he3HXkh+AULUvOvNmqHUVCS/VWBopLVX2n7/DhJGlDjkg==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
        heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] USB: core: Fix comment typo
Date:   Wed,  3 Aug 2022 04:09:15 +0800
Message-Id: <20220802200915.6390-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RDNS_NONE,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/usb/core/usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/usb.c b/drivers/usb/core/usb.c
index 2f71636af6e1..11b15d7b357a 100644
--- a/drivers/usb/core/usb.c
+++ b/drivers/usb/core/usb.c
@@ -801,7 +801,7 @@ EXPORT_SYMBOL_GPL(usb_intf_get_dma_device);
  * is simple:
  *
  *	When locking both a device and its parent, always lock the
- *	the parent first.
+ *	parent first.
  */
 
 /**
-- 
2.35.1

