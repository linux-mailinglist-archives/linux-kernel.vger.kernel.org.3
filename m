Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08354469FFE
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442792AbhLFP4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390784AbhLFPmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:42:50 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE571C08E852;
        Mon,  6 Dec 2021 07:32:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y12so44274360eda.12;
        Mon, 06 Dec 2021 07:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jA0/Vjs8HTmbMPDycewEdsM7ryNAIr3rJJKIVuOBXQc=;
        b=jD0l0RMMRQH80ctwcpGj3byfYrfKGQ8gME4jJ3W9eBNZRv2zYUkXOCgbaYsosE7o+p
         lcbMIRgRMjr/hskND+XKbxGRQtamjSrY9CR4vJHMWeYK2DnDJjMvaylyMhWF2Jr1cVuk
         y0qDtwDP5MfWISlT8GBY2saM6/H6w4yzNi+N6xvdNxWy2Wz7EIy+mn8OVb7/AKLhlsnS
         icnHPV3qcZoQssViNggvUFbj6CR5Dpca7bRI2XOrGHMf7h2R1Ppnht5JeFx3bSJisWLC
         XnYHRQYcdxo7IfPHQ4CgMiheO0wjR/okvvvvjbbjqSXazHgBbLxso+G4nOkHChgXu6BQ
         E2eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jA0/Vjs8HTmbMPDycewEdsM7ryNAIr3rJJKIVuOBXQc=;
        b=HDDycVUnoXF6k1laMzMb9BQotxL6MSgk2CLemsiRdiZjhTi4pE/ldHpbj17sGsJfWT
         7M5yWhL68d5EoNOEPALJHsXoZxLYpmx9kEg+b6FC5lSzYBMqQEKhLb5MtflJdfiLEJby
         khN/ThAYaAZ2eg43AOsWeEcdC0e9trXUgmtplNI7hnIsMbewGyWqewBz94M+Y8Bqjnjk
         LekuJKFvbjthY077USsLa0IOG38CtB4NLSYJPchPd4VUxT/jbN1KHU+lAdPQ31x4Y5bZ
         27DrLY4nZ4FiGfn7RvBmjDcIua+CvxDqVfzKrBhecl20romxqJwCKw9ch24koTgHI7Rd
         +YBQ==
X-Gm-Message-State: AOAM532earI/58x8rQ7gZ4KShp5SyM80r94kmwZshMdar13jYfyGDXdf
        bGeOWZIiBmLi2ciw0esXIEM=
X-Google-Smtp-Source: ABdhPJyElICCwzglnbsKWrwExz94gKjSFu9kQNBc2/inrAfLJnJFdelTd1WFkEkfIxu5bDdrxN2VFg==
X-Received: by 2002:aa7:c415:: with SMTP id j21mr56343729edq.357.1638804736486;
        Mon, 06 Dec 2021 07:32:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id d19sm7364688edt.34.2021.12.06.07.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 07:32:15 -0800 (PST)
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
Subject: [PATCH v4 0/7] Initial Samsung Galaxy A8 (2018) support
Date:   Mon,  6 Dec 2021 16:31:14 +0100
Message-Id: <20211206153124.427102-1-virag.david003@gmail.com>
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

Changes in v4:
- Fixed leading 0x in clock-controller nodes
- Fixed missing headers in clock driver patches
- "__SAMSUNG_CLK_ARM64_H" -> "__CLK_EXYNOS_ARM64_H" in
  clk-exynos-arm64.h everywhere (only the comment at the end had the
  latter by accident)
- Added R-b tag by Krzysztof Kozlowski to pll1417x patch
- Actually suffixed pin configuration node names with "-pins"
- Seperated Cortex-A53 and Cortex-A73 PMU

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
 drivers/clk/samsung/clk-exynos7885.c          | 597 ++++++++++++
 drivers/clk/samsung/clk-exynos850.c           |  88 +-
 drivers/clk/samsung/clk-pll.c                 |   1 +
 drivers/clk/samsung/clk-pll.h                 |   1 +
 include/dt-bindings/clock/exynos7885.h        | 115 +++
 14 files changed, 2408 insertions(+), 87 deletions(-)
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

