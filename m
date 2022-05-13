Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD045259D5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376595AbiEMC4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376610AbiEMC42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:56:28 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6404423162
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:56:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id r71so5945060pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=OGgDMvpY/n5VX5vYctev+tzQH6piKUfUzgYoN8lHPK8=;
        b=OUR7fAJxJRCdgVA79xpMHkngYG/aXvMdppYHbPGcaOU99EAuvmPd1kShMCPzLUUVcu
         GiX3Zsu33E//VV1DnOeopUCtD+bc1iG87XLMvc4vF0bmjbLMSBUOXm766o9CZey5UaWy
         wxuioIw1csCRj9SZRD3ItoLE5LscG6tOFMdMyP14Fs/GxeFOaiQWKcVnXTMaBuqyRsL0
         G6DUkVEALRHFSvDpR2YYsGd9jfMtOlTGRL0zMfmFp9hJkfD3P1cKqgZFOqap4lx5jJsT
         ECzwby0l8NXYomdcbDee8Ce9otXjhcccz89br1sNsj8Nb9yVBg5PVn3GNdgStyCODGF2
         C6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OGgDMvpY/n5VX5vYctev+tzQH6piKUfUzgYoN8lHPK8=;
        b=ZNxigZY8Iqk1ABYZaTBgd4f5vBOf+1iTZP40kvUqg7Ao1baW8DWky4IozGztD6qnfx
         WP67BlN8+SpZQWB1xibuiDASiAJLOD2iCZ3K7yAc2Mpmn8Cej3De9BK+vFKU9ao2r4Gf
         CIFdayHFMl/LZ+QiocEgalpLvGO/8uv6uciVo0yZZfr+57mTOU6NW77DrsOoQV5+RQQ4
         wOKwERyezqtbU5s/BrPVPvP3wX2yW4OsQtnv/tM/pMWSGubuBWCVJhXbyTJF+ru3Z7dQ
         7skX8lBLxjtqzmqBOD2EYFnC19+68mtuxOHB0dUwlUbd7E+jFwdZ29cqxx3ut62Y7xmX
         pdvQ==
X-Gm-Message-State: AOAM532KiSeYgtQr46cnohisOEDViEpi+B1ldF8FUT80SbKmmDTZzzQ4
        cz8o67ivvfrJoguVp2lrIThlk0fyUAcu4Q==
X-Google-Smtp-Source: ABdhPJw0m4Ce6/qaZpm58tHclY9RoVfekRzhloooOMpO4pVQGqAEPgLhzdE6QQPpFBtECoNJc9BytQ==
X-Received: by 2002:a63:e108:0:b0:3db:11bb:7345 with SMTP id z8-20020a63e108000000b003db11bb7345mr2153825pgh.502.1652410586489;
        Thu, 12 May 2022 19:56:26 -0700 (PDT)
Received: from Negi ([207.151.52.3])
        by smtp.gmail.com with ESMTPSA id y4-20020a17090ad0c400b001d95cdb62d4sm2449444pjw.33.2022.05.12.19.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 19:56:25 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Fix alignment to match open parenthesis
Date:   Thu, 12 May 2022 19:55:53 -0700
Message-Id: <20220513025553.13634-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux coding style. Fixes checkpatch warnings:
CHECK: Alignment should match open parenthesis
CHECK: line length of 101 exceeds 100 columns

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 5478188be991..d30d6e6bcd07 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -520,12 +520,12 @@ void update_sta_info_apmode(struct adapter *padapter, struct sta_info *psta)
 
 		/*  B0 Config LDPC Coding Capability */
 		if (TEST_FLAG(phtpriv_ap->ldpc_cap, LDPC_HT_ENABLE_TX) &&
-			      GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap)))
+		    GET_HT_CAPABILITY_ELE_LDPC_CAP((u8 *)(&phtpriv_sta->ht_cap)))
 			SET_FLAG(cur_ldpc_cap, (LDPC_HT_ENABLE_TX | LDPC_HT_CAP_TX));
 
 		/*  B7 B8 B9 Config STBC setting */
 		if (TEST_FLAG(phtpriv_ap->stbc_cap, STBC_HT_ENABLE_TX) &&
-			      GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap)))
+		    GET_HT_CAPABILITY_ELE_RX_STBC((u8 *)(&phtpriv_sta->ht_cap)))
 			SET_FLAG(cur_stbc_cap, (STBC_HT_ENABLE_TX | STBC_HT_CAP_TX));
 	} else {
 		phtpriv_sta->ampdu_enable = false;
@@ -1065,10 +1065,12 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 		);
 
 		if ((psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_CCMP) ||
-		     (psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_CCMP)) {
-			pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY & (0x07 << 2));
+		    (psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_CCMP)) {
+			pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY &
+						       (0x07 << 2));
 		} else {
-			pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY & 0x00);
+			pht_cap->ampdu_params_info |= (IEEE80211_HT_CAP_AMPDU_DENSITY &
+						       0x00);
 		}
 
 		rtw_hal_get_def_var(
@@ -1116,7 +1118,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
 	pmlmepriv->htpriv.ht_option = false;
 
 	if ((psecuritypriv->wpa2_pairwise_cipher & WPA_CIPHER_TKIP) ||
-	     (psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_TKIP)) {
+	    (psecuritypriv->wpa_pairwise_cipher & WPA_CIPHER_TKIP)) {
 		/* todo: */
 		/* ht_cap = false; */
 	}
@@ -1725,7 +1727,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 			pmlmepriv->num_sta_no_short_preamble--;
 
 			if ((pmlmeext->cur_wireless_mode > WIRELESS_11B) &&
-				(pmlmepriv->num_sta_no_short_preamble == 0)) {
+			    (pmlmepriv->num_sta_no_short_preamble == 0)) {
 				beacon_updated = true;
 				update_beacon(padapter, 0xFF, NULL, true);
 			}
@@ -1763,7 +1765,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 			pmlmepriv->num_sta_no_short_slot_time++;
 
 			if ((pmlmeext->cur_wireless_mode > WIRELESS_11B) &&
-				 (pmlmepriv->num_sta_no_short_slot_time == 1)) {
+			    (pmlmepriv->num_sta_no_short_slot_time == 1)) {
 				beacon_updated = true;
 				update_beacon(padapter, 0xFF, NULL, true);
 			}
@@ -1775,7 +1777,7 @@ void bss_cap_update_on_sta_join(struct adapter *padapter, struct sta_info *psta)
 			pmlmepriv->num_sta_no_short_slot_time--;
 
 			if ((pmlmeext->cur_wireless_mode > WIRELESS_11B) &&
-				 (pmlmepriv->num_sta_no_short_slot_time == 0)) {
+			    (pmlmepriv->num_sta_no_short_slot_time == 0)) {
 				beacon_updated = true;
 				update_beacon(padapter, 0xFF, NULL, true);
 			}
@@ -2024,7 +2026,7 @@ void rtw_ap_restore_network(struct adapter *padapter)
 	start_bss_network(padapter);
 
 	if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
-		(padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
+	    (padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
 		/* restore group key, WEP keys is restored in ips_leave() */
 		rtw_set_key(
 			padapter,
@@ -2062,7 +2064,7 @@ void rtw_ap_restore_network(struct adapter *padapter)
 			/* pairwise key */
 			/* per sta pairwise key and settings */
 			if ((psecuritypriv->dot11PrivacyAlgrthm == _TKIP_) ||
-				(psecuritypriv->dot11PrivacyAlgrthm == _AES_)) {
+			    (psecuritypriv->dot11PrivacyAlgrthm == _AES_)) {
 				rtw_setstakey_cmd(padapter, psta, true, false);
 			}
 		}
-- 
2.17.1

