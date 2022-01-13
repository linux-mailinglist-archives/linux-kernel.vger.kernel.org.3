Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71D5F48D772
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiAMMXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:23:14 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:21650 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiAMMXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:23:13 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220113122311epoutp0242c041b39de0dfa06245c55c687f1cb8~J0-XINryu2743127431epoutp02z
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:23:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220113122311epoutp0242c041b39de0dfa06245c55c687f1cb8~J0-XINryu2743127431epoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076591;
        bh=f2jeQ0YdCrDx1DRJgpdBMus0XrvXmwz726NZp51/TAo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=p9ZSFNjXLWbzJqhcYtnK7afdWpDofA4vhZAfnYRHfKOCT6P9/miXwUqzIUbNdnW1F
         3w7WNEQGC8ojsNVna8EcW75oDo+nrPdHsyYwvNFaZN6CiFXHs3VAKkhn4FGMDmAuwu
         1b6pXIr+PcX506ldiYwdNH0mfJuS/2BOXows6Nn8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220113122310epcas5p3f5eae1624d297ef13f8dee0d34f13273~J0-WY_tM31599415994epcas5p3j;
        Thu, 13 Jan 2022 12:23:10 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JZNqr0n5fz4x9Px; Thu, 13 Jan
        2022 12:23:04 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.21.05590.7A910E16; Thu, 13 Jan 2022 21:23:03 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220113122302epcas5p1d45c0714fe286f8f91d0f28c3fad86e4~J0-O9iT1H0848308483epcas5p1o;
        Thu, 13 Jan 2022 12:23:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220113122302epsmtrp2f88be838e6f95b4079030f95d5f872ae~J0-O8Vik93027830278epsmtrp25;
        Thu, 13 Jan 2022 12:23:02 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-5f-61e019a745cd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        E0.99.08738.6A910E16; Thu, 13 Jan 2022 21:23:02 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122300epsmtip2cbdf8491e4b5dc362dabbd687259cd22~J0-Mr3ZbO0676806768epsmtip2j;
        Thu, 13 Jan 2022 12:23:00 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 00/23] Add support for Tesla Full Self-Driving (FSD) SoC
Date:   Thu, 13 Jan 2022 17:41:20 +0530
Message-Id: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmuu5yyQeJBpdb1CwezNvGZvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdqcXnXHDaLGef3MVmcuv6ZzWLR1i/sFq17j7Bb
        HH7Tzmrx+PofNgc+jzXz1jB6zGroZfPYtKqTzePOtT1sHpuX1HtcOdHE6tG3ZRWjx+dNcgEc
        Udk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUB3KymU
        JeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKTAr0ihNzi0vz0vXyUkusDA0MjEyBChOy
        M9bPjirYKVuxv3EqWwPjDrEuRg4OCQETifvnmboYuTiEBHYzSnzfvoe1i5ETyPnEKPHpqzNE
        4jOjRMv2cywgCZCGGVP7mSGKdjFKzPptDVHUwiTRd6oDrIhNQFvi7vQtTCC2iICbxI3GDrAV
        zALHmST2t29gBEkIC3hInJg7HayBRUBVYtuCo2CreQVsJJat/M8MsU1eYvWGA8wgzRICX9kl
        XnTPYoRIuEgsnHKJDcIWlnh1fAs7hC0l8fndXjaI37IlenYZQ4RrJJbOOwb1gb3EgStzWEBK
        mAU0Jdbv0gcJMwvwSfT+fsIE0ckr0dEmBFGtKtH87ipUp7TExO5uVgjbQ2LrrfnQwIqVmPxs
        EdsERplZCEMXMDKuYpRMLSjOTU8tNi0wzksth0dMcn7uJkZw8tPy3sH46MEHvUOMTByMhxgl
        OJiVRHj7i+4nCvGmJFZWpRblxxeV5qQWH2I0BYbSRGYp0eR8YPrNK4k3NLE0MDEzMzOxNDYz
        VBLnPZW+IVFIID2xJDU7NbUgtQimj4mDU6qBaf/tVHOh99UBnO3+a3ILphz4+iKp+bNnRUxZ
        qN/M+gRWeSX1g+pykTsWR7m9ur0zJ/AAb8D8vlJhlZp7nz33G93bcODwg53hZyaEJCg9WXcj
        OufU6eTzU85+2r+m3vVYSg3T7VSGzD9qXbPuLz3xrfnQnjs6kh9fLmE4lb5RI3zOkspURrOZ
        185cPDPLL0Gw30x9Zsy08g35Emd/7S21STzUpzCpK99h9/mbOzJeBArsvdI2p5RHgdF/N0tI
        toVoE/vqsNvzd4qlyQlm/TX+drqy6779on8tnNLaqQslhAtUGU43X39RdPCDfcO0htbLP7s5
        xYKlK/bx7DRUVY7saLIW3HbtgsS9JSaLFy28p8RSnJFoqMVcVJwIAJ3DeOAHBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrALMWRmVeSWpSXmKPExsWy7bCSvO4yyQeJBh97RC0ezNvGZvF+WQ+j
        xfwj51gtNr79wWQx5c9yJotNj6+xWnzsucdqcXnXHDaLGef3MVmcuv6ZzWLR1i/sFq17j7Bb
        HH7Tzmrx+PofNgc+jzXz1jB6zGroZfPYtKqTzePOtT1sHpuX1HtcOdHE6tG3ZRWjx+dNcgEc
        UVw2Kak5mWWpRfp2CVwZ62dHFeyUrdjfOJWtgXGHWBcjJ4eEgInEjKn9zF2MXBxCAjsYJQ40
        PGWGSEhLXN84gR3CFpZY+e85O0RRE5PEjW0nGEESbALaEnenb2ECsUUEPCTa/t0Dm8QscJVJ
        4sfmeWAJYaDEibnTWUBsFgFViW0LjrKC2LwCNhLLVv6H2iYvsXrDAeYJjDwLGBlWMUqmFhTn
        pucWGxYY5aWW6xUn5haX5qXrJefnbmIEB6qW1g7GPas+6B1iZOJgPMQowcGsJMLbX3Q/UYg3
        JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQYmUa79NWEGZU9j
        Fb8vVD5UzbpQ6UnlLOGJ38Of7BLXz/aTX6qz551mQcTbCdPMeoVkp1zsrmaddSilI931lv2M
        SqlJl1edfLM47PH0npVhunqZOs9v7bzCLly6Sbk0/6eH2dILdfMX97gtXZawp0uqZ/FaLdes
        K/v866b3BBvwbG5JCciPiV1XzXna2PgZn+jLiR55LQE7P00TeGNjtKMjMPKOtK/TSrPPasrX
        umurC9cdS17SUzE/jpPv+FOGhe+PWxekXyi7WcM1j/OKwrNi/SsW1pURR3f+k7ks5CPJu6bh
        aOetY6xMxocOyhyu5k7Q02G+dUZYe77c8he61TvyXXc15ay7vbV/cWhKyTQlluKMREMt5qLi
        RAC5UrUdwwIAAA==
X-CMS-MailID: 20220113122302epcas5p1d45c0714fe286f8f91d0f28c3fad86e4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122302epcas5p1d45c0714fe286f8f91d0f28c3fad86e4
References: <CGME20220113122302epcas5p1d45c0714fe286f8f91d0f28c3fad86e4@epcas5p1.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds basic support for the Tesla Full Self-Driving (FSD)
SoC. This SoC contains three clusters of four Cortex-A72 CPUs,
as well as several IPs.

Patches 1 to 8 provide support for the clock controller
(which is designed similarly to Exynos SoCs).

The remaining changes provide pinmux support, initial device tree support,
and SPI, ADC, and MCT IP functionality.


Alim Akhtar (21):
  dt-bindings: clock: Document FSD CMU bindings
  dt-bindings: clock: Add bindings definitions for FSD CMU blocks
  clk: samsung: fsd: Add initial clock support
  clk: samsung: fsd: Add cmu_peric block clock information
  clk: samsung: fsd: Add cmu_fsys0 clock information
  clk: samsung: fsd: Add cmu_fsys1 clock information
  clk: samsung: fsd: Add cmu_imem block clock information
  clk: samsung: fsd: Add cmu_mfc block clock information
  clk: samsung: fsd: Add cam_csi block clock information
  dt-bindings: pinctrl: samsung: Add compatible for Tesla FSD SoC
  pinctrl: samsung: add FSD SoC specific data
  dt-bindings: add vendor prefix for Tesla
  dt-bindings: arm: add Tesla FSD ARM SoC
  arm64: dts: fsd: Add initial device tree support
  arm64: dts: fsd: Add initial pinctrl support
  arm64: defconfig: Enable Tesla FSD SoC
  Documentation: bindings: Add fsd spi compatible in dt-bindings
    document
  spi: s3c64xx: Add spi port configuration for Tesla FSD SoC
  dt-bindings: iio: adc: exynos-adc: Add ADC-V3 variant
  iio: adc: exynos-adc: Add support for ADC V3 controller
  arm64: dts: fsd: Add ADC device tree node

Aswani Reddy (2):
  arm64: dts: fsd: Add SPI device nodes
  clocksource: exynos_mct: Add support for handling three clusters

 .../devicetree/bindings/arm/tesla.yaml        |   25 +
 .../bindings/clock/tesla,fsd-clock.yaml       |  212 ++
 .../bindings/iio/adc/samsung,exynos-adc.yaml  |    1 +
 .../bindings/pinctrl/samsung-pinctrl.txt      |    1 +
 .../devicetree/bindings/spi/spi-samsung.txt   |    1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    8 +
 arch/arm64/Kconfig.platforms                  |    6 +
 arch/arm64/boot/dts/Makefile                  |    1 +
 arch/arm64/boot/dts/tesla/Makefile            |    3 +
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi    |  338 +++
 arch/arm64/boot/dts/tesla/fsd.dts             |  156 ++
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  805 +++++++
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/samsung/Makefile                  |    1 +
 drivers/clk/samsung/clk-fsd.c                 | 1858 +++++++++++++++++
 drivers/clk/samsung/clk-pll.c                 |    1 +
 drivers/clk/samsung/clk-pll.h                 |    1 +
 drivers/clocksource/exynos_mct.c              |    6 +-
 drivers/iio/adc/exynos_adc.c                  |   74 +-
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    |   71 +
 drivers/pinctrl/samsung/pinctrl-samsung.c     |    2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |    1 +
 drivers/spi/spi-s3c64xx.c                     |   13 +
 include/dt-bindings/clock/fsd-clk.h           |  146 ++
 25 files changed, 3731 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/tesla.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
 create mode 100644 arch/arm64/boot/dts/tesla/Makefile
 create mode 100644 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/tesla/fsd.dts
 create mode 100644 arch/arm64/boot/dts/tesla/fsd.dtsi
 create mode 100644 drivers/clk/samsung/clk-fsd.c
 create mode 100644 include/dt-bindings/clock/fsd-clk.h


base-commit: c9e6606c7fe92b50a02ce51dda82586ebdf99b48
-- 
2.17.1

