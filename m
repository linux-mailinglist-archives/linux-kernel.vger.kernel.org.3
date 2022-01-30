Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 454EA4A3853
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355807AbiA3TDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355523AbiA3TDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:03:38 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D51C061741
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:37 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id jx6so36377861ejb.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 11:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2J/aQ9AQ1tUzCIztuJ6yMYj0ykJYPL3EoCYMelHD2cg=;
        b=G/RYvTibsfIxb+lndRj/Cf0q2Ssir5hF4b2QBb2H9afM1ggumHWdJwCuTHi18nqDK3
         jiDgjiOwDgekk/cbPQfK11Brzrl/KR2bPEuk5J/PHwKUxj/ElgAFoNs4le+0MUqvUkww
         Zvrlm0pEEVIcc76Gfdi6RU7M0bYjCNr8sVxJVoiAkgTrv+wky5Sr4eVfBDXSBp+oaRu/
         rn3LwzKuY421Mm9cvLomIol3noGyAnBJSc7pWCPWZUX6HJxdScOJgrG9aAPPAmSOcqAy
         YCBEXB+3APsOd6lr+QT59faQ7EXkhY6R4GEphmkt5XjqaOO6a9jiukCc2oeV4z/e1QBT
         c9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2J/aQ9AQ1tUzCIztuJ6yMYj0ykJYPL3EoCYMelHD2cg=;
        b=sfqjoIAIpCeOqoPRtWeI8LyTiSzWjIgseaYb3R0GgTRWMVPHPMzUFTpwB01Ist79AY
         AtPhUJQbR2EwgFNO/dEXg2N5rk4dXvVauWUH54cp0bpOkZomMgqZBRIyqlEy8ZmMKyXE
         VnVPmigJaJhCkSLGYHnw+aAYoW4ercoBLnUh6wGFJ2W75u4dV+yDopm6Rd0lbU6PfuWh
         mgzsgkD+7MRoNXbPV/ue7zo+ImSeQWujBJEODdkhwnBHd2/jiYT/W7l8R5GHxPWVzFRg
         ie4YEopIYAxew+Z6rbrrBKFswNDNtUr0eDae0uO6yNYesgAh9Z7ZP1Jk5wGRHKyyANnt
         lTow==
X-Gm-Message-State: AOAM533OE+sqAMQ9Ue5XYicHCoi9s0jZnI+0HJY3/Yh5nUacXwbeVCAJ
        lgzZGqQYCUJYJnbi8BNIaPk=
X-Google-Smtp-Source: ABdhPJyoS14JOH+r7QylwrqKq0J9jt75zFltYWWsmsS6+ukiAYM4yezQDTmFtUNtm7xG4fKCMMwZLg==
X-Received: by 2002:a17:906:7316:: with SMTP id di22mr14901977ejc.505.1643569415685;
        Sun, 30 Jan 2022 11:03:35 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb5a.dynamic.kabel-deutschland.de. [95.90.187.90])
        by smtp.gmail.com with ESMTPSA id n3sm921124ejr.6.2022.01.30.11.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 11:03:35 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/12] staging: r8188eu: remove HW_VAR_SEC_CFG
Date:   Sun, 30 Jan 2022 20:03:11 +0100
Message-Id: <20220130190321.7172-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220130190321.7172-1-straube.linux@gmail.com>
References: <20220130190321.7172-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove HW_VAR_SEC_CFG from SetHwReg8188EU() and call rtw_write8()
directly.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 9 +++------
 drivers/staging/r8188eu/hal/usb_halinit.c   | 3 ---
 drivers/staging/r8188eu/include/hal_intf.h  | 1 -
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index ca4135ae587d..e7782d2499a8 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -6400,7 +6400,6 @@ u8 collect_bss_info(struct adapter *padapter, struct recv_frame *precv_frame, st
 void start_create_ibss(struct adapter *padapter)
 {
 	unsigned short	caps;
-	u8 val8;
 	u8 join_type;
 	struct mlme_ext_priv	*pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info	*pmlmeinfo = &pmlmeext->mlmext_info;
@@ -6415,8 +6414,7 @@ void start_create_ibss(struct adapter *padapter)
 	caps = rtw_get_capability((struct wlan_bssid_ex *)pnetwork);
 	update_capinfo(padapter, caps);
 	if (caps & cap_IBSS) {/* adhoc master */
-		val8 = 0xcf;
-		SetHwReg8188EU(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
+		rtw_write8(padapter, REG_SECCFG, 0xcf);
 
 		/* switch channel */
 		/* SelectChannel(padapter, pmlmeext->cur_channel, HAL_PRIME_CHNL_OFFSET_DONT_CARE); */
@@ -6472,7 +6470,7 @@ void start_clnt_join(struct adapter *padapter)
 
 		val8 = (pmlmeinfo->auth_algo == dot11AuthAlgrthm_8021X) ? 0xcc : 0xcf;
 
-		SetHwReg8188EU(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
+		rtw_write8(padapter, REG_SECCFG, val8);
 
 		/* switch channel */
 		set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode);
@@ -6488,8 +6486,7 @@ void start_clnt_join(struct adapter *padapter)
 	} else if (caps & cap_IBSS) { /* adhoc client */
 		Set_MSR(padapter, WIFI_FW_ADHOC_STATE);
 
-		val8 = 0xcf;
-		SetHwReg8188EU(padapter, HW_VAR_SEC_CFG, (u8 *)(&val8));
+		rtw_write8(padapter, REG_SECCFG, 0xcf);
 
 		/* switch channel */
 		set_channel_bwmode(padapter, pmlmeext->cur_channel, pmlmeext->cur_ch_offset, pmlmeext->cur_bwmode);
diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
index 95e89c3063f1..1fa57354389a 100644
--- a/drivers/staging/r8188eu/hal/usb_halinit.c
+++ b/drivers/staging/r8188eu/hal/usb_halinit.c
@@ -1290,9 +1290,6 @@ void SetHwReg8188EU(struct adapter *Adapter, u8 variable, u8 *val)
 			rtw_write8(Adapter, REG_RRSR + 2, regTmp);
 		}
 		break;
-	case HW_VAR_SEC_CFG:
-		rtw_write8(Adapter, REG_SECCFG, *((u8 *)val));
-		break;
 	case HW_VAR_DM_FLAG:
 		podmpriv->SupportAbility = *((u8 *)val);
 		break;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index f5a6cb9a03fd..5fb0143c86fe 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -23,7 +23,6 @@ enum hw_variables {
 	HW_VAR_SLOT_TIME,
 	HW_VAR_RESP_SIFS,
 	HW_VAR_ACK_PREAMBLE,
-	HW_VAR_SEC_CFG,
 	HW_VAR_BCN_VALID,
 	HW_VAR_DM_FLAG,
 	HW_VAR_DM_FUNC_OP,
-- 
2.34.1

