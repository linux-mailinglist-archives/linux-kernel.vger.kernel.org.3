Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D301F48824F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 09:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbiAHI1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 03:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiAHI1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 03:27:45 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECD3C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 00:27:44 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id s1so15658734wra.6
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 00:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2VTMSOScwZ5T0eJZE+RIoj2iFIAziaiqOLrqg1J6kPo=;
        b=VDyagUQnQ9G/ePVpOaXdBthLWofpAvyn6zKq4pXXZENzFU+MYPdthLPbFDeRcz1ZU3
         dnDqxjEdWmNl7elZxYk2YnqSz5oX/IbczUmBe8hs0pVEFMHGzU+jU7/mdCSGLsrVKbvu
         Y1EcJTL/Qgdl3CK0ciwIa+r4QI/FVCkHmA96XlIddNEWW8U+ShS14k8OFvW1JuxLGjru
         3sm82mPZmaJI/GF/vnrvfyOLP7dnvAIZOWHKMbqJSuNdV+6f9n2gDGYK6m9yJoip3lMx
         tIs+saQ+nq45UYenNPg4XzYpa9S1pkYZL/0UdP5UA5TPT+O2Iqaj2ut0+w/qSg+F4FKr
         prqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2VTMSOScwZ5T0eJZE+RIoj2iFIAziaiqOLrqg1J6kPo=;
        b=V56pYXsoPdliSZnkUT7sigNuOF2WLgHgyCx5bIV6K9GAGwEPgtIu3JCP0cQlKWn8DO
         zB5sGLSCaDqFygAv70CztUintyuE8j3r0XQm933a9slZRvuusRb68IS/nwpgXy0jKsxV
         rvh1hEAgIixfKj8SLdkjD6SwgdCl7tA8ADTauz+teoB6RSiqmb3AAJ1ylK+O6R4g2+Mu
         GoT9ikBf/sQtVxzwdcIkKJ1FiLL9+JjSnwJ1CUHsswFS2uXPJbBmeyKVS93tpZ3Zm1U0
         puRQJY5aRVIQp9kFfOHYBfYWu6er604hNs100V7QafWxsJJxXQ2+FmyA+jzK1TmVxm3U
         EWgA==
X-Gm-Message-State: AOAM531srMwQcAe7vmWlYrZK3+2bWQDOV1peWF8AgBWYxRcHkNeoeNiU
        qh3KGCnLRd+KIOJl9IgExAzPZwWLLIc=
X-Google-Smtp-Source: ABdhPJwXet+ZeTuvwBc2WsufI6r47xn7p8ytBi3ECBDVsmEpsrr1ECpygzI7SLAmmr962hf/Y1D8+A==
X-Received: by 2002:a05:6000:12d0:: with SMTP id l16mr55460959wrx.466.1641630463421;
        Sat, 08 Jan 2022 00:27:43 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::51e2])
        by smtp.gmail.com with ESMTPSA id az1sm964536wrb.104.2022.01.08.00.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 00:27:43 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/5] staging: r8188eu: rtw_hostapd_mlme_rx() is empty
Date:   Sat,  8 Jan 2022 09:27:32 +0100
Message-Id: <20220108082736.16788-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220108082736.16788-1-straube.linux@gmail.com>
References: <20220108082736.16788-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function rtw_hostapd_mlme_rx() is empty. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c  | 2 --
 drivers/staging/r8188eu/include/recv_osdep.h | 1 -
 drivers/staging/r8188eu/os_dep/recv_linux.c  | 5 -----
 3 files changed, 8 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index a9141ab1690e..cdd928c37a3e 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -459,8 +459,6 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 		break;
 	default:
 		_mgt_dispatcher(padapter, ptable, precv_frame);
-		if (check_fwstate(pmlmepriv, WIFI_AP_STATE))
-			rtw_hostapd_mlme_rx(padapter, precv_frame);
 		break;
 	}
 }
diff --git a/drivers/staging/r8188eu/include/recv_osdep.h b/drivers/staging/r8188eu/include/recv_osdep.h
index e87467022b39..4b5e3dde4590 100644
--- a/drivers/staging/r8188eu/include/recv_osdep.h
+++ b/drivers/staging/r8188eu/include/recv_osdep.h
@@ -14,7 +14,6 @@ s32  rtw_recv_entry(struct recv_frame *precv_frame);
 int rtw_recv_indicatepkt(struct adapter *adapter, struct recv_frame *recv_frame);
 void rtw_recv_returnpacket(struct  net_device *cnxt, struct sk_buff *retpkt);
 
-void rtw_hostapd_mlme_rx(struct adapter *padapter, struct recv_frame *recv_fr);
 void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup);
 
 int rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter);
diff --git a/drivers/staging/r8188eu/os_dep/recv_linux.c b/drivers/staging/r8188eu/os_dep/recv_linux.c
index 5a7fb94e21c1..41c4e35d967f 100644
--- a/drivers/staging/r8188eu/os_dep/recv_linux.c
+++ b/drivers/staging/r8188eu/os_dep/recv_linux.c
@@ -100,11 +100,6 @@ void rtw_handle_tkip_mic_err(struct adapter *padapter, u8 bgroup)
 			    &wrqu, (char *)&ev);
 }
 
-void rtw_hostapd_mlme_rx(struct adapter *padapter,
-			 struct recv_frame *precv_frame)
-{
-}
-
 int rtw_recv_indicatepkt(struct adapter *padapter,
 			 struct recv_frame *precv_frame)
 {
-- 
2.34.1

