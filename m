Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9784F1A89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378988AbiDDVSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380659AbiDDUug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 16:50:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ED0BE3D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 13:48:38 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ot30so12552402ejb.12
        for <linux-kernel@vger.kernel.org>; Mon, 04 Apr 2022 13:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/DCTfmFnsCW6CmRyecYd9kX39hqliOdp491MdVfso5g=;
        b=bWxC1Y22FmwVfdcBonget0iVkMXSjt/KdvaDX92OdaYjAW3YBevMMC8HvrTUY6JiVH
         eP8BhbWw90akIHKJmstXdVwaYAbrKgV1pF8BaPpl8GORABUvb5KKtl9PbX/yHYxEka0f
         nh/VQkQuCZ6fZHjsJC3SwaR5vPVyF/351XDN3u5610vKrsm9hMGsfmoZNtaA3beo3NX+
         Q0zzy6kofRl4HkkIuSTygTxcXD4Y1ykItLYOjnq1Ih9Tf2dgVhqv/vhqLwbq6XvOwcCH
         oDdVVlFFtCzcTafYcuTvPrYOBlFoUaED3V4CdTwME1+a8g5WRdWwn4djpKilCkLsXFdU
         0qNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/DCTfmFnsCW6CmRyecYd9kX39hqliOdp491MdVfso5g=;
        b=qfzJADIQpfSQ3QQhmx3bvhw6l3kwAXN/q1jNw0d9SHj/H+KwXS8+opSbXp+fSaLmri
         wO8lSGKVmZ5+4eUTSuLPHZ0dhozvnO93StzywQd5HUqVBpnv0F8qUXBWVjAKgaYhuqpg
         iyl/5SSMlcGBhyoNSA/Rl8KI2i5/QofSaRNwGfP6wFjZgWGBsPqwahgkK6Vu8f6/kW6R
         iteKD3yRCpxerqBKnvDl0DLddsitJGJCOCRkRv/kp+Gf3ev/nu6Fn3OSxU2RriNjHnVg
         2RF8k38I3DATAG6D/xQa8Fiah8OaBKSitZ0cP/zLqtrNLEEw1pZHo0sjN15Z7X5WzcC/
         6kwQ==
X-Gm-Message-State: AOAM531iTSI9Prh8+PhjRgPvoopTFVeP4Z+0ETO7hwytmBS1H+tyxbCC
        96BapnVwjWojEP/rczKzSfI=
X-Google-Smtp-Source: ABdhPJwJ6dim7l0HBfsKEpnDkESDuj1aS+iYOTW5QpQumXtQTW6yj3XhjhEPxbhpkEZ2GBfgqVZVJg==
X-Received: by 2002:a17:906:c103:b0:6e0:df50:7f52 with SMTP id do3-20020a170906c10300b006e0df507f52mr8027ejc.501.1649105317561;
        Mon, 04 Apr 2022 13:48:37 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id h7-20020a1709066d8700b006d4b4d137fbsm4821903ejt.50.2022.04.04.13.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 13:48:37 -0700 (PDT)
Date:   Mon, 4 Apr 2022 22:48:35 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/6] staging: vt6655: Remove unused macros in mac.h
Message-ID: <78f72d0aa3d1bdddf3c415fd4c458399aa5e7cbf.1649103348.git.philipp.g.hortmann@gmail.com>
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

Remove unused macros with do-while(0) loop or CamelCase in mac.h as
they are not accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
V1 -> V2: Merged two patches 1/7 and 2/7 into one.
---
 drivers/staging/vt6655/mac.h | 133 -----------------------------------
 1 file changed, 133 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index 550dc4da80a9..a1576e006d69 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -552,21 +552,6 @@ do {									\
 	VNSvOutPortW(iobase + byRegOfs, wData | (wBits));		\
 } while (0)
 
-#define MACvDWordRegBitsOn(iobase, byRegOfs, dwBits)			\
-do {									\
-	unsigned long dwData;						\
-	VNSvInPortD(iobase + byRegOfs, &dwData);			\
-	VNSvOutPortD(iobase + byRegOfs, dwData | (dwBits));		\
-} while (0)
-
-#define MACvRegBitsOnEx(iobase, byRegOfs, byMask, byBits)		\
-do {									\
-	unsigned char byData;						\
-	VNSvInPortB(iobase + byRegOfs, &byData);			\
-	byData &= byMask;						\
-	VNSvOutPortB(iobase + byRegOfs, byData | (byBits));		\
-} while (0)
-
 #define MACvRegBitsOff(iobase, byRegOfs, byBits)			\
 do {									\
 	unsigned char byData;						\
@@ -581,37 +566,6 @@ do {									\
 	VNSvOutPortW(iobase + byRegOfs, wData & ~(wBits));		\
 } while (0)
 
-#define MACvDWordRegBitsOff(iobase, byRegOfs, dwBits)			\
-do {									\
-	unsigned long dwData;						\
-	VNSvInPortD(iobase + byRegOfs, &dwData);			\
-	VNSvOutPortD(iobase + byRegOfs, dwData & ~(dwBits));		\
-} while (0)
-
-#define MACvGetCurrRx0DescAddr(iobase, pdwCurrDescAddr)	\
-	VNSvInPortD(iobase + MAC_REG_RXDMAPTR0,		\
-		    (unsigned long *)pdwCurrDescAddr)
-
-#define MACvGetCurrRx1DescAddr(iobase, pdwCurrDescAddr)	\
-	VNSvInPortD(iobase + MAC_REG_RXDMAPTR1,		\
-		    (unsigned long *)pdwCurrDescAddr)
-
-#define MACvGetCurrTx0DescAddr(iobase, pdwCurrDescAddr)	\
-	VNSvInPortD(iobase + MAC_REG_TXDMAPTR0,		\
-		    (unsigned long *)pdwCurrDescAddr)
-
-#define MACvGetCurrAC0DescAddr(iobase, pdwCurrDescAddr)	\
-	VNSvInPortD(iobase + MAC_REG_AC0DMAPTR,		\
-		    (unsigned long *)pdwCurrDescAddr)
-
-#define MACvGetCurrSyncDescAddr(iobase, pdwCurrDescAddr)	\
-	VNSvInPortD(iobase + MAC_REG_SYNCDMAPTR,		\
-		    (unsigned long *)pdwCurrDescAddr)
-
-#define MACvGetCurrATIMDescAddr(iobase, pdwCurrDescAddr)	\
-	VNSvInPortD(iobase + MAC_REG_ATIMDMAPTR,		\
-		    (unsigned long *)pdwCurrDescAddr)
-
 /* set the chip with current BCN tx descriptor address */
 #define MACvSetCurrBCNTxDescAddr(iobase, dwCurrDescAddr)	\
 	VNSvOutPortD(iobase + MAC_REG_BCNDMAPTR,		\
@@ -622,24 +576,6 @@ do {									\
 	VNSvOutPortW(iobase + MAC_REG_BCNDMACTL + 2,		\
 		     wCurrBCNLength)
 
-#define MACvReadBSSIDAddress(iobase, pbyEtherAddr)		\
-do {								\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1);		\
-	VNSvInPortB(iobase + MAC_REG_BSSID0,			\
-		    (unsigned char *)pbyEtherAddr);		\
-	VNSvInPortB(iobase + MAC_REG_BSSID0 + 1,		\
-		    pbyEtherAddr + 1);				\
-	VNSvInPortB(iobase + MAC_REG_BSSID0 + 2,		\
-		    pbyEtherAddr + 2);				\
-	VNSvInPortB(iobase + MAC_REG_BSSID0 + 3,		\
-		    pbyEtherAddr + 3);				\
-	VNSvInPortB(iobase + MAC_REG_BSSID0 + 4,		\
-		    pbyEtherAddr + 4);				\
-	VNSvInPortB(iobase + MAC_REG_BSSID0 + 5,		\
-		    pbyEtherAddr + 5);				\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
-} while (0)
-
 #define MACvWriteBSSIDAddress(iobase, pbyEtherAddr)		\
 do {								\
 	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1);		\
@@ -676,27 +612,6 @@ do {								\
 	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
 } while (0)
 
-#define MACvWriteEtherAddress(iobase, pbyEtherAddr)		\
-do {								\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1);		\
-	VNSvOutPortB(iobase + MAC_REG_PAR0,			\
-		     *pbyEtherAddr);				\
-	VNSvOutPortB(iobase + MAC_REG_PAR0 + 1,		\
-		     *(pbyEtherAddr + 1));			\
-	VNSvOutPortB(iobase + MAC_REG_PAR0 + 2,		\
-		     *(pbyEtherAddr + 2));			\
-	VNSvOutPortB(iobase + MAC_REG_PAR0 + 3,		\
-		     *(pbyEtherAddr + 3));			\
-	VNSvOutPortB(iobase + MAC_REG_PAR0 + 4,		\
-		     *(pbyEtherAddr + 4));			\
-	VNSvOutPortB(iobase + MAC_REG_PAR0 + 5,		\
-		     *(pbyEtherAddr + 5));			\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
-} while (0)
-
-#define MACvClearISR(iobase)						\
-	VNSvOutPortD(iobase + MAC_REG_ISR, IMR_MASK_VALUE)
-
 #define MACvStart(iobase)						\
 	VNSvOutPortB(iobase + MAC_REG_HOSTCR,				\
 		     (HOSTCR_MACEN | HOSTCR_RXON | HOSTCR_TXON))
@@ -704,18 +619,9 @@ do {								\
 #define MACvRx0PerPktMode(iobase)					\
 	VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, RX_PERPKT)
 
-#define MACvRx0BufferFillMode(iobase)					\
-	VNSvOutPortD(iobase + MAC_REG_RXDMACTL0, RX_PERPKTCLR)
-
 #define MACvRx1PerPktMode(iobase)					\
 	VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, RX_PERPKT)
 
-#define MACvRx1BufferFillMode(iobase)					\
-	VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, RX_PERPKTCLR)
-
-#define MACvRxOn(iobase)						\
-	MACvRegBitsOn(iobase, MAC_REG_HOSTCR, HOSTCR_RXON)
-
 #define MACvReceive0(iobase)						\
 do {									\
 	unsigned long dwData;						\
@@ -736,9 +642,6 @@ do {									\
 		VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, DMACTL_RUN); \
 } while (0)
 
-#define MACvTxOn(iobase)						\
-	MACvRegBitsOn(iobase, MAC_REG_HOSTCR, HOSTCR_TXON)
-
 #define MACvTransmit0(iobase)						\
 do {									\
 	unsigned long dwData;						\
@@ -759,26 +662,6 @@ do {									\
 		VNSvOutPortD(iobase + MAC_REG_AC0DMACTL, DMACTL_RUN); \
 } while (0)
 
-#define MACvTransmitSYNC(iobase)					\
-do {									\
-	unsigned long dwData;						\
-	VNSvInPortD(iobase + MAC_REG_SYNCDMACTL, &dwData);		\
-	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_SYNCDMACTL, DMACTL_WAKE); \
-	else								\
-		VNSvOutPortD(iobase + MAC_REG_SYNCDMACTL, DMACTL_RUN); \
-} while (0)
-
-#define MACvTransmitATIM(iobase)					\
-do {									\
-	unsigned long dwData;						\
-	VNSvInPortD(iobase + MAC_REG_ATIMDMACTL, &dwData);		\
-	if (dwData & DMACTL_RUN)					\
-		VNSvOutPortD(iobase + MAC_REG_ATIMDMACTL, DMACTL_WAKE); \
-	else								\
-		VNSvOutPortD(iobase + MAC_REG_ATIMDMACTL, DMACTL_RUN); \
-} while (0)
-
 #define MACvTransmitBCN(iobase)					\
 	VNSvOutPortB(iobase + MAC_REG_BCNDMACTL, BEACON_READY)
 
@@ -811,9 +694,6 @@ do {									\
 #define MACvReadMIBCounter(iobase, pdwCounter)			\
 	VNSvInPortD(iobase + MAC_REG_MIBCNTR, pdwCounter)
 
-#define MACvPwrEvntDisable(iobase)					\
-	VNSvOutPortW(iobase + MAC_REG_WAKEUPEN0, 0x0000)
-
 #define MACvEnableProtectMD(iobase)					\
 do {									\
 	unsigned long dwOrgValue;					\
@@ -855,19 +735,6 @@ do {									\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
-#define MACvReadATIMW(iobase, pwCounter)				\
-	VNSvInPortW(iobase + MAC_REG_AIDATIM, pwCounter)
-
-#define MACvWriteATIMW(iobase, wCounter)				\
-	VNSvOutPortW(iobase + MAC_REG_AIDATIM, wCounter)
-
-#define MACvWriteCRC16_128(iobase, byRegOfs, wCRC)		\
-do {								\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 1);		\
-	VNSvOutPortW(iobase + byRegOfs, wCRC);		\
-	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
-} while (0)
-
 #define MACvGPIOIn(iobase, pbyValue)					\
 	VNSvInPortB(iobase + MAC_REG_GPIOCTL1, pbyValue)
 
-- 
2.25.1

