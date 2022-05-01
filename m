Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FEA51654F
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349568AbiEAQkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349450AbiEAQkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:40:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E414B2FFD5
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 09:37:08 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id a21so14282191edb.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 09:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WZNze3B5Hambsa3tXM3ix5/LF3I4sB2tqfJXOa0YC20=;
        b=edjRiVazeRMftD/R1Vo1Pa/EQ2v0S/ji7qos+WtkwDtbChDphN5TE1bhIzylL4jIQC
         zcitQkSpUuur9FDznbsW4SRcL2ePCQSudmes+NuC+4+qGe62MMD2SMbjvfE+m7uale0G
         TJETJ0SVc9I6JSW4RgRce47aczto4mtJcV6ihx0a/p1GCLmXCYpiOLYC7diOg3Y4x8eX
         2F1pBRdG2uBzzMEqs186+yUdtUx6C9rklo+VdSw26+c4Oz3L+akmi5ZWaw4qHsAEshSP
         DcDN3mBQFabjKlmX8E1k2TovejfCyZv4BnL/n5lSgpLKTIXyT8gAMvLrWeZws2H5YYJs
         kxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WZNze3B5Hambsa3tXM3ix5/LF3I4sB2tqfJXOa0YC20=;
        b=bd96IE6vQWFEzeCyHrjxTX+n9PAyPwi3rTZosw03ZrTLOcLSNjhvduljRMuV2I9C+n
         a7e9CISCJzfnpNZO9e3nafQ6ZxvVzBvAv00PxOdHw68lJ3BNMDK6ma6VYmETQPA7rqS7
         mJndF96/ODMb01xfg8Y1Zq4Irg5n56UNBWHtvCe/wj2XBvIwc8vfKoQKbBBtv7I4N2zi
         uYgJ13+YgRfsqLFLIMRtIf5DVFSJGyr3pfGY2FccOAyXTTK86MkBvPGK3EAOMBQHl14j
         tZohuFGG7WnMfIfAKliMYeIMuVnV2EK/6un4MaQL/sdNtM6m4dNFpEVzg+Y6KIjHs0C3
         eUmQ==
X-Gm-Message-State: AOAM532TGGXmN4leDBFzLDV4/sDt9T5U/TskSofea3hf/LR5HlGbisEn
        3XpFPshXR6Ldc/PINf2Coos=
X-Google-Smtp-Source: ABdhPJx19/wxA7wf0mvr1SSDq2Uj8zwDUiUyY70mmT2KpG3BV15XBbWkOHdeLImV9YQVYWZpZjn/nA==
X-Received: by 2002:a05:6402:51d0:b0:426:110e:5d05 with SMTP id r16-20020a05640251d000b00426110e5d05mr9800204edd.384.1651423027505;
        Sun, 01 May 2022 09:37:07 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id e26-20020a170906845a00b006f3ef214e6csm2706059ejy.210.2022.05.01.09.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 09:37:07 -0700 (PDT)
Date:   Sun, 1 May 2022 18:37:05 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: vt6655: Rename function CARDbGetCurrentTSF
Message-ID: <1f38006d7eb18426a2336b7666d385021bf81faf.1651422181.git.philipp.g.hortmann@gmail.com>
References: <cover.1651422181.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651422181.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name of the function uses CamelCase which
is not accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/card.c        | 10 +++++-----
 drivers/staging/vt6655/card.h        |  2 +-
 drivers/staging/vt6655/device_main.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index ec6fd185d3fd..d1dfd96e13b7 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -11,7 +11,7 @@
  *      CARDbAddBasicRate - Add to BasicRateSet
  *      CARDbIsOFDMinBasicRate - Check if any OFDM rate is in BasicRateSet
  *      CARDqGetTSFOffset - Calculate TSFOffset
- *      CARDbGetCurrentTSF - Read Current NIC TSF counter
+ *      card_get_current_tsf - Read Current NIC TSF counter
  *      CARDqGetNextTBTT - Calculate Next Beacon TSF counter
  *      CARDvSetFirstNextTBTT - Set NIC Beacon time
  *      CARDvUpdateNextTBTT - Sync. NIC Beacon time
@@ -288,7 +288,7 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
 	u64 local_tsf;
 	u64 qwTSFOffset = 0;
 
-	CARDbGetCurrentTSF(priv, &local_tsf);
+	card_get_current_tsf(priv, &local_tsf);
 
 	if (qwBSSTimestamp != local_tsf) {
 		qwTSFOffset = CARDqGetTSFOffset(byRxRate, qwBSSTimestamp,
@@ -322,7 +322,7 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 {
 	u64 qwNextTBTT = 0;
 
-	CARDbGetCurrentTSF(priv, &qwNextTBTT); /* Get Local TSF counter */
+	card_get_current_tsf(priv, &qwNextTBTT); /* Get Local TSF counter */
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 
@@ -739,7 +739,7 @@ u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2)
  *
  * Return Value: true if success; otherwise false
  */
-bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
+bool card_get_current_tsf(struct vnt_private *priv, u64 *pqwCurrTSF)
 {
 	void __iomem *iobase = priv->port_offset;
 	unsigned short ww;
@@ -811,7 +811,7 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 	void __iomem *iobase = priv->port_offset;
 	u64 qwNextTBTT = 0;
 
-	CARDbGetCurrentTSF(priv, &qwNextTBTT); /* Get Local TSF counter */
+	card_get_current_tsf(priv, &qwNextTBTT); /* Get Local TSF counter */
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 	/* Set NextTBTT */
diff --git a/drivers/staging/vt6655/card.h b/drivers/staging/vt6655/card.h
index 09e7f3f1cbed..55fe039065db 100644
--- a/drivers/staging/vt6655/card.h
+++ b/drivers/staging/vt6655/card.h
@@ -46,7 +46,7 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 			   unsigned short wBeaconInterval);
 void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 			 unsigned short wBeaconInterval);
-bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF);
+bool card_get_current_tsf(struct vnt_private *priv, u64 *pqwCurrTSF);
 u64 CARDqGetNextTBTT(u64 qwTSF, unsigned short wBeaconInterval);
 u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2);
 unsigned char CARDbyGetPktType(struct vnt_private *priv);
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 12fd825c23fe..393430757700 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -1603,7 +1603,7 @@ static u64 vnt_get_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct vnt_private *priv = hw->priv;
 	u64 tsf;
 
-	CARDbGetCurrentTSF(priv, &tsf);
+	card_get_current_tsf(priv, &tsf);
 
 	return tsf;
 }
-- 
2.25.1

