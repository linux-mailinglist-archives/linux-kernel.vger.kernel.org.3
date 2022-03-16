Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B2C4DB178
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 14:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241784AbiCPNaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 09:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiCPNaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 09:30:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9BE527E8;
        Wed, 16 Mar 2022 06:29:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C776EB81A7A;
        Wed, 16 Mar 2022 13:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF15C340EC;
        Wed, 16 Mar 2022 13:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647437338;
        bh=po9w0srExdqxBbA5Y1GuLMoSzHmbiTZqW8Nx4369bGc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BAaTUiggp7hg19mVJSoejDR0l1MjKoB6c3LlQyGu5G31B9ickEMhr1YrfEKW91tbN
         1q1IUGyg8kgPY/hnzt26WZrfX3FZKJzMr91C64gwOH+Aw/2TjYJ+9kZBiR2OhVLkMp
         iAxVUMytQMIp+M4QtMZ8E/7Xm713K25FwALTykwlEbgWOwL2cyIdcvH76oubsmF0yP
         qQxuOLGxxRpA29g5P8G0S4zsW1GIwpcv6Paon/iSRm+iRIOHYRAom/wDxUN9pK8GNT
         X4B0COuovvmOyF8YkW37iylFjgxqg8Ec1C6lzCvsDgJ5XvzVYXD0sk7L73DMuIiMSy
         rSvS5safB70PQ==
Date:   Wed, 16 Mar 2022 14:28:50 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Hugues FRUCHET - FOSS <hugues.fruchet@foss.st.com>
Cc:     Alain Volmat <alain.volmat@foss.st.com>,
        Niklas =?UTF-8?B?U8O2ZGVybHVu?= =?UTF-8?B?ZA==?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitriy Ulitin <ulitin@ispras.ru>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Leon Romanovsky <leon@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Ming Qian <ming.qian@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 17/24] media: platform: rename stm32/ to sti/stm32/
Message-ID: <20220316142850.6005b09c@coco.lan>
In-Reply-To: <8a4782f3-53d0-7af7-2034-e31879efbc45@foss.st.com>
References: <cover.1647167750.git.mchehab@kernel.org>
        <dc5be62a56ac19c6f49f4c8432558fd7b0efe7e6.1647167750.git.mchehab@kernel.org>
        <20220314083942.GA526468@gnbcxd0016.gnb.st.com>
        <20220314121454.7432e231@coco.lan>
        <1122a956-0650-f948-512b-d3447e34df30@foss.st.com>
        <20220314141008.13e32acd@coco.lan>
        <8a4782f3-53d0-7af7-2034-e31879efbc45@foss.st.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 15 Mar 2022 10:02:53 +0100
Hugues FRUCHET - FOSS <hugues.fruchet@foss.st.com> escreveu:

> Hi Mauro,
> 
> sti and stm32 architectures don't have the same maintainers nor same 
> mailing list as you can see below:
> 
> ARM/STM32 ARCHITECTURE
> M:    Maxime Coquelin <mcoquelin.stm32@gmail.com>
> M:    Alexandre Torgue <alexandre.torgue@foss.st.com>
> L:    linux-stm32@st-md-mailman.stormreply.com (moderated for 
> non-subscribers)
> L:    linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:    Maintained
> T:    git 
> git://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
> F:    arch/arm/boot/dts/stm32*
> F:    arch/arm/mach-stm32/
> F:    drivers/clocksource/armv7m_systick.c
> N:    stm32
> N:    stm
> 
> ARM/STI ARCHITECTURE
> M:    Patrice Chotard <patrice.chotard@foss.st.com>
> L:    linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> S:    Maintained
> W:    http://www.stlinux.com
> F:    Documentation/devicetree/bindings/i2c/i2c-st.txt
> F:    arch/arm/boot/dts/sti*
> F:    arch/arm/mach-sti/
> F:    drivers/ata/ahci_st.c
> F:    drivers/char/hw_random/st-rng.c
> F:    drivers/clocksource/arm_global_timer.c
> F:    drivers/clocksource/clksrc_st_lpc.c
> F:    drivers/cpufreq/sti-cpufreq.c
> F:    drivers/dma/st_fdma*
> F:    drivers/i2c/busses/i2c-st.c
> F:    drivers/media/platform/sti/c8sectpfe/
> F:    drivers/media/rc/st_rc.c
> F:    drivers/mmc/host/sdhci-st.c
> F:    drivers/phy/st/phy-miphy28lp.c
> F:    drivers/phy/st/phy-stih407-usb.c
> F:    drivers/pinctrl/pinctrl-st.c
> F:    drivers/remoteproc/st_remoteproc.c
> F:    drivers/remoteproc/st_slim_rproc.c
> F:    drivers/reset/sti/
> F:    drivers/rtc/rtc-st-lpc.c
> F:    drivers/tty/serial/st-asc.c
> F:    drivers/usb/dwc3/dwc3-st.c
> F:    drivers/usb/host/ehci-st.c
> F:    drivers/usb/host/ohci-st.c
> F:    drivers/watchdog/st_lpc_wdt.c
> F:    include/linux/remoteproc/st_slim_rproc.h

Ok.
	
> but anyway, if this is really important for you to have a top folder to 
> group all ST stuff, we prefer to have "st" prefix than "stm":
>  > 	./drivers/media/platform/st/sti/
>  > 	./drivers/media/platform/st/stm32/

Works for me. Yeah, it is important to have them at the same dir. 
After this series, there's a comment on each platform subdir that
tells what vendor is there. That is meant to help selecting the right
drivers with make menuconfig/gconfig/xconfig, and it is reflected at
the .config file. I'm considering to actually add a submenu per vendor. 
Ether way, if there's more than one directory per vendor, the "comment"
and/or "menuconfig/if/endif" entries would needed to be moved back to the
drivers/media/platform, making in messier again.

Thanks,
Mauro
