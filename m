Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8637481DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 16:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbhL3PdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 10:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhL3PdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 10:33:04 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ECFC061574;
        Thu, 30 Dec 2021 07:33:03 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso13506812wme.1;
        Thu, 30 Dec 2021 07:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/EWLqn+e9gTwKuOiaXeqTXWRPro/3L5eOKPKtLfSqQ=;
        b=F2xj/eue0N18OAuFeFppYZZI0LVUEofODrtQMNGa7VuIerW3u9I+DX+cafNk98nVtD
         CWuEvjs+onYX0XYVEPTbGZS1zm1i1xUBaKmdk3NlWgd+O2VNSE3hDiJrQOBDYZDx4Tob
         //SZ8GJM3GiAM6RlAos7W0zez0edEBRsuZfLJc4N89TU0hULYlWj8eVkt1Zqzfa2uldt
         6Iex2JNUseCvXnkl1/sLPnOiVLKFWpXT8vCWwQJArFvdsACq1SvZXCoS/+ofNk3UGLc7
         UEAFpQFTCGWq5E5SWEHfo93/XOnWBYT8gqOIONiQ+QuH8I+CGq2E6OAGm04JMB6Wm49L
         jnrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=F/EWLqn+e9gTwKuOiaXeqTXWRPro/3L5eOKPKtLfSqQ=;
        b=Kv4X7mZIhR8zALhvJxxZPbJt1PP1mQaxYG72Nk+gBPrIwJ59uBEreqx2lKrS1ujv5G
         2sv0XT7dLg6FTICpehQobjnm9g7NCI/GDQnypRhSxngsNYXrgdrHaxSJRiuXm/fdjEmx
         wHs74voWcXW1sIhxU0aV6Pe/rONF1Z9B6A17UK5uji7GBlUhWsE/GlAKGmWKKYevjE1g
         hV7k+YdNZip71EyN+XAI0WhX5oZTBJB93g8KrH+v0tltnL2fGxSDhTy8jB36nykq9Z8X
         q/6OVhViQtTgJYccIslitS/o0QwrXHR4g/kmz9PlPnhnEWWDZDac3VTLWlx3W8n+GWBD
         qwRg==
X-Gm-Message-State: AOAM533K11SbvWgt+UnOLhw3XsgsEbBKbMNHH8ZFBweDpj0jXMPHWJkh
        pQMBW8i6Y9cTWE0/iN2ewk7UZ+4xELw/vV59
X-Google-Smtp-Source: ABdhPJxsgPQYRnO/2pZhcUUy7gFIl3zoZNQQMnMihhxi0ImYLxf0ke1Ua8g2a+acrN6yRW39UUeIew==
X-Received: by 2002:a1c:f205:: with SMTP id s5mr2872853wmc.33.1640878382374;
        Thu, 30 Dec 2021 07:33:02 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m15sm27690200wrw.27.2021.12.30.07.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 07:33:01 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hpfs: remove redundant variable r
Date:   Thu, 30 Dec 2021 15:33:01 +0000
Message-Id: <20211230153301.248914-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable r is being assigned a value and it is never read. The
declaration and assignment are redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/hpfs/namei.c                   | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index d73f8a67168e..81b44bac4e1f 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -555,8 +555,7 @@ static int hpfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	de.hidden = new_name[0] == '.';
 
 	if (new_inode) {
-		int r;
-		if ((r = hpfs_remove_dirent(old_dir, dno, dep, &qbh, 1)) != 2) {
+		if (hpfs_remove_dirent(old_dir, dno, dep, &qbh, 1) != 2) {
 			if ((nde = map_dirent(new_dir, hpfs_i(new_dir)->i_dno, new_name, new_len, NULL, &qbh1))) {
 				clear_nlink(new_inode);
 				copy_de(nde, &de);
-- 
2.33.1

