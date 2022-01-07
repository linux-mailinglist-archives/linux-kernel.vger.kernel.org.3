Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6614875B0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 11:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346866AbiAGKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 05:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346776AbiAGKgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:36:38 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C451BC061201
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 02:36:36 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b13so20398707edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 02:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JniXZHV+z8/FUQgwuETGo4oRZPLkn/dXIDiJ1RkV2rA=;
        b=ed6QExJ9z2Nw+R9/eFm6JvoUSaxw5vWz7VlPiy2KpUtQYeE2gNTTuhZ85+xdJPMOlR
         esOkvaIbHkJsDpoirmW/G8maAds+L2TNmTapHbAIxAflgl4GGOl6ZaKSmZ2lvKbCYv8g
         1q/hJ3BUGTW+k584WlC3NQBqHndIEDC7MgpYbOYDoM7F02jdLs53y7KD7ef+biPV7idD
         IK7Oajc8jeKAxHvU8U9Wu9ZNOXXPLUNX3MyPB2A3aGXqGd+js5veTv8QQ3cNeAWIzNvv
         RSwfLh1TILrrqNQ0m3THItcy1HgcQGGavekkRayY4iV0iXrLJMLPWnuGOGAEv1Q0fm2k
         ghWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JniXZHV+z8/FUQgwuETGo4oRZPLkn/dXIDiJ1RkV2rA=;
        b=BYAz9zkC72z3aNG56C+C3HjHnxdVXVUX+i478gDgmjvziqzminos6JwgG4sAIMjT1P
         jSeZ0qo99JW+h3sEsj8USE6BSQjXWfZEvoydnYb21KtuTg6cPEUYZi9A01yWKvwVy1OS
         Dv7GcGr15rN6oVLRqNx/nMD2eZ6laCgdt/syuaIuCHp8kOjgQGB0twXnpW/+SnwdCTtQ
         3S5ui7DBroPkGzSkXev3sxQEJAbnw+DeR4dFbZodZEwq02DLqfNu8fgBr6NXFs7qLmZD
         ysgT1hn1Mn5UnVZvHjwymb3dotjECWKUjs8fiyGhnl4T+H/wsG60AtG9C/eW1GJJS/hz
         tKSg==
X-Gm-Message-State: AOAM5338VHvqv+XuTwbxFbYOsRiEEVTdrUp+n25HwpUOiuToHIaifKgH
        zcceCn1uPSiHb+EreuYCvLCCrAzvAtU=
X-Google-Smtp-Source: ABdhPJzxDuWo4nhxy9veVNfYpRhvE9Ho0UJGns0MM7KNkXbceN5DwDNkkXeVQbighfzSTYq0m83TyQ==
X-Received: by 2002:a17:906:3e4b:: with SMTP id t11mr6265057eji.744.1641551795426;
        Fri, 07 Jan 2022 02:36:35 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id v8sm1869857edt.10.2022.01.07.02.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 02:36:35 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/19] staging: r8188eu: rename fw related functions to avoid camel case
Date:   Fri,  7 Jan 2022 11:36:11 +0100
Message-Id: <20220107103620.15648-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107103620.15648-1-straube.linux@gmail.com>
References: <20220107103620.15648-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename firmware related functions to avoid camel case.

rtl8188e_FirmwareDownload -> rtl8188e_firmware_download
_FWDownloadEnable -> fw_download_enable
_8051Reset88E -> rtw_reset_8051
_FWFreeToGo -> fw_free_to_go
_BlockWrite -> block_write
_PageWrite -> page_write
_WriteFW -> write_fw

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 .../staging/r8188eu/hal/rtl8188e_hal_init.c   | 34 +++++++++----------
 drivers/staging/r8188eu/hal/usb_halinit.c     |  2 +-
 .../staging/r8188eu/include/rtl8188e_hal.h    |  4 +--
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index f7ae2fc0d2b9..b1f2d349c33a 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -21,7 +21,7 @@ static void iol_mode_enable(struct adapter *padapter, u8 enable)
 
 		if (!padapter->bFWReady) {
 			DBG_88E("bFWReady == false call reset 8051...\n");
-			_8051Reset88E(padapter);
+			rtw_reset_8051(padapter);
 		}
 
 	} else {
@@ -336,7 +336,7 @@ int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter, struct xmit_frame *xmit
 	return ret;
 }
 
-static void _FWDownloadEnable(struct adapter *padapter, bool enable)
+static void fw_download_enable(struct adapter *padapter, bool enable)
 {
 	u8 tmp;
 
@@ -360,7 +360,7 @@ static void _FWDownloadEnable(struct adapter *padapter, bool enable)
 
 #define MAX_REG_BOLCK_SIZE	196
 
-static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
+static int block_write(struct adapter *padapter, void *buffer, u32 buffSize)
 {
 	int ret = _SUCCESS;
 	u32	blockSize_p1 = 4;	/*  (Default) Phase #1 : PCI muse use 4-byte write to download FW */
@@ -416,7 +416,7 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 	return ret;
 }
 
-static int _PageWrite(struct adapter *padapter, u32 page, void *buffer, u32 size)
+static int page_write(struct adapter *padapter, u32 page, void *buffer, u32 size)
 {
 	u8 value8;
 	u8 u8Page = (u8)(page & 0x07);
@@ -424,10 +424,10 @@ static int _PageWrite(struct adapter *padapter, u32 page, void *buffer, u32 size
 	value8 = (rtw_read8(padapter, REG_MCUFWDL + 2) & 0xF8) | u8Page;
 	rtw_write8(padapter, REG_MCUFWDL + 2, value8);
 
-	return _BlockWrite(padapter, buffer, size);
+	return block_write(padapter, buffer, size);
 }
 
-static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
+static int write_fw(struct adapter *padapter, void *buffer, u32 size)
 {
 	/*  Since we need dynamic decide method of dwonload fw, so we call this function to get chip version. */
 	/*  We can remove _ReadChipVersion from ReadpadapterInfo8192C later. */
@@ -441,7 +441,7 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 
 	for (page = 0; page < pageNums; page++) {
 		offset = page * MAX_PAGE_SIZE;
-		ret = _PageWrite(padapter, page, bufferPtr + offset, MAX_PAGE_SIZE);
+		ret = page_write(padapter, page, bufferPtr + offset, MAX_PAGE_SIZE);
 
 		if (ret == _FAIL)
 			goto exit;
@@ -449,7 +449,7 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 	if (remainSize) {
 		offset = pageNums * MAX_PAGE_SIZE;
 		page = pageNums;
-		ret = _PageWrite(padapter, page, bufferPtr + offset, remainSize);
+		ret = page_write(padapter, page, bufferPtr + offset, remainSize);
 
 		if (ret == _FAIL)
 			goto exit;
@@ -458,7 +458,7 @@ static int _WriteFW(struct adapter *padapter, void *buffer, u32 size)
 	return ret;
 }
 
-void _8051Reset88E(struct adapter *padapter)
+void rtw_reset_8051(struct adapter *padapter)
 {
 	u8 u1bTmp;
 
@@ -468,7 +468,7 @@ void _8051Reset88E(struct adapter *padapter)
 	DBG_88E("=====> _8051Reset88E(): 8051 reset success .\n");
 }
 
-static s32 _FWFreeToGo(struct adapter *padapter)
+static s32 fw_free_to_go(struct adapter *padapter)
 {
 	u32	counter = 0;
 	u32	value32;
@@ -491,7 +491,7 @@ static s32 _FWFreeToGo(struct adapter *padapter)
 	value32 &= ~WINTINI_RDY;
 	rtw_write32(padapter, REG_MCUFWDL, value32);
 
-	_8051Reset88E(padapter);
+	rtw_reset_8051(padapter);
 
 	/*  polling for FW ready */
 	counter = 0;
@@ -540,7 +540,7 @@ static int load_firmware(struct rt_firmware *rtfw, struct device *device)
 	return ret;
 }
 
-s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
+s32 rtl8188e_firmware_download(struct adapter *padapter)
 {
 	s32	rtStatus = _SUCCESS;
 	u8 writeFW_retry = 0;
@@ -583,16 +583,16 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 	/*  or it will cause download Fw fail. 2010.02.01. by tynli. */
 	if (rtw_read8(padapter, REG_MCUFWDL) & RAM_DL_SEL) { /* 8051 RAM code */
 		rtw_write8(padapter, REG_MCUFWDL, 0x00);
-		_8051Reset88E(padapter);
+		rtw_reset_8051(padapter);
 	}
 
-	_FWDownloadEnable(padapter, true);
+	fw_download_enable(padapter, true);
 	fwdl_start_time = jiffies;
 	while (1) {
 		/* reset the FWDL chksum */
 		rtw_write8(padapter, REG_MCUFWDL, rtw_read8(padapter, REG_MCUFWDL) | FWDL_ChkSum_rpt);
 
-		rtStatus = _WriteFW(padapter, pFirmwareBuf, FirmwareLen);
+		rtStatus = write_fw(padapter, pFirmwareBuf, FirmwareLen);
 
 		if (rtStatus == _SUCCESS ||
 		    (rtw_get_passing_time_ms(fwdl_start_time) > 500 && writeFW_retry++ >= 3))
@@ -602,13 +602,13 @@ s32 rtl8188e_FirmwareDownload(struct adapter *padapter)
 			__func__, writeFW_retry, rtw_get_passing_time_ms(fwdl_start_time)
 		);
 	}
-	_FWDownloadEnable(padapter, false);
+	fw_download_enable(padapter, false);
 	if (_SUCCESS != rtStatus) {
 		DBG_88E("DL Firmware failed!\n");
 		goto Exit;
 	}
 
-	rtStatus = _FWFreeToGo(padapter);
+	rtStatus = fw_free_to_go(padapter);
 	if (_SUCCESS != rtStatus) {
 		DBG_88E("DL Firmware failed!\n");
 		goto Exit;
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 696beb29536f..3dc1c432e8cf 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -625,7 +625,7 @@ u32 rtl8188eu_hal_init(struct adapter *Adapter)
 
 	_InitTxBufferBoundary(Adapter, 0);
 
-	status = rtl8188e_FirmwareDownload(Adapter);
+	status = rtl8188e_firmware_download(Adapter);
 
 	if (status != _SUCCESS) {
 		DBG_88E("%s: Download Firmware failed!!\n", __func__);
diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 051f3b9fe726..11d79606e120 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -250,8 +250,8 @@ struct hal_data_8188e {
 };
 
 /*  rtl8188e_hal_init.c */
-s32 rtl8188e_FirmwareDownload(struct adapter *padapter);
-void _8051Reset88E(struct adapter *padapter);
+s32 rtl8188e_firmware_download(struct adapter *padapter);
+void rtw_reset_8051(struct adapter *padapter);
 
 s32 InitLLTTable(struct adapter *padapter, u8 txpktbuf_bndy);
 
-- 
2.34.1

