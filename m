Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA548E87F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbiANKq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:46:57 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:48445 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234097AbiANKq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:46:56 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N18MG-1mBagn0LVK-012Z1K; Fri, 14 Jan 2022 11:46:55 +0100
Received: by mail-wm1-f44.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so3303523wmb.1;
        Fri, 14 Jan 2022 02:46:54 -0800 (PST)
X-Gm-Message-State: AOAM530QQZCirgbs6JMt/XJr1srxIShYz2/XIc3lAK8NsOoeQszXe6Ul
        9NBgVtXyhg+WQZY7mbXJImoXCAWdoyMjsZi+jws=
X-Google-Smtp-Source: ABdhPJwAWWNZkfH3zvOak1E2MdZhsLPVQGdvjKTtuDO+j6YhpQJjnaj8sNFQLsSqZON5BUwmQiGLZMoD/6dNPWTOY/Y=
X-Received: by 2002:a7b:c418:: with SMTP id k24mr3646582wmi.173.1642157214594;
 Fri, 14 Jan 2022 02:46:54 -0800 (PST)
MIME-Version: 1.0
References: <20220113201920.3201760-1-laurent@vivier.eu> <20220113201920.3201760-4-laurent@vivier.eu>
In-Reply-To: <20220113201920.3201760-4-laurent@vivier.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Jan 2022 11:46:38 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2QzMiga0FFVmTuefnq1OzsgyopiJN2he8043K0TRF1ng@mail.gmail.com>
Message-ID: <CAK8P3a2QzMiga0FFVmTuefnq1OzsgyopiJN2he8043K0TRF1ng@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] clocksource/drivers: Add a goldfish-timer clocksource
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        John Stultz <john.stultz@linaro.org>,
        linux-rtc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Z6CjTUwG+pG/J4r9HQCU+WnyA/uBxqrDpIhPcRxUXGhrgrY8LEj
 5xMzLHHYa8YxwjzLUTtESXHtPYzXFZXzoW537rOPOahw5qKW84vfBigrHz1zCs0/sepDoqi
 GJa/5b51mlA2oXHsk5SbIutYhyM2K7867nOSA1ySOriF2fxdj2+Awh1kxiwxehs8AL4e0/H
 XHsMRYgjXOxvXIplQhaEw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:kQEuGL70gR8=:Z8RjLBKEuEjIoOC5co4W1Y
 EblmfJtG5zzeq4+z7MlnItrMzg/4+2BCn+/j0aZkeD0Y2Db4c3WJuEgIZeq0PkI6S04Bx/8EV
 mhSpQcyfvXI8Hakq16OR/sV/HPaHU7Rsskzv0SrUFC72ECDNofldJzJNBzrOfiDOOe9+EEk/N
 tfvMyo72gMJ5SmNHdPe1f9P/AbXCog+ldv5NLrI4iK/LYWE9bkm7IWytgQ7Hh6Q/49BcJozap
 CNVQyySrJdc7hOdWNjUTDgWS47ztgFi7ZXYCMpHk9lydV6teoF7RKJY8BmYf61ektIE/loy0h
 Lt30G2c61DUyzvNE3QOC+h1yX1V4HesuN9NHIic+QMvneMsEA03CvsN1IHbL9hd+/PYHjyBoy
 s7VDhY3iVMX/fOnC1CtPEGbt4fFRQWLdCxtnBiqRAr6Ia9ISOTTPaakGZDxa/meZCdm8InmOQ
 uL57BPds4QFARxpUnBUJogAKpRVF9Ef89N2mg0XHpn7040p5B9L92vqQSPlU0zeJTD6iBgFV0
 kgVSR9xUN91+uebpozCLYEVPY/CeddW5cxKOmjG8JH3eVCela2XNZhuo5mS4f0bf63l8PToiL
 GObfhw3Zte1CCmVGBcgOOsU1+iUV/Dmva6Mce/YtzaksZmJKqeoS84aOqUlHFg7bW7rTDWgwE
 mzHTEkLduRTg+A6oM9K+w7w0gi63tkxg3zoKwDcRpyGrJiOB4Bdr3u9Iv3vLoReAWBfVs5aQ1
 peS7Wz5LtEBnSONH5AHZp2EXLMNUA4R1QvGlMCG1eLwXm5i+vXFAe8HVFKGnTE5TEUztDJTCQ
 PK6o5LpatJp2qZEwdmbmJE5fY/ZSQZkY9yQ4BtNOXMkNxaUPq8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 9:19 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Add a clocksource based on the goldfish-rtc device.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  drivers/clocksource/Kconfig          |   7 ++
>  drivers/clocksource/Makefile         |   1 +
>  drivers/clocksource/timer-goldfish.c | 130 +++++++++++++++++++++++++++
>  include/clocksource/timer-goldfish.h |  12 +++
>  4 files changed, 150 insertions(+)
>  create mode 100644 drivers/clocksource/timer-goldfish.c
>  create mode 100644 include/clocksource/timer-goldfish.h
>
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index f65e31bab9ae..6ca9bb78407d 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -711,4 +711,11 @@ config MICROCHIP_PIT64B
>           modes and high resolution. It is used as a clocksource
>           and a clockevent.
>
> +config GOLDFISH_TIMER
> +       bool "Clocksource using goldfish-rtc"
> +       select RTC_CLASS
> +       select RTC_DRV_GOLDFISH

This should probably be

          depends on M68K || COMPILE_TEST
          depends on RTC_DRV_GOLDFISH

A driver should never 'select' another user-selectable subsystem

> +static int goldfish_timer_set_oneshot(struct clock_event_device *evt)
> +{
> +       struct goldfish_timer *timerdrv = ced_to_gf(evt);
> +       void __iomem *base = timerdrv->base;
> +
> +       __raw_writel(0, base + TIMER_ALARM_HIGH);
> +       __raw_writel(0, base + TIMER_ALARM_LOW);
> +       __raw_writel(1, base + TIMER_IRQ_ENABLED);

As mentioned elsewhere, the __raw_* accessors are not portable, please
use readl()/writel() here, or possibly ioread32_be()/iowrite32_be() for
the big-endian variant.

> +EXPORT_SYMBOL_GPL(goldfish_timer_init);

No need to export this if the only callers are in the kernel.

         Arnd
