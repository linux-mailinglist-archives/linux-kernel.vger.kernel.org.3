Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6935F4D70E8
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 21:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232638AbiCLUnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 15:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232299AbiCLUm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 15:42:59 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B314537A1F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 12:41:52 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id z3so10478945plg.8
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 12:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=z0OtbkAFOzZxKR5/4BNUwxuMMsg+2em+OF72Kb9Nh9I=;
        b=GxCc7whH6+vY1PtxE9K8VX8Nj/A/1vqusEa9KgtMMNeyDnmRaXcHRK+m16ac89qTdH
         CzVUvAb8ClcDlB6Q/5hqFSxMRiU3PIvIDVAOXLaHpeiG2hyCM4JvYJVdwMmDlj7jwbqn
         dmjVaWyyp1uvnRgu/kjmeuAm7L2XdDUih8RGWxgsXU4d8JU1wrGUJfc+G4xdVgAjY0ok
         HBjy2pRipPrmwWor5bBbP4adqLM4GPTbRc4Lfja2f1/P5uLWTwNLb5JR8xhx+3Ls4hZ+
         Cmr75+bLftAteOxEA+uBSLSw8MUP+Q0PcL+elCq3DZcynBgX07jFMWPJFQDFXJpUWBjj
         gZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=z0OtbkAFOzZxKR5/4BNUwxuMMsg+2em+OF72Kb9Nh9I=;
        b=TenO6n5idLQ7CwJzEpTFFxp3jkbjzxZXlLYIXKm10iDX9UU54Hps/gW9QgVRBUT6bT
         GYKQVK4/zyVT+oZDLFDVwP58akGR6Bix5AmxzCUgCKkOh7y07ngx67Oa1PTjeVJq8wXy
         SxcUveMrIzaHqpGKH4C+VdY0VVhY5Bf5FeuOEHYoXMQQdiAwQbWXuu92qz6RME59xcpV
         yMKWqZgVo2r8u8PaNHead0I0UNqgRGPniMEv32ASKSmKFUI720D8SOiGfxXCWjJbTqx/
         hT6K60IyAM+M1G/8/qnlwNIM96cuUNrtsuVCFHsz3ii3yd261nCUlEW1byjP7WFFLvuK
         2Hgw==
X-Gm-Message-State: AOAM533TMh7rY3GBV/f26PyMKZoRoo2ln3SolXIip+Qkdf/ueT8SHuqj
        mQoz96Zz1GPFqCA3fhmovIM=
X-Google-Smtp-Source: ABdhPJzJEOMlOrhBzV/paNYbCbKqWmpAJrTQfrcl695FtmcHwmiiAap0tNnTGpDg2LPwXPXtCnbDZA==
X-Received: by 2002:a17:902:bd86:b0:14d:8437:5113 with SMTP id q6-20020a170902bd8600b0014d84375113mr16505518pls.43.1647117712132;
        Sat, 12 Mar 2022 12:41:52 -0800 (PST)
Received: from localhost.localdomain ([45.250.64.116])
        by smtp.gmail.com with ESMTPSA id f21-20020a056a0022d500b004f7a420c330sm3683389pfj.12.2022.03.12.12.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 12:41:51 -0800 (PST)
From:   shaikh kamal <shaikhkamal2012@gmail.com>
Cc:     shaikhkamal2012@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH]  staging: android: ashmem: Declared file operation with const keyword Warning found by checkpatch.pl script.
Date:   Sun, 13 Mar 2022 02:11:27 +0530
Message-Id: <20220312204128.3942-1-shaikhkamal2012@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: shaikh kamal <shaikhkamal2012@gmail.com>
---
 drivers/staging/android/ashmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
index ddbde3f8430e..4c6b420fbf4d 100644
--- a/drivers/staging/android/ashmem.c
+++ b/drivers/staging/android/ashmem.c
@@ -377,7 +377,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
 
 static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	static struct file_operations vmfile_fops;
+	static const struct file_operations vmfile_fops;
 	struct ashmem_area *asma = file->private_data;
 	int ret = 0;
 
-- 
2.17.1

