Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99CB1512BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244363AbiD1Gru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233790AbiD1Grq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:47:46 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426B798584;
        Wed, 27 Apr 2022 23:44:32 -0700 (PDT)
Received: by mail-qt1-f181.google.com with SMTP id t16so2789359qtr.9;
        Wed, 27 Apr 2022 23:44:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6lRX8HkbDGmeYmMR2pBv8oehQI8eucp0kVSXCaIj8U=;
        b=EYipAnCJWn/V7fK7OzwN2lFkpdkHW3LatWZL+KYXzAmse8QyRaAfPq4eXaMxdIqZBw
         xwuTt95hCVm4sruj9GVEqry56JGrwiTaEzH0KCEMFLoLJRRCwG54dg65SZOVQSlM03yr
         0+lv7+YiwLMBXI5Z0c/tr+V51DBewflveGbdbUcdDDeT/qcXfvUAU/WiTxquiXRBOxWz
         AY/8l4d8xlU+GMtrsAEJJC5wRv1lcBYvWLGmS/VJnQUBJ/d8mdN58lHoh0ZrY4NOmdPL
         NBDaaMKAhkAy+9QXf0acPDEHZccLBv8qKGstbpZOVQRe69kE2WpzruoxnOfpHiSxPIKq
         uqTA==
X-Gm-Message-State: AOAM5319prsWXsBSM48+HlJZoUMbn/ExxS2nNX7W5f+1ukqPhpOta/BA
        Zh50aHvfxe98/cpXMXzaZfqzTW7USrFDqQ==
X-Google-Smtp-Source: ABdhPJyNN5Kh2wZfhYrGV+bRy1P+svCyp2xoPHqH1RX1bQyfD071DbeUEXOipID/OxYjjPBM/h7KlA==
X-Received: by 2002:a05:622a:5d0:b0:2e1:d430:a5c9 with SMTP id d16-20020a05622a05d000b002e1d430a5c9mr21872100qtb.639.1651128271086;
        Wed, 27 Apr 2022 23:44:31 -0700 (PDT)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id o134-20020a37a58c000000b0069f8e381167sm1796158qke.76.2022.04.27.23.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:44:30 -0700 (PDT)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso42417197b3.5;
        Wed, 27 Apr 2022 23:44:29 -0700 (PDT)
X-Received: by 2002:a81:c703:0:b0:2d0:cc6b:3092 with SMTP id
 m3-20020a81c703000000b002d0cc6b3092mr30791811ywi.449.1651128269435; Wed, 27
 Apr 2022 23:44:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220427185243.173594-1-detlev.casanova@collabora.com>
 <20220427185243.173594-4-detlev.casanova@collabora.com> <YmmyvdjiG7s/Qil4@robh.at.kernel.org>
In-Reply-To: <YmmyvdjiG7s/Qil4@robh.at.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 28 Apr 2022 08:44:17 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXHRQOOrmUO1AyDXye+nnRtpzx7WHiC__whcg0aBtzAmw@mail.gmail.com>
Message-ID: <CAMuHMdXHRQOOrmUO1AyDXye+nnRtpzx7WHiC__whcg0aBtzAmw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] ARM: dto: Add bcm2711-rpi-7-inches-ts.dts overlay
To:     Rob Herring <robh@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wed, Apr 27, 2022 at 11:23 PM Rob Herring <robh@kernel.org> wrote:
> On Wed, Apr 27, 2022 at 02:52:43PM -0400, Detlev Casanova wrote:
> > Add a device tree overlay to support the official Raspberrypi 7" touchscreen for
> > the bcm2711 devices.
> >
> > The panel is connected on the DSI 1 port and uses the simple-panel
> > driver.
> >
> > The device tree also makes sure to activate the pixelvalve[0-4] CRTC modules
> >
> > Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> > ---
> >  arch/arm/boot/dts/Makefile                    |   4 +
> >  arch/arm/boot/dts/overlays/Makefile           |   3 +
> >  .../dts/overlays/bcm2711-rpi-7-inches-ts.dts  | 125 ++++++++++++++++++
>
> .dtso is preferred. I think... It was discussed, but I never got an
> updated patch to switch.

Unfortunately that switch indeed hasn't happened yet.
My main gripe with .dts for overlays is that you cannot know whether
it's an overlay or not without reading the file's contents.
Hence tools like make also cannot know, and you need to e.g. list
all files explicitly in a Makefile.

> >  arch/arm64/boot/dts/broadcom/Makefile         |   4 +
> >  .../arm64/boot/dts/broadcom/overlays/Makefile |   3 +
> >  .../overlays/bcm2711-rpi-7-inches-ts.dts      |   2 +
> >  6 files changed, 141 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/overlays/Makefile
> >  create mode 100644 arch/arm/boot/dts/overlays/bcm2711-rpi-7-inches-ts.dts
>
> A global (to arm) 'overlays' directory will create the same mess that we
> have in arch/arm/boot/dts/. IMO, first you should move all the Broadcom
> dts files to a 'broadcom' subdirectory like we have for arm64.

As I believe this display is not only used with real Raspberry Pi
devices, it makes sense to not have it a broadcom directory.
In fact it may be used on other architectures than arm, too, so I
think we need an arch-agnostic directory for overlays[1]?
This may need remapping of labels. I'm aware the rpi infrastructure has
support for remapping labels when applying overlays during boot, but
AFAIK this is not yet supported by fdtoverlay (or perhaps by a fork?)?
Note that the remapping is also needed if you want to apply two
instances of the same overlay.

> >  create mode 100644 arch/arm64/boot/dts/broadcom/overlays/Makefile
> >  create mode 100644 arch/arm64/boot/dts/broadcom/overlays/bcm2711-rpi-7-inches-ts.dts

And this one just includes the former, and thus sort-of serves as an
example of my point above ;-)

[1] Note that this does not only apply to overlays: soon we will
    have a full SoC peripheral description in r9a07g043.dtsi to
    share between RZ/G2UL (arm64) and RZ/Five (riscv)).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
