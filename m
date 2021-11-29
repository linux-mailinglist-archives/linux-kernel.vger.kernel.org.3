Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27594627FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhK2XR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbhK2XRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:17:15 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3143C06FD62
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:01:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so13458613wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o/dlIZ2W9ErrYeXmNmX8JFAF4ieV2UL7KTfq7myAV3g=;
        b=cNgssUGA+LHF93gzzIh/6Mxl5v+Xa1PvcSI7QpLPmSkgTavA7hXStqGM/Dzg5qJAzi
         crOlIgF0k/vNBr4Eg5nxIzrExwDmONTRGj6JxzAEFbMPy/nJzd6ANDGoV95Ki8A9Q4M0
         oHYAqGMSgTSlXSdGMk2cGIOuRNOELpR2qcuoauSXPuq6mEuh6xxsfU0aABW8TISB5LbJ
         bjufzFOxwQ0+XL/X49FKA34FzajHIQzsWyqId/4vDzOJODiVn3q1unm15DTbn4ifBf2R
         ES37PUNhdOGtgb0zg/piqZSnZNm9DfkM5xUtANkLJgcRLccE4b/ym/71XlzPFGuKkfvq
         F91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o/dlIZ2W9ErrYeXmNmX8JFAF4ieV2UL7KTfq7myAV3g=;
        b=8JoZowA/UGRv9t5hmfSj0g/CMoFAAymxTKTPYjJrWb2ohSUZhemPCf7fEOdZBnbFBq
         d54i3YHC9GXqxbQ53hkNDQkyylBNbvGEhHl7Bb58FF8wC8vpH/9uYcZIAJVEX+zpvVss
         aufoXM4FBZ5V2Y5af8nKm5pOkgaEZOUj/dFAqsFOMd1807XIUjmJHdtTETnhb07567rm
         zeLcUSE+UpgSQ+TR6eRC68tcq2YfBLaGYOYAi4iNQ6A9941AZ/avGpIprowOXomdMOxh
         f9z0CsmFzY7lYpTN+HzBaWlxpTZVG5/SFifXnsXaCdT9nqhTzqFUTf0AAdud1ryIY+pE
         g6wA==
X-Gm-Message-State: AOAM533+EAbfxMnCvrb/Hcf63kVMU24PdDBAaBMGbhTW0GDEqUmivbDs
        +G/Wl6uGrOX+u5jXCGV1bYw=
X-Google-Smtp-Source: ABdhPJxQNEhggO2g/vl4YZFmMLuWfB/s4jkYy1tm5zCmPajRGYNagQqnq7O9NFzVO1So9LralSnLLg==
X-Received: by 2002:a05:600c:1c1a:: with SMTP id j26mr987750wms.28.1638226891538;
        Mon, 29 Nov 2021 15:01:31 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8754])
        by smtp.gmail.com with ESMTPSA id n4sm17204891wri.41.2021.11.29.15.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:01:31 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: RFType is set but never used
Date:   Tue, 30 Nov 2021 00:01:25 +0100
Message-Id: <20211129230125.27247-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFType is set but never used. Remove it from struct HAL_VERSION and
remove the now unused enum HAL_RF_TYPE.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  1 -
 drivers/staging/r8188eu/include/HalVerDef.h     | 12 ------------
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index eeb5f46687e2..9ef73b62f94e 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -846,7 +846,6 @@ void rtl8188e_read_chip_version(struct adapter *padapter)
 	value32 = rtw_read32(padapter, REG_SYS_CFG);
 	ChipVersion.ChipType = ((value32 & RTL_ID) ? TEST_CHIP : NORMAL_CHIP);
 
-	ChipVersion.RFType = RF_TYPE_1T1R;
 	ChipVersion.VendorType = ((value32 & VENDOR_ID) ? CHIP_VENDOR_UMC : CHIP_VENDOR_TSMC);
 	ChipVersion.CUTVersion = (value32 & CHIP_VER_RTL_MASK) >> CHIP_VER_RTL_SHIFT; /*  IC version (CUT) */
 	ChipVersion.ROMVer = 0;	/*  ROM code version. */
diff --git a/drivers/staging/r8188eu/include/HalVerDef.h b/drivers/staging/r8188eu/include/HalVerDef.h
index 796a44a1e697..1d96657e6a98 100644
--- a/drivers/staging/r8188eu/include/HalVerDef.h
+++ b/drivers/staging/r8188eu/include/HalVerDef.h
@@ -24,22 +24,10 @@ enum HAL_VENDOR {
 	CHIP_VENDOR_UMC		=	1,
 };
 
-enum HAL_RF_TYPE {
-	RF_TYPE_1T1R	=	0,
-	RF_TYPE_1T2R	=	1,
-	RF_TYPE_2T2R	=	2,
-	RF_TYPE_2T3R	=	3,
-	RF_TYPE_2T4R	=	4,
-	RF_TYPE_3T3R	=	5,
-	RF_TYPE_3T4R	=	6,
-	RF_TYPE_4T4R	=	7,
-};
-
 struct HAL_VERSION {
 	enum HAL_CHIP_TYPE	ChipType;
 	enum HAL_CUT_VERSION	CUTVersion;
 	enum HAL_VENDOR		VendorType;
-	enum HAL_RF_TYPE	RFType;
 	u8			ROMVer;
 };
 
-- 
2.34.0

