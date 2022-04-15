Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 157605020C1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 04:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349000AbiDOCvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 22:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348826AbiDOCvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:51:20 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35933B53C2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:54 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 3so5895419qkj.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 19:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CKsPSzbdQxvHGjzHjwaUIzUGXMHlds2Vm+4c+Y0wyWg=;
        b=krNK/VQ+kVTKoPRnjaavol+6At8xRhgnz9BihNOArwhl5zTUEwXrg6CBipRyQsMU3c
         Oze96XQ8+P7KgwrKHO7MQUUkMSX6LEFHaQ93qfRtN8/vhAxS9p4QwUQ7FIzhOURbD3wf
         WX1JTHuCBh5IJv1v3UB8I1tWpqNJsWLqNpn/kaAH4sRQXLkgS0D7KT2/iagPiWawtCRn
         TUz0XS2hwaujZlBDju61US1NswuEj2TKIG85ZXbgLg1GvwftbcL892kJtr1E7VcZh9Jk
         1gHBC3AE+iyfzIhcCZoblhIpJBHAZbOjP++OVxuefX2AH+/dM4clcE5nJhoaU0XsFiPu
         avww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CKsPSzbdQxvHGjzHjwaUIzUGXMHlds2Vm+4c+Y0wyWg=;
        b=o63Xaac1SW2fVj7mbiDQIvqgKJ+FqxH07GKmghJRyWUmPxzOJqV7ZfEummlP9xvjNM
         txHWBYHg7cRI2nQflWimodtafjAuyvMnUNtcTtcOzVcZa2ynUQWJP0x3aN3hJwYn5n8v
         0Wt3sK+EKwgW0DpUTbXuhb4ExdFpOJ3FzB+4BUXL1NHUxmJC6GKI91SFvVl+67hNVc/Y
         S5blXcdISPF+8M/5swY29sVZ9Vb6mLjzsXBalrtKLF4fcVKuP+8cjizbXSXk639m84ev
         vhaabfNIbK6WW9IQIABdJEVAX8LRBs740o3Jr/mxd06y+GI5k6mL2Wdoi/GadK2xfmbX
         kQtQ==
X-Gm-Message-State: AOAM532Qx5J9+hfggN1LRDV5/giiJi9oNe62gTS1gISlsaR56ldo93LL
        4sAIaBEI+gUIkM2tXqS1u3w=
X-Google-Smtp-Source: ABdhPJxmlagFCkqQolzg6U7aFXJnV+1Lr8Si2ywcY/BsE5JOOXCI5SlzAXt1V03EuIhyQqPEFbzlRg==
X-Received: by 2002:ae9:ef8a:0:b0:69c:1015:3383 with SMTP id d132-20020ae9ef8a000000b0069c10153383mr4222123qkg.492.1649990933357;
        Thu, 14 Apr 2022 19:48:53 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.lan ([2607:fb90:1b7a:2349:50b1:5db4:a2d5:7054])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a22a700b0069c37e2c473sm1800085qkh.94.2022.04.14.19.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 19:48:52 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v2 6/6] staging: r8188eu: correct typo in comments
Date:   Thu, 14 Apr 2022 22:48:37 -0400
Message-Id: <080ec2f68f6558af098918e3b8e69a2d3529cb3f.1649990500.git.jhpark1013@gmail.com>
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

Correct misspellings in the comments. Issue found with checkpatch.

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 38ae8be675c4..58c7d6cc4a3f 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -186,7 +186,7 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 /*
 	return the wlan_network with the matching addr
 
-	Shall be calle under atomic context... to avoid possible racing condition...
+	Shall be called under atomic context... to avoid possible racing condition...
 */
 struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
@@ -322,7 +322,7 @@ void rtw_free_network_queue(struct adapter *dev, u8 isfreeall)
 /*
 	return the wlan_network with the matching addr
 
-	Shall be calle under atomic context... to avoid possible racing condition...
+	Shall be called under atomic context... to avoid possible racing condition...
 */
 struct	wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
@@ -905,7 +905,7 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			memset((u8 *)&psta->dot11rxpn, 0, sizeof(union pn48));
 		}
 		/*	When doing the WPS, the wps_ie_len won't equal to 0 */
-		/*	And the Wi-Fi driver shouldn't allow the data packet to be tramsmitted. */
+		/*	And the Wi-Fi driver shouldn't allow the data packet to be transmitted. */
 		if (padapter->securitypriv.wps_ie_len != 0) {
 			psta->ieee8021x_blocked = true;
 			padapter->securitypriv.wps_ie_len = 0;
@@ -1299,7 +1299,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 }
 
 /*
-* _rtw_join_timeout_handler - Timeout/faliure handler for CMD JoinBss
+* _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
 * @adapter: pointer to struct adapter structure
 */
 void _rtw_join_timeout_handler (struct adapter *adapter)
@@ -1334,7 +1334,7 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 }
 
 /*
-* rtw_scan_timeout_handler - Timeout/Faliure handler for CMD SiteSurvey
+* rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
 * @adapter: pointer to struct adapter structure
 */
 void rtw_scan_timeout_handler (struct adapter *adapter)
-- 
2.25.1

