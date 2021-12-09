Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5646F16B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:15:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242268AbhLIRTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235383AbhLIRTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:19:00 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB153C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:15:25 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v23so4916720pjr.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k9CE6QhPwg3s8utWxPi7Ldmxt6sjc0Bifgso0aNV7b8=;
        b=XfpCxEgQsGXOPFKB5wdN6G+EGYvDjS7x6AxHUg77HMdOFZXohrzhBwRmYnAc3rMQhg
         K02oXgS985YmpS6mfaTFUra1Ut9ugIpyk/rbqrWMWpd8vc9mqsZWyjO5QR5WkouNeXC8
         GCwouaFGRnhIHeY6o0GMoW/zWu1K9PAy1DaHyAYI0fmioF1c/yWIUaHYzducRkyhhBBa
         E1WfD09UxIsDU22UgObWuVMW/KACMPKwqR7AXP8SkSSZsnpTtQU48vrK17N1zMPCApd4
         NAac+d5im8ayD5vBaLc2MjPiRIB6i/8mLb0P7hG1lHldaGelvdwExrnZ9Hj1MXf9Nbgv
         fHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k9CE6QhPwg3s8utWxPi7Ldmxt6sjc0Bifgso0aNV7b8=;
        b=NmcW07uGhaG2ix1buV7oSiSHo8Goy9LS1zpdUI9/TTkSWesOKkJhGz3giiQDz4CHLE
         mrmFZKYAsp2nTErpc//x4+S0v6dtBL1+GM+3dkYuOGC15bQ9puJDuaH5cT0FRDPKQ0q1
         DLujPwi1MqKFsM+072yRaBkG/tWaaD+rUhOeYTdEIqkcTzIyLuFmjEBkaPMoNP78tevX
         HvGZ1D6cVOxvJLZQpGsW7iz8EsXoWq2LhCvEF12Q/mAUtQvjExjCSw6EgcLZ+N0QYPOQ
         G7LTo7i9y92LhWQqeJvfunk3v5HOamWUtXuk4LcPNDcLVvOMCVNSQOXo7gai59efvG6+
         ow8Q==
X-Gm-Message-State: AOAM533jT0MH4iRQlx2wRb2NFMntnPFVa5G0oJZPFlUlnqVKZt3IuTCC
        B2kT3yV6C/XVrDWzH81ddxh4PqBnZf0BTw==
X-Google-Smtp-Source: ABdhPJyUZpXZOQNHa3ThEcF9fKGgKwjl3UQzzuDlKEr3tUtq6YdXT+ELSuAs07v+/6sFe1SOg/xtQg==
X-Received: by 2002:a17:90b:1d0b:: with SMTP id on11mr16751006pjb.163.1639070125510;
        Thu, 09 Dec 2021 09:15:25 -0800 (PST)
Received: from DESKTOP-OO3QD6O.localdomain ([221.162.118.197])
        by smtp.gmail.com with ESMTPSA id f8sm262504pfv.135.2021.12.09.09.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 09:15:24 -0800 (PST)
From:   6812skiii@gmail.com
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     peterz@infradead.org, dvhart@infradead.org, dave@stgolabs.net,
        andrealmeid@collabora.com, linux-kernel@vger.kernel.org,
        Jangwoong Kim <6812skiii@gmail.com>
Subject: [PATCH v4] futex: Clarify comment at futex_wait_multiple_setup()
Date:   Fri, 10 Dec 2021 02:14:04 +0900
Message-Id: <20211209171404.478-1-6812skiii@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jangwoong Kim <6812skiii@gmail.com>

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

