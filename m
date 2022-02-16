Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AF74B9179
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 20:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238150AbiBPTlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 14:41:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238130AbiBPTlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 14:41:03 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43EB2B0493
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:40:49 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id y17so5710036edd.10
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 11:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbXARzhtH3QOWgRRPGrSYM+TBaIkAjRMKIK2lUHXdUQ=;
        b=aeTblRuGs8dcHA4wMchgTThkGnuq2fTSdlxzklbCIvmLwUpS8ShDhEX4p/EYZAM17D
         eebmW4UELfnrywrhWpQjXPLCdKWDjQ0ixHOAIlLZ74M5E32t4Ox5H4/1FWK30j8JSY+C
         33pr6j3UbrgWDKfShPn/akSE9u0yxoEmVGdLj9QRSIYZCFekUG85m899lHeqrgTd/OGo
         n+DGOhlT452avHjCPGgGU195WSj7OW4kMXN0o3zNT+JTuDhQ/SddXuz7Bk4XxsT3oe58
         nchO5Ofvoqh9tUYYPxSsU3TcaQLAX7FYQbEGG7SeHFap4R71jcaA3001iW0/gvO+T3w7
         b0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbXARzhtH3QOWgRRPGrSYM+TBaIkAjRMKIK2lUHXdUQ=;
        b=H2gupvyXNmBMXpUBZSpcAxmaMckS9XpMGyjxKdDsQM0LG6RXDLqH8yrvh94MBHArxg
         uMFxiYYMsgLsFtIutKgIrlLfo/Cw17Yfb0TjhRVpsezvxm/R1AA1IHqRmp6XWykltnZC
         eWpdyGzxksOq+/baI3QG8z5ga3E6OWrnMqnU1Pz3YZaQazbTH/8Wi74ynQ+CbKlCsgkR
         /nZLkgt1VqbYdAYunj+/nn1qpK5vSXZJ99o+IItHacLDN9toW+GZ78scjkG/ZRfvho/x
         vrnXuXsK2iOyWFXOIc4eybEgiJ+KCUIAC8QsIgIZGLwHJlCZ0IaW06XFpgfrv1/0ZF2Y
         A1yw==
X-Gm-Message-State: AOAM530jnsSD/nqU0rXEST5Npjb5nL//OE9KGi/IMVjOI/LLHok9CXQb
        7nVCpDRfdzXAUkXBK85TRbw=
X-Google-Smtp-Source: ABdhPJyRNIU/fXJS6CqwzSVFThzW41KIIFGEku02f0WfTQmRjhAulbs7ExESaR8z0IzNwYlowEcKow==
X-Received: by 2002:a05:6402:4c6:b0:406:d579:2c4 with SMTP id n6-20020a05640204c600b00406d57902c4mr4769016edw.52.1645040448391;
        Wed, 16 Feb 2022 11:40:48 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8c.dynamic.kabel-deutschland.de. [95.90.187.140])
        by smtp.gmail.com with ESMTPSA id z18sm276910ejl.78.2022.02.16.11.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 11:40:48 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/3] staging: r8188eu: rename CCKSwingTable_Ch1_Ch13
Date:   Wed, 16 Feb 2022 20:40:38 +0100
Message-Id: <20220216194038.6762-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220216194038.6762-1-straube.linux@gmail.com>
References: <20220216194038.6762-1-straube.linux@gmail.com>
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

After removing CCKSwingTable_Ch14 there is only one table left and we
can rename CCKSwingTable_Ch1_Ch13 to simply cck_swing_table.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/HalPhyRf_8188e.c | 2 +-
 drivers/staging/r8188eu/hal/odm.c            | 2 +-
 drivers/staging/r8188eu/include/odm.h        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
index 523d4fedb3cc..b944c8071a3b 100644
--- a/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
+++ b/drivers/staging/r8188eu/hal/HalPhyRf_8188e.c
@@ -149,7 +149,7 @@ odm_TXPowerTrackingCallback_ThermalMeter_8188E(
 		TempCCk = dm_odm->RFCalibrateInfo.RegA24;
 
 		for (i = 0; i < CCK_TABLE_SIZE; i++) {
-			if (memcmp((void *)&TempCCk, (void *)&CCKSwingTable_Ch1_Ch13[i][2], 4)) {
+			if (memcmp((void *)&TempCCk, (void *)&cck_swing_table[i][2], 4)) {
 				CCK_index_old = (u8)i;
 				dm_odm->BbSwingIdxCckBase = (u8)i;
 				break;
diff --git a/drivers/staging/r8188eu/hal/odm.c b/drivers/staging/r8188eu/hal/odm.c
index 24a884bcea3b..e0824eefd83a 100644
--- a/drivers/staging/r8188eu/hal/odm.c
+++ b/drivers/staging/r8188eu/hal/odm.c
@@ -65,7 +65,7 @@ u32 OFDMSwingTable[OFDM_TABLE_SIZE_92D] = {
 	0x0b40002d,/*  42, -15.0dB */
 };
 
-u8 CCKSwingTable_Ch1_Ch13[CCK_TABLE_SIZE][8] = {
+u8 cck_swing_table[CCK_TABLE_SIZE][8] = {
 	{0x36, 0x35, 0x2e, 0x25, 0x1c, 0x12, 0x09, 0x04}, /*  0, +0dB */
 	{0x33, 0x32, 0x2b, 0x23, 0x1a, 0x11, 0x08, 0x04}, /*  1, -0.5dB */
 	{0x30, 0x2f, 0x29, 0x21, 0x19, 0x10, 0x08, 0x03}, /*  2, -1.0dB */
diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
index f17c707f2cde..9fb09e0a0df9 100644
--- a/drivers/staging/r8188eu/include/odm.h
+++ b/drivers/staging/r8188eu/include/odm.h
@@ -447,7 +447,7 @@ enum dm_swas {
 #define	CCK_TABLE_SIZE		33
 
 extern	u32 OFDMSwingTable[OFDM_TABLE_SIZE_92D];
-extern	u8 CCKSwingTable_Ch1_Ch13[CCK_TABLE_SIZE][8];
+extern u8 cck_swing_table[CCK_TABLE_SIZE][8];
 
 /*  check Sta pointer valid or not */
 #define IS_STA_VALID(pSta)		(pSta)
-- 
2.35.1

