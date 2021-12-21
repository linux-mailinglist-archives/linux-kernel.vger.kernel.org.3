Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 486B647BC82
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 10:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbhLUJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 04:07:20 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:36388 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233125AbhLUJHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 04:07:19 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V.K8OFf_1640077636;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V.K8OFf_1640077636)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 17:07:17 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     linkinjeon@kernel.org
Cc:     senozhatsky@chromium.org, sfrench@samba.org, hyc.lee@gmail.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/4] ksmbd: Fix buffer_check_err() kernel-doc comment
Date:   Tue, 21 Dec 2021 17:07:11 +0800
Message-Id: <20211221090714.122543-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @rsp_org in buffer_check_err() kernel-doc comment
to remove a warning found by running scripts/kernel-doc, which is caused 
by using 'make W=1'.
fs/ksmbd/smb2pdu.c:4028: warning: Function parameter or member 'rsp_org'
not described in 'buffer_check_err'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: cb4517201b8a ("ksmbd: remove smb2_buf_length in smb2_hdr")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ksmbd/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index b8b3a4c28b74..ee2bcd02d0d7 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -4018,6 +4018,7 @@ int smb2_query_dir(struct ksmbd_work *work)
  * buffer_check_err() - helper function to check buffer errors
  * @reqOutputBufferLength:	max buffer length expected in command response
  * @rsp:		query info response buffer contains output buffer length
+ * @rsp_org:    	base response buffer pointer in case of chained response
  * @infoclass_size:	query info class response buffer size
  *
  * Return:	0 on success, otherwise error
-- 
2.20.1.7.g153144c

