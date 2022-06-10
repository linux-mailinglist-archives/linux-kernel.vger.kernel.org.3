Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7152C545D1F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346732AbiFJHWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346716AbiFJHWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:22:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67B52253B;
        Fri, 10 Jun 2022 00:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654845717;
        bh=WTXdRmpNWHVZt4Pw6LPt3l+43M1dfxQOCdp1a0FiYPU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=hxPjyxIJxmrTV9Wr7Wc0OooaZ9LifuFqDBphswy7SOyf2SDvpjgS08kh4ABF9mJ7M
         ii/f/OO1SI1Ffezne/+As1wnO24PB7jlVGPpWZOwlbDlRWGVDVkamekc83NAL1s+xG
         FhuH/nUrafWCjixHbY/5soJB9ed16Oe9fbmWaxN0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.3]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeU4y-1nRKfw2Xno-00aU5K; Fri, 10
 Jun 2022 09:21:57 +0200
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-clk@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v4 0/6] Nuvoton WPCM450 clock and reset driver
Date:   Fri, 10 Jun 2022 09:21:35 +0200
Message-Id: <20220610072141.347795-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1kuBg+7igqos6GbUcXPQEvCtiSFIGEOJEao4BKzcgU6daJds40V
 IC2kvpVWTYuqW+3qK8qc5dzrNFBw9+rXhLtvVT2cWx1zDi4kquUl8OcXbzL4354cWfAQN8Q
 bRaDCt0nJeZLKOjrxCfxqE3DcS3cBskJ0hjwvnmDs3bT3wpqoP/SXw5cpwqbkGqbxdXFwvg
 OS84VsELokgxPwrmam1Ag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:suInKowovQg=:GPGBiAoq6NlXMdOwhi509A
 qJ6kTT/m+MgUUQOlf+FfwvYpjvMkjf/DgR9bAzCtAAltaNRncBLB+9HT6gojSu8ZQI7JiQ7Yl
 17xKjq/FMr443PcHYaiEIgnNLBeThxlm45JNkFy4lBoG/G2vUVKGrylSVqeA56UuEzmnUnAS8
 JEsGDvdPt9t4pwCmLK5j+hGBpIsGUKqiQ60LjViJrvP21zwRsiSlS/oIaSs1yKOf5b83+pRTj
 9l236NGpiX5kvLuP4PAQCDBZMhKNCyW8e4nKksrRROklx8sQaUQd0SzRx/xwpq/iaFKH9ctvL
 pjT8RYkZiyVkQZVhI+oPCGI4ei5o1yofizbBL2lMQYhWEnU1Wl0cuq2FzZ88pX7hVyxGYA65R
 c/sxry/+xYh33QuiLxwV+dRBghSAa9uVTixKfD0zgxZXmS06o9G6ZmCHQ5o0Cbv9vfdYKgcMo
 cypQYWvXQAq0OrnTGmGF88K9UhclQjN66e1x5JG0ABWP8QL7iD/cuDM5C1wNlfMtQ7PBarnRq
 +tQWInPzlTmWpUTl/xmFyfbRzwSu5tBasODGewFkUhVDMbsX8vmvJmND4K8cJen6+DtETv5p4
 nP+111tvEM93Q+r8gs0nL1QOqCCE02cNKnbriDYMU7/9DdXvVVjjdyznRaI7jmVepWZpqE5bt
 jqSiUAhH8Ncwzx6EWq6AlQTMUWF2bEwE54gYeW8KSWG9VZHckwDbx0PG+MQhxYmJEskZG5vbd
 OZH/5JVZ9sbV9rHZS+C/ah32QbfbmZCclZPXDLdeMREO1iiFoTqjS3E+PsapO3Mu2etHQYWmH
 Z0pZ8QP6Do2wAsAei75dT3F56wpOfNpr3GWnc2XzvxZiEipsSRJleQajIc9WFXnu+DurJBZe/
 edDtRTIPeAxGEiTt6Vse0sCc4ELqCVra3lkQYaatveyL49mUslJYeJejqoEfkf6VjpnOboPsN
 CktHGANE8dMRf2dD54pb/A5rD8TQxSYowc9j/rjhDRIBb7JXhAMxxikVVTN63rxwhcWRmPztE
 rPx+SmLkU+zGXcyJrNQ2mhtdbwrNpNt4LVu9QoYaG8pR4iXsytct5ljD3+x8jf7QbrhXm4WzC
 iOEIn2DGt5ejCDpHS4NmIg60FXSrMul7OfTuBdspIbTq10D/6nCEesUDQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the clock and reset controller in the Nuvoton
WPCM450 SoC. This means that the clock rates for peripherals will be calcu=
lated
automatically based on the clock tree as it was preconfigured by the bootl=
oader.
The 24 MHz dummy clock, that is currently in the devicetree, is no longer =
needed.
Somewhat unfortunately, this also means that there is a breaking change on=
ce
the devicetree starts relying on the clock driver, but I find it acceptabl=
e in
this case, because WPCM450 is still at a somewhat early stage.


Upstreaming plan (although other suggestions are welcome):

Once reviewed,

- The ARM/dts changes should go through Joel Stanley's bmc tree
- The clocksource/timer changes should probably go via Daniel Lezcano and =
TIP
- The watchdog patch should go via the watchdog tree
- The clock controller bindings and driver should go through the clk tree
- It might make sense to delay the final ARM/dts patch ("ARM: dts: wpcm450=
:
  Switch clocks to clock controller") until next cycle to make sure it is
  merged after the clock driver.


v4:
- Leave WDT clock running during after restart handler
- Fix reset controller initialization
- Dropped patch 2/7 (clocksource: timer-npcm7xx: Enable timer 1 clock befo=
re use),
  as it was applied by Daniel Lezcano

v3:
- https://lore.kernel.org/lkml/20220508194333.2170161-1-j.neuschaefer@gmx.=
net/
- Changed "refclk" string to "ref"
- Fixed some dead code in the driver
- Added clk_prepare_enable call to the watchdog restart handler
- Added a few review tags

v2:
- https://lore.kernel.org/lkml/20220429172030.398011-1-j.neuschaefer@gmx.n=
et/
- various small improvements

v1:
- https://lore.kernel.org/lkml/20220422183012.444674-1-j.neuschaefer@gmx.n=
et/

Jonathan Neusch=C3=A4fer (6):
  dt-bindings: timer: nuvoton,npcm7xx-timer: Allow specifying all clocks
  watchdog: npcm: Enable clock if provided
  dt-bindings: clock: Add Nuvoton WPCM450 clock/reset controller
  ARM: dts: wpcm450: Add clock controller node
  clk: wpcm450: Add Nuvoton WPCM450 clock/reset controller driver
  ARM: dts: wpcm450: Switch clocks to clock controller

 .../bindings/clock/nuvoton,wpcm450-clk.yaml   |  66 ++++
 .../bindings/timer/nuvoton,npcm7xx-timer.yaml |   8 +-
 arch/arm/boot/dts/nuvoton-wpcm450.dtsi        |  29 +-
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-wpcm450.c                     | 364 ++++++++++++++++++
 drivers/reset/Kconfig                         |   2 +-
 drivers/watchdog/npcm_wdt.c                   |  16 +
 .../dt-bindings/clock/nuvoton,wpcm450-clk.h   |  67 ++++
 8 files changed, 544 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,wpcm45=
0-clk.yaml
 create mode 100644 drivers/clk/clk-wpcm450.c
 create mode 100644 include/dt-bindings/clock/nuvoton,wpcm450-clk.h

=2D-
2.35.1

