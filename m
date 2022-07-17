Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E32577892
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 00:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiGQWUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 18:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiGQWUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 18:20:12 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85C01274D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:20:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j22so18327600ejs.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ER+wlmwgWW3cJhjmYLRX0mj3AW4fGnQUl6MKua+ERA0=;
        b=egnh8gJ6gvdtwfYwLGH1oxRefUzeuZsf7BuZk3+wRnNACbIgkzrFq71omHmwltzKMM
         9bzHf6J1HCms1r04n6s6K4M3WpzWCkIF+H/eASzYyDLrT685Ugpsx5Jwcqvur/ZtbrGe
         c5P8FX6nVMIzVLKGazf97Je09F20bAmkxzT9Ak+kIDwS2SASqDNrm8Xjza8ENxKaqwvw
         yAnhHBgQBuHw35P6eY5BpMMhkUFuvGXAi2vnRDFdK70fPcy7y4IbWzEsBqjX7zpHKh8n
         K7wqtXcInI3Z4KTU54FkNsTbrmnHdJcgaIicYRtV0SwbszeC3ZVo8dAUE+tsJ1AssxCG
         EmuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ER+wlmwgWW3cJhjmYLRX0mj3AW4fGnQUl6MKua+ERA0=;
        b=ivmY6g0A29osRZw7SWL2+M1nOeRP+Q1VEEqc6MT3PQahxffsmk2Ej0rqh72RFJnfKa
         bE4ka/jx7BTdPv7tnYXrCRHri7roNqAOn1X2HpvY6L4PxTE3Asz4Ys6o6Hox0GSNoFdg
         ZD8IIy0rnlx7l9kAmhGl2TMWYPn06gLaZgetMkOcPq2FoP7hEpAANr36SusR6z4bn9H2
         Uoix0ioUv6zr+LIvZh1VUq8ncn3R56cRpCCt0vefxRVVYk4CWIgBF8bep/QULOrZXLUU
         pkoNXQm+Zp7TbEFUqr75IrqVa7q3QZ/lfD00mmhz8BkkAQWQywph1ZGovRjjj+JvCEls
         32qw==
X-Gm-Message-State: AJIora+qVkRxXGAhJBEhwuKUppHyX1W+4eD0rpYqeLfut7rOQvXTNE6F
        OOopNopQ3dhlORXSZcdBtCI=
X-Google-Smtp-Source: AGRyM1uDFea9JW//11M9yCM7Lw/U2tgXSLxucFib47swRpXoGt0xgvh4znDtoHqMnYd/dQ/d3ds14A==
X-Received: by 2002:a17:906:216:b0:711:f623:8bb0 with SMTP id 22-20020a170906021600b00711f6238bb0mr24012671ejd.174.1658096410414;
        Sun, 17 Jul 2022 15:20:10 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p54a07b82.dip0.t-ipconnect.de. [84.160.123.130])
        by smtp.gmail.com with ESMTPSA id f8-20020a056402160800b0043b0cd89d99sm7427924edv.32.2022.07.17.15.20.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 15:20:09 -0700 (PDT)
Date:   Mon, 18 Jul 2022 00:20:08 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] staging: vt6655: Rename dwData to reg_value in four
 macros
Message-ID: <b54577316eebdbb54e478fc51473eeba9d7eacae.1658094708.git.philipp.g.hortmann@gmail.com>
References: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1658094708.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix name of a variable in four macros that use CamelCase which is not
accepted by checkpatch.pl

Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
---
 drivers/staging/vt6655/mac.h | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
index b307161818a0..bfcbeb96f839 100644
--- a/drivers/staging/vt6655/mac.h
+++ b/drivers/staging/vt6655/mac.h
@@ -539,9 +539,9 @@
 
 #define MACvReceive0(iobase)						\
 do {									\
-	unsigned long dwData;						\
-	dwData = ioread32(iobase + MAC_REG_RXDMACTL0);			\
-	if (dwData & DMACTL_RUN)					\
+	unsigned long reg_value;					\
+	reg_value = ioread32(iobase + MAC_REG_RXDMACTL0);		\
+	if (reg_value & DMACTL_RUN)					\
 		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL0);	\
 	else								\
 		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL0);	\
@@ -549,9 +549,9 @@ do {									\
 
 #define MACvReceive1(iobase)						\
 do {									\
-	unsigned long dwData;						\
-	dwData = ioread32(iobase + MAC_REG_RXDMACTL1);			\
-	if (dwData & DMACTL_RUN)					\
+	unsigned long reg_value;					\
+	reg_value = ioread32(iobase + MAC_REG_RXDMACTL1);		\
+	if (reg_value & DMACTL_RUN)					\
 		iowrite32(DMACTL_WAKE, iobase + MAC_REG_RXDMACTL1);	\
 	else								\
 		iowrite32(DMACTL_RUN, iobase + MAC_REG_RXDMACTL1);	\
@@ -559,9 +559,9 @@ do {									\
 
 #define MACvTransmit0(iobase)						\
 do {									\
-	unsigned long dwData;						\
-	dwData = ioread32(iobase + MAC_REG_TXDMACTL0);			\
-	if (dwData & DMACTL_RUN)					\
+	unsigned long reg_value;					\
+	reg_value = ioread32(iobase + MAC_REG_TXDMACTL0);		\
+	if (reg_value & DMACTL_RUN)					\
 		iowrite32(DMACTL_WAKE, iobase + MAC_REG_TXDMACTL0);	\
 	else								\
 		iowrite32(DMACTL_RUN, iobase + MAC_REG_TXDMACTL0);	\
@@ -569,9 +569,9 @@ do {									\
 
 #define MACvTransmitAC0(iobase)					\
 do {									\
-	unsigned long dwData;						\
-	dwData = ioread32(iobase + MAC_REG_AC0DMACTL);			\
-	if (dwData & DMACTL_RUN)					\
+	unsigned long reg_value;					\
+	reg_value = ioread32(iobase + MAC_REG_AC0DMACTL);		\
+	if (reg_value & DMACTL_RUN)					\
 		iowrite32(DMACTL_WAKE, iobase + MAC_REG_AC0DMACTL);	\
 	else								\
 		iowrite32(DMACTL_RUN, iobase + MAC_REG_AC0DMACTL);	\
-- 
2.37.1

