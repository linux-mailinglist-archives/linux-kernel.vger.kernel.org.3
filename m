Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A772A49E260
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 13:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbiA0M3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 07:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236262AbiA0M3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 07:29:31 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6FDC061714;
        Thu, 27 Jan 2022 04:29:30 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o64so2787139pjo.2;
        Thu, 27 Jan 2022 04:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=Df2cXxSmkO2s9pXpUhby3GMrF2bLdrg9wsoaVHWzMUM=;
        b=KxK7NE+S+mXEX5orO1iOW14APsGPbD0uhLLhZEAEujZoAdoRFuSL5+OtiBW/p8iUXn
         rLL0aGvQnnjus1pcUBWXbsv/fYvBIe09OdPxE+lxvy9xKgIT9AOxxy5UWkpILqrRZhue
         M6Wh1nEBkYod/he+rrJcJ1kvY4IyIzqafipvwOVV1ZbYD452p3My+cCnTb8cFjr2XSZJ
         WByUXyV6Fsx0iK+QzoMJtwdBvTlPojWdMxqFUGvvYZ9gxJcwqeShATx/9RMoTCnah0hO
         2caYYmiaWJMh4f58DbIMDQqETr3GKS1MTLZ8ydi6SAJSW5mzJPKEN0Be6j63OH4TCUAc
         SZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=Df2cXxSmkO2s9pXpUhby3GMrF2bLdrg9wsoaVHWzMUM=;
        b=rI1bOCJfDjwZjw1dv6KjC4ZkyLyJISAXB5nARlGbiqTpwim4avHi6aI0LI+8beLl1X
         f2U9SDDeNh9gEJ+eVaxM7Ft9QYLmeo39PHgyNd/HUlPVDsADATDzhdqQwuzovAht8mzL
         NgGVM7KqfFcUxd6MnCYmMECG2375/0lkIiayJdNzq2lth/dfrOXocbZZ/jvJxthppc4H
         rffRhlXBfKkw7JG0+irPg7qalXvvlaV128HFMnBet7591YGpL/1RIWkLuQivUz7S20XI
         0u0FK0fOLMMqOqX+/N8T/PtUrG8soZ6B2iKankBH1wFGaMgYRB71De+K4M68ySV+mNV6
         AZFA==
X-Gm-Message-State: AOAM531WUk1w2lNb4j+AB9z+wXwZRXe968BfB1vcLyIoJ0tMY2qHSfYT
        neh+V/bDGvs81PzVKc9+rQg=
X-Google-Smtp-Source: ABdhPJznD1M/6u5dCYTUMJ6rp986/OnrrC+fYL9/d2Ofe5ji5hxVaqM6bThe0dH2XZqbbGUw4JvfDA==
X-Received: by 2002:a17:902:d510:: with SMTP id b16mr3051347plg.40.1643286570494;
        Thu, 27 Jan 2022 04:29:30 -0800 (PST)
Received: from anyang ([106.250.177.234])
        by smtp.gmail.com with ESMTPSA id r14sm6260943pjo.39.2022.01.27.04.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 04:29:30 -0800 (PST)
Date:   Thu, 27 Jan 2022 21:29:25 +0900
From:   Dongjin Kim <tobetter@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: meson-g12b-odroid-n2: fix typo 'dio2133'
Message-ID: <YfKQJejh0bfGYvof@anyang>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Typo in audio amplifier node, dioo2133 -> dio2133

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index aa5898a58b89..120f2551a28b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -22,7 +22,7 @@ aliases {
 		spi0 = &spicc0;
 	};
 
-	dioo2133: audio-amplifier-0 {
+	dio2133: audio-amplifier-0 {
 		compatible = "simple-audio-amplifier";
 		enable-gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
 		VCC-supply = <&vcc_5v>;
@@ -222,7 +222,7 @@ sound {
 		audio-widgets = "Line", "Lineout";
 		audio-aux-devs = <&tdmout_b>, <&tdmout_c>, <&tdmin_a>,
 				 <&tdmin_b>, <&tdmin_c>, <&tdmin_lb>,
-				 <&dioo2133>;
+				 <&dio2133>;
 		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
 				"TDMOUT_B IN 2", "FRDDR_C OUT 1",
-- 
2.32.0

