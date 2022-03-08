Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F054D148F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 11:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345765AbiCHKSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 05:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345805AbiCHKR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 05:17:58 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1427342A37
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 02:17:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k29-20020a05600c1c9d00b003817fdc0f00so1135473wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 02:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=HdfldeRXis5xg5itaSC4cjdq2Dglhbwr4/3jp/FVqVE=;
        b=uSDpizh7GugWh6z6YLQC0VFL3fvdm/BfxDWa314D6b3lx8h7gYs6Wq4CqepcE+e3qS
         q03hB5w8YIKctW4ozl45eFueXpFZmfiZmoq2kHOSQdDZ1GgGv8dVb2xrjrmwnrhmt84Z
         r9S7rRN8OFCwZZ/MsioJj9uK5MvsreTOuT0tbdmBdN5z+KR8Pa4CqDOiiTI4xEBQm9C9
         5oI1eE3FZBW63e43zhdFiLcquE83iDZUO0H05kWHhABkoyv2f/o8d4vm/rZhia0YjY69
         F9Xdm5YJslUx3s1vEmT+3r/5n/CWX1MF7UN6+3y83fTyNCEBJMN1Ym8XLEthM8o9xFHz
         lTZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=HdfldeRXis5xg5itaSC4cjdq2Dglhbwr4/3jp/FVqVE=;
        b=Oy8V6MuAXv5DI2/lfL7QyUNTKbPCKYJCngVf7KemONI6kl3kaIIbVYykOzog38An2R
         er3jeTfkRliD9oGEZVo54HEqK6mpksWb4k+Id7iGooGhGwH2KylJkRopyYsDlR1IEuAC
         H3+PynRyNcExFYf7wz2ipApGmSA8ARlsqSW1jISQ4xPHsqPiQCm3SqFHsQYZ2eJC/c3l
         EQQdDB68T+QMrHuhPtK/u7eMJ3LrBfiNVDk3Qbj9/g7nSHOSMYdYS8ztJx9J+MH0HaV8
         cnPVzaiUOPyyrGO+3JJe1xV7A1MCDtm6XzoQyiEskyNwcNSsdU2Htmyqs6KKFP7wKtxB
         uI1g==
X-Gm-Message-State: AOAM530Ra+eAAoapF/9+EGPGdIs4L2IOQNtRejzCdlOz+a4969IoXpSG
        dUfRlGb+yEzRbaaIADOaY33KFg==
X-Google-Smtp-Source: ABdhPJy3zRSaMNPDhF0tBtIeeLu8X/mhKpIgyAZxS8NSMClS+T9QRt+fsXDtfjCnioxFmZ0FiW30vA==
X-Received: by 2002:a05:600c:4611:b0:389:9f47:30cd with SMTP id m17-20020a05600c461100b003899f4730cdmr2924964wmo.185.1646734619516;
        Tue, 08 Mar 2022 02:16:59 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:6cbe:1901:15e:e188? ([2a01:e34:ed2f:f020:6cbe:1901:15e:e188])
        by smtp.googlemail.com with ESMTPSA id l5-20020a5d6745000000b001f1e4e40e42sm7657953wrw.77.2022.03.08.02.16.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 02:16:58 -0800 (PST)
Message-ID: <a8cd9be9-7d70-80df-2b74-1a8226a215e1@linaro.org>
Date:   Tue, 8 Mar 2022 11:16:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        David Heidelberg <david@ixit.cz>,
        Drew Fustini <dfustini@baylibre.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Marc Zyngier <Marc.Zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peng Fan <peng.fan@nxp.com>, granquet@baylibre.com
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v5.18-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

please consider pulling,


The following changes since commit 35e13e9da9afbce13c1d36465504ece4e65f24fe:

   Merge branch 'clocksource' of 
git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into 
timers/core (2022-01-10 13:57:17 +0100)

are available in the Git repository at:

   https://git.linaro.org/people/daniel.lezcano/linux.git 
tags/timers-v5.18-rc1

for you to fetch changes up to 4467b8bad2401794fb89a0268c8c8257180bf60f:

   clocksource/drivers/timer-of: Check return value of of_iomap in 
timer_of_base_init() (2022-03-07 19:21:25 +0100)

Thanks

   -- Daniel

----------------------------------------------------------------
- Fix return error code check for the timer-of layer when getting
   the base address (Guillaume Ranquet)

- Remove MMIO dependency, add notrace annotation for sched_clock
   and increase the timer resolution for the Microchip
   PIT64b (Claudiu Beznea)

- Convert DT bindings to yaml for the Tegra timer (David Heidelberg)

- Fix compilation error on architecture other than ARM for the
   i.MX TPM (Nathan Chancellor)

- Add support for the event stream scaling for 1GHz counter on
   the arch ARM timer (Marc Zyngier)

- Support a higher number of interrupts by the Exynos MCT timer
   driver (Alim Akhtar)

- Detect and prevent memory corruption when the specified number
   of interrupts in the DTS is greater than the array size in the
   code for the Exynos MCT timer (Krzysztof Kozlowski)

- Fix regression from a previous errata fix on the TI DM
   timer (Drew Fustini)

- Several fixes and code improvements for the i.MX TPM
   driver (Peng Fan)

----------------------------------------------------------------
Alim Akhtar (3):
       clocksource/drivers/exynos_mct: Remove mct interrupt index enum
       clocksource/drivers/exynos_mct: Bump up mct max irq number
       clocksource/drivers/exynos_mct: Increase the size of name array

Claudiu Beznea (3):
       clocksource/drivers/timer-microchip-pit64b: Remove mmio selection
       clocksource/drivers/timer-microchip-pit64b: Use notrace
       clocksource/drivers/timer-microchip-pit64b: Use 5MHz for clockevent

David Heidelberg (1):
       dt-bindings: timer: Tegra: Convert text bindings to yaml

Drew Fustini (1):
       clocksource/drivers/timer-ti-dm: Fix regression from errata i940 fix

Guillaume Ranquet (1):
       clocksource/drivers/timer-of: Check return value of of_iomap in 
timer_of_base_init()

Krzysztof Kozlowski (1):
       clocksource/drivers/exynos_mct: Handle DTS with higher number of 
interrupts

Marc Zyngier (1):
       clocksource/drivers/arm_arch_timer: Use event stream scaling when 
available

Nathan Chancellor (1):
       clocksource/drivers/imx-tpm: Move tpm_read_sched_clock() under 
CONFIG_ARM

Peng Fan (6):
       clocksource/drivers/imx-sysctr: Drop IRQF_IRQPOLL
       clocksource/drivers/imx-tpm: Drop IRQF_IRQPOLL
       clocksource/drivers/imx-tpm: Mark two variable with __ro_after_init
       clocksource/drivers/imx-tpm: Add CLOCK_EVT_FEAT_DYNIRQ
       clocksource/drivers/imx-tpm: Update name of clkevt
       clocksource/drivers/imx-tpm: Exclude sched clock for ARM64

  .../bindings/timer/nvidia,tegra-timer.yaml         | 150 
+++++++++++++++++++++
  .../bindings/timer/nvidia,tegra20-timer.txt        |  24 ----
  .../bindings/timer/nvidia,tegra210-timer.txt       |  36 -----
  .../bindings/timer/nvidia,tegra30-timer.txt        |  28 ----
  arch/arm/boot/dts/dra7-l4.dtsi                     |   5 +-
  arch/arm/boot/dts/dra7.dtsi                        |   8 +-
  drivers/clocksource/Kconfig                        |   1 -
  drivers/clocksource/arm_arch_timer.c               |  13 +-
  drivers/clocksource/exynos_mct.c                   |  39 +++---
  drivers/clocksource/timer-imx-sysctr.c             |   2 +-
  drivers/clocksource/timer-imx-tpm.c                |  14 +-
  drivers/clocksource/timer-microchip-pit64b.c       |   8 +-
  drivers/clocksource/timer-of.c                     |   6 +-
  drivers/clocksource/timer-ti-dm-systimer.c         |   4 +-
  include/clocksource/arm_arch_timer.h               |   1 +
  15 files changed, 205 insertions(+), 134 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/timer/nvidia,tegra-timer.yaml
  delete mode 100644 
Documentation/devicetree/bindings/timer/nvidia,tegra20-timer.txt
  delete mode 100644 
Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
  delete mode 100644 
Documentation/devicetree/bindings/timer/nvidia,tegra30-timer.txt

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
