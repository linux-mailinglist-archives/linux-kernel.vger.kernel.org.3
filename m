Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB75951F1D8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 23:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiEHVkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 17:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiEHVkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 17:40:43 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDD0DF51;
        Sun,  8 May 2022 14:36:52 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id b19so16993192wrh.11;
        Sun, 08 May 2022 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wdczpGExok8Ixspg0oBG1+Qe9W34SUYs1C1W6f+vXrI=;
        b=oGF0bN61PfJfTgwyb85UN9/mN+5cBHzaSsAq4JaZr5Lnj9d4+yr7Ses6/Y0szkeLFG
         jt1b+dA6F9SIYk2umoBWlGiG048+2O3Cvt0gcWgIQxcAsop5IpLTfZ6ZKxFOsAnYCdfo
         6Mk33BSjN6IxcTZf9aCYOIAJpPw/MrE5XaDwHm2RcqstJGF0OYmDeHzEXn5IxMT1qyXL
         vus/x5z7ZH7vN4avKQ1Tczjx4OQ6/SrBNHNNINo+cPebJmKKQCfHQdlPqFp74/kSdC+z
         76HkA0in7EFjRupZVbl4L2LHFsXVlDVRFLOm7ei/3rImyw04zEYFZSv/zeq/oYfBtUY+
         y9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wdczpGExok8Ixspg0oBG1+Qe9W34SUYs1C1W6f+vXrI=;
        b=lDX3eknoh7ksX9aotQENYO0XZ7Kse6F25NkKKwfEszvcR8rbraF9gPH5u7j8W0UIWB
         Pw48b/GIC6NUDmJhkIropiuU2D7giTwUOaJklJ0+5HE99HheuATHq7+gb0Jfnvf+4hfu
         HKeQMp1LmznGrxqgvDH43zKXLNW5yHwrXJqUcQQ6eHeT/YrJK4ElMmWFt9aJ45ezElY2
         q0bcDhbECt2k17ahJ7iV1pkroelmb5ssFVba9jWLClZ1qIlVIKJaQknKwudPO/nH1lqK
         FzYhU82oMKwzp++J6Z56p5GMML3UDgz31sw1jJOC5bsTQtc7ay/qC8l1woIVXQHg7nZu
         2JmQ==
X-Gm-Message-State: AOAM533jnpj8Y5i+JBpsgTpppEu6DNAWGTz9f/9jZ+7dcXqCm3qEFz8G
        1m8dDTeHKhzNrhuESr0t7aE=
X-Google-Smtp-Source: ABdhPJy+tZJg1yGfkKl+/YN9+AStJ+NXLb/i6afFYek3TlrQgairXFovQpVPIWCsMZ/kX7v0sZ3iNw==
X-Received: by 2002:adf:ef01:0:b0:20a:8068:ca5e with SMTP id e1-20020adfef01000000b0020a8068ca5emr11211848wro.661.1652045810835;
        Sun, 08 May 2022 14:36:50 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z8-20020a1cf408000000b003942a244ecdsm11161445wma.18.2022.05.08.14.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 14:36:50 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hpfs: remove redundant variable r
Date:   Sun,  8 May 2022 22:36:49 +0100
Message-Id: <20220508213649.59917-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable r is being assigned a value that is never used, the assignment
and the variable are redundant and can be removed.

Cleans up clang scan warning:
fs/hpfs/namei.c:560:8: warning: Although the value stored to 'r' is
used in the enclosing expression, the value is never actually read
from 'r' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/hpfs/namei.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 15fc63276caa..d4a57e476013 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -556,8 +556,7 @@ static int hpfs_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 	de.hidden = new_name[0] == '.';
 
 	if (new_inode) {
-		int r;
-		if ((r = hpfs_remove_dirent(old_dir, dno, dep, &qbh, 1)) != 2) {
+		if (hpfs_remove_dirent(old_dir, dno, dep, &qbh, 1) != 2) {
 			if ((nde = map_dirent(new_dir, hpfs_i(new_dir)->i_dno, new_name, new_len, NULL, &qbh1))) {
 				clear_nlink(new_inode);
 				copy_de(nde, &de);
-- 
2.35.1

