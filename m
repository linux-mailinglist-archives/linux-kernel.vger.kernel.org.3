Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BCA4EFA48
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351535AbiDATJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351497AbiDATJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:09:05 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB9C28A028
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:07:14 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id hu11so2739357qvb.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7duh5/e6azg6x7M9ZEJraSnYR2xg1p2mo3IgTU2n19I=;
        b=ixCVpPmT/JlXNt6KzufnyJWEqNtOWAo85HK28S7mlmUNz7+i+Xn2ycK3NtwdyV/3Ws
         im+/dNS7arlQR3WljVo4QAnmbBbFbEWexnKya1xQXePJMI6X/aeQkvVEsNqaLv8hOedT
         2pCzBm9lLcNw1XPFNOWd7YHC81/woL+Akco37rWL2xbn/fIsiyemhEveLI5NMLtd1ph0
         HPvF+IuqC9qQAKpJuFTTm+a9KWHRw+YQd1uiasqUktgDSsxeDzJ9tqoBeP9L8gED8HNX
         vm0KcOre3UBqdAWaiY04VWpAcV8o1dqVb1ol/Oxpu08qoU2KVPRpwfZ7f9LsR+p8qho4
         2nHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7duh5/e6azg6x7M9ZEJraSnYR2xg1p2mo3IgTU2n19I=;
        b=aKLkpXPOkiu7Vu9SEG9osqZJr3cdT04lMQ1CqFhjQEuurIcRjmeZcY1/5dJY89nULC
         Dcaac1TllXXzZczsJrj2zDFZrgA+mLXMY4Kx7Gv9xHodn8y55ttyDosweVed0Sknj5e4
         e0lHEWmlcxmK6D5QXPHveMvoYan0YPfzJuWyUe2CXHSmQQD1Zet4sYzH4oU8ygIlDLT4
         ytvV3csDpNgskDW8ThJzSMZFspkiocEehDh15ZNkB/CG2wt5nWk10lepq4AGqw2GGsBG
         FRAci6RqfASuEzY97eDapbiQAABmYSOIqM9rOoLI8lra2ckFDx6gOnL0dxjxoAQOlc3p
         DpBQ==
X-Gm-Message-State: AOAM532wL+unANm20lxtUml/zkaQITL+up4c3uUthdGoYjLu5dRCzNjl
        jTq4g7TyJB3QW/Xmnmauc6Y=
X-Google-Smtp-Source: ABdhPJw2mfHY0gOg+ec3qnwP3hWFN+2tbRKgXUdgtDXbIGg/5BcqyaMV0aj88gpDCQmfER129js3Cg==
X-Received: by 2002:ad4:4874:0:b0:440:f735:2743 with SMTP id u20-20020ad44874000000b00440f7352743mr9362812qvy.0.1648840033574;
        Fri, 01 Apr 2022 12:07:13 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id h22-20020a05620a245600b0067d6dae634csm2070825qkn.9.2022.04.01.12.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 12:07:12 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH 2/2] staging: rtl8723bs: remove redundant else branches
Date:   Fri,  1 Apr 2022 15:06:59 -0400
Message-Id: <eb57817c25a90a98d5f1602f6595cae13b2ae7ef.1648839290.git.sevinj.aghayeva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1648839290.git.sevinj.aghayeva@gmail.com>
References: <cover.1648839290.git.sevinj.aghayeva@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to Linux kernel coding style.

Reported by checkpatch:

WARNING: else is not generally useful after a break or return

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 63 +++++++++----------
 1 file changed, 30 insertions(+), 33 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 81e4b1bf68f6..7a941832ee34 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -907,10 +907,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 			set_link_timer(pmlmeext, REAUTH_TO);
 
 			return _SUCCESS;
-		} else {
-			/*  open system */
-			go2asoc = 1;
 		}
+		/*  open system */
+		go2asoc = 1;
 	} else if (seq == 4) {
 		if (pmlmeinfo->auth_algo == dot11AuthAlgrthm_Shared)
 			go2asoc = 1;
@@ -1467,6 +1466,7 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	struct mlme_ext_info *pmlmeinfo = &(pmlmeext->mlmext_info);
 	u8 *pframe = precv_frame->u.hdr.rx_data;
+	int ignore_received_deauth = 0;
 
 	/* check A3 */
 	if (memcmp(GetAddr3Ptr(pframe), get_my_bssid(&pmlmeinfo->network), ETH_ALEN))
@@ -1502,32 +1502,31 @@ unsigned int OnDeAuth(struct adapter *padapter, union recv_frame *precv_frame)
 
 
 		return _SUCCESS;
-	} else {
-		int	ignore_received_deauth = 0;
-
-		/* 	Commented by Albert 20130604 */
-		/* 	Before sending the auth frame to start the STA/GC mode connection with AP/GO, */
-		/* 	we will send the deauth first. */
-		/* 	However, the Win8.1 with BRCM Wi-Fi will send the deauth with reason code 6 to us after receieving our deauth. */
-		/* 	Added the following code to avoid this case. */
-		if ((pmlmeinfo->state & WIFI_FW_AUTH_STATE) ||
-			(pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
-			if (reason == WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) {
-				ignore_received_deauth = 1;
-			} else if (reason == WLAN_REASON_PREV_AUTH_NOT_VALID) {
-				/*  TODO: 802.11r */
-				ignore_received_deauth = 1;
-			}
+	}
+
+	/* 	Commented by Albert 20130604 */
+	/* 	Before sending the auth frame to start the STA/GC mode connection with AP/GO, */
+	/* 	we will send the deauth first. */
+	/* 	However, the Win8.1 with BRCM Wi-Fi will send the deauth with reason code 6 to us after receieving our deauth. */
+	/* 	Added the following code to avoid this case. */
+	if ((pmlmeinfo->state & WIFI_FW_AUTH_STATE) ||
+		(pmlmeinfo->state & WIFI_FW_ASSOC_STATE)) {
+		if (reason == WLAN_REASON_CLASS2_FRAME_FROM_NONAUTH_STA) {
+			ignore_received_deauth = 1;
+		} else if (reason == WLAN_REASON_PREV_AUTH_NOT_VALID) {
+			/*  TODO: 802.11r */
+			ignore_received_deauth = 1;
 		}
+	}
 
-		netdev_dbg(padapter->pnetdev,
-			   "sta recv deauth reason code(%d) sta:%pM, ignore = %d\n",
-			   reason, GetAddr3Ptr(pframe),
-			   ignore_received_deauth);
+	netdev_dbg(padapter->pnetdev,
+		"sta recv deauth reason code(%d) sta:%pM, ignore = %d\n",
+		reason, GetAddr3Ptr(pframe),
+		ignore_received_deauth);
+
+	if (ignore_received_deauth == 0)
+		receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 
-		if (ignore_received_deauth == 0)
-			receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
-	}
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
 	return _SUCCESS;
 
@@ -1574,16 +1573,14 @@ unsigned int OnDisassoc(struct adapter *padapter, union recv_frame *precv_frame)
 		}
 
 		return _SUCCESS;
-	} else {
-		netdev_dbg(padapter->pnetdev,
-			   "sta recv disassoc reason code(%d) sta:%pM\n",
-			   reason, GetAddr3Ptr(pframe));
-
-		receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 	}
+	netdev_dbg(padapter->pnetdev,
+		"sta recv disassoc reason code(%d) sta:%pM\n",
+		reason, GetAddr3Ptr(pframe));
+
+	receive_disconnect(padapter, GetAddr3Ptr(pframe), reason);
 	pmlmepriv->LinkDetectInfo.bBusyTraffic = false;
 	return _SUCCESS;
-
 }
 
 unsigned int OnAtim(struct adapter *padapter, union recv_frame *precv_frame)
-- 
2.25.1

