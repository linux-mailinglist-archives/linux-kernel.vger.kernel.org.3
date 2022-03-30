Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D004EC848
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 17:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348196AbiC3PdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 11:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348242AbiC3Pcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 11:32:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042A627CE06
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:31:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j18so29815491wrd.6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gJz7fYhfJWqCmC2Mcr5bDAKKPMhr/W9ez4DMr6xey+k=;
        b=ceMznRGpwFxnxcArdnMPvl5HfRy3xwhignwESlXi8csYWIHvoOJgFAo5Zgd/QYaJV7
         MgyMMgu7jf1EjzdpvqwE/VKjXqFQEwIjy5oy0T8WiPOG33kxtDrxRmkyVw21mQvd1q8e
         SNb6F9/3Ot8HjzH09hMBFZaJ2SDZVPbI/JjgPF+iBHtv4WPJvP2OTSDslvQrO/Pv8Rr3
         3K+k8g933wH7ED+RGvaewwvAzJpOS4/MuFF5np0jd8FPaDWtbn8r067f3TZ9hpGBjgLo
         YG6uGUp1ZzhAdf4W6UYRgZG4ikloQBt6WRXWtkzhzpgyeBJihtgSUOx8ubhs9gPO8ksE
         kC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gJz7fYhfJWqCmC2Mcr5bDAKKPMhr/W9ez4DMr6xey+k=;
        b=A8dRPleXoseTIz0KKaVbKc9TvNBn2VOU3qg8Dz8zdO5RpMCWkEtc1SLeP354nbY/js
         r4erNhfXUZr9k25lzEvgsKMZY8FSqL0Ify5qKfYyov4oza+B1DrQAtthr/ikzVupEdms
         dn/yk5V/pc89s/DHnNh1A83m8upIsaxxbvnvZ2V2W3DrOGa4OiyGYEgVRqL9o07lR17O
         VdCJks/jAk1fy4J9xfnVuxP/AszRxR9bL/Jz/S5fQOjA51TNKqgrq5P5keSLNJCXIc/J
         LI18kfOq16Tfkgz3Bn3G7biNQknoyUcxEsg+ROGwO5GMhfqOyBx5F1zKS6Ra2nZjTE7a
         LMoQ==
X-Gm-Message-State: AOAM533pzoUS7QWu7PRt23d8pONhHsQ3gjiLE81VabYN/3FTgsxEmaFU
        7Rra1unBo8LIJWAIMKjlS85ZX7/yl0g=
X-Google-Smtp-Source: ABdhPJxbORWcrgcXzlxBYwb0i9BcaEP/wUxgwjqJd3r8z/OOO2KndntviGQfobOQHpFnLywO1zI5fQ==
X-Received: by 2002:a5d:64ce:0:b0:204:1177:e1c4 with SMTP id f14-20020a5d64ce000000b002041177e1c4mr134091wri.692.1648654264520;
        Wed, 30 Mar 2022 08:31:04 -0700 (PDT)
Received: from alaa-emad ([41.37.132.115])
        by smtp.gmail.com with ESMTPSA id q16-20020adff950000000b00205aa05fa03sm13450509wrr.58.2022.03.30.08.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 08:31:03 -0700 (PDT)
From:   Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, eng.alaamohamedsoliman.am@gmail.com
Subject: [PATCH] staging:rtl8723bs:rtw_cmd.c remove suspect indent
Date:   Wed, 30 Mar 2022 17:31:00 +0200
Message-Id: <20220330153100.5813-1-eng.alaamohamedsoliman.am@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Fix "WARNING: suspect code indent for conditional
statements (16, 32)" for line 1240
founded by checkpatch.pl

Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 14d37b369273..46e18a90529f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1238,7 +1238,7 @@ u8 traffic_status_watchdog(struct adapter *padapter, u8 from_timer)
 		/*&& !MgntInitAdapterInProgress(pMgntInfo)*/) {
 		/*  if we raise bBusyTraffic in last watchdog, using lower threshold. */
 		if (pmlmepriv->LinkDetectInfo.bBusyTraffic)
-				BusyThreshold = BusyThresholdLow;
+			BusyThreshold = BusyThresholdLow;
 
 		if (pmlmepriv->LinkDetectInfo.NumRxOkInPeriod > BusyThreshold ||
 			pmlmepriv->LinkDetectInfo.NumTxOkInPeriod > BusyThreshold) {
-- 
2.35.1

