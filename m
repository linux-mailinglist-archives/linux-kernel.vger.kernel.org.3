Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7AC0485E3C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 02:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344449AbiAFBvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 20:51:51 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:54689 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344427AbiAFBvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 20:51:49 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V13wOxI_1641433907;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V13wOxI_1641433907)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Jan 2022 09:51:48 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     anton@tuxera.com
Cc:     linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] NTFS: Fix one kernel-doc comment
Date:   Thu,  6 Jan 2022 09:51:45 +0800
Message-Id: <20220106015145.67067-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/**
 * attrib.c - NTFS attribute operations.  Part of the Linux-NTFS

The comments for the file should not be in kernel-doc format, which causes
it to be incorrectly identified for function ntfs_map_runlist_nolock(),
causing some warnings found by running scripts/kernel-doc.

fs/ntfs/attrib.c:25: warning: Incorrect use of kernel-doc format:  *
ntfs_map_runlist_nolock - map (a part of) a runlist of an ntfs inode
fs/ntfs/attrib.c:71: warning: Function parameter or member 'ni' not
described in 'ntfs_map_runlist_nolock'
fs/ntfs/attrib.c:71: warning: Function parameter or member 'vcn' not
described in 'ntfs_map_runlist_nolock'
fs/ntfs/attrib.c:71: warning: Function parameter or member 'ctx' not
described in 'ntfs_map_runlist_nolock'
fs/ntfs/attrib.c:71: warning: expecting prototype for attrib.c - NTFS
attribute operations.  Part of the Linux(). Prototype was for
ntfs_map_runlist_nolock() instead

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 fs/ntfs/attrib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index d563abc3e136..2911c04a33e0 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * attrib.c - NTFS attribute operations.  Part of the Linux-NTFS project.
  *
  * Copyright (c) 2001-2012 Anton Altaparmakov and Tuxera Inc.
-- 
2.20.1.7.g153144c

