Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327414EC422
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244424AbiC3Me0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343758AbiC3Mdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:33:38 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8076C1C3;
        Wed, 30 Mar 2022 05:19:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id r13so41133365ejd.5;
        Wed, 30 Mar 2022 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAKbIACOG+B8BQa+6h8FyunEp7V5Zr3/l+NhPAq74Os=;
        b=NXCRk+P7Zuekg1nnqnrt+WNb45/SnlvVr+hmqcw24v6HK/Kl4O65OTx98uLmUEOEei
         341PtzLIPbi5/4S4patdKu4pikVDwXLCpWk2kDLXtVj4eVQsXvaIu0QWFKgLlmjyEtdg
         2qxj+fjUx8FU8ZQvw+AKlKz5Cg2sswyEbbUStuIhs3GJ6H4DpDwqMcUCV1x5srzmpbTN
         btR6ZrS8FJWjUC3RD5AK/nrgjeW09AhFJ28Of1kFvKi+vjVNVQoIMALV/JKz38h1sLqI
         WzJzaXSRugHG0Bkg1Lk4xv0/hMJ9+LYkqqN3gWRObvCV/X4Vcf7nDoArxP69A/iwRsQQ
         oBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OAKbIACOG+B8BQa+6h8FyunEp7V5Zr3/l+NhPAq74Os=;
        b=Jw99aoabruAgEruGKNCOvuAOUMFFIVKH3aHSvYa4b6gxDBBh2DEtQwcSKWN6U4EHui
         Aa4GnidmaE8pk3kKTURd/uhYypV3c6IHjWvoBt2gJ+h4INfALTHzfjupPubdqC87FqwM
         wh2dyly51nKyC2SJFO4isKAoz4DoVhQomt5uuD7MbDppABFjdvlsIvQSGbWlsqsl70vp
         2xVje13SSUUvrDQzqeYNi+ckwSrnLKdXhAFD2w3gqQCVoUKThIXuFB9JVasjVR8G6xpZ
         QN09nuaNhHRVgDClthVoffqUC6t3LFQ/PPxbd4HzsdBBojZNqzeXvU8wIPz5JOyKDYJb
         6IMg==
X-Gm-Message-State: AOAM532eH8UBT+GnIHnAAySzbITB7R3PvKzLyJXq4YU1qFcX+iOyKL1v
        sTaUgvbWVVmu6ukpseRAgsw=
X-Google-Smtp-Source: ABdhPJyPR65YDAqkJdSJxleu9Q7ZvLSqY3+KTPZlozK34i/lIW5pGZsB3zsFVTFr+hs14s+2hYofYA==
X-Received: by 2002:a17:907:8690:b0:6da:8436:2b94 with SMTP id qa16-20020a170907869000b006da84362b94mr39997707ejc.33.1648642769458;
        Wed, 30 Mar 2022 05:19:29 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id h8-20020a1709066d8800b006e09a49a713sm6721194ejt.159.2022.03.30.05.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 05:19:28 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v5.18-rc1
Date:   Wed, 30 Mar 2022 14:19:24 +0200
Message-Id: <20220330121924.2715661-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.35.1
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

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-5.18-rc1

for you to fetch changes up to ed14d36498c8d15be098df4af9ca324f96e9de74:

  pwm: rcar: Simplify multiplication/shift logic (2022-02-24 15:14:56 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v5.18-rc1

Contains conversions of some more drivers to the atomic API as well as
the addition of new chip support for some existing drivers.

There are also various minor fixes and cleanups across the board, from
drivers to device tree bindings.

----------------------------------------------------------------
Aidan MacDonald (2):
      dt-bindings: timer: Add PWM compatible for X1000 SoC
      pwm: jz4740: Add support for X1000 SoC

Allen-KH Cheng (1):
      dt-bindings: pwm: mtk-disp: Add compatible string for MT8183 SoC

AngeloGioacchino Del Regno (3):
      pwm: pwm-mediatek: Simplify error handling with dev_err_probe()
      pwm: pwm-mediatek: Allocate clk_pwms with devm_kmalloc_array
      pwm: pwm-mediatek: Beautify error messages text

Colin Ian King (1):
      pwm: atmel: Remove redundant initialization of variable timeout

Geert Uytterhoeven (1):
      pwm: rcar: Simplify multiplication/shift logic

Krzysztof Kozlowski (16):
      dt-bindings: pwm: google,cros-ec: include generic pwm schema
      dt-bindings: pwm: allwinner,sun4i-a10: Include generic PWM schema
      dt-bindings: pwm: imx: Include generic PWM schema
      dt-bindings: pwm: intel,lgm: Include generic PWM schema
      dt-bindings: pwm: iqs620a: Include generic PWM schema
      dt-bindings: pwm: mxs: Include generic PWM schema
      dt-bindings: pwm: rockchip: Include generic PWM schema
      dt-bindings: pwm: sifive: Include generic PWM schema
      dt-bindings: pwm: renesas,pwm: Include generic PWM schema
      dt-bindings: pwm: toshiba,visconti: Include generic PWM schema
      dt-bindings: pwm: brcm,bcm7038: Do not require pwm-cells twice
      dt-bindings: pwm: intel,keembay: Do not require pwm-cells twice
      dt-bindings: pwm: samsung: Do not require pwm-cells twice
      dt-bindings: pwm: tiecap: Do not require pwm-cells twice
      dt-bindings: pwm: tiehrpwm: Do not require pwm-cells twice
      dt-bindings: pwm: renesas,tpu: Do not require pwm-cells twice

Lionel Vitte (1):
      pwm: pca9685: Reset OFF/ON registers to POR value

Uwe Kleine-König (19):
      pwm: meson: Drop always false check from .request()
      pwm: meson: Drop useless check for channel data being NULL
      pwm: meson: Simplify duplicated per-channel tracking
      pwm: meson: Drop always false check from .apply()
      pwm: lpc18xx-sct: Initialize driver data and hardware before pwmchip_add()
      pwm: lpc18xx-sct: Reduce number of devm memory allocations
      pwm: lpc18xx-sct: Simplify driver by not using pwm_[gs]et_chip_data()
      pwm: imx1: Implement .apply callback
      pwm: img: Rename variable pointing to driver private data
      pwm: tegra: Rename variable pointing to driver private data
      pwm: sun4i: Rename variable pointing to driver private data
      pwm: stmpe: Drop unused setting of driver data
      pwm: stmpe: Rename variable pointing to driver private data
      pwm: pxa: Implement .apply() callback
      pwm: tiehrpwm: Implement .apply() callback
      pwm: bcm-kona: Implement .apply() callback
      pwm: raspberrypi-poe: Drop assignment to struct pwmchip::base
      pwm: brcmstb: Implement .apply() callback
      pwm: brcmstb: Remove useless locking

zhaoxiao (1):
      pwm: vt8500: Rename variable pointing to driver private data

 .../devicetree/bindings/mfd/google,cros-ec.yaml    |   4 +
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml      |  53 ++++----
 .../devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml  |   1 -
 .../bindings/pwm/google,cros-ec-pwm.yaml           |   5 +-
 Documentation/devicetree/bindings/pwm/imx-pwm.yaml |   4 +-
 .../devicetree/bindings/pwm/imx-tpm-pwm.yaml       |   4 +-
 .../devicetree/bindings/pwm/intel,keembay-pwm.yaml |   1 -
 .../devicetree/bindings/pwm/intel,lgm-pwm.yaml     |   3 +
 .../devicetree/bindings/pwm/iqs620a-pwm.yaml       |   4 +-
 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml |   4 +-
 .../devicetree/bindings/pwm/pwm-mtk-disp.txt       |   1 +
 .../devicetree/bindings/pwm/pwm-rockchip.yaml      |  74 +++++------
 .../devicetree/bindings/pwm/pwm-samsung.yaml       |   1 -
 .../devicetree/bindings/pwm/pwm-sifive.yaml        |   4 +-
 .../devicetree/bindings/pwm/pwm-tiecap.yaml        |   1 -
 .../devicetree/bindings/pwm/pwm-tiehrpwm.yaml      |   1 -
 .../devicetree/bindings/pwm/renesas,pwm-rcar.yaml  |  26 ++--
 .../devicetree/bindings/pwm/renesas,tpu-pwm.yaml   |   1 -
 .../bindings/pwm/toshiba,pwm-visconti.yaml         |   4 +-
 .../devicetree/bindings/timer/ingenic,tcu.yaml     |   1 +
 drivers/pwm/pwm-atmel.c                            |   2 +-
 drivers/pwm/pwm-bcm-kona.c                         |  90 ++++++++-----
 drivers/pwm/pwm-brcmstb.c                          |  52 ++++----
 drivers/pwm/pwm-img.c                              | 141 ++++++++++-----------
 drivers/pwm/pwm-imx1.c                             |  33 ++++-
 drivers/pwm/pwm-jz4740.c                           |   5 +
 drivers/pwm/pwm-lpc18xx-sct.c                      |  49 +++----
 drivers/pwm/pwm-mediatek.c                         |  34 ++---
 drivers/pwm/pwm-meson.c                            |  25 ++--
 drivers/pwm/pwm-pca9685.c                          |   4 +-
 drivers/pwm/pwm-pxa.c                              |  33 ++++-
 drivers/pwm/pwm-raspberrypi-poe.c                  |   1 -
 drivers/pwm/pwm-rcar.c                             |   2 +-
 drivers/pwm/pwm-stmpe.c                            |  18 ++-
 drivers/pwm/pwm-sun4i.c                            |  70 +++++-----
 drivers/pwm/pwm-tegra.c                            |  59 +++++----
 drivers/pwm/pwm-tiehrpwm.c                         |  40 +++++-
 drivers/pwm/pwm-vt8500.c                           |  38 +++---
 38 files changed, 492 insertions(+), 401 deletions(-)
