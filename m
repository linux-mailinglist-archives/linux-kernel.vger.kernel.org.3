Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19164AD7DD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358818AbiBHLuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359750AbiBHLuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:50:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223E9C07D6C3;
        Tue,  8 Feb 2022 03:46:59 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k1so13686114wrd.8;
        Tue, 08 Feb 2022 03:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmKAUjm7Amkz4S/+pPvWtraWrpa9Qq6Jt7Fq2nrePGY=;
        b=EgeeHN4vzoL9zkyQQVYX1Lnc+cX0DZo1vKQPHeupYiXrhuhX3nBJAOCYY4IBoqxlyh
         aaElxz/kT4CVD5ywumrG53+6Lbl4dCv1lTwUVOfJWALhBAlRFVmBcKRjmO7El/TbWlHH
         w5ygQguZlGzTZrItZ5bMdJq3b1YNzmrxI49/7yG06HqexxLtBzh7VpV09oxNY+gHDMoz
         voXJCeuN6gY4tomhUKUOhcOlL1StV4b+hBtrXzmQDg70ZZh8nFUZQlbqlwoPWR0LN8hr
         mncBTWERBiafqsGg1V8Iv4MxqcrFjtvswXqQQfYWa2zSigAQPJYdhiOckoTYf+Zy82pb
         55tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TmKAUjm7Amkz4S/+pPvWtraWrpa9Qq6Jt7Fq2nrePGY=;
        b=3rq9OAzRUzxvX7OvV1yrNCUtWxU0n239jAt6dPU14zTlXfxJwYoo6IsEKy1uCNIjgp
         G9rkyaZ/sJRIZA0x6FYEv8cPAwZibr+p1URf78A14Z8viOQWicKyWp3e7TXGBJcF7Hz5
         uSI7dkx7Ru/TZmM/RtgWiDeC9+PTUEBuwQ46+rFW2HQ3la3kgE/ddaYgn74vHvvlIIaR
         QoDu4UkHREAQnKk7HigTl7/WmLbhRxZbMQGNPikYSFGxnDe4sWZ/3eVfYgShHdTZDJBY
         Nz26PtU7G1WYAoAE2z4/5PNrr3FNmp1JxrkpKwiCH961Nfq28KymLbgiA2pkH0ycYBkA
         ZZLA==
X-Gm-Message-State: AOAM5339NysVO6QAgbP66cfOt1NnNSIT2QU1ix3PR0d48xFrqlid5KZA
        hsBux1wNYnK4nK6x8EJs7hU=
X-Google-Smtp-Source: ABdhPJydTeiXL4oQvRW9uwlGPuG9NdNqDOm+HT9vlgGdbCLc5ktplVB4jWosm30UjoJiuT+AoLlU0w==
X-Received: by 2002:a05:6000:4:: with SMTP id h4mr3150446wrx.336.1644320817649;
        Tue, 08 Feb 2022 03:46:57 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id c13sm12650329wrv.24.2022.02.08.03.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 03:46:57 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] loop: clean up grammar in warning message
Date:   Tue,  8 Feb 2022 11:46:56 +0000
Message-Id: <20220208114656.61629-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The phrase "has still" should be "still has" to clean up the grammar.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/block/loop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 01cbbfc4e9e2..bdea448d2419 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1262,7 +1262,7 @@ loop_set_status(struct loop_device *lo, const struct loop_info64 *info)
 	if (size_changed && lo->lo_device->bd_inode->i_mapping->nrpages) {
 		/* If any pages were dirtied after invalidate_bdev(), try again */
 		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+		pr_warn("%s: loop%d (%s) still has dirty pages (nrpages=%lu)\n",
 			__func__, lo->lo_number, lo->lo_file_name,
 			lo->lo_device->bd_inode->i_mapping->nrpages);
 		goto out_unfreeze;
@@ -1482,7 +1482,7 @@ static int loop_set_block_size(struct loop_device *lo, unsigned long arg)
 	/* invalidate_bdev should have truncated all the pages */
 	if (lo->lo_device->bd_inode->i_mapping->nrpages) {
 		err = -EAGAIN;
-		pr_warn("%s: loop%d (%s) has still dirty pages (nrpages=%lu)\n",
+		pr_warn("%s: loop%d (%s) still has dirty pages (nrpages=%lu)\n",
 			__func__, lo->lo_number, lo->lo_file_name,
 			lo->lo_device->bd_inode->i_mapping->nrpages);
 		goto out_unfreeze;
-- 
2.34.1

