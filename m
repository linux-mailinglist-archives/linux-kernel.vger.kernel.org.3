Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78E92468C12
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 17:17:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235858AbhLEQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 11:20:45 -0500
Received: from smtpbg587.qq.com ([113.96.223.105]:43397 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231614AbhLEQUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 11:20:44 -0500
X-QQ-mid: bizesmtp34t1638720953t3qa4y1j
Received: from wangx.lan (unknown [218.88.126.113])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 06 Dec 2021 00:15:46 +0800 (CST)
X-QQ-SSF: 0100000000600050B000B00A0000000
X-QQ-FEAT: 947M1SYlfBs+sIemuYZRd55PWpL3RGGvx8Hrc8xPNZeOkQZTIJuC1/92pKhIg
        +TfnydM/Y4tFjl3DJxV0YzmDZgblZdjUqvN438xOn0qT9V3Z9KpnOoAGkxcAmM0TJVujQBk
        yw8tgtwpHYHTd5MGRDu8oZvtZupULsPJSRbGhbfHCgV8pQtVOo1iLtYS2yt4GvZLcvOI2JB
        fHzlnYqxpMZZPbTcNXOiqq1ZV49SIjIsM8M8cRC1XFcqyE+Y375Cc4LiqJwzw8SlVS6E05u
        c6KtvfWq/gnUB/f2N7j/vymhClx+YOyaTOr168cYPNB54WgBnUTJglL9UHPZYnHdB5yg==
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     gregkh@linuxfoundation.org
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] tty/ldsem: Fix syntax errors in comments
Date:   Mon,  6 Dec 2021 00:15:44 +0800
Message-Id: <20211205161544.12104-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam3
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'are'

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
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

