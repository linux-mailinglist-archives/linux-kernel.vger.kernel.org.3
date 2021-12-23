Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB7347E33A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 13:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348246AbhLWM2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 07:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348245AbhLWM2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 07:28:05 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3052CC061756
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:28:05 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso8691726pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 04:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=UTE+esZ/4TZyUTsTUlc3WjOYgKLVtNI6J28jxD1ZZj8=;
        b=eKdRwn9hwBJl059PMqq+lnBBSTypk064f7yg18Ny/uZ59Hb68D0LVTJrvbjEzYTtF8
         4FoSN5D3fheMvB3OpF0za9TXOssZShkP1wdhyGxlvQqcjUgirkVO9pRWpxo/hWKJ+22V
         fCgRVIyMS4h9qXoR+5RVrohd5h7HOoUqGWM44isEcFLQ7BO/00WehZKdLA5lqLlAG7Rs
         Wmx9fx67QRs/NJrUyVqN9OjQPZYt6D/IUUiiKxfEoQJ64xRHTg7w13JuXHPMWq7Pp1iJ
         4dJ1yV8Vfon9Cy97+iygodECXB6OB2TPB4Yu8JwC3vh7x1LzNIfQ6g9BUTbuLO1tnple
         L7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UTE+esZ/4TZyUTsTUlc3WjOYgKLVtNI6J28jxD1ZZj8=;
        b=Lot31+0Kjs8p+18ktQcJzMCG9VBpIgMW/wHLcpnhOqm426Cx9rsV5klpi22uO+eg95
         6hfDAnijkZJI3t/SzH/PgyfeaomOuWPjvq+AtGRcXjnUSFuW/1zo4DWmC0rJySKU/3TG
         T5GF/4m8ci8g5TFQLfItzsqpHJmU/18iDVmS8szU+vEcSUPXgB0Bh2YSAni+pF7Cq/JP
         6dqyDnXcJ42dEKL9mXQCOoAOvIhE2Mxz++SApktT6DSvbEHzHOCpYc5fEq8rl+tmxbAH
         s3XDvxQ41O2SuyaDVy2A1imkKdA3jjO8k/xxlm5PJ55ZByG85XTWM6/ni71AJpLFAN2q
         iQGw==
X-Gm-Message-State: AOAM533MB0Me2COLGl3FOiuG9a9gILK+wRXGLNW+3JJG2huOBn+HKJ8z
        RmwAIJPjGNtSUcxIZzzplAk=
X-Google-Smtp-Source: ABdhPJzg7Mwt96r2GaK4bRD0hzz5ri5NBVjYic7qtdtpte0/085VWWJToSGswgWI55UpkOaOAy8byA==
X-Received: by 2002:a17:902:b197:b0:148:a2f7:9d88 with SMTP id s23-20020a170902b19700b00148a2f79d88mr2130486plr.167.1640262484345;
        Thu, 23 Dec 2021 04:28:04 -0800 (PST)
Received: from localhost.localdomain ([117.254.32.221])
        by smtp.googlemail.com with ESMTPSA id bk17sm8853512pjb.3.2021.12.23.04.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 04:28:03 -0800 (PST)
From:   Ajith P V <ajithpv.linux@gmail.com>
To:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, christian@brauner.io,
        hridya@google.com, surenb@google.com
Cc:     linux-kernel@vger.kernel.org, Ajith P V <ajithpv.linux@gmail.com>
Subject: [PATCH] binder: remove repeat word from comment to avoid warning
Date:   Thu, 23 Dec 2021 17:57:25 +0530
Message-Id: <20211223122725.29842-1-ajithpv.linux@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

binder.c file comment produce warning with checkpatch as below:
WARNING: Possible repeated word: 'and'
Remove the repeated word from the comment to avoid this warning.

Signed-off-by: Ajith P V <ajithpv.linux@gmail.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index cffbe57a8e08..fc0f4e8b58bd 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4436,7 +4436,7 @@ static int binder_thread_release(struct binder_proc *proc,
 
 	/*
 	 * This is needed to avoid races between wake_up_poll() above and
-	 * and ep_remove_waitqueue() called for other reasons (eg the epoll file
+	 * ep_remove_waitqueue() called for other reasons (eg the epoll file
 	 * descriptor being closed); ep_remove_waitqueue() holds an RCU read
 	 * lock, so we can be sure it's done after calling synchronize_rcu().
 	 */
-- 
2.17.1

