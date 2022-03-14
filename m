Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616A44D807E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbiCNLQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbiCNLQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:16:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5FD2BB09;
        Mon, 14 Mar 2022 04:15:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A80561032;
        Mon, 14 Mar 2022 11:15:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002A7C340E9;
        Mon, 14 Mar 2022 11:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647256502;
        bh=6yfUzUx3hzhPLIDF1CvX2NqY/lQlucJQRif0H041xoM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JfsA9q7MChAN4Exx0ZM5p0ou/V36b2anrh4NydF3HuEht2vVdDy6SbKIK4ushDc5g
         XMYAPJubg4ZWzkZQHBK2ZCafD3qm9a80z3MYIrYTM/Tw+CNJZsDYxmrRo89r7o41mg
         +cMmjl5TFpzivAY9Nho//Nd2ltc/a5C2iWqwySqynt92Evbnm27hGysFPTG8WDN4Av
         KECWdDfiSUVM+WObt8KtRuZRZgiMbxIrmYPtU0Dfe/WKz16ohV9HQDSWM3xpMSzww5
         2f2bxuu8VJELYvi7KPucNraoYP5G4thvLnXChc757hE32zEFT1lXGUg8pRbrQUnmnR
         Jkox7Ke6tCZqQ==
Date:   Mon, 14 Mar 2022 12:14:54 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Alain Volmat <alain.volmat@foss.st.com>
Cc:     Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Dillon Min <dillon.minfei@gmail.com>,
        Dmitriy Ulitin <ulitin@ispras.ru>,
        Dmitry Osipenko <digetx@gmail.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Hugues Fruchet <hugues.fruchet@foss.st.com>,
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
Message-ID: <20220314121454.7432e231@coco.lan>
In-Reply-To: <20220314083942.GA526468@gnbcxd0016.gnb.st.com>
References: <cover.1647167750.git.mchehab@kernel.org>
        <dc5be62a56ac19c6f49f4c8432558fd7b0efe7e6.1647167750.git.mchehab@kernel.org>
        <20220314083942.GA526468@gnbcxd0016.gnb.st.com>
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

Hi Alain,

Em Mon, 14 Mar 2022 09:39:42 +0100
Alain Volmat <alain.volmat@foss.st.com> escreveu:

> Hi Mauro,
> 
> I don't think stm32 should be put within the sti platform folder.
> sti and stm32 are 2 different platforms from ST Microelectronics.
> STi refers to the platform with SoCs such as STiH407/STiH410 and STiH418
> while stm32 are all STM32 ones. Those two platforms aren't related.
> What about having a folder stmicro or stmicroelectronics (too long
> probably :D) with the 2 folders sti and stm32 into it ?

Yeah, a folder like "st", "stm" (New York Stock Exchange uses this name),
"stmicro", or even "stmicroelectronics" with either two folders on it
or two separate submenus work from my side.

I would prefer to have a short name there, like "st" or "stm", but it
is up to you to choose whatever works best for ST Microelectronics.

Just let me know what works best and I'll change it at the patch.

> 
> Alain
> 
> On Sun, Mar 13, 2022 at 11:51:58AM +0100, Mauro Carvalho Chehab wrote:
> > As the end goal is to have platform drivers split by vendor,
> > rename stm32/ to sti/stm32/.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> > ---
> > 
> > To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH 00/24] at: https://lore.kernel.org/all/cover.1647167750.git.mchehab@kernel.org/
> > 
> >  MAINTAINERS                                               | 2 +-
> >  drivers/media/platform/Kconfig                            | 2 +-
> >  drivers/media/platform/Makefile                           | 2 +-
> >  drivers/media/platform/{ => sti}/stm32/Kconfig            | 0
> >  drivers/media/platform/{ => sti}/stm32/Makefile           | 0
> >  drivers/media/platform/{ => sti}/stm32/dma2d/dma2d-hw.c   | 0
> >  drivers/media/platform/{ => sti}/stm32/dma2d/dma2d-regs.h | 0
> >  drivers/media/platform/{ => sti}/stm32/dma2d/dma2d.c      | 0
> >  drivers/media/platform/{ => sti}/stm32/dma2d/dma2d.h      | 0
> >  drivers/media/platform/{ => sti}/stm32/stm32-dcmi.c       | 0
> >  10 files changed, 3 insertions(+), 3 deletions(-)
> >  rename drivers/media/platform/{ => sti}/stm32/Kconfig (100%)
> >  rename drivers/media/platform/{ => sti}/stm32/Makefile (100%)
> >  rename drivers/media/platform/{ => sti}/stm32/dma2d/dma2d-hw.c (100%)
> >  rename drivers/media/platform/{ => sti}/stm32/dma2d/dma2d-regs.h (100%)
> >  rename drivers/media/platform/{ => sti}/stm32/dma2d/dma2d.c (100%)
> >  rename drivers/media/platform/{ => sti}/stm32/dma2d/dma2d.h (100%)
> >  rename drivers/media/platform/{ => sti}/stm32/stm32-dcmi.c (100%)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7711a5ea125e..620705e0f043 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -12046,7 +12046,7 @@ L:	linux-media@vger.kernel.org
> >  S:	Supported
> >  T:	git git://linuxtv.org/media_tree.git
> >  F:	Documentation/devicetree/bindings/media/st,stm32-dcmi.yaml
> > -F:	drivers/media/platform/stm32/stm32-dcmi.c
> > +F:	drivers/media/platform/sti/stm32/stm32-dcmi.c
> >  
> >  MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
> >  M:	Mauro Carvalho Chehab <mchehab@kernel.org>
> > diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> > index c3594807f8d7..cf373bfbca1b 100644
> > --- a/drivers/media/platform/Kconfig
> > +++ b/drivers/media/platform/Kconfig
> > @@ -95,7 +95,7 @@ source "drivers/media/platform/samsung/s5p-g2d/Kconfig"
> >  source "drivers/media/platform/samsung/s5p-jpeg/Kconfig"
> >  source "drivers/media/platform/samsung/s5p-mfc/Kconfig"
> >  source "drivers/media/platform/sti/Kconfig"
> > -source "drivers/media/platform/stm32/Kconfig"
> > +source "drivers/media/platform/sti/stm32/Kconfig"
> >  source "drivers/media/platform/ti-vpe/Kconfig"
> >  source "drivers/media/platform/via/Kconfig"
> >  source "drivers/media/platform/xilinx/Kconfig"
> > diff --git a/drivers/media/platform/Makefile b/drivers/media/platform/Makefile
> > index 6a766acfbe37..e3dd2331003a 100644
> > --- a/drivers/media/platform/Makefile
> > +++ b/drivers/media/platform/Makefile
> > @@ -40,7 +40,7 @@ obj-y += sti/bdisp/
> >  obj-y += sti/c8sectpfe/
> >  obj-y += sti/delta/
> >  obj-y += sti/hva/
> > -obj-y += stm32/
> > +obj-y += sti/stm32/
> >  obj-y += ti-vpe/
> >  obj-y += via/
> >  obj-y += xilinx/
> > diff --git a/drivers/media/platform/stm32/Kconfig b/drivers/media/platform/sti/stm32/Kconfig
> > similarity index 100%
> > rename from drivers/media/platform/stm32/Kconfig
> > rename to drivers/media/platform/sti/stm32/Kconfig
> > diff --git a/drivers/media/platform/stm32/Makefile b/drivers/media/platform/sti/stm32/Makefile
> > similarity index 100%
> > rename from drivers/media/platform/stm32/Makefile
> > rename to drivers/media/platform/sti/stm32/Makefile
> > diff --git a/drivers/media/platform/stm32/dma2d/dma2d-hw.c b/drivers/media/platform/sti/stm32/dma2d/dma2d-hw.c
> > similarity index 100%
> > rename from drivers/media/platform/stm32/dma2d/dma2d-hw.c
> > rename to drivers/media/platform/sti/stm32/dma2d/dma2d-hw.c
> > diff --git a/drivers/media/platform/stm32/dma2d/dma2d-regs.h b/drivers/media/platform/sti/stm32/dma2d/dma2d-regs.h
> > similarity index 100%
> > rename from drivers/media/platform/stm32/dma2d/dma2d-regs.h
> > rename to drivers/media/platform/sti/stm32/dma2d/dma2d-regs.h
> > diff --git a/drivers/media/platform/stm32/dma2d/dma2d.c b/drivers/media/platform/sti/stm32/dma2d/dma2d.c
> > similarity index 100%
> > rename from drivers/media/platform/stm32/dma2d/dma2d.c
> > rename to drivers/media/platform/sti/stm32/dma2d/dma2d.c
> > diff --git a/drivers/media/platform/stm32/dma2d/dma2d.h b/drivers/media/platform/sti/stm32/dma2d/dma2d.h
> > similarity index 100%
> > rename from drivers/media/platform/stm32/dma2d/dma2d.h
> > rename to drivers/media/platform/sti/stm32/dma2d/dma2d.h
> > diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/sti/stm32/stm32-dcmi.c
> > similarity index 100%
> > rename from drivers/media/platform/stm32/stm32-dcmi.c
> > rename to drivers/media/platform/sti/stm32/stm32-dcmi.c
> > -- 
> > 2.35.1
> >   



Thanks,
Mauro
