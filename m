Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8424F210F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbiDEDSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 23:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiDEDSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 23:18:40 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5E62A728
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 20:16:34 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id d65so9355856qke.5
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 20:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XjUcUC0xOAdui6NRMH4KwBLjOAvQDzyoui4/sjnCQaM=;
        b=N53uVDUY8COgraNQHjrQJHOUIcgtsCa4P8pedtYOeZX5/d9GNy0+4iXkWAqM+skfJq
         dGcTCjiQoTyemeVHYzuQNB3BskQhN3MBpvvxbTj1R2nJwj/+5Hmv3Ffxev/gDUbVdnI0
         Q7wWbYoH1T/PzyZQV2D8vtkMiODDh5/WbzwAmMnuSmSyznRlgB0BrKzt9zON7BEp/uMB
         UIrCY5f8SF6BDfqzagSQqENsZpSQ4Ts+359QCroNSqWs50MHgHJmGNusr1QyGvGBjQny
         pSkYtYzQexlIITr8iL+6BY2mjeUtIIhSNVpRqEpQtaCVxuzotZkl+D+kuJrTxfwld8xM
         m0Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XjUcUC0xOAdui6NRMH4KwBLjOAvQDzyoui4/sjnCQaM=;
        b=SbrWrZjYtB3paDnNcZllmj0ykUgQIUECExq6i9MjAUMaQprWkbMscXsxtMMXWTsokV
         ey3jZzuEB6mMcFGniTHn/KVr/l7c2T9IR1JoR+DPuBdNfEqeoHg2p+xkPgF3sHpCLBHw
         TDsX/al0nlatovyqCyxGoCLybBq7WWgc2h8Qp5TaBZduiqh+lTqu0XvWK2tg7wnpnBhz
         /j/yKeUTgMgFtsBmXXDKxrMl0CIXcqxH9HA64GCAhgDFoVniX45VxJveMC8TttXYQ2mD
         RAA+DGSHZlbd9pF1cZV0J4z7al1kkJleby5wwJg1NWW0mXfz2JszTPIgE+k8F8lPN5mG
         r1ng==
X-Gm-Message-State: AOAM533wU4Iyjnu3EcZ5vmtT+YnMFGyvXZ8AJ2ap3T6LViIcZAKp0gta
        dVVsWxbQrr3Rpo1VTVcv9vZO3OdMdAcZXA==
X-Google-Smtp-Source: ABdhPJy/WJY97qySPgIVZQbadBmodc+zwK5xhPaDAjPx0aAMvNNW6fiV2ST1WjRh1VY9kDJxJzyAAA==
X-Received: by 2002:a05:620a:4508:b0:67d:c137:68df with SMTP id t8-20020a05620a450800b0067dc13768dfmr942184qkp.337.1649128593636;
        Mon, 04 Apr 2022 20:16:33 -0700 (PDT)
Received: from euclid ([71.58.109.160])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85756000000b002e1cabad999sm10352280qtx.89.2022.04.04.20.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 20:16:33 -0700 (PDT)
From:   Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev,
        Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
Subject: [PATCH 4/5] staging: rtl8723bs: fix indentation
Date:   Mon,  4 Apr 2022 23:16:11 -0400
Message-Id: <3bb9687a1057619334d95832f803c9b8d7e7fa63.1649128267.git.sevinj.aghayeva@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1649128267.git.sevinj.aghayeva@gmail.com>
References: <cover.1649128267.git.sevinj.aghayeva@gmail.com>
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

WARNING: suspect code indent for conditional statements

Signed-off-by: Sevinj Aghayeva <sevinj.aghayeva@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index c06be65b45cf..5eddff488f27 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5145,9 +5145,9 @@ void link_timer_hdl(struct timer_list *t)
 		if (++pmlmeinfo->reauth_count > REAUTH_LIMIT) {
 			/* if (pmlmeinfo->auth_algo != dot11AuthAlgrthm_Auto) */
 			/*  */
-				pmlmeinfo->state = 0;
-				report_join_res(padapter, -1);
-				return;
+			pmlmeinfo->state = 0;
+			report_join_res(padapter, -1);
+			return;
 			/*  */
 			/* else */
 			/*  */
@@ -5455,7 +5455,7 @@ u8 disconnect_hdl(struct adapter *padapter, unsigned char *pbuf)
 	u8 val8;
 
 	if (is_client_associated_to_ap(padapter))
-			issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
+		issue_deauth_ex(padapter, pnetwork->mac_address, WLAN_REASON_DEAUTH_LEAVING, param->deauth_timeout_ms/100, 100);
 
 	if (((pmlmeinfo->state&0x03) == WIFI_FW_ADHOC_STATE) || ((pmlmeinfo->state&0x03) == WIFI_FW_AP_STATE)) {
 		/* Stop BCN */
-- 
2.25.1

