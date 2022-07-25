Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1623157FE98
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234753AbiGYLp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiGYLpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:45:24 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9606AA1B0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:45:23 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id f3-20020a17090ac28300b001f22d62bfbcso8159752pjt.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1waDT/Uu9da6MNp40DJuFsfnaQFRitkplpYUuVaMUX8=;
        b=m7RBCc7XVK3O2lCDZq14AWHEcgTmWs2nRhStjd2dmQaYdopcG/xxg70UM8WLKMRnfP
         p7F5alMmzqqFL6uIEducyKx+kVLTyGApEkWWgW801f1xUgh+H6THXoSQ6wwe3vA9++h4
         OtLpftQ4vGO6No9VV3/PqTWkDZ4mg+XAIvkhtMsnniv8VdZLJC0G0HYxnUPHcD3kpbjo
         hBT/dKmU48E9TuvcEcvp48UQTJbDkKQnWYLFjDKROB0s+RLYWkaLd9fziaP6iHAxBJsX
         jri3K/7vkYI+Ujvm6+/Vgc+gYbD04uwnSJuKD3v10MEsBxiwRwQ6B/7OD/DfxHsjawqY
         dLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1waDT/Uu9da6MNp40DJuFsfnaQFRitkplpYUuVaMUX8=;
        b=O38hQcA8Kdjr96dRw+v5utBi2N6frPFn3UzGJJ/vKMhNr4Lp7APmSPYr+i514BfRa5
         94IRMcB6TifERJqJEG7qu5u9nkJY+BGYtE1T6z9rr3uhXlAZmRQA1Ngv8X97WseTktqh
         bd/w4euuoe+1G5HTHDc+EqMxB+3vDZDn3ZDmmhMJk6+1by5Y6eaFa7ofXyf206807k5w
         TCEOxKvE6xF6Bp66zV/uydGsHjgTdcq+h3QQKUK1GUQSH8JI0Cz62Tz068ZUh2ThfmJS
         mGN0i0FJg14jj8alBHUQlh+HrX4kyN52EGXNU1RdOoMWaM3GCHF64YvMZYE9QNjYtWk0
         PXeA==
X-Gm-Message-State: AJIora/I3pxzyX5D0eZxOtECiworDosdO0qf6XWBzf3eCAKiIqXYfVEW
        GfBUKn63OQdX0pX8rmsQhrG6uUmDKrTwGA==
X-Google-Smtp-Source: AGRyM1sRNKC474Vo7/sTrqvEIRriUyLHySpKLEsmxxNUyVQQnn1FqOModHgArQqt5HNLZ95JsS0R9w==
X-Received: by 2002:a17:902:a418:b0:16c:9ee2:8a02 with SMTP id p24-20020a170902a41800b0016c9ee28a02mr11738377plq.46.1658749522575;
        Mon, 25 Jul 2022 04:45:22 -0700 (PDT)
Received: from localhost.localdomain ([175.195.128.78])
        by smtp.gmail.com with ESMTPSA id 7-20020a620507000000b005289f594326sm9334989pff.69.2022.07.25.04.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 04:45:21 -0700 (PDT)
From:   Sidong Yang <realwakka@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     Sidong Yang <realwakka@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: pi433: remove duplicated comments
Date:   Mon, 25 Jul 2022 12:45:13 +0100
Message-Id: <20220725114513.85089-1-realwakka@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Remove duplicated words in comments for readability. The words are
duplicated from a sentence below.

Signed-off-by: Sidong Yang <realwakka@gmail.com>
---
 drivers/staging/pi433/pi433_if.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/pi433/pi433_if.c b/drivers/staging/pi433/pi433_if.c
index 941aaa7eab2e..df02335fdbab 100644
--- a/drivers/staging/pi433/pi433_if.c
+++ b/drivers/staging/pi433/pi433_if.c
@@ -1406,7 +1406,7 @@ static int __init pi433_init(void)
 
 	/*
 	 * Claim device numbers.  Then register a class
-	 * that will key udev/mdev to add/remove /dev nodes.  Last, register
+	 * that will key udev/mdev to add/remove /dev nodes.
 	 * Last, register the driver which manages those device numbers.
 	 */
 	status = alloc_chrdev_region(&pi433_dev, 0, N_PI433_MINORS, "pi433");
-- 
2.30.2

