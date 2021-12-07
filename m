Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8D246B40C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhLGHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230478AbhLGHjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:39:17 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD20EC061A83
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:35:47 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id z6so8828331plk.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 23:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dsXlIsf76JNMatfuhwAUdEA84/JMo3Ts2ABkDWjK+mI=;
        b=K8YX8uuRjz240hFUNPcphLvGew8dZ+iZbpvRwzKXUXcD7XH4HDrz/wTBzlyPPXefI7
         dBKwJp+Srg7bXGGB7jz7my28m2U7mGp6OYuHte1AvfrDJUUnmRaiOUSmiV+gyAGJMxzK
         hsDNKpO1veFpF5nltFvWQsNXZL1LjT0XdAXewgifWJa96BknmVRIIcuv9Re20gdYwhN7
         nrZxGplN+dFldIaHKoRaGqryYPZYZ2qFpwx1FDp+PTC74x1FN4N0cYlZ7evfRs/ohBss
         UB1BQEUmfvIHhymi68L372N5WIrnmJA2Ewf7zM7LJfJbxWGfTd6a3w3E+bOq4AdtfA6E
         6Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dsXlIsf76JNMatfuhwAUdEA84/JMo3Ts2ABkDWjK+mI=;
        b=w2H6rXxRXtEdKMb4lpnFUAs73R/RpVRx10Y8xDe7mWYUaD3mX1mo4pzyYlnCVCbjn1
         tpqi/R3TsVHPUCjEGev2dsnYr9udFijkGzs+xalLLmOuI9RPDxzBiSIKPhEQKIt39yY6
         WrPvtYPaq6K9n1DrazNtDxQiMBzPWwphwUhBK+nVIUWwy9c2Has9xvw4k3ZXnR9FVnPk
         K383+NNAWzeBszKmgLYRU8rYoy/stP2AHD5x3BIyOb8FtPAMnUpgi7XXAn5Gtcd8hr25
         23LqPCRUTsyn6g26VtpDuWeuI1cIRGzFHojq09kTaRSUaHCL6HuzQgLKhdE9ZYMnxu/l
         dCjw==
X-Gm-Message-State: AOAM532EBdV/n1AcwTvpGgDiRWAREF/hFdy+q8yVCDIqZhe11FMslDaj
        aLCVrLY4Hm8/hazJSGr5Od5nAumHzN8=
X-Google-Smtp-Source: ABdhPJwMdUmEPglBwsjuNrhnlKXx/DmOsFUcc97MozQegLTMENXDGDs4r/7RGFBhwQbzIP5LDbt4aw==
X-Received: by 2002:a17:90a:ec15:: with SMTP id l21mr4627080pjy.48.1638862547368;
        Mon, 06 Dec 2021 23:35:47 -0800 (PST)
Received: from localhost ([47.88.60.64])
        by smtp.gmail.com with ESMTPSA id d12sm15646124pfu.91.2021.12.06.23.35.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Dec 2021 23:35:47 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 3/7] workqueue: Remove outdated comment about exceptional workers in unbind_workers()
Date:   Tue,  7 Dec 2021 15:35:39 +0800
Message-Id: <20211207073543.61092-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20211207073543.61092-1-jiangshanlai@gmail.com>
References: <20211207073543.61092-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Long time before, workers are not ALL bound after CPU_ONLINE, they can
still be running in other CPUs before self rebinding.

But the commit a9ab775bcadf ("workqueue: directly restore CPU affinity
of workers from CPU_ONLINE") makes rebind_workers() bind them all.

So all workers are on the CPU before the CPU is down.

And the comment in unbind_workers() refers to the workers "which are
still executing works from before the last CPU down" is outdated.
Just removed it.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ba8cf5f5e7fa..ad663853bb78 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4998,9 +4998,7 @@ static void unbind_workers(int cpu)
 		/*
 		 * We've blocked all attach/detach operations. Make all workers
 		 * unbound and set DISASSOCIATED.  Before this, all workers
-		 * except for the ones which are still executing works from
-		 * before the last CPU down must be on the cpu.  After
-		 * this, they may become diasporas.
+		 * must be on the cpu.  After this, they may become diasporas.
 		 */
 		for_each_pool_worker(worker, pool)
 			worker->flags |= WORKER_UNBOUND;
-- 
2.19.1.6.gb485710b

