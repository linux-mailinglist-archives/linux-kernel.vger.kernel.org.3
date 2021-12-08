Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DEF346D8F0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 17:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbhLHQzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 11:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhLHQza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 11:55:30 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074C5C061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 08:51:58 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id r15so5825420uao.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 08:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NsPq00yIfOBpAmL7EJoPHmZ49H4SAg5EXmPB7erQLMw=;
        b=lCsuLSwfSHmuaosWw8kbB4sTHJM+gA9ROusB9lhNrc6AHVX4eoWNGLJZPvq3A9Is/X
         +yhiCcI6gAZOEqxAOj2JvxzFYF1oaqvqSrFdgzuvV0ce6ajuHiuSt3cdWMbNZ4XsCfBD
         KKmKh1TZ2r3Eah//Zt8W4aFIuTu1e7N/cQcJ3gy5GFmbhhYosku2DIORF6iQQRJMTjeN
         vI8vYD1IAT2WDk3ja8KebpdcIZCX+YqoBL/XRvr7+hGNaS6eCWyH6uQ8TUxixSXc9NUS
         dKIhAvuoYDZ4huagX2FbEk4uOS0N5Wo+1bIoLgz0Ej38FtICaclo3T7sgvdFaxnd5SRX
         S+KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NsPq00yIfOBpAmL7EJoPHmZ49H4SAg5EXmPB7erQLMw=;
        b=Qd/2L3fZJKyT5954dSAIYpa5bLR3tm+UfNlQUzGW8Zr1+30OUIr+G8qaoLNq8ZTO3w
         PrLd5MSjNKsQU3RuC1PavT85SNLlKdExjYk+y3cD++0TiHqhybN26hh9ZNjxwFgNO5v3
         Vb4GAv3LLW1Sy1fLlZ8MbeaeQ0js8m3UV322JQbcNkxLFr1udzbgjqXTP7hL5BJR2taE
         o/rmRmUNVT1W0vDwZQHhlb3C9fnu9N0MEBG+KLPA5dtY8BOCoXTU25pidpuLkPbtb1g5
         7Ju0/ucd+Jry44Dtokao+QLGHgszAaWOguD1KWhzIL32xYyZNsrnlO1idZ9RIv4XfElP
         v+lg==
X-Gm-Message-State: AOAM530ZVvAWUeLEc0d+gagVwrWFuehV9Ntx36mkwjp75bSqngMZCVUk
        DUGy1HOEafIWJeNf6FJh6K+k+Y7pqFaXNAOdkZ6I6A==
X-Google-Smtp-Source: ABdhPJzSp7LNFdlDZQpDLMZULnPfdtRwmUOM/YhcHaNNHYhtbRZiyC2gxLf1d4O1CceWOQkIDkA3Xah8GvhA+bVPr+A=
X-Received: by 2002:ab0:6002:: with SMTP id j2mr9946991ual.9.1638982316992;
 Wed, 08 Dec 2021 08:51:56 -0800 (PST)
MIME-Version: 1.0
References: <20211206153124.427102-1-virag.david003@gmail.com>
 <20211206153124.427102-8-virag.david003@gmail.com> <CAPLW+4k3Vmg0W0jVsTChHTG8+eeg=5QF+actz1Tk0vNV9w-y-A@mail.gmail.com>
 <0c7fc14b-a0d0-7d31-3a33-623f07114a80@canonical.com> <CAPLW+4=ioLewf5Hv5FO1jXjxaLrgedrzyKNtNtevTGADF9rBmw@mail.gmail.com>
 <a7d5f290-7992-b37c-fe2c-90bf3e5e83ce@canonical.com>
In-Reply-To: <a7d5f290-7992-b37c-fe2c-90bf3e5e83ce@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 8 Dec 2021 18:51:45 +0200
Message-ID: <CAPLW+4kmt1fEWG14jLJmPM0uHoyf017U7rigri47KT9Tamto=Q@mail.gmail.com>
Subject: Re: [PATCH v4 7/7] arm64: dts: exynos: Add initial device tree
 support for Exynos7885 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     David Virag <virag.david003@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Dec 2021 at 18:29, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 08/12/2021 16:37, Sam Protsenko wrote:
> > On Wed, 8 Dec 2021 at 11:05, Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >>
> >> On 07/12/2021 21:19, Sam Protsenko wrote:
> >>> On Mon, 6 Dec 2021 at 17:32, David Virag <virag.david003@gmail.com> w=
rote:
> >>>>
> >>>> Add initial Exynos7885 device tree nodes with dts for the Samsung Ga=
laxy
> >>>> A8 (2018), a.k.a. "jackpotlte", with model number "SM-A530F".
> >>>> Currently this includes some clock support, UART support, and I2C no=
des.
> >>>>
> >>>> Signed-off-by: David Virag <virag.david003@gmail.com>
> >>>> ---
> >>>> Changes in v2:
> >>>>   - Remove address-cells, and size-cells from dts, since they are
> >>>>     already in the dtsi.
> >>>>   - Lower case hex in memory node
> >>>>   - Fix node names with underscore instead of hyphen
> >>>>   - Fix line breaks
> >>>>   - Fix "-key" missing from gpio keys node names
> >>>>   - Use the form without "key" in gpio key labels on all keys
> >>>>   - Suffix pin configuration node names with "-pins"
> >>>>   - Remove "fimc_is_mclk" nodes from pinctrl dtsi for now
> >>>>   - Use macros for "samsung,pin-con-pdn", and "samsung,pin-con-pdn"
> >>>>   - Add comment about Arm PMU
> >>>>   - Rename "clock-oscclk" to "osc-clock"
> >>>>   - Include exynos-syscon-restart.dtsi instead of rewriting its cont=
ents
> >>>>
> >>>> Changes in v3:
> >>>>   - Fix typo (seperate -> separate)
> >>>>
> >>>> Changes in v4:
> >>>>   - Fixed leading 0x in clock-controller nodes
> >>>>   - Actually suffixed pin configuration node names with "-pins"
> >>>>   - Seperated Cortex-A53 and Cortex-A73 PMU
> >>>>
> >>>>  arch/arm64/boot/dts/exynos/Makefile           |   7 +-
> >>>>  .../boot/dts/exynos/exynos7885-jackpotlte.dts |  95 ++
> >>>>  .../boot/dts/exynos/exynos7885-pinctrl.dtsi   | 865 +++++++++++++++=
+++
> >>>>  arch/arm64/boot/dts/exynos/exynos7885.dtsi    | 438 +++++++++
> >>>>  4 files changed, 1402 insertions(+), 3 deletions(-)
> >>>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte=
.dts
> >>>
> >>> Shouldn't SoC and board files be sent as two separate patches? For
> >>> example, I've checked exynos5433 and exynos7, SoC support
> >>
> >> Does not have to be. DTSI by itself cannot be even compiled, so keepin=
g
> >> it a separate commit does not bring that much benefits. Especially if =
it
> >> is only one DTSI and one DTS.
> >>
> >
> > Right, the only theoretical benefit I can see is reverting the board
> > dts in future, if another board already uses SoC dtsi. Or
> > cherry-picking in similar manner. Not my call though, for me it just
> > seems easier to review it that way, and more atomic.
> >
> >>>
> >>>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dt=
si
> >>>>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7885.dtsi
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/exynos/Makefile b/arch/arm64/boot/d=
ts/exynos/Makefile
> >>>> index b41e86df0a84..c68c4ad577ac 100644
> >>>> --- a/arch/arm64/boot/dts/exynos/Makefile
> >>>> +++ b/arch/arm64/boot/dts/exynos/Makefile
> >>>> @@ -1,6 +1,7 @@
> >>>>  # SPDX-License-Identifier: GPL-2.0
> >>>>  dtb-$(CONFIG_ARCH_EXYNOS) +=3D \
> >>>> -       exynos5433-tm2.dtb      \
> >>>> -       exynos5433-tm2e.dtb     \
> >>>> -       exynos7-espresso.dtb    \
> >>>> +       exynos5433-tm2.dtb              \
> >>>> +       exynos5433-tm2e.dtb             \
> >>>> +       exynos7-espresso.dtb            \
> >>>> +       exynos7885-jackpotlte.dtb       \
> >>>>         exynosautov9-sadk.dtb
> >>>> diff --git a/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts b/=
arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> >>>> new file mode 100644
> >>>> index 000000000000..f5941dc4c374
> >>>> --- /dev/null
> >>>> +++ b/arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
> >>>> @@ -0,0 +1,95 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * Samsung Galaxy A8 2018 (jackpotlte/SM-A530F) device tree source
> >>>> + *
> >>>> + * Copyright (c) 2021 Samsung Electronics Co., Ltd.
> >>>> + * Copyright (c) 2021 D=C3=A1vid Vir=C3=A1g
> >>>> + *
> >>>
> >>> This line is not needed.
> >>>
> >>>> + */
> >>>> +
> >>>> +/dts-v1/;
> >>>
> >>> Suggest adding empty line here.
> >>>
> >>>> +#include "exynos7885.dtsi"
> >>>> +#include <dt-bindings/gpio/gpio.h>
> >>>> +#include <dt-bindings/input/input.h>
> >>>> +#include <dt-bindings/interrupt-controller/irq.h>
> >>>> +
> >>>> +/ {
> >>>> +       model =3D "Samsung Galaxy A8 (2018)";
> >>>> +       compatible =3D "samsung,jackpotlte", "samsung,exynos7885";
> >>>> +       chassis-type =3D "handset";
> >>>> +
> >>>> +       aliases {
> >>>> +               serial0 =3D &serial_0;
> >>>> +               serial1 =3D &serial_1;
> >>>> +               serial2 =3D &serial_2;
> >>>
> >>> Suggestion: add aliases also for i2c nodes, to keep i2c instance
> >>> numbers fixed in run-time (e.g. in "i2cdetect -l" output).
> >>>
> >>>> +       };
> >>>> +
> >>>> +       chosen {
> >>>> +               stdout-path =3D &serial_2;
> >>>> +       };
> >>>> +
> >>>> +       memory@80000000 {
> >>>> +               device_type =3D "memory";
> >>>> +               reg =3D <0x0 0x80000000 0x3da00000>,
> >>>> +                     <0x0 0xc0000000 0x40000000>,
> >>>> +                     <0x8 0x80000000 0x40000000>;
> >>>> +       };
> >>>> +
> >>>> +       gpio-keys {
> >>>> +               compatible =3D "gpio-keys";
> >>>> +               pinctrl-names =3D "default";
> >>>> +               pinctrl-0 =3D <&key_volup &key_voldown &key_power>;
> >>>> +
> >>>> +               volup-key {
> >>>> +                       label =3D "Volume Up";
> >>>> +                       interrupts =3D <5 IRQ_TYPE_LEVEL_HIGH 0>;
> >>>
> >>> Here and below: what is 0, why it's needed? Also, isn't it enough to
> >>> have just "gpios", and remove interrupt*? Need to check "gpio-keys"
> >>> driver and bindings doc, but AFAIR it should be enough to have just
> >>> "gpios =3D" or just "interrupts =3D".
> >>
> >> "gpios" is enough, because the IRQ line is derived from it. However
> >> explicitly describing interrupts seems like a more detailed hardware
> >> description.
> >>
> >
> > Frankly I don't think it's more detailed, it states the same thing
> > (gpa1 controller, line=3D5).
>
> It states that interrupt is exactly the same as GPIO which not
> explicitly coming from bindings.
>
> > Also not sure if level interrupt is needed
> > for a key, maybe edge type would be better. Also, I still don't
> > understand 0 in the end.
>
> Indeed this part looks not correct - the leve and 0 at the end. In such
> case better to skip it then define misleading property.
>
> > Checking existing dts's, most of those only
> > define "gpios". I'd say having only "gpios" is more obvious, and will
> > work the same way. But that's not a strong preference on my side, just
> > think it's a bit misleading right now.
>
> Yep.
>
> >
> >>>
> >>>
> >>>> +                       interrupt-parent =3D <&gpa1>;
> >>>> +                       linux,code =3D <KEY_VOLUMEUP>;
> >>>> +                       gpios =3D <&gpa1 5 GPIO_ACTIVE_LOW>;
> >>>> +               };
> >>>> +
> >>>> +               voldown-key {
> >>>> +                       label =3D "Volume Down";
> >>>> +                       interrupts =3D <6 IRQ_TYPE_LEVEL_HIGH 0>;
> >>>> +                       interrupt-parent =3D <&gpa1>;
> >>>> +                       linux,code =3D <KEY_VOLUMEDOWN>;
> >>>> +                       gpios =3D <&gpa1 6 GPIO_ACTIVE_LOW>;
> >>>> +               };
> >>>> +
> >>>> +               power-key {
> >>>> +                       label =3D "Power";
> >>>> +                       interrupts =3D <7 IRQ_TYPE_LEVEL_HIGH 0>;
> >>>> +                       interrupt-parent =3D <&gpa1>;
> >>>> +                       linux,code =3D <KEY_POWER>;
> >>>> +                       gpios =3D <&gpa1 7 GPIO_ACTIVE_LOW>;
> >>>> +                       wakeup-source;
> >>>> +               };
> >>>> +       };
> >>>> +};
> >>>> +
> >>>
> >>> If there are some LEDs by chance on that board -- it might be useful
> >>> to define those here with "gpio-leds" as well. Maybe even set some
> >>> default trigger like "heartbeat".
> >>>
> >>>> +&serial_2 {
> >>>> +       status =3D "okay";
> >>>> +};
> >>>> +
> >>>> +&pinctrl_alive {
> >>>> +       key_volup: key-volup-pins {
> >>>> +               samsung,pins =3D "gpa1-5";
> >>>> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_F>;
> >>>
> >>> Maybe EXYNOS_PIN_FUNC_EINT is more self-explanatory? Just a suggestio=
n though.
> >>>
> >>>> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> >>>> +               samsung,pin-drv =3D <0>;
> >>>
> >>> Here and below: please use EXYNOS5420_PIN_DRV_LV1 (means drive level =
=3D 1x).
> >>
> >> But are these drive level 1x? The Exynos Auto v9 has different values
> >> than older ones.
> >>
> >
> > It should be that. One way to implicitly figure that out is to look at
> > nodes like "sd0_clk_fast_slew_rate_3x" and those pin-drv properties.
> > Also, in Exynos850 for most of domains those constants are
> > appropriate, that's why I mentioned that.
>
> Then I agree, use existing macros. The macros can be skipped for cases
> when the meaning is different.
>
> >
> >>>
> >>>> +       };
> >>>> +
> >>>> +       key_voldown: key-voldown-pins {
> >>>> +               samsung,pins =3D "gpa1-6";
> >>>> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_F>;
> >>>> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> >>>> +               samsung,pin-drv =3D <0>;
> >>>> +       };
> >>>> +
> >>>> +       key_power: key-power-pins {
> >>>> +               samsung,pins =3D "gpa1-7";
> >>>> +               samsung,pin-function =3D <EXYNOS_PIN_FUNC_F>;
> >>>> +               samsung,pin-pud =3D <EXYNOS_PIN_PULL_NONE>;
> >>>> +               samsung,pin-drv =3D <0>;
> >>>> +       };
> >>>> +};
> >>>> diff --git a/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi b/ar=
ch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
> >>>> new file mode 100644
> >>>> index 000000000000..8336b2e48858
> >>>> --- /dev/null
> >>>> +++ b/arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
> >>>> @@ -0,0 +1,865 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * Samsung Exynos7885 SoC pin-mux and pin-config device tree source
> >>>> + *
> >>>> + * Copyright (c) 2017 Samsung Electronics Co., Ltd.
> >>>> + * Copyright (c) 2021 D=C3=A1vid Vir=C3=A1g
> >>>> + *
> >>>> + * Samsung's Exynos7885 SoC pin-mux and pin-config options are list=
ed as
> >>>> + * device tree nodes in this file.
> >>>> + */
> >>>> +
> >>>> +#include <dt-bindings/pinctrl/samsung.h>
> >>>
> >>> You probably also need <dt-bindings/interrupt-controller/arm-gic.h>
> >>> here for GIC_SPI definition.
> >>>
> >>>> +
> >>>> +&pinctrl_alive {
> >>>> +       etc0: etc0 {
> >>>> +               gpio-controller;
> >>>> +               #gpio-cells =3D <2>;
> >>>> +
> >>>> +               interrupt-controller;
> >>>> +               #interrupt-cells =3D <2>;
> >>>> +       };
> >>>> +
> >>>> +       etc1: etc1 {
> >>>> +               gpio-controller;
> >>>> +               #gpio-cells =3D <2>;
> >>>> +
> >>>> +               interrupt-controller;
> >>>> +               #interrupt-cells =3D <2>;
> >>>> +       };
> >>>
> >>> Hmm, what are these two? I can't find anything related in
> >>> exynos7885.dtsi. If it's just some leftover from downstream vendor
> >>> kernel -- please remove it.
> >>
> >> This is a pinctrl DTSI file. What do you expect to find in
> >> exynos7885.dtsi for these? Why removing them?
> >
> > etc0 and etc1 nodes are defined as gpio-controller and
> > interrupt-controller. So "compatible" should be provided somewhere for
> > those nodes. For example, for "gpa0" node below you can find its
> > compatible in exynos7885.dtsi.
>
> I am sorry, I still don't get it. gpa0 below does not have compatible.
>

I was probably groggy and missed the fact those etc* nodes are child
nodes of pinctrl_alive :) And now I can see those are actually
described in pinctrl-exynos-arm64.c (in linux-next, where 7885 pinctrl
support is added). Please ignore my request w.r.t. etc* nodes, those
should stay of course.

> > Right now I don't understand how those
> > etc0 and etc1 can be used at all.
>
> Exactly the same as gpa0, nothing changes here.
>
> >  So maybe it's better to just remove
> > those? Those are not used anywhere and we probably don't even know
> > what those nodes represent. My point is, if those are actually some
> > leftovers from vendor kernel and those are not going to be used (and I
> > don't see how, without "compatible"), then we probablly better off
> > without those.
>
> I don't have the manual but in other SoCs these are not left-overs, but
> real GPIO banks. Their configurability depends on the SoCs. I agree that
> usually they are not used (because one of the uses is debugging), but
> they can be included for completness of HW description. Assuming they exi=
st.
>
> (...)
>
> >>>> +#include "exynos7885-pinctrl.dtsi"
> >>>> +#include "arm/exynos-syscon-restart.dtsi"
> >>>
> >>> Have you verified both reboot and power off functions from this file?
> >>> I guess if some doesn't work, it's better to avoid including this, bu=
t
> >>> instead add corresponding sub-nodes into your pmu_sytem_controller.
> >>
> >> Why open-coding same code work and including would not? Assuming that =
it
> >> compiles, of course.
> >>
> >
> > For example, in case of Exynos850 the "power off" node from this file
> > wasn't suitable. In that case it's not worth including it. But David
> > already confirmed both work fine for him, so it doesn't matter
> > anymore.
>
> These nodes were here before and since they duplicated common syscon, I
> asked to use DTSI. The boards which do not use the same syscon
> registers/methods should not include it, obviously. :)
>
>
> Best regards,
> Krzysztof
