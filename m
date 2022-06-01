Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C049B53A94C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 16:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353852AbiFAOiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 10:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiFAOit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 10:38:49 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D659931233;
        Wed,  1 Jun 2022 07:38:46 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k19so2643812wrd.8;
        Wed, 01 Jun 2022 07:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hHUZJTrnV/WM36MXypWHBCTec3ewmd46xALxBegjTQc=;
        b=YQ2yzIZm8fU9pugvj/pwDwGOZpa28cSZf1Dsv+DIPdaFk77kWRCzCzFV8GuaQdZoSi
         u3CgJMrs5iRgqKgsrp+ZkQa20bN4khmCLPMvIuz+trakjv+AtQY1p1sbP49qlBAvoioT
         w+B+b8v6FK+LM4oxWB9UyLrVBffoNQ9J1hcMrwAbTcxjPIYiqTt+Wuya/MkyrhYQJfrx
         wPTimS9qgm+cOAgvqygiFq3klBeCiS6fZbNW2dWYMVtDJxe86iZob+oRFK/W5NFfOPmO
         YMYwvO414S5Y2IxHRfTDR4flkLmfpZ0qM1ubU26/K2/FkmT5POWfPo65PmF1Zua+w44+
         J7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hHUZJTrnV/WM36MXypWHBCTec3ewmd46xALxBegjTQc=;
        b=cWLTD93C++K1DgI26ekfOkOCZU7CPyOK+YGg3M+FblFjkws63SK+gUGxTKhzfWKXom
         GwLSrTVoHX2/udPR2Q2eNZNQHJlTrrqj1CG5XyhGwjXRIA29KNM2KtfwWQvtbuCg16YK
         qXpKo5F0faR94go68ZzSNArfLjG/kCCzTU3z/roVV/t+jGMSZY4nGHLHgl9Ls+/UdCUL
         4eGqT1ozNXnk5cWv9nISDgK3vnxqh3CMj1iztosD4JKrIUmRIjGJ0RHq23Mqjis78HNy
         Yi+/ik4RBqdDnY+IlXMOQBQd6rvASQU2ZaSV77EXdIIwFywP8m0Xn1dZi0hk1yJlEcHm
         n22w==
X-Gm-Message-State: AOAM532fs7lc8FGk11yCVP4DJGnfhDIonCY+7LC51/xIt2ezSKADcyXA
        zH87qo0mCKlaiGeA1QbZVmQ=
X-Google-Smtp-Source: ABdhPJyhonIuDNAlb0CP37t93RaBFmhE65vJfveBqnY40ME/Lca5TqeFMvhepoVjlCDfhQKXfzhRQg==
X-Received: by 2002:adf:e691:0:b0:210:2d6a:8a82 with SMTP id r17-20020adfe691000000b002102d6a8a82mr140032wrm.14.1654094325286;
        Wed, 01 Jun 2022 07:38:45 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id h24-20020adfa4d8000000b0020d0a57af5esm1845185wrb.79.2022.06.01.07.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 07:38:44 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.19-rc1
Date:   Wed,  1 Jun 2022 16:38:39 +0200
Message-Id: <20220601143839.3893139-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.19-rc1

for you to fetch changes up to 3d593b6e80ad2c911b5645af28d83eabb96e7c1b:

  pwm: pwm-cros-ec: Add channel type support (2022-05-20 16:40:01 +0200)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.19-rc1

Quite a large number of conversions this time around, courtesy of Uwe
who has been working tirelessly on these. No drivers of the legacy API
are left at this point, so as a next step the old API can be removed.

Support is added for a few new devices such as the Xilinx AXI timer-
based PWMs and the PWM IP found on Sunplus SoCs.

Other than that, there's a number of fixes, cleanups and optimizations.

----------------------------------------------------------------
AngeloGioacchino Del Regno (2):
      dt-bindings: pwm: pwm-mediatek: Add documentation for MT6795 SoC
      pwm: pwm-mediatek: Add support for MediaTek Helio X10 MT6795

Baruch Siach (1):
      gpio: mvebu: Drop PWM base assignment

Fabio Baltieri (3):
      dt-bindings: Add mfd/cros_ec definitions
      dt-bindings: google,cros-ec-pwm: Add the new -type compatible
      pwm: pwm-cros-ec: Add channel type support

Hammer Hsieh (2):
      dt-bindings: pwm: Add bindings doc for Sunplus SoC SP7021 PWM Driver
      pwm: sunplus-pwm: Add Sunplus SoC SP7021 PWM Driver

Max Kellermann (3):
      pwm-sun4i: Convert "next_period" to local variable
      pwm-sun4i: Calculate "delay_jiffies" directly, eliminate absolute time
      pwm-sun4i: Calculate the delay without rounding down to jiffies

Sean Anderson (2):
      dt-bindings: pwm: Add Xilinx AXI Timer
      pwm: Add support for Xilinx AXI Timer

Sergiu Moga (2):
      dt-bindings: pwm: Convert atmel pwm to json-schema
      dt-bindings: pwm: at91: Add SAMA7G5 compatible strings list

Uwe Kleine-König (22):
      pwm: atmel-tcb: Drop duplicated tracking of per-channel data
      pwm: lp3943: Fix duty calculation in case period was clamped
      pwm: lp3943: Implement .apply() callback
      pwm: atmel-tcb: Make atmel_tcb_divisors static
      pwm: raspberrypi-poe: Fix endianness in firmware struct
      pwm: clps71xx: Implement .apply() callback
      pwm: samsung: Implement .apply() callback
      pwm: renesas-tpu: Make use of dev_err_probe()
      pwm: renesas-tpu: Make use of devm functions
      pwm: renesas-tpu: Implement .apply() callback
      pwm: renesas-tpu: Rename variables to match the usual naming
      pwm: renesas-tpu: Improve maths to compute register settings
      pwm: renesas-tpu: Improve precision of period and duty_cycle calculation
      pwm: tegra: Optimize period calculation
      pwm: sti: Implement .apply() callback
      pwm: stmpe: Implement .apply() callback
      pwm: tegra: Implement .apply() callback
      pwm: lpc32xx: Implement .apply() callback
      pwm: mediatek: Implement .apply() callback
      pwm: lpc18xx: Implement .apply() callback
      pwm: twl-led: Implement .apply() callback
      pwm: Document that the pinstate of a disabled PWM isn't reliable

Wan Jiabing (1):
      pwm: sifive: Simplify if-if to if-else

Xinlei Lee (5):
      dt-bindings: pwm: Convert pwm-mtk-disp.txt to mediatek,pwm-disp.yaml format
      dt-bindings: pwm: Add compatible for MediaTek MT8192
      dt-bindings: pwm: Add compatible for MediaTek MT8195
      dt-bindings: pwm: Add compatible for MediaTek MT8186
      dt-bindings: pwm: Add interrupts property for MediaTek MT8192

 .../devicetree/bindings/pwm/atmel,at91sam-pwm.yaml |  47 +++
 .../devicetree/bindings/pwm/atmel-pwm.txt          |  35 ---
 .../bindings/pwm/google,cros-ec-pwm.yaml           |   9 +-
 .../devicetree/bindings/pwm/mediatek,pwm-disp.yaml |  75 +++++
 .../devicetree/bindings/pwm/pwm-mediatek.txt       |   1 +
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |  45 ---
 .../bindings/pwm/sunplus,sp7021-pwm.yaml           |  42 +++
 .../devicetree/bindings/timer/xlnx,xps-timer.yaml  |  92 ++++++
 Documentation/driver-api/pwm.rst                   |   6 +
 MAINTAINERS                                        |  14 +-
 arch/microblaze/kernel/timer.c                     |   4 +
 drivers/gpio/gpio-mvebu.c                          |   7 -
 drivers/pwm/Kconfig                                |  25 ++
 drivers/pwm/Makefile                               |   2 +
 drivers/pwm/pwm-atmel-tcb.c                        |  14 +-
 drivers/pwm/pwm-clps711x.c                         |  68 ++---
 drivers/pwm/pwm-cros-ec.c                          |  82 +++++-
 drivers/pwm/pwm-lp3943.c                           |  42 ++-
 drivers/pwm/pwm-lpc18xx-sct.c                      |  43 ++-
 drivers/pwm/pwm-lpc32xx.c                          |  29 +-
 drivers/pwm/pwm-mediatek.c                         |  36 ++-
 drivers/pwm/pwm-raspberrypi-poe.c                  |   2 +-
 drivers/pwm/pwm-renesas-tpu.c                      | 317 +++++++++++---------
 drivers/pwm/pwm-samsung.c                          |  54 +++-
 drivers/pwm/pwm-sifive.c                           |   5 +-
 drivers/pwm/pwm-sti.c                              |  29 +-
 drivers/pwm/pwm-stmpe.c                            |  29 +-
 drivers/pwm/pwm-sun4i.c                            |  18 +-
 drivers/pwm/pwm-sunplus.c                          | 232 +++++++++++++++
 drivers/pwm/pwm-tegra.c                            |  40 ++-
 drivers/pwm/pwm-twl-led.c                          |  76 ++++-
 drivers/pwm/pwm-xilinx.c                           | 321 +++++++++++++++++++++
 include/clocksource/timer-xilinx.h                 |  73 +++++
 include/dt-bindings/mfd/cros_ec.h                  |  18 ++
 34 files changed, 1558 insertions(+), 374 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pwm/atmel,at91sam-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/mediatek,pwm-disp.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-mtk-disp.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/sunplus,sp7021-pwm.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
 create mode 100644 drivers/pwm/pwm-sunplus.c
 create mode 100644 drivers/pwm/pwm-xilinx.c
 create mode 100644 include/clocksource/timer-xilinx.h
 create mode 100644 include/dt-bindings/mfd/cros_ec.h
