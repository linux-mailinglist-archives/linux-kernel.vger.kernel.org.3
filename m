Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B53548BDDC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 05:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350712AbiALEWU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 23:22:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350644AbiALEWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 23:22:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FCCAC061748
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:22:13 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso9385577pjm.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k1CvHCi8TZtIaZG3Bq0qS6ZhlctMk+7qABS/i6xkMSo=;
        b=fX30lOZ4FMJYr8CjAkgql92CW01yJo51P/NyvoW2q3Otmx1d7TgGIIOGCMAUfEUONo
         fi6mrvtSxZ2Dj1CK+4ZtvPW6Ose0K0hMp4yfJ943LAUbRuHxLXI1dNf8wbhh/UQi/nIR
         EE/U3JeY5lpy1uX+peOLmLa4K0ift8XklH4ZfGVrFj58X4e2wFamWtRk0QVL5OGMammm
         GJ9dYwrRa1j2tu3fAZfNjmjSWNiQL/icAFH5CqWtihKBqY7TkMNV0NOIN9weNX/C59M0
         QJnOgztUcDdUxNPcXBfoOBgEzJizRGoalUDYQwYTPJ2pNZ/vt00WcEwNKAn48Cts4nNI
         s9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k1CvHCi8TZtIaZG3Bq0qS6ZhlctMk+7qABS/i6xkMSo=;
        b=J/AQXeJHczl2MXEoFwSW5lP1myWQC1a9kPKXddxBGMXyHomIsA6e5AyZfalIe5fuhh
         Rl/y+8/8KM+kUeQRakWPaJk/16LgsZzoKYmHSsGq9nBlYozscjat4soOOkG0AF5GYjqy
         hmgd7Dx4sevSpZIuE3ajGN7XG4SWGCELngeKj6bYZvp7H92GZ69qNfZa0O/Tnbd451y1
         sMTGoyfz4ggXQNu+Aho6I+RoQRAcZzLXXwmWHmhI0uKtRiDZjZe54VonnqsKLfJFIWaQ
         FSnLAwv2wuAs+95o/5X74M6mKjnvWEMPyIsds4PSu42VbqT89/3vnvCcaDGeXnloNwD7
         SHNQ==
X-Gm-Message-State: AOAM533CzDadDegDlbU3tiQuNYQZBzPJXO1suO97OYYhgnshkFeN/f+f
        Zx4UbaZw8eOvanFb6V7Prvs=
X-Google-Smtp-Source: ABdhPJzq+/s/gE+BaV/JcOeqHlDltMnS5dSpSDKYFDU7LPdDSGbuHCJQTK3LG6ayx3bqlh5+s45ZaA==
X-Received: by 2002:a05:6a00:198a:b0:4bb:4621:f074 with SMTP id d10-20020a056a00198a00b004bb4621f074mr7649925pfl.69.1641961332980;
        Tue, 11 Jan 2022 20:22:12 -0800 (PST)
Received: from localhost.localdomain ([115.99.137.58])
        by smtp.gmail.com with ESMTPSA id t207sm11237747pfc.205.2022.01.11.20.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 20:22:12 -0800 (PST)
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        marcocesati@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        jagathjog1996@gmail.com
Subject: [PATCH  3/4] Staging: rtl8723bs: Removed extra spaces between datatype and variable
Date:   Wed, 12 Jan 2022 09:52:00 +0530
Message-Id: <20220112042201.5056-4-jagathjog1996@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220112042201.5056-1-jagathjog1996@gmail.com>
References: <20220112042201.5056-1-jagathjog1996@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following checkpatch.pl warning by placing single space between
datatype and variable
WARNING: please, no space before tabs

Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 42 +++++++++++-------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index b28351a97cd3..79294e25c3f4 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -531,9 +531,9 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	struct rtw_ieee80211_channel *ch, int ch_num)
 {
 	u8 res = _FAIL;
-	struct cmd_obj		*ph2c;
-	struct sitesurvey_parm	*psurveyPara;
-	struct cmd_priv 	*pcmdpriv = &padapter->cmdpriv;
+	struct cmd_obj *ph2c;
+	struct sitesurvey_parm *psurveyPara;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	if (check_fwstate(pmlmepriv, _FW_LINKED))
@@ -632,8 +632,8 @@ void rtw_getbbrfreg_cmdrsp_callback(struct adapter *padapter,  struct cmd_obj *p
 u8 rtw_createbss_cmd(struct adapter  *padapter)
 {
 	struct cmd_obj *pcmd;
-	struct cmd_priv 			*pcmdpriv = &padapter->cmdpriv;
-	struct wlan_bssid_ex		*pdev_network = &padapter->registrypriv.dev_network;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+	struct wlan_bssid_ex *pdev_network = &padapter->registrypriv.dev_network;
 	u8 res = _SUCCESS;
 
 	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
@@ -707,14 +707,14 @@ u8 rtw_joinbss_cmd(struct adapter  *padapter, struct wlan_network *pnetwork)
 {
 	u8 res = _SUCCESS;
 	uint	t_len = 0;
-	struct wlan_bssid_ex		*psecnetwork;
-	struct cmd_obj		*pcmd;
-	struct cmd_priv 	*pcmdpriv = &padapter->cmdpriv;
-	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
-	struct qos_priv 	*pqospriv = &pmlmepriv->qospriv;
+	struct wlan_bssid_ex *psecnetwork;
+	struct cmd_obj *pcmd;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct qos_priv *pqospriv = &pmlmepriv->qospriv;
 	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	struct registry_priv *pregistrypriv = &padapter->registrypriv;
-	struct ht_priv 		*phtpriv = &pmlmepriv->htpriv;
+	struct ht_priv *phtpriv = &pmlmepriv->htpriv;
 	enum ndis_802_11_network_infrastructure ndis_network_mode = pnetwork->network.infrastructure_mode;
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
@@ -897,12 +897,11 @@ u8 rtw_setopmode_cmd(struct adapter  *padapter, enum ndis_802_11_network_infrast
 u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_key, bool enqueue)
 {
 	struct cmd_obj *ph2c;
-	struct set_stakey_parm	*psetstakey_para;
-	struct cmd_priv 			*pcmdpriv = &padapter->cmdpriv;
-	struct set_stakey_rsp		*psetstakey_rsp = NULL;
-
-	struct mlme_priv 		*pmlmepriv = &padapter->mlmepriv;
-	struct security_priv 	*psecuritypriv = &padapter->securitypriv;
+	struct set_stakey_parm *psetstakey_para;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+	struct set_stakey_rsp *psetstakey_rsp = NULL;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
+	struct security_priv *psecuritypriv = &padapter->securitypriv;
 	u8 res = _SUCCESS;
 
 	psetstakey_para = rtw_zmalloc(sizeof(struct set_stakey_parm));
@@ -957,9 +956,9 @@ u8 rtw_setstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 unicast_
 u8 rtw_clearstakey_cmd(struct adapter *padapter, struct sta_info *sta, u8 enqueue)
 {
 	struct cmd_obj *ph2c;
-	struct set_stakey_parm	*psetstakey_para;
-	struct cmd_priv 			*pcmdpriv = &padapter->cmdpriv;
-	struct set_stakey_rsp		*psetstakey_rsp = NULL;
+	struct set_stakey_parm *psetstakey_para;
+	struct cmd_priv *pcmdpriv = &padapter->cmdpriv;
+	struct set_stakey_rsp *psetstakey_rsp = NULL;
 	s16 cam_id = 0;
 	u8 res = _SUCCESS;
 
@@ -1228,8 +1227,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 	u16 BusyThreshold = BusyThresholdHigh;
 	u8 bBusyTraffic = false, bTxBusyTraffic = false, bRxBusyTraffic = false;
 	u8 bHigherBusyTraffic = false, bHigherBusyRxTraffic = false, bHigherBusyTxTraffic = false;
-
-	struct mlme_priv 	*pmlmepriv = &padapter->mlmepriv;
+	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 
 	collect_traffic_statistics(padapter);
 
-- 
2.17.1

