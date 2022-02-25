Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC04C3FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238347AbiBYID4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238348AbiBYIDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:03:55 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68A119D612
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:03:23 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o26so3314788pgb.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=pATmZROrWiuG5CWs1kSYk2Oan3U4G8+HjVhDW4324ys=;
        b=kkM689EQ5WPDqsWwfkb20CAFFR7mEU5TXmtqcIiDCShdf1rtfcQLvVcG3s7ptn/yVB
         rDuOOIxMg36Cv17J+jZYMN/C3iYh3wQj35fIXYWGT3ypRMLkXfyV0n8fbADG3ZSsfO1G
         1MAzDGivTrXdBtoJZFsJUxLNH5Ype3qFWIw4M6dcqNg74qhcAvLbDPJyq112nWj4RWZm
         0XdJRWbyZoMJiaPGVRZvs/YTzjNfCcYmv9kmt4lh6jwgw4iC2J2bLn/hBywQmoVZ1cQ8
         9kvpm3aP68/sOWXFJ2V8dAYTZ2fr5fKfd8whpbkfFnei0oAFmYd6bfOpp0iekoatApdX
         HOSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=pATmZROrWiuG5CWs1kSYk2Oan3U4G8+HjVhDW4324ys=;
        b=R0U5E1ubOPg4vCBs0ShqWWvkAVi/DnKfZBOC2FnBi2MoVEGJWDGUNH5QlKijJXvyGG
         Ix2UtWf70xfXQce6utC3bMa9Mc8dqtnSA+FOMRt/rC5Zq74Xi1RRWZGVlVc4Jwilvf62
         TUaPtWINRO7ixvuEDbHteI+STMQ+SK8bnTb7UE0G0t3zgd9kDH7FeAlnQ1653hehiOWu
         m8sOiwN7zYgTzOkEfEmtt79XWMUoDnkzuxHOJplijAliPFMJgzpr/HYrtUWtLr3wbrTC
         jfYifgghht2m/kqDoHCZxeG3/DsiXXQDyM7EPyzrrZbuukxUB188F9VzC5izyoLBuTJb
         niqA==
X-Gm-Message-State: AOAM530hdKjV2Kn7LW9fzJ6IZUXzW7jirJHaopao9lBVlF8YWJeowB7M
        UirjfpljcEkVDFoLUdUJ3Hw=
X-Google-Smtp-Source: ABdhPJy0gMwqLyE0+7tN6+q2loHkORGpgvzfluL2SdR/pNhk48Qm3AJK2kn2ZtRPDQSvKhAHivNk1w==
X-Received: by 2002:a05:6a00:24c5:b0:4d1:65bf:1fe0 with SMTP id d5-20020a056a0024c500b004d165bf1fe0mr6561632pfv.0.1645776203359;
        Fri, 25 Feb 2022 00:03:23 -0800 (PST)
Received: from mail.google.com (122-58-164-114-fibre.sparkbb.co.nz. [122.58.164.114])
        by smtp.gmail.com with ESMTPSA id nn17-20020a17090b38d100b001bc5a705fb2sm1557900pjb.26.2022.02.25.00.03.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 00:03:22 -0800 (PST)
Date:   Fri, 25 Feb 2022 21:03:17 +1300
From:   Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To:     gregkh@linuxfoundation.org, paulo.miguel.almeida.rodenas@gmail.com,
        realwakka@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: add index value to write dev_dbg statement
Message-ID: <YhiNRSi7jijxJWCL@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add index value to the string that will be printed by dev_dbg for better
easier visualisation when debugging. For instance, if I have a big
message payload that will inevitably get split into chunks, it would be
a hassle trying to debug if the offset of the original payload that got
sent at that time.

This patch adds index value to write dev_dbg statement.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 drivers/staging/pi433/rf69.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 901f8db3e3ce..1a0081ebf63c 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -869,7 +869,7 @@ int rf69_write_fifo(struct spi_device *spi, u8 *buffer, unsigned int size)
 
 	/* print content written from fifo for debugging purposes */
 	for (i = 0; i < size; i++)
-		dev_dbg(&spi->dev, "0x%x\n", buffer[i]);
+		dev_dbg(&spi->dev, "%d - 0x%x\n", i, buffer[i]);
 
 	return spi_write(spi, local_buffer, size + 1);
 }
-- 
2.34.1

