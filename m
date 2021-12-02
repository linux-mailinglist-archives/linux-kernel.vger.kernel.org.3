Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 828E6466A61
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376779AbhLBT0v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:26:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348599AbhLBT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:26:43 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADE6C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 11:23:20 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id w1so2170186edc.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 11:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qss9WczWsHf6m6xg+GfxowVSEYP0p3JBA2lkpNMO7B0=;
        b=p/1LhlExRHF+B41phebtCxcYDklvUrFLTGbMotAKBZgWPcqU0fDVLSDpXP6iaR/Aw+
         5l8y0fYrLz29kUDPNiay7L4dGND3qiSiQY39aBtBv5zwbf0ShWbhwRMWtAjSvGyiIGBt
         UA8qAYyj0xasFdE63mYqElToRl10RFaDasP7Pa5Uu7tw699/zMvc+Q8XnTpy2lASm9OI
         Q6lXDqG2Oa6frI6Q0S3AF1mvn5Z0voQSRteInHqZUQzKFh/h2D533kfx6V9dtqIyShkP
         IC6YEIFwDzKzjVi1BsnmuSEYgn6t0Oi9pBFwA2IQOo3PeEDbFiPapPPyJPI40Be+hk3O
         hmCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qss9WczWsHf6m6xg+GfxowVSEYP0p3JBA2lkpNMO7B0=;
        b=4VXxt13dnqXM7LUwotFeQJ0MV3gW65oWgZP9C37UKAoVPopiFCE/0g08acPC9f06Jl
         isysXUlBK83CjXcsemmMvSkuE9+Ii8NcqNW4L9yLxQyJDg7wIs/DTYTuYpZFFGKgHMmq
         SNKISDOWkZsAfwoFtEiVOPBxtAW8yLAqG27y+YYlrhxaMI4QCNhiBxGvFMSm+xVMsO4m
         cjowEGkyhf1SBDdUWU2BS/l/I7tXx/tQ//MOp/T+XyQY0rZ92aXviAky/2zb0sDsrG/s
         VY6i4T1KZBSbzDbgHGD4NOwbUKjEanjKyDVDcapHuf3zC8UND4j94Shd9qTiygH+NGcP
         9tWw==
X-Gm-Message-State: AOAM531iOV46fnbFltPOyZyrBI1XdcmYx3z4/stREs5mrk8diUj0PLkT
        kpa6XNV7zO3POMyF0NSV6a4=
X-Google-Smtp-Source: ABdhPJyXC8e7WpOCL7CeylQ6+9Al/mjZ3YhX+Sf3enLHkJLl9cOsRSnI8DOZcNvFboNgNxAPd+OJzw==
X-Received: by 2002:a50:9ec9:: with SMTP id a67mr19994458edf.238.1638472998831;
        Thu, 02 Dec 2021 11:23:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id jg36sm432530ejc.44.2021.12.02.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:23:18 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: pSecurity is set but never used
Date:   Thu,  2 Dec 2021 20:23:07 +0100
Message-Id: <20211202192309.9362-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202192309.9362-1-straube.linux@gmail.com>
References: <20211202192309.9362-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pSecurity in odm_dm_struct is set but never used. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c         | 3 ---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 1 -
 drivers/staging/r8188eu/include/odm.h     | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index aa5249505fde..f3498454ee1a 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -237,9 +237,6 @@ void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	case	ODM_CMNINFO_SEC_CHNL_OFFSET:
 		pDM_Odm->pSecChOffset = (u8 *)pValue;
 		break;
-	case	ODM_CMNINFO_SEC_MODE:
-		pDM_Odm->pSecurity = (u8 *)pValue;
-		break;
 	case	ODM_CMNINFO_BW:
 		pDM_Odm->pBandWidth = (u8 *)pValue;
 		break;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 5725774cd89b..389a0c650388 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -72,7 +72,6 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_RX_UNI, &Adapter->recvpriv.rx_bytes);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_WM_MODE, &pmlmeext->cur_wireless_mode);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_CHNL_OFFSET, &hal_data->nCur40MhzPrimeSC);
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_MODE, &Adapter->securitypriv.dot11PrivacyAlgrthm);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_BW, &hal_data->CurrentChannelBW);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_CHNL, &hal_data->CurrentChannel);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SCAN, &pmlmepriv->bScanInProcess);
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index f3f17ad2c1c6..bb1df9d2d652 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -228,7 +228,6 @@ enum odm_common_info_def {
 	ODM_CMNINFO_RX_UNI,
 	ODM_CMNINFO_WM_MODE,		/*  ODM_WIRELESS_MODE_E */
 	ODM_CMNINFO_SEC_CHNL_OFFSET,	/*  ODM_SEC_CHNL_OFFSET_E */
-	ODM_CMNINFO_SEC_MODE,		/*  ODM_SECURITY_E */
 	ODM_CMNINFO_BW,			/*  ODM_BW_E */
 	ODM_CMNINFO_CHNL,
 
@@ -480,8 +479,6 @@ struct odm_dm_struct {
 	u8	*pWirelessMode; /* ODM_WIRELESS_MODE_E */
 	/*  Secondary channel offset don't_care/below/above = 0/1/2 */
 	u8	*pSecChOffset;
-	/*  Security mode Open/WEP/AES/TKIP = 0/1/2/3 */
-	u8	*pSecurity;
 	/*  BW info 20M/40M/80M = 0/1/2 */
 	u8	*pBandWidth;
 	/*  Central channel location Ch1/Ch2/.... */
-- 
2.34.0

