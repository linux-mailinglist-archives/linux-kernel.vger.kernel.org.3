Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1145947652C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 23:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbhLOWFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 17:05:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhLOWFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 17:05:42 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E893C061574;
        Wed, 15 Dec 2021 14:05:42 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id m192so21558051qke.2;
        Wed, 15 Dec 2021 14:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82TjwUfk9T2/ds3Ciyj/zGT4kaKZHzrrPS0KAqF4ALY=;
        b=Vw4Ln5z5bJ1z4j37TQH8Minz9tGBBCeVuWNd1Zp92mp05MfCGPJyyfL9T2gzSFrVuA
         L5I/AE2EXSJ7/+1dwo2uE/6OeXAfmOlCKXAQUoaw3GGQXJHgE9trosGjCuj0XIhYVgDM
         vVdmAsbqu+MYJkM1Nn3Nof6BeNvrOfLUPUDxYY83n+YeJyJXukMZPPivAnsSQDGwWYH2
         k3cDEkw6XaLun4Oa+uCzy/U8TxzJYd8pVqi3Xzz35P/kNXrXFbC85WWeShHcHorfrgqo
         zgBWO+yUUyBLJ6uV2MV2XzIVwZAXev3QfxK4zlMIz0Cx9ktR3kHUM1VOjI9hhcgfBNfz
         16Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=82TjwUfk9T2/ds3Ciyj/zGT4kaKZHzrrPS0KAqF4ALY=;
        b=B523/dQWDbD41kjfaUWCCsh0wlcr0o7b7nNcGYOKz3y4ErMmMjs9pXw0qHlsqG3aeh
         v5l0P1aBuB51xuUuqeIN6lveDfDeYHKf5MB0LWjJynEZBcUUFTa7N1HD3aWvcAtlp4rS
         cq57T7kfh8h2xLSS3dO81BDuLMjd6MEOt2cM2hkWKQVTBM24N4tyy6EBvz3IAN+jqzSx
         6oDb5PeBBf+y3RnEgBw9EIeQOdU4ltamDVYyIMVqXZOSry0yHkox64EVcfJlxr7Nj8WM
         tcDrX2bUfLXm+ORKLvmnMbOKsEdxOXLXhunInmRlxcfXP2wwKVP28N5leNwCh0f3iNOF
         bVGw==
X-Gm-Message-State: AOAM532l1A/F1qM7Ln/8WUGn7cGBoF48D2nToV7vNpvm2YKpTcm8i+g5
        h+3aLo/qRaW/rLiZdQNCn30=
X-Google-Smtp-Source: ABdhPJy6zw4A2uEDI0uCUlM5KpQmgZDOHGlxjcoHCdvjCKDQYGLWVUUcTm5W6ciyxP6apXSAQr1dJQ==
X-Received: by 2002:a37:9ed5:: with SMTP id h204mr10494788qke.35.1639605941389;
        Wed, 15 Dec 2021 14:05:41 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id s20sm2471592qtc.75.2021.12.15.14.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 14:05:40 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v5 0/9]  Add initial support for the i.MXRTxxxx SoC family starting from i.IMXRT1050 SoC.
Date:   Wed, 15 Dec 2021 17:05:29 -0500
Message-Id: <20211215220538.4180616-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains:
- i.MXRT10xx family infrastructure
- i.MXRT1050 pinctrl driver adaption
- i.MXRT1050 clock driver adaption
- i.MXRT1050 sd-card driver adaption
- i.MXRT1050 uart driver adaption
- i.MXRT1050-evk basic support

The i.MXRTxxxx family that could have support by Linux actually spreads
from i.MXRT1020 to i.MXRT1170 with the first one supporting 1 USB OTG &
100M ethernet with a cortex-M7@500Mhz up to the latter with i.MXRT1170
with cortex-M7@1Ghz and cortex-M4@400Mhz, 2MB of internal SRAM, 2D GPU,
2x 1Gb and 1x 100Mb ENET. The i.MXRT family is NXP's answer to
STM32F7XX, as it uses only simple SDRAM, it gives the chance of a 4 or
less layer PCBs. Seeing that these chips are comparable to the
STM32F7XXs which have linux ported to them it seems reasonable to add
support for them.

Giving Linux support to this family should ease the development process,
instead of using a RTOS they could use Embedded Linux allowing for more
portability, ease of design and will broaden the scope of people using
embedded linux.

The EVK has very little SDRAM, generally 32MB starting from
i.MXRT1020(the lowest P/N), although the i.MXRT1160/70 provide instead
64MB of SDRAM for more functionality.

At the moment we do not support XIP for either u-boot or Linux but it
should be done in the future. XIP will also save SDRAM.

Another interesting fact is the amount of internal SRAM, as the P/N
increases the SRAM will reach up to 2MB(some could be for cache and
some would be for video).

Also, some parts have embed flash of 4MB that can be used for
u-boot/Linux, if both correctly sized it will leave the SDRAM free.

External flash can be Quad SPI and HyperFlash, so throughput would be
decent.

The i.MXRT11xx series supports MIPI interface too.

The family in general provide CAN bus, audio I/O, 1 or more
USB(otg/host), 1 or more 100Mb/1Gb ethernet, camera interface, sd-card.

All this can be used for simple GUIs, web-servers, point-of-sale
stations, etc.

Giulio Benetti (4):
  ARM: imx: Add initial support for i.MXRT10xx family
  dt-bindings: imx: Add clock binding for i.MXRT1050
  ARM: dts: imx: Add i.MXRT1050-EVK support
  ARM: imxrt_defconfig: Add i.MXRT family defconfig

Jesse Taube (5):
  ARM: dts: imxrt1050-pinfunc: Add pinctrl binding header
  dt-bindings: clock: imx: Add documentation for i.MXRT1050 clock
  clk: imx: Add initial support for i.MXRT1050 clock driver
  dt-bindings: serial: fsl-lpuart: add i.MXRT1050 compatible
  tty: serial: fsl_lpuart: Add i.MXRT1050 support

 .../bindings/clock/imxrt1050-clock.yaml       |  66 ++
 .../bindings/serial/fsl-lpuart.yaml           |   1 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/imxrt1050-evk.dts           |  72 ++
 arch/arm/boot/dts/imxrt1050-pinfunc.h         | 993 ++++++++++++++++++
 arch/arm/boot/dts/imxrt1050.dtsi              | 154 +++
 arch/arm/configs/imxrt_defconfig              |  35 +
 arch/arm/mach-imx/Kconfig                     |   7 +
 arch/arm/mach-imx/Makefile                    |   2 +
 arch/arm/mach-imx/mach-imxrt.c                |  19 +
 drivers/clk/imx/Kconfig                       |   5 +
 drivers/clk/imx/Makefile                      |   1 +
 drivers/clk/imx/clk-imxrt1050.c               | 181 ++++
 drivers/tty/serial/fsl_lpuart.c               |   8 +
 include/dt-bindings/clock/imxrt1050-clock.h   |  73 ++
 15 files changed, 1619 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
 create mode 100644 arch/arm/boot/dts/imxrt1050-evk.dts
 create mode 100644 arch/arm/boot/dts/imxrt1050-pinfunc.h
 create mode 100644 arch/arm/boot/dts/imxrt1050.dtsi
 create mode 100644 arch/arm/configs/imxrt_defconfig
 create mode 100644 arch/arm/mach-imx/mach-imxrt.c
 create mode 100644 drivers/clk/imx/clk-imxrt1050.c
 create mode 100644 include/dt-bindings/clock/imxrt1050-clock.h

-- 
2.34.1

