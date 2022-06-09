Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E851B5445A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240647AbiFIIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240646AbiFIIYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:24:43 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22C41285F2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:24:41 -0700 (PDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B53B33F218
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1654763080;
        bh=Gxx/jGLU2uWuojMM52X0Si8qfwqQ7pBHCgTCq74hS8A=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=h6Ff1dJxmyG8Qz1/mkhKabmernmAhushdqveSiLy7Jfd1LYjBk6L0MynH5IJa2r1J
         SUKChvwy1Btg/EaarZ55qpOLtuaZmtEFDftDkXSZzD3NebNcLrfL0P4mH+DyYeMho5
         fXlWsQMYPadNCPlpJU5MsXS/bSZn1crwK9EuM1ojSwxxkBboqxAaMS8TTZ8gypDDZo
         Sa+MtcRqx341aLQ+jWQZCZCQiD3qkANrA/5Os1th2uZuKjuahP3xJcUkwuwGIgLvvL
         Lp7z395ImjXvGMcrloXTE+hKBii4Z1fQvcihXNuqus65XiYU3viEgldT84G82k6Ulu
         9vBH/mSqHVzEg==
Received: by mail-ej1-f72.google.com with SMTP id t15-20020a1709066bcf00b0070dedeacb2cso7701628ejs.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 01:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gxx/jGLU2uWuojMM52X0Si8qfwqQ7pBHCgTCq74hS8A=;
        b=R+uO47Sib9ap7ElwUDuzKFSXKZ7qz7GS6sbKYyESFWnIY2Nk3zL2iesS6WfDCzc6oY
         iHvCDcNXmVNtQ2wXupxVaShDggsmLIBBUkFMXej7CPdHoT+oot8V2gz4EsjC1f8cMXas
         urmpORorO4KZRVJreVTDdf1Zc89aXQdYK/a9G+O5NuaYTjtRMlk3x+Rt8x9bXdF28+/J
         Oek8T9bCHvmFNB2qzlk7PAX0akW6/MuGN32Mf0Qret0wTCNUbUXbOY67WqiOVGPgonVa
         T7pmRIvbSPU/zUG4qNdMWoBAj1+RbgcTKosUayIO1b4zVbg5uU2wfUuRgxzQkg1FYAes
         uHbw==
X-Gm-Message-State: AOAM530VsIJcJGBFOgnnIwCnJxjwKRvoBtueVwfjEBp0R32lID03unK4
        CvZy+g7rT3oJhhtuSIU4MjhFYkJD9qw3tzCpq9wgYF8MhCgd5ogrJpeFbLsTAz4d9v9+xpx8njl
        E8kHgMDqLdcVVqFoRUV1RAtAkZxQ5uRe3OMR+3zYo3A==
X-Received: by 2002:a17:907:62a0:b0:6fe:69f3:88de with SMTP id nd32-20020a17090762a000b006fe69f388demr34191136ejc.214.1654763080515;
        Thu, 09 Jun 2022 01:24:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH7dJNNrYBVVMz0J81cvqdVsYLt67yWfEsDM6DtN4gQ8PLXWao4fH9CEALeu730tUBdNZoaQ==
X-Received: by 2002:a17:907:62a0:b0:6fe:69f3:88de with SMTP id nd32-20020a17090762a000b006fe69f388demr34191119ejc.214.1654763080324;
        Thu, 09 Jun 2022 01:24:40 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id v9-20020a170906380900b00711d546f8a8sm4664834ejc.139.2022.06.09.01.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 01:24:39 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     krzysztof.kozlowski@linaro.org, linux@armlinux.org.uk,
        alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 2/3 v3] ARM: s3c: Kconfig.s3c24xx: Fix indentation and replace some tabs
Date:   Thu,  9 Jun 2022 10:21:53 +0200
Message-Id: <20220609082154.115301-3-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220609082154.115301-1-juerg.haefliger@canonical.com>
References: <63eabd40-761e-3b4e-c1be-43a12516e1b0@linaro.org>
 <20220609082154.115301-1-juerg.haefliger@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

While add it, replace tabs before comments with whitespaces (which seems to
be more common), add a missing trailing endif comment and squeeze multiple
empty lines.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
v2:
  Mention additional changes in the commit message.  
---
 arch/arm/mach-s3c/Kconfig.s3c24xx | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-s3c/Kconfig.s3c24xx b/arch/arm/mach-s3c/Kconfig.s3c24xx
index 662c5aec2ea3..ba8f4f7101de 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c24xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c24xx
@@ -37,8 +37,6 @@ config PLAT_S3C24XX
 	help
 	  Base platform code for any Samsung S3C24XX device
 
-
-
 menu "Samsung S3C24XX SoCs Support"
 
 comment "S3C24XX SoCs"
@@ -293,7 +291,7 @@ config MACH_VR1000
 	help
 	  Say Y here if you are using the Thorcom VR1000 board.
 
-endif	# CPU_S3C2410
+endif # CPU_S3C2410
 
 config S3C2412_PM_SLEEP
 	bool
@@ -367,7 +365,7 @@ config MACH_VSTMS
 	help
 	  Say Y here if you are using an VSTMS board
 
-endif	# CPU_S3C2412
+endif # CPU_S3C2412
 
 if CPU_S3C2416
 
@@ -415,7 +413,7 @@ config MACH_S3C2416_DT
 	  Note: This is under development and not all peripherals can be supported
 	  with this machine file.
 
-endif	# CPU_S3C2416
+endif # CPU_S3C2416
 
 if CPU_S3C2440 || CPU_S3C2442
 
@@ -444,7 +442,7 @@ config S3C2440_PLL_16934400
 	default y if S3C24XX_PLL
 	help
 	  PLL tables for S3C2440 or S3C2442 CPUs with 16.934MHz crystals.
-endif
+endif # CPU_S3C2440 || CPU_S3C2442
 
 if CPU_S3C2440
 
@@ -540,7 +538,7 @@ config SMDK2440_CPU2440
 	default y if ARCH_S3C2440
 	select S3C2440_XTAL_16934400
 
-endif	# CPU_S3C2440
+endif # CPU_S3C2440
 
 if CPU_S3C2442
 
@@ -559,7 +557,7 @@ config MACH_NEO1973_GTA02
 	select POWER_SUPPLY
 	select S3C_DEV_USB_HOST
 	help
-	   Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
+	  Say Y here if you are using the Openmoko GTA02 / Freerunner GSM Phone
 
 config MACH_RX1950
 	bool "HP iPAQ rx1950"
@@ -570,9 +568,9 @@ config MACH_RX1950
 	select S3C2440_XTAL_16934400
 	select S3C_DEV_NAND
 	help
-	   Say Y here if you're using HP iPAQ rx1950
+	  Say Y here if you're using HP iPAQ rx1950
 
-endif	# CPU_S3C2442
+endif # CPU_S3C2442
 
 if CPU_S3C2443 || CPU_S3C2416
 
@@ -581,7 +579,7 @@ config S3C2443_SETUP_SPI
 	help
 	  Common setup code for SPI GPIO configurations
 
-endif	# CPU_S3C2443 || CPU_S3C2416
+endif # CPU_S3C2443 || CPU_S3C2416
 
 if CPU_S3C2443
 
@@ -594,13 +592,13 @@ config MACH_SMDK2443
 	help
 	  Say Y here if you are using an SMDK2443
 
-endif	# CPU_S3C2443
+endif # CPU_S3C2443
 
 config PM_H1940
 	bool
 	help
 	  Internal node for H1940 and related PM
 
-endmenu	# Samsung S3C24XX SoCs Support
+endmenu # "Samsung S3C24XX SoCs Support"
 
-endif	# ARCH_S3C24XX
+endif # ARCH_S3C24XX
-- 
2.32.0

