Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82376468D92
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbhLEWPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbhLEWPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:15:47 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8AF0C061714;
        Sun,  5 Dec 2021 14:12:19 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so35033278edd.13;
        Sun, 05 Dec 2021 14:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0+D7LVpx2b7+YEMHYNQ4sHzfEasm4IIQFuQ89JA1j8=;
        b=F1ShzJNVmwrJpSJSRSW9i78hXffC6SmbOrZhsVhVWauFzMa2QgZ5ZEiL3yjxKcWWl/
         b3mZcfV2vMjsBoxTguBJ2/Fj4TLrJGB5PBWZnTceQvBlrC9J+xIYPw+9L5sknnwRVyOe
         Tj4zoIDtHFctHEmv4nyiv2dHBXa3cfQlYV4Bfi9/NI2W62m8e1X9tC4WoalYvLJQaVSc
         1Yf3y95KIX8VTuzYd+xcG/t+qKei2WJXaV0ka/zSMq6pJuVioghBpp+li4gX61+y0s07
         eGFs1sGzLxp/r/Teac8JLFi0QKh1nO3mPGPpTfVQRh7oHq+4JvvVlHmdi8V7cD1ujyK0
         zFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/0+D7LVpx2b7+YEMHYNQ4sHzfEasm4IIQFuQ89JA1j8=;
        b=no614cVfOAo7oaf5p9lsaZZJmqR5gI4k1dqW7kkKnNoQ3iqV45yb7ZnUoDIaX8vTVA
         FaHZIyUmXIQdKsfccoXiC4GxMJe+u5ObaPbtnenVlD9962VsgIojn1w/5aF5xxpCH0WO
         FoisrjvPW57+L4Xq2cWT1dpluBN53w8gY+40rihsmpzymdTKcZggR9eo2fACAQ0aIhJd
         +2s0md1UVUaUjts/ir0mPpVLfREf4+70dKydypmbj6r9v5dPMFzt4yJEPfVNNcEItgfU
         yr1WrUL+pOCtefjauuyNEUz9hvQHDr2sQejH865CsWYULkXyQ4zRq7cu65KZzxvZpyzX
         qJXg==
X-Gm-Message-State: AOAM531B2oAPaQ1SgJtJ0FOj6zWkSVZClsnNy4fsKGKVHn6FACQ1sFMq
        wFms2ulwXoDxWY7vaG+luE0=
X-Google-Smtp-Source: ABdhPJwNJVY/pPrZpgLhM+zElauLpEyy+O+9rCOEWxON+LxRF3Qjo0Yh25DR1b0Y1aOy0+uHn21Xww==
X-Received: by 2002:a17:906:f74a:: with SMTP id jp10mr39938596ejb.358.1638742338498;
        Sun, 05 Dec 2021 14:12:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id gb18sm5608079ejc.95.2021.12.05.14.12.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 14:12:18 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        David Virag <virag.david003@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v2 0/7] Initial Samsung Galaxy A8 (2018) support
Date:   Sun,  5 Dec 2021 23:10:59 +0100
Message-Id: <20211205221108.193400-1-virag.david003@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic initial support for the Samsung Galaxy A8 (2018) smartphone.
This phone is also known as "jackpotlte" and under the model name
"SM-A530F". In its current state this should work on most if not all
Exynos7885 phones/devices released.

As of now, it supports I2C nodes (all disabled by default) and UART
console with basic clock support in place.

To access the UART console on the A8, there are two methods:
  -You can open up the device and solder directly to some debug pins
   close to the display connector.
  -Through I2C you can set the S2MU004 MFD chip to multiplex the SoC's
   UART lines to the d+ and d- on the USB Type-C port of the device.

Note that UART works on 1.8 volts, so plugging in a normal USB cable
while multiplexed to UART may fry the SoC.

Everything was tested through UART by using a minimal driver that sets
the S2MU004 to multiplex UART.

The preferred way to boot this device is by using my Minimal S-Boot
Wrapper [1] to work around some issues caused by the stock, and
non-replacable Samsung S-Boot bootloader.

Changes in v2:
- Added R-b tags by Krzysztof Kozlowski
- Moved dt-bindings patches to the beginning of the series
- Fixed double : in 7885 CMU bindings
- Fixed multiple double line breaks
- Made Exynos850 and 7885 clock drivers share some code in a new patch
- Lots of dts/dtsi fixes

[1] https://github.com/VDavid003/minimal_sboot_wrapper

David Virag (7):
  dt-bindings: clock: Add bindings definitions for Exynos7885 CMU
  dt-bindings: clock: Document Exynos7885 CMU bindings
  dt-bindings: arm: samsung: document jackpotlte board binding
  clk: samsung: Make exynos850_register_cmu shared
  clk: samsung: clk-pll: Add support for pll1417x
  clk: samsung: Add initial Exynos7885 clock driver
  arm64: dts: exynos: Add initial device tree support for Exynos7885 SoC

 .../bindings/arm/samsung/samsung-boards.yaml  |   6 +
 .../clock/samsung,exynos7885-clock.yaml       | 166 ++++
 arch/arm64/boot/dts/exynos/Makefile           |   7 +-
 .../boot/dts/exynos/exynos7885-jackpotlte.dts |  95 ++
 .../boot/dts/exynos/exynos7885-pinctrl.dtsi   | 865 ++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    | 438 +++++++++
 drivers/clk/samsung/Makefile                  |   2 +
 drivers/clk/samsung/clk-exynos-arm64.c        |  94 ++
 drivers/clk/samsung/clk-exynos-arm64.h        |  20 +
 drivers/clk/samsung/clk-exynos7885.c          | 593 ++++++++++++
 drivers/clk/samsung/clk-exynos850.c           |  94 +-
 drivers/clk/samsung/clk-pll.c                 |   1 +
 drivers/clk/samsung/clk-pll.h                 |   1 +
 include/dt-bindings/clock/exynos7885.h        | 115 +++
 14 files changed, 2404 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos-arm64.c
 create mode 100644 drivers/clk/samsung/clk-exynos-arm64.h
 create mode 100644 drivers/clk/samsung/clk-exynos7885.c
 create mode 100644 include/dt-bindings/clock/exynos7885.h

-- 
2.34.1

