Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46AB507352
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354807AbiDSQmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241799AbiDSQlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D30815A2B;
        Tue, 19 Apr 2022 09:39:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D34EF61826;
        Tue, 19 Apr 2022 16:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23EEC385AB;
        Tue, 19 Apr 2022 16:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386346;
        bh=/w2/TuJUuh8aAeAb2m2RYQ0ha5XDa7wX5MqtonXBziw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JSa8soCOWoHbvEvEMCJM5/utpcask8B1DWr5x2vp91tbyaynmX0rTSsEKOTeoQHXR
         xSRS3Xno7rnCUQ3pMwm4mb0C5Nn4Un3kthir4lze9lCf7arGoOqvJyX6s9isYF1BTg
         81xrpPmbsNyOwda4gry9Su9QAWOc6aLDIvSCivZ6D7ALqa5hnnFk8qqp6WGo4H0jz/
         n3cmV2yg+Hsqp/2KBOQWv4OG8fsDhuMeF3RquJVsVmQ3r03jGQ5Jb/kE9Eg+MfTnPV
         0fhh0N+QRSE/UK4kqmfvj+oYMYiI2cyul44m5sN6XHaZpuap2KcE/Ox9+lUvfY7liW
         OcEgijUbKxbQQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     robert.jarzmik@free.fr, linux-arm-kernel@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
        Tomas Cech <sleep_walker@suse.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Helge Deller <deller@gmx.de>, Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-input@vger.kernel.org,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        alsa-devel@alsa-project.org
Subject: [PATCH 02/48] ARM: pxa: make mainstone.h private
Date:   Tue, 19 Apr 2022 18:37:24 +0200
Message-Id: <20220419163810.2118169-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220419163810.2118169-1-arnd@kernel.org>
References: <20220419163810.2118169-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

No driver includes this any more, so don't expose it globally.

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/mainstone.c                    | 2 +-
 arch/arm/mach-pxa/{include/mach => }/mainstone.h | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)
 rename arch/arm/mach-pxa/{include/mach => }/mainstone.h (99%)

diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index d237bd030238..997f6e502201 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -45,7 +45,7 @@
 #include <asm/mach/flash.h>
 
 #include "pxa27x.h"
-#include <mach/mainstone.h>
+#include "mainstone.h"
 #include <mach/audio.h>
 #include <linux/platform_data/video-pxafb.h>
 #include <linux/platform_data/mmc-pxamci.h>
diff --git a/arch/arm/mach-pxa/include/mach/mainstone.h b/arch/arm/mach-pxa/mainstone.h
similarity index 99%
rename from arch/arm/mach-pxa/include/mach/mainstone.h
rename to arch/arm/mach-pxa/mainstone.h
index 1698f2ffd7c7..ba003742e003 100644
--- a/arch/arm/mach-pxa/include/mach/mainstone.h
+++ b/arch/arm/mach-pxa/mainstone.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/mach-pxa/include/mach/mainstone.h
- *
  *  Author:	Nicolas Pitre
  *  Created:	Nov 14, 2002
  *  Copyright:	MontaVista Software Inc.
-- 
2.29.2

