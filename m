Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8BB553A006
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350917AbiFAJEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244708AbiFAJEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:04:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F6B8E1BF;
        Wed,  1 Jun 2022 02:04:48 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k19so1383830wrd.8;
        Wed, 01 Jun 2022 02:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=wtRkBI0Hmgo17iTt9HbMbkovhjGDzKXn4k4Ag8EmbDs=;
        b=T9Jr30mV5o1fZ7eMzur41l8EhcmpgIPdBv+q33WhNs2fEKVUPIB5j5nWZrYp2WrO86
         UfGGszHKPJ5yYdbRLC57TflFi0LD2KPDyC3B27J3jDCJr5FJ2oh54Qvqh4Yhjk22T+xk
         opbwMtMlp729F4Eicp066HeW5L8woINBY7uQHHUpBL1eY4sdEZeS/ImdWD9n6H+2H/nM
         204OfFqY4OPRohx8Qsa8vp7P3/RB/yh4r70xZVHCLiO8io1JxvKJUHQyyd9JjS7FwAeo
         bEjEM7cqZQDkTjuuj0QFlHdGF4ajthX4RF2zn3M0uXbkixzvAdAtgoOQd+1/RMHrloy9
         r36A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wtRkBI0Hmgo17iTt9HbMbkovhjGDzKXn4k4Ag8EmbDs=;
        b=72SoNtOMLNJUXG5GZlN3c6DGZF/YJH2KCF2XXekT4oyJKZbFUEzMaBvOqBqx+aTUMA
         aeuMll9CEv71Us2EdTsFfmJezFiw3ircEsKAhZgjijo7ksGb/BkUUrnLSchQlRq8wCLX
         okpK+LxWDR0MSrSowQL9RTXzX6ZD9+KfpyHwxxSfU9gMjYLzp+D5+w3RP+v716Zldi2g
         wmFapNX0lTSPsS2pLf1Qf5N5zkOKDPIOyNceH2YqksI961CyT2LhPBXHLavu9HEhkyM2
         oGZK7ZVGY5jmJanSL/pLDSZZHA79LFQfJx+NuS+s7eeyJFQteg+spmtzo0358V/qiTDF
         RSmQ==
X-Gm-Message-State: AOAM531/1PrsvsmqEkgDBSqh1QudErGkFLvSklTv2S4/pIdo5quH+3Cl
        BTjShS7g9xqJWzfta2jw1Qs=
X-Google-Smtp-Source: ABdhPJzw4+VssDVUfhNUnSXMWr3ktT/G2G5DrywiGpRcQRiNV7zxmOhjBFlm4Dremch2DVHG/302TQ==
X-Received: by 2002:a05:6000:1812:b0:210:2eb1:4606 with SMTP id m18-20020a056000181200b002102eb14606mr14551109wrh.593.1654074287103;
        Wed, 01 Jun 2022 02:04:47 -0700 (PDT)
Received: from felia.fritz.box (200116b82620c00028af88788fa7d286.dip.versatel-1u1.de. [2001:16b8:2620:c000:28af:8878:8fa7:d286])
        by smtp.gmail.com with ESMTPSA id i23-20020a1c5417000000b00394708a3d7dsm4528458wmb.15.2022.06.01.02.04.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 02:04:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: update file entries after arm multi-platform rework
Date:   Wed,  1 Jun 2022 11:04:29 +0200
Message-Id: <20220601090429.4697-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the work of Arnd's arm multi-platform support, various files in arch/arm
are moved:

  Files in arch/arm/mach-ep93xx/include/mach/ are made local:
    arch/arm/{mach-ep93xx/include/mach/uncompress.h => boot/compressed/misc-ep93xx.h}
    arch/arm/mach-ep93xx/{include/mach => }/ep93xx-regs.h
    arch/arm/mach-ep93xx/{include/mach => }/mach/irqs.h

  Files in arch/arm/mach-vexpress/ are moved to mach-versatile.

  Files in arch/arm/plat-omap/ are split into arch/arm/mach-omap{1,2}/.

  Files in arch/arm/mach-pxa/include/mach/ are made local.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about some
broken references.

Correct all those references accordingly after this refactoring.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Arnd, please pick this minor non-urgent clean-up patch.

 MAINTAINERS | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8eee9d2aea5..1d0249e2acfc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1952,8 +1952,8 @@ M:	Hartley Sweeten <hsweeten@visionengravers.com>
 M:	Alexander Sverdlin <alexander.sverdlin@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
+F:	arch/arm/boot/compressed/misc-ep93xx.h
 F:	arch/arm/mach-ep93xx/
-F:	arch/arm/mach-ep93xx/include/mach/
 
 ARM/CLKDEV SUPPORT
 M:	Russell King <linux@armlinux.org.uk>
@@ -2114,8 +2114,7 @@ M:	Philipp Zabel <philipp.zabel@gmail.com>
 M:	Paul Parsons <lost.distance@yahoo.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/mach-pxa/hx4700.c
-F:	arch/arm/mach-pxa/include/mach/hx4700.h
+F:	arch/arm/mach-pxa/hx4700.[ch]
 F:	sound/soc/pxa/hx4700.c
 
 ARM/HISILICON SOC SUPPORT
@@ -2508,14 +2507,11 @@ M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://hackndev.com
-F:	arch/arm/mach-pxa/include/mach/palmld.h
-F:	arch/arm/mach-pxa/include/mach/palmtc.h
-F:	arch/arm/mach-pxa/include/mach/palmtx.h
-F:	arch/arm/mach-pxa/palmld.c
+F:	arch/arm/mach-pxa/palmld.*
 F:	arch/arm/mach-pxa/palmt5.*
-F:	arch/arm/mach-pxa/palmtc.c
+F:	arch/arm/mach-pxa/palmtc.*
 F:	arch/arm/mach-pxa/palmte2.*
-F:	arch/arm/mach-pxa/palmtx.c
+F:	arch/arm/mach-pxa/palmtx.*
 
 ARM/PALMZ72 SUPPORT
 M:	Sergey Lapin <slapin@ossfans.org>
@@ -2968,7 +2964,7 @@ S:	Maintained
 F:	*/*/*/vexpress*
 F:	*/*/vexpress*
 F:	arch/arm/boot/dts/vexpress*
-F:	arch/arm/mach-vexpress/
+F:	arch/arm/mach-versatile/
 F:	arch/arm64/boot/dts/arm/
 F:	drivers/clk/versatile/clk-vexpress-osc.c
 F:	drivers/clocksource/timer-versatile.c
@@ -2985,8 +2981,7 @@ ARM/VOIPAC PXA270 SUPPORT
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/mach-pxa/include/mach/vpac270.h
-F:	arch/arm/mach-pxa/vpac270.c
+F:	arch/arm/mach-pxa/vpac270*
 
 ARM/VT8500 ARM ARCHITECTURE
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -3009,8 +3004,7 @@ ARM/ZIPIT Z2 SUPPORT
 M:	Marek Vasut <marek.vasut@gmail.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-F:	arch/arm/mach-pxa/include/mach/z2.h
-F:	arch/arm/mach-pxa/z2.c
+F:	arch/arm/mach-pxa/z2.[ch]
 
 ARM/ZYNQ ARCHITECTURE
 M:	Michal Simek <michal.simek@xilinx.com>
@@ -14554,7 +14548,6 @@ Q:	http://patchwork.kernel.org/project/linux-omap/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
 F:	arch/arm/configs/omap1_defconfig
 F:	arch/arm/mach-omap1/
-F:	arch/arm/plat-omap/
 F:	drivers/i2c/busses/i2c-omap.c
 F:	include/linux/platform_data/ams-delta-fiq.h
 F:	include/linux/platform_data/i2c-omap.h
@@ -14569,7 +14562,6 @@ Q:	http://patchwork.kernel.org/project/linux-omap/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
 F:	arch/arm/configs/omap2plus_defconfig
 F:	arch/arm/mach-omap2/
-F:	arch/arm/plat-omap/
 F:	drivers/bus/ti-sysc.c
 F:	drivers/i2c/busses/i2c-omap.c
 F:	drivers/irqchip/irq-omap-intc.c
-- 
2.17.1

