Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7546A517754
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387092AbiEBTY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233034AbiEBTY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:24:57 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D55F7C;
        Mon,  2 May 2022 12:21:26 -0700 (PDT)
Received: from mail-yw1-f182.google.com ([209.85.128.182]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MxE1Q-1o1DiO25O4-00xb47; Mon, 02 May 2022 21:21:24 +0200
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-2ec42eae76bso158737117b3.10;
        Mon, 02 May 2022 12:21:23 -0700 (PDT)
X-Gm-Message-State: AOAM532dexJ22ra+J/GQiTXBV9KGVIFRF7Vg4bUMZYJMFJ7qK4mz/9yz
        b9U2gbk8Ia7hVOXAcuTbhHdwawHZSC3RAHe0a9o=
X-Google-Smtp-Source: ABdhPJwUfMAOks7BnV4AzKQEtr1EDQTOee83IkNCHoU3D+nfieXOKuWmJ4Tp85gou+YPOwWYc3gRkPoRLjpjhxYBTNE=
X-Received: by 2002:a81:ad7:0:b0:2e6:84de:3223 with SMTP id
 206-20020a810ad7000000b002e684de3223mr12927652ywk.209.1651519282261; Mon, 02
 May 2022 12:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220419163810.2118169-1-arnd@kernel.org> <20220422234150.GA3442771@roeck-us.net>
 <CAK8P3a3qZdEqnJ2nTOKwDMossngOgCpEvZq4cQMPQjSsUoU=6g@mail.gmail.com>
 <3b4046ed-fd75-13ea-fac3-06469172806c@roeck-us.net> <CAK8P3a1LzEG1vo+5nMrnL3TOMcbSKJ3u=StcfY8dajV2raUBjA@mail.gmail.com>
 <3df135a2-17f5-d6c6-b4a8-e1a60e254297@roeck-us.net> <CAK8P3a2EHMQPN4ny9sXXuReFG0jN0hyRV7h9v_AR_0pqpOU41w@mail.gmail.com>
 <CAK8P3a09+nFS3g1rgvTW9da3tMiAhHjkjZVs1QOJOj8TJ-9MDg@mail.gmail.com>
 <6f1b27fa-96d1-4be7-ac6a-762610314f2a@roeck-us.net> <8d6d453a-e6fc-439b-2f34-e60c22fc9e98@roeck-us.net>
 <CAK8P3a2Ekvis1YcrJZtuga+XQdbeTC98PkOszCpS2DiZri7VMQ@mail.gmail.com>
 <149509dd-f43d-1b27-4395-81eab4ff3455@roeck-us.net> <CAK8P3a05vFdBnXXAMPVS82xX29+uinvWPcWxAgvj0TfoOk+1kg@mail.gmail.com>
 <b13783aa-9225-d52a-3800-c97ad772688b@roeck-us.net> <CAK8P3a3S5OjkKq_u5FpnwzYv+0+typya6Z4MzTez5ZH+do00xQ@mail.gmail.com>
 <CAK8P3a3jiqf_zpBsZyvAb5ZtkwDa7KkqExqDAdpY_pYqkr_NgQ@mail.gmail.com> <4dcdbfe2-9edf-320b-d123-3b62c8b5e28e@roeck-us.net>
In-Reply-To: <4dcdbfe2-9edf-320b-d123-3b62c8b5e28e@roeck-us.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 2 May 2022 21:21:05 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0ogn1wgPBDHkT=Fb8ufA+y8Ax1Qov2-vRXfC08QqnrQA@mail.gmail.com>
Message-ID: <CAK8P3a0ogn1wgPBDHkT=Fb8ufA+y8Ax1Qov2-vRXfC08QqnrQA@mail.gmail.com>
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
X-Provags-ID: V03:K1:LSvvD9ealIOnZB+N8uP6cECWasA2Jd3X8iq0Cc9U/iVYsnBKg9o
 ytWvTRMzIQZCGD0e1i7o1EpHdePM1NG9xgkirUzKNRG6DSfKxic3mGGZTfGFL1U7ldQBAtb
 wZn+CIpiZcMaiJxAbFO8IcYLfu9Ti5wj+O+27MhczGNb74PleKViT5c7M7wD+VsSs1l36KF
 rLwC2CFIQOhBN9KmrpHoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fbjVa8gY3qo=:Gwe5l2mvYrqeN0P6ZafGZX
 oSrefPBFecdfxw+f2yj2mmY/LNx/cpo7UkhFA7eG9/WUJjjyAjSQUz+mL0/OLnp5lOAILv+rL
 wZJbWfmd2byNsZvHnyZ6D5nRZ9KFAfpxvn1a4TBEFQ2s6dROZbMe9Z6w690de8hT7BEqQ8k+s
 2bjXyLFsN8Lw+n44zSR1HGla2yhwhqOQHrKMmcfLR0GbieiOL0Z45Hx8rP9m3k7YGdbArZBKJ
 gE91irW27MSLEy8/RxVLsPwOx7ErZb6Dh/Jwf33SIqPA/tH2GKjHxro5Afx1pz6CyXFh8S0Bm
 q+g6PuJlDIXiAG/IhRohR8uQM0G8Qy5vvnkeo2ejvxHQpHuSbP5kjX9vUZJckhnDgEtxImPJp
 +GnTaCuQjlnSHZteZWplbiaHTDCmszD6xNYQGYWhMuttlCO+btnl4MwI/OXOedY8xdJf3RzpQ
 sHkSX3XL5lLbnPreGSdIsT7mNybINie0NBh/J7jj8Ghl+KZJvFnfTEGdoAxOBf/mffcyQ+mTW
 MMmnnIdw8pdSTWgXXDsu+rgJhFZH9CSMCIMUJjFpGaFZkZdfOctv6bVjTzxFgLZP6p/QGZpRv
 xcMjPjwUGouwAtJDc+IwqidtHZsi+5+VWNyxGpo/aSdufJFzWEiXxcN2szr+Ne1ePoobkPQ6W
 INOTn8vgyN3/Kfge/OT/t5/jjqKuyputjRD3BtqSfG7QOKmIoUj4uxQCxtpiVS9zq/sHII562
 S0gInb219DnDLHdLByJXGuuihG0d/ry6f2WJyeNaw7HHKivck2Il58WyKzkeKHJ9xp3zsW+Yq
 ZZ2wJiLLtye20JCTyQ5nrKv8EToRmeSZd8QIQexpc0p+nhZshM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 6:26 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> With v5.18-rc1-49-gcb813018b5c1, I still get:
>
> [    0.797668] RAMDISK: Couldn't find valid RAM disk image starting at 0.
> [    0.805262] /dev/root: Can't open blockdev
> [    0.805487] VFS: Cannot open root device "(null)" or unknown-block(0,0): error -6
> [    0.805674] Please append a correct "root=" boot option; here are the available partitions:
>
> when trying to boot z2 from initrd.
>
> The other problems are gone.

Ok, progress!

What is your qemu command line? I see that z2 has no pcmcia device, so
I tried booting
from MMC, but this already fails with 5.18-rc1 without any of my
patches, giving me

[    0.697481] Creating 3 MTD partitions on "physmap-flash":
[    0.698161] 0x000000000000-0x000000040000 : "U-Boot Bootloader"
[    0.702815] 0x000000040000-0x000000060000 : "U-Boot Environment"
[    0.706541] 0x000000060000-0x000000800000 : "Flash"
[    0.718066] pxa2xx-mci pxa2xx-mci.0: incomplete constraints, dummy
supplies not allowed
[    0.718501] pxa2xx-mci pxa2xx-mci.0: incomplete constraints, dummy
supplies not allowed

Do  you have MMC or some other rootfs working without my patch series?

     Arnd
