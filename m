Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A85F50793C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357261AbiDSSax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357376AbiDSS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:28:03 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EB913F32
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:55 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id d9so13825489qvm.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fhC3X2SyiyAl+npbfkVlNLSTyoSpgwtiZmqJs5lxBc4=;
        b=OPKv+zXzIulJ/bChAz/N/BvFQIw/GcXNMZhcMI98zHKajTluQf7i4EbuvdfwwS2jGY
         /buH9ZVrWciy6p8exI4Uk6zeeDkzxqbd2gpMbUMJMVIZLogmAKVkumWSjBO04KFXhSWp
         0i0+gqMZKsS7E+F657CgSYirCWN32nFnRePZKrEm6eZEkr3MWKRLnZ3YH1Bd/JxSksvm
         mHFl+3PrAKqLXd996WL9Ol/hSDiJfX/BWXJ0VgB/RMh9MBUe18X/1JG6IT5dlSzJAeyZ
         nats29XlJRMqJBfBO+22dPnPArkE3TR09ZPC4WgEgA2tksfuDiNDsRCIz7Iuze/0Jf/M
         I55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fhC3X2SyiyAl+npbfkVlNLSTyoSpgwtiZmqJs5lxBc4=;
        b=zsj6JRVS0ZFAaC/8d3AXO0CMV7H6amcs8exJIPIOymzd01unWQad3bqGAgJ9aDJIDf
         WeTP8ZJt48LhfqO5vXEToTstgWZZwf57r04zmSGCDQJ9KBeA80jm135Kdolaru4Sw3qV
         XUAERdxL3hkhSc+hhxPTBeWTXtGFnkZhdK4REOG8HhhThBZCoKLblfBVSDwEaa9zlH2W
         1V9xmiLhIEqmddtqb0tgiF+NCcnAI4gKXHJ7IlgUlCMzRT0sKcpRIPw+2Ccq5nw6P1tg
         H01ZO5y3p5vkbkkRBeOrFSApTAYMxcQkmfHatVFD5tUYWElB6r0Kaj5bN1zzO06yd9HM
         YxGw==
X-Gm-Message-State: AOAM531xJ96xB3ccYnNSSmd3H0Lv90AAvIEHW9TdvCvf34MgRO+RhZTD
        MizoQ0te9JOUKbgrPn58Qy0=
X-Google-Smtp-Source: ABdhPJwL1/XGUDSeSF2YDZwjDMQcm7h/PtbdT22eCAuEiEDQTwr9gswRBWcSUzRdoEyWVWt7j97EsQ==
X-Received: by 2002:a05:6214:18c4:b0:444:39f6:b328 with SMTP id cy4-20020a05621418c400b0044439f6b328mr12820589qvb.51.1650392394335;
        Tue, 19 Apr 2022 11:19:54 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id e126-20020a376984000000b0069c86b28524sm373334qkc.19.2022.04.19.11.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:19:53 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com
Subject: [PATCH v3 6/7] staging: r8188eu: correct typo in comments
Date:   Tue, 19 Apr 2022 14:19:37 -0400
Message-Id: <fc808136903d360ffa2a785fdc75017ae1735d86.1650392020.git.jhpark1013@gmail.com>
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

Correct misspellings in the comments. Issue found with checkpatch.

Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 173754c127e3..5ada336ac723 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -174,7 +174,7 @@ void _rtw_free_network_nolock(struct	mlme_priv *pmlmepriv, struct wlan_network *
 /*
 	return the wlan_network with the matching addr
 
-	Shall be calle under atomic context... to avoid possible racing condition...
+	Shall be called under atomic context... to avoid possible racing condition...
 */
 struct wlan_network *_rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
@@ -310,7 +310,7 @@ void rtw_free_network_queue(struct adapter *dev, u8 isfreeall)
 /*
 	return the wlan_network with the matching addr
 
-	Shall be calle under atomic context... to avoid possible racing condition...
+	Shall be called under atomic context... to avoid possible racing condition...
 */
 struct	wlan_network *rtw_find_network(struct __queue *scanned_queue, u8 *addr)
 {
@@ -893,7 +893,7 @@ static struct sta_info *rtw_joinbss_update_stainfo(struct adapter *padapter, str
 			memset((u8 *)&psta->dot11rxpn, 0, sizeof(union pn48));
 		}
 		/*	When doing the WPS, the wps_ie_len won't equal to 0 */
-		/*	And the Wi-Fi driver shouldn't allow the data packet to be tramsmitted. */
+		/*	And the Wi-Fi driver shouldn't allow the data packet to be transmitted. */
 		if (padapter->securitypriv.wps_ie_len != 0) {
 			psta->ieee8021x_blocked = true;
 			padapter->securitypriv.wps_ie_len = 0;
@@ -1287,7 +1287,7 @@ void rtw_stadel_event_callback(struct adapter *adapter, u8 *pbuf)
 }
 
 /*
-* _rtw_join_timeout_handler - Timeout/faliure handler for CMD JoinBss
+* _rtw_join_timeout_handler - Timeout/failure handler for CMD JoinBss
 * @adapter: pointer to struct adapter structure
 */
 void _rtw_join_timeout_handler (struct adapter *adapter)
@@ -1322,7 +1322,7 @@ void _rtw_join_timeout_handler (struct adapter *adapter)
 }
 
 /*
-* rtw_scan_timeout_handler - Timeout/Faliure handler for CMD SiteSurvey
+* rtw_scan_timeout_handler - Timeout/Failure handler for CMD SiteSurvey
 * @adapter: pointer to struct adapter structure
 */
 void rtw_scan_timeout_handler (struct adapter *adapter)
-- 
2.25.1

