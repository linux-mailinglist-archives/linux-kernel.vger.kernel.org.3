Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC42348271C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbiAAIt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:49:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiAAItx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:49:53 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C68C06173E
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:49:52 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id b73so18482503wmd.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNnyQKUNwC5X0HyOtAQZAQEeFLjT4A8KEQdLN65zWrc=;
        b=dJbOB/ZC4h3BRk/xTb5EgV5IengAUTb/1w1gKwajQF5bq860aSOeBq6DXINXKoxMuN
         YsPr79vrXi6u+R91TmV+DHfzyPVAmV3TfLJk9fTWg2BCuTQtiBO0gGA+Vstw9dy7kKh6
         mPX6L6ThyQPYdX+m9t9MTtWCgQvpy9vHZ2hplIX2yhjXQCOjq7hHwiAEaLLGQdO18n4b
         iuw5nQWzfuGV16r/mtGLKFUN0WRxr+iu+o8IUFtOKqmRt6Vg1wzFAambz84MfcMnJHmI
         B0acv3wZiPU8MUN40DlZmHvm6xjMef05TUoUp/WuQaZ4VLVIWa+rIMFpZS19//TVkrXu
         nKtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zNnyQKUNwC5X0HyOtAQZAQEeFLjT4A8KEQdLN65zWrc=;
        b=M/illE+pLaafm60TgT0n6LDd+45HdUBk23XptTwPpfNPlh54ZpDvhwmQlHvY1LDqTr
         2ILXj1rKhJR4upAG4HpK77oXCaAcUKeTbV+k2c+0OrWykoq/Zcz0RYxdG3sLYhXoa80G
         bgX/Z/Hg6TBrknxnKfoIGEntxZ6/YgpVkCb1sZ8aVThc5/1sVB5BU7wEFsIl3SaSVgcb
         Q2dPMZi66WAehIdF0yu/XXkXdyiCGhj3u9Jfn+SQjMsBBWwOyiqihZm3SSl4BrOJQb+J
         YmQHLxtUzPEarh3F+KSej1hUu/d0wnF6HzpStCNyL4k4r9zwHd1IREDrZ7SUv/lE+myb
         o3+g==
X-Gm-Message-State: AOAM5335ATexeL2AyyZ4WCki9CNLiIw3cTC2zXJq40eqviadZao2PNqp
        THo40A4Qrtwd2xfv5yTQXMU=
X-Google-Smtp-Source: ABdhPJxcKD1CJDT8eJEBvC4dNChBFf8X3jKspSH8k1vrT9OcQ0ydahtVGVqcYdY3i4PO2Ty1/wtQJw==
X-Received: by 2002:a1c:9dc7:: with SMTP id g190mr32885211wme.56.1641026991187;
        Sat, 01 Jan 2022 00:49:51 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::d7e8])
        by smtp.gmail.com with ESMTPSA id o9sm14806578wri.97.2022.01.01.00.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:49:50 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v3 3/7] staging: r8188eu: bTXPowerDataReadFromEEPORM is set but never used
Date:   Sat,  1 Jan 2022 09:49:33 +0100
Message-Id: <20220101084937.3411-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101084937.3411-1-straube.linux@gmail.com>
References: <20220101084937.3411-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The field bTXPowerDataReadFromEEPORM of struct hal_data_8188e is set
but never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v3: no changes
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

