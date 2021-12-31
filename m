Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3EB4821F3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 05:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242672AbhLaEU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 23:20:56 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:57327 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231305AbhLaEUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 23:20:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V0Ofr7J_1640924452;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V0Ofr7J_1640924452)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 31 Dec 2021 12:20:53 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rpeterso@redhat.com
Cc:     agruenba@redhat.com, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] gfs2: Fix __gfs2_holder_init() kernel-doc comment
Date:   Fri, 31 Dec 2021 12:20:51 +0800
Message-Id: <20211231042051.21736-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @ip to remove warning found
by running scripts/kernel-doc, which is caused by
using 'make W=1'.
fs/gfs2/glock.c:1258: warning: Function parameter or member 'ip' not
described in '__gfs2_holder_init'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/gfs2/glock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/gfs2/glock.c b/fs/gfs2/glock.c
index b7ab8430333c..2f3f91e518de 100644
--- a/fs/gfs2/glock.c
+++ b/fs/gfs2/glock.c
@@ -1250,6 +1250,9 @@ int gfs2_glock_get(struct gfs2_sbd *sdp, u64 number,
  * @state: the state we're requesting
  * @flags: the modifier flags
  * @gh: the holder structure
+ * @ip: Get the return address of the current function, that is, the function
+ *	is called by another function, and then when the function is finished,
+ *	the return address is the address at that time.
  *
  */
 
-- 
2.20.1.7.g153144c

