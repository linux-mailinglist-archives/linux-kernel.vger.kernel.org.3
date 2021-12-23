Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 053CD47DE25
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 04:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346252AbhLWDvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 22:51:06 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:30167 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242010AbhLWDvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 22:51:05 -0500
Received: from kwepemi500005.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4JKGQ150Qqz8vnq;
        Thu, 23 Dec 2021 11:48:41 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500005.china.huawei.com (7.221.188.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 11:51:02 +0800
Received: from [127.0.0.1] (10.174.177.249) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Thu, 23 Dec
 2021 11:51:02 +0800
To:     <corbet@lwn.net>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>, <axboe@kernel.dk>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
CC:     <linux-doc@vger.kernel.org>, linfeilong <linfeilong@huawei.com>
Subject: [PATCH] doc: fs: remove bdev_try_to_free_page related doc
Message-ID: <c45e6351-b0f8-3410-787e-02c6aeb3efe6@huawei.com>
Date:   Thu, 23 Dec 2021 11:51:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.249]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


In commit acc6100d3ffa ("fs: remove bdev_try_to_free_page callback"),
bdev_try_to_free_page has been removed.

We should remove its doc.

Signed-off-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
---
 Documentation/filesystems/locking.rst | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index d36fe79167b3..3f9b1497ebb8 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -169,7 +169,6 @@ prototypes::
 	int (*show_options)(struct seq_file *, struct dentry *);
 	ssize_t (*quota_read)(struct super_block *, int, char *, size_t, loff_t);
 	ssize_t (*quota_write)(struct super_block *, int, const char *, size_t, loff_t);
-	int (*bdev_try_to_free_page)(struct super_block*, struct page*, gfp_t);

 locking rules:
 	All may block [not true, see below]
@@ -194,7 +193,6 @@ umount_begin:		no
 show_options:		no		(namespace_sem)
 quota_read:		no		(see below)
 quota_write:		no		(see below)
-bdev_try_to_free_page:	no		(see below)
 ======================	============	========================

 ->statfs() has s_umount (shared) when called by ustat(2) (native or
@@ -210,9 +208,6 @@ dqio_sem) (unless an admin really wants to screw up something and
 writes to quota files with quotas on). For other details about locking
 see also dquot_operations section.

-->bdev_try_to_free_page is called from the ->releasepage handler of
-the block device inode.  See there for more details.
-
 file_system_type
 ================

-- 
2.23.0



