Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60451482B78
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 14:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbiABNuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 08:50:19 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:56821 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiABNuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 08:50:18 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MiJdI-1mRwsA13Ac-00fPG5; Sun, 02 Jan 2022 14:50:16 +0100
Received: by mail-wm1-f42.google.com with SMTP id b73so20051691wmd.0;
        Sun, 02 Jan 2022 05:50:16 -0800 (PST)
X-Gm-Message-State: AOAM5324g8K+jh3VaJBvkVVRUzBVjeRcMncIvvUFlvKKZB4nXL/HtOQg
        9It2aam8jkTGW8eHXt7KyNvUYkRFZKc8hpymONc=
X-Google-Smtp-Source: ABdhPJyBExhPDKd/O9vrBRVKwV03zh2sjTNfK9yfgAYQ14ISPxmj4TeEYwQZGwiWUmgdy3AH9plc+YWhOvCK0m/vwMk=
X-Received: by 2002:a7b:c448:: with SMTP id l8mr35431267wmi.173.1641131415841;
 Sun, 02 Jan 2022 05:50:15 -0800 (PST)
MIME-Version: 1.0
References: <20211229072916.2567155-1-nikita.yoush@cogentembedded.com> <CACRpkdYcR7SA1bfzAtMBpXZiXZeZnV8hWGddx26VvvKwiZC4Sw@mail.gmail.com>
In-Reply-To: <CACRpkdYcR7SA1bfzAtMBpXZiXZeZnV8hWGddx26VvvKwiZC4Sw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 2 Jan 2022 08:49:58 -0500
X-Gmail-Original-Message-ID: <CAK8P3a0zH1Xpx6qKNOpQN-po=fisAikAai_7X+2+f9zUDjFLLw@mail.gmail.com>
Message-ID: <CAK8P3a0zH1Xpx6qKNOpQN-po=fisAikAai_7X+2+f9zUDjFLLw@mail.gmail.com>
Subject: Re: [PATCH] iio: stm: don't always auto-enable I2C and SPI interface drivers
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Cai Huoqing <caihuoqing@baidu.com>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1K4DA7hxOAImVuoxIz/c8QJNg5lAtaMtdEwFrA+M6lMND3BVj7o
 7ejK7ziftQHH7w0BPB7rSzGo4VOC34dkGuItk0ULRV6OzFOPHxhjYHrcZy55InBnweaGZAq
 i2eS+IPkFa0tZdNWGQaTHYs/zwS6ZMB7dR6AC9Bz3ZqFFa8X4suEmT/Kx2XBFMFhJChJBU0
 AaYBdPnXCfAaCfw6LZCGw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:QPIzJ4sTiJY=:AUUF8BZ8dNT6aq/VmNbF4f
 BBnNfqaOjjogznECpRDtEdYNCyRCyh78LP8sixozP+ewPI+doRewGc2XW0g2sfuo7txmjR7or
 vpWYHjSZplVlmGoaAgliwWe+43+CkD4BXHcJpwoc3pUGhRV16tnobmdNz5XM18nhN83RKwNeA
 iflKSiRTHN0uUTUzf5GOHR6WwZhDDPMxNCPUK8MRp2P6IKd+mETKSqAL1yOkMDYZJHr96gyd6
 WW3g+OQqt32i3oki9d+BEB+B4VQXpQWeSfNZoRTPgHaOS2qwLKT7gXFpv2RrtEu9xP5+RTprn
 tZ5Tz2UDNI/cRk5Xa+eO9WWkyNVzBzJk0bo7M5j/2EM3my2au/BNBjoimYZcnh0jV0ijjOY2m
 OfkUFXGPmzs6Cv0xmvS2kVP2hHL2fGRaPFtJpLbwKOvL+CtB1bslaTyP4JqQT/vFMqnFq2i3y
 l9yrNqmT1WjUbYkGmjHQpH6WgFcRWX38NCzLcfR1If4BPKG1fbGED8Qfip4G3lYbwaLVKaBw1
 imJlFxbesSiZiaKSexGrXsp7EU7JuNJtMmU2KJgwZApEl9KGGvkRo/hbz/giJ8dl+pTO74tom
 BJtuRnKAhTtaBAPjEy+HHpvi6NqXGHYypA6LYKtWR6og2sQEGkWtm2YumChZ//uvW+DZMTfa8
 aEzn5PV+PJ68mEI43PPVBkwwycjjv+V5oqCjJcWP79+bJEMwalSJ0M23Aezd+Xagu5g+PudQR
 c1vk9Rt1rK/ZFr0BB89/Bj/sGLa7yzmlaT2v7yhlDbclAza81AGCWGQC1ehs6ZkU0LI2h2Kf0
 ygA5hpq4h48UtzoOGgb1u9+OO0w6dBjBe72M1VqwY9IkIp5/m8=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 2, 2022 at 2:02 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Dec 29, 2021 at 8:29 AM Nikita Yushchenko
> <nikita.yoush@cogentembedded.com> wrote:
>
> >  config IIO_ST_ACCEL_I2C_3AXIS
> > -       tristate
> > -       depends on IIO_ST_ACCEL_3AXIS
> > -       depends on IIO_ST_SENSORS_I2C
> > +       tristate "STMicroelectronics accelerometers 3-Axis I2C Interface"
> > +       depends on (I2C && IIO_ST_ACCEL_3AXIS)
> > +       default y if (I2C && IIO_ST_ACCEL_3AXIS)
> > +       select IIO_ST_SENSORS_I2C
>
> This thing that a Kconfig symbol is made to depend on itself just
> boggles my head but it wouldn't surprise me if KConfig is this weird :(
>
> I CCed Arnd who knows KConfig a bit better than anyone I know.

It looks fine to me, the only thing I'd change is to write the default as

           default I2C && IIO_ST_SENSORS_I2C

rather than 'default y', which is less intuitive for the case where one
of the dependencies is =m.

      Arnd
