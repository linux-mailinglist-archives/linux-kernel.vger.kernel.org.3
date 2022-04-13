Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75014FFFCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 22:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbiDMUOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 16:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237193AbiDMUOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 16:14:07 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC9A7CB24
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:11:45 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id c1so2325748qkf.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZneH4LjchLUspCBR6Lavef7yu8zFb5eswSR3q4Bedk=;
        b=kKCkE1mTU+DdqnCj8NCQAqkogQ028mQ2y6QjWGNcQr+hrftJSy+u3+nzCJ96AwSM4r
         oz96E17JiW+6xRft7KWEPXYIXgSI3M2+Zd1m39eXd0OoMk+awKUvRfjMe+u58DEReZb3
         nXiKIewoKfdO217K5vJ3TnVUsXa1Zs4AAYzDJMp7OM4t8wB74i/Io/Gpw+maRs8wxuXz
         cqTNeTYXEq9CB99afzfBBNKUQQTq1ssFY/Lorgn45Ad0Qst4E+bs0vUOm4ukni9WXVk8
         V9g5fXIwL2JNWAnnoXSIxF+vFl2vKeBov44HfZ7GAGB456+rllUtmPNZTUfQ+qu8JWoi
         ZFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZneH4LjchLUspCBR6Lavef7yu8zFb5eswSR3q4Bedk=;
        b=fEl6/JacYKOX/eTok28nXIHX4whHov3lFaqtwJOlPHq39UsU/rSoWA5x9tAgyXd7EY
         GxdPX+XCsOBBJL8GkXvZFsGqqeQrh2VrJ0EEPoplXZVy90PS7XN8Nswvc1oJxZdYx/5Z
         OroZspqBkDTemSh4p0BVArCXYMnZ6v614dEc2hv3YGJCm9DugCGAz7n0E0w2aZ44yL/a
         AqN+tQIynhnvC76q3Nu+NHDMKD57YdgeU4eVP139QJibpHzoPuJr9u6f6BfwjHm54dRy
         L6tMSQtaipKZFJAc9s1/GuKqTwlFm8SvM2arlGPTCqKaWVCarsKAgfSsKC0HG4INhbk/
         b0UA==
X-Gm-Message-State: AOAM5306b7qhCUsCn/5WzhibuXlVDlvRcOQqLP9epdjVk2SqbRabMLD7
        umsdtZrah+gs42hjBubm0+A=
X-Google-Smtp-Source: ABdhPJy9A6fW1l4McT2TwRVX5CNaNpmRadFkLVNz0G3g8v7kVVnnqa4vb8jKg7THdaJd4RxkGE8h/g==
X-Received: by 2002:a05:620a:4154:b0:69c:6976:1ee4 with SMTP id k20-20020a05620a415400b0069c69761ee4mr551891qko.463.1649880704808;
        Wed, 13 Apr 2022 13:11:44 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id 7-20020a370907000000b0069c5598584esm1469827qkj.105.2022.04.13.13.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:11:44 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH 2/6] staging: r8188eu: remove spaces before tabs
Date:   Wed, 13 Apr 2022 16:11:30 -0400
Message-Id: <9bad09e5de45ce0c369e9eb26c98d0662219e6e3.1649880454.git.jhpark1013@gmail.com>
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

