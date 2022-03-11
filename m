Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6BB4D5FC7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348111AbiCKKi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:38:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348090AbiCKKhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:37:55 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A6F1C232A;
        Fri, 11 Mar 2022 02:36:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b8so7792972pjb.4;
        Fri, 11 Mar 2022 02:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EP/SVWsoRg9qx+eTBIrNOE+5ZwuyKTmThSiBQtkA/sk=;
        b=mdi8s0LYAMdHFiZZwJ2tNK6B+uPloNGuk13iXDTS7oFdjDkpBkILTKVnb6k5KaVWbD
         VBxiIO/pPsUrs7rCFI1/k8BovDJGhHfHO7D+Bg4/w40sVDu5A9dLlFT3kjw40clHppbB
         xHIoaZ+pdpt6nzgWpafrI8T1kGCC2uVIEOGS/BqG1WJq+AhhBsuUdQSG80ztXEDvXP5N
         dkUVdvHDLgwHPPcWJBoaEZgA2TBOBVQsuNs5j7niONcjz8a+rRMlPKEsbrjVIYeJ2yvn
         mN4FwaZjCBlWs74/H+o6IgF4+l4rqttZewlyOb8b69L252zQgt4SOwZLIVWlwIPhVhU+
         cY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EP/SVWsoRg9qx+eTBIrNOE+5ZwuyKTmThSiBQtkA/sk=;
        b=wCX0Kt5D+U9W8gj7qgsIRj/GRAC9m3Oy94MrJ20AORi8T6kX5sdAQcEK/Fnbv1G5ri
         vpwqwbQmoS1TM7pNbd409LcBAdTipKlvcl6O+tH1T6b61L/iWia0LPJV6QWfbeAsooEX
         6dFLi7I1otC2BNf4LcsOxdq+wZdSW8Nabn1H7bb9l57ZqL6msohgyZAjZ+aFNXX8oYqN
         Qz9MNetTsd21Ent5VYAdNQWjEVDOXlYLkjB3dmHWc0v/c3SatKOnalW1lH18CKGs5dJC
         Hy4wjcvme99wrpmLGhOPurK+++6d4ufQ21VKTRHg92o7/uLezG/pJ+l+RiTZTB+Bge+x
         TCvQ==
X-Gm-Message-State: AOAM530yYryYYJn9DXfW85sg1WN9DxvZHncWTh35JYGLmSdZ19lugId8
        8RkJS3JtYn8QEv8YXPEFe60=
X-Google-Smtp-Source: ABdhPJzw4L706pa8K1vQiMZhHMt5+ByC0r9wN80pe2K0eIk6HJIjKXy1D13BmT0Ss/q1qOAzHUfXnA==
X-Received: by 2002:a17:903:248f:b0:14f:acf5:a5c2 with SMTP id p15-20020a170903248f00b0014facf5a5c2mr9484771plw.167.1646995010506;
        Fri, 11 Mar 2022 02:36:50 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id u10-20020a63b54a000000b00380ea901cd2sm4445892pgo.6.2022.03.11.02.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 02:36:50 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: dts: ste-dbx: Update spi clock name
Date:   Fri, 11 Mar 2022 16:06:35 +0530
Message-Id: <20220311103635.39849-5-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220311103635.39849-1-singh.kuldeep87k@gmail.com>
References: <20220311103635.39849-1-singh.kuldeep87k@gmail.com>
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

SPI clock for pl022 is "sspclk" and meanwhile ST Ericsson platform
specify "SSPCLK" as clock name. Even though binding check don't
differentiate the two names, better to keep same convention throughout
i.e sspclk to align with other platforms.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
v2:
- Separate out patches for various platforms
- Rebase to top

 arch/arm/boot/dts/ste-dbx5x0.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index dc0bcc7020f1..c28b32640254 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -755,7 +755,7 @@ ssp0: spi@80002000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&prcc_kclk 3 1>, <&prcc_pclk 3 1>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 8 0 0x2>, /* Logical - DevToMem */
 			       <&dma 8 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -772,7 +772,7 @@ ssp1: spi@80003000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			clocks = <&prcc_kclk 3 2>, <&prcc_pclk 3 2>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 9 0 0x2>, /* Logical - DevToMem */
 			       <&dma 9 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -790,7 +790,7 @@ spi0: spi@8011a000 {
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 2 8>, <&prcc_pclk 2 8>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 0 0 0x2>, /* Logical - DevToMem */
 			       <&dma 0 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -807,7 +807,7 @@ spi1: spi@80112000 {
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 2 2>, <&prcc_pclk 2 2>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 35 0 0x2>, /* Logical - DevToMem */
 			       <&dma 35 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -824,7 +824,7 @@ spi2: spi@80111000 {
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 2 1>, <&prcc_pclk 2 1>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 33 0 0x2>, /* Logical - DevToMem */
 			       <&dma 33 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
@@ -841,7 +841,7 @@ spi3: spi@80129000 {
 			#size-cells = <0>;
 			/* Same clock wired to kernel and pclk */
 			clocks = <&prcc_pclk 1 7>, <&prcc_pclk 1 7>;
-			clock-names = "SSPCLK", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			dmas = <&dma 40 0 0x2>, /* Logical - DevToMem */
 			       <&dma 40 0 0x0>; /* Logical - MemToDev */
 			dma-names = "rx", "tx";
-- 
2.25.1

