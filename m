Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB80546B1BE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234742AbhLGEOT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhLGEOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:14:18 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AA5C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 20:10:48 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id k4so12510526pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 20:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0TwGbYIT1feRlx/MLRRjJJoTPI1eMpeJCX8wKC+CGs=;
        b=GD+s/Bt+zoyj2v7920Hyj3mNWKpNBIbqjVM+/cUNAVM4/bpZaf0DY8r/1uJhT0aTHI
         8Eq/j+WyYNaWN/yRHzlAngECBzMkgrjZB4IGmbsJXeXAsVB+lVbrgwFnETEIqYGjNPje
         3yzLzIaXdGbA5EgcFikYnBitFzIX2M1Aq0llHPPBun1U9ot41wv1DGgloZj0aSAjYM3Q
         UbpsZs3E4KS1J+KLUFKaIeLflFmIxFb+Nt6onw0EnT7cpAmZJ7e9bJu53+MZu+xbMSRL
         687VVgwqiX4fJTvLy677ej/YG8p1ojE0p5K60f2RSlvPkfAwqAc16S0wHJhrIgsj2cK6
         Kvkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L0TwGbYIT1feRlx/MLRRjJJoTPI1eMpeJCX8wKC+CGs=;
        b=nciKr82yAqmW44BVTj/1IMuLAGVnilDtywz2zDKOxUsFtmFbbkB/j+vuCotRiOL1CG
         ntif5vUT+c294OfZmjHsIsH/0AvJ7o+yC7duY8/5Eu/Dp82+tVeQbwsvFRU64U3UuFQE
         KkBid6Wuo+Fm5b7TJthegJvxvgF4f1koNzaG7xD+/7YzGV44fLI5NnEmcChtnh8Xay9Y
         datIOWhnhWL4Evx090/cx1BjyTjcs3Ku5kr6kHb0mhMazoj1Yhbix5lQGCx6u9a4RsTo
         tFY/a5RbcZc0B/uZPeObZaIDGS8xr4zdFJTOr28EwxGC4bBDeg63Wxbviy0hSYZxtcdH
         dAiw==
X-Gm-Message-State: AOAM530p8Q2/yHy2Q0Xn88YWzASUVfjKWkNg0WAXFTqSZF0SV4AlimJE
        5pURZhxoRkXePic0lzKNZNM=
X-Google-Smtp-Source: ABdhPJwCxx56JpKzQtjn2SLKUH53IWwaqO4botweInKz6TRjqWMWf+gZcGZNzjfyjV85LtPZsCifzg==
X-Received: by 2002:a05:6a00:856:b0:4ad:7832:e13a with SMTP id q22-20020a056a00085600b004ad7832e13amr12209304pfk.41.1638850248248;
        Mon, 06 Dec 2021 20:10:48 -0800 (PST)
Received: from DESKTOP-OO3QD6O.localdomain ([221.162.118.197])
        by smtp.gmail.com with ESMTPSA id n31sm6829633pfv.176.2021.12.06.20.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 20:10:48 -0800 (PST)
From:   6812skiii@gmail.com
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com, linux-kernel@vger.kernel.org,
        Jangwoong Kim <6812skiii@gmail.com>
Subject: [PATCH v2] futex: Fix a faulty comment.
Date:   Tue,  7 Dec 2021 13:10:37 +0900
Message-Id: <20211207041037.323-1-6812skiii@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jangwoong Kim <6812skiii@gmail.com>

Clarify that "woken" saves the last index of futex awoken.

Signed-off-by: Jangwoong Kim <6812skiii@gmail.com>
---
 kernel/futex/waitwake.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 4ce0923f1ce3..45d634dacfcb 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -454,9 +454,9 @@ static int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wo
 		__set_current_state(TASK_RUNNING);
 
 		/*
-		 * Even if something went wrong, if we find out that a futex
-		 * was woken, we don't return error and return this index to
-		 * userspace
+		 * Even if something went wrong, if we find out that any futex
+		 * was woken, we don't return error and return the last index
+		 * of futex awaken to userspace
 		 */
 		*woken = unqueue_multiple(vs, i);
 		if (*woken >= 0)
-- 
2.25.1

