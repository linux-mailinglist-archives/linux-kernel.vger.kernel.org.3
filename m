Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB55A52346E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243934AbiEKNiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbiEKNio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:38:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BA81AD58D;
        Wed, 11 May 2022 06:38:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so2117397pjq.2;
        Wed, 11 May 2022 06:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=jsRV8EvMOtUfJsgLKEp/CDjMrcTGRjbK7SqrPRT4roE=;
        b=hqvlJxq9PAR5+noe0CxheCXcFPfVtVGDqaiEGYE94YokujbrehQTT7oHQ74ftn3YaA
         7yHJwGUtm76af2ozPbSrExtHWwQXisy2UFTIGtQ3yn6PmKZ/yUWONEt8YZz6FFevGwf0
         AI3+I1mE51loi5LF4VH2qJxFHmz1ZiI+YgrQTmqPOEoJxTje7cC54RLotlocuQoi95C8
         vxchaX4SaqvDP5cuB6MKfCR8HCu82At6+MEBYocGMUAXMePgdPPBF7oYmR/XNQCAIQDn
         SCpVc7epYS8pZhvVKlw/dBDiMcqkzUGqv4L+ae/+E6hqqZ1WU3/CdJVMPnotLAN9OqM7
         ZUXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jsRV8EvMOtUfJsgLKEp/CDjMrcTGRjbK7SqrPRT4roE=;
        b=THI0aA1gjHcgnsHiy6A+xpDbw0VKyCF6RCppk4KjHYz1t7ov/bF/NQCn6FoHKrcE+B
         BPlOOnVqtbscc9gAkKi7QIOkqukoHwj0zQ7Jw9zj2AuyrzXVXmmaFSBp4vVZ5zZFoQXF
         ujk9GbkYUaY7k++bLH45TL9RQpTlMAuilSOOoEEhc+Q+p8ZWd7gZHTSua3Hpxeem78Gr
         Mcpkj9gJU+c1DLFVYXXihDTsmzb2KnNxcGfErRCOmKYwYNBz1rK12O5F+y4fuAWdw/pe
         6DH7E1LeAl6OR6IPlzn/RaNUiodlA2baq7DS8cTe+1gz5YInNRHKJgkQa7/HX+lXa/QI
         +2TQ==
X-Gm-Message-State: AOAM533QLk0CrYH1Kzsk4CzFw9gOlCWAkOOBZl3CKgNTRs4QAuBipDv3
        qSHxHROxl8V2fvASWsXeJRIFSC++0/g=
X-Google-Smtp-Source: ABdhPJwULSrhzjwC/+BV5fbgbTH6ZuoGqYYe6vbv/Km2fOQjL7ReimWM7jPlbXKrI1f+3pTPQvuL+w==
X-Received: by 2002:a17:90b:1251:b0:1d7:f7ae:9f1 with SMTP id gx17-20020a17090b125100b001d7f7ae09f1mr5439092pjb.65.1652276322266;
        Wed, 11 May 2022 06:38:42 -0700 (PDT)
Received: from carrot.localdomain (i58-89-48-88.s42.a014.ap.plala.or.jp. [58.89.48.88])
        by smtp.gmail.com with ESMTPSA id k11-20020aa792cb000000b0050dc76281b3sm1793275pfa.141.2022.05.11.06.38.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 May 2022 06:38:40 -0700 (PDT)
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-nilfs <linux-nilfs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] nilfs2: Fix some kernel-doc comments
Date:   Wed, 11 May 2022 22:38:36 +0900
Message-Id: <1652276316-7791-1-git-send-email-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Li <yang.lee@linux.alibaba.com>

The description of @flags in nilfs_dirty_inode() kernel-doc
comment is missing, and some functions had kernel-doc that
used a hash instead of a colon to separate the parameter
name from the one line description.

Fix them to remove some warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

fs/nilfs2/inode.c:73: warning: Function parameter or member 'inode' not
described in 'nilfs_get_block'
fs/nilfs2/inode.c:73: warning: Function parameter or member 'blkoff' not
described in 'nilfs_get_block'
fs/nilfs2/inode.c:73: warning: Function parameter or member 'bh_result'
not described in 'nilfs_get_block'
fs/nilfs2/inode.c:73: warning: Function parameter or member 'create' not
described in 'nilfs_get_block'
fs/nilfs2/inode.c:145: warning: Function parameter or member 'file' not
described in 'nilfs_readpage'
fs/nilfs2/inode.c:145: warning: Function parameter or member 'page' not
described in 'nilfs_readpage'
fs/nilfs2/inode.c:968: warning: Function parameter or member 'flags' not
described in 'nilfs_dirty_inode'

Link: https://lkml.kernel.org/r/20220324024215.63479-1-yang.lee@linux.alibaba.com
Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
---
 fs/nilfs2/inode.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 6045cea21f52..6a00cf324cbd 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -63,10 +63,10 @@ void nilfs_inode_sub_blocks(struct inode *inode, int n)
 
 /**
  * nilfs_get_block() - get a file block on the filesystem (callback function)
- * @inode - inode struct of the target file
- * @blkoff - file block number
- * @bh_result - buffer head to be mapped on
- * @create - indicate whether allocating the block or not when it has not
+ * @inode: inode struct of the target file
+ * @blkoff: file block number
+ * @bh_result: buffer head to be mapped on
+ * @create: indicate whether allocating the block or not when it has not
  *      been allocated yet.
  *
  * This function does not issue actual read request of the specified data
@@ -142,8 +142,8 @@ int nilfs_get_block(struct inode *inode, sector_t blkoff,
 /**
  * nilfs_readpage() - implement readpage() method of nilfs_aops {}
  * address_space_operations.
- * @file - file struct of the file to be read
- * @page - the page to be read
+ * @file: file struct of the file to be read
+ * @page: the page to be read
  */
 static int nilfs_readpage(struct file *file, struct page *page)
 {
@@ -1088,6 +1088,7 @@ int __nilfs_mark_inode_dirty(struct inode *inode, int flags)
 /**
  * nilfs_dirty_inode - reflect changes on given inode to an inode block.
  * @inode: inode of the file to be registered.
+ * @flags: flags to determine the dirty state of the inode
  *
  * nilfs_dirty_inode() loads a inode block containing the specified
  * @inode and copies data from a nilfs_inode to a corresponding inode
-- 
1.8.3.1

