Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1765AABDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235696AbiIBJxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbiIBJwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:52:42 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F5CD530
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:52:39 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id y64so1982117ede.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=h3mhTe/mjeUDsRieRFZcGAvsQDavOcg5RIWTE5zQGmg=;
        b=P3QdD0gpQHruFVJqMa7Wzvc+n78eFD5RH+hz7cX3l6rx08EFj3fZWG05QZDc1tCA/N
         tqRdJWwx9/9Udq2YSEbOvUobkWiLQKGhoYbefcfJgEmpjeV9ek/f5nzNCNIuFcWsdw51
         Ika/mTSR3k7lfAFgRUqyy2B5HPmcfTULxXoqQS/NkaFvT+8l4UV9I7Ng0DThuyouyMlc
         Arx2cZJHg3/LlIUbqyiSVtXlDLR8rYB6EsX6QqtdMJ1bN6lC4F+BnlMZGDBG4oq4Nohi
         LHM1zFvigxswzvXcx8rs+phoLDRdUZapoyRSXylO3L9ErPNxHpr/1M16YSrV5JgztBsJ
         CQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=h3mhTe/mjeUDsRieRFZcGAvsQDavOcg5RIWTE5zQGmg=;
        b=342QWxUlkPfncoLrSP1fTJuncWDs+nsc2y8PO/wWfgwqesdusbt9rTuqJqOumYxcL7
         cutFz+fPGcRcR5k7KTmoiYL9QsE0Dh54t+Q+Mfnp4CwpyVgItyLR7/x512vSk/yCXL6Y
         i/vloerSn8ss4cu/9whbc0mG0hYUoINRlUTBwfR0A2BqIzgxRZiJmfrzVG+/W8jPGdtG
         IWuV6aaFP5N+7BBdrjGI7DgZCVc4Kf7DyDjbBAs43KskvckJ1DIeYBUZKNHiWI0rCP+n
         CADsng8FlSYP0ajYLiUnIzVhlFCIUYH1ISU2CnpRKzDfD2zM83w/ekNmLykw3Epgnaoy
         wRow==
X-Gm-Message-State: ACgBeo3aeHgs1U90pjPlnbQG2nM32MIZFnBhaaWx9BxUoTeglrmBGOUG
        iyQTnJqaqggQ4T6r9w8GVKE=
X-Google-Smtp-Source: AA6agR6XamPgDiGUEGLE9DLDhapoNvBAlbipZ3p2jb95dD0vAa9TTvWkK8BfBpaom1LZMB0xKqqtig==
X-Received: by 2002:a05:6402:428a:b0:42e:8f7e:1638 with SMTP id g10-20020a056402428a00b0042e8f7e1638mr32624816edc.228.1662112357639;
        Fri, 02 Sep 2022 02:52:37 -0700 (PDT)
Received: from localhost.localdomain (ip-217-105-46-83.ip.prioritytelecom.net. [217.105.46.83])
        by smtp.gmail.com with ESMTPSA id h6-20020a170906828600b0073d6234ceebsm959601ejx.160.2022.09.02.02.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 02:52:37 -0700 (PDT)
From:   Nam Cao <namcaov@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        hdegoede@redhat.com
Cc:     namcaov@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH 05/10] staging: rtl8723bs: remove odm_PauseDIG
Date:   Fri,  2 Sep 2022 11:51:55 +0200
Message-Id: <274e8338398d915327d353f713b2d47e48f92ba9.1662111798.git.namcaov@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1662111798.git.namcaov@gmail.com>
References: <cover.1662111798.git.namcaov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove function odm_PauseDIG because it is not used.

Signed-off-by: Nam Cao <namcaov@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_DIG.c | 57 -------------------------
 drivers/staging/rtl8723bs/hal/odm_DIG.h |  2 -
 2 files changed, 59 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
index 7e92c373cddb..07edf74ccfe5 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
@@ -309,63 +309,6 @@ void ODM_Write_DIG(void *pDM_VOID, u8 CurrentIGI)
 
 }
 
-void odm_PauseDIG(
-	void *pDM_VOID,
-	enum ODM_Pause_DIG_TYPE PauseType,
-	u8 IGIValue
-)
-{
-	struct dm_odm_t *pDM_Odm = (struct dm_odm_t *)pDM_VOID;
-	struct dig_t *pDM_DigTable = &pDM_Odm->DM_DigTable;
-	static bool bPaused;
-
-	if (
-		(pDM_Odm->SupportAbility & ODM_BB_ADAPTIVITY) &&
-		pDM_Odm->TxHangFlg == true
-	) {
-		return;
-	}
-
-	if (
-		!bPaused && (!(pDM_Odm->SupportAbility & ODM_BB_DIG) ||
-		!(pDM_Odm->SupportAbility & ODM_BB_FA_CNT))
-	){
-		return;
-	}
-
-	switch (PauseType) {
-	/* 1 Pause DIG */
-	case ODM_PAUSE_DIG:
-		/* 2 Disable DIG */
-		ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_ABILITY, pDM_Odm->SupportAbility & (~ODM_BB_DIG));
-
-		/* 2 Backup IGI value */
-		if (!bPaused) {
-			pDM_DigTable->IGIBackup = pDM_DigTable->CurIGValue;
-			bPaused = true;
-		}
-
-		/* 2 Write new IGI value */
-		ODM_Write_DIG(pDM_Odm, IGIValue);
-		break;
-
-	/* 1 Resume DIG */
-	case ODM_RESUME_DIG:
-		if (bPaused) {
-			/* 2 Write backup IGI value */
-			ODM_Write_DIG(pDM_Odm, pDM_DigTable->IGIBackup);
-			bPaused = false;
-
-			/* 2 Enable DIG */
-			ODM_CmnInfoUpdate(pDM_Odm, ODM_CMNINFO_ABILITY, pDM_Odm->SupportAbility | ODM_BB_DIG);
-		}
-		break;
-
-	default:
-		break;
-	}
-}
-
 bool odm_DigAbort(void *pDM_VOID)
 {
 	struct dm_odm_t *pDM_Odm = (struct dm_odm_t *)pDM_VOID;
diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.h b/drivers/staging/rtl8723bs/hal/odm_DIG.h
index 88cfd542df16..a5b041101c89 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.h
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.h
@@ -141,8 +141,6 @@ void odm_Adaptivity(void *pDM_VOID, u8 IGI);
 
 void ODM_Write_DIG(void *pDM_VOID, u8 CurrentIGI);
 
-void odm_PauseDIG(void *pDM_VOID, enum ODM_Pause_DIG_TYPE PauseType, u8 IGIValue);
-
 void odm_DIGInit(void *pDM_VOID);
 
 void odm_DIG(void *pDM_VOID);
-- 
2.25.1

