Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F954482709
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 09:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231355AbiAAISP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 03:18:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiAAISJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 03:18:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BABC061574
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jan 2022 00:18:09 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id e5so59604705wrc.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jan 2022 00:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTPq3bwy8yog6hFLtW+V15w6R9lOZAWWw5IrK/yQyN8=;
        b=HgKm7xkW/qoi/ID9pKhSSSbbF/4253umdAAPLBkG2ooU7m5o7vPdbout5Liuf4APqh
         egHIEF3SKUWBDnUjKTFbYFhBa70bj1f4l6VS0Yf6w9EQKyIyFs4lZUveBecSqGyCDbAb
         VqSQEsCL5sGG5mydHNwzXanpzUlhK335sFVp/QSQzOqBtSlaPr/Z6dC6uuObN2wARAy/
         tctqWxpxGxH7IzvPFwqtYUwKv3c42eRv99WQgI1vqLeQT+jhMciubDtyW7W+NHXzMHS2
         qFuJtcipZEAJSy3Jafc7IQkYen2uChAg+mc6iz2XTxKvkHSRIyRXSZjwe2MR3Ymwx/Yj
         YCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTPq3bwy8yog6hFLtW+V15w6R9lOZAWWw5IrK/yQyN8=;
        b=c2W87gATNvI261vXIfVd3reAZyq14HVBJCrmy4Sor1Hg1czVR2sQy9tKXrlCjyOcai
         ZMIfUIOLKxeljc/gytOTK49FXfyo+2IDq6Y0Pf8DcDfrDCctMVUBrHvaxf5WTOTivRiu
         7B0TkhLdurH+o1gSIOD7VjNtORTbFQr0gdUW4FvHj6dVcjc+zi2MMrdfKAm8q+PLDxLT
         PhXUn9gjWu30SS2yBp9KKZOrtuj9QyZfohFbbht8nEGn/OPTgIdBF/bQNCaqYufZ0oWA
         eX9cza7DXdMznQ50e8bKomn1tDSYVreorLFjHNhOGkfRAhkGFyRRriTxUdKRzZPhjA0y
         0xzQ==
X-Gm-Message-State: AOAM5308vKNwxa3MvDrDNWH2uq4wbVJS90FN/d2alIP7SUSXuBY+nhjI
        MXxE8Eh+Z9vagxHSO7Q444I=
X-Google-Smtp-Source: ABdhPJwKMf+fs+TBJ1CkJHY8LOPZFsGF3o+HS+5e3UgWJ4mJSAx7EQQma8XXTTKq3w3nQQue2pemyQ==
X-Received: by 2002:adf:f6c1:: with SMTP id y1mr31607998wrp.351.1641025087926;
        Sat, 01 Jan 2022 00:18:07 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id u9sm30693651wmm.7.2022.01.01.00.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 00:18:07 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 5/7] staging: r8188eu: remove unused fields from struct hal_data_8188e
Date:   Sat,  1 Jan 2022 09:17:56 +0100
Message-Id: <20220101081758.9716-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220101081758.9716-1-straube.linux@gmail.com>
References: <20220101081758.9716-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused fields from struct hal_data_8188e.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: no changes

 .../staging/r8188eu/include/rtl8188e_hal.h    | 30 -------------------
 1 file changed, 30 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
index 40b3db34b8f2..2ce42d647a34 100644
--- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
+++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
@@ -175,15 +175,9 @@ struct hal_data_8188e {
 
 	u16	BasicRateSet;
 
-	/*  EEPROM setting. */
-	u16	EEPROMSVID;
-	u16	EEPROMSDID;
 	u8	EEPROMRegulatory;
-
 	u8	EEPROMThermalMeter;
 
-	bool	EepromOrEfuse;
-
 	u8	Index24G_CCK_Base[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
 	u8	Index24G_BW40_Base[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
 	/* If only one tx, only BW20 and OFDM are used. */
@@ -192,11 +186,6 @@ struct hal_data_8188e {
 	s8	BW20_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
 	s8	BW40_24G_Diff[RF_PATH_MAX][MAX_TX_COUNT];
 
-	u8	TxPwrLevelCck[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
-	/*  For HT 40MHZ pwr */
-	u8	TxPwrLevelHT40_1S[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
-	/*  For HT 40MHZ pwr */
-	u8	TxPwrLevelHT40_2S[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
 	/*  HT 20<->40 Pwr diff */
 	u8	TxPwrHt20Diff[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
 	/*  For HT<->legacy pwr diff */
@@ -205,7 +194,6 @@ struct hal_data_8188e {
 	u8	PwrGroupHT20[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
 	u8	PwrGroupHT40[RF_PATH_MAX][CHANNEL_MAX_NUMBER];
 
-	u8	LegacyHTTxPowerDiff;/*  Legacy to HT rate power diff */
 	/*  The current Tx Power Level */
 	u8	CurrentCckTxPwrIdx;
 	u8	CurrentOfdm24GTxPwrIdx;
@@ -213,21 +201,12 @@ struct hal_data_8188e {
 	u8	CurrentBW4024GTxPwrIdx;
 
 	/*  Read/write are allow for following hardware information variables */
-	u8	framesync;
-	u32	framesyncC34;
-	u8	framesyncMonitor;
-	u8	DefaultInitialGain[4];
 	u8	pwrGroupCnt;
 	u32	MCSTxPowerLevelOriginalOffset[MAX_PG_GROUP][16];
-	u32	CCKTxPowerLevelOriginalOffset;
 
 	u8	CrystalCap;
-	u32	AntennaTxPath;			/*  Antenna path Tx */
-	u32	AntennaRxPath;			/*  Antenna path Rx */
 	u8	ExternalPA;
 
-	u8	b1x1RecvCombine;	/*  for 1T1R receive combining */
-
 	u32	AcParam_BE; /* Original parameter for BE, use for EDCA turbo. */
 
 	struct bb_reg_def PHYRegDef[2];	/* Radio A/B */
@@ -254,17 +233,9 @@ struct hal_data_8188e {
 	u8	FwRsvdPageStartOffset; /* Reserve page start offset except
 					*  beacon in TxQ. */
 
-	/*  2010/08/09 MH Add CU power down mode. */
-	bool		pwrdown;
-
 	u8	OutEpQueueSel;
 	u8	OutEpNumber;
 
-	/*  2010/11/22 MH Add for slim combo debug mode selective. */
-	/*  This is used for fix the drawback of CU TSMC-A/UMC-A cut.
-	 * HW auto suspend ability. Close BT clock. */
-	bool		SlimComboDbg;
-
 	u16	EfuseUsedBytes;
 
 	struct P2P_PS_Offload_t	p2p_ps_offload;
@@ -280,7 +251,6 @@ struct hal_data_8188e {
 	u8	C2hArray[16];
 	u8	UsbTxAggMode;
 	u8	UsbTxAggDescNum;
-	u32	MaxUsbRxAggBlock;
 
 	enum usb_rx_agg_mode UsbRxAggMode;
 	u8	UsbRxAggBlockCount;	/*  USB Block count. Block size is
-- 
2.34.1

