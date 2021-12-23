Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902FA47E577
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 16:28:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348979AbhLWP2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 10:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbhLWP2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 10:28:24 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9F2C061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 07:28:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n14-20020a7bcbce000000b00332f4abf43fso3483949wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 07:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=q7RTGfQtH/veGPXUg27/tBq1XXqBcC4whZoLOAq5QxI=;
        b=i2ETA83ZXfgVeWak/c6dcgKAtXkLEkjcgBbwiXlmBudojESr0toLiY+m9brhInTDM7
         KJ2aurYS+QCcAyDJBZDRmdmul47Vz6kBCWRUr3s/TKTaC9HatNYAZQSayX1oy2vb7AAw
         7U4kk7Ejz2UqK5zPqWZouz8Yk7V7nBmGIJKatLTnZxbbzQNOAPVB1t+Onz66vp7S8BKg
         teeW0QDk6BOX6oxgr/ca8aJFZMJp+ZmpnQZQ5/uguIrLQj7SvxdSuI+YYDjAPkCWofEy
         u/VPugL0c+AUBJaGIeOYT0/PduOydiYch5ay6kLGqi/ANd/++geAbBCX/2NaoAoH0ItM
         VofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=q7RTGfQtH/veGPXUg27/tBq1XXqBcC4whZoLOAq5QxI=;
        b=5UkhBsJFhziDKFTr4weAjOgFV28z4US+EUZmpD7COTLy00jt/5n+hFvCBw4dSZflme
         0UpXAlrBYOvrSef0eH5DTAPi8URhEuj7SuoUoV1on5cl36f3Fa70ItfWdg5bs/daRhoW
         3G+v0Sf4n/glrraUo6CzajC7b7GlqFajq4dsDHitDQuN3gFzk3MJaW2pajOiLXxXkXBR
         hPB6ZnQks5sLW9+KKYBKCCYxNSE8EiHo4RW1Z15l75O8sRQIMFyl9LaMEnoHWGKyxLKz
         F7nF/gP0LK02345jeeQbelYNTrraahfgUiLTE93cs1tJ4J23ru/T9UwCw4/HylZGEC1D
         NtEw==
X-Gm-Message-State: AOAM53176/nRPj05HCBZJJf9UFZKGGXLcyNH5eZzCnGgVSd+GqgPdFeY
        hCwej+44wzPFZcX1GVTQiEGoj39wHAf8Fg==
X-Google-Smtp-Source: ABdhPJwf7iLNHqzqsfmCWSP7lLpMfpit2/QWoM/RyIMl6kJ/ztFed4v5vXKOnEx0gakfTaArXcpjSA==
X-Received: by 2002:a05:600c:1d08:: with SMTP id l8mr2188066wms.44.1640273302727;
        Thu, 23 Dec 2021 07:28:22 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:34ca:f67b:b782:1949? ([2a01:e34:ed2f:f020:34ca:f67b:b782:1949])
        by smtp.googlemail.com with ESMTPSA id l25sm4916434wmh.18.2021.12.23.07.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Dec 2021 07:28:22 -0800 (PST)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das@bp.renesas.com>,
        Drew Fustini <dfustini@baylibre.com>, jacky.baip@gmail.com,
        Johan Jonker <jbx6244@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Peng Fan <peng.fan@nxp.com>,
        Romain Perier <romain.perier@gmail.com>,
        Will Deacon <will@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [GIT PULL] timer drivers for v5.17
Message-ID: <e093c706-c98d-29ee-0102-78b6d41c6164@linaro.org>
Date:   Thu, 23 Dec 2021 16:28:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,

please consider the following changes for v5.17.

Note this depends on the immutable branch:

reset/of-get-optional-exclusive' of git://git.pengutronix.de/pza/linux

"Add optional variant of of_reset_control_get_exclusive(). If the
requested reset is not specified in the device tree, this function
returns NULL instead of an error."

Thanks

  -- Daniel


The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  https://git.linaro.org/people/daniel.lezcano/linux.git
tags/timers-v5.17-rc1

for you to fetch changes up to 7647204c2e81b28b4a7c4eec7d539f998d48eaf0:

  dt-bindings: timer: Add Mstar MSC313e timer devicetree bindings
documentation (2021-12-20 13:28:47 +0100)

----------------------------------------------------------------
- Refactor resource allocation on the Exynos_mct driver without
  functional changes (Marek Szyprowski)

- Add imx8ulp compatible string for NPX TPM driver (Jacky Bai)

- Fix comma introduced by error by replacing it by the initial
  semicolon on the Exynos_mct (Will Deacon)

- Add OSTM driver support on Renesas. The reset line must be
  deasserted before accessing the registers. This change depends on an
  external change resulting in a shared immutable branch
  'reset/of-get-optional-exclusive' from
  git://git.pengutronix.de/pza/linux (Biju Das)

- Make the OSTM Kconfig option visible to user in order to let him
  disable it when ARM architected timers is enabled (Biju Das)

- Tag two variables on iMX sysctr _ro_afterinit (Peng Fan)

- Set the cpumask to cpu_possible_mask in order to have full benefit
  of the DYNIRQ flag on iMX sysctr (Peng Fan)

- Tag __maybe_unused a variable in the Pistachio timer driver in order
  to fix a warning reported by the kernel test robot (Drew Fustini)

- Add MStar MSC313e timer support and the ssd20xd-based variant, as
  well as the DT bindings (Romain Perier)

- Remove the incompatible compatible string for the rk3066 (Johan
  Jonker)

- Fix dts_check warnings on the cadence ttc driver by adding the power
  domain bindings (Michal Simek)

----------------------------------------------------------------
Biju Das (4):
      reset: Add of_reset_control_get_optional_exclusive()
      dt-bindings: timer: renesas: ostm: Document Renesas RZ/G2L OSTM
      clocksource/drivers/renesas-ostm: Add RZ/G2L OSTM support
      clocksource/drivers/renesas,ostm: Make RENESAS_OSTM symbol visible

Daniel Lezcano (1)
      Merge branch 'reset/of-get-optional-exclusive' of
git://git.pengutronix.de/pza/linux into timers/drivers/next

Drew Fustini (1):
      clocksource/drivers/pistachio: Fix -Wunused-but-set-variable warning

Jacky Bai (1):
      dt-bindings: timer: tpm-timer: Add imx8ulp compatible string

Johan Jonker (1):
      dt-bindings: timer: remove rockchip,rk3066-timer compatible string
from rockchip,rk-timer.yaml

Marek Szyprowski (1):
      clocksource/drivers/exynos_mct: Refactor resources allocation

Michal Simek (1):
      dt-bindings: timer: cadence_ttc: Add power-domains

Peng Fan (2):
      clocksource/drivers/imx-sysctr: Mark two variable with __ro_after_init
      clocksource/drivers/timer-imx-sysctr: Set cpumask to cpu_possible_mask

Romain Perier (3):
      clocksource/drivers: Add MStar MSC313e timer support
      clocksource/drivers/msc313e: Add support for ssd20xd-based platforms
      dt-bindings: timer: Add Mstar MSC313e timer devicetree bindings
documentation

Will Deacon (1):
      clocksource/drivers/exynos_mct: Fix silly typo resulting in
checkpatch warning

 Documentation/devicetree/bindings/timer/cdns,ttc.yaml            |   3 ++
 Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml |  46
+++++++++++++++++++++++++
 Documentation/devicetree/bindings/timer/nxp,tpm-timer.yaml       |   6 +++-
 Documentation/devicetree/bindings/timer/renesas,ostm.yaml        |  20
+++++++++--
 Documentation/devicetree/bindings/timer/rockchip,rk-timer.yaml   |   1 -
 MAINTAINERS                                                      |   1 +
 drivers/clocksource/Kconfig                                      |  12
++++++-
 drivers/clocksource/Makefile                                     |   1 +
 drivers/clocksource/exynos_mct.c                                 |  52
+++++++++++++++++------------
 drivers/clocksource/renesas-ostm.c                               |  39
+++++++++++++++++++++-
 drivers/clocksource/timer-imx-sysctr.c                           |   6 ++--
 drivers/clocksource/timer-msc313e.c                              | 253
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/timer-pistachio.c                            |   3 +-
 include/linux/reset.h                                            |  20
+++++++++++
 14 files changed, 431 insertions(+), 32 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/timer/mstar,msc313e-timer.yaml
 create mode 100644 drivers/clocksource/timer-msc313e.c

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
