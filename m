Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39A849CA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 13:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241546AbiAZMyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 07:54:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34265 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241540AbiAZMyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 07:54:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643201686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=33HY34cD9z5vOB4yb8+O1ko0hzCxvVEJ/j6ux5soDhI=;
        b=gfOX3LzzgSVcPV07cy1OXO9AFv5Sk3HLM4OtQQAbiJ+kumCu/C8QUIOHaX14D3k3o6W1By
        IRN9Tk3AmzskNgYYWnGgzgIlA7v94qKtOEOnMPs+zDRq3n46JZp2fT0kZYJhM/ypk2VdfV
        IBSQjbvmmBnahwSGNpAXEQfRBcU0xsM=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-56--I9YqabANU6EW731q_sABQ-1; Wed, 26 Jan 2022 07:54:45 -0500
X-MC-Unique: -I9YqabANU6EW731q_sABQ-1
Received: by mail-oi1-f199.google.com with SMTP id g4-20020acab604000000b002c8b24c3964so13261304oif.22
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 04:54:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=33HY34cD9z5vOB4yb8+O1ko0hzCxvVEJ/j6ux5soDhI=;
        b=QANGGHZyqpujna6D75Iiiuirj+ueRabYcIQm+1xzIsF0kekRuv4EI1i6C4MkZSzep4
         +eghenPh0V41cufTFm4NKBQg9abM0qigdRcdizcy5pcZu4kNj8Q7C/8jcE1Z6/7jdcYs
         s6aUtaZF+v3uHBh5DezBLnBI08PM2UELLroNOGjba7kNKz/8NnQ75v5x0L4TRk+zFFpo
         oYZsb49EJTsoGaY7FT50ejCn/c9gVEendXANE9vcVJ6LBCdXzIsEs+wv/3WrS2zJDnmg
         Rj6UXuew6KtZTE45moifx/uRyKjW4dUaSkhdNks6MUfdzMdonaiQCQoiDVcqfqJzm5OY
         8IJw==
X-Gm-Message-State: AOAM532PnghVk7tgdQSX3g9cqDkB1xEYaPbiQCq2JKOrJ0cmpWvj2v35
        8kF3mI2UKXfd+Lv+LSE6UQhkSuKzsXksbOy6BIi3U2iysJxPlf9tt96MOvp2+u5KD4GYGyg52UC
        a5JWhRfnew+PI8EyC7jUCQux9
X-Received: by 2002:a9d:2031:: with SMTP id n46mr12899732ota.190.1643201684459;
        Wed, 26 Jan 2022 04:54:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy2crbAvizgEsJk/RGFNhDLfbjahYu89AEq2rjYxbM8xbYbGTnrtziTAXrmvwJCdrYqz2yExg==
X-Received: by 2002:a9d:2031:: with SMTP id n46mr12899727ota.190.1643201684245;
        Wed, 26 Jan 2022 04:54:44 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w62sm1678846oie.4.2022.01.26.04.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 04:54:43 -0800 (PST)
From:   trix@redhat.com
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] seqlock: cleanup double word in comment
Date:   Wed, 26 Jan 2022 04:54:37 -0800
Message-Id: <20220126125437.1166862-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'the'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 37ded6b8fee61..12156166c6365 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -867,7 +867,7 @@ static inline unsigned read_seqretry(const seqlock_t *sl, unsigned start)
 }
 
 /*
- * For all seqlock_t write side functions, use the the internal
+ * For all seqlock_t write side functions, use the internal
  * do_write_seqcount_begin() instead of generic write_seqcount_begin().
  * This way, no redundant lockdep_assert_held() checks are added.
  */
-- 
2.26.3

