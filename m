Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33E447BC86
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhLUJHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:07:30 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:49310 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236117AbhLUJH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:07:27 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V.K8OHG_1640077643;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V.K8OHG_1640077643)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 17:07:24 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     linkinjeon@kernel.org
Cc:     senozhatsky@chromium.org, sfrench@samba.org, hyc.lee@gmail.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 3/4] ksmbd: Delete an invalid arguement description in smb2_populate_readdir_entry()
Date:   Tue, 21 Dec 2021 17:07:13 +0800
Message-Id: <20211221090714.122543-3-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20211221090714.122543-1-yang.lee@linux.alibaba.com>
References: <20211221090714.122543-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A warning is reported because an invalid arguement description, it is found by
running scripts/kernel-doc, which is caused by using 'make W=1'.
fs/ksmbd/smb2pdu.c:3406: warning: Excess function parameter 'user_ns'
description in 'smb2_populate_readdir_entry'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: 475d6f98804c ("ksmbd: fix translation in smb2_populate_readdir_entry()")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ksmbd/smb2pdu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 2d55a186b825..1bb413537239 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3392,7 +3392,6 @@ static int dentry_name(struct ksmbd_dir_info *d_info, int info_level)
  * @conn:	connection instance
  * @info_level:	smb information level
  * @d_info:	structure included variables for query dir
- * @user_ns:	user namespace
  * @ksmbd_kstat:	ksmbd wrapper of dirent stat information
  *
  * if directory has many entries, find first can't read it fully.
-- 
2.20.1.7.g153144c

