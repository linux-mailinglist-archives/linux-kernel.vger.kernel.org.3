Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7C753B44A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiFBHZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiFBHZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:25:19 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B98D2755BF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:25:19 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id r71so4082840pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 00:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8s3LJw5xicbUhVaH0XHYNaSTkuhFS4Q1fnoIihiiOA=;
        b=PpUcfnTeCjQJpRRld4d2NkaZOQ+giQuHJCn1hzgzAqhdn6283vgJycubVJLHBz7MeO
         gpk/zLenJxp9+0MjyREOYZrTUaH4ZO3CsgN4B/2kYGrIj6WtCgBd5Vxj0NprmFh3iOOe
         qqRccxugpbcmvhBLur+sbcAxdL9UkwfInmnoeaMIK2j9IL2G1v/EK4XC0099v5nGhbkY
         /2oUDiJzag2krbBJswpFIJ3ox1IVAQFwEzgpbd8EIB6GMv/imk1bfRNdh4pLljzCnbL8
         FDMiOweeEvMn8jEeguFjd4Y2npkd0rr0Xc5o3TwFXpAyvU45XvDEGAVctirlyucvMIvv
         M6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L8s3LJw5xicbUhVaH0XHYNaSTkuhFS4Q1fnoIihiiOA=;
        b=4l7T6ZTy+lu/Qv23WrMurXOdHOrjnrD5XXJXlq+sFuvN1yiktck0PYbIW6eYYbb0OZ
         l5hjKrjw5kder40Nw+cyRC79gDKz0ylvhjOUfjHA8nOP61iigDJMf1LdIfUHns7XRbnL
         Kb2ZfCcF/YttuYHZAbquVoCfz55DBwcAtnsMZ6elbR9zbJQ4CRvG6UI5Cm6QsUyxmY/a
         5Y1v9qzScV/I38Akv0SThLxU7RnaU7aoJeHwQ74GjiAfkcMNQunXZThLUMW6SGtQmmri
         cgcrtOXCxAYftP8k+cJ2cNRzuITPwY2WzHiJOoraoCi3u/UgvzS3zH0MfZVaGJTzbJlv
         94fw==
X-Gm-Message-State: AOAM530m41Q6/csZM2v8idCMVQHuyvSnu/XLAXSwWTqVOHIsH7hJa3kU
        xswx0uqgGVO835hlDipUqYQ=
X-Google-Smtp-Source: ABdhPJzF76sBp7B+RevVSJ6GLP6kQU1DDA5WxDEyBKWr3d793qldOtmxxXG4GU+oPlNcprYzx09L2g==
X-Received: by 2002:a63:e60e:0:b0:3fc:7753:ed89 with SMTP id g14-20020a63e60e000000b003fc7753ed89mr3032900pgh.70.1654154718717;
        Thu, 02 Jun 2022 00:25:18 -0700 (PDT)
Received: from localhost.localdomain ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id h21-20020a170902f7d500b001637997d0d4sm2725018plw.206.2022.06.02.00.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 00:25:18 -0700 (PDT)
From:   Chao Liu <chaoliu719@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yue Hu <huyue2@coolpad.com>,
        Wayne Zhang <zhangwen@coolpad.com>,
        Chao Liu <liuchao@coolpad.com>
Subject: [PATCH] f2fs: refine comments for inline flags
Date:   Thu,  2 Jun 2022 15:24:49 +0800
Message-Id: <20220602072449.998303-1-chaoliu719@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Liu <liuchao@coolpad.com>

Currently, we use f2fs_has_inline_xattr() to check whether the
inode can store inline xattr. However, it might be misinterpreted
as the inode has at least one inline xattr.

The same is true for f2fs_has_inline_data() and
f2fs_has_inline_dentry(). To be more intuitive and specific,
refine comments of inline flags.

Signed-off-by: Chao Liu <liuchao@coolpad.com>
---
 fs/f2fs/f2fs.h          | 6 +++---
 include/linux/f2fs_fs.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e10838879538..e0205d42588d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -730,9 +730,9 @@ enum {
 	FI_NO_ALLOC,		/* should not allocate any blocks */
 	FI_FREE_NID,		/* free allocated nide */
 	FI_NO_EXTENT,		/* not to use the extent cache */
-	FI_INLINE_XATTR,	/* used for inline xattr */
-	FI_INLINE_DATA,		/* used for inline data*/
-	FI_INLINE_DENTRY,	/* used for inline dentry */
+	FI_INLINE_XATTR,	/* inode can store inline xattr */
+	FI_INLINE_DATA,		/* inode can store inline data */
+	FI_INLINE_DENTRY,	/* inode can store inline dentry */
 	FI_APPEND_WRITE,	/* inode has appended data */
 	FI_UPDATE_WRITE,	/* inode has in-place-update data */
 	FI_NEED_IPU,		/* used for ipu per file */
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index d445150c5350..a3c6750a66ae 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -223,9 +223,9 @@ struct f2fs_extent {
 #define	NODE_IND2_BLOCK		(DEF_ADDRS_PER_INODE + 4)
 #define	NODE_DIND_BLOCK		(DEF_ADDRS_PER_INODE + 5)
 
-#define F2FS_INLINE_XATTR	0x01	/* file inline xattr flag */
-#define F2FS_INLINE_DATA	0x02	/* file inline data flag */
-#define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
+#define F2FS_INLINE_XATTR	0x01	/* file can store inline xattr */
+#define F2FS_INLINE_DATA	0x02	/* file can store inline data */
+#define F2FS_INLINE_DENTRY	0x04	/* file can store inline dentry */
 #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
 #define F2FS_INLINE_DOTS	0x10	/* file having implicit dot dentries */
 #define F2FS_EXTRA_ATTR		0x20	/* file having extra attribute */
-- 
2.36.1

