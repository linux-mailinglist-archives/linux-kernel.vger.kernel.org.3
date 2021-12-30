Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB657482025
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 21:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbhL3UBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 15:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242069AbhL3UBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 15:01:10 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABDAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:10 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a9so52283476wrr.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 12:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B1vSJDEPA92WJZ+OLUXTW8AO9oxcwVbu51WrMzfIzm0=;
        b=Kom2npQpWrk9ZTSpsGA3lB3KehkgszsYsoJCTXU+m+XFDxqNy+47PaJclLShkoy4BU
         Jg+tykmOBvhDnZ5uoOtvCAZeHT0AIM/ltpIcVywDuy3WjlrHoRFjhjcwMO7vWVo1/a8s
         qawjIaWaX01HeKIVOr0z4lQEBtQtBjLJp9vEmdxQNsFl1GaoXG0/CW+g1bt2cQkNR/J0
         z3J1cq2ZaGWS3fflxx3aX2mwcafZgaZSWWi/SX9JRE9BB8mCFGp1WnZMcq4+um3Z+e6B
         btXDIVsz82T1eAya6iFUY55sCVpPOfmdb46Z+AAJvaJQgk1ggGFlkI3a25go92mvSLiT
         zd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B1vSJDEPA92WJZ+OLUXTW8AO9oxcwVbu51WrMzfIzm0=;
        b=CnaejzP5d90bkzPo2dwi3QhLBdFApCYbs8m0OgU02mtSrv3Czmy8VGTkiK0cUpvkpM
         BGn0OxmOIs2F+psXHe2SCjPzyzrboaZI08jd/cOPLNDOehYOUT/GWKuulS5Rj9yunRKn
         rfsGcbNA3HvtBP3YMDSaU485zjHe2G5GdZ3MJ8qmf4g83ASaMRFik4hcXrhb8WyfKoy0
         b6f45SzVqvFjTtGa84kZGdWCwJojRrHF35EFAWNTbCCId3xa9nz+exSyl1Ahaaasq3JB
         6eaC3cN1XlmZV7UhW8QiDHaOSALLvrGMRiW02/XWmWi+cgy/cv9PfSrGwEGrf2RizF0Y
         +t+g==
X-Gm-Message-State: AOAM531P9NJS+3hM0MC/zDfaSIy7vAEPWWRcDdRKAGdzPiHmle1Zp6hx
        QYg7YvjRfCQ7OVTENtJBdhk=
X-Google-Smtp-Source: ABdhPJxWGGxzUblQgB4eK/E0Aux7Ry6+fWaVirWaA+gqIoZGHU9jEZje2S76ltgf3nS69CKoXcxuzw==
X-Received: by 2002:adf:b60e:: with SMTP id f14mr2604087wre.11.1640894469031;
        Thu, 30 Dec 2021 12:01:09 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id o8sm29042286wry.20.2021.12.30.12.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 12:01:08 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 5/7] staging: r8188eu: remove unused fields from struct hal_data_8188e
Date:   Thu, 30 Dec 2021 21:00:57 +0100
Message-Id: <20211230200059.13406-6-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211230200059.13406-1-straube.linux@gmail.com>
References: <20211230200059.13406-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused fields from struct hal_data_8188e.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
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

