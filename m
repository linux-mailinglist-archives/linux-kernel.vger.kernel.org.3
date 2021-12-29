Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94994816CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 21:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbhL2UwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 15:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232010AbhL2Uvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 15:51:40 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF981C06173E
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:39 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q16so46590635wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 12:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nUh0l/NYOhj5OYFcmzELhPCuQaaICzcNcx63DNkni6g=;
        b=hIJ4JRYlTB0kHe3wLXvHB4scgsvr7loW9HPSajWN9dLsxK0AG8FoLHle822Fl93MTu
         /+Byiqt/FJKsfx/t4nH8K0m4VupvEJ4fgLjhc3qg/dSSN8V5aB7LCU3zg1aqdpEgg8SX
         Y/qrNh0kutXh0HhZNau/giIdg23+3yeaNDk8N4oHVlKVces4ZrP4rEa1M0FeOxKQ5eRm
         BU3gRKxwf8GBwOoaeslkNvrEImQDqfbhQOcQwP7UH0a8IamrqicyUyRxnWpPCo/ejMIR
         0X4pDx2FWQH557JeAzjvHMohwxum01j8HAD59/bw6Q7tramPH6lC7OzkrdbbtBrpKLZN
         2R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nUh0l/NYOhj5OYFcmzELhPCuQaaICzcNcx63DNkni6g=;
        b=UDBSXR6x88oBwO9aan4ZR2zTmd0Pa+vyG1kWVlRNRHLagXQ37m9ZOb6eH3qf+HgtTX
         pXLHFaGXtwsuLgTed1IeoKUFIucPq+819BsvEKGS3SFWNOT/4veAYg+Wqg1V8vlcr2HT
         CsBSpfPdzg7WsBaFaY26QlP9OaS/k+XaPZxnzcoz7ll152Zfn3neLtFs7l0K/S2BOPqm
         MNT3lG9ENx9LXCAraLBFdrqUrqn8Y+75tswqhiK1z2Rfc82XioOuiDRYbV94IRpp2wKk
         3oNXev1JuAHfjHhitTG0UL5VIDVXJnkqRnz7Z7ml9qEP06rLH1RYU5M84raSbAqPhYCF
         Gedg==
X-Gm-Message-State: AOAM530Hfdas7mgFjJNiH5jtuQlFRIjBFqVUEIneIc9uk3yjvg0LWhuU
        VflA45KRhKwDNhHq4+RDBfA=
X-Google-Smtp-Source: ABdhPJy4fE6IVVaUmAU6YFArInmcRwCB7cm+Lv4GLJF7oRjqM26W1GxJAZiY3vmDueJQqCzkyRJILg==
X-Received: by 2002:adf:df81:: with SMTP id z1mr22757078wrl.668.1640811098594;
        Wed, 29 Dec 2021 12:51:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::6619])
        by smtp.gmail.com with ESMTPSA id l12sm27421989wmq.2.2021.12.29.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 12:51:38 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 17/32] staging: r8188eu: make odm_CommonInfoSelfInit() static
Date:   Wed, 29 Dec 2021 21:50:53 +0100
Message-Id: <20211229205108.26373-18-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211229205108.26373-1-straube.linux@gmail.com>
References: <20211229205108.26373-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function odm_CommonInfoSelfInit() is only used in odm.c.
Make it static.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/odm.c             | 16 ++++++++--------
 drivers/staging/r8188eu/include/odm_precomp.h |  1 -
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 6f94954ba987..d62ae3e021be 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -303,6 +303,14 @@ static void odm_DIG(struct odm_dm_struct *pDM_Odm)
 	pDM_DigTable->DIG_Dynamic_MIN_0 = DIG_Dynamic_MIN;
 }
 
+static void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm)
+{
+	struct adapter *adapter = pDM_Odm->Adapter;
+
+	pDM_Odm->bCckHighPower = (bool)rtl8188e_PHY_QueryBBReg(adapter, 0x824, BIT(9));
+	pDM_Odm->RFPathRxEnable = (u8)rtl8188e_PHY_QueryBBReg(adapter, 0xc04, 0x0F);
+}
+
 /* 3 Export Interface */
 
 /*  2011/09/21 MH Add to describe different team necessary resource allocate?? */
@@ -426,14 +434,6 @@ void ODM_CmnInfoUpdate(struct odm_dm_struct *pDM_Odm, u32 CmnInfo, u64 Value)
 	}
 }
 
-void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm)
-{
-	struct adapter *adapter = pDM_Odm->Adapter;
-
-	pDM_Odm->bCckHighPower = (bool)rtl8188e_PHY_QueryBBReg(adapter, 0x824, BIT(9));
-	pDM_Odm->RFPathRxEnable = (u8)rtl8188e_PHY_QueryBBReg(adapter, 0xc04, 0x0F);
-}
-
 void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
 {
 	u8 EntryCnt = 0;
diff --git a/drivers/staging/r8188eu/include/odm_precomp.h b/drivers/staging/r8188eu/include/odm_precomp.h
index ea9fe7044314..b92e5b68161e 100644
--- a/drivers/staging/r8188eu/include/odm_precomp.h
+++ b/drivers/staging/r8188eu/include/odm_precomp.h
@@ -39,7 +39,6 @@ void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm);
 void odm_FalseAlarmCounterStatistics(struct odm_dm_struct *pDM_Odm);
 void odm_CCKPacketDetectionThresh(struct odm_dm_struct *pDM_Odm);
 void odm_EdcaTurboCheck(struct odm_dm_struct *pDM_Odm);
-void odm_CommonInfoSelfInit(struct odm_dm_struct *pDM_Odm);
 void odm_RSSIMonitorCheck(struct odm_dm_struct *pDM_Odm);
 void odm_RefreshRateAdaptiveMask(struct odm_dm_struct *pDM_Odm);
 void odm_TXPowerTrackingThermalMeterInit(struct odm_dm_struct *pDM_Odm);
-- 
2.34.1

