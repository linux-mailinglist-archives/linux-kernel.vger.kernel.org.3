Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D212D4816C9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhL2UwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhL2Uvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B3CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r17so46578450wrc.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOo319fzjEUISZs5YH9GJVr9iNceoSjpl9nm5JKLpLQ=;
        b=TAbOBgbUuQTficM757lP2hK188zm8Dm3LZ72aLeoAOG6iq3W3TAf0oKmNmSGcu67FZ
         zuhrAXwMYNQdzJwZ6w3yA9ys0cJS8YAU1Ukjlh6N6YEhTCDHz43vQvyUbzYZd7cqipgH
         y92YVNo/n8eh6XQRPNgomORSexiVQxOrmqNybdmDVqOjfyV52gQaEkw/DIaYj36/kjk2
         fbEJ1VdWk2F2ufe7lPpkIBEqP6c7Qi4/j5W9cJgi1TYb9mePmxY0mmH0IJDx/0Dhn10J
         t4rBXft1YF9ZIF2XwSTjhUUbpZz0nt2LyI79HuFg2rbIndFvMc2WsL0cATWcS3ajjSLF
         agrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOo319fzjEUISZs5YH9GJVr9iNceoSjpl9nm5JKLpLQ=;
        b=dsn4CZEOlIWmE0KEAiE+u9S0NZSz2C91j/BJQvW0Jeg62vNUAjvYjYVfFZsW+lL0Wh
         9m5oMapnRMTqFb5QgGw7iDbPen0ZxozSN9ryUoy/Go8Y4RT3BX7cS5JtbSv7C2TFALrJ
         HN52dmQ1YbiVWrG/zA7hcPpSh7BEhYR08ZINVthb/2I145srmeYBe1RT3g44Qi2LQmVD
         ENip1NQ7tzyv+ecRVcsc1B1isi8DOg8C344rzSEg33NaiPdIrLEhM7nzutfFNNo4UlrP
         /SZ49JIhgpMA0C+NiHF6NNA38Em7fCptD7KOxQR/8NrogNagrqF58EMusMJkcNwNNlPy
         K4JQ==
X-Gm-Message-State: AOAM53264EUMSyH+48dci4kn+7wInuvpH284rRDqs8fFZEXadD4UGXEc
        JSOIU8N75wHcfKHWUcEr7rA=
X-Google-Smtp-Source: ABdhPJwp0yJzthg0rlbGx92oO4njXNnCTWGOCf2HKFqEwWwnheMmgOSW8MysMWgcihKXHkCTUje2gQ==
X-Received: by 2002:a5d:47aa:: with SMTP id 10mr22246992wrb.455.1640811096455;
        Wed, 29 Dec 2021 12:51:36 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:36 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 14/32] staging: r8188eu: remove unused prototypes
Date:   Wed, 29 Dec 2021 21:50:50 +0100
Message-Id: <20211229205108.26373-15-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some unused function prototypes.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/include/odm.h          | 2 --
 drivers/staging/r8188eu/include/odm_RTL8188E.h | 4 ----
 drivers/staging/r8188eu/include/odm_precomp.h  | 1 -
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index c07dbf763903..793068778833 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -558,8 +558,6 @@ extern	u8 CCKSwingTable_Ch14 [CCK_TABLE_SIZE][8];
 void ODM_Write_DIG(struct odm_dm_struct *pDM_Odm, u8 CurrentIGI);
 void ODM_Write_CCK_CCA_Thres(struct odm_dm_struct *pDM_Odm, u8 CurCCK_CCAThres);
 
-void ODM_SetAntenna(struct odm_dm_struct *pDM_Odm, u8 Antenna);
-
 void ODM_RF_Saving(struct odm_dm_struct *pDM_Odm, u8 bForceInNormal);
 
 void ODM_TXPowerTrackingCheck(struct odm_dm_struct *pDM_Odm);
diff --git a/drivers/staging/r8188eu/include/odm_RTL8188E.h b/drivers/staging/r8188eu/include/odm_RTL8188E.h
index 85a0d7ec7378..3c6471f1a893 100644
--- a/drivers/staging/r8188eu/include/odm_RTL8188E.h
+++ b/drivers/staging/r8188eu/include/odm_RTL8188E.h
@@ -25,8 +25,4 @@ void ODM_AntselStatistics_88E(struct odm_dm_struct *pDM_Odm, u8	antsel_tr_mux,
 
 void odm_FastAntTraining(struct odm_dm_struct *pDM_Odm);
 
-void odm_FastAntTrainingCallback(struct odm_dm_struct *pDM_Odm);
-
-void odm_FastAntTrainingWorkItemCallback(struct odm_dm_struct *pDM_Odm);
-
 #endif
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index a0d5e870c11a..7f08f2d0a671 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -36,7 +36,6 @@ void odm_RateAdaptiveMaskInit(struct odm_dm_struct *pDM_Odm);
 void odm_DynamicBBPowerSavingInit(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingInit(struct odm_dm_struct *pDM_Odm);
 void ODM_EdcaTurboInit(struct odm_dm_struct *pDM_Odm);
-void odm_SwAntDivInit_NIC(struct odm_dm_struct *pDM_Odm);
 void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm);
 void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
 void odm_DIG(struct odm_dm_struct *pDM_Odm);
-- 
2.34.1

