Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79F659D2B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 09:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbiHWHyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 03:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241373AbiHWHye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 03:54:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905BB3C8E3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:54:33 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 83so7009963pfw.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=Fhc6O7Qq+zYM2J7HupUPMiHA1uhYp0JcTthm4gtLpMk=;
        b=eKLCQCWAmjeNQY1OQRr7S08CWDNeiCLxDDFGvLNINXnWtOrZLASoZsSQ0Ph+3K3QQZ
         frwmfig0WFOxAq9gk5JssTOTZ6LtS/+sOxKh930lF4P8GDaRREGt/kcoQ3v2O0NCvR38
         El1vo57dLAvErllDwVCFVn6a4f7mvlsCi2LRw4k711w/QpulUYNP1Kmcxfb1EGt8nwBN
         o7hGrwKezS1mSIQqhzkQeWDpmP+ai8w/XBjjYVIjTPEiitPxesfd3I/0VlALCJ4LYQbV
         jfhBsVKzE0N/WqlTt6sRwlR7egUpqKo1JWwmEPHggFYCn9DAvwqMS88BNSpoXhorShDE
         +GAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=Fhc6O7Qq+zYM2J7HupUPMiHA1uhYp0JcTthm4gtLpMk=;
        b=4QG2QGSHK6QIoVWIneRTmJ2o0OzPRVZhl9P/0YkhovKU6gg1zKoFR7qtXI0QnDIQM/
         E/9pkVjVHXu+kUcZRQM0o5DPr2mAEjWIKqCTYjRwGMFwnN+Lu5jn8AzR7OS7RNNQ/l4z
         C3SQ84jyYywcwIR6uua0n3T0bzphnE++DsvYI+SdOV+c911ZyrYNv6jnq0D8CStLnOvZ
         AMsqhUYugMiflcgO/LH/HtIR287/5Yp8Fvyjt9SPX0zKVY1glcdbfX/Lta0wKqscICgu
         0L/2TKO/w/ch1oYPI0fqIodlrxlx5yW7YvPygzjHs4CL1pdfmLafDeJVkGn2tzyXMVYP
         uGSw==
X-Gm-Message-State: ACgBeo1B0RV8Vqq8jK/EQYffpItbJ1mlwZMyi3wV8py48K263vm2dD2y
        e9tLF0dllToXJs6Pg88qZVg=
X-Google-Smtp-Source: AA6agR42r5dO1/gViA+AZieihQ4hhf5LzL7oacVP6Vd1GQ+y1OSyfKOBE2bT0T+YxAX1ZqxCr6apSQ==
X-Received: by 2002:a05:6a00:1410:b0:528:5a5a:d846 with SMTP id l16-20020a056a00141000b005285a5ad846mr24614330pfu.9.1661241272696;
        Tue, 23 Aug 2022 00:54:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902d38c00b001636d95fe59sm4284033pld.172.2022.08.23.00.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 00:54:32 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     agruenba@redhat.com, linux-kernel@vger.kernel.org
Cc:     rpeterso@redhat.com, cluster-devel@redhat.com,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] gfs2: Remove the unneeded result variable
Date:   Tue, 23 Aug 2022 07:54:29 +0000
Message-Id: <20220823075429.209135-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Return the value from gfs2_iomap_get() directly instead of storing it
in another redundant variable.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 fs/gfs2/bmap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 3bdb2c668a71..977d53db2994 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -2462,8 +2462,6 @@ int __gfs2_punch_hole(struct file *file, loff_t offset, loff_t length)
 static int gfs2_map_blocks(struct iomap_writepage_ctx *wpc, struct inode *inode,
 		loff_t offset)
 {
-	int ret;
-
 	if (WARN_ON_ONCE(gfs2_is_stuffed(GFS2_I(inode))))
 		return -EIO;
 
@@ -2472,8 +2470,7 @@ static int gfs2_map_blocks(struct iomap_writepage_ctx *wpc, struct inode *inode,
 		return 0;
 
 	memset(&wpc->iomap, 0, sizeof(wpc->iomap));
-	ret = gfs2_iomap_get(inode, offset, INT_MAX, &wpc->iomap);
-	return ret;
+	return gfs2_iomap_get(inode, offset, INT_MAX, &wpc->iomap);
 }
 
 const struct iomap_writeback_ops gfs2_writeback_ops = {
-- 
2.25.1
