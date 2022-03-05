Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056804CE738
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiCEVdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiCEVdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:33:15 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29D55AED7
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 13:32:23 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q14so2063027wrc.4
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 13:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9IH5+QpuYr8xx7VseEHwb3B5cUXtUdnzvWAtsWC3Lqo=;
        b=jjohIZhvIlSjJYT5OU4GmDH7lyi5I14Gd5Leo4WCzgkFaN0zY3hfFz1iGgWe0x3rNp
         N7cu2YM2M4kmsLsQ76HEflqobBdlIucQ9Bi4Rt1ro46WtEeRg8+IgqKOpnZ5N8vz0BTg
         6UNWOQyJ3Sw2IkdhYB+o7HMqEYRVx4/BfexsE3fH86a6E3m7iacquC3FEW2EGe4zo2Gc
         VmE1aR17MIp4vunFL9JG7x3YMTs+sfN2SI956OsFcO/yHAjB0Qmyma4lFsnZhw2IfDOU
         oiWLfz8ROFsWBV22K1RGvFEC04OG7D3/K7Ghqvfg3U3i/O72n8Po/7C5VAB2jOhlWm4W
         QRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9IH5+QpuYr8xx7VseEHwb3B5cUXtUdnzvWAtsWC3Lqo=;
        b=ZMSlpXoF9tZfvvteUm1aQB2rugGirqUZGnzFijAAQScaDJ2jyTXJoEOdDbIEFkEP9M
         IrAtaZ5CkkrJ/nhSTcrsgQbc3470zngSlRmavpz46Kustxrr8hXPoLQ5nPENzMRgC/vw
         Virtdd/RYRj+0pAoyRWRWiG2YTPXSZ9jMGpiP4qVB2WurpbqlijPZ/OIa+FWEoiV56tA
         eAZWtjQE66J1GMQy51U7VAdENf0s0g+E70zee/5tNEVzJcukyftjqreZZSyILIXGV2UO
         0yey8DeUjAG6gabWdxfMSAsmuwvszcpvmIcDJhBPQRkFIFVZl9Ykm55RUuAjAQw63EHx
         WN+A==
X-Gm-Message-State: AOAM530Lo47m2x2KoKoPIPZ2hH9LnpsoXfSiqn34a48VwtD3mOiDFzzg
        5yqSwEIkIAFb8VAildyXQgE=
X-Google-Smtp-Source: ABdhPJzV5HWPYwTYCrqKU/3cUb4+hY5cPjIC2BdFXXdl50Tp9vTG7vFSAKADoYcLSC7M8LEa3kMvjQ==
X-Received: by 2002:a5d:4609:0:b0:1f1:de8a:af07 with SMTP id t9-20020a5d4609000000b001f1de8aaf07mr3180549wrq.549.1646515942625;
        Sat, 05 Mar 2022 13:32:22 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935aa6.dip0.t-ipconnect.de. [87.147.90.166])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0a4c00b00381141f4967sm11472031wmq.35.2022.03.05.13.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Mar 2022 13:32:22 -0800 (PST)
Date:   Sat, 5 Mar 2022 22:32:20 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] staging: vt6655: Remove unused byRFType in card.c
Message-ID: <5554b243ae285e3274d9968575aadd1a79806b01.1646512837.git.philipp.g.hortmann@gmail.com>
References: <cover.1646512837.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1646512837.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove byRFType that support 5GHz band.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/card.c | 56 +----------------------------------
 1 file changed, 1 insertion(+), 55 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index ee2d145778ed..1110366fc415 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -183,32 +183,11 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 	unsigned char bySlot = 0;
 	unsigned char bySIFS = 0;
 	unsigned char byDIFS = 0;
-	unsigned char data;
 	int i;
 
 	/* Set SIFS, DIFS, EIFS, SlotTime, CwMin */
 	if (bb_type == BB_TYPE_11A) {
-		if (priv->byRFType == RF_AIROHA7230) {
-			/* AL7230 use single PAPE and connect to PAPE_2.4G */
-			MACvSetBBType(priv->port_offset, BB_TYPE_11G);
-			priv->abyBBVGA[0] = 0x20;
-			priv->abyBBVGA[2] = 0x10;
-			priv->abyBBVGA[3] = 0x10;
-			bb_read_embedded(priv, 0xE7, &data);
-			if (data == 0x1C)
-				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
-
-		} else if (priv->byRFType == RF_UW2452) {
-			MACvSetBBType(priv->port_offset, BB_TYPE_11A);
-			priv->abyBBVGA[0] = 0x18;
-			bb_read_embedded(priv, 0xE7, &data);
-			if (data == 0x14) {
-				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
-				bb_write_embedded(priv, 0xE1, 0x57);
-			}
-		} else {
-			MACvSetBBType(priv->port_offset, BB_TYPE_11A);
-		}
+		MACvSetBBType(priv->port_offset, BB_TYPE_11A);
 		bb_write_embedded(priv, 0x88, 0x03);
 		bySlot = C_SLOT_SHORT;
 		bySIFS = C_SIFS_A;
@@ -216,22 +195,6 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		byCWMaxMin = 0xA4;
 	} else if (bb_type == BB_TYPE_11B) {
 		MACvSetBBType(priv->port_offset, BB_TYPE_11B);
-		if (priv->byRFType == RF_AIROHA7230) {
-			priv->abyBBVGA[0] = 0x1C;
-			priv->abyBBVGA[2] = 0x00;
-			priv->abyBBVGA[3] = 0x00;
-			bb_read_embedded(priv, 0xE7, &data);
-			if (data == 0x20)
-				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
-
-		} else if (priv->byRFType == RF_UW2452) {
-			priv->abyBBVGA[0] = 0x14;
-			bb_read_embedded(priv, 0xE7, &data);
-			if (data == 0x18) {
-				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
-				bb_write_embedded(priv, 0xE1, 0xD3);
-			}
-		}
 		bb_write_embedded(priv, 0x88, 0x02);
 		bySlot = C_SLOT_LONG;
 		bySIFS = C_SIFS_BG;
@@ -239,22 +202,6 @@ bool CARDbSetPhyParameter(struct vnt_private *priv, u8 bb_type)
 		byCWMaxMin = 0xA5;
 	} else { /* PK_TYPE_11GA & PK_TYPE_11GB */
 		MACvSetBBType(priv->port_offset, BB_TYPE_11G);
-		if (priv->byRFType == RF_AIROHA7230) {
-			priv->abyBBVGA[0] = 0x1C;
-			priv->abyBBVGA[2] = 0x00;
-			priv->abyBBVGA[3] = 0x00;
-			bb_read_embedded(priv, 0xE7, &data);
-			if (data == 0x20)
-				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
-
-		} else if (priv->byRFType == RF_UW2452) {
-			priv->abyBBVGA[0] = 0x14;
-			bb_read_embedded(priv, 0xE7, &data);
-			if (data == 0x18) {
-				bb_write_embedded(priv, 0xE7, priv->abyBBVGA[0]);
-				bb_write_embedded(priv, 0xE1, 0xD3);
-			}
-		}
 		bb_write_embedded(priv, 0x88, 0x08);
 		bySIFS = C_SIFS_BG;
 
@@ -417,7 +364,6 @@ void CARDbRadioPowerOff(struct vnt_private *priv)
 
 	case RF_AIROHA:
 	case RF_AL2230S:
-	case RF_AIROHA7230:
 		MACvWordRegBitsOff(priv->port_offset, MAC_REG_SOFTPWRCTL,
 				   SOFTPWRCTL_SWPE2);
 		MACvWordRegBitsOff(priv->port_offset, MAC_REG_SOFTPWRCTL,
-- 
2.25.1

