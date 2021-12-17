Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24874790FD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 17:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238856AbhLQQJc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 17 Dec 2021 11:09:32 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:52859 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbhLQQJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 11:09:31 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MDgxt-1mp8iE2zTz-00AmWf; Fri, 17 Dec 2021 17:09:29 +0100
Received: by mail-wr1-f54.google.com with SMTP id t18so4943070wrg.11;
        Fri, 17 Dec 2021 08:09:29 -0800 (PST)
X-Gm-Message-State: AOAM530lm6T2EaDOTNBINP+1cUPyrKaDTMT++0ks8ENYGaFYF33i0NsO
        kCRZd0MWN7fQ3vsBepgT3SoN+iXDCtMHci2V8+M=
X-Google-Smtp-Source: ABdhPJw+hpDyyXl4RGdNrjBoGpphEIFP8WbbxKnsDBwk4fby22emKOtFTtHb87NvnAn3PiNTf/SBfIb0QDVvSxKoTzc=
X-Received: by 2002:a5d:484f:: with SMTP id n15mr3108967wrs.219.1639757369230;
 Fri, 17 Dec 2021 08:09:29 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
 <bc15d5e8d7a5ec96582799fe513de4ace6fd4b8b.1639039163.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a2UGr6ZbHk6G=wh5XG_EGdJxGf6SfyN1sTb4aaUgiK8Lw@mail.gmail.com> <5c01390c485a44b6913dcb42e3677ed1@sphcmbx02.sunplus.com.tw>
In-Reply-To: <5c01390c485a44b6913dcb42e3677ed1@sphcmbx02.sunplus.com.tw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 17 Dec 2021 17:09:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1zjsZsf4_V8CxUzeh8=LPntsdsM7Yvhs8k3mTw3fZwNw@mail.gmail.com>
Message-ID: <CAK8P3a1zjsZsf4_V8CxUzeh8=LPntsdsM7Yvhs8k3mTw3fZwNw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
To:     =?UTF-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        gregkh <gregkh@linuxfoundation.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:jbEz9HVOOp/DT6eplBNQJz5ZKl6Ae0AM9PDzlP6rdOL3ufhUQYD
 Ux8C5N35l+kXQLdpCM5cVaKUs9T701cSBTz/kJubF1OtkQOiaZYHTVDIu6qKNVlRg6j07ZJ
 QUsahJ+Z4V3Ta7wGpCjXzrN7G3cBgZoy5I+0zGDxtt8vi1XzmSnNyOU2CPB5pQN6Itw9pDN
 N1HBverwvCU3VD1tqcQAQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:C11EqKUf7dE=:0qwfP/P/alOcqtQjRCkPs+
 MVn8wzteqeuNb0lBwXDj0LzoM/KtoescOj1E6JZB8emsEDCC9JcVtCxCWx0Y6cGOF63ipes/N
 CGhuFFo3OquNMM4x6aVBpZhpTZWyEmzn6xzQ1VvC8COtV//LmHb7ffNJRjAg/+2bn4nlSRiTj
 TAKQc7bGK/vd1ioMSTXwylIM5q+V2Q3xgM126Cpr034IVJttSO8Pxw4evExRTYfXSmu5P3bPY
 n7KuCcorepcRYvZRh8G+EBu8zG0RlGOkrB+7nrIgk49XWLtULWgG7S393uPI/hojTZk25MecQ
 tLrEknL0TIRR8hM3lFRtvbvgZJwG865gdOndnOfi1TKap49RqXkRvXq5TLtCJOFM9MtTdeQRU
 ahz9QBJlrDWaxXk5D5hc/+8FGWPV6I03YUg9Tttjyi9z7plcXiWbtTfl5XkOyDc/hw/lNWOUi
 uwNxMDqJsjR1bDyNQE7+DuKoxlRLgOeXaY/7IAgupmfFrZmF1Kx1ZiZ6Tgo0kTEYOoSlpKAC8
 knQNXzk80oa9a0SkNvo3RB16SQ4igOaQ87hE7tFwapu7eJq6iwohwJV2GEig01HycmlEuiGsG
 qDRu3W0b/oG2JtLs0Liuwwo0n/fUqa2elCXFteBgx4y6U9zRyrw9zxZ+NSRiODyjUE+sjZU/G
 h96uBExo7BF1eBV6jk7IvUlCHbwJQVNyITlr1OagHdNOTy6dD+ZujUHrPyRW6kow3YCA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 17, 2021 at 4:16 PM Tony Huang 黃懷厚 <tony.huang@sunplus.com> wrote:
> > On Thu, Dec 9, 2021 at 9:58 AM Tony Huang <tonyhuang.sunplus@gmail.com>
> > wrote:
> > >
> > > IOP (IO Processor) embedded inside SP7021 which is used as Processor
> > > for I/O control, RTC wake-up and cooperation with CPU & PMC in power
> > > management purpose.
> > > The IOP core is DQ8051, so also named IOP8051, it supports dedicated
> > > JTAG debug pins which share with SP7021.
> > > In standby mode operation, the power spec reach 400uA.
> > >
> > > Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> >
> > Thanks for the improvements, this again looks better than the previous version.
> > I still have some minor comments, and there are a couple of details I have
> > commented on before that would need to be addressed, but let's focus on the
> > one main issue for now:
> >
> > The driver still doesn't actually /do/ anything: you load the firmware when the
> > driver is loaded, and you shut it down when the driver is removed, but
> > otherwise there is no way to interact with the iop. You had the miscdevice
> > earlier, and you still register that, but there are no file_operations associated
> > with it, so it still doesn't have any effect.
> >
> > In the original version you had a couple of user-side interfaces, for which Greg
> > and I commented that they were not using the correct abstractions, and you
> > still list them in the changelog text as "I/O control, RTC wake-up and
> > cooperation with CPU & PMC in power management".
> >
> > If you want to make any progress with adding the driver, I'd say you should
> > implement at least two of those high-level interfaces that interact with the
> > respective kernel subsystems in order to show that the abstraction works.
> >
>
> Q:"with respective kernel subsystems in order to show that the abstraction works."
> May I ask you about repective kernel subsystem.
> If I use the file_operation method
> Provide user can read and write IOP(8051)'s register.
> Is this a repective kernel subsystem?
> if not
> There are other driver code can give me reference

- For gpio, there are lots of drivers in drivers/gpio/
- For RTC, there are drivers in drivers/rtc/
- For suspending the CPU core, there are drivers in drivers/cpuidle/
- For turning off the system, you can find drivers in drivers/power/reset/

Any of these drivers can interface with your kernel driver in various ways
that avoid adding a custom miscdevice.

         Arnd
