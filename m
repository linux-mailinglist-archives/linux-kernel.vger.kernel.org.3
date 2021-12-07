Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E044546B40A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbhLGHjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbhLGHjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:39:06 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0FFC061354
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:35:36 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id gt5so9668452pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 23:35:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IiKSgGyCzx6UXi6dwVZbrgSYwe3nyq+9MEyavhfsGHo=;
        b=gx0amkyfWHJKcgg24pwL2bZml4ibUoS06FZ24+TRrvSPyygfObXMulLLjo9uh3QVB9
         1V6xNiJvkG9tfK2DHlY/xo382iIyL9TtnTWAmuuSSWHMJMyNIpfg1LEuuKkQYs0JhSVQ
         LKjQekv697/gXlXJ2t+5YLGhFTdI1ZFb4Rkc5QrtoS090eSsI/fT0S/As8ICPy8me4IH
         H5gWCKSseWhcha2m4Pr1h0GwTWT3VSCSNWp9bPncGCYQ0wSxjSkGcmQcBCRRdxG1v7ZF
         +59FOuj00c6uDpYM437O5VWMVycsmMhKIcwWkN9E33moneNGXcFKZRgOql5vaAXYTD4X
         gn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IiKSgGyCzx6UXi6dwVZbrgSYwe3nyq+9MEyavhfsGHo=;
        b=DCBhVJC0MChJWSItin0o7ouNZ+lySmb6FwuS1thSO3JaJVJyfQR018+eMGCFRuaQ4I
         aV1pAF+XCE2i0aVjDt+t3jZQwzrODyl2Nadb5IqPX4V1pHA+2de27yvcbOx7PHOiYtMk
         on54EtOd6Nc6KNSHHQq5HwRqLdQCxmyY6gKrgDbhPhZi6zGRQosYY4x8SZIer5wLRWij
         6p9+wjOdBy3h+fZ1JdhKgsr4RQ89AVP45RYrmDOO02TwGWD8JHWzzGvKQg4kd3qERfj3
         1z4mrlLFcHIbDd6KUFjun+8jDwBf5mXsRFzrydtJq7ggJZYWA+XwXfIp+xlbw4m3x3Yk
         lDCA==
X-Gm-Message-State: AOAM530i7wJzayy356cZ/EGNgbh46KA0n3esWsQNdHLsfjQ1QW1vk0PR
        mpeIH58dy9hnirRLb+q4SOznkb360sg=
X-Google-Smtp-Source: ABdhPJzB3Q7OuP61/sHQ1qk8/gGZaSwbDwHq3XJb/OIpsJUeKMcMScu6of2wrRtt0V2Fz4angb++ew==
X-Received: by 2002:a17:90a:880a:: with SMTP id s10mr4614824pjn.214.1638862536166;
        Mon, 06 Dec 2021 23:35:36 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id mh1sm1726743pjb.6.2021.12.06.23.35.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 23:35:35 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/7] workqueue: Remove the outdated comment before wq_worker_sleeping()
Date:   Tue,  7 Dec 2021 15:35:37 +0800
Message-Id: <20211207073543.61092-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211207073543.61092-1-jiangshanlai@gmail.com>
References: <20211207073543.61092-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

It isn't called with preempt disabled now.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 5557d19ea81c..312b806b3956 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -887,8 +887,7 @@ void wq_worker_running(struct task_struct *task)
  * @task: task going to sleep
  *
  * This function is called from schedule() when a busy worker is
- * going to sleep. Preemption needs to be disabled to protect ->sleeping
- * assignment.
+ * going to sleep.
  */
 void wq_worker_sleeping(struct task_struct *task)
 {
-- 
2.19.1.6.gb485710b

