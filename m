Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499EF5078F9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357298AbiDSSbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357370AbiDSS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:28:03 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB32636A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:52 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d19so6324657qko.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eTY41j92DVLNXeSt4o0nuA9rJQeUxDOxu+njnckXIDQ=;
        b=LTl9kT3xpYL6VGEy2O5G2D/KacFzBLapBCcpa8SVQcm/vTgM1g2taCae9ti31ZnUnP
         jQ3wMxvJsuD3S5QQDIAo61l28GRuHnj+rQYPOxxH59K9KxAhQ6DOeh+H2v7m9F1WBJrU
         1cE6HGebZfiVlUTpQtUvgzZAhJPIjP70k53nd6Hh8mWk0ZTJJ4P+q1CcETzFGx+5Mxdr
         UM8BMo3myP85dULJVvG7tmEtEPGh42u/6Q6NuWuCAYq5gnXuauYPwWQFBrAf29ZR/ZAd
         nrEodCYgzqC5VptflF042txhrU25aUwKKluUY6nmnjT7yF5ZbL84tiYCyYDPbiaX/7oo
         GVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eTY41j92DVLNXeSt4o0nuA9rJQeUxDOxu+njnckXIDQ=;
        b=C3wRJ1x79wsRg4aU9DAlanoC13UxkZ3R1nrHFF2T/6UrizN+JbCJX1FrPhibjjy6pk
         Hfj+M9EpGZ5XoPwucxBmiJ7V4PBCdkWGpyZ4/9BxWeHWkPrUQ2xoIzcvMSCMw2X7RQz3
         e8WjG9Bp1oSMpiAL/9Vj3uAfs1/haew3GMGTGl3SUqWOSC8GSaSOCXMJ9N3Lf57Ismse
         cdV5aCEKR154NDh0KBG98WDA3OM7cOcMTAlkm8OcLTMoI2bw/o1zyFicsE4anyJigSic
         UdBj8Bu2D5gaI7fh96mZXPxgbFK6kxI1IZ5RwyjMaD2DKLgaaJDfFOhDQ8ATFkkRJDHd
         yYGA==
X-Gm-Message-State: AOAM5323VIZTlmVwXzF/wdsoyM7e+h38nbJcGJFpIsr6MxD/PnQDvMIQ
        BGa9hJtPVuewFDQwJA4tk/s=
X-Google-Smtp-Source: ABdhPJy7FqTgL+ZMMB+LutLXJ2/U/G82goC/xh9N3tuArQF8jIEzE5CndILEgQbLcUQNdwFSzoHjlA==
X-Received: by 2002:a37:8ac1:0:b0:69b:ef34:2655 with SMTP id m184-20020a378ac1000000b0069bef342655mr10460110qkd.336.1650392391091;
        Tue, 19 Apr 2022 11:19:51 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id e126-20020a376984000000b0069c86b28524sm373334qkc.19.2022.04.19.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:19:50 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v3 4/7] staging: r8188eu: place constants on the right side of tests
Date:   Tue, 19 Apr 2022 14:19:35 -0400
Message-Id: <31d2a118c5d797a2df7428aa701afe46cbbc1d19.1650392020.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1650392020.git.jhpark1013@gmail.com>
References: <cover.1650392020.git.jhpark1013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To comply with the linux coding style, place constants on the right
side of the test in comparisons. Issue found with checkpatch.
WARNING: Comparisons should place the constant on the right side of
the test.

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 47f528c14b25..adaf0f813a97 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -703,7 +703,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 			pmlmepriv->to_join = false;
 			s_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
-			if (_SUCCESS == s_ret) {
+			if (s_ret == _SUCCESS) {
 			     _set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 			} else if (s_ret == 2) { /* there is no need to wait for join */
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
@@ -711,7 +711,8 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			} else {
 				if (rtw_to_roaming(adapter) != 0) {
 					if (--pmlmepriv->to_roaming == 0 ||
-					    _SUCCESS != rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0)) {
+					    rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid,
+							       1, NULL, 0) != _SUCCESS) {
 						rtw_set_roaming(adapter, 0);
 						rtw_free_assoc_resources(adapter, 1);
 						rtw_indicate_disconnect(adapter);
@@ -1952,7 +1953,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 		issued = (phtpriv->agg_enable_bitmap >> priority) & 0x1;
 		issued |= (phtpriv->candidate_tid_bitmap >> priority) & 0x1;
 
-		if (0 == issued) {
+		if (issued == 0) {
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
 			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
@@ -1979,19 +1980,19 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
 	else
 		pnetwork = &pmlmepriv->cur_network;
 
-	if (0 < rtw_to_roaming(padapter)) {
+	if (rtw_to_roaming(padapter) > 0) {
 		memcpy(&pmlmepriv->assoc_ssid, &pnetwork->network.Ssid, sizeof(struct ndis_802_11_ssid));
 
 		pmlmepriv->assoc_by_bssid = false;
 
 		while (1) {
 			do_join_r = rtw_do_join(padapter);
-			if (_SUCCESS == do_join_r) {
+			if (do_join_r == _SUCCESS) {
 				break;
 			} else {
 				pmlmepriv->to_roaming--;
 
-				if (0 < pmlmepriv->to_roaming) {
+				if (pmlmepriv->to_roaming > 0) {
 					continue;
 				} else {
 					rtw_indicate_disconnect(padapter);
-- 
2.25.1

