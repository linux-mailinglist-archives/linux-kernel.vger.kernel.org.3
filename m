Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C1134686ED
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 19:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385390AbhLDSSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 13:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhLDSSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 13:18:43 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E11C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 10:15:18 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id r130so6178675pfc.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 10:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQlMNNyyibbtLZwlpfOnpdvAksqhJsZKvwfYADxJ0xI=;
        b=BQPvbI72cOQ67QRSmG6GYbQkWPgqtxxCM+ymfT7UaQpFKOvxcFykJtzQcXI32MFXmF
         b55S3zcjDvp0qgJWeMvKDsqnhM9SR2xBCiSCqLY5OnWfNvGne3rrsaUqScqZiwiCX5FE
         aFkpxHREcIXLbJDTfEqtwUDgaLi/4jsPtJMHJX8GIgv5aq5I4aBLf0ofLJxlgpGFRbrJ
         flfveTY3GlGIttVIW2jfYwbE8NCMODNfTESDqizq3VYah7i+71Ye+APF2sS5XAuEaQB4
         ULLrvfe42XXUqLfUyS6j2HDpxCWhmk23DOZrnyeQkLbFx0Lw3p2PEyNSNSczdS3h19Cr
         RySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bQlMNNyyibbtLZwlpfOnpdvAksqhJsZKvwfYADxJ0xI=;
        b=b5V5BT0/6cFDtHvwph316lfkEHrXBOYd6MvUnYpDqO1j70cjgzO4yaWU/6TRbaXHH0
         /4r9oNss3UUYgHTSqT605sEh3zonGVcYFnhGVXdEGJ8M7gaPUWnKp34xZd8XQFm0QVRu
         2s+dwpMb5fQc70iPAHly5mEit1MqMURGClsrEr5RADAiNxlE+8ixIHjqqFmcLEHRRWfJ
         60+/C36DFdZaockT+NhhA/fuaZOmMgjADV45HdAv9+0Of3jmqv+dOhhumJM3GpvvixeF
         3/fxTDWO7HnBFTIp7WZvtJQnCFDEWMyOzIg+7ogVq4eH0GBiXB3XZBGUprcJdNUKvICM
         iJJA==
X-Gm-Message-State: AOAM533poKUnbnZTIWSXwAQyeiuQKDJtwJxl3/JtYCAY7tW48zCfZB/A
        YSrxudM6OpChHjSKztfnohj0qMesGfpH2w==
X-Google-Smtp-Source: ABdhPJwz9YQT5i9xWvbfzUxMW+v4vlqIv0RXffBpJCYWVp7HxBKtLKks1kqy4xw4IW97I44dzq6VxA==
X-Received: by 2002:a62:6542:0:b0:49f:c35f:83f8 with SMTP id z63-20020a626542000000b0049fc35f83f8mr10757776pfb.47.1638641717603;
        Sat, 04 Dec 2021 10:15:17 -0800 (PST)
Received: from DESKTOP-OO3QD6O.localdomain ([221.162.118.197])
        by smtp.gmail.com with ESMTPSA id q5sm8068130pfu.66.2021.12.04.10.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 10:15:17 -0800 (PST)
From:   6812skiii@gmail.com
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com, linux-kernel@vger.kernel.org,
        Jangwoong Kim <6812skiii@gmail.com>
Subject: [PATCH] futex: Fix a faulty comment.
Date:   Sun,  5 Dec 2021 03:14:58 +0900
Message-Id: <20211204181458.10076-1-6812skiii@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jangwoong Kim <6812skiii@gmail.com>

We return 1, not the index of futex woken up.

Signed-off-by: Jangwoong Kim <6812skiii@gmail.com>
---
 kernel/futex/waitwake.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 4ce0923f1ce3..d148e5d4956b 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -455,8 +455,8 @@ static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wo
 
 		/*
 		 * Even if something went wrong, if we find out that a futex
-		 * was woken, we don't return error and return this index to
-		 * userspace
+		 * was woken, we don't return error and make userspace aware
+		 * of this by returning 1.
 		 */
 		*woken = unqueue_multiple(vs, i);
 		if (*woken >= 0)
-- 
2.25.1

