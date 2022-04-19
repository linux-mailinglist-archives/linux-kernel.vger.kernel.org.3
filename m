Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9320350793D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 20:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357168AbiDSSan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 14:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357351AbiDSS2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 14:28:02 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02075D70
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:48 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id bb21so3984422qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 11:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TsS6c/RnnW8N28Uqgbk6xNjG2rAtG4yyJqhZPCFyu68=;
        b=a0X4omet7ubwepI7Sjq1GKWazDAR1sokGbqsF2O9SYrR/5aybF/+dqcutAJ4hSLFDY
         bQ5EY2/ufswhxA8QIWGeRgngEYDAJuXeMOk2K09O7GN5G9sfoceLBhIac6OEnUv0xIbR
         jSqTQ8mdx2ehVp7LMxd9ir62r9npohwyda3GsBbiEjQ0icSm/UMTTMNLCDRos5YrCUWn
         9HcgWTPZ5l9e2dEAtLcB7fygjCtb5NVtnk+u44cwVTXiEqmB982JAZ0FxwPU4zuUMvFc
         nBBFMf8yrpBe/9pApKfrmZcMuKY0rPQ8TGDEL95ptt7rP2Mk7ZP0Hk/gtNveCte/P6C3
         a7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TsS6c/RnnW8N28Uqgbk6xNjG2rAtG4yyJqhZPCFyu68=;
        b=clryae5BZawXCxmLXaz/zRrGCxccPEht8epMKqaBbgPviW1yRMOiFLR0MSJgXl3jb7
         La7Z1iysJLfJNj14bSoG5bCNPp+H+KqBHAn6Xz80R6sUOxmNWLiIzymROZyxgYkvDaVi
         5U2qez0cSiW6tzP3hBAoYBGR5sO32AKrGzu4ZNOZU5db0fBpwyoLDYLrnANAZKpVnH10
         W8Re+p6hP6FYF1dm+a8gQ6TO+ygmeHVfJeMLLXuFEchgBzZ7M5nlbfm0zghbFEuqIDJU
         eZlyFtyjBeo38NoQcoxpuApK4p5jc8PmZ7Crvqc+2EcQ9JV70hCcSAOeQZ6GPbRHhoO9
         68aA==
X-Gm-Message-State: AOAM532bjtEmSFasIay8wOSKCepOcmU7ZT46lrF+WECscWTUPwicx468
        PyENXtqJEXC+giKdY2u0iTQ=
X-Google-Smtp-Source: ABdhPJxrlyYuX/eLyo4aukz0bVgPyF+C57SnMVxkrDap85pqIY+pyePm5XZh0i/1LddBILjTx5eyLw==
X-Received: by 2002:a05:622a:1792:b0:2f3:3a82:b15e with SMTP id s18-20020a05622a179200b002f33a82b15emr2286518qtk.246.1650392387084;
        Tue, 19 Apr 2022 11:19:47 -0700 (PDT)
Received: from jaehee-ThinkPad-X1-Extreme.wework.com ([4.34.18.218])
        by smtp.gmail.com with ESMTPSA id e126-20020a376984000000b0069c86b28524sm373334qkc.19.2022.04.19.11.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 11:19:45 -0700 (PDT)
From:   Jaehee Park <jhpark1013@gmail.com>
To:     Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev, jhpark1013@gmail.com,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v3 1/7] staging: r8188eu: remove unused member free_bss_buf
Date:   Tue, 19 Apr 2022 14:19:32 -0400
Message-Id: <3c5a510938ac395a13bb09c0de1868cce8ca3dd8.1650392020.git.jhpark1013@gmail.com>
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

The free_bss_buf member of pmlmepriv is unused. Remove all related
lines.

Suggested-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Jaehee Park <jhpark1013@gmail.com>
---
 drivers/staging/r8188eu/include/rtw_mlme.h |  1 -
 drivers/staging/r8188eu/core/rtw_mlme.c    | 21 +--------------------
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_mlme.h b/drivers/staging/r8188eu/include/rtw_mlme.h
index 1dc1fbf049af..0f03ac43079c 100644
--- a/drivers/staging/r8188eu/include/rtw_mlme.h
+++ b/drivers/staging/r8188eu/include/rtw_mlme.h
@@ -319,7 +319,6 @@ struct mlme_priv {
 	struct list_head *pscanned;
 	struct __queue free_bss_pool;
 	struct __queue scanned_queue;
-	u8 *free_bss_buf;
 	u8	key_mask; /* use to restore wep key after hal_init */
 	u32	num_of_scanned;
 
diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 3e9882f89f76..8af11626a3e7 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -33,8 +33,7 @@ u8 rtw_to_roaming(struct adapter *adapter)
 static int _rtw_init_mlme_priv(struct adapter *padapter)
 {
 	int	i;
-	u8	*pbuf;
-	struct wlan_network	*pnetwork;
+	struct wlan_network	*pnetwork = NULL;
 	struct mlme_priv		*pmlmepriv = &padapter->mlmepriv;
 	int	res = _SUCCESS;
 
@@ -55,16 +54,6 @@ static int _rtw_init_mlme_priv(struct adapter *padapter)
 
 	memset(&pmlmepriv->assoc_ssid, 0, sizeof(struct ndis_802_11_ssid));
 
-	pbuf = vzalloc(MAX_BSS_CNT * (sizeof(struct wlan_network)));
-
-	if (!pbuf) {
-		res = _FAIL;
-		goto exit;
-	}
-	pmlmepriv->free_bss_buf = pbuf;
-
-	pnetwork = (struct wlan_network *)pbuf;
-
 	for (i = 0; i < MAX_BSS_CNT; i++) {
 		INIT_LIST_HEAD(&pnetwork->list);
 
@@ -79,8 +68,6 @@ static int _rtw_init_mlme_priv(struct adapter *padapter)
 
 	rtw_init_mlme_timer(padapter);
 
-exit:
-
 	return res;
 }
 
@@ -109,13 +96,7 @@ void rtw_free_mlme_priv_ie_data(struct mlme_priv *pmlmepriv)
 
 void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 {
-
 	rtw_free_mlme_priv_ie_data(pmlmepriv);
-
-	if (pmlmepriv) {
-		vfree(pmlmepriv->free_bss_buf);
-	}
-
 }
 
 struct	wlan_network *_rtw_alloc_network(struct	mlme_priv *pmlmepriv)/* _queue *free_queue) */
-- 
2.25.1

