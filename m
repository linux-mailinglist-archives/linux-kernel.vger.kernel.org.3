Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A483546D58D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 15:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhLHOYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 09:24:48 -0500
Received: from smtpbg127.qq.com ([109.244.180.96]:62442 "EHLO smtpbg.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229529AbhLHOYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 09:24:48 -0500
X-QQ-mid: bizesmtp53t1638973249t7cnjliu
Received: from wangx.lan (unknown [218.88.126.113])
        by esmtp6.qq.com (ESMTP) with 
        id ; Wed, 08 Dec 2021 22:20:39 +0800 (CST)
X-QQ-SSF: 0100000000600050C000B00A0000000
X-QQ-FEAT: jfdGVjI73+RzttaNeIGq4XTV4t3YtMZEgoQtAyv4pYhgGVzKk6flJM7ArGhpC
        /YCSwrRkO8dMOhiEloW5Dbewomb5n8PnQ4u4LFoxc0++hlkv7u0rSmXNtk/muu5Px49C5Ip
        L47fnuUx0pUFyQA99Ua1nmghGnmHgmh3JDIm3SA+Ff1hC6xxJGW1IwTml+2cO9+YD/7ezNG
        nOS+4XSLJmw8/dVooWmGYkGP7ejE4okHpZsOCh2mJevYxdmd+UZPfxobfrMELc1WccTHyij
        dk5V3L3y8qDK13gBoe3XjMzGRB45+RbUSV8W3XglHacleVW1VEggMshTywOHSIBqxoOyw9K
        vItedZS
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH v2] tty/ldsem: Fix syntax errors in comments
Date:   Wed,  8 Dec 2021 22:20:36 +0800
Message-Id: <20211208142036.7956-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'are'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---

Changes since v1
* Change commit log

 drivers/tty/tty_ldsem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/tty_ldsem.c b/drivers/tty/tty_ldsem.c
index ce8291053af3..3be428c16260 100644
--- a/drivers/tty/tty_ldsem.c
+++ b/drivers/tty/tty_ldsem.c
@@ -163,7 +163,7 @@ down_read_failed(struct ld_semaphore *sem, long count, long timeout)
 
 	/*
 	 * Try to reverse the lock attempt but if the count has changed
-	 * so that reversing fails, check if there are are no waiters,
+	 * so that reversing fails, check if there are no waiters,
 	 * and early-out if not
 	 */
 	do {
-- 
2.20.1

