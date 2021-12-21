Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E19747BC84
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236116AbhLUJH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:07:26 -0500
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:58732 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232598AbhLUJHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:07:24 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R851e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V.KCYcP_1640077641;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V.KCYcP_1640077641)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 17:07:21 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     linkinjeon@kernel.org
Cc:     senozhatsky@chromium.org, sfrench@samba.org, hyc.lee@gmail.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/4] ksmbd: Fix smb2_set_info_file() kernel-doc comment
Date:   Tue, 21 Dec 2021 17:07:12 +0800
Message-Id: <20211221090714.122543-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20211221090714.122543-1-yang.lee@linux.alibaba.com>
References: <20211221090714.122543-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix argument list that the kdoc format and script verified in
smb2_set_info_file().

The warnings were found by running scripts/kernel-doc, which is
caused by using 'make W=1'.
fs/ksmbd/smb2pdu.c:5862: warning: Function parameter or member 'req' not
described in 'smb2_set_info_file'
fs/ksmbd/smb2pdu.c:5862: warning: Excess function parameter 'info_class'
description in 'smb2_set_info_file'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 9496e268e3af ("ksmbd: add request buffer validation in smb2_set_info")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ksmbd/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index ee2bcd02d0d7..2d55a186b825 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5850,7 +5850,7 @@ static int set_file_mode_info(struct ksmbd_file *fp,
  * smb2_set_info_file() - handler for smb2 set info command
  * @work:	smb work containing set info command buffer
  * @fp:		ksmbd_file pointer
- * @info_class:	smb2 set info class
+ * @req:        request buffer validation
  * @share:	ksmbd_share_config pointer
  *
  * Return:	0 on success, otherwise error
-- 
2.20.1.7.g153144c

