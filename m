Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9104FA76F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 14:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241704AbiDIMIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 08:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbiDIMIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 08:08:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1931706F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 05:06:42 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z99so4204576ede.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e2l4+TzWynqdn+GbmcVMBPCWsygQ6XPirUeVvI7JC2s=;
        b=JkrmEPriyHhrdIUJKSEF689S9aXzzAkOVE38FBavP/SuTci3QFCqq8N3Goh8ahf0ii
         3aaG3YRItNrHzlnXWAqXiUtSk18LcuCwuSkrQcnduxDCGhljgKzPL6rH1WTXI0OsATAQ
         nbe/ngKerMefy0Fy+IUD+vevZQxjva/51Fsz3Z5swwISeMbG6H5PZkmKKr2d7CPp7eEL
         GE3C/QONUJ0WggSG1+9G/SLjXY+Dh0pB2RXoWrCpq3wG/OH8qxDv0GdflXaSMwDnFyVp
         gmMGEOHv0lvySEgivuM5Yw7tBv1teHlmwmXn2UEk+QyD+zCn504Qmb2xzndEk617XZEr
         n09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e2l4+TzWynqdn+GbmcVMBPCWsygQ6XPirUeVvI7JC2s=;
        b=1J6gpw0Cya7ZXWiMFxNacq5N0oxmIbT7tbk3jpRYHkdXdR1f/BH3TsocMlMsFMVESS
         ftWLSwmE943H4+VA0tfJbfcpurHFzUNXVf94voNabYLsnjWAJPBn+F925X72FOTrOuCU
         p803qWitutizEwQJup0mJuRmW6s/9mHkTghZfle9vWHhK3oFxTU2Wmvwag9Mia+eL0i3
         D69UTvxeDdiTRpNGDIZyk8DT3SvhtD18BBVItwru5aNA/0RDaiCOhydE1+XR57G5pNAm
         viWeAQsipOxb5rrjovC7d4JN5GNMXpzE7N4RSL9ErDs9CQsmVl+RqMvGF9VLFMfbNljL
         3isA==
X-Gm-Message-State: AOAM5306X24exANZqWAWjrmfRitOQu1Awh5LXGRySLGZbSuNO+SqFErv
        qwUNVBpr1VfTIOSxwUXOv4EYkn0JJtQ=
X-Google-Smtp-Source: ABdhPJz1xHYk56YMm2DLOOnZRqJ7LJZW3TNEd7EYzFHHo5+hUKIlwHdGC9jjzmlbQdJxho0CbYJaVA==
X-Received: by 2002:a05:6402:6c1:b0:41d:6043:22ea with SMTP id n1-20020a05640206c100b0041d604322eamr4439096edy.332.1649506000889;
        Sat, 09 Apr 2022 05:06:40 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id z21-20020a170906435500b006e8669fae36sm1102947ejm.189.2022.04.09.05.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 05:06:40 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/4] staging: r8188eu: remove HW_VAR_INITIAL_GAIN
Date:   Sat,  9 Apr 2022 14:06:24 +0200
Message-Id: <20220409120627.10633-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220409120627.10633-1-straube.linux@gmail.com>
References: <20220409120627.10633-1-straube.linux@gmail.com>
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

Remove the HW_VAR_INITIAL_GAIN case from SetHwReg8188EU() and move its
functionality to a new static function in rtw_mlme_ext.c. This is part
of the ongoing effort to get rid of the unwanted hal layer.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 30 ++++++++++++++-------
 drivers/staging/r8188eu/hal/usb_halinit.c   | 13 ---------
 drivers/staging/r8188eu/include/hal_intf.h  |  1 -
 3 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 474391bf7cb5..e7fffd56196c 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -5794,13 +5794,27 @@ Following are some utitity fuctions for WiFi MLME
 
 *****************************************************************************/
 
+static void rtw_set_initial_gain(struct adapter *adapter, u8 gain)
+{
+	struct hal_data_8188e *haldata = &adapter->haldata;
+	struct odm_dm_struct *odmpriv = &haldata->odmpriv;
+	struct rtw_dig *digtable = &odmpriv->DM_DigTable;
+
+	if (gain == 0xff) {
+		/* restore rx gain */
+		ODM_Write_DIG(odmpriv, digtable->BackupIGValue);
+	} else {
+		digtable->BackupIGValue = digtable->CurIGValue;
+		ODM_Write_DIG(odmpriv, gain);
+	}
+}
+
 void site_survey(struct adapter *padapter)
 {
 	unsigned char		survey_channel = 0, val8;
 	enum rt_scan_type ScanType = SCAN_PASSIVE;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
-	u32 initialgain = 0;
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
 	if ((pwdinfo->rx_invitereq_info.scan_op_ch_only) || (pwdinfo->p2p_info.scan_op_ch_only)) {
@@ -5878,8 +5892,8 @@ void site_survey(struct adapter *padapter)
 			rtw_p2p_set_state(pwdinfo, P2P_STATE_FIND_PHASE_LISTEN);
 			pmlmeext->sitesurvey_res.state = SCAN_DISABLE;
 
-			initialgain = 0xff; /* restore RX GAIN */
-			SetHwReg8188EU(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain));
+			/* restore RX GAIN */
+			rtw_set_initial_gain(padapter, 0xff);
 			/* turn on dynamic functions */
 			Restore_DM_Func_Flag(padapter);
 			/* Switch_DM_Func(padapter, DYNAMIC_FUNC_DIG|DYNAMIC_FUNC_HP|DYNAMIC_FUNC_SS, true); */
@@ -5912,8 +5926,8 @@ void site_survey(struct adapter *padapter)
 			/* config MSR */
 			Set_MSR(padapter, (pmlmeinfo->state & 0x3));
 
-			initialgain = 0xff; /* restore RX GAIN */
-			SetHwReg8188EU(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain));
+			/* restore RX GAIN */
+			rtw_set_initial_gain(padapter, 0xff);
 			/* turn on dynamic functions */
 			Restore_DM_Func_Flag(padapter);
 			/* Switch_DM_Func(padapter, DYNAMIC_ALL_FUNC_ENABLE, true); */
@@ -7369,7 +7383,6 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 	struct sitesurvey_parm	*pparm = (struct sitesurvey_parm *)pbuf;
 	u8 bdelayscan = false;
 	u8 val8;
-	u32	initialgain;
 	u32	i;
 	struct wifidirect_info *pwdinfo = &padapter->wdinfo;
 
@@ -7418,11 +7431,10 @@ u8 sitesurvey_cmd_hdl(struct adapter *padapter, u8 *pbuf)
 
 		/* config the initial gain under scanning, need to write the BB registers */
 		if (rtw_p2p_chk_state(pwdinfo, P2P_STATE_NONE))
-			initialgain = 0x1E;
+			rtw_set_initial_gain(padapter, 0x1e);
 		else
-			initialgain = 0x28;
+			rtw_set_initial_gain(padapter, 0x28);
 
-		SetHwReg8188EU(padapter, HW_VAR_INITIAL_GAIN, (u8 *)(&initialgain));
 
 		/* set MSR to no link state */
 		Set_MSR(padapter, _HW_STATE_NOLINK_);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 5cbb982505a8..d8aea49afe8b 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1146,19 +1146,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtl8188e_set_FwPwrMode_cmd(Adapter, psmode);
 		}
 		break;
-	case HW_VAR_INITIAL_GAIN:
-		{
-			struct rtw_dig *pDigTable = &podmpriv->DM_DigTable;
-			u32 rx_gain = ((u32 *)(val))[0];
-
-			if (rx_gain == 0xff) {/* restore rx gain */
-				ODM_Write_DIG(podmpriv, pDigTable->BackupIGValue);
-			} else {
-				pDigTable->BackupIGValue = pDigTable->CurIGValue;
-				ODM_Write_DIG(podmpriv, rx_gain);
-			}
-		}
-		break;
 	case HW_VAR_FIFO_CLEARN_UP:
 		{
 			struct pwrctrl_priv *pwrpriv = &Adapter->pwrctrlpriv;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 532d02bba9f8..342587e05468 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -22,7 +22,6 @@ enum hw_variables {
 	HW_VAR_AC_PARAM_BE,
 	HW_VAR_AMPDU_FACTOR,
 	HW_VAR_H2C_FW_PWRMODE,
-	HW_VAR_INITIAL_GAIN,
 	HW_VAR_FIFO_CLEARN_UP,
 	HW_VAR_H2C_MEDIA_STATUS_RPT,
 };
-- 
2.35.1

