Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF065780AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233979AbiGRLZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiGRLZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:25:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC61BCB1;
        Mon, 18 Jul 2022 04:25:01 -0700 (PDT)
Received: from mail-yw1-f170.google.com ([209.85.128.170]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MsHwC-1nPQgA0KZ0-00tjPu; Mon, 18 Jul 2022 13:25:00 +0200
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31e1ecea074so26608577b3.8;
        Mon, 18 Jul 2022 04:24:59 -0700 (PDT)
X-Gm-Message-State: AJIora+XZxXwlbeo8tYRIcu6UrcArdCFUnfN41ji1cKx2TLUisIzJ1Pr
        PRqoYLaACkjWRTk1llHbQmYvaVUEXxktkfAttNw=
X-Google-Smtp-Source: AGRyM1tzL7hthvP1sOdr1X/BfOKLedAJn4Urbe8k3BQ7Z19q4rX8bfPxpzkeM1Uk0JKELZ+zlaoPYOQFI7A/abx5b1Y=
X-Received: by 2002:a81:9b02:0:b0:31c:9ae4:99ec with SMTP id
 s2-20020a819b02000000b0031c9ae499ecmr29471022ywg.495.1658143498552; Mon, 18
 Jul 2022 04:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1656396767.git.qinjian@cqplus1.com> <CAK8P3a1HoB74TA9EKJFuPLuw_zJfy_p7fwkm0M45+jaGkK6ivA@mail.gmail.com>
In-Reply-To: <CAK8P3a1HoB74TA9EKJFuPLuw_zJfy_p7fwkm0M45+jaGkK6ivA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jul 2022 13:24:42 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3eSNR4xdGkjiBadNd+YsvEP6WtdAcJjinX+5AAiZWQog@mail.gmail.com>
Message-ID: <CAK8P3a3eSNR4xdGkjiBadNd+YsvEP6WtdAcJjinX+5AAiZWQog@mail.gmail.com>
Subject: Re: [PATCH v20 00/11] Add Sunplus SP7021 SoC Support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Qin Jian <qinjian@cqplus1.com>, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Olof Johansson <olof@lixom.net>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ez5RRW2DnTCgtLBs77BuhklVwUiXDDX6Rjn05D2CM3wYwbvtcV+
 UIjey1f9G0pqstGJgytrgMLQ25ReWBgVjD3A0DiFX1OVpvK8Eb43bRIGDJPW3R1Cyg1skgz
 4M6TiYFY1eRxrWC5ZXqsoroEYy4/mmpc0Plpt6L5ql53Ge97ELgZ2cqdspfCpehAN/dlUPa
 RZQve9n2SqmYT/SiKe83g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vmE3xwsqK9A=:MD3/WQhQvR5PchRTMYws0Z
 MMhpZNbXkPxQM22yc9lk6QdR5VFAK8D/rcXc8F6B07ukICnehNh9Z2heeel5TIdoAPhG4/H8U
 lvaXpa8D2oJGueodqXTa4f/tXbaMAq7uzM0qsoTT/s6wmn+RH3jwnEpecf9VKlaqKsutfTjpd
 jEAobfhxUYsS4brByThBmiFCHhvh3PyS59K/zKbwnTOiVHbNRK+VKBON/mbkV2DY3m/WHbWwc
 AjHcwjf9VMkDAiN4pTBaDFPYlof3l9YVk5yvBoAWUWC8dPQgYvKmAlcUM5XH3TJ+VEp7vfvFG
 zBcUPuIxIo8LRc81JMiQVo6BGFN6prfyEbLxHxMC0XVaahBPC5q5cLqTfQjVRs0UqOMAhc8Bp
 PTtiK9qvV5ovuZ4CYNcTJZTJZ7rYzu0PVx7dR9xkBvsLWTcPtdug9QzvttB1oFI6fdGAEFtZA
 ELv2R8U5sAfleLpbMZsrW7cQQRdAY0VJPVBpP4NS19Fpjlmt/W//R5aL6Y2LJrz77sfz/PBeJ
 u6AN3gz/8+fr0CsuPU5yp4H2x9xrUoMC6RH3VNH6kPo+IPEBtL+oEIuujNzUbUhQyPs9n6ZNo
 tS3PBel49g25WYKjRDd5dEMopEb7pM0miu5c/mvLvpIRHdpi6vVpY3eB8ehsZK6XXh+yISVVh
 rqcQkyTxRJwecHO8fvW2hsFSHR4ykP8MUaXWuChh5F7ZrdNg0bnl8HRQoXErDmrz04tVJ6Ckw
 4mgzB+XmOpuEroNvCQEdqr3JAM7S2upeP45cAg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 5:01 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Jun 28, 2022 at 8:26 AM Qin Jian <qinjian@cqplus1.com> wrote:
> >
> > This patch series add Sunplus SP7021 SoC support.
> >
> > Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates many
> > peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and etc.) into a
> > single chip. It is designed for industrial control.
> >
> > SP7021 consists of two chips (dies) in a package. One is called C-chip
> > (computing chip). It is a 4-core ARM Cortex A7 CPU. It adopts high-level
> > process (22 nm) for high performance computing. The other is called P-
> > chip (peripheral chip). It has many peripherals and an ARM A926 added
> > especially for real-time control. P-chip is made for customers. It adopts
> > low-level process (ex: 0.11 um) to reduce cost.
> >
>
> As far as I can tell, all review comments have been fully addressed,
> but I'm missing an Ack from Stephen Boyd so I can apply it through
> the SoC tree.

I ended up applying the series without the clk driver now, please see

https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git/commit/?h=arm/newsoc&id=7cb7b8fe63393d77

No need to resend the series any more, please just work with
the clk maintainers to get that driver included through their tree.

If there are any issues with the patches that I merged, it's best
to send bugfix patches that can be applied on top of the branch
listed above, or a pull request based on that commit.

For new features to be merged in a later release, e.g. patches to
add device tree nodes for other on-chip components, or additional
dts files, please base them on the coming -rc1 release when that
is out.

       Arnd
