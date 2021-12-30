Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B1E482023
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 21:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242075AbhL3UBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 15:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242062AbhL3UBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 15:01:09 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D259C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:09 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so13816177wme.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuJQXdVZDt3Q260m2XKqRZ/xVabItJzV8eJCp2HOE80=;
        b=a/qQ/BOpGTjgv1UdHnPYFHbLQT9c1Otq7B7fCxAAOEhLGhGasfJqsG+CZbxbrBuQPN
         k/GgA31C2adT7kcVrNI2vp4E0StqPf8WmklzT/1vrnE+BCmK21s9AXOZJkn0w1YpWAuM
         suLXzvJ133+wRAexS0ruxDm+pvQpGDucHDEg6vQp8P/2n6qGrYRqIEzbdDrQ6g4rRIRr
         Vu2tkPxl6Be5L4Qpbu57bKxUdZZ5R8emSUN3ZpP9N9k4TI0lHIsMDM9N2fM4PWs9Zt7V
         kUBo1z63Hwisx8mRNr2J1wjx65B/Lzv+P3QI+/Vc9KqsNaOuIqJotpy7xPUYO8QhyaRQ
         dyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuJQXdVZDt3Q260m2XKqRZ/xVabItJzV8eJCp2HOE80=;
        b=WkAx1HXG5yUxydp4l/X3qrtyEw7oXOCNkh8z/DBy86hDqHk2me22RizrM66rUH2SJm
         7IQKF/vD/xCMbYfGbHgXuBX7NzgXqE2rgq8s5JFrV2kj3uz2lHdkMNadJb5hpPLxs/9g
         KmJZe1lfgL3WBw247DimB1eY4CBS/0ybnK2U+rNCRqnXWkKkLzG/fvDEXDtfDo8rDmCA
         r8HM88R/o2VqYF5FxAaJNwqZXNEBtQOJn4jNbC0m6HnS4Nu7qqfq+231FZymNW6vsksP
         msXV/aRKWt3Hx0dqwVEnMKD+hWDnutEMT6unxoEgo7evdtGv+jKdllr6XUCJ8ZYBcoBW
         41pg==
X-Gm-Message-State: AOAM533Jm6BRNAkb90qA6c+Tzpk5sSkl2iO4gO+dDUUHHCOGoWp3MpEt
        uM0nhAazpTVt3KhkhZgjHXcDJnTMlUo=
X-Google-Smtp-Source: ABdhPJzTzmAEOWGto84ZQhMkPWLnYMCokESqabDX/0iYn8CqT2OWwY6JBQewb6SoVB6ETrR8CplzJg==
X-Received: by 2002:a05:600c:3489:: with SMTP id a9mr26994643wmq.45.1640894467622;
        Thu, 30 Dec 2021 12:01:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id o8sm29042286wry.20.2021.12.30.12.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 12:01:07 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/7] staging: r8188eu: bTXPowerDataReadFromEEPORM is set but never used
Date:   Thu, 30 Dec 2021 21:00:55 +0100
Message-Id: <20211230200059.13406-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230200059.13406-1-straube.linux@gmail.com>
References: <20211230200059.13406-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field bTXPowerDataReadFromEEPORM of struct hal_data_8188e is set
but never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 3 ---
 drivers/staging/r8188eu/include/rtl8188e_hal.h  | 1 -
 2 files changed, 4 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index d8d6547465a7..065c2701077d 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1127,9 +1127,6 @@ void Hal_ReadTxPowerInfo88E(struct adapter *padapter, u8 *PROMContent, bool Auto
 
 	Hal_ReadPowerValueFromPROM_8188E(&pwrInfo24G, PROMContent, AutoLoadFail);
 
-	if (!AutoLoadFail)
-		pHalData->bTXPowerDataReadFromEEPORM = true;
-
 	for (ch = 0; ch < CHANNEL_MAX_NUMBER; ch++) {
 		hal_get_chnl_group_88e(ch, &group);
 
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 8b54f52f49e2..de58c85b8bdc 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -180,7 +180,6 @@ struct hal_data_8188e {
 	u16	EEPROMSDID;
 	u8	EEPROMRegulatory;
 
-	u8	bTXPowerDataReadFromEEPORM;
 	u8	EEPROMThermalMeter;
 	u8	bAPKThermalMeterIgnore;
 
-- 
2.34.1

