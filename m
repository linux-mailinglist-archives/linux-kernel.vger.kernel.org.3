Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFC24AF6DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237242AbiBIQhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237205AbiBIQhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:37:31 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A653FC061355
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:37:34 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id n23so5272267pfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 08:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hs9DY75/VY6KIjzo1a64wWbEFVmS6NW//YA6Jf9CUb4=;
        b=L7NbQPE0syDYGE1ddofCCp1z+t90MeErgcI/4BbheKn89HzKUitNQ5QSSSJO4DHe51
         piFRwUAm4OH3rcmCpE8Zg665LX1GuxSqbhEQVp5vKXC+ijsK4nSHWLCI/71xSUzWT6p1
         DBUzn7sBfmaZLL75vKUt4p5gXd9+ixDfLBSs1Id88GVQKCMMioMxr8eQQrSZuwJNywcg
         K7mUfTaHL2tSXLDNoTpsTjSTxMW7B7yZYeONmjWKnW3oZDNDFN+hcW4zxrebck/O5Hqb
         CmaXPo0vt9mXGaQaCdTthcmg8GcT56QqWfP/fTf5StZ31TDQ9C8y2iNxz6oSOweFM6Fs
         pGjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hs9DY75/VY6KIjzo1a64wWbEFVmS6NW//YA6Jf9CUb4=;
        b=uwAiR379D1bDAot0c/I5zmP1e3FX8XmJR8WyS9tnunYK0QhrV2hNMbknQ3YsvQUhXl
         qv/WcQSVSyFuN76ID4DSMkM357eJh09R8Pzic6Ro1gE8sf1LNIisXOKMbxfJEIKpr433
         k4pYMQ7PvRkcwihOa2/dFEDdrcz/PMx65eTTUGxUueLHKydymTRtHlk/Uh/SSlv/7WsS
         UGa04vsFuwDmjLNIEOzVxRpqkbXgScnJYwmY3kMFlyEYLAfyYor2mJ+A9rWOMg/+mwCv
         rHMAbPf6wSdBx5COkUBzp3+wVqJ/cyhu3o+4/dyfdlVN4okGzlQEjc+pswTXX5cuBiBu
         DcDg==
X-Gm-Message-State: AOAM533JZAVvf6KmV28ezy1BG8WCXPqjjQoKqUBFpHNEZIMYnDR+3d7j
        ZoaNbCZbI75y20DtptCNziQ=
X-Google-Smtp-Source: ABdhPJxbcKappCAHTfHoKEJ/GFWu323ixU8DxvXUynUmEGcR/PzlHcfMhmJ6pzCtPMf088I7eMxfSQ==
X-Received: by 2002:a05:6a00:1382:: with SMTP id t2mr3211098pfg.31.1644424654196;
        Wed, 09 Feb 2022 08:37:34 -0800 (PST)
Received: from localhost.localdomain ([122.164.186.156])
        by smtp.googlemail.com with ESMTPSA id kb18sm7840199pjb.30.2022.02.09.08.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 08:37:33 -0800 (PST)
From:   Abdun Nihaal <abdun.nihaal@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: [PATCH 3/9] staging: r8188eu: remove empty function rtw_mfree_mlme_priv_lock
Date:   Wed,  9 Feb 2022 22:06:01 +0530
Message-Id: <8b6d750b049f875370996258aedaf89cf0f198d4.1644422181.git.abdun.nihaal@gmail.com>
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

The definition of function rtw_mfree_mlme_priv_lock is empty. Remove it.

Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mlme.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index e1e358c94ea4..0abad3c78f82 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -85,10 +85,6 @@ int _rtw_init_mlme_priv(struct adapter *padapter)
 	return res;
 }
 
-static void rtw_mfree_mlme_priv_lock(struct mlme_priv *pmlmepriv)
-{
-}
-
 static void rtw_free_mlme_ie_data(u8 **ppie, u32 *plen)
 {
 	kfree(*ppie);
@@ -118,8 +114,6 @@ void _rtw_free_mlme_priv(struct mlme_priv *pmlmepriv)
 	rtw_free_mlme_priv_ie_data(pmlmepriv);
 
 	if (pmlmepriv) {
-		rtw_mfree_mlme_priv_lock(pmlmepriv);
-
 		vfree(pmlmepriv->free_bss_buf);
 	}
 
-- 
2.34.1

