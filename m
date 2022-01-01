Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEF7B482707
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbiAAISL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiAAISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:18:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0675C06173E
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:18:07 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v7so59493747wrv.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eK7taryyQSQVDJH0tOpVoMb90mygew6Vz5QUqjyD+10=;
        b=A3vpCJPzTHTnzx3JxK4ba+oIxWkOqewjdxEFSjIvVIoCZMRq5vGyFfSBVwIHgS9RCc
         qmZKCnmB28KgQywNn74wrsp7822NlNQip2ry3YiOHmTSqoJusLN52LfcjoSPdNA9TLZH
         n3+TfUmda6iB/CNRwF+W+MDCgl1B1cBN8KWYPfkCEY1PWBHi+OEB5FtEEiPANZDCYX4G
         /gfNsgFa8cjdfDJZrfrdm47fKm0wRJ6spl7j9sSoN1+UG/EBWWTBi2hcPZHnxBqNp9G9
         ZK8KYYR7+8mQyDI1Qlwssxxr0Huu86dvQsIQktnenKCff9SyIvqyHTGcqNnrxMYGBkNw
         Vy9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eK7taryyQSQVDJH0tOpVoMb90mygew6Vz5QUqjyD+10=;
        b=mtCHs5nNk8I4G7fjfioYAukg/PEpbSGoDGwDmLSMmCXDI1DdU9lWWHIrtkZ6i73pFW
         4BlQwT5MtWoCwE/e7mI7aNsKJ9LzXtFaEPG1Ylx9nE7u6NwTAngqW0MHU/L8W49Ru1bg
         5pbZi1RriYpS2mAy6fCfbUJgyzi0ugDlACJPy2+NtLIXaXi45ve4meROsJruIyDVwMSG
         udlELOQuXLfwDAY2/qO3eDqnem4Q0NgNdATgASOULs6amXdjfzesRxEmLyWt1bF+JiOI
         Pz4sigMsuhs+CvAwTU/f+TY4W4KVhKebyc1eDLfTPwbvSbrlbGYJazKiv2LoEWod7meN
         IeyQ==
X-Gm-Message-State: AOAM533TVg2g6cX7pXBbcfJCmzrOby7kb0LJa7VZId0J1P8rX8RlgZH+
        ZBW9PdUc7wPAv71ROsFcinQ=
X-Google-Smtp-Source: ABdhPJxBBUk1kWB1nOkNsVekcIfhxgoiz7bCp3zOW5hmK4GCz4GYNOcuRgsvVk8ay1q/qcuoSPql4A==
X-Received: by 2002:a05:6000:1112:: with SMTP id z18mr31091235wrw.129.1641025086424;
        Sat, 01 Jan 2022 00:18:06 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id u9sm30693651wmm.7.2022.01.01.00.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:18:06 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/7] staging: r8188eu: bTXPowerDataReadFromEEPORM is set but never used
Date:   Sat,  1 Jan 2022 09:17:54 +0100
Message-Id: <20220101081758.9716-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101081758.9716-1-straube.linux@gmail.com>
References: <20220101081758.9716-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field bTXPowerDataReadFromEEPORM of struct hal_data_8188e is set
but never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: no changes

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

