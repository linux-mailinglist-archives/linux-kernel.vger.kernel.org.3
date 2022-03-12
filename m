Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C034D704E
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 19:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbiCLSHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 13:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbiCLSHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 13:07:33 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A4070CDB;
        Sat, 12 Mar 2022 10:06:28 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id q19so10193948pgm.6;
        Sat, 12 Mar 2022 10:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p0GzujtrGM9Z+sUlTt2clDdUTuQkuCPOBQNUOQ7491g=;
        b=JMoKF9I+mRFfMuK0T25u/ur8rVBEIOJGM/i02jlg13o5RMotmChfNNixCR57t0Zye9
         pvn7EzqX0tpt/14Pth37E42Twkvv8+2Wmxi9HIZuPtAh7cCnCQUJO2jYDhj9tw5qvtN2
         is3gU+XiPUjGNazWT1sYwkYyV9MwW2ZfcLeiYG1y6u9+yf/LVavP2eLBmAu+m67a0mCq
         5YOztOkUY65BA3fU9LklrlaFi6hPkAI2knZI+C2pmkVd4D1LWZUb7E+FgSOG3IMoGAF9
         l7fkMBP8iMlVc/p11LkxYMhePEOVs1+CrvFnAhVjJKbjuOmCd8LGw2vK9RtjhfSzPEqc
         UAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p0GzujtrGM9Z+sUlTt2clDdUTuQkuCPOBQNUOQ7491g=;
        b=WE7J/7uQY4N/SV0V5yPc1DstG6iyBESTIyVbHKN/oJ8yGzwkVGCeZujOsAM+/PueGf
         tzwRxtCkXRNqLUjlGr1quiVKhm8BqB37pSe58q4k35zAEvz7skNv4ATzuUILHbjaoavR
         AejaQW8TfB7PrWhg4XAezXShSDcM2rRo5TnP+HJpncijkMuK6Il2MJ44Hn5RHZWAp1k3
         tXJ2mPkI8S7nNqglfJ1+krPsZ13Gjpst2XbMyGaJDnFoS/kxxugQgCC5NA5tgA9xp1sn
         j32LWagO/lGNM9bnMTK2RseKpvuRkQzwsFfuHvxJvFqs4B0a0xGUYTtMGQJ0/Bc7vW9P
         LbNA==
X-Gm-Message-State: AOAM530xllwbty1Kx19Jl1XsKgpY+01kh2KFZbEtJc2MInNhesQzpf9h
        wR2cGIvQBpoXz1eZU3I+hZ1rsem5rYI=
X-Google-Smtp-Source: ABdhPJyF9kO3rvea9Hls8NcNDo5E9gu1t9UmoheAdi6EQE8QSPmyP5CHKblJH4//un/nzAQtzI1eSw==
X-Received: by 2002:a63:4412:0:b0:372:f29e:3108 with SMTP id r18-20020a634412000000b00372f29e3108mr13209087pga.354.1647108387749;
        Sat, 12 Mar 2022 10:06:27 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id z72-20020a627e4b000000b004f70cbcb06esm14017951pfc.49.2022.03.12.10.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 10:06:27 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Vladimir Zapolskiy <vz@mleia.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: lpc18xx: Update SPI dma properties
Date:   Sat, 12 Mar 2022 23:36:15 +0530
Message-Id: <20220312180615.68929-3-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220312180615.68929-1-singh.kuldeep87k@gmail.com>
References: <20220312180615.68929-1-singh.kuldeep87k@gmail.com>
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

SPI pl022 describes dma-names as RX,TX.
Reorder dmas and dma-names properties to follow specified convention.
And while at it, also fix entries order within dma pairs.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
CC: soc@kernel.org
---
 arch/arm/boot/dts/lpc18xx.dtsi | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/lpc18xx.dtsi b/arch/arm/boot/dts/lpc18xx.dtsi
index 10b8249b8ab6..b3070cc927b7 100644
--- a/arch/arm/boot/dts/lpc18xx.dtsi
+++ b/arch/arm/boot/dts/lpc18xx.dtsi
@@ -317,8 +317,7 @@ ssp0: spi@40083000 {
 			clocks = <&ccu2 CLK_APB0_SSP0>, <&ccu1 CLK_CPU_SSP0>;
 			clock-names = "sspclk", "apb_pclk";
 			resets = <&rgu 50>;
-			dmas = <&dmamux  9 0 2
-				&dmamux 10 0 2>;
+			dmas = <&dmamux  10 0 2>, <&dmamux 9 0 2>;
 			dma-names = "rx", "tx";
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -424,16 +423,12 @@ ssp1: spi@400c5000 {
 			clocks = <&ccu2 CLK_APB2_SSP1>, <&ccu1 CLK_CPU_SSP1>;
 			clock-names = "sspclk", "apb_pclk";
 			resets = <&rgu 51>;
-			dmas = <&dmamux 11 2 2
-				&dmamux 12 2 2
-				&dmamux  3 3 2
-				&dmamux  4 3 2
-				&dmamux  5 2 2
-				&dmamux  6 2 2
-				&dmamux 13 2 2
-				&dmamux 14 2 2>;
-			dma-names = "rx", "tx", "tx", "rx",
-				    "tx", "rx", "rx", "tx";
+			dmas = <&dmamux 12 2 2>, <&dmamux 11 2 2>,
+					<&dmamux  4 3 2>, <&dmamux  3 3 2>,
+					<&dmamux  6 2 2>, <&dmamux  5 2 2>,
+					<&dmamux 14 2 2>, <&dmamux 13 2 2>;
+			dma-names = "rx", "tx", "rx", "tx",
+						"rx", "tx", "rx", "tx";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
-- 
2.25.1

