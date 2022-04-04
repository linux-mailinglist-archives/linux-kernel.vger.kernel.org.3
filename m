Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185654F1ED2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382476AbiDDVvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380662AbiDDUuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:50:54 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD4FBE3D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:48:57 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ot30so12553684ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0d3RlzCZMgsq11e2hqshe8ZFXAtKOmd50MfeSnFBOt0=;
        b=GrfLTfHDWjCXz/bZ7440a15s2kpCTBA78mPwrjeoapSOy4B0jB6wGSqvphssq7Fh2/
         DOfqrTKq8rMEHHMONYetbPCdT31ltNlTzA8n/OcHLVLPHS+PS/JIaaudJ5daiZ5GrVst
         MWCDLmvf0a6dPeEYY0T4WSFqtM4NFgE9SWfBkbP5CQJnUrUEh9PhTUcuWyb+HTt1sft8
         NXkZiLF5lV/UlNWlnfjKqt92RIsZutksb9pz1ZZ7TH8lnMyEWU68CopqrEzhFXj9/DIG
         +eBPmwWorkn4evw3oUT0DfqCt6ojw0myZnj4Zm5o3vPvIxNpBH3Qhflkll0hXzgssbPL
         nD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0d3RlzCZMgsq11e2hqshe8ZFXAtKOmd50MfeSnFBOt0=;
        b=Jpvc0fCb6nkPeSLqwQVH+CRZ++W9sNSyW6wZfO/az8LQXm+4cK9NRB9Lxq6TQzIKN+
         h81SrVnz4HPaXqjJt8shL2s7yafZtJpILveJWZDy1wipPwkp/S3w1bwfwuMQokwQSh8Y
         uDV9XsL9UvsBYmxYWzRGN/km5EvLKvheV2Nn2T/xnsGiQF7tpA+mIsXc/I10K2vI3+HK
         154lgW87066yNKY6LH0nAvAh1Z3maVMo4qrNpQO8caNMr6Io21yaFq/IPYi5gvQzYyc8
         qyKJFEqzI4liL4QCVoNcw3Kin3TApplZKPS/iFM9n5VFUEVV+xkWJ/F9XBudohhdOSeR
         ItJg==
X-Gm-Message-State: AOAM530L8j522y7F+TBxptIXu+08xDKeSCDz7g8cZOTddDVwQlbzeQxi
        YiAqZEQ6e0SjmlTBKm1Dpns=
X-Google-Smtp-Source: ABdhPJyCQa2Ur4vTdDd8jkqAK9DjN3Ey3wycHl/sN/D7hxmeFhBQ1NINr3soTxW3FM7NSECxjdHb2g==
X-Received: by 2002:a17:906:3104:b0:6ce:6b85:ecc9 with SMTP id 4-20020a170906310400b006ce6b85ecc9mr15988ejx.339.1649105335788;
        Mon, 04 Apr 2022 13:48:55 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id m20-20020a170906235400b006e718d8b849sm2908544eja.45.2022.04.04.13.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:48:55 -0700 (PDT)
Date:   Mon, 4 Apr 2022 22:48:53 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] staging: vt6655: Rename macros VNSvInPortB,W,D
Message-ID: <f732374554c692466b54af14e5ac9acfa9bf31df.1649103348.git.philipp.g.hortmann@gmail.com>
References: <cover.1649103348.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1649103348.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename macros VNSvInPortB,W,D with CamelCase in upc.h as
they are not accepted by checkpatch.pl

Since there are more than one checkpatch issue per line,
more steps are rquired to fix.

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: This patch was 5/7 and is now 4/6
---
 drivers/staging/vt6655/baseband.c    |  6 ++--
 drivers/staging/vt6655/card.c        |  6 ++--
 drivers/staging/vt6655/device_main.c |  4 +--
 drivers/staging/vt6655/mac.h         | 46 ++++++++++++++--------------
 drivers/staging/vt6655/rf.c          |  2 +-
 drivers/staging/vt6655/srom.c        |  6 ++--
 drivers/staging/vt6655/upc.h         |  6 ++--
 7 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
index dfdb0ebf43b5..9279d15c371f 100644
--- a/drivers/staging/vt6655/baseband.c
+++ b/drivers/staging/vt6655/baseband.c
@@ -1916,13 +1916,13 @@ bool bb_read_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 	MACvRegBitsOn(iobase, MAC_REG_BBREGCTL, BBREGCTL_REGR);
 	/* W_MAX_TIMEOUT is the timeout period */
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
-		VNSvInPortB(iobase + MAC_REG_BBREGCTL, &by_value);
+		VNS_IN_PORTB(iobase + MAC_REG_BBREGCTL, &by_value);
 		if (by_value & BBREGCTL_DONE)
 			break;
 	}
 
 	/* get BB data */
-	VNSvInPortB(iobase + MAC_REG_BBREGDATA, pby_data);
+	VNS_IN_PORTB(iobase + MAC_REG_BBREGDATA, pby_data);
 
 	if (ww == W_MAX_TIMEOUT) {
 		pr_debug(" DBG_PORT80(0x30)\n");
@@ -1961,7 +1961,7 @@ bool bb_write_embedded(struct vnt_private *priv, unsigned char by_bb_addr,
 	MACvRegBitsOn(iobase, MAC_REG_BBREGCTL, BBREGCTL_REGW);
 	/* W_MAX_TIMEOUT is the timeout period */
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
-		VNSvInPortB(iobase + MAC_REG_BBREGCTL, &by_value);
+		VNS_IN_PORTB(iobase + MAC_REG_BBREGCTL, &by_value);
 		if (by_value & BBREGCTL_DONE)
 			break;
 	}
diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
index 1110366fc415..43b7d16427a4 100644
--- a/drivers/staging/vt6655/card.c
+++ b/drivers/staging/vt6655/card.c
@@ -748,14 +748,14 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
 
 	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TSFCNTRRD);
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
-		VNSvInPortB(iobase + MAC_REG_TFTCTL, &data);
+		VNS_IN_PORTB(iobase + MAC_REG_TFTCTL, &data);
 		if (!(data & TFTCTL_TSFCNTRRD))
 			break;
 	}
 	if (ww == W_MAX_TIMEOUT)
 		return false;
-	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
-	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
+	VNS_IN_PORTD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
+	VNS_IN_PORTD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
 
 	return true;
 }
diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
index 897d70cf32b8..ec8726e2da7d 100644
--- a/drivers/staging/vt6655/device_main.c
+++ b/drivers/staging/vt6655/device_main.c
@@ -219,7 +219,7 @@ static void device_init_registers(struct vnt_private *priv)
 	MACvInitialize(priv);
 
 	/* Get Local ID */
-	VNSvInPortB(priv->port_offset + MAC_REG_LOCALID, &priv->local_id);
+	VNS_IN_PORTB(priv->port_offset + MAC_REG_LOCALID, &priv->local_id);
 
 	spin_lock_irqsave(&priv->lock, flags);
 
@@ -1513,7 +1513,7 @@ static void vnt_configure(struct ieee80211_hw *hw,
 
 	*total_flags &= FIF_ALLMULTI | FIF_OTHER_BSS | FIF_BCN_PRBRESP_PROMISC;
 
-	VNSvInPortB(priv->port_offset + MAC_REG_RCR, &rx_mode);
+	VNS_IN_PORTB(priv->port_offset + MAC_REG_RCR, &rx_mode);
 
 	dev_dbg(&priv->pcid->dev, "rx mode in = %x\n", rx_mode);
 
diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 6221351c6400..b45ff015b189 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -541,28 +541,28 @@
 #define MACvRegBitsOn(iobase, byRegOfs, byBits)			\
 do {									\
 	unsigned char byData;						\
-	VNSvInPortB(iobase + byRegOfs, &byData);			\
+	VNS_IN_PORTB(iobase + byRegOfs, &byData);			\
 	VNSvOutPortB(iobase + byRegOfs, byData | (byBits));		\
 } while (0)
 
 #define MACvWordRegBitsOn(iobase, byRegOfs, wBits)			\
 do {									\
 	unsigned short wData;						\
-	VNSvInPortW(iobase + byRegOfs, &wData);			\
+	VNS_IN_PORTW(iobase + byRegOfs, &wData);			\
 	VNSvOutPortW(iobase + byRegOfs, wData | (wBits));		\
 } while (0)
 
 #define MACvRegBitsOff(iobase, byRegOfs, byBits)			\
 do {									\
 	unsigned char byData;						\
-	VNSvInPortB(iobase + byRegOfs, &byData);			\
+	VNS_IN_PORTB(iobase + byRegOfs, &byData);			\
 	VNSvOutPortB(iobase + byRegOfs, byData & ~(byBits));		\
 } while (0)
 
 #define MACvWordRegBitsOff(iobase, byRegOfs, wBits)			\
 do {									\
 	unsigned short wData;						\
-	VNSvInPortW(iobase + byRegOfs, &wData);			\
+	VNS_IN_PORTW(iobase + byRegOfs, &wData);			\
 	VNSvOutPortW(iobase + byRegOfs, wData & ~(wBits));		\
 } while (0)
 
@@ -597,17 +597,17 @@ do {								\
 #define MACvReadEtherAddress(iobase, pbyEtherAddr)		\
 do {								\
 	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1);		\
-	VNSvInPortB(iobase + MAC_REG_PAR0,			\
+	VNS_IN_PORTB(iobase + MAC_REG_PAR0,			\
 		    (unsigned char *)pbyEtherAddr);		\
-	VNSvInPortB(iobase + MAC_REG_PAR0 + 1,		\
+	VNS_IN_PORTB(iobase + MAC_REG_PAR0 + 1,		\
 		    pbyEtherAddr + 1);				\
-	VNSvInPortB(iobase + MAC_REG_PAR0 + 2,		\
+	VNS_IN_PORTB(iobase + MAC_REG_PAR0 + 2,		\
 		    pbyEtherAddr + 2);				\
-	VNSvInPortB(iobase + MAC_REG_PAR0 + 3,		\
+	VNS_IN_PORTB(iobase + MAC_REG_PAR0 + 3,		\
 		    pbyEtherAddr + 3);				\
-	VNSvInPortB(iobase + MAC_REG_PAR0 + 4,		\
+	VNS_IN_PORTB(iobase + MAC_REG_PAR0 + 4,		\
 		    pbyEtherAddr + 4);				\
-	VNSvInPortB(iobase + MAC_REG_PAR0 + 5,		\
+	VNS_IN_PORTB(iobase + MAC_REG_PAR0 + 5,		\
 		    pbyEtherAddr + 5);				\
 	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
 } while (0)
@@ -625,7 +625,7 @@ do {								\
 #define MACvReceive0(iobase)						\
 do {									\
 	unsigned long dwData;						\
-	VNSvInPortD(iobase + MAC_REG_RXDMACTL0, &dwData);		\
+	VNS_IN_PORTD(iobase + MAC_REG_RXDMACTL0, &dwData);		\
 	if (dwData & DMACTL_RUN)					\
 		VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, DMACTL_WAKE); \
 	else								\
@@ -635,7 +635,7 @@ do {									\
 #define MACvReceive1(iobase)						\
 do {									\
 	unsigned long dwData;						\
-	VNSvInPortD(iobase + MAC_REG_RXDMACTL1, &dwData);		\
+	VNS_IN_PORTD(iobase + MAC_REG_RXDMACTL1, &dwData);		\
 	if (dwData & DMACTL_RUN)					\
 		VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, DMACTL_WAKE); \
 	else								\
@@ -645,7 +645,7 @@ do {									\
 #define MACvTransmit0(iobase)						\
 do {									\
 	unsigned long dwData;						\
-	VNSvInPortD(iobase + MAC_REG_TXDMACTL0, &dwData);		\
+	VNS_IN_PORTD(iobase + MAC_REG_TXDMACTL0, &dwData);		\
 	if (dwData & DMACTL_RUN)					\
 		VNSvOutPortD(iobase + MAC_REG_TXDMACTL0, DMACTL_WAKE); \
 	else								\
@@ -655,7 +655,7 @@ do {									\
 #define MACvTransmitAC0(iobase)					\
 do {									\
 	unsigned long dwData;						\
-	VNSvInPortD(iobase + MAC_REG_AC0DMACTL, &dwData);		\
+	VNS_IN_PORTD(iobase + MAC_REG_AC0DMACTL, &dwData);		\
 	if (dwData & DMACTL_RUN)					\
 		VNSvOutPortD(iobase + MAC_REG_AC0DMACTL, DMACTL_WAKE); \
 	else								\
@@ -668,13 +668,13 @@ do {									\
 #define MACvClearStckDS(iobase)					\
 do {									\
 	unsigned char byOrgValue;					\
-	VNSvInPortB(iobase + MAC_REG_STICKHW, &byOrgValue);		\
+	VNS_IN_PORTB(iobase + MAC_REG_STICKHW, &byOrgValue);		\
 	byOrgValue = byOrgValue & 0xFC;					\
 	VNSvOutPortB(iobase + MAC_REG_STICKHW, byOrgValue);		\
 } while (0)
 
 #define MACvReadISR(iobase, pdwValue)				\
-	VNSvInPortD(iobase + MAC_REG_ISR, pdwValue)
+	VNS_IN_PORTD(iobase + MAC_REG_ISR, pdwValue)
 
 #define MACvWriteISR(iobase, dwValue)				\
 	VNSvOutPortD(iobase + MAC_REG_ISR, dwValue)
@@ -692,12 +692,12 @@ do {									\
 	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1)
 
 #define MACvReadMIBCounter(iobase, pdwCounter)			\
-	VNSvInPortD(iobase + MAC_REG_MIBCNTR, pdwCounter)
+	VNS_IN_PORTD(iobase + MAC_REG_MIBCNTR, pdwCounter)
 
 #define MACvEnableProtectMD(iobase)					\
 do {									\
 	unsigned long dwOrgValue;					\
-	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
+	VNS_IN_PORTD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
 	dwOrgValue = dwOrgValue | ENCFG_PROTECTMD;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
@@ -705,7 +705,7 @@ do {									\
 #define MACvDisableProtectMD(iobase)					\
 do {									\
 	unsigned long dwOrgValue;					\
-	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
+	VNS_IN_PORTD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
 	dwOrgValue = dwOrgValue & ~ENCFG_PROTECTMD;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
@@ -713,7 +713,7 @@ do {									\
 #define MACvEnableBarkerPreambleMd(iobase)				\
 do {									\
 	unsigned long dwOrgValue;					\
-	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
+	VNS_IN_PORTD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
 	dwOrgValue = dwOrgValue | ENCFG_BARKERPREAM;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
@@ -721,7 +721,7 @@ do {									\
 #define MACvDisableBarkerPreambleMd(iobase)				\
 do {									\
 	unsigned long dwOrgValue;					\
-	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
+	VNS_IN_PORTD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
 	dwOrgValue = dwOrgValue & ~ENCFG_BARKERPREAM;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
@@ -729,14 +729,14 @@ do {									\
 #define MACvSetBBType(iobase, byTyp)					\
 do {									\
 	unsigned long dwOrgValue;					\
-	VNSvInPortD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
+	VNS_IN_PORTD(iobase + MAC_REG_ENCFG, &dwOrgValue);		\
 	dwOrgValue = dwOrgValue & ~ENCFG_BBTYPE_MASK;			\
 	dwOrgValue = dwOrgValue | (unsigned long)byTyp;			\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
 #define MACvGPIOIn(iobase, pbyValue)					\
-	VNSvInPortB(iobase + MAC_REG_GPIOCTL1, pbyValue)
+	VNS_IN_PORTB(iobase + MAC_REG_GPIOCTL1, pbyValue)
 
 #define MACvSetRFLE_LatchBase(iobase)                                 \
 	MACvWordRegBitsOn(iobase, MAC_REG_SOFTPWRCTL, SOFTPWRCTL_RFLEOPT)
diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
index 4498c9d400f2..dad8d20ef10b 100644
--- a/drivers/staging/vt6655/rf.c
+++ b/drivers/staging/vt6655/rf.c
@@ -175,7 +175,7 @@ bool IFRFbWriteEmbedded(struct vnt_private *priv, unsigned long dwData)
 
 	/* W_MAX_TIMEOUT is the timeout period */
 	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
-		VNSvInPortD(iobase + MAC_REG_IFREGCTL, &dwValue);
+		VNS_IN_PORTD(iobase + MAC_REG_IFREGCTL, &dwValue);
 		if (dwValue & IFREGCTL_DONE)
 			break;
 	}
diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index 5cdbc24e8c45..53a565bbc0eb 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -66,7 +66,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 	unsigned char byOrg;
 
 	byData = 0xFF;
-	VNSvInPortB(iobase + MAC_REG_I2MCFG, &byOrg);
+	VNS_IN_PORTB(iobase + MAC_REG_I2MCFG, &byOrg);
 	/* turn off hardware retry for getting NACK */
 	VNSvOutPortB(iobase + MAC_REG_I2MCFG, (byOrg & (~I2MCFG_NORETRY)));
 	for (wNoACK = 0; wNoACK < W_MAX_I2CRETRY; wNoACK++) {
@@ -77,7 +77,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 		VNSvOutPortB(iobase + MAC_REG_I2MCSR, I2MCSR_EEMR);
 		/* wait DONE be set */
 		for (wDelay = 0; wDelay < W_MAX_TIMEOUT; wDelay++) {
-			VNSvInPortB(iobase + MAC_REG_I2MCSR, &byWait);
+			VNS_IN_PORTB(iobase + MAC_REG_I2MCSR, &byWait);
 			if (byWait & (I2MCSR_DONE | I2MCSR_NACK))
 				break;
 			PCAvDelayByIO(CB_DELAY_LOOP_WAIT);
@@ -87,7 +87,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 			break;
 		}
 	}
-	VNSvInPortB(iobase + MAC_REG_I2MDIPT, &byData);
+	VNS_IN_PORTB(iobase + MAC_REG_I2MDIPT, &byData);
 	VNSvOutPortB(iobase + MAC_REG_I2MCFG, byOrg);
 	return byData;
 }
diff --git a/drivers/staging/vt6655/upc.h b/drivers/staging/vt6655/upc.h
index f080a25e6cdf..d271126a86b9 100644
--- a/drivers/staging/vt6655/upc.h
+++ b/drivers/staging/vt6655/upc.h
@@ -20,13 +20,13 @@
 
 /* For memory mapped IO */
 
-#define VNSvInPortB(io_address, data) \
+#define VNS_IN_PORTB(io_address, data) \
 	(*(data) = ioread8(io_address))
 
-#define VNSvInPortW(io_address, data) \
+#define VNS_IN_PORTW(io_address, data) \
 	(*(data) = ioread16(io_address))
 
-#define VNSvInPortD(io_address, data) \
+#define VNS_IN_PORTD(io_address, data) \
 	(*(data) = ioread32(io_address))
 
 #define VNSvOutPortB(io_address, data) \
-- 
2.25.1

