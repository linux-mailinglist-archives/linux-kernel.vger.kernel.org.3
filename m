Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B77F46F939
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 03:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbhLJCfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 21:35:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhLJCft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 21:35:49 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D225AC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 18:32:14 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id p18-20020a17090ad31200b001a78bb52876so8392396pju.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 18:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rz2hszQnu9ZEQPVJqgSQiN65azKXvcGLoR3ob3i/3C8=;
        b=NKjIlcLrlskSKTPZ7irmX2bZPAevfI4jN51uaD5n56sQdpSstNmD1xKOeaPoTyGMg9
         aJ0T/EldY6oijTlwvmR8kuUc3wSpQhGuIM5PJhjtWVEfOnJV+8bMSTAKYLVNaKWITJkQ
         w+I7sVsEDuhg5Awjpt7BlihPmqbun4jKrb81Mme3wHqzUn4QIcsnXtFFH/atUF7q36Sa
         zGlZBwdvIl7mRcM8oq8kKIFM1O4M+46Xg/pvuRYIkF/sKw9cDow/h+12vD/uNQWR01Er
         k1IskEqgE+66Kg9zEFLCc3P/kM27SLx0JkgsuPthWBgc0RTb7ORst7c0umMX2jp7VI/7
         SjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rz2hszQnu9ZEQPVJqgSQiN65azKXvcGLoR3ob3i/3C8=;
        b=RBWrWPl6UdinIA9bZIr/fVigS+Ts5do9LnBSNqux43QHdsADr7i+TOqo6TUhx4kp2T
         Lsxq5vURbcJB5F8jXQs6SLb5ANR72ICzenwutAsBAWF/3kDjwcCNGV+YrxAeP0k8J0Ia
         RX7KExGQxSPJn1TOf2zGwW4t6MpFaQj02yXabSXoFpZRQPc0SSbF+a5YHcnTMWHFDc/z
         nb05Ju3m0Vd/6J5ptqS68C7FUxzDx2tmA8YQP8UnMtchyWcBrIEGE5QKc6Iwyg7nlfrs
         Q5qB/vBJRIeQPLPF9p+Y10gmPBwxgVObdgWtiiJBV1U0OAjmHAAe+eR+aN1Sikvo74HH
         5ERg==
X-Gm-Message-State: AOAM532mDGoeczvTUwbcw2R3C6F8IKngrrvJ6PMoWHtmF5+VAEeb23ru
        lx3aAFb7JTWB47/M2dD1zjTPDK7LODQ=
X-Google-Smtp-Source: ABdhPJwqVgjOoa/o26jmQhNOENgGZntvPebfvROBkJY7xJlURPI0UP6CH2raiHejnL7pOEYJ5azzzA==
X-Received: by 2002:a17:90a:e7ca:: with SMTP id kb10mr20354597pjb.8.1639103534457;
        Thu, 09 Dec 2021 18:32:14 -0800 (PST)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i185sm1021692pfg.80.2021.12.09.18.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 18:32:14 -0800 (PST)
From:   cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To:     christian.brauner@ubuntu.com
Cc:     chi.minghao@zte.com.cn, jack@suse.cz, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
Subject: [PATCH] fs/adfs: remove unneeded variable make code cleaner
Date:   Fri, 10 Dec 2021 02:32:11 +0000
Message-Id: <20211210023211.424609-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Minghao Chi <chi.minghao@zte.com.cn>

return value form directly instead of
taking this in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cm>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 fs/adfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/adfs/inode.c b/fs/adfs/inode.c
index adbb3a1edcbf..5156821bfe6a 100644
--- a/fs/adfs/inode.c
+++ b/fs/adfs/inode.c
@@ -355,7 +355,6 @@ int adfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 {
 	struct super_block *sb = inode->i_sb;
 	struct object_info obj;
-	int ret;
 
 	obj.indaddr	= ADFS_I(inode)->indaddr;
 	obj.name_len	= 0;
@@ -365,6 +364,5 @@ int adfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	obj.attr	= ADFS_I(inode)->attr;
 	obj.size	= inode->i_size;
 
-	ret = adfs_dir_update(sb, &obj, wbc->sync_mode == WB_SYNC_ALL);
-	return ret;
+	return adfs_dir_update(sb, &obj, wbc->sync_mode == WB_SYNC_ALL);
 }
-- 
2.25.1

