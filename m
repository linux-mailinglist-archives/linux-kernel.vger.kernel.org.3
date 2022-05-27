Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC0953625B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 14:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiE0MVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 08:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352607AbiE0MJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 08:09:23 -0400
X-Greylist: delayed 80 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 May 2022 04:58:21 PDT
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E4D3D1C3
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 04:58:21 -0700 (PDT)
X-QQ-mid: bizesmtp88t1653652609tvbfulci
Received: from localhost.localdomain ( [182.148.13.40])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 27 May 2022 19:56:45 +0800 (CST)
X-QQ-SSF: 01000000000000B0G000B00A0000000
X-QQ-FEAT: mwYX/W3keFESGNifi1nYC/0th6SFrIwTvvNHV916Q1pTnt6XcF2ArOW4UbxMm
        4WgbUTfpZIB4rWqyFHsIhckmYPNJU2PKOoj7BJL1RLmPX5AWl6dUaGuSYVKzgPzPAHIMJBB
        c0xY2WU9MGcbvrbxBx1g1ezWVfL0/EJFNbsoFNMIXlG5XRGX9gdZBxdWPjAQ7XsYBxOOrFf
        oSnpE9exotKlzy5CA1v47G6PP6A7HlIq6t+HewtuVzgsqfOjdYBF6iVvvezpd7BnPLkF7Rx
        pOtQFGIWL71HLcO8m7UM1ZOMwsWemE7NOAxnjpk6ILHCFxE0vW991AmuQ=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] ntfs: remove unnecessary returns
Date:   Fri, 27 May 2022 19:56:38 +0800
Message-Id: <20220527115638.9031-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Void function return statements are not generally useful

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 fs/ntfs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
index 4474adb393ca..b80bee4a8e5a 100644
--- a/fs/ntfs/inode.c
+++ b/fs/ntfs/inode.c
@@ -2277,7 +2277,6 @@ void ntfs_evict_big_inode(struct inode *vi)
 	BUG_ON(ni->page);
 	if (!atomic_dec_and_test(&ni->count))
 		BUG();
-	return;
 }
 
 /**
-- 
2.36.1

