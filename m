Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811EF46F1F2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243022AbhLIRfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243006AbhLIRfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:35:23 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BECCC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:31:50 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b11so4388639pld.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DwKL79kls1XuF2KeVjpre+XvAupMytXZT6K6VUOmIlA=;
        b=L1ZLb/J7YpiBA1svLseKa4zwfTPCBWv3/Vp9SxQ0mBch7YPjpjz88hIwZ5tUejLPrj
         9FeL1YzRkhfMQGaM8dDmiQEEKEOEPszfkPymPI/lN1gm7lto2kr9oPP3nUBBGrx2ZLOE
         DZDeZhm+FqjAQTm7tMn365YUykVoMcumrjrt9TNRou1Q7sOejUXhasn4i7mn5CiIoU+1
         x24LTPmtAWniFE1KGyWHOcTqGjlCWQxw+h4vK9KO19o6mGhplyTe3yj+he2XbLr+8nxJ
         G2ZaGUqMIcVfp2EclXFUhAmJ4CJE9dOwaT9e4VzkbpbD+Tdy03pS85cCUqA3Vhtl3Hiu
         jaQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DwKL79kls1XuF2KeVjpre+XvAupMytXZT6K6VUOmIlA=;
        b=ojQf6NFnryoOiuwBpyyg83dwjTtC6KW5ceUDfUYrecuOyPYLhLnf+JimBWqSKv13ZR
         uOViGuG0W8odY+vNweczh6MWV4OqKgsOttI5dApMJJ79WS91stE74+xmTPkQx+NnDICH
         qC+sRtzP/BmNTJ5gp1AT58FApN52NI3Um2hwGHzT5wIIJmLOvMuUhPFsbAmcsCBtW+AQ
         WDEpTCz3sNOMhbfBB3VHDCfrVJsnCN95Crafpwmm1KybcGJ497pqTRyUm2zw0KlDlXoq
         A3R/f1hgDoIwLqtOChNFnQChiNBTjbBfdZZz7mD5xMoZBezVcP//C/lnOV0YpZbj2PTO
         pAfQ==
X-Gm-Message-State: AOAM531zM8PkYxCg5mMtXdQHdZ4qytxtWaDCnn11anMopHofApOsS4qi
        UONl4vbsBvHICD84G1u60tw=
X-Google-Smtp-Source: ABdhPJxAGJHornCKLs/temQCaZ4n6SLylodD0ZExz/ku/scZ18Vd4kvtF79NKIbzERNYSmK7HwtYew==
X-Received: by 2002:a17:90b:3a85:: with SMTP id om5mr17509376pjb.28.1639071109714;
        Thu, 09 Dec 2021 09:31:49 -0800 (PST)
Received: from DESKTOP-OO3QD6O.localdomain ([221.162.118.197])
        by smtp.gmail.com with ESMTPSA id z22sm318548pfe.93.2021.12.09.09.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:31:49 -0800 (PST)
From:   6812skiii@gmail.com
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com, linux-kernel@vger.kernel.org,
        Jangwoong Kim <6812skiii@gmail.com>
Subject: [PATCH v5] futex: Clarify comment at futex_wait_multiple_setup()
Date:   Fri, 10 Dec 2021 02:31:41 +0900
Message-Id: <20211209173141.877-1-6812skiii@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jangwoong Kim <6812skiii@gmail.com>

Clarify that multiple futexes might have been woken.

Signed-off-by: Jangwoong Kim <6812skiii@gmail.com>
---
 kernel/futex/waitwake.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 4ce0923f1ce3..c7a14ebfe61d 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -454,9 +454,9 @@ static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wo
 		__set_current_state(TASK_RUNNING);
 
 		/*
-		 * Even if something went wrong, if we find out that a futex
-		 * was woken, we don't return error and return this index to
-		 * userspace
+		 * Even if something went wrong, if we find out that any futex
+		 * was woken, we don't return error and return the index of the
+		 * last futex awaken to userspace
 		 */
 		*woken = unqueue_multiple(vs, i);
 		if (*woken >= 0)
-- 
2.25.1

