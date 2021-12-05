Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEC9468B52
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 14:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhLEODT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 09:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbhLEODE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 09:03:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839CAC0611F7
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 05:59:37 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o20so32034469eds.10
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 05:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wbc5BjprOLrYjULn10Q4JIxpSgq7iMFV0qoy8K2cU4w=;
        b=PKSssRcZs64czEbOVxfix++TMNmx9h9de/ERbPZ1iwXrndb299Ts5kapaJRt3hLYfY
         VGyC04XcKN2CDLYjfXAePji0eOBwq7+3EgcrQr4sYgu3w99UQO+2bugbtAWscJwBrNqn
         uoXcSVwTLkuXNPtQXZGccn39RyFHBg7Rj3TG+HYVLj2Tvy4uSTimEeQyy+9fS4IbnEq8
         kifyWJRD4gzdsWTfpvlqSQegHsl1l4wJqmNz6DOtURlBbD03UbXeWSdtmwtTJZLH3Uk1
         UtYYIbad15uhMRcdhA4RB49qjeJ17TXWhRIV68isHXLR0Afu6E9qma/dcQU7+UaUhvTw
         w8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wbc5BjprOLrYjULn10Q4JIxpSgq7iMFV0qoy8K2cU4w=;
        b=y7yOygK5JQ99q8J6I8gBNwPHdRH0o/GeW+V/RBvu7538z7vUN7k6599QoMxkx/lGBt
         uPO0u9nm4CbH4tYxGOqSb52Wsch7I26rdE2yMq+dOqjR4LeAucg6bnrPBU7RQXkWm3pe
         HFGFt/qX8ex2rQ/d06JFU9eOmQUFkzDMIGdNa/jsz2GcfP7KVjEG9n9uASwP1JJ70iAZ
         tjVSbWwF3JSOgKPvKIHMPUiSqSX0Tiur5pslr3fslPnXvkurA49I+y356jJawb7CiZR3
         GYvVbWcE7pIEX6PaAaSEnMbRDqeawol7mL3RPWTXN8GkXCPk9I66JXsgsZ0oL5t3JKAW
         Nhzw==
X-Gm-Message-State: AOAM531Hu7zMy8ihr5Kpfe9JGRUqs4xJ2vqj4mQRuTyVrF9EwMOjM/EB
        kClJhRuG4Gf8joo668oYvyo=
X-Google-Smtp-Source: ABdhPJxlgd7Q0GOE5gLSTyvsF9vXU4jeu5dryDMh+pYReyiJUIGrt6lHSqtD6QkD+XF0i0ZSRL7KSg==
X-Received: by 2002:a50:f189:: with SMTP id x9mr45300168edl.95.1638712776147;
        Sun, 05 Dec 2021 05:59:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id yd20sm5146451ejb.47.2021.12.05.05.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 05:59:35 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/12] staging: r8188eu: hal_data_sz is set but never used
Date:   Sun,  5 Dec 2021 14:59:19 +0100
Message-Id: <20211205135919.30460-13-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211205135919.30460-1-straube.linux@gmail.com>
References: <20211205135919.30460-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hal_data_sz in struct adapter is set but never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_halinit.c   | 1 -
 drivers/staging/r8188eu/include/drv_types.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 641aaf299109..da966538596f 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1969,5 +1969,4 @@ void rtl8188eu_alloc_haldata(struct adapter *adapt)
 	adapt->HalData = kzalloc(sizeof(struct hal_data_8188e), GFP_KERNEL);
 	if (!adapt->HalData)
 		DBG_88E("cant not alloc memory for HAL DATA\n");
-	adapt->hal_data_sz = sizeof(struct hal_data_8188e);
 }
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index c0854e9401b8..ff98ad90a65b 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -206,7 +206,6 @@ struct adapter {
 	struct wifidirect_info	wdinfo;
 
 	struct hal_data_8188e *HalData;
-	u32 hal_data_sz;
 
 	s32	bDriverStopped;
 	s32	bSurpriseRemoved;
-- 
2.34.1

