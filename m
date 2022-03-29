Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098384EB00B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238380AbiC2PQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbiC2PQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:16:16 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6E0241A17
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:14:33 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id b17so4946446qvf.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iTX5eis5JXZM+luuzeeILwldfqD5/+1wXgCmLUitkS4=;
        b=iAIkpnTYOlzAD6uHP12CKJ04RV8yvfY3+n9eg9vYOamsEYeUQuI/sBQ0pCS63LA9F9
         nncNt9S4+KW99q9Qcd/Vntxvz2dWjcc4lWtsmTdPCK2ao9144mBZ/W5InJ0Ye/AG0qff
         Q7dMdOTdF543Epq6PpzW8LJ9z7zAaRlvRjlszVgTrx2Z9IN98n2wNlri3k2/Ap1/zfp/
         a6ABJeC4n/HBjciXts/LCvM+TAjbG2mMafVXszsEPJZk0CECA2hnEl/sqRS/TqYhGAGZ
         Z8x15+rCFcHr3HjyjSgIC/Pe7FhcSsvmMv8npfBm3cZPKhvI8acrUcqM3thV8c/e4IBK
         vAig==
X-Gm-Message-State: AOAM531qICPcLVj4LGXhECF62FTb3635tBCbEqJbTCx/AaXYbS9etGXr
        pB2GNhc8eqJOslXK6s6px7tHeavypH9ywQ==
X-Google-Smtp-Source: ABdhPJzVo3IxYPuRQ8FtgaiKzany1eCFNvlPY1zRPwZTT0slSir7Bi7dGDOwQ7oD2mQyxcJ9q5gq+Q==
X-Received: by 2002:a0c:8151:0:b0:42c:2329:91a0 with SMTP id 75-20020a0c8151000000b0042c232991a0mr26585843qvc.107.1648566869757;
        Tue, 29 Mar 2022 08:14:29 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id b26-20020a05620a119a00b0067e5a092d45sm9660639qkk.11.2022.03.29.08.14.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 08:14:29 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2e5757b57caso187037527b3.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 08:14:29 -0700 (PDT)
X-Received: by 2002:a81:24d6:0:b0:2e5:b253:f9fc with SMTP id
 k205-20020a8124d6000000b002e5b253f9fcmr32054884ywk.438.1648566868204; Tue, 29
 Mar 2022 08:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220329125631.2915388-1-geert@linux-m68k.org> <YkMVLNHo+iMLHZRg@kroah.com>
In-Reply-To: <YkMVLNHo+iMLHZRg@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 29 Mar 2022 17:14:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVZfxYgbcB2ikAU_a-7BmU4dkrmSwte86irFUn6E6wrDw@mail.gmail.com>
Message-ID: <CAMuHMdVZfxYgbcB2ikAU_a-7BmU4dkrmSwte86irFUn6E6wrDw@mail.gmail.com>
Subject: Re: [PATCH] phy: PHY_FSL_LYNX_28G should depend on ARCH_LAYERSCAPE
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-phy@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Mar 29, 2022 at 4:18 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 29, 2022 at 02:56:31PM +0200, Geert Uytterhoeven wrote:
> > From: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Freescale Layerscape Lynx 28G SerDes PHYs are only present on
> > Freescale/NXP Layerscape SoCs.
> >
> > Move PHY_FSL_LYNX_28G outside the block for ARCH_MXC, as the latter
> > is meant for i.MX8 SoCs, which is a different family than Layerscape.
> > Add a dependency on ARCH_LAYERSCAPE, to prevent asking the user about
> > this driver when configuring a kernel without Layerscape SoC support.
>
> Why the artificial ARCH dependency?  What happens when people want to

Because it does not make sense to ask Linus^Weverybody about this
driver when configuring a kernel that cannot even run on a platform
that has this hardware.

Please read "Architecture and platform dependencies"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/kbuild/kconfig-language.rst#n552

> build kernels for multiple arches at the same time?  We shouldn't put

If you build a kernel to run on multiple arches, you should have
support for all of these arches enabled anyway, else it won't run.
E.g. both are enabled in the arm64 defconfig:
$ git grep -E "ARCH_(MXC|LAYERSCAPE)" -- arch/arm64/configs/defconfig
arch/arm64/configs/defconfig:CONFIG_ARCH_LAYERSCAPE=y
arch/arm64/configs/defconfig:CONFIG_ARCH_MXC=y

> these restrictions on just to have to go back later and remove them.

What do you gain by removing them, apart from having to spend more
time making love with your kernel configuration?
Do you (and everyone else) really want to see all 19190 config
symbol questions?

> > Fixes: 02e2af20f4f9f2aa ("Merge tag 'char-misc-5.18-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc")
> > Fixes: 8f73b37cf3fbda67 ("phy: add support for the Layerscape SerDes 28G")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

> > --- a/drivers/phy/freescale/Kconfig
> > +++ b/drivers/phy/freescale/Kconfig
> > @@ -26,14 +26,15 @@ config PHY_FSL_IMX8M_PCIE
> >         Enable this to add support for the PCIE PHY as found on
> >         i.MX8M family of SOCs.
> >
> > +endif
> > +
> >  config PHY_FSL_LYNX_28G
> >       tristate "Freescale Layerscape Lynx 28G SerDes PHY support"
> >       depends on OF
> > +     depends on ARCH_LAYERSCAPE || COMPILE_TEST
> >       select GENERIC_PHY
> >       help
> >         Enable this to add support for the Lynx SerDes 28G PHY as
> >         found on NXP's Layerscape platforms such as LX2160A.
> >         Used to change the protocol running on SerDes lanes at runtime.
> >         Only useful for a restricted set of Ethernet protocols.
> > -
> > -endif
>
> The movement of the #endif is fine, how about just sending that change
> as that is the merge issue here.

The Lynx 28G SerDes PHY driver should depend on ARCH_LAYERSCAPE
instead of ARCH_MXC.  The former needs a new dependency, the latter
needs the if to bemoved.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
