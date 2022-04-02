Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4E94EFF61
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 09:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbiDBHbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 03:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238722AbiDBHbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 03:31:20 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BCD173F6D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 00:29:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i27so2995906ejd.9
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 00:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GBBvzxregCkjrG0nIJdKGZ1Gb8mYJTSvUt4XwV6bAho=;
        b=J2nnEKvnYT6lu3MNze+z0bnxPxwcnSdA9LjONIl7dziCuGf5C8CdES4pBwcIxOgBj3
         pMyxuWURBbC//ZDkBuOuoISR8kiFXpvic2sMZr8Q/lYzvc71mQX898caW8MLxuACkT7y
         bejspNPOShI8hbYG/O8KdFBzC1eVluwwjMuG9MAqKWkG8gbNcRkdNxdQn0j9AZ01/vil
         NWxW33K2VAn/U6NhDrZE/MCHwcULl3ZBAk4k77cnOtj81wNROl7MByeqAK6m38cUD5JS
         Jxn/fgNFdS8w7mLHYwk7Tz/4PXI+lD8XfM+MatqRDZMIVoxfuEJQAX2WRb2Utr7t3BTW
         QCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GBBvzxregCkjrG0nIJdKGZ1Gb8mYJTSvUt4XwV6bAho=;
        b=NCIqjitB1HSOONVdJnRMmb65tzwKL48RtAQ4OAk6JFKA2evOVJU8Qhlpq+ifdDFiNI
         6Kgkammk+8W/NSJtlPPUKIhehevO62skosiIw31P5rtdiaP1AX7U53DvExIrnDXatA1g
         RvCiGiu5WSzutn9NcG2cifjn6BQUB0K6Xn5zrqGsAnfYDV9B4rNTlZ2/qGNgVGDfisBe
         SRj3bRndblhrvvt6OI+9s6ablY9zB63natEyfS6xPHY5fj5hwDnVBxYWiUcJ/edjWP3a
         C0s+6Pv2FtgWuYI1MamlFkGXzsf5GHTckhH/J3ntzw0BWaGiSyMOo1hx+hMh9Qu4QMEz
         yXvA==
X-Gm-Message-State: AOAM532Ctn9BkPythc8IcfOGkkuQbBz7eDSkIp8NApCEyPFLZVquFOEe
        f3F371nb/uVve9sb4FGuoSk=
X-Google-Smtp-Source: ABdhPJz65PPWYyuQAdbFCSwkQLSiZH6e642nFJdVdQez6ZsW2j3S/PMHGZ4BlimY1Y3H22ly876suQ==
X-Received: by 2002:a17:906:6a17:b0:6e1:13c3:e35c with SMTP id qw23-20020a1709066a1700b006e113c3e35cmr2944056ejc.760.1648884567601;
        Sat, 02 Apr 2022 00:29:27 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a074e9.dip0.t-ipconnect.de. [84.160.116.233])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906339100b006e11af84acasm1813424eja.128.2022.04.02.00.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 00:29:27 -0700 (PDT)
Date:   Sat, 2 Apr 2022 09:29:25 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] staging: vt6655: Remove unused macros with CamelCase in
 mac.h
Message-ID: <646acd285c1239f301692456bd9f46eda449d02b.1648882847.git.philipp.g.hortmann@gmail.com>
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

Remove unused macros with CamelCase variables in mac.h as
they are not accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.h | 48 ------------------------------------
 1 file changed, 48 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index c8bc4b6d2938..a1576e006d69 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -566,30 +566,6 @@ do {									\
 	VNSvOutPortW(iobase + byRegOfs, wData & ~(wBits));		\
 } while (0)
 
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
@@ -636,9 +612,6 @@ do {								\
 	VNSvOutPortB(iobase + MAC_REG_PAGE1SEL, 0);		\
 } while (0)
 
-#define MACvClearISR(iobase)						\
-	VNSvOutPortD(iobase + MAC_REG_ISR, IMR_MASK_VALUE)
-
 #define MACvStart(iobase)						\
 	VNSvOutPortB(iobase + MAC_REG_HOSTCR,				\
 		     (HOSTCR_MACEN | HOSTCR_RXON | HOSTCR_TXON))
@@ -646,18 +619,9 @@ do {								\
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
@@ -678,9 +642,6 @@ do {									\
 		VNSvOutPortD(iobase + MAC_REG_RXDMACTL1, DMACTL_RUN); \
 } while (0)
 
-#define MACvTxOn(iobase)						\
-	MACvRegBitsOn(iobase, MAC_REG_HOSTCR, HOSTCR_TXON)
-
 #define MACvTransmit0(iobase)						\
 do {									\
 	unsigned long dwData;						\
@@ -733,9 +694,6 @@ do {									\
 #define MACvReadMIBCounter(iobase, pdwCounter)			\
 	VNSvInPortD(iobase + MAC_REG_MIBCNTR, pdwCounter)
 
-#define MACvPwrEvntDisable(iobase)					\
-	VNSvOutPortW(iobase + MAC_REG_WAKEUPEN0, 0x0000)
-
 #define MACvEnableProtectMD(iobase)					\
 do {									\
 	unsigned long dwOrgValue;					\
@@ -777,12 +735,6 @@ do {									\
 	VNSvOutPortD(iobase + MAC_REG_ENCFG, dwOrgValue);		\
 } while (0)
 
-#define MACvReadATIMW(iobase, pwCounter)				\
-	VNSvInPortW(iobase + MAC_REG_AIDATIM, pwCounter)
-
-#define MACvWriteATIMW(iobase, wCounter)				\
-	VNSvOutPortW(iobase + MAC_REG_AIDATIM, wCounter)
-
 #define MACvGPIOIn(iobase, pbyValue)					\
 	VNSvInPortB(iobase + MAC_REG_GPIOCTL1, pbyValue)
 
-- 
2.25.1

