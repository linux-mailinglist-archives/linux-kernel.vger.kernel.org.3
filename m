Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94D41515B53
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 10:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382368AbiD3IIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 04:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiD3IIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 04:08:32 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADA81F601;
        Sat, 30 Apr 2022 01:05:08 -0700 (PDT)
Received: from mail-yw1-f179.google.com ([209.85.128.179]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MHX7f-1ngZDn1G89-00DXMm; Sat, 30 Apr 2022 10:05:06 +0200
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-2f7d7e3b5bfso105925027b3.5;
        Sat, 30 Apr 2022 01:05:04 -0700 (PDT)
X-Gm-Message-State: AOAM533xqCo+pqTgEdk3t68FdBEfQCR1LcHYhjkFQWze4r6WRwPe/SKf
        djy1ZfzlVfSGf7Cty2LlR1MqsdZ6atlEV7pEziI=
X-Google-Smtp-Source: ABdhPJxIMDnLMjNypqGxsmgcfR7ZUL75Dsm3yzSBDwMin5TKOLRH68mEJhbPriu8EYo0bqonSau57unAkS8+mfbVn7s=
X-Received: by 2002:a0d:fc83:0:b0:2e5:b0f4:c125 with SMTP id
 m125-20020a0dfc83000000b002e5b0f4c125mr3009265ywf.347.1651305903889; Sat, 30
 Apr 2022 01:05:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220422170530.GA2338209@roeck-us.net>
 <CAK8P3a3V=qxUqYT3Yt=dpXVv58-Y+HVi952wO6D4LPN5NNphGA@mail.gmail.com>
 <8b36d3a4-ec85-2f9f-e4b7-734d8ddd3d8f@roeck-us.net> <CAK8P3a0R9cpEb1d2=e9KnGSbi_uRv48RWfCu_J4DDak_cGZSuw@mail.gmail.com>
 <20220422234150.GA3442771@roeck-us.net> <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
 <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net> <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
 <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net> <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
 <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
 <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net> <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
 <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com> <149509dd-f43d-1b27-4395-81eab4ff3455@roeck-us.net>
In-Reply-To: <149509dd-f43d-1b27-4395-81eab4ff3455@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 30 Apr 2022 10:04:47 +0200
X-Gmail-Original-Message-ID: <CAK8P3a05vFdBnXXAMPVS82xX29+uinvWPcWxAgvj0TfoOk+1kg@mail.gmail.com>
Message-ID: <CAK8P3a05vFdBnXXAMPVS82xX29+uinvWPcWxAgvj0TfoOk+1kg@mail.gmail.com>
Subject: Re: [PATCH v2 00/48] ARM: PXA multiplatform support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Paul Parsons <lost.distance@yahoo.com>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        IDE-ML <linux-ide@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        patches@opensource.cirrus.com, linux-leds@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rtc@vger.kernel.org, USB list <linux-usb@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:6ELo6aWZ/AVT/h2IKTPL1/oF3s8PLFtinj2cmsv3MhMMbc5hjot
 hLyyhifXaK+a6ahQyyWy1km/IWQxSq3MLQ0ISIDZNjnHBeGaFURioUFgLw+WjNYxKuw5EVS
 dimLcxr+iyF1IKTlkTu/NvMwHi0G+6LLreUrPUSYPAx+Hh/aFHCg9q0MRcjevaEZnfEfp7/
 CFqGylxWC7n4sP9ADC09g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KdWF3kDIRlY=:U6mK5dyEyj/AbvznimN/C3
 Ts0726ANLRkytNW2iGPeTTb3UDc2gTD9XQrqQ6M2mcIIHr2fwn5llpqh2MPqiFnO/wevWwbm1
 U9SHSgo4duBCZCv7iDkGmHeAIfWFyJ29KEgJKNddc96IC3ISz36PmQTIQ6mgCP9NM53g5IDrh
 HD8pSbzqX7srB94lmmCy6h1CnPJ/A1f6OPnMXai3ddugX/eRFpsknp7O+YgzYth9dH2KhGWhe
 2ISBVhjgGvBVkK991IYW4EOOTYDLSNgehunxyDxOiia8WaSTuHbHn4Q2yP6M8Trg8mgoAbtFD
 Oilf4QNYgJJkgJRNVfYhZmooyltnz0ebcpKUfTX/pcHLognokKq0PkmeHBPdBLXcQuLR4JAWg
 DpFM2DU7O6/Z3IN9sQOwYJVm3k1PkgIBOEhTXeOEi6E/VmDMKOvohKdCxnLDW6L6HFUKxmjnD
 kwZTQgy4VZD+uVXm+Wcoyog8ULwuE4TqhjJ3URUvzZfX2nzN1t1Rd+YIKMlDAl15NfKTcxFAB
 sw32bWvqXoa7We/cN9kIvFc4rOmZyu+hbClBZMjep/QjwB5aXOoLVCclqsgvNPoyx7S73aYuh
 ORyBsz2YkCDXDpYrFcR8aki4b0lOAMo+NR7rj71DVR4jVJGVu6PijUylsX5pSZNau1+SCU32P
 Zq80V50uf8PbyozzcFXQfkuSmXj9VCsKB2COSp5fNhvLY9LEY5kq3MlMFDIapn/0SGjfEyTwJ
 rSqd7cqtK8k891zj+D8VJhKOSxsLbpUW2R+dB7w5tEiuFV7ta6e/aWpRwDtbDgaJ5pQVUttvM
 A75m099WaHVuaoYkbgtarYJh/WtWNVgeo1oP1Ga3MpX+ESVqfA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 30, 2022 at 1:09 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 4/29/22 14:46, Arnd Bergmann wrote:
> > On Fri, Apr 29, 2022 at 10:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >> On 4/29/22 10:48, Guenter Roeck wrote:
> >>>
> >>> I tried the pxa-multiplatform-5.18 branch. Its failures match
> >>> those in v5.18-rc1.
> >>>
> >>
> >> Uuh, wait, the build wasn't complete. There are still some
> >> failures. I'll report later.
> >
> > Sorry about the breakage, I got a few more reports about minor build errors
> > and warnings, the newly uploaded branches should address all of the ones
> > I got reports for.
> >
>
> Unless I am missing something the failures are the same as before. See
> https://kerneltests.org/builders/qemu-arm-testing/builds/74/steps/qemubuildcommand/logs/stdio
>
> This is with v5.18-rc1-49-ge8ab9a9a2745 which is the tip of
> soc/pxa-multiplatform-5.18.
>
> Should I check a different branch ?

I only addressed the pcmcia probe failure that you reported for the
final pxa patch, which
previously caused a NULL pointer reference here:

[    1.405319] PC is at pcmcia_init_one+0xf8/0x27c
[    1.405476] LR is at devres_add+0x40/0x6c
[    1.405611] pc : [<c04bdea0>]    lr : [<c044d808>]    psr: a0000113
[    1.405846] sp : c48a5d00  ip : c15f4220  fp : 60000113
[    1.406026] r10: 00000000  r9 : c48b000e  r8 : c48b0000
[    1.406195] r7 : feeb0000  r6 : feeb000e  r5 : c15ec090  r4 : c15ec020
[    1.406395] r3 : 00000002  r2 : 00000000  r1 : c15f4200  r0 : feeb000e

This now seems to work:

[    1.435846] pcmcia_socket pcmcia_socket1: pccard: PCMCIA card
inserted into slot 1
[    1.456350] pcmcia_socket pcmcia_socket0: pccard: PCMCIA card
inserted into slot 0
[    1.457489] pcmcia 0.0: pcmcia: registering new device pcmcia0.0 (IRQ: 217)
[    1.460275] pata_pcmcia: probe of 0.0 failed with error -12

So it sounds like there are additional bugs that I have to look at. I
probably won't
be able to do that in time for the merge window. The logs contain a number of
warnings, but I have no idea which ones of those are preexisting issue. I had
a look at

[    0.689982] pxa-dma pxa-dma.0: error -ENXIO: IRQ index 1 not found

and concluded that it must have done this for a long time. In my own qemu
instance, I see a crash from iWMMXt, but that works fine on your machine.
OTOH, your failed instances all look like they either time out or
failed to find a
rootfs. I tried passing an MMC device as root, and that works here.

         Arnd
