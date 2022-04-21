Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB38350A90F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391873AbiDUTXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391898AbiDUTXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:23:37 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B00496BC
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:44 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id dw17so4403791qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RsvCyHjEEdexsUzersCRTZshhGaPsOo9bh7mou5OagQ=;
        b=FkgurS7SauexiZ2xz+IYN6sCV8y8IctfMz6zJRR0B1i1HZUczTuqQ6Jal4cqrtpvCX
         GZZdHzXtpZX9SHLCLW7ThoFTfZpFT6jng+3sCIR0Jjuj2/NSY4u4QrehQ1G15w7Jahet
         d3Mi6iTAHXRlx28tDX2tC8O9CO+gNZbr7N6j8F0kQutBSYhM4LclnTWbkgBelEJW+fSY
         RcCbg/7n4TpsTU6h+kET+XYSKialRwMI8xRMF1eQed1KrEjB1eWXOi/iPR1gocRKwF6M
         3IjFWZvSyOty7p04A+dYe0eVbuZsPLdhNa4ASbK1ep6l9YMxMxcQYh3HmX7tNxp14aen
         pO6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RsvCyHjEEdexsUzersCRTZshhGaPsOo9bh7mou5OagQ=;
        b=1zMGnNfm1E6yEHt3zilWaIOlbZEF9Xujsm4vHUMMUOhIiEoCtSU5ATo5Ckdsl+Uije
         x9B74PfMcIo/pBGALqSdu+ncHqmZbV4CEFRsFMYVq1SqzKMkVRWso2J62M4cIxPVSal8
         09RCSxqNQvCwJaDFmE/866p79mYkWPu3Jp95Fpbk26uMZVPRN66ZMHCpwy5JMW35PXWp
         7hL4oBlyFauOlQ6nATmP7r+JTk1bQhwHO28ez4suffRw21rmlOR/nHtcf3amTrohQ7uT
         UvawtAugr2A1hYEJfvjdhrj+a+ZLGoAzr2aQ7uw2lsPCHGz0bDaJwlLIJGcojrsKmoaE
         Qv8w==
X-Gm-Message-State: AOAM530Lau/N/aB75Nd16ZnFqIbykdXnuBxjIMgizsO9PaGOZept9DLc
        yf5ixmRKEHNX6e3tMoS88/8=
X-Google-Smtp-Source: ABdhPJwO0I3s7RxyUKvfBF8cqKZtNGNGlYfjd7FaVUq9letNDxcuYXA6OBmvU6zFcMxeaY8rdrBIiw==
X-Received: by 2002:ad4:5aa3:0:b0:443:9ba7:3f27 with SMTP id u3-20020ad45aa3000000b004439ba73f27mr812991qvg.63.1650568843523;
        Thu, 21 Apr 2022 12:20:43 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id l9-20020a05622a174900b002f34421b01csm2567736qtk.23.2022.04.21.12.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:20:43 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v4 4/7] staging: r8188eu: place constants on the right side of tests
Date:   Thu, 21 Apr 2022 15:20:29 -0400
Message-Id: <2fa0eaadcb7d3772fb1c4f67d4ba9e1620ffeb7a.1650568579.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1650568579.git.jhpark1013@gmail.com>
References: <cover.1650568579.git.jhpark1013@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
index 5adef9b9108d..b943fb190e4c 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -721,7 +721,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 			pmlmepriv->to_join = false;
 			s_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
-			if (_SUCCESS == s_ret) {
+			if (s_ret == _SUCCESS) {
 			     _set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 			} else if (s_ret == 2) { /* there is no need to wait for join */
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
@@ -729,7 +729,8 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			} else {
 				if (rtw_to_roaming(adapter) != 0) {
 					if (--pmlmepriv->to_roaming == 0 ||
-					    _SUCCESS != rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0)) {
+					    rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid,
+							       1, NULL, 0) != _SUCCESS) {
 						rtw_set_roaming(adapter, 0);
 						rtw_free_assoc_resources(adapter, 1);
 						rtw_indicate_disconnect(adapter);
@@ -1970,7 +1971,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 		issued = (phtpriv->agg_enable_bitmap >> priority) & 0x1;
 		issued |= (phtpriv->candidate_tid_bitmap >> priority) & 0x1;
 
-		if (0 == issued) {
+		if (issued == 0) {
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
 			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
@@ -1997,19 +1998,19 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
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

