Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA814BCD94
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 11:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243734AbiBTKDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 05:03:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243716AbiBTKC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 05:02:58 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B8B3B02E
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:02:22 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p9so25647009ejd.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 02:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkI9AnkK9Hx4PE0VopfNSysIyR8hiEwnCg1vfX4w8qo=;
        b=UqLm+85YwRk5e03YO1uqe0i/H9qa5BM5sRFcQacfx7hN7MKcioBW+nf+ckCVknmxG0
         PcRpIDaY2irp9R5pqLcuqTlIR5daTVtabb9O3zs0JuzXbiX7AE/FyAXcsbPuY6x2X6+L
         +CXmPZVhU+51kR3LD6YSwZbxWngdyYe79G4Se/vF93Oeyme8Txr8fvsm5OoCBwNjFfcC
         xzpZo/FtO6Dlflp5kWOz3Qf0WOoh7PCrJ4DlJjSyS7/xjaidlL5/6rM84sJzCosyZQY/
         OMIKk2CDrsdc/oA/9nVgh9LUlJeML6aABSyfjoq3DzBkTc+mSRO7V0+f887r6chLIg1Y
         miuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkI9AnkK9Hx4PE0VopfNSysIyR8hiEwnCg1vfX4w8qo=;
        b=zD0XBIxgqhuURaANOCaYTPioEcbT2NBKlq0Olhr4noc15uQ9kzLObntibpI78WylbN
         X4evtKWChfO7V5lZMoQhnXh99PlOU/P/aRKEWQwbIX1PuJFT2B68J5XwlZA09HjDJRT5
         8rb65q1NkmCZgrw0F6UtLugYcR83Z+ztsP2oQr9q4niE/9Y5KNlh8m3Z3DAd4XTxA/Yz
         A5pyT7mzCneyEGCHmZP+iyuLwD3DZtRKr+fhUOhZwT/eybvUSZTMRvyzDN2KKC2PSPk0
         eCJakl6baweZqyMAVnbMv1kayI/U7TNcHp/bWIgr/dagRHjCnCVpb8FlfvQTv7ORENe8
         Ob1w==
X-Gm-Message-State: AOAM531hB5TtkRrvPL4JFJ4zERNxbQHe/ynRID9BOjoXHDVhcS0mHMGs
        i8E1/m56uU7iUEnQPqwj6gI=
X-Google-Smtp-Source: ABdhPJwTnByq03MA+PvXGyxT/lHmMG/Sx7fAOD0r2B6r+Q/KfcPCPs7eFqmUhBEvkjnFhLaGdewsmA==
X-Received: by 2002:a17:907:c92:b0:6b5:c8ae:7918 with SMTP id gi18-20020a1709070c9200b006b5c8ae7918mr11823612ejc.531.1645351341478;
        Sun, 20 Feb 2022 02:02:21 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8f.dynamic.kabel-deutschland.de. [95.90.187.143])
        by smtp.gmail.com with ESMTPSA id dx7sm3265223ejb.23.2022.02.20.02.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Feb 2022 02:02:21 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/5] staging: r8188eu: remove enum odm_bw
Date:   Sun, 20 Feb 2022 11:02:10 +0100
Message-Id: <20220220100212.7466-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220100212.7466-1-straube.linux@gmail.com>
References: <20220220100212.7466-1-straube.linux@gmail.com>
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

