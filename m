Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED31B505AED
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345182AbiDRPYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345197AbiDRPX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:23:57 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5024DF59;
        Mon, 18 Apr 2022 07:25:00 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i20so18724823wrb.13;
        Mon, 18 Apr 2022 07:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7iufcEvsuaQis8fTM7OSiYyDiFr/RCy5Os8Typpr5PQ=;
        b=W8Zrt0OINJ0xXSf2dRTYbcrYN4U9XpiE+RWgguqdzPreePbsZK3wtm+oMnyweiRs98
         FaANv1T/6osU9/lh/hxRXF5AY7ZfLq4othDMrEI+O5Kk4K8MNBoY4EArUC8RPcsvoNPc
         oidkCuySDhCp76GUteUvbOUCXUOF7otdzK5PTMV08/XO+pM6jU+C2r+fngVVtcYPNXGD
         EGo4Qs1X8BxgFiNB4IXSSM8zo3YLBtrmfw6Fr2EsbqVObnpaNyUvEaIa+LnIOHLLD8Qh
         LYMitYcMP9eTag9CCSdNqp6Wv9Vpg7YTM7hou0S4vDF+MrNwro+YIoIqcE9ohBIwr1/b
         XpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7iufcEvsuaQis8fTM7OSiYyDiFr/RCy5Os8Typpr5PQ=;
        b=OYkFVGZGi2NKxS/akLmn/OuFLtuBqUyhSB8h8HQQfokYV59V/PogeEEDN8b3abuVye
         VYEfQ8RO7XYSZJWKQ/T2c7tieIaoeMw3yszPWCHvNlRPf0ZMDv0m+KTqdizL5q2bf81E
         t5pRLocYAqM1+L7r8gX8KvxJ2GiklYi7zu5+EcQF5TR1Ux9yKn+2opRbip70fSDIka4h
         2o7YCkyN+pDtDY8WNpeCspHYkfceKzzITWjwcJUnRrTXPVLjq2tZFun3i9jynndOrd50
         wgCd8iItm8/zYobzmBY/cFD4BZEM7O/a5pJpnkJFLMH27auFG/P6TPcQuOMbcUH4ONZo
         wt/g==
X-Gm-Message-State: AOAM531UcdVh7Fuz48eKNwtIVOKRurx3ZtfmDzibWP7rCQuvR9EOC8G5
        TvMpWvhkTx+T+mldbJuOLMs=
X-Google-Smtp-Source: ABdhPJxgSCQYHJVw47K4IDaCUWF1dHGEQHZ1Wju6gFzH3xzj8cZLw/7ApEOo7PlkwFRxpf1MxN/Upw==
X-Received: by 2002:a5d:6c66:0:b0:20a:847e:10b9 with SMTP id r6-20020a5d6c66000000b0020a847e10b9mr9046593wrz.82.1650291899007;
        Mon, 18 Apr 2022 07:24:59 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t2-20020a1c4602000000b003917d43d339sm10238406wma.4.2022.04.18.07.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 07:24:58 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] Input: aiptek - remove redundant assignment to variable ret
Date:   Mon, 18 Apr 2022 15:24:57 +0100
Message-Id: <20220418142457.84708-1-colin.i.king@gmail.com>
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

Variable ret is being assigned a value that is never read, it is
being re-assigned again in either path of the if statement. The
assignment is redundant and can be removed.

Cleans up clang scan build warning:
Although the value stored to 'ret' is used in the enclosing expression,
the value is never actually read from 'ret' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/input/tablet/aiptek.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/input/tablet/aiptek.c b/drivers/input/tablet/aiptek.c
index 1581f6ef0927..24ec4844a5c3 100644
--- a/drivers/input/tablet/aiptek.c
+++ b/drivers/input/tablet/aiptek.c
@@ -931,8 +931,7 @@ aiptek_query(struct aiptek *aiptek, unsigned char command, unsigned char data)
 	}
 	msleep(aiptek->curSetting.programmableDelay);
 
-	if ((ret =
-	     aiptek_get_report(aiptek, 3, 2, buf, sizeof_buf)) != sizeof_buf) {
+	if (aiptek_get_report(aiptek, 3, 2, buf, sizeof_buf) != sizeof_buf) {
 		dev_dbg(&aiptek->intf->dev,
 			"aiptek_query failed: returned 0x%02x 0x%02x 0x%02x\n",
 			buf[0], buf[1], buf[2]);
-- 
2.35.1

