Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17EF747A1BB
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 19:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbhLSSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 13:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbhLSSUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 13:20:09 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B59C061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 10:20:09 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f5so6400323edq.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 10:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2JGTItMZLnyhLTpH8eIkTs8tCi5ANTqOzNBuD2pnIU=;
        b=ooxS5Pi1aTq1KoApuVHAb3j+mIhWhTLHJIYpTMPDJUCl2QGSXGUmOJ7tf0CcpFK8R8
         cx/sXjC9Y+einAyZsFPtoQ3FQxaoUpN2iIeV7Z2sRujSSqW54zhqC8BUIqKoR2cwqWW1
         lwZQOKDb0p8qHdzgx5nfpF39rQBQbWQdZ+LV797QdZyJ6kQJDZJh0O7W6pNDGPHt5klX
         mfRGvETqaKIYdR6qFR0o77ywAQSUQg8EW9tKUbrHF7TpESUMsp8dak/8l5IHmC9FhLAe
         7pq5+FHWeudmap0HL2s1aSWNV+34HNd7HhF/idHO1QJfKS/Dmcholz2JybU7/P4KtXyT
         BIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h2JGTItMZLnyhLTpH8eIkTs8tCi5ANTqOzNBuD2pnIU=;
        b=w45Ized2XyQb818wy8K63JuwCSLBaEwTVHmZQgGR7AiMy1ZV6avga+3mwd3swtKT7J
         fmLo2MiMDp5n6hmW4ziPKB4FRBrh//Y9hBSpcXFEIqTORX/lh13mYfQJude92XZQla2e
         s2YgNHcnBA35M78BPEs4IaGtNpbajTH9/HopYwTt561286VWFPx6Ypu07qkvV3/pLxVI
         jr1+kc8PbZtoWToYBldEnN+wIlpp+xmEAM1dKGZBb09RmBoLVSaSdnaxPyQcK/sFVdfj
         vizktsI/qUxxsk+HsNK5kFOx3AQ17xw/VMLgXjqZYm7rm7JSCFRv1GC8qeDXPsL/T9Se
         yKGA==
X-Gm-Message-State: AOAM530xtmJ6IrVkzF8ZT3rwgp0sFGJK6c7l35vky5qsOG39HFUebucY
        UzjnhBFvQ/6ddI7RvBdFK4A=
X-Google-Smtp-Source: ABdhPJwaS6VqugQvFlRzTs6C2xE6a4EjAnj8tlDm5Ra041uaV2Sbn0I2V98QJIlbgUukrNUWNs/pEA==
X-Received: by 2002:aa7:dd56:: with SMTP id o22mr12387440edw.73.1639938008044;
        Sun, 19 Dec 2021 10:20:08 -0800 (PST)
Received: from tom-desktop.station (net-93-151-129-173.cust.dsl.teletu.it. [93.151.129.173])
        by smtp.gmail.com with ESMTPSA id go35sm1149540ejc.191.2021.12.19.10.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 10:20:07 -0800 (PST)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     linuxfancy@googlegroups.com, tomm.merciai@gmail.com,
        Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alberto Merciai <alb3rt0.m3rciai@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        =?UTF-8?q?Aldas=20Tara=C5=A1kevi=C4=8Dius?= <aldas60@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: drop off byRxMode var in device.h
Date:   Sun, 19 Dec 2021 19:20:03 +0100
Message-Id: <20211219182004.25656-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop off unused variable byRxMode in device.h, this fix following 
checkpatch.pl check:

CHECK: Avoid CamelCase: <byRxMode>
131: FILE: drivers/staging/vt6655/device.h:131:
	unsigned char byRxMode

Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
---
 drivers/staging/vt6655/device.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
index 4706bde1ec1d..84b1dcf80e47 100644
--- a/drivers/staging/vt6655/device.h
+++ b/drivers/staging/vt6655/device.h
@@ -128,8 +128,6 @@ struct vnt_private {
 	u32                         memaddr;
 	u32                         ioaddr;
 
-	unsigned char byRxMode;
-
 	spinlock_t                  lock;
 
 	volatile int                iTDUsed[TYPE_MAXTD];
-- 
2.25.1

