Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0485948FFD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 02:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiAQBLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 20:11:35 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47405 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233958AbiAQBLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 20:11:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V1ytjFC_1642381891;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V1ytjFC_1642381891)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 17 Jan 2022 09:11:32 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] cifs: clean up an inconsistent indenting
Date:   Mon, 17 Jan 2022 09:11:30 +0800
Message-Id: <20220117011130.84223-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:
fs/cifs/sess.c:1581 sess_auth_rawntlmssp_authenticate() warn:
inconsistent indenting

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/cifs/sess.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index d12490e12be5..96434cad0bfe 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -1574,7 +1574,7 @@ sess_auth_rawntlmssp_authenticate(struct sess_data *sess_data)
 out:
 	sess_free_buffer(sess_data);
 
-	 if (!rc)
+	if (!rc)
 		rc = sess_establish_session(sess_data);
 
 	/* Cleanup */
-- 
2.20.1.7.g153144c

