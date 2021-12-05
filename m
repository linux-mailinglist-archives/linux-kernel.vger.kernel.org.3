Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F247468BCA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 16:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbhLEPiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 10:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235449AbhLEPiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 10:38:06 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD30C061714;
        Sun,  5 Dec 2021 07:34:39 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o20so32704935eds.10;
        Sun, 05 Dec 2021 07:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCWVRIBty2ysTW9LxrCBVZ2lJJbgYXQd/K1AUKUM9lE=;
        b=m6EM0vjYH3agoF3Xok1WIcUpDBDbqoqgu1qqYXCnFbemDd8ATnQ8LSbWE9BNlvwede
         4Eez0YxxdSln5svizIZkPLFxXHINCUJzQIfQDEQ0+tY1LvguAo6pdYvhIAjB64EGxKc9
         AoOfSJDvtQ1vPamqJtT2SIyqJYmnQVsl6mr9n72OcEpZlXeG14aGIWP4V5vOv4C20v35
         yymId3qzLZP3LObA5p94ed+PAo6cInbQPEMN9c4krTvnZUqVvdEWnLssaShl4bBELcJN
         RYjEMMj2JG7/pRrqtoZuAYP5e+0tdELh2xzqNANLcz9IhSa78Xsabe8RHYHv3k5yxFs3
         cCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uCWVRIBty2ysTW9LxrCBVZ2lJJbgYXQd/K1AUKUM9lE=;
        b=xXGI5BGetlpGTCOcK4aNPuJ0WJQF3SZe2e3mUtYKghOX7/gdOtXbKhRvFRbC1k+VIW
         j0+d9iizRt0z7jqYNG8gVYuz1jZYiGslIm2jcJn+ti9nzqJIcTg6EWECoYb7VIQTeCt0
         AteePsg6Yhbc9FPtIe15JqyCIMpzSx+9zjYVMN1rxuhxQuix3/tXosVh66oTyp/zv5WQ
         j2L9UC6HNAuqPYXWu6KRJldUsxzm/brvUmSKCQnVnrFag2I/twTKQHc675u7jKzVxuHZ
         IgK7sUXRzrJ4UCZjJ7oxQSPptrfTu4jxdpHas7+0A3tBg+BhhNRrjJV7EdcRYTnvTVRe
         qgdQ==
X-Gm-Message-State: AOAM531i1S3RAzIMJOaMPfeVOmygrv5Xvr0C3K/YA/FdRDPya+hnAaCq
        8imElPD+7VNuHfFKpM7s4QIKqNt8ZiznsaBW
X-Google-Smtp-Source: ABdhPJxCNkgizFyBLpcFDeokmUs3vnv0IUg1QQtE31Pu9qVoohNJAdy0nySzwt78D/EODAthvIOO+Q==
X-Received: by 2002:aa7:c714:: with SMTP id i20mr45489449edq.180.1638718478149;
        Sun, 05 Dec 2021 07:34:38 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:eab:126a:947d:3008])
        by smtp.googlemail.com with ESMTPSA id sa17sm5529941ejc.123.2021.12.05.07.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 07:34:37 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     David Virag <virag.david003@gmail.com>,
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
Subject: [PATCH 0/6] Initial Samsung Galaxy A8 (2018) support
Date:   Sun,  5 Dec 2021 16:32:54 +0100
Message-Id: <20211205153302.76418-1-virag.david003@gmail.com>
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

The preferred way to boot this device is using my Minimal S-Boot Wrapper
[1] to work around some issues caused by the stock, and non-replacable
Samsung S-Boot bootloader.

[1] https://github.com/VDavid003/minimal_sboot_wrapper

David Virag (6):
  clk: samsung: clk-pll: Add support for pll1417x
  dt-bindings: clock: Add bindings definitions for Exynos7885 CMU
  dt-bindings: clock: Document Exynos7885 CMU bindings
  clk: samsung: Add initial Exynos7885 clock driver
  dt-bindings: arm: samsung: document jackpotlte board binding
  arm64: dts: exynos: Add initial device tree support for Exynos7885 SoC

 .../bindings/arm/samsung/samsung-boards.yaml  |   6 +
 .../clock/samsung,exynos7885-clock.yaml       | 166 ++++
 arch/arm64/boot/dts/exynos/Makefile           |   7 +-
 .../boot/dts/exynos/exynos7885-jackpotlte.dts |  95 ++
 .../boot/dts/exynos/exynos7885-pinctrl.dtsi   | 929 ++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    | 444 +++++++++
 drivers/clk/samsung/Makefile                  |   1 +
 drivers/clk/samsung/clk-exynos7885.c          | 680 +++++++++++++
 drivers/clk/samsung/clk-pll.c                 |   1 +
 drivers/clk/samsung/clk-pll.h                 |   1 +
 include/dt-bindings/clock/exynos7885.h        | 115 +++
 11 files changed, 2442 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,exynos7885-clock.yaml
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885.dtsi
 create mode 100644 drivers/clk/samsung/clk-exynos7885.c
 create mode 100644 include/dt-bindings/clock/exynos7885.h

-- 
2.34.1

