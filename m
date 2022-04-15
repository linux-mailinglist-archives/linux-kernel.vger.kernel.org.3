Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ACC5020BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348940AbiDOCvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348989AbiDOCvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:51:17 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A603CB645F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:50 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id x20so5734110qvl.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5Mc5RpUXea4SRPDeY1qeGl0bCped7ZnWWdOYH5iSbns=;
        b=h+6MCgqU+1gY93wXDbjOD3yeEt4oSm86gR8dYLMSQ5ontZUs7pHreKh6u8S9E7+8M9
         rzG0d7uPGLmq0zgra31/y9DxTKn62SJryyXirRt3Q7dK9jOH0yvBCspl0TBcSVJNfmlr
         MuIr3C0hjDCSAkJfpoqwHM4RMAOSUGmW1cJxCyNavW8QdOP5khWN1zvH0PLgKDau7UGA
         z+nE60WMXRi2i8bHZextSl/Er27QHvLgmzISa14d9mhgbZ0llHrD6VduLHaMr4hqThWx
         bsbGP98jLUCCfQf9DDIgM+lpDcfax6T+Buz7M2T53ylKiRt2O1SUFpmyuj7nDCgN4GQy
         3law==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Mc5RpUXea4SRPDeY1qeGl0bCped7ZnWWdOYH5iSbns=;
        b=iGNGNLruqiAHLW39U/ZB46QK+AeiuepMDZj/36/KI+O1xwa8B0EDW/WbapOm06aN51
         UoBDr00fgc55eDNpzGeOemQOhkB5cxj1kA4w5Si9O/NHx8oWKOH45c77xnCXDTEueycr
         bey5MKRTNOYTrLOSGAneNeNqKXO8r+kGsZLuvkJ7oKLFWvQ2jxzzvTFrCKf982AvUkha
         PtYb4XmiwIjNyo672H+O1cPk+UP+GGlu9oK62BL/mOcqY/Lp1iX4bYWdqXVnMcQktcwF
         JaaUGkb/SsXVrxAxISPt6mJmfg3BvDkSG7qPVVKxEBSeqh7pmxJcyx6q5k7wsiuW69qI
         oj2g==
X-Gm-Message-State: AOAM532WQ06ZBhAHuWoO94P3tl96Sl/K4Ef1Md5t8hwJXHqLGUUPqmK0
        uXzU/+JKE7T+YrGwWd6gxsY=
X-Google-Smtp-Source: ABdhPJxWU4j21dPv9kXNTFNN4dy5rZpviBfSXSQmwgLz0JoRPXD0oZQB6WvoXjkL+dmsgsJ2EgK+Cw==
X-Received: by 2002:a05:6214:f01:b0:443:a990:4ea4 with SMTP id gw1-20020a0562140f0100b00443a9904ea4mr6125752qvb.42.1649990929819;
        Thu, 14 Apr 2022 19:48:49 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:1b7a:2349:50b1:5db4:a2d5:7054])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a22a700b0069c37e2c473sm1800085qkh.94.2022.04.14.19.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 19:48:49 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v2 4/6] staging: r8188eu: place constants on the right side of tests
Date:   Thu, 14 Apr 2022 22:48:35 -0400
Message-Id: <baa4d5259e2eb48da1dd71e1863b62a086312a7e.1649990500.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649990500.git.jhpark1013@gmail.com>
References: <cover.1649990500.git.jhpark1013@gmail.com>
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
index bb9d595a90b9..d57f2ffa069e 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -715,7 +715,7 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			set_fwstate(pmlmepriv, _FW_UNDER_LINKING);
 			pmlmepriv->to_join = false;
 			s_ret = rtw_select_and_join_from_scanned_queue(pmlmepriv);
-			if (_SUCCESS == s_ret) {
+			if (s_ret == _SUCCESS) {
 			     _set_timer(&pmlmepriv->assoc_timer, MAX_JOIN_TIMEOUT);
 			} else if (s_ret == 2) { /* there is no need to wait for join */
 				_clr_fwstate_(pmlmepriv, _FW_UNDER_LINKING);
@@ -723,7 +723,8 @@ void rtw_surveydone_event_callback(struct adapter	*adapter, u8 *pbuf)
 			} else {
 				if (rtw_to_roaming(adapter) != 0) {
 					if (--pmlmepriv->to_roaming == 0 ||
-					    _SUCCESS != rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid, 1, NULL, 0)) {
+					    rtw_sitesurvey_cmd(adapter, &pmlmepriv->assoc_ssid,
+							       1, NULL, 0) != _SUCCESS) {
 						rtw_set_roaming(adapter, 0);
 						rtw_free_assoc_resources(adapter, 1);
 						rtw_indicate_disconnect(adapter);
@@ -1964,7 +1965,7 @@ void rtw_issue_addbareq_cmd(struct adapter *padapter, struct xmit_frame *pxmitfr
 		issued = (phtpriv->agg_enable_bitmap >> priority) & 0x1;
 		issued |= (phtpriv->candidate_tid_bitmap >> priority) & 0x1;
 
-		if (0 == issued) {
+		if (issued == 0) {
 			psta->htpriv.candidate_tid_bitmap |= BIT((u8)priority);
 			rtw_addbareq_cmd(padapter, (u8)priority, pattrib->ra);
 		}
@@ -1991,19 +1992,19 @@ void _rtw_roaming(struct adapter *padapter, struct wlan_network *tgt_network)
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

