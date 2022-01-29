Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757D84A2B50
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 03:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352221AbiA2CvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 21:51:08 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:60292 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238931AbiA2CvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 21:51:06 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V34uRnT_1643424663;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V34uRnT_1643424663)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Jan 2022 10:51:03 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     serge@hallyn.com
Cc:     jmorris@namei.org, john.johansen@canonical.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/3] apparmor: Fix match_mnt_path_str() and match_mnt() kernel-doc comment
Date:   Sat, 29 Jan 2022 10:50:59 +0800
Message-Id: <20220129025101.38355-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a spelling problem and change @mntpath to @path to remove warnings
found by running scripts/kernel-doc, which is caused by using 'make W=1'.

security/apparmor/mount.c:321: warning: Function parameter or member
'devname' not described in 'match_mnt_path_str'
security/apparmor/mount.c:321: warning: Excess function parameter
'devnme' description in 'match_mnt_path_str'
security/apparmor/mount.c:377: warning: Function parameter or member
'path' not described in 'match_mnt'
security/apparmor/mount.c:377: warning: Excess function parameter
'mntpath' description in 'match_mnt'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/mount.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/mount.c b/security/apparmor/mount.c
index 23aafe68d49a..5cc5de062fc8 100644
--- a/security/apparmor/mount.c
+++ b/security/apparmor/mount.c
@@ -304,7 +304,7 @@ static int path_flags(struct aa_profile *profile, const struct path *path)
  * @profile: the confining profile
  * @mntpath: for the mntpnt (NOT NULL)
  * @buffer: buffer to be used to lookup mntpath
- * @devnme: string for the devname/src_name (MAY BE NULL OR ERRPTR)
+ * @devname: string for the devname/src_name (MAY BE NULL OR ERRPTR)
  * @type: string for the dev type (MAYBE NULL)
  * @flags: mount flags to match
  * @data: fs mount data (MAYBE NULL)
@@ -359,7 +359,7 @@ static int match_mnt_path_str(struct aa_profile *profile,
 /**
  * match_mnt - handle path matching for mount
  * @profile: the confining profile
- * @mntpath: for the mntpnt (NOT NULL)
+ * @path: for the mntpnt (NOT NULL)
  * @buffer: buffer to be used to lookup mntpath
  * @devpath: path devname/src_name (MAYBE NULL)
  * @devbuffer: buffer to be used to lookup devname/src_name
-- 
2.20.1.7.g153144c

