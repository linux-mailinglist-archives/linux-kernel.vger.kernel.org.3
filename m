Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2E55A9F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbiIASdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 14:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiIASds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 14:33:48 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E347E03E;
        Thu,  1 Sep 2022 11:33:47 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c20so14123231qtw.8;
        Thu, 01 Sep 2022 11:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=t4MOz4hyFM7udJrYf7fDh0BfCZhkVhHzgWpksUtpi5s=;
        b=erTAgaZdSIzj2sCqSc9m32MKjOfn5KYlQQfGZKlS0tOKgOvXNpOYRvItMFB7gJoTxm
         Et7RPS1etxX4HgAQpTeqJHU2ZEZOG0g9BC38gUsFbh553sbiDjqLCmJ4enAKjOc12lVx
         O3xviAmhEHWAifpiUlj8tuZQogj2CgvT7AId/mFpcnJxM7v5fx8jmzKOHKuX6eterJtB
         XCKdzzIu1gF5GKCdEm+X0ZNbCaRYYdCZzCg56R8PM7Dg4ME1mPEMLcZJXDQUSGFc0Q4k
         B4T5w+e/biuFf+IRDH4nNDPHp5Vxgi7FeUvnFbTQyc/H3hH+E3KyHenEdJmYEjPHEZNg
         VUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=t4MOz4hyFM7udJrYf7fDh0BfCZhkVhHzgWpksUtpi5s=;
        b=sFJURSUE/atp9RZbJHN0ZeE3QTUJOTy98qbARGpCwW0WEkxxV5dpRKPyFZbgFmIEJU
         cknfjeHIu/kles46e1b4gF9kWSHE8k7q+VxalV/H6jUBdFjWCxkoTE8bCZvtJ4DQaiMm
         iL1WG5k42jScn3EPj0zY5b1JQM/AQNAyVE2hYmuLlW0na4U7vgP9IWOZ5p+UWSjWDtsq
         2LWlYsYdQWa1bUN+5nWAmt7D/3naCYvUGCke/CE2HZI+79AFuieTIdRV8DAjOncA/75E
         n6qBgKjk+qYsoYZPeUCNYgsHyzDN/p8uMsMOLk2KTa2fmhF6/HysduOVxWQ0q7+TT0R1
         pz5Q==
X-Gm-Message-State: ACgBeo1wcKOMPrFnf7IymdNcIUJyD6bMRIjEMVECXVkKHzVk+1e8Zo6i
        6hySNL/NxIV4DgfQ2mogwwg=
X-Google-Smtp-Source: AA6agR6xpDwOMPSvTKBAaMMhdvQUxT30aSC5TWYUPsxs76GlD60pP91bDsz2MOK3LAfdx0ZLpGnBMA==
X-Received: by 2002:ac8:5b91:0:b0:344:55f7:da72 with SMTP id a17-20020ac85b91000000b0034455f7da72mr25122323qta.542.1662057226843;
        Thu, 01 Sep 2022 11:33:46 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id u20-20020ac87514000000b00342e86b3bdasm10563343qtq.12.2022.09.01.11.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 11:33:45 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v6 00/10]  Add support for i.MXRT1170-evk
Date:   Thu,  1 Sep 2022 14:33:33 -0400
Message-Id: <20220901183343.3188903-1-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch continues support for the imxrt series now adding the imxrt1170

This patch contains:
- Update to imxrt_defconfig
- Devicetree
- Clock driver
- Pinctrl driver
- New pll

This patch also updates some documentation for both imxrt1170 an 1050.

The i.MXRT1170 has a vast array of features including two cores,
2 Ethernet, 2 USB phy, and a 2d gpu.

It also is featured in a new google coral board
https://coral.ai/products/dev-board-micro
Not affiliated unfortunately.

---
V1 -> V2:
 - Add 3 new commits in documentation
 - Fix spelling
---

Jesse Taube (10):
  dt-bindings: arm: imx: Add i.MXRT compatible Documentation
  dt-bindings: timer: gpt: Add i.MXRT compatible Documentation
  dt-bindings: mmc: fsl-imx-esdhc: add i.MXRT1170 compatible
  dt-bindings: serial: fsl-lpuart: add i.MXRT1170 compatible
  ARM: mach-imx: Add support for i.MXRT1170
  clk: imx: Update pllv3 to support i.MXRT1170
  dt-bindings: imx: Add clock binding for i.MXRT1170
  clk: imx: Add initial support for i.MXRT1170 clock driver
  ARM: dts: imx: Add i.MXRT1170-EVK support
  ARM: imxrt_defconfig: Add i.MXRT1170

 .../devicetree/bindings/arm/fsl.yaml          |  12 +
 .../bindings/mmc/fsl-imx-esdhc.yaml           |   4 +
 .../bindings/serial/fsl-lpuart.yaml           |   3 +
 .../devicetree/bindings/timer/fsl,imxgpt.yaml |   2 +
 arch/arm/boot/dts/Makefile                    |   3 +-
 arch/arm/boot/dts/imxrt1170-evk.dts           | 110 +++
 arch/arm/boot/dts/imxrt1170.dtsi              | 276 +++++++
 arch/arm/configs/imxrt_defconfig              |  17 +
 arch/arm/mach-imx/mach-imxrt.c                |   1 +
 drivers/clk/imx/Kconfig                       |   7 +
 drivers/clk/imx/Makefile                      |   1 +
 drivers/clk/imx/clk-imxrt1170.c               | 749 ++++++++++++++++++
 drivers/clk/imx/clk-pllv3.c                   |  57 +-
 drivers/clk/imx/clk.h                         |  11 +-
 include/dt-bindings/clock/imxrt1170-clock.h   | 282 +++++++
 15 files changed, 1526 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/imxrt1170-evk.dts
 create mode 100644 arch/arm/boot/dts/imxrt1170.dtsi
 create mode 100644 drivers/clk/imx/clk-imxrt1170.c
 create mode 100644 include/dt-bindings/clock/imxrt1170-clock.h

-- 
2.36.1

