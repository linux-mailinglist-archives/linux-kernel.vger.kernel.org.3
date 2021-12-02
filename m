Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA428466A63
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 20:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376830AbhLBT07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 14:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354341AbhLBT0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 14:26:43 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B17C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 11:23:21 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l25so2032071eda.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 11:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k8V8pUt+WGRfiTwkpc4qq8UAMQGA384FOQPAoawdWxk=;
        b=aJn2GDAYGc4lLQSokkKvenVD4jG39KQr24RuiyIRm+RxCSL6OaHgrb6Ia492EHFWjk
         7htXHtYU9UI0K3YlC9UClnx+objx8S1ASmrqEGf+XB8nJovoYS+qshyS7g9mtg/5wHLI
         hqLS+5HAxuRCTwbrVZMtogWeWHpVUinCL84uc6Xym/uoIGGydCSiawPbNyd1P7Kz8y3j
         1TzOV6ivgetMG/0V75KHYJgpSQFciUSPm0QnI08CoathzDAMrYbpJNXBv2RFk+KYXo9z
         p31qPWG3DajtXYZ2B8Fnb+SrdN55EXxTX60RFFseQT/lsw1HFpA9npaH12z1SCN+ditr
         o2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k8V8pUt+WGRfiTwkpc4qq8UAMQGA384FOQPAoawdWxk=;
        b=SPM+sjaFZ3kmXX9GczEbds7cIq9gtdBMBr37k9TVX8JXWC4uSK/IYdgx4EohiMob5A
         CTKzqg3hnpBjpejfVciHzGeGEx+YBpwu412BYpuyCMoyahqBdgcDjT9IsZd5PinRpV21
         xXjFYfIUeAa3xcpmz5rN6dfl4C+790cwdnqKFF1k5vup2o7QEEkeD0jwRpSzjN6Sa024
         uIUluVyfxxCl3RdaZAeIbhEMD4knksszjRVQqBCjR4lTxge9TTu3G1WA9ooDVaUVy4C3
         Q2DqLvfoGybfYx6XkyFLvsm+0vmZE3aj9FG/pO3Oa5VeVT0J4cIBDZVdF1iwVe/fj/Al
         kKMA==
X-Gm-Message-State: AOAM531Juitku9Kp8EK2TX3Lg5bUO+adxuHSD8USDGIvZZCt3c0QvDc6
        ZU8E4AfAyboLG6gohHffaQA=
X-Google-Smtp-Source: ABdhPJwMgwCO26y5SeFi8zRaSituWtGsRoPjZTj5PXiNWdcrvWOZEUpXdND/TSklkvO7MzjU6Lxy9Q==
X-Received: by 2002:a17:906:2b12:: with SMTP id a18mr17404615ejg.254.1638472999651;
        Thu, 02 Dec 2021 11:23:19 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::5a05])
        by smtp.gmail.com with ESMTPSA id jg36sm432530ejc.44.2021.12.02.11.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 11:23:19 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/5] staging: r8188eu: pNumTxBytesUnicast is set but never used
Date:   Thu,  2 Dec 2021 20:23:08 +0100
Message-Id: <20211202192309.9362-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202192309.9362-1-straube.linux@gmail.com>
References: <20211202192309.9362-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pNumTxBytesUnicast in odm_dm_struct is set but never used.
Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c         | 3 ---
 drivers/staging/r8188eu/hal/rtl8188e_dm.c | 1 -
 drivers/staging/r8188eu/include/odm.h     | 3 ---
 3 files changed, 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index f3498454ee1a..86758a603cfc 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -225,9 +225,6 @@ void ODM_CmnInfoHook(struct odm_dm_struct *pDM_Odm, enum odm_common_info_def Cmn
 	/*  */
 	switch	(CmnInfo) {
 	/*  Dynamic call by reference pointer. */
-	case	ODM_CMNINFO_TX_UNI:
-		pDM_Odm->pNumTxBytesUnicast = (u64 *)pValue;
-		break;
 	case	ODM_CMNINFO_RX_UNI:
 		pDM_Odm->pNumRxBytesUnicast = (u64 *)pValue;
 		break;
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_dm.c b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
index 389a0c650388..494175bb2739 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_dm.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_dm.c
@@ -68,7 +68,6 @@ static void Update_ODM_ComInfo_88E(struct adapter *Adapter)
 
 	ODM_CmnInfoUpdate(dm_odm, ODM_CMNINFO_ABILITY, pdmpriv->InitODMFlag);
 
-	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_TX_UNI, &Adapter->xmitpriv.tx_bytes);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_RX_UNI, &Adapter->recvpriv.rx_bytes);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_WM_MODE, &pmlmeext->cur_wireless_mode);
 	ODM_CmnInfoHook(dm_odm, ODM_CMNINFO_SEC_CHNL_OFFSET, &hal_data->nCur40MhzPrimeSC);
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index bb1df9d2d652..ca8d60b515f4 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -224,7 +224,6 @@ enum odm_common_info_def {
 
 	/*  Dynamic value: */
 /*  POINTER REFERENCE-----------  */
-	ODM_CMNINFO_TX_UNI,
 	ODM_CMNINFO_RX_UNI,
 	ODM_CMNINFO_WM_MODE,		/*  ODM_WIRELESS_MODE_E */
 	ODM_CMNINFO_SEC_CHNL_OFFSET,	/*  ODM_SEC_CHNL_OFFSET_E */
@@ -471,8 +470,6 @@ struct odm_dm_struct {
 
 	/*  Dynamic Value */
 /*  POINTER REFERENCE----------- */
-	/* TX Unicast byte count */
-	u64	*pNumTxBytesUnicast;
 	/* RX Unicast byte count */
 	u64	*pNumRxBytesUnicast;
 	/*  Wireless mode B/G/A/N = BIT(0)/BIT(1)/BIT(2)/BIT(3) */
-- 
2.34.0

