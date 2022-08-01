Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE64358628C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiHACZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbiHACZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:25:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F3B2AE6
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:25:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h21-20020a17090aa89500b001f31a61b91dso10852829pjq.4
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=EVBoyRWZigkccBsvB4uh5xlF3s1rJUHBaQVZeXyiy68=;
        b=ftsjD0vsSTdUSAtjICFc5VLtK0DuMYkrCipIK+3xEfRxuyD1Ft8rbDG6h7znNIGZEO
         WoJEJhUexPRnABkElPICbvzjXRskN321/XNAg23r+B39jp80ez3MokGqdQQtJck9iZ4K
         eDBDmVgYaewLCsen0tyj/lArm+ARV7m5VG2aIHI8EMdV0Uc3n+8AH0xeA/aGZgMCE5ZX
         akdSIHJybpWhvQpgpUqrdqIkWcx8eSvPO/F/ZZlmP3zJwlAdQ0MD19iZhLapgnMd6/1J
         jBibAJdg61wUlTdjjAhXqErmpEbjAkqwUYx7t/oPSCgh7YrB9JY3J2o5XKhWksFs0XNo
         reFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=EVBoyRWZigkccBsvB4uh5xlF3s1rJUHBaQVZeXyiy68=;
        b=kos8E4X8J8MS2DXVB2SXvG1HLEdeAIuwErFjN/3QCz5vGHPdye2AArqIskZZBBvNNu
         iimZK6+U6CYAC3hwUyjkjskZQDPDdnuZG5lAqFeBuN3cuwtPKRMP3pEFOqrUIceocv93
         5JlpjLiWystk0m5Vd4oporlxI5iYg04U+XhSp1U7cPbAlXkF2cP/ojFW0heH9u2jSmfh
         3e/sFDV0riBcyMb8DHesYmVGNu6tG4jrAkLLzQpwLyKL3CUYt3+LmXO2ILvmtREp/yht
         SbbQW41zkC4Mbl5RaeIRGLbbfNqua8Kj//iyMJlm164hlY+4frx2zaLxYodig+HSWwiS
         MCuA==
X-Gm-Message-State: ACgBeo1NXNpVlLuRIhtvjYesqyrDf7bUEjO2Xr8a6ph8oUv2M00IamGz
        nV7ilIvJd87uHu2C729ZE76R213lXS8=
X-Google-Smtp-Source: AA6agR7aNyMg2Wo2Fkh9Ql/YgG/B+msUN4m1xsfJUklb5q1MqEExamxbZAzRou9ZYayAxJPO6Dikrw==
X-Received: by 2002:a17:902:8502:b0:16c:c5c5:a198 with SMTP id bj2-20020a170902850200b0016cc5c5a198mr14528236plb.88.1659320725884;
        Sun, 31 Jul 2022 19:25:25 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id t3-20020a17090a950300b001f21a8f7f14sm7431098pjo.9.2022.07.31.19.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 19:25:25 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org,
        ye xingchen <ye.xingchen@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] macintosh:adb:recordmcount:use !E in conditional statements
Date:   Mon,  1 Aug 2022 02:25:21 +0000
Message-Id: <20220801022521.1594464-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Use !E to replace the type of x == 0. This change is just to 
simplify the code, no actual functional changes.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/macintosh/adb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 1bbb9ca08d40..368ab25db234 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -673,7 +673,7 @@ static int adb_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 	state = kmalloc(sizeof(struct adbdev_state), GFP_KERNEL);
-	if (state == 0) {
+	if (!state) {
 		ret = -ENOMEM;
 		goto out;
 	}
-- 
2.25.1
