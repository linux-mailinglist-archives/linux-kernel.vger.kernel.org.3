Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C74E507913
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357320AbiDSSb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357355AbiDSS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:28:02 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6380F2A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:49 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id f22so3695914qtp.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XSg9NHRu+GinF4s8/icuB36rUFEij5QIkSvezyRfTkQ=;
        b=kyt7keqdox5sCDgMehjinLNgkpUGGZ8Db0wu4OjgV5ZdSGNuAwqfsgFqJlHysFdfi+
         HLT23tQu7IZYDF/kPQDUNW9vNa5o9/LQkvwusOavQdf7zG/4wmmrJJQtN0wZ6eSPl7HN
         AaRt/09ZvYj09MVEZOTK4D/Zh8HsMz74RH1OYwC1LlsMyQdKYLFIY7Ynxjk83FX3MjwF
         RjHqcm9UKv2/n5b/+ZweuOE+d+nnocJub6eXLhPXyfTlMI/Ldo0LY4N/CCpiRfYvUW9S
         cHO2j7JkUbax8D1Ux9i1GdfzK9laHU/STcGCt8fJbHv8OC+qP/7C11QuhYnPcptcyC9Y
         aVdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XSg9NHRu+GinF4s8/icuB36rUFEij5QIkSvezyRfTkQ=;
        b=qEJbK+u3582iiBZlULTz2RMMk5Ntx8XyiEjSkk7rZrHOgmRbcfj9hMAgCMK+bXEu63
         DM0/xpFHrbWOupxmfI6hgfJ0g6SIlrs+cEH0mxDbXN4/CxoW0q1rpvgHDg8mVKk7d9F5
         89S9ZbQviQ7vV+PV10slS4fvZGdJzkXnyj9pu/IbL3kHYnBkZkA4XiSq8E7L71mMzgEB
         9A+iP91qJ+hFKmZjXjjYRsdYjX/0caeGV1Aup3+HlWILfgOjlTMPcjnFvqpqgXG6yDAN
         uyb5Xpdzkl5OuH/ly+U/twTO+vmiPB+I1MEjZZBuMlKc1Nq9fUuq67b3h/DrhLN/lk4C
         QTLw==
X-Gm-Message-State: AOAM532NoXggZiyHLbiov9w6XuUt1E2f22DpVjYkPzE4XhRcvEup69wo
        e7SoPJuNs9uw6h0DIQ/jXHrohHh5tpc1Anz8
X-Google-Smtp-Source: ABdhPJznnjG2Alx/CXED04SbSCzRXNOHcagsZnIEhYgl2TeoeWGFAejCFvsjZiVGqKG38ckdNL3QNA==
X-Received: by 2002:ac8:5f8d:0:b0:2f3:3f9a:d5bb with SMTP id j13-20020ac85f8d000000b002f33f9ad5bbmr62282qta.314.1650392388318;
        Tue, 19 Apr 2022 11:19:48 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id e126-20020a376984000000b0069c86b28524sm373334qkc.19.2022.04.19.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:19:47 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v3 2/7] staging: r8188eu: remove spaces before tabs
Date:   Tue, 19 Apr 2022 14:19:33 -0400
Message-Id: <5e16b9df1b5ce3a754a8f71c35cf4d55777e19cf.1650392020.git.jhpark1013@gmail.com>
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

Delete spaces before tabs in the comments. Issue found with checkpatch.
WARNING: please, no space before tabs

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 8af11626a3e7..72963ed7b665 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -555,8 +555,8 @@ static void rtw_add_network(struct adapter *adapter,
 
 /* select the desired network based on the capability of the (i)bss. */
 /*  check items:	(1) security */
-/* 			(2) network_type */
-/* 			(3) WMM */
+/*			(2) network_type */
+/*			(3) WMM */
 /*			(4) HT */
 /*			(5) others */
 static bool rtw_is_desired_network(struct adapter *adapter, struct wlan_network *pnetwork)
@@ -891,9 +891,9 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
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
@@ -1616,8 +1616,8 @@ int rtw_restruct_wmm_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, uint in_
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

