Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF2F477E8A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 22:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhLPVOU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 16 Dec 2021 16:14:20 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:54953 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhLPVOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 16:14:18 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MpUIW-1mAIuo1K1s-00pt2F; Thu, 16 Dec 2021 22:14:14 +0100
Received: by mail-wr1-f51.google.com with SMTP id u17so371147wrt.3;
        Thu, 16 Dec 2021 13:14:14 -0800 (PST)
X-Gm-Message-State: AOAM530PkeRe7zhgh9Vlocxcwd5jIJhdtIs1chKw1wQHdBotE+eFAsKN
        E6INXH95RVH0wUcvICfb+SJeGRVPxAR2uuHG9HY=
X-Google-Smtp-Source: ABdhPJx5ftEfPH4qvIzikYkTAI2QfNEBmismxp18qt3xtWOd9p6RwUc2SZYuv+4lj5MKuQ7wJcPfZffT71zk71LPRZ8=
X-Received: by 2002:a05:6000:1aca:: with SMTP id i10mr10867640wry.407.1639689253768;
 Thu, 16 Dec 2021 13:14:13 -0800 (PST)
MIME-Version: 1.0
References: <20211215220538.4180616-1-Mr.Bossman075@gmail.com>
 <CAK8P3a29tzgd_4WncippZBEJra9n0bQTysBkPBp_WA0sb28gTg@mail.gmail.com> <1360c4fe-4a09-a8a1-3224-7f1d4af59f6f@benettiengineering.com>
In-Reply-To: <1360c4fe-4a09-a8a1-3224-7f1d4af59f6f@benettiengineering.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 Dec 2021 22:13:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1oZK1qMRBE3D8otCTY6Lg4jMXxVpAZHQzLTA8woA3_UQ@mail.gmail.com>
Message-ID: <CAK8P3a1oZK1qMRBE3D8otCTY6Lg4jMXxVpAZHQzLTA8woA3_UQ@mail.gmail.com>
Subject: Re: [RESEND in plain-test] Re: [PATCH v5 0/9] Add initial support for
 the i.MXRTxxxx SoC family starting from i.IMXRT1050 SoC.
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jesse Taube <mr.bossman075@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Stefan Agner <stefan@agner.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Abel Vesa <abel.vesa@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:jLcfKWuFEKdB88gRT6zG+WNsy+2D4zMGcg9vmzSiKMpG4GXwiHA
 TZ3Mod5cZQg9ulqi6UikNcrt3jaz1VE+NWg4wqwrTHPpjw0c6kkKEO11y3p2tcAj8fbzPRZ
 yRH+Z+gDtqDy16EgfNJc1Cz7xLy9taRKNvTbR14ZrJrk8+/Dc3TNL+kTIEarR5LENeKDMuE
 k7Gl/EGFBNgEmg3ndaWxQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z/D4V6ISYL4=:swO45RG2EqZcuUukJekSUQ
 ZCPRAjKX7GuMlkxZdBlPUxtXKnqYmJYkIYAjnemcueOrpTKtEh0xwApd+O4q1XrMsx/vTYU+j
 WUeAf59gRSlIn/J4O0o6iW1QAwuKDH+K4NOD/alhj7/g2UZxs9QEeW/kx6CDpOT8RUNneiP7X
 maTFLoumWOXvRhRgPQxC109YEtPGQ7ABThgDaxTeJ7AjqQV2GA45Gtb5Of2rzEN8yOHkp9WJC
 EFyn59AUyJx82p+arn6cbwNUaRMKoHxy+Mfjoc43jAsjLC5a5mxw8DL986mtlNKt2BfUaZHyb
 Yf6WEOZClGTDYG9gtO4XudZw9vOcDTiw5SfHKZhYmd5PpW3hsaAxdINlqnCxgZ5h+ybYD1lQ7
 V+BWjLzfxDAyT+OcZuHrau+R3L2M+t3RsGZyzCRVoEFP21ubA1R5B1HTbPCZJzaxSrD5eWOcO
 XbIUfV6Aq7Nrp6ffXVGw0HKB3QuP/ldQfsihvjSiZdVmufpGK4RT7d4pxHw13WBkSpRdJBLJY
 onG6zFCoUt25pWYVpv9TfWPd0RTDIbdYWJ+E/ko0Xl7e++cjBOT+3MEApGSOX6DGFFE0bOlWr
 r3VrGLRnNyG2G9PvObId3SMOcCnUZiOImcnO8N+xJJ9NMGPIEwmQlE4LZupP4G7YYvs1oZlup
 z8/4vax5s1BpCj4G40rYaGM2eb2A1lJrb5UL0IQBATLkRqyVPQcXLsQ4r/YPoGmMTk0JTAR2N
 QraYHtKXw8kEDmD1CHoOzFjZ7Yi106LGkBKKalTUCiGI7aAMMFrZNkH+boqUlMwJKS7vQxKOE
 wPzvxJ8K7Nu+Gd8MdMPoKN7tyUassekAK+XRq8GzHmAdGfFcTs=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 6:33 PM Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
> On 16/12/21 09:26, Arnd Bergmann wrote:
> > On Wed, Dec 15, 2021 at 11:05 PM Jesse Taube <mr.bossman075@gmail.com> wrote:

> > As a more general comment, it's always nice to see newly added SoC
> > platforms, especially when they are this well implemented and done
> > by hobbyists. However, I do think you are being overly optimistic
> > as to how useful this is going to be to other people: interest in NOMMU
> > ARM platforms has dropped a lot over the past 5 years, and as far as I
> > can tell, it is only being kept alive for existing stm32 customers
> > as the economics do not favor Linux on Cortex-M for new products
> > compare to Linux on Cortex-A or some RTOS on Cortex-M.
> >
> > The existing users will inevitably stop updating their kernels at some
> > point, and then it's most likely just you and Vladimir Murzin that care.
>
>
> About this will you accept support for the other SoCs in the family?
> We would like to add in the near future:
> - i.MXRT1020(uboot support is already upstreamed)
> - i.MXRT1024(almost equal to 1020)
> - i.MXRT1060(almost equal to 1050)
> - i.MXRT1064(almost equal to 1060)
> And
> - i.MXRT1160/70 new family with faster core clock(1Ghz) and a cortex M4
>
> We need to add missing lcd(uboot upstreamed), usb(uboot upstreamed),
> ethernet(wip) supports for i.MXRT10xx family.

Sure, anything you want to work on supporting can be added to the kernel,
the important bit is that it's well written and can be maintained going forward.

My best guess is that we'll end up ripping out all NOMMU support in
a few years, when we get to a point when both of these things happen:

- the number of actual users that still update their kernels becomes
  really low

- There is some treewide refactoring that isn't easily supportable without an
   MMU unless someone puts extra work into it.

At the moment, we still support NOMMU kernels on a bunch of architectures
(Arm, riscv/k210, sh/j2, m68k/coldfire, xtensa and h8300). Out of these,
Arm is by far the most active, and if Arm NOMMU support was to go away
for some reason, the others would likely follow.

> This is to organize with Jesse also about buying evaluation boards and
> timing.
>
> We’ve meant this porting also as an exercise to deal with Linux deeper
> for us and for the other newbies.
>
> We’ve been also asked about a possible support for s32s(quad cortex-R52)
> on initial emails but it has no mmu too.
> While I’m seeing that some cortex-R is landing inside Linux.
> Would it be interesting anyway?

I brought that up during the initial review, but I think this is even
less interesting
than Cortex-M support from the perspective of potential use cases. While
Cortex-M MCUs have some advantages over larger SoCs in terms of
power consumption and cost, this is generally not true for running Linux
on Cortex-R. The Cortex-R and Cortex-A cores are closely related, so
they tend have similar power/performance/area characteristics, but
the lack of an MMU makes the Cortex-R much less useful. If there was
an advantage to running with the MMU disabled, you could actually do that
on a Cortex-A as well, but clearly nobody does that either.

Vladimir has put some work into making Cortex-R work in the kernel, and
he may have some other thoughts on this question.

          Arnd
