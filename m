Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5564C4CD9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiBYRtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBYRtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:49:11 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EF42118E7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:48:38 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a8so12285546ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wpJrU2b7v7CL9UCI2QuiW9U5b87AMAnh8NHOnYuVjcs=;
        b=EttKkSdEAUvjuAqk58bkrPK6Q8Bva7vriJJl5l2/m9c1DBl63QAI+OS0UbpRLrm0Gp
         2YdptCK1j51Do8vGjvQjTKZUtkhUYXV5Ob4tNC+oe/p60bVu/asSSVmEqMfgna1EVWrJ
         cDFxrLN+zGNIG6FKOMSXoDw/bf2+C7arf8HXvI5QBHP9FOEfFxZsM+gPa3NzR1G2jfSY
         RSLs7pf+BKFWYQg/rw7+zJhIQQ0uPEmzM1tTbfb0N8oV2WYFYdKfaVTjbF0cccOam4Rl
         TuCNNHfG0MV8FtpSpEqWhttf/h44CL7iWTdrAyS2KFmkQmXv/xPh0O/ufQdMBeYzOaPE
         0H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wpJrU2b7v7CL9UCI2QuiW9U5b87AMAnh8NHOnYuVjcs=;
        b=R9LD6V3cq7hfNhnJMwreJ4vvWit8/Ck/9N/jEGPScWmIUC1kO4dfuWrRIzg2jGz8bc
         KPsKaCjtBOvf2M5K8EQmGzVQBjwqmVyz0UHSUf7BBXQ+xwg862RssBVrRx0d490auWJo
         FkhDUvvTMRMKpNhwg7EcEv5oMpAklEj69UTLLiVwmNvyewb724axLJ9MoLwCv21O0l+g
         ejWRxtZhFQhd1sTyJpjMRtHUE4LE4uda1RUiOuvwlJ8cntekcCl84h0gfCX1TBO+A91I
         ENpQgAVxbi4cK26641uh5ydgHFQ/a/R1RFX3RL6gId31qyx4QWmpbenPVKBGUC1Lp2F6
         5HIw==
X-Gm-Message-State: AOAM531Z7leblqJBlZ/iigk/Iw2CSDLbDuuNQG10cEg5QDYjzOfGXC6X
        7uNLmYyA2t84J4s3rOTlVpc=
X-Google-Smtp-Source: ABdhPJyMO37YdwtPW7XsnYf4MD3Qobx/aSE2sXhM+7mesYI3uEc88vPohW68b5qPAjbEmiyI2xf8jw==
X-Received: by 2002:a17:906:a213:b0:6b5:b0f9:7567 with SMTP id r19-20020a170906a21300b006b5b0f97567mr7091278ejy.129.1645811316879;
        Fri, 25 Feb 2022 09:48:36 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8d.dynamic.kabel-deutschland.de. [95.90.187.141])
        by smtp.gmail.com with ESMTPSA id v5-20020a056402184500b00412e1a73c7bsm1603571edy.61.2022.02.25.09.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:48:36 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: r8188eu: remove _linked_rx_signal_strength_display()
Date:   Fri, 25 Feb 2022 18:48:27 +0100
Message-Id: <20220225174827.15927-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
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

The function _linked_rx_signal_strength_display() only sets two local
variables that are not used after setting. Remove the function and
remove resulting dead code.

The HW_DEF_RA_INFO_DUMP case in GetHalDefVar8188EUsb() does not set
the passed variable. It just calls check_fwstate() which does nothing
than return true or false. So it is safe to remove this call to
GetHalDefVar8188EUsb().

The HAL_DEF_UNDERCORATEDSMOOTHEDPWDB case in GetHalDefVar8188EUsb()
does nothing than set the passed variable and it is safe to remove
this call to GetHalDefVar8188EUsb() as well.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
Tested on x86_64 with Inter-Tech DMG-02.

 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 20 --------------------
 drivers/staging/r8188eu/hal/usb_halinit.c   | 13 -------------
 drivers/staging/r8188eu/include/hal_intf.h  |  2 --
 3 files changed, 35 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 0b77ddde6ce2..580d0c15b958 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6834,23 +6834,6 @@ void mlmeext_sta_del_event_callback(struct adapter *padapter)
 Following are the functions for the timer handlers
 
 *****************************************************************************/
-static void _linked_rx_signal_strength_display(struct adapter *padapter)
-{
-	struct mlme_ext_priv    *pmlmeext = &padapter->mlmeextpriv;
-	struct mlme_ext_info    *pmlmeinfo = &pmlmeext->mlmext_info;
-	u8 mac_id;
-	int UndecoratedSmoothedPWDB;
-
-	if ((pmlmeinfo->state & 0x03) == WIFI_FW_STATION_STATE)
-		mac_id = 0;
-	else if ((pmlmeinfo->state & 0x03) == _HW_STATE_AP_)
-		mac_id = 2;
-
-	GetHalDefVar8188EUsb(padapter, HW_DEF_RA_INFO_DUMP, &mac_id);
-
-	GetHalDefVar8188EUsb(padapter, HAL_DEF_UNDERCORATEDSMOOTHEDPWDB, &UndecoratedSmoothedPWDB);
-}
-
 static u8 chk_ap_is_alive(struct sta_info *psta)
 {
 	u8 ret = false;
@@ -6886,9 +6869,6 @@ void linked_status_chk(struct adapter *padapter)
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
 	struct sta_priv		*pstapriv = &padapter->stapriv;
 
-	if (padapter->bRxRSSIDisplay)
-		_linked_rx_signal_strength_display(padapter);
-
 	rtl8188e_sreset_linked_status_check(padapter);
 
 	if (is_client_associated_to_ap(padapter)) {
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 0704fa3156af..3eafc298f3e1 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1399,16 +1399,6 @@ void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 	struct hal_data_8188e *haldata = &Adapter->haldata;
 
 	switch (eVariable) {
-	case HAL_DEF_UNDERCORATEDSMOOTHEDPWDB:
-		{
-			struct mlme_priv *pmlmepriv = &Adapter->mlmepriv;
-			struct sta_priv *pstapriv = &Adapter->stapriv;
-			struct sta_info *psta;
-			psta = rtw_get_stainfo(pstapriv, pmlmepriv->cur_network.network.MacAddress);
-			if (psta)
-				*((int *)pValue) = psta->rssi_stat.UndecoratedSmoothedPWDB;
-		}
-		break;
 	case HAL_DEF_IS_SUPPORT_ANT_DIV:
 		*((u8 *)pValue) = (haldata->AntDivCfg == 0) ? false : true;
 		break;
@@ -1418,9 +1408,6 @@ void GetHalDefVar8188EUsb(struct adapter *Adapter, enum hal_def_variable eVariab
 	case HAL_DEF_DBG_DM_FUNC:
 		*((u32 *)pValue) = haldata->odmpriv.SupportAbility;
 		break;
-	case HW_DEF_RA_INFO_DUMP:
-		check_fwstate(&Adapter->mlmepriv, _FW_LINKED);
-		break;
 	case HAL_DEF_DBG_DUMP_RXPKT:
 		*((u8 *)pValue) = haldata->bDumpRxPkt;
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 8e204d61cc53..3cededa4dcfc 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -43,12 +43,10 @@ enum hw_variables {
 };
 
 enum hal_def_variable {
-	HAL_DEF_UNDERCORATEDSMOOTHEDPWDB,
 	HAL_DEF_IS_SUPPORT_ANT_DIV,
 	HAL_DEF_CURRENT_ANTENNA,
 	HAL_DEF_DBG_DUMP_RXPKT,/* for dbg */
 	HAL_DEF_DBG_DM_FUNC,/* for dbg */
-	HW_DEF_RA_INFO_DUMP,
 	HAL_DEF_DBG_DUMP_TXPKT,
 };
 
-- 
2.35.1

