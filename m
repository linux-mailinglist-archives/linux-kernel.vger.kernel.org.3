Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348C1582A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiG0QE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiG0QEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:04:22 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6F2491D2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:04:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bn9so14229433wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=6NrUn7E//ykFF4QQhJDK/6i3k3Gu7D6eaxZjwgfcbTM=;
        b=lfb3jPEvnfhUcOiVEqU0NK6hdjncV70kQO/e8gQ9cmp58Dj0vpmYYbzlCikJ+lWSVe
         C9bBJA07O+VwuOohfmt5qlowKa3FMQxKT3nNOQt9Rgsb1joHmnVjjVy30x0MILDlZb7V
         nMV8AeH7Z+YinSC2VfZfFbgqoeYdIqmp441mVX1UbpocRjAzUwc7fsFYP8dm+7d7/GGh
         IaXC077PHMkRp9kj/mpP1lReQOWQEMHx2CxfI7j+gltAt6u4W8AC1jAV0NHvvDlbqAjO
         FU/TVdda779L0hCzByZGds9S5sPr8O3uF64NX4cuRSaG+wubU4uzT5M5jlDjhlneU3lD
         KLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=6NrUn7E//ykFF4QQhJDK/6i3k3Gu7D6eaxZjwgfcbTM=;
        b=HyD4iYnCWzKoRXECr23AEEevMYh6J5kg17T1FSoY/MN4VMNiVGcUxnJxCzgIbfA+Xn
         jxQE/D3qOKmZm08KP6Sk49/DqCJfdPehs6NTfi/MGc2wgEwhW9AC6DzwplxafO1DKJrK
         b95hTY9VR8w3vU1oIeP/cJDLUcensZ/L+Pw8+Dv1xkXu/qGeJIZFa4R26KgzkR9jm1Zb
         u7ga8HZoTPZOVYDew04XVXMg/rRA3LtKso3VAJh5RKVgVXE/2P4/MgK/loMw1NP5tFOw
         wBpqlcgT1ViT/DzutWuSRqV5Z/LUaJPUXUBO1OKYWREIely/9COZAx4FhAoFgo4rOVxV
         TERQ==
X-Gm-Message-State: AJIora8KdELwZf/n4g5wNnIQrQqUtskJVLfDiyB5tRQ2TRT+hD35pDOf
        0vsSAYY5qjbv3PDbIzyMBbAtpw==
X-Google-Smtp-Source: AGRyM1vg/CnCRzKaOiyCAp0pY1hj4SpyrC3dqPfR9kcVOPTokuKZYv+GXpDMc6cTZAhojiK02rpt7g==
X-Received: by 2002:a05:600c:2196:b0:3a2:feff:4c42 with SMTP id e22-20020a05600c219600b003a2feff4c42mr3628523wme.163.1658937859480;
        Wed, 27 Jul 2022 09:04:19 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0? ([2a05:6e02:1041:c10:65a8:ebd8:4098:d9d0])
        by smtp.googlemail.com with ESMTPSA id h15-20020a5d430f000000b0021b5861eaf7sm17511327wrq.3.2022.07.27.09.04.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 09:04:19 -0700 (PDT)
Message-ID: <7472984e-f502-5f27-82bf-070127dd85a5@linaro.org>
Date:   Wed, 27 Jul 2022 18:04:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Samuel Holland <samuel@sholland.org>,
        XU pengfei <xupengfei@nfschina.com>,
        Li zeming <zeming@nfschina.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v5.20-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

please consider pulling the changes:

The following changes since commit 57963a92a70b037aa22544fbc34742e5be689c04:

   Merge tag 'timers-v5.19-rc1' of 
https://git.linaro.org/people/daniel.lezcano/linux into timers/core 
(2022-05-27 10:32:08 +0200)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v5.20-rc1

for you to fetch changes up to 148399c90e25bb5d1aa6f3e1dde25fec6f4005f2:

   clocksource/drivers/sun5i: Remove unnecessary (void*) conversions 
(2022-07-27 17:01:52 +0200)

----------------------------------------------------------------
- Add the missing DT bindings for the MTU nomadik timer (Linus
   Walleij)

- Fix grammar typo in the ARM global timer Kconfig option (Randy
   Dunlap)

- Add the tegra186 timer and use it on the tegra234 board (Thierry
   Reding)

- Add the 'CPUXGPT' CPU timer for Mediatek MT6795 and implement a
   workaround to overcome an ATF bug where the timer is not correctly
   initialized (AngeloGioacchino Del Regno)

- Rework the suspend/resume approach to enable the feature on the
   timer even it is not an active clock and fix a compilation warning
   (Claudiu Beznea)

- Add the Add R-Car Gen4 timer support along with the DT bindings
   (Wolfram Sang)

- Add compatible for ti,am654-timer to support AM6 SoC (Tony Lindgren)

- Fix Kconfig option to put it back to 'bool' instead of 'tristate'
   for the tegra186 (Daniel Lezcano)

- Sort 'family,type' DT bindings for the Renesas timers (Geert
   Uytterhoeven)

- Add compatible 'allwinner,sun20i-d1-timer' for Allwinner D1 (Samuel
   Holland)

- Remove unnecessary (void*) conversions for sun4i (XU pengfei)

- Remove unnecessary (void*) conversions for sun5i (Li zeming)

----------------------------------------------------------------
AngeloGioacchino Del Regno (2):
       dt-bindings: timer: mediatek: Add CPUX System Timer and MT6795 
compatible
       clocksource/drivers/timer-mediatek: Implement CPUXGPT timers

Claudiu Beznea (3):
       clocksource/drivers/timer-microchip-pit64b: Remove suspend/resume 
ops for ce
       clocksource/drivers/timer-microchip-pit64b: Use 
mchp_pit64b_{suspend, resume}
       clocksource/drivers/timer-microchip-pit64b: Fix compilation warnings

Daniel Lezcano (1):
       clocksource/drivers/tegra186: Put Kconfig option 'tristate' to 'bool'

Geert Uytterhoeven (1):
       dt-bindings: timer: renesas,cmt: Fix R-Car Gen4 fall-out

Kartik (1):
       clocksource/drivers/timer-tegra186: Add support for Tegra234 SoC

Krzysztof Kozlowski (1):
       dt-bindings: timer: ingenic,tcu: use absolute path to other schema

Li zeming (1):
       clocksource/drivers/sun5i: Remove unnecessary (void*) conversions

Linus Walleij (1):
       dt-bindings: timer: Add Nomadik MTU binding

Randy Dunlap (1):
       clocksource/drivers/arm_global_timer: Fix Kconfig "its" grammar

Samuel Holland (1):
       dt-bindings: timer: allwinner,sun4i-a10-timer: Add D1 compatible

Thierry Reding (1):
       clocksource: Add Tegra186 timers support

Tony Lindgren (4):
       clocksource/drivers/timer-ti-dm: Move inline functions to driver 
for am6
       clocksource/drivers/timer-ti-dm: Make timer selectable for ARCH_K3
       clocksource/drivers/timer-ti-dm: Add compatible for am6 SoCs
       clocksource/drivers/timer-ti-dm: Make driver selection bool for TI K3

Wolfram Sang (4):
       thermal/drivers/rcar_gen3_thermal: Add r8a779f0 support
       dt-bindings: timer: renesas,cmt: Add r8a779f0 and generic Gen4 
CMT support
       dt-bindings: timer: renesas,cmt: R-Car V3U is R-Car Gen4
       clocksource/drivers/sh_cmt: Add R-Car Gen4 support

XU pengfei (1):
       clocksource/drivers/sun4i: Remove unnecessary (void*) conversions

  .../bindings/timer/allwinner,sun4i-a10-timer.yaml  |   1 +
  .../devicetree/bindings/timer/ingenic,tcu.yaml     |   4 +-
  .../bindings/timer/mediatek,mtk-timer.txt          |   6 +-
  .../devicetree/bindings/timer/renesas,cmt.yaml     |  16 +-
  .../devicetree/bindings/timer/st,nomadik-mtu.yaml  |  58 +++
  arch/arm/mach-omap2/Kconfig                        |   2 +
  drivers/clocksource/Kconfig                        |  19 +-
  drivers/clocksource/Makefile                       |   3 +-
  drivers/clocksource/sh_cmt.c                       |   8 +
  drivers/clocksource/timer-mediatek.c               | 114 +++++
  drivers/clocksource/timer-microchip-pit64b.c       |  64 ++-
  drivers/clocksource/timer-sun4i.c                  |   2 +-
  drivers/clocksource/timer-sun5i.c                  |   2 +-
  drivers/clocksource/timer-tegra186.c               | 514 
+++++++++++++++++++++
  drivers/clocksource/timer-ti-dm.c                  | 123 +++++
  drivers/thermal/rcar_gen3_thermal.c                |   4 +
  include/clocksource/timer-ti-dm.h                  | 144 ------
  17 files changed, 893 insertions(+), 191 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/timer/st,nomadik-mtu.yaml
  create mode 100644 drivers/clocksource/timer-tegra186.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
