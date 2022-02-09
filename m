Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A314AF6DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbiBIQh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbiBIQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:37:24 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7DAC0612BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:37:26 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id c5-20020a17090a1d0500b001b904a7046dso4110411pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H4jFxmUni6FbOkZnCa6JLyaPCS22eEc+ZVQfL1y8iaw=;
        b=WWs21SjLS3G9zEQAIJzi6Y6yF1/J+ccsfWGeAniVbYn726FpGywZOsylkpxebp+18n
         YJU4oHS0bf16sn+HhUAc7Nq7Nd0jFUxHn5tEyetgQsTqNwVqa1Vma/zAp84Rkwv3KL1i
         p+ojDVWVuvv8KXVwKBClepAbIbwmYuK2da4kNWFAd854w1NWAQS4p6g0L8NPNWeqgLSr
         H6xNZm0UyTNj/Rb5A0ZZu5CLNhVPewQTdiwi9WzmYwsEokvS1r9G6Z7KwuaGo6W3X4ue
         pNzJGuapPlY69LrFWF45TNU3kX2sdrGSmNQZREdCfOhuTyLJ5HyghZfF4CxUWfvsfxqj
         r6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H4jFxmUni6FbOkZnCa6JLyaPCS22eEc+ZVQfL1y8iaw=;
        b=wr1tyfMPqE4GhNs3vudp8w+Q0eas1S4R/0BLfjfy50iWP18s0v5BKws2VzSvJQCV1Q
         /WA1CKkgrTS2ZIYoFSQBIJhPkv0tZgX97hDlWNo5UxZFGhLTp2AmrZLGrx4RdBfGpiU6
         4obzu8NVW82BjVCTxVmZKnnNqsCMD09Ywve8xS1QZGCAccfCSpVCffjiEPhQVcL7BGd6
         n0tLi46TuOBYf9g7cvKdtZHpHbd05UOAM8WA9+rRww3ibNWt972QACMtnD7gJTF8UUXD
         /mxiWvcjJVLB8lbDiAtXkysC+L8hcuFvMtHe3Hwc7pe1gSClF3Zojy101XG5MIE7Obot
         Cshg==
X-Gm-Message-State: AOAM533NaLykpdSTQWDifA4DHpRZv5qCfxTgYStVuTStptjjJCxdjTql
        dQC4AfSInqzYR42CZpzV/v8=
X-Google-Smtp-Source: ABdhPJz83GkpvY+UeNicEorQn/f50/2QRTWl8JDgzZW4eysK1CN8l6OFz3rwi1CuW+GpB01eTN17RQ==
X-Received: by 2002:a17:90a:2e0a:: with SMTP id q10mr3443760pjd.130.1644424645601;
        Wed, 09 Feb 2022 08:37:25 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id kb18sm7840199pjb.30.2022.02.09.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:37:25 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 1/9] staging: r8188eu: remove unused struct zero_bulkout_context
Date:   Wed,  9 Feb 2022 22:05:59 +0530
Message-Id: <05b72a7b045a829de6f706295d17c9f0d5fa5e2f.1644422181.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644422181.git.abdun.nihaal@gmail.com>
References: <cover.1644422181.git.abdun.nihaal@gmail.com>
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

struct zero_bulkout_context is not used. Remove it.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 3977a717d30a..d75933c73946 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -20,13 +20,6 @@ unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr)
 	return pipe;
 }
 
-struct zero_bulkout_context {
-	void *pbuf;
-	void *purb;
-	void *pirp;
-	void *padapter;
-};
-
 void rtw_read_port_cancel(struct adapter *padapter)
 {
 	int i;
-- 
2.34.1

