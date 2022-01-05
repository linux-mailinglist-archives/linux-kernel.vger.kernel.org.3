Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824F1485034
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239001AbiAEJjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:39:24 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:46394 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238963AbiAEJjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:39:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V10dbcD_1641375556;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V10dbcD_1641375556)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 05 Jan 2022 17:39:17 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] cifs: Fix smb311_update_preauth_hash() kernel-doc comment
Date:   Wed,  5 Jan 2022 17:39:09 +0800
Message-Id: <20220105093909.71011-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @server in smb311_update_preauth_hash()
kernel-doc comment to remove warning found by running scripts/kernel-doc,
which is caused by using 'make W=1'.
fs/cifs/smb2misc.c:856: warning: Function parameter or member 'server' 
not described in 'smb311_update_preauth_hash'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/cifs/smb2misc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 396d5afa7cf1..b25623e3fe3d 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -847,6 +847,7 @@ smb2_handle_cancelled_mid(struct mid_q_entry *mid, struct TCP_Server_Info *serve
  * SMB2 header.
  *
  * @ses:	server session structure
+ * @server:	pointer to server info
  * @iov:	array containing the SMB request we will send to the server
  * @nvec:	number of array entries for the iov
  */
-- 
2.20.1.7.g153144c

