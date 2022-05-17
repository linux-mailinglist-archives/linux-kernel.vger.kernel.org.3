Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7299D52A444
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 16:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348441AbiEQOGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 10:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348329AbiEQOGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 10:06:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3B627FFD
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:06:40 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id h186so14392640pgc.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 07:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvUgUjmvE7sy7yIPoGJaEuswuZK60S9OzDycOOYXOCw=;
        b=LdPgp9viGlgUoy+Z2wq8QytcD4XRoYj1OTfGDEdNPB2AkOFpjOVE5KjgnQUFn/tQeV
         gnsYTY4ORDpAmWJf/2cxZAyz+o5eP1TR78crD6oi+oaNmaQEfDK8HGzToaIGHxutC5gd
         e+4iGkYyqGasM/GUH2ZNqugg/RL57wjcVFPfnopdK1Tw9sg1E3J+BeuKJL4MSajoNQNS
         8heGUqM7PTZ3R1HGBc6RAMCQrNmemvItVLdgkjApwNo6T3HXcL/Fiv8Y78wKLnZZ5M8A
         CImuTuRUMEJQ5YeHDHXsXVQgp6V/+mp/SwRxQzkmnKjHqWP9x6dXCJ2P7X6nQA3O6Fhn
         103g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvUgUjmvE7sy7yIPoGJaEuswuZK60S9OzDycOOYXOCw=;
        b=1A2o2AxpFlX7m5dseD8U1hL/5foA6StU+zguesE5M+kItOCwsITkvXeM4ggHsS4xSW
         KHx9cHVAtJvKjQRxUPZTsXxgRMbJ+nODEbh+Xm+7wPO71ljZvGdMaaTSxEObj0j1Nhz2
         M1PNlDgJswk3+sTVyZl9JnGctxOY6BK3AqzqT/0rOE5h58bBZKMYPi/sMVbXqWBeKdrr
         H7iYbk8zwrJevZrn2jE82KqyMIUDOXTQB3wWFubjNrvjT9IQchXQADgKoIprR6Wu++1L
         +2VMXAMtOhAjR/csZuyczvJSy9ITUWsrLvYSkUS6aPr9Cd3w4DbrO9Iz/BuFNdB5IAFM
         AAlg==
X-Gm-Message-State: AOAM5308eKtKxcjWY2E6WR33mDkrZanSekaP1gglXAJcUJP5JAvO6rFq
        fJefy1IJhrP/LqhipQguQvs=
X-Google-Smtp-Source: ABdhPJwWX8ZDtaSXGxc5BTr7f/mCM9/dBnBR2fUupGrZ+WO9omjidQc6rPELYuVINkcwPmhTzPk+lA==
X-Received: by 2002:a65:428c:0:b0:3db:822e:2163 with SMTP id j12-20020a65428c000000b003db822e2163mr19232498pgp.466.1652796400301;
        Tue, 17 May 2022 07:06:40 -0700 (PDT)
Received: from makvihas.localhost.com ([2405:201:202b:1:3174:ae5c:a49e:4e77])
        by smtp.gmail.com with ESMTPSA id z34-20020a631922000000b003f27f91135asm3113289pgl.76.2022.05.17.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 07:06:39 -0700 (PDT)
From:   Vihas Makwana <makvihas@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        Vihas Makwana <makvihas@gmail.com>
Subject: [PATCH v2 1/3] staging: r8188eu: fix warnings in rtw_p2p
Date:   Tue, 17 May 2022 19:36:24 +0530
Message-Id: <20220517140626.3716-2-makvihas@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220517140626.3716-1-makvihas@gmail.com>
References: <20220517140626.3716-1-makvihas@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the code to fix following warning:
    WARNING: Comparisons should place the constant on the right side of the test

Signed-off-by: Vihas Makwana <makvihas@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_p2p.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_p2p.c b/drivers/staging/r8188eu/core/rtw_p2p.c
index 59bb1bd12..c3884c49b 100644
--- a/drivers/staging/r8188eu/core/rtw_p2p.c
+++ b/drivers/staging/r8188eu/core/rtw_p2p.c
@@ -872,7 +872,7 @@ u32 process_assoc_req_p2p_ie(struct wifidirect_info *pwdinfo, u8 *pframe, uint l
 				}
 
 				psta->dev_name_len = 0;
-				if (WPS_ATTR_DEVICE_NAME == be16_to_cpu(*(__be16 *)pattr_content)) {
+				if (be16_to_cpu(*(__be16 *)pattr_content) == WPS_ATTR_DEVICE_NAME) {
 					dev_name_len = be16_to_cpu(*(__be16 *)(pattr_content + 2));
 
 					psta->dev_name_len = (sizeof(psta->dev_name) < dev_name_len) ? sizeof(psta->dev_name) : dev_name_len;
@@ -1213,7 +1213,7 @@ u8 process_p2p_group_negotation_resp(struct wifidirect_info *pwdinfo, u8 *pframe
 				if (attr_content == P2P_STATUS_SUCCESS) {
 					/*	Do nothing. */
 				} else {
-					if (P2P_STATUS_FAIL_INFO_UNAVAILABLE == attr_content) {
+					if (attr_content == P2P_STATUS_FAIL_INFO_UNAVAILABLE) {
 						rtw_p2p_set_state(pwdinfo, P2P_STATE_RX_INFOR_NOREADY);
 					} else {
 						rtw_p2p_set_state(pwdinfo, P2P_STATE_GONEGO_FAIL);
@@ -1891,7 +1891,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 
 	if (role == P2P_ROLE_DEVICE || role == P2P_ROLE_CLIENT || role == P2P_ROLE_GO) {
 		/* leave IPS/Autosuspend */
-		if (_FAIL == rtw_pwr_wakeup(padapter)) {
+		if (rtw_pwr_wakeup(padapter) == _FAIL) {
 			ret = _FAIL;
 			goto exit;
 		}
@@ -1905,7 +1905,7 @@ int rtw_p2p_enable(struct adapter *padapter, enum P2P_ROLE role)
 		init_wifidirect_info(padapter, role);
 
 	} else if (role == P2P_ROLE_DISABLE) {
-		if (_FAIL == rtw_pwr_wakeup(padapter)) {
+		if (rtw_pwr_wakeup(padapter) == _FAIL) {
 			ret = _FAIL;
 			goto exit;
 		}
-- 
2.30.2

