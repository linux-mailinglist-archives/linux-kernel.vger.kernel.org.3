Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724D44A2B57
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 03:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352252AbiA2Cwg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 21:52:36 -0500
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:50665 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352232AbiA2Cwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 21:52:34 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V34UhTY_1643424751;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V34UhTY_1643424751)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 29 Jan 2022 10:52:32 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     serge@hallyn.com
Cc:     jmorris@namei.org, john.johansen@canonical.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 3/3] apparmor: Fix some kernel-doc comments
Date:   Sat, 29 Jan 2022 10:52:29 +0800
Message-Id: <20220129025229.39663-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't use /** for non-kernel-doc comments and change function name
aa_mangle_name to mangle_name in kernel-doc comment to Remove some
warnings found by running scripts/kernel-doc, which is caused by
using 'make W=1'.

security/apparmor/apparmorfs.c:1503: warning: Cannot understand  *
 on line 1503 - I thought it was a doc line
security/apparmor/apparmorfs.c:1530: warning: Cannot understand  *
 on line 1530 - I thought it was a doc line
security/apparmor/apparmorfs.c:1892: warning: Cannot understand  *
 on line 1892 - I thought it was a doc line
security/apparmor/apparmorfs.c:108: warning: expecting prototype for
aa_mangle_name(). Prototype was for mangle_name() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 security/apparmor/apparmorfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index 15efe4076fc4..4d7df859542d 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -98,7 +98,7 @@ static struct rawdata_f_data *rawdata_f_data_alloc(size_t size)
 #endif
 
 /**
- * aa_mangle_name - mangle a profile name to std profile layout form
+ * mangle_name - mangle a profile name to std profile layout form
  * @name: profile name to mangle  (NOT NULL)
  * @target: buffer to store mangled name, same length as @name (MAYBE NULL)
  *
@@ -1499,7 +1499,7 @@ int __aa_fs_create_rawdata(struct aa_ns *ns, struct aa_loaddata *rawdata)
 
 /** fns to setup dynamic per profile/namespace files **/
 
-/**
+/*
  *
  * Requires: @profile->ns->lock held
  */
@@ -1526,7 +1526,7 @@ void __aafs_profile_rmdir(struct aa_profile *profile)
 	}
 }
 
-/**
+/*
  *
  * Requires: @old->ns->lock held
  */
@@ -1888,7 +1888,7 @@ static void __aa_fs_list_remove_rawdata(struct aa_ns *ns)
 		__aa_fs_remove_rawdata(ent);
 }
 
-/**
+/*
  *
  * Requires: @ns->lock held
  */
-- 
2.20.1.7.g153144c

