Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C537F4EE37B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 23:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242006AbiCaVzJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 31 Mar 2022 17:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242004AbiCaVzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 17:55:05 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2329C;
        Thu, 31 Mar 2022 14:53:15 -0700 (PDT)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1McHQA-1oAUTN2kzU-00cdqe; Thu, 31 Mar 2022 23:53:13 +0200
Received: by mail-wm1-f43.google.com with SMTP id n63-20020a1c2742000000b0038d0c31db6eso429078wmn.1;
        Thu, 31 Mar 2022 14:53:13 -0700 (PDT)
X-Gm-Message-State: AOAM5305OXLMlTXJuVThcnnOdrTLpgEYdyda/hmiJt+ilwn4OgZxhj1i
        WqRT5rdB2HBjfM8N/RtEYEcHuL5kNLUsjDUkqXc=
X-Google-Smtp-Source: ABdhPJzSHATsHDA8OPQsrpSCw7bzrU0ceQWFZH98PATzuINEPVrGLYQQfA2Y7GDA3HyQPXtd6FxMBYyz2bZIsZjTXz4=
X-Received: by 2002:a1c:f219:0:b0:38c:782c:3bb with SMTP id
 s25-20020a1cf219000000b0038c782c03bbmr6160589wmc.94.1648763593322; Thu, 31
 Mar 2022 14:53:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220310195229.109477-1-nick.hawkins@hpe.com> <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com> <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com> <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com> <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
 <PH0PR84MB17181C316E55073EBC28C386881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <PH0PR84MB17185ADBA824F9CC9EB3E022881F9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1080yz9jggOrwz2iQ1sAB2Xe2Emh22uCuqRok60BQSiA@mail.gmail.com> <PH0PR84MB17186189F5025374AA39584D88E19@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
In-Reply-To: <PH0PR84MB17186189F5025374AA39584D88E19@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 31 Mar 2022 23:52:57 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2b+ESAAkc=_2hqx0kOxwYVS6mNjMGBKhhipaSj_5jV9g@mail.gmail.com>
Message-ID: <CAK8P3a2b+ESAAkc=_2hqx0kOxwYVS6mNjMGBKhhipaSj_5jV9g@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device tree
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Verdun, Jean-Marie" <verdun@hpe.com>,
        Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:dPX2QrCBwjyyBFklQRFdGm6/RQRV4vXf4kV7XhROMWwEGX6FXrw
 KZIzwfpt4kK/Pbhfi5zJbBnMJM0Bd1iPVqK8lzN/cCjMTIqLlhaV0zdk6muZ3Z4nA/3jdDE
 4XvPZ5huUg8fBdbePoCa/CkzzlWc+EzhsLARswxnjU8wFcwAOJ0VFRKSDYyKgwVVMGJXWIH
 dhk4v+ZYe3XHXvcrfOC4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dvkznSxNqDI=:DsE35yqgJj1v1QpJsOmvkz
 E66/7cH6BsPYxD9yRpnIQubXtcDYAr8CZ6zTB2TDk9RHP6l1t1p7hcnJ5PCkUwSwHfdzG83pn
 zhM5LI5TQkxr3iFAugHgaDv75OhRMYiKrl36Kh9HQM78bOgKMvt9ucjtP8HxGVAUYmk2XisbL
 QT0ncych37ZsF8g5s1jUjQI6/iKfWTeU0acaRN3wnXyJoLUeJF2uXvkZjFGvEeVM5GMDIkQj8
 pk94zkpsqT6NuqZb0Hfz9kMz04O8TsPCeya99YUFk8BkXtJ4hbmUDmcawkDBjpNYNqB1zHC4n
 hwRzikiY/iN4CINHIsl5OAqiGMJ1dS13t7B4z64yLalldjWqAt/O1HfwgIn707W6bszjZ2+AY
 IXYvoV3UUccQp96AIQsdui/NM3AQB3FyoDZ4Kmk6O6ytIEC79YNiuWiLB7g/TKysdCDauh2Ro
 hGZGdBHSRXcRydpCKml9IO1S0s2x6FqMuRIIliP49DVttjY0fZW3h+xB8nRBM2mWBKuw2TQ3/
 5PIm0DfezXur5X3rUDw916NQ1KiHpybgcJ+v75HKMXVcyxIc4yww4I5QXk/VhihwaNu+5VOYv
 hZxXD9pUxRU7M3g1RHyrF/eA8NLkMKtZKcbfc0zZApuYgtf0JC6L3qigGIh4CUh/yIlwSdkfK
 9+ehN6+zLrcLnVL1oCLzqPOj+krSyZz4SjRw+DWk3F+JLF1NzTuSDsCoWYQFsg1+w/Lk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:09 PM Hawkins, Nick <nick.hawkins@hpe.com> wrote:
> On Thu, Mar 31, 2022 at 12:27 AM Hawkins, Nick <nick.hawkins@hpe.com> wrote:
> > On Tue, Mar 29, 2022 at 9:38 PM Hawkins, Nick <nick.hawkins@hpe.com>> wrote:
> > I'd have to study the other examples myself to see what is most common.
>
> > My feeling would be that it's better to either have a "hpe,gxp-timer" parent device with a watchdog child but no syscon, or to have a syscon/simple-mfd parent with both the timer and the watchdog as children.
>
> Arnd, thanks for the feedback. I am trying to use the approach you recommend where you have a syscon/simple-mfd parent with watchdog and timer as children.
>
> st: chip-controller@80 {
>                                 compatible = "hpe,gxp-ctrl-st","syscon","simple-mfd";
>                                 reg = <0x80 0x16>;
>
>                                 timer0: timer {
>                                         compatible = "hpe,gxp-timer";
>                                         interrupts = <0>;
>                                         interrupt-parent = <&vic0>;
>                                         clocks = <&ppuclk>;
>                                         clock-names = "ppuclk";
>                                 };
>
>                                 watchdog {
>                                         compatible = "hpe,gxp-wdt";
>                                 };
> };
>
> This compiles without any errors but I do have some questions about accessing the regmap in both drivers, specifically the timer code. How do you use a regmap with clocksource_mmio_init? I tried searching through the codebase and could not find the answer. I assume I am missing some vital step.

I don't think you can do this, if you are using the syscon regmap, you
go through the
regmap indirection rather than accessing the mmio register by virtual address,
and this may result in some extra code in your driver, and a little
runtime overhead.

If you prefer to avoid that, you can go back to having the timer node as the
parent, but without being a syscon. In this case, the watchdog would be handled
in one of these ways:

a) a child device gets created from the clocksource driver and bound to the
    watchdog driver, which then uses a private interface between the clocksource
    and the watchdog to access the registers

b) the clocksource driver itself registers as a watchdog driver, without
    having a separate driver module

One thing to consider is whether the register range here contains any
registers that may be used in another driver, e.g. a second timer,
a PWM, or a clk controller. If not, you are fairly free to pick any of these
approaches.

        Arnd
