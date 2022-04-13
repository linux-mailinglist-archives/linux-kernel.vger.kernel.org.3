Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4AF4FFFD1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbiDMUOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiDMUOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:14:12 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03AF7EB2A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:11:50 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id b17so2444511qvf.12
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NMYq8qcFTxh0xZzr+s+ajhPy8SCulftSg3sqVf1Tdxo=;
        b=oYhBgOSuosl6tL48jTUohiHOpUf+YjueYnMYdwuKylf3p7YWpj1FOXPT2pIUio/kik
         sYD8+KyL+GtLbTg2+kmbODB2pglVR+1LR1koJ/BEl6ntVqI3SEuSHDVkeqMwS5eolv6E
         J6jCQUKYhkfju81I83DDmPIEFvcI+xDve2lSMat6lyYmw0IFWUcyLJEBjIwAPji95MAW
         3s9Su3v/mSWoqn9gVwQnVZlyVvcMd03WhS6BYHfuh1WbN9s15MYG5+WfNV2oyvI6ARVt
         hTm5WDUPPtvH+6EUbq1eXWr/O+55a8JxCwwf2vsh1yOtSkKhum8QnYWpzd3F8lc9slLt
         GxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NMYq8qcFTxh0xZzr+s+ajhPy8SCulftSg3sqVf1Tdxo=;
        b=rVF1FUuLR4F/eK9AC5ZGkIaq0j3HgcdUrD7aN2JTeXmqN9W2t5U8QXoEy4q5Qqm62h
         wRv6eiitDXGpzDdGuartcD47aM1jDI0gpUCRoZ3NO8+5XCoibVWo5swkWXpXYsTV+YqK
         hJmEkrjQA6m2MJWt/gqdalEhftrxTn7moGN+q9lfrBXBq/nZf/C9wAT4iXRbarRwNExx
         RXUDZ0pWEOZ7xUhq5n4eYwg4UrF0AcdYSAQWtDW8DSWWFLBpfIY12N8W+c4AXvd4n0Gl
         dRdP/V46fpInp1qaMkv+h4yBr/6Sd3mtSW2HSjo0zhMg4wZKekvdoyAoLuJpxbtOK1Fi
         2N0g==
X-Gm-Message-State: AOAM532t1Gx7l0gSpQrlTfkX44gFibLqM+3aUtX2oRfAbRR/uVfv7uvf
        l0hwcAW8HY5dmLOQeMtZH60=
X-Google-Smtp-Source: ABdhPJy0EsEhPQ/ILFgSmyz6uo6YpNecGOiFrkVwEzNx23WvjkMRvqdLlxdZsF0Cts/4ng4i7j133A==
X-Received: by 2002:a05:6214:18c4:b0:444:39f6:b328 with SMTP id cy4-20020a05621418c400b0044439f6b328mr10001532qvb.51.1649880709390;
        Wed, 13 Apr 2022 13:11:49 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id 7-20020a370907000000b0069c5598584esm1469827qkj.105.2022.04.13.13.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:11:48 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH 6/6] staging: r8188eu: correct typo in comments
Date:   Wed, 13 Apr 2022 16:11:34 -0400
Message-Id: <f4c3e6a2ed65597544c18fe34f6bd3f4676072c5.1649880454.git.jhpark1013@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649880454.git.jhpark1013@gmail.com>
References: <cover.1649880454.git.jhpark1013@gmail.com>
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

Correct misspellings in the comments. Issue found with checkpatch.

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 7a90fe826d1d..d422ce87ba7c 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -192,7 +192,7 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 /*
 	return the wlan_network with the matching addr
 
-	Shall be calle under atomic context... to avoid possible racing condition...
+	Shall be called under atomic context... to avoid possible racing condition...
 */
 struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
@@ -328,7 +328,7 @@ void rtw_free_network_queue(struct adapter *dev, u8 isfreeall)
 /*
 	return the wlan_network with the matching addr
 
-	Shall be calle under atomic context... to avoid possible racing condition...
+	Shall be called under atomic context... to avoid possible racing condition...
 */
 struct	wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
@@ -911,7 +911,7 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			memset((u8 *)&psta->dot11rxpn, 0, sizeof(union pn48));
 		}
 		/*	When doing the WPS, the wps_ie_len won't equal to 0 */
-		/*	And the Wi-Fi driver shouldn't allow the data packet to be tramsmitted. */
+		/*	And the Wi-Fi driver shouldn't allow the data packet to be transmitted. */
 		if (padapter->securitypriv.wps_ie_len != 0) {
 			psta->ieee8021x_blocked = true;
 			padapter->securitypriv.wps_ie_len = 0;
@@ -1305,7 +1305,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 }
 
 /*
-* _rtw_join_timeout_handler - Timeout/faliure handler for CMD JoinBss
+* _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
 * @adapter: pointer to struct adapter structure
 */
 void _rtw_join_timeout_handler (struct adapter *adapter)
@@ -1340,7 +1340,7 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 }
 
 /*
-* rtw_scan_timeout_handler - Timeout/Faliure handler for CMD SiteSurvey
+* rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
 * @adapter: pointer to struct adapter structure
 */
 void rtw_scan_timeout_handler (struct adapter *adapter)
-- 
2.25.1

