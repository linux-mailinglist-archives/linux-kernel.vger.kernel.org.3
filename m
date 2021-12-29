Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53EC64816BE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhL2Uvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbhL2Uva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:30 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE154C061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:29 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id q16so46590080wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=db2QjV6BwCz+v1VxPsNmHOvJO2uVgbYB/DpowETnxnc=;
        b=k4wD0apR7MaJzbZeGXlwqLey3O9QcLMzN+9l0F6W6/MVnsWwEwtpVofErtEbv6Rqgp
         Ld7FzcnA8xvj1PNJFde78PebL7y/PWmUFfRu4Vb0IZTsolnfIiNgWORFc4JgwhSSQ/gj
         8tv9wyJLn5fbTYztiQUNVJ51bMiDEjG4KGE9xivCMiKsdvbbg91Z09thZQ1OdeATMoCR
         2jSUWxwkpfChNS+gQ3fsrIPVNOQw1KjV9QAFtcMc5E78akYtlH9BDnATQcVNQ6a1TeHI
         neRLAYTIfer7EBDjhBCrup+TaZ1ldXDCELzamKwQqQu9TZqTE2Qh8Q061SISPeiH/5eo
         1xHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=db2QjV6BwCz+v1VxPsNmHOvJO2uVgbYB/DpowETnxnc=;
        b=1nDKwyg80mFzGQTpSbx3EeaRQKVZc1KBrFfzQWH9X7I5jid+pAElF+B3eh2OtL5jwJ
         oTVsrPZ2uthAY3gXw+g3qMmiULj6Sgio6xRm+yCx/++LS5cZyJLE9kkbTG3D0maDTnkf
         HT59SUtlkTMy8sLeUJzA10CNQgLrdFENU7isDnPje1RflIDA81pFkk/AX1jtebsvYeU7
         BvBllc5mE8QDemYxwZAX965ceS6LUJVBRAogrD9AqWccng2KdLviwTCUdWMu42JrOEmg
         eufzzsIxo5Tv6A3q9JaochMS6vsO3V4Xf8vIC6d8CHjYf7ArJ1+iTWYPj/1McAeEbViA
         uKNw==
X-Gm-Message-State: AOAM533+L8WXKccnaUXR5MHz2d8GXcrBeqI5YNoogNNnAoLOwMgwQAd2
        CURKYpUkiV84xPg36eibRh0=
X-Google-Smtp-Source: ABdhPJwcmSixa2+MyNljhjCs+g83TJjcBvV7MF11Rz4TQGr4PxPCtLk1HNIMpBR5lJRJBCc9obMPOA==
X-Received: by 2002:a5d:4e46:: with SMTP id r6mr21748530wrt.161.1640811088439;
        Wed, 29 Dec 2021 12:51:28 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:28 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 03/32] staging: r8188eu: remove ODM_GetRFReg()
Date:   Wed, 29 Dec 2021 21:50:39 +0100
Message-Id: <20211229205108.26373-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODM_GetRFReg() is just a wrapper around rtl8188e_PHY_QueryRFReg().
Remove ODM_GetRFReg() and call rtl8188e_PHY_QueryRFReg() directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c    | 2 +-
 drivers/staging/r8188eu/hal/odm_interface.c     | 6 ------
 drivers/staging/r8188eu/include/odm_interface.h | 3 ---
 3 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 9694893fadcc..f6f99b2acc01 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -137,7 +137,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 	/*  <Kordan> RFCalibrateInfo.RegA24 will be initialized when ODM HW configuring, but MP configures with para files. */
 	dm_odm->RFCalibrateInfo.RegA24 = 0x090e1317;
 
-	ThermalValue = (u8)ODM_GetRFReg(dm_odm, RF_PATH_A, RF_T_METER_88E, 0xfc00);	/* 0x42: RF Reg[15:10] 88E */
+	ThermalValue = (u8)rtl8188e_PHY_QueryRFReg(Adapter, RF_PATH_A, RF_T_METER_88E, 0xfc00); /* 0x42: RF Reg[15:10] 88E */
 
 	if (is2t)
 		rf = 2;
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 6c29122553b5..bf82f40cca24 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -22,12 +22,6 @@ void ODM_SetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path	eRFPath, u32
 	rtl8188e_PHY_SetRFReg(Adapter, (enum rf_radio_path)eRFPath, RegAddr, BitMask, Data);
 }
 
-u32 ODM_GetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path	eRFPath, u32 RegAddr, u32 BitMask)
-{
-	struct adapter *Adapter = pDM_Odm->Adapter;
-	return rtl8188e_PHY_QueryRFReg(Adapter, (enum rf_radio_path)eRFPath, RegAddr, BitMask);
-}
-
 /*  ODM Memory relative API. */
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u32 length)
 {
diff --git a/drivers/staging/r8188eu/include/odm_interface.h b/drivers/staging/r8188eu/include/odm_interface.h
index b4af86ac5bd4..aabc33927a30 100644
--- a/drivers/staging/r8188eu/include/odm_interface.h
+++ b/drivers/staging/r8188eu/include/odm_interface.h
@@ -20,9 +20,6 @@ u32 ODM_GetBBReg(struct odm_dm_struct *pDM_Odm, u32 RegAddr, u32 BitMask);
 void ODM_SetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path eRFPath,
 		  u32 RegAddr, u32 BitMask, u32 Data);
 
-u32 ODM_GetRFReg(struct odm_dm_struct *pDM_Odm, enum rf_radio_path eRFPath,
-		 u32 RegAddr, u32 BitMask);
-
 /*  Memory Relative Function. */
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2,
 		      u32 length);
-- 
2.34.1

