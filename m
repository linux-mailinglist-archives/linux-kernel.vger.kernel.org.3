Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF93B4BD6EF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 08:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346265AbiBUHeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 02:34:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346258AbiBUHdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 02:33:54 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31E913E82
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:33:18 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id d10so30787746eje.10
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 23:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O6E3mVixruLxdZHjJ1wxRBvkKpRcoOQJ1soEUthx7X8=;
        b=gUQMEEqFDEmmcDfzQK4o4ZPd3s+UQuFOc+Zi9aGoY4O9z4ClQqvVxUQKAp84YpPBNy
         BM+t/PtQ76A2WSBqY3SoOh1ZsaLIfjOqC4TexkXAyjPiJLcyBIp2NsIgEOrV5u4t91MG
         NXffr3x/r3eBumnMs8Cefeo2RwA/35zjl1ikjnym6ZxGZAgr+lMf5J618Rms6eUX9GFM
         3BwDy6Q8AfjVRmv7EiYNcU/CApBEF+Q+G/hCSe1Y0/WsKwIISG9q0bHIwLiZxoPgvElB
         4VLmCzRidd1PO53gsCfXp/E4ikpWLwS9b8zQ9X+uz5HsJwqrcGkcf4SAAiztXlI8TuiS
         J4LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O6E3mVixruLxdZHjJ1wxRBvkKpRcoOQJ1soEUthx7X8=;
        b=QCtP8e04r3zb7lGkYusD4L6rq/XysWGyVngn7O9EiqqDh0BQJBj17CJhFG+XHNvKmM
         z2q/nWsc59OAMXLWmyrSmxNpD3SmEokPQa1qwCsTjQKCdbqpt5XvnMJtLyGoLzFX/BE7
         eXSt9NohSX+Gj+On+MXCZ0oxd8zjqtC6fNbfZOMQ5e+XmYJbB7YxrQkmKzZT9Vl0xmE8
         +E2ls+rzRv6Rm6TxsBI/Q4MLWIrYf5N5XvDZskk8J03xiGaluVjE6OKcpSMzzXgYVylN
         wZ08vNLgSXhtiliS1Bbil0m5eC2x3sWOhNcLhwRbwgPgOAe3Ja/7UYrG/rbUbhUNkch1
         u4/Q==
X-Gm-Message-State: AOAM5301gEp4n0WYXMVczLpMl/sshzpCm6P7OvRis1DzlRwbyD8Rj/6p
        z7aF/+iKw5NNqjBOyzHD+DY=
X-Google-Smtp-Source: ABdhPJxTNUhzfwuSfieA7KUNxbkpK3lwDok77gr9+EbSnDej9/2n495FaAXct4sPOB+LaEklpGVrKw==
X-Received: by 2002:a17:906:407:b0:6cd:472b:2d5f with SMTP id d7-20020a170906040700b006cd472b2d5fmr14530079eja.573.1645428797278;
        Sun, 20 Feb 2022 23:33:17 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id c11sm8673128edx.42.2022.02.20.23.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 23:33:17 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 3/5] staging: r8188eu: remove enum odm_bw
Date:   Mon, 21 Feb 2022 08:33:04 +0100
Message-Id: <20220221073306.16636-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221073306.16636-1-straube.linux@gmail.com>
References: <20220221073306.16636-1-straube.linux@gmail.com>
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

The enums odm_bw and ht_channel_width are redundant. Keep
ht_channel_width and remove odm_bw.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2:
no changes

 drivers/staging/r8188eu/hal/odm.c     | 4 ++--
 drivers/staging/r8188eu/include/odm.h | 6 ------
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 6f594ae33c6e..5d2f934d78ae 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -266,7 +266,7 @@ static void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
 	u8 i;
 	struct sta_info *pEntry;
 
-	if (*pDM_Odm->pBandWidth == ODM_BW40M) {
+	if (*pDM_Odm->pBandWidth == HT_CHANNEL_WIDTH_40) {
 		if (*pDM_Odm->pSecChOffset == 1)
 			pDM_Odm->ControlChannel = *pDM_Odm->pChannel - 2;
 		else if (*pDM_Odm->pSecChOffset == 2)
@@ -766,7 +766,7 @@ u32 ODM_Get_Rate_Bitmap(struct odm_dm_struct *pDM_Odm, u32 macid, u32 ra_mask, u
 		} else if (rssi_level == DM_RATR_STA_MIDDLE) {
 			rate_bitmap = 0x000ff000;
 		} else {
-			if (*pDM_Odm->pBandWidth == ODM_BW40M)
+			if (*pDM_Odm->pBandWidth == HT_CHANNEL_WIDTH_40)
 				rate_bitmap = 0x000ff015;
 			else
 				rate_bitmap = 0x000ff005;
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index 0e85bd88ab8a..fed12203c558 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -166,12 +166,6 @@ enum odm_wireless_mode {
 	ODM_WM_AUTO	= BIT(5),
 };
 
-/*  ODM_CMNINFO_BW */
-enum odm_bw {
-	ODM_BW20M		= 0,
-	ODM_BW40M		= 1,
-};
-
 struct odm_ra_info {
 	u8 RateID;
 	u32 RateMask;
-- 
2.35.1

