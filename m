Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576B74EFF54
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241671AbiDBHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244091AbiDBHbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:31:46 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4B9174EA2
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:29:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg10so10149842ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 00:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UgmXQ65LCqfnu6AqhqLZmG8FG0znnwhRP6/0ELaH6bE=;
        b=I0rGqgA677Rkmr6mgMmldh4OOXkEpPvKSDuqfx0mWZCPY4NH/wv3QIp3pdM53yv/j1
         q4TmBQm/422HTyVaflj6uTbHRA1iuvT4zuJ4yB4IukpnkbUapMxRdUASta6P3uSk9YYs
         u51EwjIaWzu5EY0TX0dg8mw7PtcBDO9A/0nTUKnp3NRWi0vYyG2IL7XP4Xjv+ks1/k15
         k0oPFQHYU3h62/n9zKFtRO87UiZeZltUwzASgp+4Onp5DXDrY3RCjyNCatHNz2qjUHJQ
         ahkfNMsPPAyK1kKrOu0EP2PH5ehZ5L3N/tFPbmEB3dF99bGAVkJ6m6ag51XVHfh43tZJ
         hzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UgmXQ65LCqfnu6AqhqLZmG8FG0znnwhRP6/0ELaH6bE=;
        b=rhvnXaxUkopZu7IwQAv9Kl68CQwMrbOJBsrwB4RIARQJhnii9hXaJwf/Y5V3abY/3L
         Svh9h8AI7jaE2TswxlROgzbZwr5zZLEU59LTND8U0D0QN8n9GQD15pxGxT+B0PG9N0y2
         ZRmyTJVCtbKphwBcic1F6sO8OLcwhTqsd5sd/D9c72EXYycte40c8D3valHpFDs7WSrX
         Mtl8cxYhLTXfg1WLGhfW24M+iJYDJgFCaLsM1l2LqnVWkWFoTkj44JcxOXC0mYDuzj6K
         wlL1eHdl4BjCS4pj5EBX19ZN8nWiHTmyIYV5jgRn/H2Ffrl8kzIGolqrBS05SmVSJy9O
         q/fw==
X-Gm-Message-State: AOAM531+u8zUN6Q/SX94nHybuyVa+nyz7OGpqiAXILyEwcGgwc2mIYmI
        ngabFzFtdeCGPDkYGIxEC5w=
X-Google-Smtp-Source: ABdhPJxSjxs7i6l8eOkJekJYHew97eTr7Ih7VEaRIpkFpIIR+NmWSx9Mwrw2NRi5Ea+lk3vU+w5Eqg==
X-Received: by 2002:a17:907:728b:b0:6df:8f3b:28ae with SMTP id dt11-20020a170907728b00b006df8f3b28aemr2927627ejc.336.1648884586786;
        Sat, 02 Apr 2022 00:29:46 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id gt34-20020a1709072da200b006df6bb3db69sm1821498ejc.158.2022.04.02.00.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 00:29:46 -0700 (PDT)
Date:   Sat, 2 Apr 2022 09:29:44 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] staging: vt6655: Rename macros VNSvOutPortB,W,D
Message-ID: <0fdcf2d95973719c2398819915239d47c5d4b34f.1648882847.git.philipp.g.hortmann@gmail.com>
References: <cover.1648882847.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1648882847.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename macros VNSvOutPortB,W,D with CamelCase in upc.h as
they are not accepted by checkpatch.pl

Since there are more than one checkpatch issue per line,
more steps are rquired to fix.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/baseband.c    | 10 ++--
 drivers/staging/vt6655/card.c        | 54 +++++++++----------
 drivers/staging/vt6655/channel.c     |  4 +-
 drivers/staging/vt6655/device_main.c | 26 +++++-----
 drivers/staging/vt6655/mac.h         | 78 ++++++++++++++--------------
 drivers/staging/vt6655/power.c       |  4 +-
 drivers/staging/vt6655/rf.c          | 12 ++---
 drivers/staging/vt6655/rxtx.c        |  4 +-
 drivers/staging/vt6655/srom.c        | 10 ++--
 drivers/staging/vt6655/upc.h         |  6 +--
 10 files changed, 104 insertions(+), 104 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index 9279d15c371f..c995c7bd0545 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1910,7 +1910,7 @@ bool bb_read_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 	unsigned char by_value;
 
 	/* BB reg offset */
-	VNSvOutPortB(iobase + MAC_REG_BBREGADR, by_bb_addr);
+	VNS_OUT_PORTB(iobase + MAC_REG_BBREGADR, by_bb_addr);
 
 	/* turn on REGR */
 	MACvRegBitsOn(iobase, MAC_REG_BBREGCTL, BBREGCTL_REGR);
@@ -1953,9 +1953,9 @@ bool bb_write_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 	unsigned char by_value;
 
 	/* BB reg offset */
-	VNSvOutPortB(iobase + MAC_REG_BBREGADR, by_bb_addr);
+	VNS_OUT_PORTB(iobase + MAC_REG_BBREGADR, by_bb_addr);
 	/* set BB data */
-	VNSvOutPortB(iobase + MAC_REG_BBREGDATA, by_data);
+	VNS_OUT_PORTB(iobase + MAC_REG_BBREGDATA, by_data);
 
 	/* turn on BBREGCTL_REGW */
 	MACvRegBitsOn(iobase, MAC_REG_BBREGCTL, BBREGCTL_REGW);
@@ -2014,7 +2014,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 					byVT3253B0_AGC4_RFMD2959[ii][0],
 					byVT3253B0_AGC4_RFMD2959[ii][1]);
 
-			VNSvOutPortD(iobase + MAC_REG_ITRTMSET, 0x23);
+			VNS_OUT_PORTD(iobase + MAC_REG_ITRTMSET, 0x23);
 			MACvRegBitsOn(iobase, MAC_REG_PAPEDELAY, BIT(0));
 		}
 		priv->abyBBVGA[0] = 0x18;
@@ -2054,7 +2054,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
 				byVT3253B0_AGC[ii][0],
 				byVT3253B0_AGC[ii][1]);
 
-		VNSvOutPortB(iobase + MAC_REG_ITRTMSET, 0x23);
+		VNS_OUT_PORTB(iobase + MAC_REG_ITRTMSET, 0x23);
 		MACvRegBitsOn(iobase, MAC_REG_PAPEDELAY, BIT(0));
 
 		priv->abyBBVGA[0] = 0x14;
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 43b7d16427a4..dead364539d3 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -239,25 +239,25 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 
 	if (priv->bySIFS != bySIFS) {
 		priv->bySIFS = bySIFS;
-		VNSvOutPortB(priv->port_offset + MAC_REG_SIFS, priv->bySIFS);
+		VNS_OUT_PORTB(priv->port_offset + MAC_REG_SIFS, priv->bySIFS);
 	}
 	if (priv->byDIFS != byDIFS) {
 		priv->byDIFS = byDIFS;
-		VNSvOutPortB(priv->port_offset + MAC_REG_DIFS, priv->byDIFS);
+		VNS_OUT_PORTB(priv->port_offset + MAC_REG_DIFS, priv->byDIFS);
 	}
 	if (priv->byEIFS != C_EIFS) {
 		priv->byEIFS = C_EIFS;
-		VNSvOutPortB(priv->port_offset + MAC_REG_EIFS, priv->byEIFS);
+		VNS_OUT_PORTB(priv->port_offset + MAC_REG_EIFS, priv->byEIFS);
 	}
 	if (priv->bySlot != bySlot) {
 		priv->bySlot = bySlot;
-		VNSvOutPortB(priv->port_offset + MAC_REG_SLOT, priv->bySlot);
+		VNS_OUT_PORTB(priv->port_offset + MAC_REG_SLOT, priv->bySlot);
 
 		bb_set_short_slot_time(priv);
 	}
 	if (priv->byCWMaxMin != byCWMaxMin) {
 		priv->byCWMaxMin = byCWMaxMin;
-		VNSvOutPortB(priv->port_offset + MAC_REG_CWMAXMIN0,
+		VNS_OUT_PORTB(priv->port_offset + MAC_REG_CWMAXMIN0,
 			     priv->byCWMaxMin);
 	}
 
@@ -295,9 +295,9 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
 		qwTSFOffset = CARDqGetTSFOffset(byRxRate, qwBSSTimestamp,
 						local_tsf);
 		/* adjust TSF, HW's TSF add TSF Offset reg */
-		VNSvOutPortD(priv->port_offset + MAC_REG_TSFOFST,
+		VNS_OUT_PORTD(priv->port_offset + MAC_REG_TSFOFST,
 			     (u32)qwTSFOffset);
-		VNSvOutPortD(priv->port_offset + MAC_REG_TSFOFST + 4,
+		VNS_OUT_PORTD(priv->port_offset + MAC_REG_TSFOFST + 4,
 			     (u32)(qwTSFOffset >> 32));
 		MACvRegBitsOn(priv->port_offset, MAC_REG_TFTCTL,
 			      TFTCTL_TSFSYNCEN);
@@ -328,11 +328,11 @@ bool CARDbSetBeaconPeriod(struct vnt_private *priv,
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 
 	/* set HW beacon interval */
-	VNSvOutPortW(priv->port_offset + MAC_REG_BI, wBeaconInterval);
+	VNS_OUT_PORTW(priv->port_offset + MAC_REG_BI, wBeaconInterval);
 	priv->wBeaconInterval = wBeaconInterval;
 	/* Set NextTBTT */
-	VNSvOutPortD(priv->port_offset + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
-	VNSvOutPortD(priv->port_offset + MAC_REG_NEXTTBTT + 4,
+	VNS_OUT_PORTD(priv->port_offset + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
+	VNS_OUT_PORTD(priv->port_offset + MAC_REG_NEXTTBTT + 4,
 		     (u32)(qwNextTBTT >> 32));
 	MACvRegBitsOn(priv->port_offset, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
 
@@ -555,7 +555,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 	 /* swap over to get correct write order */
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_RSPINF_B_1, phy.field_write);
+	VNS_OUT_PORTD(priv->port_offset + MAC_REG_RSPINF_B_1, phy.field_write);
 
 	/* RSPINF_b_2 */
 	vnt_get_phy_field(priv, 14,
@@ -564,7 +564,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_RSPINF_B_2, phy.field_write);
+	VNS_OUT_PORTD(priv->port_offset + MAC_REG_RSPINF_B_2, phy.field_write);
 
 	/* RSPINF_b_5 */
 	vnt_get_phy_field(priv, 14,
@@ -573,7 +573,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_RSPINF_B_5, phy.field_write);
+	VNS_OUT_PORTD(priv->port_offset + MAC_REG_RSPINF_B_5, phy.field_write);
 
 	/* RSPINF_b_11 */
 	vnt_get_phy_field(priv, 14,
@@ -582,42 +582,42 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 
 	swap(phy.swap[0], phy.swap[1]);
 
-	VNSvOutPortD(priv->port_offset + MAC_REG_RSPINF_B_11, phy.field_write);
+	VNS_OUT_PORTD(priv->port_offset + MAC_REG_RSPINF_B_11, phy.field_write);
 
 	/* RSPINF_a_6 */
 	s_vCalculateOFDMRParameter(RATE_6M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_6,
+	VNS_OUT_PORTW(priv->port_offset + MAC_REG_RSPINF_A_6,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_9 */
 	s_vCalculateOFDMRParameter(RATE_9M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_9,
+	VNS_OUT_PORTW(priv->port_offset + MAC_REG_RSPINF_A_9,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_12 */
 	s_vCalculateOFDMRParameter(RATE_12M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_12,
+	VNS_OUT_PORTW(priv->port_offset + MAC_REG_RSPINF_A_12,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_18 */
 	s_vCalculateOFDMRParameter(RATE_18M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_18,
+	VNS_OUT_PORTW(priv->port_offset + MAC_REG_RSPINF_A_18,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_24 */
 	s_vCalculateOFDMRParameter(RATE_24M,
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_24,
+	VNS_OUT_PORTW(priv->port_offset + MAC_REG_RSPINF_A_24,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_36 */
 	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
@@ -625,7 +625,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_36,
+	VNS_OUT_PORTW(priv->port_offset + MAC_REG_RSPINF_A_36,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_48 */
 	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
@@ -633,7 +633,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_48,
+	VNS_OUT_PORTW(priv->port_offset + MAC_REG_RSPINF_A_48,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_54 */
 	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
@@ -641,7 +641,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_54,
+	VNS_OUT_PORTW(priv->port_offset + MAC_REG_RSPINF_A_54,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* RSPINF_a_72 */
 	s_vCalculateOFDMRParameter(CARDwGetOFDMControlRate((void *)priv,
@@ -649,7 +649,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
 				   bb_type,
 				   &byTxRate,
 				   &byRsvTime);
-	VNSvOutPortW(priv->port_offset + MAC_REG_RSPINF_A_72,
+	VNS_OUT_PORTW(priv->port_offset + MAC_REG_RSPINF_A_72,
 		     MAKEWORD(byTxRate, byRsvTime));
 	/* Set to Page0 */
 	MACvSelectPage0(priv->port_offset);
@@ -810,8 +810,8 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
 
 	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
 	/* Set NextTBTT */
-	VNSvOutPortD(iobase + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
-	VNSvOutPortD(iobase + MAC_REG_NEXTTBTT + 4, (u32)(qwNextTBTT >> 32));
+	VNS_OUT_PORTD(iobase + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
+	VNS_OUT_PORTD(iobase + MAC_REG_NEXTTBTT + 4, (u32)(qwNextTBTT >> 32));
 	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
 }
 
@@ -836,8 +836,8 @@ void CARDvUpdateNextTBTT(struct vnt_private *priv, u64 qwTSF,
 
 	qwTSF = CARDqGetNextTBTT(qwTSF, wBeaconInterval);
 	/* Set NextTBTT */
-	VNSvOutPortD(iobase + MAC_REG_NEXTTBTT, (u32)qwTSF);
-	VNSvOutPortD(iobase + MAC_REG_NEXTTBTT + 4, (u32)(qwTSF >> 32));
+	VNS_OUT_PORTD(iobase + MAC_REG_NEXTTBTT, (u32)qwTSF);
+	VNS_OUT_PORTD(iobase + MAC_REG_NEXTTBTT + 4, (u32)(qwTSF >> 32));
 	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TBTTSYNCEN);
 	pr_debug("Card:Update Next TBTT[%8llx]\n", qwTSF);
 }
diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
index abe867814dc8..6bef64bc51cf 100644
--- a/drivers/staging/vt6655/channel.c
+++ b/drivers/staging/vt6655/channel.c
@@ -118,10 +118,10 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
 		/* set HW default power register */
 		MACvSelectPage1(priv->port_offset);
 		RFbSetPower(priv, RATE_1M, priv->byCurrentCh);
-		VNSvOutPortB(priv->port_offset + MAC_REG_PWRCCK,
+		VNS_OUT_PORTB(priv->port_offset + MAC_REG_PWRCCK,
 			     priv->byCurPwr);
 		RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
-		VNSvOutPortB(priv->port_offset + MAC_REG_PWROFDM,
+		VNS_OUT_PORTB(priv->port_offset + MAC_REG_PWROFDM,
 			     priv->byCurPwr);
 		MACvSelectPage0(priv->port_offset);
 
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index ec8726e2da7d..69b75193c819 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -334,7 +334,7 @@ static void device_init_registers(struct vnt_private *priv)
 	if (priv->local_id > REV_ID_VT3253_B1) {
 		MACvSelectPage1(priv->port_offset);
 
-		VNSvOutPortB(priv->port_offset + MAC_REG_MSRCTL + 1,
+		VNS_OUT_PORTB(priv->port_offset + MAC_REG_MSRCTL + 1,
 			     (MSRCTL1_TXPWR | MSRCTL1_CSAPAREN));
 
 		MACvSelectPage0(priv->port_offset);
@@ -349,9 +349,9 @@ static void device_init_registers(struct vnt_private *priv)
 	MACvSetLongRetryLimit(priv, priv->byLongRetryLimit);
 
 	/* reset TSF counter */
-	VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
+	VNS_OUT_PORTB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
 	/* enable TSF counter */
-	VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
+	VNS_OUT_PORTB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
 
 	/* initialize BBP registers */
 	bb_vt3253_init(priv);
@@ -1060,8 +1060,8 @@ static void vnt_interrupt_process(struct vnt_private *priv)
 
 		if (isr & ISR_FETALERR) {
 			pr_debug(" ISR_FETALERR\n");
-			VNSvOutPortB(priv->port_offset + MAC_REG_SOFTPWRCTL, 0);
-			VNSvOutPortW(priv->port_offset +
+			VNS_OUT_PORTB(priv->port_offset + MAC_REG_SOFTPWRCTL, 0);
+			VNS_OUT_PORTW(priv->port_offset +
 				     MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPECTI);
 			device_error(priv, isr);
 		}
@@ -1477,9 +1477,9 @@ static void vnt_bss_info_changed(struct ieee80211_hw *hw,
 
 			CARDvSetFirstNextTBTT(priv, conf->beacon_int);
 		} else {
-			VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL,
+			VNS_OUT_PORTB(priv->port_offset + MAC_REG_TFTCTL,
 				     TFTCTL_TSFCNTRST);
-			VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL,
+			VNS_OUT_PORTB(priv->port_offset + MAC_REG_TFTCTL,
 				     TFTCTL_TSFCNTREN);
 		}
 	}
@@ -1526,18 +1526,18 @@ static void vnt_configure(struct ieee80211_hw *hw,
 			if (priv->mc_list_count > 2) {
 				MACvSelectPage1(priv->port_offset);
 
-				VNSvOutPortD(priv->port_offset +
+				VNS_OUT_PORTD(priv->port_offset +
 					     MAC_REG_MAR0, 0xffffffff);
-				VNSvOutPortD(priv->port_offset +
+				VNS_OUT_PORTD(priv->port_offset +
 					    MAC_REG_MAR0 + 4, 0xffffffff);
 
 				MACvSelectPage0(priv->port_offset);
 			} else {
 				MACvSelectPage1(priv->port_offset);
 
-				VNSvOutPortD(priv->port_offset +
+				VNS_OUT_PORTD(priv->port_offset +
 					     MAC_REG_MAR0, (u32)multicast);
-				VNSvOutPortD(priv->port_offset +
+				VNS_OUT_PORTD(priv->port_offset +
 					     MAC_REG_MAR0 + 4,
 					     (u32)(multicast >> 32));
 
@@ -1561,7 +1561,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 			rx_mode |= RCR_BSSID;
 	}
 
-	VNSvOutPortB(priv->port_offset + MAC_REG_RCR, rx_mode);
+	VNS_OUT_PORTB(priv->port_offset + MAC_REG_RCR, rx_mode);
 
 	dev_dbg(&priv->pcid->dev, "rx mode out= %x\n", rx_mode);
 }
@@ -1621,7 +1621,7 @@ static void vnt_reset_tsf(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct vnt_private *priv = hw->priv;
 
 	/* reset TSF counter */
-	VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
+	VNS_OUT_PORTB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
 }
 
 static const struct ieee80211_ops vnt_mac_ops = {
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index b45ff015b189..be59da1b04b9 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -542,61 +542,61 @@
 do {									\
 	unsigned char byData;						\
 	VNS_IN_PORTB(iobase + byRegOfs, &byData);			\
-	VNSvOutPortB(iobase + byRegOfs, byData | (byBits));		\
+	VNS_OUT_PORTB(iobase + byRegOfs, byData | (byBits));		\
 } while (0)
 
 #define MACvWordRegBitsOn(iobase, byRegOfs, wBits)			\
 do {									\
 	unsigned short wData;						\
 	VNS_IN_PORTW(iobase + byRegOfs, &wData);			\
-	VNSvOutPortW(iobase + byRegOfs, wData | (wBits));		\
+	VNS_OUT_PORTW(iobase + byRegOfs, wData | (wBits));		\
 } while (0)
 
 #define MACvRegBitsOff(iobase, byRegOfs, byBits)			\
 do {									\
 	unsigned char byData;						\
 	VNS_IN_PORTB(iobase + byRegOfs, &byData);			\
-	VNSvOutPortB(iobase + byRegOfs, byData & ~(byBits));		\
+	VNS_OUT_PORTB(iobase + byRegOfs, byData & ~(byBits));		\
 } while (0)
 
 #define MACvWordRegBitsOff(iobase, byRegOfs, wBits)			\
 do {									\
 	unsigned short wData;						\
 	VNS_IN_PORTW(iobase + byRegOfs, &wData);			\
-	VNSvOutPortW(iobase + byRegOfs, wData & ~(wBits));		\
+	VNS_OUT_PORTW(iobase + byRegOfs, wData & ~(wBits));		\
 } while (0)
 
 /* set the chip with current BCN tx descriptor address */
 #define MACvSetCurrBCNTxDescAddr(iobase, dwCurrDescAddr)	\
-	VNSvOutPortD(iobase + MAC_REG_BCNDMAPTR,		\
+	VNS_OUT_PORTD(iobase + MAC_REG_BCNDMAPTR,		\
 		     dwCurrDescAddr)
 
 /* set the chip with current BCN length */
 #define MACvSetCurrBCNLength(iobase, wCurrBCNLength)		\
-	VNSvOutPortW(iobase + MAC_REG_BCNDMACTL + 2,		\
+	VNS_OUT_PORTW(iobase + MAC_REG_BCNDMACTL + 2,		\
 		     wCurrBCNLength)
 
 #define MACvWriteBSSIDAddress(iobase, pbyEtherAddr)		\
 do {								\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1);		\
-	VNSvOutPortB(iobase + MAC_REG_BSSID0,			\
+	VNS_OUT_PORTB(iobase + MAC_REG_PAGE1SEL, 1);		\
+	VNS_OUT_PORTB(iobase + MAC_REG_BSSID0,			\
 		     *(pbyEtherAddr));				\
-	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 1,		\
+	VNS_OUT_PORTB(iobase + MAC_REG_BSSID0 + 1,		\
 		     *(pbyEtherAddr + 1));			\
-	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 2,		\
+	VNS_OUT_PORTB(iobase + MAC_REG_BSSID0 + 2,		\
 		     *(pbyEtherAddr + 2));			\
-	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 3,		\
+	VNS_OUT_PORTB(iobase + MAC_REG_BSSID0 + 3,		\
 		     *(pbyEtherAddr + 3));			\
-	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 4,		\
+	VNS_OUT_PORTB(iobase + MAC_REG_BSSID0 + 4,		\
 		     *(pbyEtherAddr + 4));			\
-	VNSvOutPortB(iobase + MAC_REG_BSSID0 + 5,		\
+	VNS_OUT_PORTB(iobase + MAC_REG_BSSID0 + 5,		\
 		     *(pbyEtherAddr + 5));			\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
+	VNS_OUT_PORTB(iobase + MAC_REG_PAGE1SEL, 0);		\
 } while (0)
 
 #define MACvReadEtherAddress(iobase, pbyEtherAddr)		\
 do {								\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1);		\
+	VNS_OUT_PORTB(iobase + MAC_REG_PAGE1SEL, 1);		\
 	VNS_IN_PORTB(iobase + MAC_REG_PAR0,			\
 		    (unsigned char *)pbyEtherAddr);		\
 	VNS_IN_PORTB(iobase + MAC_REG_PAR0 + 1,		\
@@ -609,27 +609,27 @@ do {								\
 		    pbyEtherAddr + 4);				\
 	VNS_IN_PORTB(iobase + MAC_REG_PAR0 + 5,		\
 		    pbyEtherAddr + 5);				\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
+	VNS_OUT_PORTB(iobase + MAC_REG_PAGE1SEL, 0);		\
 } while (0)
 
 #define MACvStart(iobase)						\
-	VNSvOutPortB(iobase + MAC_REG_HOSTCR,				\
+	VNS_OUT_PORTB(iobase + MAC_REG_HOSTCR,				\
 		     (HOSTCR_MACEN | HOSTCR_RXON | HOSTCR_TXON))
 
 #define MACvRx0PerPktMode(iobase)					\
-	VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, RX_PERPKT)
+	VNS_OUT_PORTD(iobase + MAC_REG_RXDMACTL0, RX_PERPKT)
 
 #define MACvRx1PerPktMode(iobase)					\
-	VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, RX_PERPKT)
+	VNS_OUT_PORTD(iobase + MAC_REG_RXDMACTL1, RX_PERPKT)
 
 #define MACvReceive0(iobase)						\
 do {									\
 	unsigned long dwData;						\
 	VNS_IN_PORTD(iobase + MAC_REG_RXDMACTL0, &dwData);		\
 	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, DMACTL_WAKE); \
+		VNS_OUT_PORTD(iobase + MAC_REG_RXDMACTL0, DMACTL_WAKE); \
 	else								\
-		VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, DMACTL_RUN); \
+		VNS_OUT_PORTD(iobase + MAC_REG_RXDMACTL0, DMACTL_RUN); \
 } while (0)
 
 #define MACvReceive1(iobase)						\
@@ -637,9 +637,9 @@ do {									\
 	unsigned long dwData;						\
 	VNS_IN_PORTD(iobase + MAC_REG_RXDMACTL1, &dwData);		\
 	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, DMACTL_WAKE); \
+		VNS_OUT_PORTD(iobase + MAC_REG_RXDMACTL1, DMACTL_WAKE); \
 	else								\
-		VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, DMACTL_RUN); \
+		VNS_OUT_PORTD(iobase + MAC_REG_RXDMACTL1, DMACTL_RUN); \
 } while (0)
 
 #define MACvTransmit0(iobase)						\
@@ -647,9 +647,9 @@ do {									\
 	unsigned long dwData;						\
 	VNS_IN_PORTD(iobase + MAC_REG_TXDMACTL0, &dwData);		\
 	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_TXDMACTL0, DMACTL_WAKE); \
+		VNS_OUT_PORTD(iobase + MAC_REG_TXDMACTL0, DMACTL_WAKE); \
 	else								\
-		VNSvOutPortD(iobase + MAC_REG_TXDMACTL0, DMACTL_RUN); \
+		VNS_OUT_PORTD(iobase + MAC_REG_TXDMACTL0, DMACTL_RUN); \
 } while (0)
 
 #define MACvTransmitAC0(iobase)					\
@@ -657,39 +657,39 @@ do {									\
 	unsigned long dwData;						\
 	VNS_IN_PORTD(iobase + MAC_REG_AC0DMACTL, &dwData);		\
 	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_AC0DMACTL, DMACTL_WAKE); \
+		VNS_OUT_PORTD(iobase + MAC_REG_AC0DMACTL, DMACTL_WAKE); \
 	else								\
-		VNSvOutPortD(iobase + MAC_REG_AC0DMACTL, DMACTL_RUN); \
+		VNS_OUT_PORTD(iobase + MAC_REG_AC0DMACTL, DMACTL_RUN); \
 } while (0)
 
 #define MACvTransmitBCN(iobase)					\
-	VNSvOutPortB(iobase + MAC_REG_BCNDMACTL, BEACON_READY)
+	VNS_OUT_PORTB(iobase + MAC_REG_BCNDMACTL, BEACON_READY)
 
 #define MACvClearStckDS(iobase)					\
 do {									\
 	unsigned char byOrgValue;					\
 	VNS_IN_PORTB(iobase + MAC_REG_STICKHW, &byOrgValue);		\
 	byOrgValue = byOrgValue & 0xFC;					\
-	VNSvOutPortB(iobase + MAC_REG_STICKHW, byOrgValue);		\
+	VNS_OUT_PORTB(iobase + MAC_REG_STICKHW, byOrgValue);		\
 } while (0)
 
 #define MACvReadISR(iobase, pdwValue)				\
 	VNS_IN_PORTD(iobase + MAC_REG_ISR, pdwValue)
 
 #define MACvWriteISR(iobase, dwValue)				\
-	VNSvOutPortD(iobase + MAC_REG_ISR, dwValue)
+	VNS_OUT_PORTD(iobase + MAC_REG_ISR, dwValue)
 
 #define MACvIntEnable(iobase, dwMask)				\
-	VNSvOutPortD(iobase + MAC_REG_IMR, dwMask)
+	VNS_OUT_PORTD(iobase + MAC_REG_IMR, dwMask)
 
 #define MACvIntDisable(iobase)				\
-	VNSvOutPortD(iobase + MAC_REG_IMR, 0)
+	VNS_OUT_PORTD(iobase + MAC_REG_IMR, 0)
 
 #define MACvSelectPage0(iobase)				\
-		VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0)
+		VNS_OUT_PORTB(iobase + MAC_REG_PAGE1SEL, 0)
 
 #define MACvSelectPage1(iobase)				\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1)
+	VNS_OUT_PORTB(iobase + MAC_REG_PAGE1SEL, 1)
 
 #define MACvReadMIBCounter(iobase, pdwCounter)			\
 	VNS_IN_PORTD(iobase + MAC_REG_MIBCNTR, pdwCounter)
@@ -699,7 +699,7 @@ do {									\
 	unsigned long dwOrgValue;					\
 	VNS_IN_PORTD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
 	dwOrgValue = dwOrgValue | ENCFG_PROTECTMD;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	VNS_OUT_PORTD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
 #define MACvDisableProtectMD(iobase)					\
@@ -707,7 +707,7 @@ do {									\
 	unsigned long dwOrgValue;					\
 	VNS_IN_PORTD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
 	dwOrgValue = dwOrgValue & ~ENCFG_PROTECTMD;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	VNS_OUT_PORTD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
 #define MACvEnableBarkerPreambleMd(iobase)				\
@@ -715,7 +715,7 @@ do {									\
 	unsigned long dwOrgValue;					\
 	VNS_IN_PORTD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
 	dwOrgValue = dwOrgValue | ENCFG_BARKERPREAM;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	VNS_OUT_PORTD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
 #define MACvDisableBarkerPreambleMd(iobase)				\
@@ -723,7 +723,7 @@ do {									\
 	unsigned long dwOrgValue;					\
 	VNS_IN_PORTD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
 	dwOrgValue = dwOrgValue & ~ENCFG_BARKERPREAM;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	VNS_OUT_PORTD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
 #define MACvSetBBType(iobase, byTyp)					\
@@ -732,7 +732,7 @@ do {									\
 	VNS_IN_PORTD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
 	dwOrgValue = dwOrgValue & ~ENCFG_BBTYPE_MASK;			\
 	dwOrgValue = dwOrgValue | (unsigned long)byTyp;			\
-	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
+	VNS_OUT_PORTD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
 #define MACvGPIOIn(iobase, pbyValue)					\
diff --git a/drivers/staging/vt6655/power.c b/drivers/staging/vt6655/power.c
index 06066fa56dd5..a3dcc31d2112 100644
--- a/drivers/staging/vt6655/power.c
+++ b/drivers/staging/vt6655/power.c
@@ -52,10 +52,10 @@ void PSvEnablePowerSaving(struct vnt_private *priv,
 	u16 wAID = priv->current_aid | BIT(14) | BIT(15);
 
 	/* set period of power up before TBTT */
-	VNSvOutPortW(priv->port_offset + MAC_REG_PWBT, C_PWBT);
+	VNS_OUT_PORTW(priv->port_offset + MAC_REG_PWBT, C_PWBT);
 	if (priv->op_mode != NL80211_IFTYPE_ADHOC) {
 		/* set AID */
-		VNSvOutPortW(priv->port_offset + MAC_REG_AIDATIM, wAID);
+		VNS_OUT_PORTW(priv->port_offset + MAC_REG_AIDATIM, wAID);
 	}
 
 	/* Set AutoSleep */
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index dad8d20ef10b..952339b36d56 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -171,7 +171,7 @@ bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData)
 	unsigned short ww;
 	unsigned long dwValue;
 
-	VNSvOutPortD(iobase + MAC_REG_IFREGCTL, dwData);
+	VNS_OUT_PORTD(iobase + MAC_REG_IFREGCTL, dwData);
 
 	/* W_MAX_TIMEOUT is the timeout period */
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
@@ -207,7 +207,7 @@ static bool RFbAL2230Init(struct vnt_private *priv)
 	ret = true;
 
 	/* 3-wire control for normal mode */
-	VNSvOutPortB(iobase + MAC_REG_SOFTPWRCTL, 0);
+	VNS_OUT_PORTB(iobase + MAC_REG_SOFTPWRCTL, 0);
 
 	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, (SOFTPWRCTL_SWPECTI  |
 							 SOFTPWRCTL_TXPEINV));
@@ -238,7 +238,7 @@ static bool RFbAL2230Init(struct vnt_private *priv)
 							 SOFTPWRCTL_TXPEINV));
 
 	/* 3-wire control for power saving mode */
-	VNSvOutPortB(iobase + MAC_REG_PSPWRSIG, (PSSIG_WPE3 | PSSIG_WPE2)); /* 1100 0000 */
+	VNS_OUT_PORTB(iobase + MAC_REG_PSPWRSIG, (PSSIG_WPE3 | PSSIG_WPE2)); /* 1100 0000 */
 
 	return ret;
 }
@@ -254,10 +254,10 @@ static bool RFbAL2230SelectChannel(struct vnt_private *priv, unsigned char byCha
 	ret &= IFRFbWriteEmbedded(priv, al2230_channel_table1[byChannel - 1]);
 
 	/* Set Channel[7] = 0 to tell H/W channel is changing now. */
-	VNSvOutPortB(iobase + MAC_REG_CHANNEL, (byChannel & 0x7F));
+	VNS_OUT_PORTB(iobase + MAC_REG_CHANNEL, (byChannel & 0x7F));
 	MACvTimer0MicroSDelay(priv, SWITCH_CHANNEL_DELAY_AL2230);
 	/* Set Channel[7] = 1 to tell H/W channel change is done. */
-	VNSvOutPortB(iobase + MAC_REG_CHANNEL, (byChannel | 0x80));
+	VNS_OUT_PORTB(iobase + MAC_REG_CHANNEL, (byChannel | 0x80));
 
 	return ret;
 }
@@ -350,7 +350,7 @@ bool rf_write_wake_prog_syn(struct vnt_private *priv, unsigned char rf_type,
 	unsigned char sleep_count = 0;
 	unsigned short idx = MISCFIFO_SYNDATA_IDX;
 
-	VNSvOutPortW(iobase + MAC_REG_MISCFFNDEX, 0);
+	VNS_OUT_PORTW(iobase + MAC_REG_MISCFFNDEX, 0);
 	switch (rf_type) {
 	case RF_AIROHA:
 	case RF_AL2230S:
diff --git a/drivers/staging/vt6655/rxtx.c b/drivers/staging/vt6655/rxtx.c
index 53506e242a96..e6c7c1eef17b 100644
--- a/drivers/staging/vt6655/rxtx.c
+++ b/drivers/staging/vt6655/rxtx.c
@@ -1450,9 +1450,9 @@ int vnt_beacon_make(struct vnt_private *priv, struct ieee80211_vif *vif)
 int vnt_beacon_enable(struct vnt_private *priv, struct ieee80211_vif *vif,
 		      struct ieee80211_bss_conf *conf)
 {
-	VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
+	VNS_OUT_PORTB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTRST);
 
-	VNSvOutPortB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
+	VNS_OUT_PORTB(priv->port_offset + MAC_REG_TFTCTL, TFTCTL_TSFCNTREN);
 
 	CARDvSetFirstNextTBTT(priv, conf->beacon_int);
 
diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index 53a565bbc0eb..1612c9702e31 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -68,13 +68,13 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 	byData = 0xFF;
 	VNS_IN_PORTB(iobase + MAC_REG_I2MCFG, &byOrg);
 	/* turn off hardware retry for getting NACK */
-	VNSvOutPortB(iobase + MAC_REG_I2MCFG, (byOrg & (~I2MCFG_NORETRY)));
+	VNS_OUT_PORTB(iobase + MAC_REG_I2MCFG, (byOrg & (~I2MCFG_NORETRY)));
 	for (wNoACK = 0; wNoACK < W_MAX_I2CRETRY; wNoACK++) {
-		VNSvOutPortB(iobase + MAC_REG_I2MTGID, EEP_I2C_DEV_ID);
-		VNSvOutPortB(iobase + MAC_REG_I2MTGAD, byContntOffset);
+		VNS_OUT_PORTB(iobase + MAC_REG_I2MTGID, EEP_I2C_DEV_ID);
+		VNS_OUT_PORTB(iobase + MAC_REG_I2MTGAD, byContntOffset);
 
 		/* issue read command */
-		VNSvOutPortB(iobase + MAC_REG_I2MCSR, I2MCSR_EEMR);
+		VNS_OUT_PORTB(iobase + MAC_REG_I2MCSR, I2MCSR_EEMR);
 		/* wait DONE be set */
 		for (wDelay = 0; wDelay < W_MAX_TIMEOUT; wDelay++) {
 			VNS_IN_PORTB(iobase + MAC_REG_I2MCSR, &byWait);
@@ -88,7 +88,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 		}
 	}
 	VNS_IN_PORTB(iobase + MAC_REG_I2MDIPT, &byData);
-	VNSvOutPortB(iobase + MAC_REG_I2MCFG, byOrg);
+	VNS_OUT_PORTB(iobase + MAC_REG_I2MCFG, byOrg);
 	return byData;
 }
 
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index d271126a86b9..7d5075ec3162 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -29,13 +29,13 @@
 #define VNS_IN_PORTD(io_address, data) \
 	(*(data) = ioread32(io_address))
 
-#define VNSvOutPortB(io_address, data) \
+#define VNS_OUT_PORTB(io_address, data) \
 	iowrite8((u8)(data), io_address)
 
-#define VNSvOutPortW(io_address, data) \
+#define VNS_OUT_PORTW(io_address, data) \
 	iowrite16((u16)(data), io_address)
 
-#define VNSvOutPortD(io_address, data) \
+#define VNS_OUT_PORTD(io_address, data) \
 	iowrite32((u32)(data), io_address)
 
 #define PCAvDelayByIO(u_delay_unit)				\
-- 
2.25.1

