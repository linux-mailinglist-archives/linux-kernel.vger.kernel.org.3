Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DE6468DE5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 00:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240676AbhLEXM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240528AbhLEXM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:12:28 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B84C061714;
        Sun,  5 Dec 2021 15:09:00 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x15so35753689edv.1;
        Sun, 05 Dec 2021 15:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VgzJbq6J/Xiy+wJ4KjBK4ePhEWoROOcFACdzEQA4O3M=;
        b=ebEvTXNjpHjo3uTzmwLqnpKGMPLRyutMXdtcVZkourArQF7dddBbr2721Obgny6d5j
         HinTyCreX+/bLonStg+SOm6/65yPsxsIkDFlFjDhD7FplrMjxrMNEnG8+osW3W08Qwv7
         YVkGvo/V7RW12LQc90CkiUHkWDlrCy6cmGEjFI3CkaV837abQ9svnpAdtfH+dTA9NwbE
         NVO/lP09YF7bJ57pFbdc/cGAbmNnNKN4sq1kfSvvtGYLv7chfDcq61/9wiWGVyIwH/1p
         Dbd0F2jET2vAIgAPWHF7Hb4hPjNvPS1uH9UuAB+8FF1BE+4Br8rJ75vKypV61wF++AmT
         S6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VgzJbq6J/Xiy+wJ4KjBK4ePhEWoROOcFACdzEQA4O3M=;
        b=Yr0Y50n70mPVYcpCKs1mnvsOTOEdo6mIeuH+4l2EhIIAB5CJnOadvb7YAUb+q+ZEYd
         EoMyi8MHDGMRoEbMNNZdOM7xIk3TwkbyB4d3WeP9g8B8GbHMDW8MPlblidIjS43P5Q9v
         23lzjE107ItX7jxO51GEb+GJHNXzjHEOEjXR0pEQ7wpRYJHKOEIK1+avGaD7qHDnvU6Y
         WgaWCxfPjdHXlgoueQ0+ou4qEwe5tcZg4ajcX9ikzSJmeF7avkHboBCfRPy7eU/03+FW
         t4XwfVh+PVDPFvbI0L2PqSIzsn/VNDY3dzXptjMcauJoSrGkQDwPtrysTSUeEryIMMl0
         ggLg==
X-Gm-Message-State: AOAM533VSNkN8iRNELwSVkd+31hZVuaEznb2GVN2va8p8+ImY6mX78lU
        ZEhACeNJ7IlX7+ktjzSJ8q8=
X-Google-Smtp-Source: ABdhPJzQNHxDEhE6roGKxFL2RGZlYUEBqOti5ptFcXFJdwIdy2uVjEO2yjDCuVDRlOrrxCs+clrQag==
X-Received: by 2002:a17:906:a10c:: with SMTP id t12mr41419350ejy.429.1638745739059;
        Sun, 05 Dec 2021 15:08:59 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id co10sm6686569edb.83.2021.12.05.15.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:08:58 -0800 (PST)
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
Subject: [PATCH v3 0/7] Initial Samsung Galaxy A8 (2018) support
Date:   Mon,  6 Dec 2021 00:07:54 +0100
Message-Id: <20211205230804.202292-1-virag.david003@gmail.com>
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

Changes in v3:
- Fix SPDX comment style in clk-exynos-arm64.h
- Fix typo in dts comment

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

