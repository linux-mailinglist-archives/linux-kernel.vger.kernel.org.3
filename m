Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1AD4AF6E5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbiBIQh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237285AbiBIQh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:37:56 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC3AC05CB87
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:37:54 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id d15-20020a17090a564f00b001b937f4ae2fso356523pji.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:37:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WbFobfSnE8stzLHhA9k0e0i8hXDiaZu/9/LOjHIwu8E=;
        b=fr4o/+4nviTwLuTChms4MwaGDGiGvK8YOtpl59fKdESATh4gQPPxSzKNUMBZsbvzLQ
         SGcDeoxiZnPvyVkvWy15du/nWpBzJrgJrz+3Rqho40ox6BqeZNnwW8HNEy8v/4QUFOWc
         yh+TmDXO/g8X9QRS9PLTzOgtECiX2Juzee6lna8nmJcP/lMl5bq1RK7Lb97pdEt6wOgO
         Cnd/2yMb6xoa6OP+2aHnrszeIvarrVaha0YIqdP/6BKkm97bFRYI+r+CYexp7Hw+ifmP
         O/gsOUN+Q27/58pvhfferc5oQHdBEJ2Qhteg+RNHabw/LPvJwcxVx08kyVeh+jL5CLEA
         ydGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WbFobfSnE8stzLHhA9k0e0i8hXDiaZu/9/LOjHIwu8E=;
        b=hIGhWnU0FBPswfmaqYyuM4Ld39SpFHJfy6iEAdkrLpD7XeCsJvcwXpamgBKPwoMvbF
         3ZC5LujhOA4nGgXhLK/NrFvyWFTlg6uPezlTbSY3es+STM7heBJ/Y+xxCSFFxjF4BI9P
         cbYElhlumW1OWEI8JQJ5QRF2MxoUoP5hPzQVEw6FFl7dJiaDKm26cOyqnztALrF/LnJB
         lbYF4C/3y9k97GwqHR2bZozyioDCxFMl6pBFd2ZtxfSG1Pt9MNYfg1AF9mJiewZf+tyu
         kxWGSnk3ZD9uGq2pd+Sn3MJGddePt14LAUIwlEIFpTbBpsOpWAcsrJKadnYHu5O1NT6B
         KagQ==
X-Gm-Message-State: AOAM532gQ8QHw74ghD9o2bb9HDoTEEqwd2nThca+KMtvxAyqmx4XNn81
        NcjcZT4uWJ1E2Ha60cHhWsQS/nQmPxs=
X-Google-Smtp-Source: ABdhPJw+2ICMdS/UQR23E9I17lWoNWNMAeZkc3zCcftGaezZs2KNw0AF1PagI372poK1Mv6ZYwqSdw==
X-Received: by 2002:a17:90a:e7c8:: with SMTP id kb8mr3451562pjb.228.1644424674327;
        Wed, 09 Feb 2022 08:37:54 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id kb18sm7840199pjb.30.2022.02.09.08.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:37:53 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 8/9] staging: r8188eu: remove unused argument in chk_ap_is_alive
Date:   Wed,  9 Feb 2022 22:06:06 +0530
Message-Id: <17af206986d64f34e85acdf67b138edb4ccc0312.1644422181.git.abdun.nihaal@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1644422181.git.abdun.nihaal@gmail.com>
References: <cover.1644422181.git.abdun.nihaal@gmail.com>
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

The function argument padapter is not used in chk_ap_is_alive.
Remove it.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 27bfb43f306e..ceca6751cdee 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -7157,7 +7157,7 @@ static void _linked_rx_signal_strength_display(struct adapter *padapter)
 		   "UndecoratedSmoothedPWDB:%d\n", UndecoratedSmoothedPWDB);
 }
 
-static u8 chk_ap_is_alive(struct adapter *padapter, struct sta_info *psta)
+static u8 chk_ap_is_alive(struct sta_info *psta)
 {
 	u8 ret = false;
 
@@ -7221,7 +7221,7 @@ void linked_status_chk(struct adapter *padapter)
 			bool is_p2p_enable = false;
 			is_p2p_enable = !rtw_p2p_chk_state(&padapter->wdinfo, P2P_STATE_NONE);
 
-			if (!chk_ap_is_alive(padapter, psta))
+			if (!chk_ap_is_alive(psta))
 				rx_chk = _FAIL;
 
 			if (pxmitpriv->last_tx_pkts == pxmitpriv->tx_pkts)
-- 
2.34.1

