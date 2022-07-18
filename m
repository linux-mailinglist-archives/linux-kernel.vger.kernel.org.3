Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0614C577D33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbiGRILC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbiGRILB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:11:01 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CD212601
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:10:59 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g126so9969626pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=koJtdu2xGKY/BDY+kAcaq9hS2IfMj226ck1h8XVx8nc=;
        b=YPfCzd+LWX6tGDrhIg8VyeRtxSwuQnIytXKBmgqlJU+EP1t3GV3USjvadSwh21GTWn
         bIxC9/uswSeopFMkbYMOtzFJVtEA3ZGrZBZC69To+Tp+or9+gD9lUJJ3MIahxw+6p7Gx
         r0ogkc0Ppp4Pv8PTWZmNkCDUCuyjHUVHeVFiqx5Y9FHWpGQrfLEyaZXSkfaAASPZ/lgH
         vYj3As3RcWhFUBLOB/naxgsoKzkpo54qn/TWlDqmuOe7+TgtZqKkPU9F2fFjnOlOLkcM
         LsK/QN+01r/wML+H8xKfxZyYepasaICMvcZr4oF7lS7S3Hj1r8jyPeeadjNbz1FrzRxL
         5IhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=koJtdu2xGKY/BDY+kAcaq9hS2IfMj226ck1h8XVx8nc=;
        b=i01WRjlUK/vnL8FbTvwTQoTC4dqOqQKZJiq9IWneNBiklcmU5ZijoZi14WqA5pRafb
         WGhX386JPp4UHwvuUucy4IuK/DIXJzLV4j2X6bMgCzfbArDueYgnkokpZ5oEDniT1OVz
         7JuIvYssKKZj66s12/QttgCXGWAbwGbLt1d9QiR0niA6PWhMZZr9wONP8XnT5I/HU/l3
         CiCRnQ9KkfSYmJdl9xNHA7LnsxG9knLsmm/QHHpMKQrY1XqZEA0k4DwMt+F8/7YrjQ3s
         VCaGXJS0ZX4TqfhOip/KH8Ffl/wyEm/3gxa0pnfb0zRdPA10mUoyNWCurcCpC+8tBVfS
         3c9Q==
X-Gm-Message-State: AJIora+6gBggQQn+JD4Cns1jY45E0f67wlai9phpNuysSLn9cXIjD9FP
        w24G/jw1MIpHtBkJ3868FJ9tQQl6JjsFAiWT
X-Google-Smtp-Source: AGRyM1s1EKjylolsXMIuvJO65KwmrcIJ8rMJh/CjiItqMsskcy1K0pyvsDM0UwUrI7oSMmx+Ha9VmQ==
X-Received: by 2002:a63:6a82:0:b0:419:de8c:8ca with SMTP id f124-20020a636a82000000b00419de8c08camr14123782pgc.467.1658131859151;
        Mon, 18 Jul 2022 01:10:59 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.232])
        by smtp.gmail.com with ESMTPSA id ng8-20020a17090b1a8800b001ef9479373fsm11047865pjb.4.2022.07.18.01.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 01:10:58 -0700 (PDT)
From:   Guowei Du <duguoweisz@gmail.com>
To:     jaegeuk@kernel.org, chao@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, duguowei <duguowei@xiaomi.com>
Subject: [PATCH] f2fs: modify task name prefix
Date:   Mon, 18 Jul 2022 16:10:38 +0800
Message-Id: <20220718081038.2279-1-duguoweisz@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: duguowei <duguowei@xiaomi.com>

If there are more than one f2fs sbi, there will be more
discard threads. But the comm is too long to show dev
minor. So, change the default prefix of thread from
"f2fs_discard" to "f2fs_dcd".

Before:
$ ps -e | grep f2fs
1628 ?        00:00:00 f2fs_ckpt-7:10
1629 ?        00:00:00 f2fs_flush-7:10
1630 ?        00:00:00 f2fs_discard-7:
1631 ?        00:00:00 f2fs_gc-7:10
2030 ?        00:00:00 f2fs_ckpt-7:27
2031 ?        00:00:00 f2fs_flush-7:27
2032 ?        00:00:00 f2fs_discard-7:
2033 ?        00:00:00 f2fs_gc-7:27

After:
$ ps -e | grep f2fs
1628 ?        00:00:00 f2fs_ckpt-7:10
1629 ?        00:00:00 f2fs_flush-7:10
1630 ?        00:00:00 f2fs_dcd-7:10
1631 ?        00:00:00 f2fs_gc-7:10
2030 ?        00:00:00 f2fs_ckpt-7:27
2031 ?        00:00:00 f2fs_flush-7:27
2032 ?        00:00:00 f2fs_dcd-7:27
2033 ?        00:00:00 f2fs_gc-7:27

Signed-off-by: duguowei <duguowei@xiaomi.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 874c1b9c41a2..2eeefcbe62db 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2018,7 +2018,7 @@ int f2fs_start_discard_thread(struct f2fs_sb_info *sbi)
 		return 0;
 
 	dcc->f2fs_issue_discard = kthread_run(issue_discard_thread, sbi,
-				"f2fs_discard-%u:%u", MAJOR(dev), MINOR(dev));
+				"f2fs_dcd-%u:%u", MAJOR(dev), MINOR(dev));
 	if (IS_ERR(dcc->f2fs_issue_discard))
 		err = PTR_ERR(dcc->f2fs_issue_discard);
 
-- 
2.36.1

