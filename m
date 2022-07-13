Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1CD9572CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 07:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234208AbiGMFBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 01:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbiGMFAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 01:00:31 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71D93DAB96
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:00:30 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id os14so17864444ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 22:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0wMftk2eQcprvM9x6LRj/pysT2hw03/2wElXHcPO8jg=;
        b=lrrQiEyMaox3Gj63Ughmo5lWDHzHzoJXlgjo9adVErpfy50EMQ8br7b9VJxwUvsK4R
         iOHITYRRJ9EKUzhLc97rnwSyEhmbB9WhVpQFrY98/9ukjGDmsFLVP2nwjKuQP7579d15
         6v21Y5uhmQPuJpPcgmIioY0aOvNK06tx1wE4gu2cgs8gKm/sH8/cZMqEGWgo7qzMZw1P
         fmaDfsSAYGKmn2/9aoLJudDzVQCWPHq1iN//ib07rFk7fDyZSfWenIC0Btpi+WJ6AllG
         9W0GuwO4URrXYCHxM5h+fA34KY191e7vECavYoa0+yYt5cCBtblfIQEGtwwiOS0Kukbt
         tqnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0wMftk2eQcprvM9x6LRj/pysT2hw03/2wElXHcPO8jg=;
        b=yo4EUbJS4BnkRsGFPycoosgzkNA+PAMdxHTklJgMFBsYRXpkx7KGy+rTf0TNCuYR5m
         YnSC9oMApYGvWheAWT4FpiqOvHtvBidpE57atq+gGFm+Em89peZEd+75Sgwafiq/Eaw7
         rVz84+pCnDLtTeU8nrC4u2fzWIMI/bn08O8nRg4VBlWn9EA/kUuT5l15UlvR2Jz6vEXB
         pNl7VWNJNIrK5AUCE+cBpbFKWFjVTW3U035RiRhD00UPo/MqgPgC+lN2oFZMEMVUBOnY
         i8j5N1dEnntAGiG2tF4X+Wxz/POoFuAikHFuwqvv3BH2fKGCTcicl2VKgBOn9qOWgVeK
         lghg==
X-Gm-Message-State: AJIora95b0hE6tHgev33uRxjDz7t78qaFBlhuIbd9BL1ZS1MvRKMzr1H
        r5Ulg22otlwpnFPc/B+j3Q0=
X-Google-Smtp-Source: AGRyM1vfv/UZHhjJF7CmI/nIqwPMjmwOfmIqSrq1u2iLudBWUXCPzqAxcdkjeJLhjKoIfmCE3JwUlg==
X-Received: by 2002:a17:906:3f49:b0:722:e1d2:f857 with SMTP id f9-20020a1709063f4900b00722e1d2f857mr1524582ejj.15.1657688429063;
        Tue, 12 Jul 2022 22:00:29 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906a28800b0072b13fa5e4csm4543451ejz.58.2022.07.12.22.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 22:00:28 -0700 (PDT)
Date:   Wed, 13 Jul 2022 07:00:25 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/13] staging: vt6655: Rename MACvWordRegBitsOn
Message-ID: <b3873e1103d642a804d42c945dc0c73d94b0c1cf.1657657918.git.philipp.g.hortmann@gmail.com>
References: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1657657918.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of a macro that uses CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/card.c        |  4 ++--
 drivers/staging/vt6655/device_main.c |  4 ++--
 drivers/staging/vt6655/mac.h         |  4 ++--
 drivers/staging/vt6655/rf.c          | 14 +++++++-------
 4 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 220b47106855..54a12c97aa16 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -354,8 +354,8 @@ void CARDbRadioPowerOff(struct vnt_private *priv)
 	case RF_RFMD2959:
 		MACvWordRegBitsOff(priv->port_offset, MAC_REG_SOFTPWRCTL,
 				   SOFTPWRCTL_TXPEINV);
-		MACvWordRegBitsOn(priv->port_offset, MAC_REG_SOFTPWRCTL,
-				  SOFTPWRCTL_SWPE1);
+		vt6655_mac_word_reg_bits_on(priv->port_offset, MAC_REG_SOFTPWRCTL,
+					    SOFTPWRCTL_SWPE1);
 		break;
 
 	case RF_AIROHA:
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 1a202e5fa39f..bcf35a89730e 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -359,8 +359,8 @@ static void device_init_registers(struct vnt_private *priv)
 	}
 
 	/* use relative tx timeout and 802.11i D4 */
-	MACvWordRegBitsOn(priv->port_offset,
-			  MAC_REG_CFG, (CFG_TKIPOPT | CFG_NOTXTIMEOUT));
+	vt6655_mac_word_reg_bits_on(priv->port_offset, MAC_REG_CFG,
+				    (CFG_TKIPOPT | CFG_NOTXTIMEOUT));
 
 	/* set performance parameter by registry */
 	MACvSetShortRetryLimit(priv, priv->byShortRetryLimit);
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 4e15174ca2ee..3303b9ba3bee 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -544,7 +544,7 @@ do {									\
 	iowrite8(reg_value | (bit_mask), iobase + reg_offset);		\
 } while (0)
 
-#define MACvWordRegBitsOn(iobase, reg_offset, bit_mask)		\
+#define vt6655_mac_word_reg_bits_on(iobase, reg_offset, bit_mask)	\
 do {									\
 	unsigned short reg_value;					\
 	reg_value = ioread16(iobase + reg_offset);			\
@@ -661,7 +661,7 @@ do {									\
 } while (0)
 
 #define MACvSetRFLE_LatchBase(iobase)                                 \
-	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_RFLEOPT)
+	vt6655_mac_word_reg_bits_on(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_RFLEOPT)
 
 #define MAKEWORD(lb, hb) \
 	((unsigned short)(((unsigned char)(lb)) | (((unsigned short)((unsigned char)(hb))) << 8)))
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 99850367293a..6953afc0be34 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -209,8 +209,8 @@ static bool RFbAL2230Init(struct vnt_private *priv)
 	/* 3-wire control for normal mode */
 	iowrite8(0, iobase + MAC_REG_SOFTPWRCTL);
 
-	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, (SOFTPWRCTL_SWPECTI  |
-							 SOFTPWRCTL_TXPEINV));
+	vt6655_mac_word_reg_bits_on(iobase, MAC_REG_SOFTPWRCTL,
+				    (SOFTPWRCTL_SWPECTI | SOFTPWRCTL_TXPEINV));
 	/* PLL  Off */
 	MACvWordRegBitsOff(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPE3);
 
@@ -222,7 +222,7 @@ static bool RFbAL2230Init(struct vnt_private *priv)
 	MACvTimer0MicroSDelay(priv, 30); /* delay 30 us */
 
 	/* PLL On */
-	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPE3);
+	vt6655_mac_word_reg_bits_on(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_SWPE3);
 
 	MACvTimer0MicroSDelay(priv, 150);/* 150us */
 	ret &= IFRFbWriteEmbedded(priv, (0x00d80f00 + (BY_AL2230_REG_LEN << 3) + IFREGCTL_REGW));
@@ -232,10 +232,10 @@ static bool RFbAL2230Init(struct vnt_private *priv)
 	ret &= IFRFbWriteEmbedded(priv,
 				  al2230_init_table[CB_AL2230_INIT_SEQ - 1]);
 
-	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, (SOFTPWRCTL_SWPE3    |
-							 SOFTPWRCTL_SWPE2    |
-							 SOFTPWRCTL_SWPECTI  |
-							 SOFTPWRCTL_TXPEINV));
+	vt6655_mac_word_reg_bits_on(iobase, MAC_REG_SOFTPWRCTL, (SOFTPWRCTL_SWPE3    |
+								 SOFTPWRCTL_SWPE2    |
+								 SOFTPWRCTL_SWPECTI  |
+								 SOFTPWRCTL_TXPEINV));
 
 	/* 3-wire control for power saving mode */
 	iowrite8(PSSIG_WPE3 | PSSIG_WPE2, iobase + MAC_REG_PSPWRSIG);
-- 
2.37.0

