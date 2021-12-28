Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5C4480843
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 11:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236126AbhL1KMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 05:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhL1KLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 05:11:50 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DA7C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:49 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d9so37485440wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 02:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EjwXk8DAoVctoWcKSh1CxTed9Argmbii4xJnIrYtVZc=;
        b=B2ZfjswxYQF099t1ED3UHvTKXrMVJzSlr+cqPCFWClcD4UgpSKr9j7C5of6vN2fbjR
         yursA2m2V0p167sRe6frBdGOroHSnU7afmB++i2zskVSx2Tht1n/X9ZVgcjnT+e7/Kba
         9nuMredI/07qVyO/IPHQ0IcvgHi2ISwzVbqbCy2x44GlgJUCtKdFIaqFzXySLupLsTSC
         iQqSnuAnQ+RyYDzvgua6wXoV+EQNwW3r25vxPKRjYWFtKbeF8eCiZdS08nwg6luwCo6O
         +p3XgqehAY6RTQ9m20lcTWv/ZNkbaY0R4/SDgmy/7KmSYde15TIUF45oZDRHrFvOzM6o
         QAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EjwXk8DAoVctoWcKSh1CxTed9Argmbii4xJnIrYtVZc=;
        b=7OgcJ+fHNQmwUUDeZEhl+CKt8CW9luRri5Tyzn4bpP+6NIXeUSAd3LngLYQUTkBLce
         sfQHro+lqykYQr2S4hMK1n5Mgr/7oIQ01Mp2pnjr92DBfmbBA+4+bCPsx8ZWNuCk0xQL
         pD7C36wIuZ3cDF45KEw4pejMmWMieENNcCKNgX6YjRP4KpARfPXnohCLgZFIiacjfsTu
         B6VkIGhaYtwsu5+lEf5QkSzBxGPKtCmadfWJC7KQCEtxWmt7tINGtKbg6nkZoVDhmYoc
         wZL8QnBUdjwOetexZLBpSFpBKrgIXcbUdzRxx4jrEurKh4DbeKq83F0W5hxQQgTwfgUc
         WLng==
X-Gm-Message-State: AOAM5314YdVHQbCApsG/pJVb+ink8TDJeqasFPN3dTqiizxOieS4w9cQ
        Zz+g3kuKK30ZyGf5QC/4upw=
X-Google-Smtp-Source: ABdhPJycaCqsdFX+otOe7KZPXWoMVSn1rlIJHmQIHnRNs/9aLjqFkfOtLFSN7AkgiH3sTT45sIrqSg==
X-Received: by 2002:a5d:4e92:: with SMTP id e18mr16143241wru.89.1640686308209;
        Tue, 28 Dec 2021 02:11:48 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id d62sm21160984wmd.3.2021.12.28.02.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 02:11:47 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 07/10] staging: r8188eu: FAT_State is set but never used
Date:   Tue, 28 Dec 2021 11:11:17 +0100
Message-Id: <20211228101120.9120-8-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211228101120.9120-1-straube.linux@gmail.com>
References: <20211228101120.9120-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field FAT_State of struct fast_ant_train is set but never used.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm_RTL8188E.c | 1 -
 drivers/staging/r8188eu/include/odm.h      | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm_RTL8188E.c b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
index 34530fcd00d8..1dcdf6a131fc 100644
--- a/drivers/staging/r8188eu/hal/odm_RTL8188E.c
+++ b/drivers/staging/r8188eu/hal/odm_RTL8188E.c
@@ -60,7 +60,6 @@ static void odm_FastAntTrainingInit(struct odm_dm_struct *dm_odm)
 	struct fast_ant_train *dm_fat_tbl = &dm_odm->DM_FatTable;
 
 	dm_fat_tbl->TrainIdx = 0;
-	dm_fat_tbl->FAT_State = FAT_NORMAL_STATE;
 
 	/* MAC Setting */
 	value32 = ODM_GetMACReg(dm_odm, 0x4c, bMaskDWord);
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 66dc93518628..db72eea83382 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -387,7 +387,6 @@ struct fast_ant_train {
 	u8	antsel_rx_keep_0;
 	u8	antsel_rx_keep_1;
 	u8	antsel_rx_keep_2;
-	u8	FAT_State;
 	u32	TrainIdx;
 	u8	antsel_a[ODM_ASSOCIATE_ENTRY_NUM];
 	u8	antsel_b[ODM_ASSOCIATE_ENTRY_NUM];
@@ -400,11 +399,6 @@ struct fast_ant_train {
 	bool	bBecomeLinked;
 };
 
-enum fat_state {
-	FAT_NORMAL_STATE		= 0,
-	FAT_TRAINING_STATE		= 1,
-};
-
 enum ant_div_type {
 	NO_ANTDIV			= 0xFF,
 	CG_TRX_HW_ANTDIV		= 0x01,
-- 
2.34.1

