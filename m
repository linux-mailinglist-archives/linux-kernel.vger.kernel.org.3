Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9D348D6C9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 12:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbiAMLnF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 13 Jan 2022 06:43:05 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:55891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiAMLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 06:43:04 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MZAvp-1mmL261LLF-00VBiM; Thu, 13 Jan 2022 12:43:03 +0100
Received: by mail-wm1-f49.google.com with SMTP id v123so3650778wme.2;
        Thu, 13 Jan 2022 03:43:03 -0800 (PST)
X-Gm-Message-State: AOAM531TPKK+FzpLXa7yNz7E1yzJAuVAiGXdjqBAayNj8ppnRht8RprM
        44wxtY1dCHRxAjdvvi/Ozkh3Xy1bmnrBA09/fy0=
X-Google-Smtp-Source: ABdhPJxwX82RKjcZ7lo6/WdyVIEJ5Vjk6IOkFYcqrpqtCJt+H5PWX05QDE08ehIn3XiMfT4yqHLHIp8+V4wVfcchO3Q=
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr3431122wmj.35.1642074182910;
 Thu, 13 Jan 2022 03:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20220113103559.2577216-1-laurent@vivier.eu> <20220113103559.2577216-4-laurent@vivier.eu>
 <CAK8P3a2_cJi9+SNi9gK6+5kpBo4wmVw4hz42Bq_jm1+s6AvENQ@mail.gmail.com> <8c0b3146-35ee-b0b2-468b-1c8dcdaf64ee@vivier.eu>
In-Reply-To: <8c0b3146-35ee-b0b2-468b-1c8dcdaf64ee@vivier.eu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jan 2022 12:42:46 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0GYm=Q5aPJuJJ7JoBQw4+QokgkMKv_D+YgYfzPODRYSQ@mail.gmail.com>
Message-ID: <CAK8P3a0GYm=Q5aPJuJJ7JoBQw4+QokgkMKv_D+YgYfzPODRYSQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] m68k: virt: Remove LEGACY_TIMER_TICK
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org, John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:GqvVufrpuc0rpx5CGvMGfps7AyQB0lTpJhvQPzG16LuIm0ZkqWr
 3DlPkBfshB7Ct25si0kSnxG/JtvrvpOLgTesHkq7gFakYbapmqBEUbNEBwYZQwHmw3rJ1l1
 UWOFz+gbooRTozsUF8oqklYuwz73Lk0zXlfeI/lc0TtSa0fY6/SA790hfNrGsgq7wLGA6ud
 7r1oasuLWxNweNIHHyuDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:aOSeITfvL2Q=:/s2UfzjKDIT/jF6NezEocl
 LsaU90oFa4RNmCwwGIgiJJUMNoglREdzjGTXanHv2FFgOr+IoxPcJvwdHc7m3JzLj8uOjpRYc
 N4neP16b9PdfE70v6YMSO4BdFXeVxI2+EFL3wGqUr3D2lSsmorvS0xDURaIQuVkQ/bHCIpLvE
 PA0AqNxsrTsS4y9Qp7QXsXSUO0+jWPrSaKkzw75wZNuVYFpYr6gr87m9H1MKPhhuHQAy2lqJ7
 WEMnHJiMYP/dg2B78mHBQqyA7YqG3jDI1OGxo5tE2EReTFHp0jO5+GChGWJMNChjmuKMEQaUi
 Q7Y/W+2+Y/UbywIqQdqvIc7cMX4XY4cUf+tsdC6iSf0sPW1LaQ33ccAyD5sBdWJ2dk3oM9pD9
 3QbNAXdOXSuyHkMnBzlfBaaz2TZs+tRNnr+Bu9o6XJLTRMe5jfu6BK9v3UqTi8ARTXZenbJSt
 NJ3ERnxNn0DXZpOpWtEmQ/T0vxv5mnxK8apOVYVNVTYM9kaLNofmpGFvP3dHHf+Z7+/40zLPd
 Sact31iRaxNDR80f7kvH+Hwe+oiSJI/PzAeCaQP4NHrs26Fn+Xdc4XV2JeQ8SJO3FI6icklTo
 nY52ifcXcf3G/30ZWkomYjchyJGqArGEFwqgyCOfG37dqxNbSDy4bo8yc34n7feh8+xGDFgxT
 ZDHApe5bGUoPLPF+jBqb1wYdG+M42Eq8Gtad5elBmgzttuOIXgSblziIi0ybpWwYzIOPlE/cr
 FVdpkwaJks6hnOU1geoqKuAjT+dHb+hZIQuUmVFORJ1d7/UAQ7ttMJH2bra4GtE8k7nDkn+4y
 8oioEh/i+Ot5Q+JpIfv2/mGolve+0+/ErCSUd8TD92JgON5pvQ=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 12:32 PM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 13/01/2022 à 12:20, Arnd Bergmann a écrit :
> > On Thu, Jan 13, 2022 at 11:35 AM Laurent Vivier <laurent@vivier.eu> wrote:
> >>
> >> Move virt machine to generic clockevents.
> >>
> >> cc: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> >
> > The change looks good, but it appears that you only just add the legacy code
> > in the same series, and it would be easier to just add the correct version
> > first.
>
> In fact, I'd like to keep it separated for two reasons:
> - it can be used as an example for people that want to move from legacy to clockevents,
> - the machine with legacy timer tick is in use for more than one year by debian to propose a m68k
> buildd and dev machine, so it is really well tested and robust. If there is a bug in my clockevents
> use it will be easier to detect.

In general, it should be easier to do a correct generic driver than
an implementation for the legacy interface.

> >> diff --git a/arch/m68k/virt/timer.c b/arch/m68k/virt/timer.c
> >> index 843bf6ed7e1a..767b01f75abb 100644
> >> --- a/arch/m68k/virt/timer.c
> >> +++ b/arch/m68k/virt/timer.c
> >
> > How about moving the entire file to drivers/clocksource/timer-goldfish.c?
> > It shouldn't even be architecture specific any more at this point. It probably
> > still is in practice, but that could be addressed when another architecture
> > wants to share the implementation.
>
> For the moment I'd like to have my m68k virt machine merged, and I think it will be easier if I hit
> only one subsystem/maintainer. Moreover I don't know if I use correctly the goldfish-rtc,  so for
> the moment I think it's better if I keep it hidden in arch/m68k/virt.
>
> But I can propose to send a patch to move this code to drivers/clocksource/timer-goldfish.c once the
> machine is merged.

If you are not sure about that implementation, I would think that's an
extra reason to
submit it to the clocksource maintainers for review (added to Cc
here). You should still
be able to merge the driver in the new location through the m68k tree
as part of your
series, but regardless of where it goes I think it needs an Ack from them.

        Arnd
