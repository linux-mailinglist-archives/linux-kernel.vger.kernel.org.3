Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8CD5136D6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348330AbiD1O3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347045AbiD1O3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:29:21 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0883B57C;
        Thu, 28 Apr 2022 07:26:06 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id m11so5471697oib.11;
        Thu, 28 Apr 2022 07:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zXubuPjx2pjAm7hx5cD02wC66amPUE4R4gLIeK6MStk=;
        b=Hgi6UFYBOnfLbtFt3RVphkX7kyVyE0dWBeCF9+GFZIrwHTU07TyDVoycqB4ZceuCeC
         /ITKNTjYNtQyhXdbWynMaYs1aExYGEF1YL37IPS/1XnsjYSSVuluPw6nB2MW2F2i7Oi9
         l5bQYkYWY2erPfQ34x1MSGLoZ8eFIenJimtyHuUt6juNlAF3KRix/Lz/2a0FFM1tqBHC
         BmUyMFkq2VJupPtVN07orIB2CErgPBitg3IsW0+ftJRa7s0hCN/Mv5COsV0EPkB8jC8O
         QMrvdYwgDWwQKPgq10XLhwBxZ6AY3FYUDflhxjaBT7Wbl9bGg1Bkhyvofk/jGMofwFCI
         JO8Q==
X-Gm-Message-State: AOAM5332D4ayo57SKa5zR2EpXsFV4lR5oKJ1mRHQi41NBMIaso38Wxtw
        FkWdKA1kATkpy7lVdLjY+w==
X-Google-Smtp-Source: ABdhPJyGuPF0HOA0tIXbE2tN+YPk6d3A782bnuVeS4IVfJscr45WQBcONamKAO4aNHjqSxXj6dJ9ww==
X-Received: by 2002:aca:1811:0:b0:2ef:3c0f:f169 with SMTP id h17-20020aca1811000000b002ef3c0ff169mr15678035oih.61.1651155965318;
        Thu, 28 Apr 2022 07:26:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x21-20020a4aea15000000b0035e9a8d6e58sm68641ood.26.2022.04.28.07.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:26:04 -0700 (PDT)
Received: (nullmailer pid 2177702 invoked by uid 1000);
        Thu, 28 Apr 2022 14:26:03 -0000
Date:   Thu, 28 Apr 2022 09:26:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Detlev Casanova <detlev.casanova@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Olof Johansson <olof@lixom.net>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        arm-soc <soc@kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [RFC PATCH v2 3/3] ARM: dto: Add bcm2711-rpi-7-inches-ts.dts
 overlay
Message-ID: <Ymqj+2xBuHCmGUd/@robh.at.kernel.org>
References: <20220427185243.173594-1-detlev.casanova@collabora.com>
 <20220427185243.173594-4-detlev.casanova@collabora.com>
 <YmmyvdjiG7s/Qil4@robh.at.kernel.org>
 <CAMuHMdXHRQOOrmUO1AyDXye+nnRtpzx7WHiC__whcg0aBtzAmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXHRQOOrmUO1AyDXye+nnRtpzx7WHiC__whcg0aBtzAmw@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 08:44:17AM +0200, Geert Uytterhoeven wrote:
> Hi Rob,
> 
> On Wed, Apr 27, 2022 at 11:23 PM Rob Herring <robh@kernel.org> wrote:
> > On Wed, Apr 27, 2022 at 02:52:43PM -0400, Detlev Casanova wrote:
> > > Add a device tree overlay to support the official Raspberrypi 7" touchscreen for
> > > the bcm2711 devices.
> > >
> > > The panel is connected on the DSI 1 port and uses the simple-panel
> > > driver.
> > >
> > > The device tree also makes sure to activate the pixelvalve[0-4] CRTC modules
> > >
> > > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > > ---
> > >  arch/arm/boot/dts/Makefile                    |   4 +
> > >  arch/arm/boot/dts/overlays/Makefile           |   3 +
> > >  .../dts/overlays/bcm2711-rpi-7-inches-ts.dts  | 125 ++++++++++++++++++
> >
> > .dtso is preferred. I think... It was discussed, but I never got an
> > updated patch to switch.
> 
> Unfortunately that switch indeed hasn't happened yet.
> My main gripe with .dts for overlays is that you cannot know whether
> it's an overlay or not without reading the file's contents.
> Hence tools like make also cannot know, and you need to e.g. list
> all files explicitly in a Makefile.

See my reply in the other thread for that.

> > >  arch/arm64/boot/dts/broadcom/Makefile         |   4 +
> > >  .../arm64/boot/dts/broadcom/overlays/Makefile |   3 +
> > >  .../overlays/bcm2711-rpi-7-inches-ts.dts      |   2 +
> > >  6 files changed, 141 insertions(+)
> > >  create mode 100644 arch/arm/boot/dts/overlays/Makefile
> > >  create mode 100644 arch/arm/boot/dts/overlays/bcm2711-rpi-7-inches-ts.dts
> >
> > A global (to arm) 'overlays' directory will create the same mess that we
> > have in arch/arm/boot/dts/. IMO, first you should move all the Broadcom
> > dts files to a 'broadcom' subdirectory like we have for arm64.
> 
> As I believe this display is not only used with real Raspberry Pi
> devices, it makes sense to not have it a broadcom directory.

Then at a minimum 'bcm2711' in the name is not appropriate.

I'm doubtful that as-is the overlay would apply to boards outside of 
RPi's. For this to work (well), there needs to be a connector node to 
translate between connector resources and the base board resources. See 
the recent mikrobus thread[2].

> In fact it may be used on other architectures than arm, too, so I
> think we need an arch-agnostic directory for overlays[1]?

Probably so.

Personally, I would prefer no DTs under /arch.

> This may need remapping of labels. I'm aware the rpi infrastructure has
> support for remapping labels when applying overlays during boot, but
> AFAIK this is not yet supported by fdtoverlay (or perhaps by a fork?)?
> Note that the remapping is also needed if you want to apply two
> instances of the same overlay.

First I've heard of label remapping... I have a lot of concerns about 
using labels for overlays. For starters, with a flip of a switch (-@), 
they all become an ABI when they were not previously. I think at a 
minimum, we need an annotation so that a subset can be exported. 
Anything that's an ABI, we should be documenting and reviewing.

The requirement for overlays upstream is that they are applied at build 
time to a base DT. Otherwise, we can't validate them completely. So if 
there's a label remapping dependency on these, sounds like there is some 
more work to do. The first being getting agreement that label remapping 
is the right approach.

Common label names or some remapping for targets kind of works, but 
easily falls apart. For example, GPIO (or any provider with identifier 
cells) numbering or SPI CS numbering would be different. 

Rob

[2] https://lore.kernel.org/all/YmFo+EntwxIsco%2Ft@robh.at.kernel.org/
