Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4495AF971
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 03:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiIGBpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 21:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIGBpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 21:45:18 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8829D474DF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 18:45:16 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id az27so18057220wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 18:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=jZaYovgub0rZqByc9v6RFrZ7UGMX6EoYevj6jqzmCbo=;
        b=XWdKqNh9srmZtJfElg5dSP8h0RPQRVxgZaA1KbM4h1GdoQUm8t0xD89PdP4wHJpD6O
         Dkz69+3eOixiPgByLZN+UICXUsI++49cMeaOsv0Is/7bakkGn/TWQDuauFQ55cmLdfnx
         EfJ5MHoi9bXTBiy7pdLQCdHueepAj0H9soVYkG3UL5M7wWT/ctsTFYsRGd/xYQQB0aRg
         QuicwtjiVhH19CwybdIb6ZIz5I1pmgKR3MdTJNbl9lTf5as0pX1HZt9ngiAUqGLwTgIV
         4mjdisBcBKlFqjt6ebOSaW50kdMDT+m7FKA6kzf8lEYcHNyqb/5RMGzo2xIJ8P6QaUVF
         AnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=jZaYovgub0rZqByc9v6RFrZ7UGMX6EoYevj6jqzmCbo=;
        b=LModqLxm3x04MzASyohx5ywNb9R6A3E1tOlkm0i2ZSBgttEdwuS6MB5Je2R7c/CP7k
         qZkz/pGl8RFrc2pBkf0CdjYc9zSGCYcfd7sS4SI8SbIp/tri3LcSbhHSpouFZ4moNSRT
         ixJ2x0HXj97Fi2ycFe6o5HSQ8wuwM1qlp4IATrEitKwME5ef4G6zEVMzJKM42hE3lDdE
         6nXG3whZHoBiwRe3Rm8xymiDSdcEk/ALftIq9g+CasDydj86cyu9IuPbskWd8wKSWLr4
         1cIlWbA6jak/tr6bx/mjjG8qvUCjBW6sO1SXAEUR+cxFQ6TIK8tEzzEC8wmvQ+hWdtQu
         oqqQ==
X-Gm-Message-State: ACgBeo3NmGLte1AaPip0btB4iSZKNL9GYH3vJbXgnikuYlMJocD+4fLL
        RpSyHj+ZsoTSs5NRnLmx08tboqBhf0c9aX58
X-Google-Smtp-Source: AA6agR6PWq1CqiErw5IE05JcYFHBMr3L/svqbLQu+Cldw0unavfeW+grYRTWwqNRBvl+AACKaCLkrg==
X-Received: by 2002:a5d:59a6:0:b0:228:ac72:3c27 with SMTP id p6-20020a5d59a6000000b00228ac723c27mr596979wrr.73.1662515114990;
        Tue, 06 Sep 2022 18:45:14 -0700 (PDT)
Received: from [192.168.42.102] (mo-217-129-3-75.netvisao.pt. [217.129.3.75])
        by smtp.gmail.com with ESMTPSA id h4-20020a5d4304000000b002238ea5750csm17562831wrq.72.2022.09.06.18.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 18:45:14 -0700 (PDT)
Message-ID: <7839ac04-f93c-a897-70eb-2505d72f936c@gmail.com>
Date:   Wed, 7 Sep 2022 02:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Content-Language: en-US
From:   Daniel Pinto <danielpinto52@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Artem S. Tashkinov" <aros@gmx.com>
Subject: [PATCH] ntfs3: fix junction point resolution
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ntfs3 file system driver does not convert the target path of
junction points to a proper Linux path. As junction points targets
are always absolute paths (they start with a drive letter), all
junctions will result in broken links.

Translate the targets of junction points to relative paths so they
point to directories inside the mounted volume. Note that Windows
allows junction points to reference directories in another drive.
However, as there is no way to know which drive the junctions refer
to, we assume they always target the same file system they are in.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=214833
Signed-off-by: Daniel Pinto <danielpinto52@gmail.com>
---
 fs/ntfs3/inode.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 51363d4e8636..f7e8876f56d3 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1749,7 +1749,101 @@ void ntfs_evict_inode(struct inode *inode)
 	ni_clear(ntfs_i(inode));
 }
 
-static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer,
+/*
+ * ntfs_translate_junction
+ *
+ * Translate a Windows junction target to the Linux equivalent.
+ * On junctions, targets are always absolute (they include the drive
+ * letter). We have no way of knowing if the target is for the current
+ * mounted device or not so we just assume it is.
+ */
+static int ntfs_translate_junction(const struct super_block *sb,
+				   const struct dentry *link_de, char *target,
+				   int target_len, int target_max)
+{
+	int tl_len, err = target_len;
+	char *link_path_buffer = NULL, *link_path;
+	char *translated = NULL;
+	char *target_start;
+	int copy_len;
+
+	link_path_buffer = kmalloc(PATH_MAX, GFP_NOFS);
+	if (!link_path_buffer) {
+		err = -ENOMEM;
+		goto out;
+	}
+	/* Get link path, relative to mount point */
+	link_path = dentry_path_raw(link_de, link_path_buffer, PATH_MAX);
+	if (IS_ERR(link_path)) {
+		ntfs_err(sb, "Error getting link path");
+		err = -EINVAL;
+		goto out;
+	}
+
+	translated = kmalloc(PATH_MAX, GFP_NOFS);
+	if (!translated) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	/* Make translated path a relative path to mount point */
+	strcpy(translated, "./");
+	++link_path;	/* Skip leading / */
+	for (tl_len = sizeof("./") - 1; *link_path; ++link_path) {
+		if (*link_path == '/') {
+			if (PATH_MAX - tl_len < sizeof("../")) {
+				ntfs_err(sb, "Link path %s has too many components",
+					 link_path);
+				err = -EINVAL;
+				goto out;
+			}
+			strcpy(translated + tl_len, "../");
+			tl_len += sizeof("../") - 1;
+		}
+	}
+
+	/* Skip drive letter */
+	target_start = target;
+	while (*target_start && *target_start != ':')
+		++target_start;
+
+	if (!*target_start) {
+		ntfs_err(sb, "Link target (%s) missing drive separator", target);
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* Skip drive separator and leading /, if exists */
+	target_start += 1 + (target_start[1] == '/');
+	copy_len = target_len - (target_start - target);
+
+	if (PATH_MAX - tl_len <= copy_len) {
+		ntfs_err(sb, "Link target %s too large for buffer (%d <= %d)",
+			 target_start, PATH_MAX - tl_len, copy_len);
+		err = -EINVAL;
+		goto out;
+	}
+
+	/* translated path has a trailing / and target_start does not */
+	strcpy(translated + tl_len, target_start);
+	tl_len += copy_len;
+	if (target_max <= tl_len) {
+		ntfs_err(sb, "Target path %s too large for buffer (%d <= %d)",
+			 translated, target_max, tl_len);
+		err = -EINVAL;
+		goto out;
+	}
+	strcpy(target, translated);
+	err = tl_len;
+
+out:
+	kfree(link_path_buffer);
+	kfree(translated);
+	return err;
+}
+
+static noinline int ntfs_readlink_hlp(const struct dentry *link_de,
+				      struct inode *inode, char *buffer,
 				      int buflen)
 {
 	int i, err = -EINVAL;
@@ -1892,6 +1986,11 @@ static noinline int ntfs_readlink_hlp(struct inode *inode, char *buffer,
 
 	/* Always set last zero. */
 	buffer[err] = 0;
+
+	/* If this is a junction, translate the link target. */
+	if (rp->ReparseTag == IO_REPARSE_TAG_MOUNT_POINT)
+		err = ntfs_translate_junction(sb, link_de, buffer, err, buflen);
+
 out:
 	kfree(to_free);
 	return err;
@@ -1910,7 +2009,7 @@ static const char *ntfs_get_link(struct dentry *de, struct inode *inode,
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
 
-	err = ntfs_readlink_hlp(inode, ret, PAGE_SIZE);
+	err = ntfs_readlink_hlp(de, inode, ret, PAGE_SIZE);
 	if (err < 0) {
 		kfree(ret);
 		return ERR_PTR(err);

