Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EB1530FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235160AbiEWL7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 07:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235029AbiEWL7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 07:59:02 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4E81CB1C;
        Mon, 23 May 2022 04:58:59 -0700 (PDT)
Received: from mail-yb1-f173.google.com ([209.85.219.173]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mn2iP-1nT52E0Xbj-00k5Tu; Mon, 23 May 2022 13:58:57 +0200
Received: by mail-yb1-f173.google.com with SMTP id a3so24960405ybg.5;
        Mon, 23 May 2022 04:58:56 -0700 (PDT)
X-Gm-Message-State: AOAM532veqWEdm/lhII2OzRXSKBOkHqyrMl9LFSUykEXp2oHMti99YIr
        XHpY3GjPUUXf5iVhbHnpRDhlpNzVAZI6mQPiiyI=
X-Google-Smtp-Source: ABdhPJww6UI3VHujKsiD4GORINdaaD7sInRUTDtpI+wOKYOknAfrhPLfgU/Tcrezf+twApFr3bW/yO+tBPWuypHA/W0=
X-Received: by 2002:a25:c747:0:b0:64f:62fb:f55e with SMTP id
 w68-20020a25c747000000b0064f62fbf55emr13692906ybe.106.1653299558644; Mon, 23
 May 2022 02:52:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220522155046.260146-1-tmaimon77@gmail.com>
In-Reply-To: <20220522155046.260146-1-tmaimon77@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 23 May 2022 11:52:22 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2CUy17vbd5Go523894vcF_oLz=dAR7JNLsUuR1Gsc9sA@mail.gmail.com>
Message-ID: <CAK8P3a2CUy17vbd5Go523894vcF_oLz=dAR7JNLsUuR1Gsc9sA@mail.gmail.com>
Subject: Re: [PATCH v1 00/19] Introduce Nuvoton Arbel NPCM8XX BMC SoC
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        robert.hancock@calian.com,
        "nathan=20Neusch=C3=A4fer?=" <j.neuschaefer@gmx.net>,
        Lubomir Rintel <lkundrak@v3.sk>, SoC Team <soc@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:K2R+uAYYvavIOQlbMP3GLCeRXnol3L+0VpJyijg1+MUeIWxNLX7
 lNFWjJX6Cv4Is7pwQkqi+RoqhDoEwUE378KnS4nslJeKUWa4650jXF+D2LPeoM1XCs7QGvw
 MpKbPu/uiR2Rfhau1JOLSKA93AIsrltZjMkDphSwbaLua95IcOfLpqQJfs4U5yNJRYWg+gh
 NgsZ5HOHmJaiPgTfsswuA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:leD/+n0eHbs=:mDqVauFrvVHcOs81g3yIXC
 MTLRWcCg76/Ryh14JfUC37tXuFN4ICUccXdk9dp84bpNcEczf10bpN3I6sghDBi1BDiHoM4No
 RtQ3wUYCkbV084hfn41QnJJytlO2/+J0mt8TZXU6gx1pe7NXfWLw4xO3xGNgLbK3C60nAyPVP
 LaA0UumGtVwOpWDyuKILdH+/eAVuL7cjyU86OeybvtAtxOWC4OG4EnUjYFVzuZskeJVgNnahr
 jaCsklePVvLqWNi9VYhTl7lm84o/FlFu5hqT2aQHtV9GGlQ5n6otkcrUI6c1uWG3CLGa+EOR3
 Vf1upv32PaGG9VWIXIWuQJuGMzmT8JYJAG7w3zFbCQzW0LQSnb21N1hwIGkLb16C414gvByce
 68Osn/r8eDXqCs804PL69yZYBkVNXdrbHM9JcMPvnoPDkLoqbiX4fEAzOhyeeTo7i6/4QCfKy
 MZBEdP7cABkJYQpyy9UCrD2XRO2TmKYYEp85jeycA0hwh+gpHfwlLYkK1PbuExIngScxRRkYt
 BcNQ0CR3GDph53q81ianNmLrRz+rBFeH+LyTwZvg3h1BE+lHqvaxvC+4lf/yNR978FYaGQWuc
 LxYojiRfRiGy3dU8UAcG2NCv5O+iQLMGLIlBdi0UEtnlk0JLo6PB5hry1yOvVzPjj2W+hHlBa
 USUxfhJTxxMdMWG8Ia31kgurB1rHC1sEoxNSFBalWMAvqjTsDtmuzX37SKR/bLcsryFd9khpS
 3IOfue31wKTaozFrI+ue4XmzXp9bt18Q+2WX6LybAxm3npWpYu64o/0AeP2xWQH03bX4YA3FJ
 Rqc2yA0Llk0nSzi+0Cv+5xpHytwSB7WnTpCVOlSE1KrTQbHr+oiip/Lxb4JkpiEClEqBsU7K5
 smDV24Nm2eKEMbW1WwgFKql5lxbIZ2nSJc4e/IlMQ=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 5:50 PM Tomer Maimon <tmaimon77@gmail.com> wrote:
>
> This patchset  adds initial support for the Nuvoton
> Arbel NPCM8XX Board Management controller (BMC) SoC family.
>
> The Nuvoton Arbel NPCM8XX SoC is a fourth-generation BMC.
> The NPCM8XX computing subsystem comprises a quadcore ARM
> Cortex A35 ARM-V8 architecture.
>
> This patchset adds minimal architecture and drivers such as:
> Clocksource, Clock, Reset, and WD.
>
> Some of the Arbel NPCM8XX peripherals are based on Poleg NPCM7XX.
>
> This patchset was tested on the Arbel NPCM8XX evaluation board.

Thanks for your submission. Please note a few things about the process here:

- The merge window is currently open, which means a lo

Some of the Arbel NPCM8XX peripherals are based on Poleg NPCM7XX.

This patchset was tested on the Arbel NPCM8XX evaluation board.

Tomer Maimon (19):
  dt-bindings: timer: npcm: Add npcm845 compatible string
  clocksource: timer-npcm7xx: Add NPCM845 timer support
  dt-bindings: serial: 8250: Add npcm845 compatible string
  tty: serial: 8250: Add NPCM845 UART support
  dt-bindings: watchdog: npcm: Add npcm845 compatible string
  watchdog: npcm_wdt: Add NPCM845 watchdog support
  dt-binding: clk: npcm845: Add binding for Nuvoton NPCM8XX Clock
  clk: npcm8xx: add clock controller
  dt-bindings: reset: add syscon property
  reset: npcm: using syscon instead of device data
  dt-bindings: reset: npcm: Add support for NPCM8XX
  reset: npcm: Add NPCM8XX support
  dt-bindings: arm: npcm: Add maintainer
  dt-bindings: arm: npcm: Add nuvoton,npcm845 compatible string
  dt-bindings: arm: npcm: Add nuvoton,npcm845 GCR compatible string
  arm64: npcm: Add support for Nuvoton NPCM8XX BMC SoC
  arm64: dts: nuvoton: Add initial NPCM8XX device tree
  arm64: dts: nuvoton: Add initial NPCM845 EVB device tree
  arm64: defconfig: Add Nuvoton NPCM family supportt of maintainers
  won't be reviewing your patches at the moment. It may be better to wait
  for the -rc1 to be out before sending out v2

- don't send your patches to soc@kernel.org unless you want me to pick
  them up into the soc tree and they have been reviewed already. The series
  is clearly still under review at the moment, and I expect it to go through
  a few revisions first.

- gmail marked your emails as possible spam for me. I don't know what
  happened here, but you may want to look into this to ensure that
  everybody receives it.

Some of the Arbel NPCM8XX peripherals are based on Poleg NPCM7XX.

This patchset was tested on the Arbel NPCM8XX evaluation board.

Tomer Maimon (19):
  dt-bindings: timer: npcm: Add npcm845 compatible string
  clocksource: timer-npcm7xx: Add NPCM845 timer support
  dt-bindings: serial: 8250: Add npcm845 compatible string
  tty: serial: 8250: Add NPCM845 UART support
  dt-bindings: watchdog: npcm: Add npcm845 compatible string
  watchdog: npcm_wdt: Add NPCM845 watchdog support
  dt-binding: clk: npcm845: Add binding for Nuvoton NPCM8XX Clock
  clk: npcm8xx: add clock controller
  dt-bindings: reset: add syscon property
  reset: npcm: using syscon instead of device data
  dt-bindings: reset: npcm: Add support for NPCM8XX
  reset: npcm: Add NPCM8XX support
  dt-bindings: arm: npcm: Add maintainer
  dt-bindings: arm: npcm: Add nuvoton,npcm845 compatible string
  dt-bindings: arm: npcm: Add nuvoton,npcm845 GCR compatible string
  arm64: npcm: Add support for Nuvoton NPCM8XX BMC SoC
  arm64: dts: nuvoton: Add initial NPCM8XX device tree
  arm64: dts: nuvoton: Add initial NPCM845 EVB device tree
  arm64: defconfig: Add Nuvoton NPCM family support

- For an initial platform submission, I can merge the
  clk/clocksource/serial/reset drivers along with the platform if they
  have an Ack from the subsystem maintainers. I would normally
  not include the watchdog patch in this as it's not essential, but
  I suppose that it's fine if you only do a oneline change and it
  has an Ack. If you have other nonessential drivers that need changes,
  best submit them separately though.

         Arnd
