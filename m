Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B210B5020B2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348853AbiDOCvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348994AbiDOCvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:51:17 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB22B368C
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:47 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id a10so5742202qvm.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jl8cA15AhHC5y4h+FeNERnQbKM+f37jdKRIZJGm/yhE=;
        b=L1WFgpZkQlF23uXoOfCCxu1h881F8755tMZldHEjaZbD4Afdt+/aOmDAZyoSWO5Uys
         TkkLFEGSZV4hhWg9ukWsCrTkJr6ImRLDrpI0OU+sqKadGebIDrEfgCXJZfy23Oe1f1ec
         DF6r1vW8cPZQgbSOWLLdRYaypN5fyVcAdEh+w0VeKgr9pMXAvpH0Ks7oIN6B28/4Cpm4
         NkN2qc6QerfhQyiQRe9DDLXm7qlz0vJgvbxhvClsHNy9ZqlGetQMXtyh4BXjnh+MibPA
         7EVnR+sblEXvRNsNbER9r2sg8DOCLcqc8xgVu2Lusua4LqieYqm6sh1FiYTIuIbUUB2c
         QTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jl8cA15AhHC5y4h+FeNERnQbKM+f37jdKRIZJGm/yhE=;
        b=eha+hke6QKmOdfdfukpTGfB3OhPE8zinbAhidNbnm/GK8D2Z3G1j/kPrdhHFKC/fBk
         ds29RixSoB8wsYyAlbZZgcusLf498b5+5MQS/oSK34/83m+B2PoC6512cHqpOm0hrtpI
         ph5QhaHPNzrF+Q+Q+TKB+/v0g7RvMmxtUKHqGmo3cCCpFxYJSCa/Qy2O0xcUgNpzWyEE
         YaF0MvPWkv8xj8oQJWL84/SZ8UD+B2mbdvnCYY/GVwEI6vLEIjaz/A+/1zwGm0pWC1KO
         WjV/XzWkfGaGZFjBd69Z2+RkH2boZRWEvLMd4Pzo9AyOvTaUETS3pkATMgLaHjjobMgl
         0R0A==
X-Gm-Message-State: AOAM531uCqa16TkX/6DJL29BzH9sWnmep1evNzE+c2C5BgDBaI+DGKiS
        z+rigBkY5W7O7bN0/OmDTjcO6/hJ8xfh1oKN
X-Google-Smtp-Source: ABdhPJzlkp+L8XmPEEo671yAb3XgFN78LTs8FO4w3iGvK1FiTeC2Wf7DWE/jJh4wdVsqeqZyg+9bqw==
X-Received: by 2002:a05:6214:622:b0:441:2825:c288 with SMTP id a2-20020a056214062200b004412825c288mr6051916qvx.79.1649990926337;
        Thu, 14 Apr 2022 19:48:46 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:1b7a:2349:50b1:5db4:a2d5:7054])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a22a700b0069c37e2c473sm1800085qkh.94.2022.04.14.19.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 19:48:45 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v2 2/6] staging: r8188eu: remove spaces before tabs
Date:   Thu, 14 Apr 2022 22:48:33 -0400
Message-Id: <16fc136092cb89e6a819afe2de69edb96ca7c68a.1649990500.git.jhpark1013@gmail.com>
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

Delete spaces before tabs in the comments. Issue found with checkpatch.
WARNING: please, no space before tabs

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index aed868d1d47b..1620ca181bf7 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -567,8 +567,8 @@ static void rtw_add_network(struct adapter *adapter,
 
 /* select the desired network based on the capability of the (i)bss. */
 /*  check items:	(1) security */
-/* 			(2) network_type */
-/* 			(3) WMM */
+/*			(2) network_type */
+/*			(3) WMM */
 /*			(4) HT */
 /*			(5) others */
 static bool rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork)
@@ -903,9 +903,9 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
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
@@ -1628,8 +1628,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
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

