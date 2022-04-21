Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F21450A910
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiDUTXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391876AbiDUTXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:23:37 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211F74D252
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:42 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id y129so4318343qkb.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 12:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZneH4LjchLUspCBR6Lavef7yu8zFb5eswSR3q4Bedk=;
        b=VezwsUuuDcpjP96JaMyId6lbKh94k5PRoJc+VgRn6QMBC9LAJHOZyisA3pizrmw01f
         T5ph+dtxqVd05uSYw2FZmC51z9oYoOHt7shNjYlmux5X8Hceji+Z6GLtMM8y+9M2Uf3i
         j1n6U6ovQiub2n1Cc+GBkOpnyi//Rs75yS5AcnfFJfQNKsrp/macF8Li/BeYDRZrMukd
         RaIyCU9ExBnDm5TP3ZT+RSu9TlPZNKxqzGRM+2KSWIJNmt6hh9N60CczwMTl3Al6PUgB
         7k5i+LMpPNieFV2FKWSEcvU/p/bI5Ric1vJDvoKeVfqIFP3Vp2qD+zmf4jdYQ1YOhruT
         mLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZneH4LjchLUspCBR6Lavef7yu8zFb5eswSR3q4Bedk=;
        b=WZ7gEcNrxsWqif8yNnSAvUdWL1Q5o5PVJfbbTeIdQDFHhii9np8NWrtYiE3/QGMlS1
         53Jnwmf1nOPlJwDNziIV1rP+3sEGsdX14G5x4zEVq73zPD8l4K2HT2F5wXOxzQUNjSbK
         l4a/5gx359LTG6laOiwdJt0X32ibKqPNEBbkeZQoxBMOk/8dKrRcrfgnHvHYyfiOlMlr
         QeCJc6Byl6AeAx6F05XcoijUXudUUNLQaiKSveG0PeuAi5M6UoNxHWo5s2yNb6Jlq9WN
         SQ5/knIXNK5Zxssgih8IYte3s8GSfcpQLnDoy3KwQRd3XSC6lZUkzP6+re1lzL93pDJA
         CKQw==
X-Gm-Message-State: AOAM532wwQe83uqQI6N3sb+AnfdBHee2cUI/hP/LbgILJ/RNr40CUQE+
        mNvaU/BJCLdlBjEBoM81j30=
X-Google-Smtp-Source: ABdhPJxGiRkrAoMbgBK8oGXrrEHyDpC98OxpXgGcmOOiQdDF6gJnxnFvNjVu92/aWttU1VqG1wUOwA==
X-Received: by 2002:a05:620a:29d1:b0:69e:d2e2:b3ce with SMTP id s17-20020a05620a29d100b0069ed2e2b3cemr636184qkp.686.1650568841218;
        Thu, 21 Apr 2022 12:20:41 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id l9-20020a05622a174900b002f34421b01csm2567736qtk.23.2022.04.21.12.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 12:20:40 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v4 2/7] staging: r8188eu: remove spaces before tabs
Date:   Thu, 21 Apr 2022 15:20:27 -0400
Message-Id: <1b1e8cda03ca5d3fdf26c511da76258f7a2ab8d5.1650568579.git.jhpark1013@gmail.com>
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

Delete spaces before tabs in the comments. Issue found with checkpatch.
WARNING: please, no space before tabs

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d3f4d7cdfa08..2cfd8e8d74a4 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -573,8 +573,8 @@ static void rtw_add_network(struct adapter *adapter,
 
 /* select the desired network based on the capability of the (i)bss. */
 /*  check items:	(1) security */
-/* 			(2) network_type */
-/* 			(3) WMM */
+/*			(2) network_type */
+/*			(3) WMM */
 /*			(4) HT */
 /*			(5) others */
 static bool rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork)
@@ -909,9 +909,9 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			memset((u8 *)&psta->dot11txpn, 0, sizeof(union pn48));
 			memset((u8 *)&psta->dot11rxpn, 0, sizeof(union pn48));
 		}
-		/* 	Commented by Albert 2012/07/21 */
-		/* 	When doing the WPS, the wps_ie_len won't equal to 0 */
-		/* 	And the Wi-Fi driver shouldn't allow the data packet to be tramsmitted. */
+		/*	Commented by Albert 2012/07/21 */
+		/*	When doing the WPS, the wps_ie_len won't equal to 0 */
+		/*	And the Wi-Fi driver shouldn't allow the data packet to be tramsmitted. */
 		if (padapter->securitypriv.wps_ie_len != 0) {
 			psta->ieee8021x_blocked = true;
 			padapter->securitypriv.wps_ie_len = 0;
@@ -1634,8 +1634,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
 /*  */
 /*  Search by BSSID, */
 /*  Return Value: */
-/* 		-1		:if there is no pre-auth key in the  table */
-/* 		>= 0		:if there is pre-auth key, and   return the entry id */
+/*		-1		:if there is no pre-auth key in the  table */
+/*		>= 0		:if there is pre-auth key, and   return the entry id */
 /*  */
 /*  */
 
-- 
2.25.1

