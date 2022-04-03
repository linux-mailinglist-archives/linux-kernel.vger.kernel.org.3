Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB524F0B5A
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 18:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359500AbiDCQzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 12:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355784AbiDCQy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 12:54:58 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DFF3915D
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 09:53:04 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id g20so8420896edw.6
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 09:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6ppqJI6bbXknNDSSsJIou3kIlI0a1zrBWncxQPeAqXw=;
        b=eO4A/B8Rbvg6+KTk8Q4V11CE6ik1HKgFFfLiNJga4J4Y4h6nPl1JaYnGi2k0gYTueI
         B+n8t33+dDXRX4z2QEJAmhrvXLBbv1BDalzX4ARwNWrzt6vcsiAQO5Fm2ZuuKoy7PsG9
         v2Xe0Kzq9lGRl2rOj6Z7H43sUSua4fSmupcpgRKmVZBHEDsaGtd7/wPd/r3VVe9t2pbd
         S3uDgFsEAqULZXa1BYFnJF7KwmSWLKtrOXpmpYIgm2J2FkvgvdCaAVHGLwwUZlPSQ5WA
         KLyHYzZLCtuQpOm0IxyOX4yk06bBv4aeUp739l24Nh2aiZt5cZkNSwftn87MkdA2uzWu
         01qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6ppqJI6bbXknNDSSsJIou3kIlI0a1zrBWncxQPeAqXw=;
        b=EavUce00QJ9TM5eQhTMOufH5vBGpWguTDF7CbHTAeXRFSUEJpqBALVA5SVKXLFIsQT
         PGD2GvAh2X3+DM6hXNEqE21QN+Thplw00bJprMtjomjQlchM5G2s9DUDUVPWPOSMcD/V
         6Iw8ws+63U18Kr6YMMBCObTiOMpx4LachV4O6mgzeQjtAydSt/pS3KBvMbppuaY4pjrw
         9ksf3ek1wK3dRvitEntKi1MabtSTJNn/ZiNI6TYgwo9jyNcPC+V/Vpbm1pPvzGfVnsuG
         P3KIUKOe+90PyaYnWqGEdGz1yuVw38w59hfYAIIjsMiQbMGdsu8roq1ATvjM+ji5XZyQ
         gwwQ==
X-Gm-Message-State: AOAM531ZnaOgto0XOA7lypNanT/W82zejr8ni+SgwMNrr++H9SypM4YJ
        C4LjgFPNtF6jC5/Hj09Tnog=
X-Google-Smtp-Source: ABdhPJz7iGMzQylnp6xiZ8+xjEBOJvO9t+6oZBhF04quwPsb32ENmk3xPMKMy8SE7IACgTCKfCrk9g==
X-Received: by 2002:a05:6402:1148:b0:416:a4fb:3c2e with SMTP id g8-20020a056402114800b00416a4fb3c2emr29423188edw.182.1649004783078;
        Sun, 03 Apr 2022 09:53:03 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id d4-20020a056402000400b00412d60fee38sm4018138edu.11.2022.04.03.09.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 09:53:02 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: remove HAL_DEF_IS_SUPPORT_ANT_DIV
Date:   Sun,  3 Apr 2022 18:52:51 +0200
Message-Id: <20220403165255.6900-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220403165255.6900-1-straube.linux@gmail.com>
References: <20220403165255.6900-1-straube.linux@gmail.com>
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

In order to get rid of the function GetHalDefVar8188EUsb(), remove
the HAL_DEF_IS_SUPPORT_ANT_DIV case from it and move the functionality
into a new function. This is part of the ongoing effort to get rid of
the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_cmd.c     |  4 +---
 drivers/staging/r8188eu/core/rtw_mlme.c    |  4 +---
 drivers/staging/r8188eu/hal/usb_halinit.c  | 10 +++++++---
 drivers/staging/r8188eu/include/hal_intf.h |  3 ++-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
index 8b24330e97c1..c286485e6a40 100644
--- a/drivers/staging/r8188eu/core/rtw_cmd.c
+++ b/drivers/staging/r8188eu/core/rtw_cmd.c
@@ -1099,11 +1099,9 @@ u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
 	struct cmd_obj		*ph2c;
 	struct drvextra_cmd_parm	*pdrvextra_cmd_parm;
 	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-	u8	support_ant_div;
 	u8	res = _SUCCESS;
 
-	GetHalDefVar8188EUsb(padapter, HAL_DEF_IS_SUPPORT_ANT_DIV, &support_ant_div);
-	if (!support_ant_div)
+	if (!support_ant_div(padapter))
 		return res;
 
 	if (enqueue) {
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index f94b1536a177..b6ed5fb5b281 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1458,7 +1458,6 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 	struct __queue *queue	= &pmlmepriv->scanned_queue;
 	struct	wlan_network	*pnetwork = NULL;
 	struct	wlan_network	*candidate = NULL;
-	u8	supp_ant_div = false;
 
 	spin_lock_bh(&pmlmepriv->scanned_queue.lock);
 	phead = get_list_head(queue);
@@ -1485,8 +1484,7 @@ int rtw_select_and_join_from_scanned_queue(struct mlme_priv *pmlmepriv)
 		rtw_free_assoc_resources(adapter, 0);
 	}
 
-	GetHalDefVar8188EUsb(adapter, HAL_DEF_IS_SUPPORT_ANT_DIV, &supp_ant_div);
-	if (supp_ant_div) {
+	if (support_ant_div(adapter)) {
 		u8 cur_ant;
 		GetHalDefVar8188EUsb(adapter, HAL_DEF_CURRENT_ANTENNA, &cur_ant);
 	}
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 4bc6b08fb282..31ec88b7a400 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -481,6 +481,13 @@ static void _BBTurnOnBlock(struct adapter *Adapter)
 	rtl8188e_PHY_SetBBReg(Adapter, rFPGA0_RFMOD, bOFDMEn, 0x1);
 }
 
+bool support_ant_div(struct adapter *adapter)
+{
+	struct hal_data_8188e *haldata = &adapter->haldata;
+
+	return haldata->AntDivCfg != 0;
+}
+
 static void _InitAntenna_Selection(struct adapter *Adapter)
 {
 	struct hal_data_8188e *haldata = &Adapter->haldata;
@@ -1204,9 +1211,6 @@ void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 	struct hal_data_8188e *haldata = &Adapter->haldata;
 
 	switch (eVariable) {
-	case HAL_DEF_IS_SUPPORT_ANT_DIV:
-		*((u8 *)pValue) = (haldata->AntDivCfg == 0) ? false : true;
-		break;
 	case HAL_DEF_CURRENT_ANTENNA:
 		*((u8 *)pValue) = haldata->CurAntenna;
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index e222ab89bfc5..2a82bc392b87 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -28,7 +28,6 @@ enum hw_variables {
 };
 
 enum hal_def_variable {
-	HAL_DEF_IS_SUPPORT_ANT_DIV,
 	HAL_DEF_CURRENT_ANTENNA,
 	HAL_DEF_DBG_DM_FUNC,/* for dbg */
 };
@@ -64,6 +63,8 @@ uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
 void rtw_hal_stop(struct adapter *padapter);
 
+bool support_ant_div(struct adapter *adapter);
+
 u32 rtl8188eu_hal_init(struct adapter *Adapter);
 u32 rtl8188eu_hal_deinit(struct adapter *Adapter);
 
-- 
2.35.1

