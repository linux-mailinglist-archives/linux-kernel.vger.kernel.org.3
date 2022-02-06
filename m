Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EF44AB29C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 23:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237883AbiBFWSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 17:18:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiBFWSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 17:18:36 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AC4C06173B;
        Sun,  6 Feb 2022 14:18:35 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ka4so36484104ejc.11;
        Sun, 06 Feb 2022 14:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ndvVG8PppU1q6zgmhfWtx/U0/AcHLfiB5ez8eWAuiM0=;
        b=dO2ABgghuCjrlXVuQZAbM0LfcNTau2p74DbNzabG4isw0dsDj6671p6whvKKCJ8q8n
         CDrvktw9YHONjrJOgFO/rlbCIFfKObaZclgyUKD+7rLnYXXg23uKaRF3LpQ4Q566cXLs
         3+0asMVHcfw/FqjKGuyhakJDn9X9B9E7MJWwnHJri7HWjoH4WFUG99eeSns/FCv4/Xs8
         E97JwjoHRmv+LBUU2bZ04Wzhto9ya+zzvXcsx3PPfMe/v9sO//DU4HgddHbcWwgx9DVp
         6gFbXVHQqBRXy63rl2fYTFsIi3v6IesOOLiwA8fWazCoCewTPtrek7xO5LQXBvwh+iys
         vyOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ndvVG8PppU1q6zgmhfWtx/U0/AcHLfiB5ez8eWAuiM0=;
        b=5zPhnMXmrVXYWyHLupkx1I6+VxxBEr+KypdsctVE0MpJ1uFZb+JmXUa2/29QDWEVjb
         hCzYlO9HzgAKR1VlLSRg2zYb9fPjR1Br5wCYyNx1HGDz67H8DA7g6MHauKzaOgtgC9LL
         e+0AM4rLmZVuqjJuP9SvaKMxqv5vYH0EovDTTMZMO25V9JKRQnOQFIKZZMELU52b9O9r
         T6i8CViPtnsJluXnEvDtW6GYBMGrFY5bg7X33yWksKaD28jpmZvOZur/Hzp8iwFiNn99
         Mx3AlawEKlqFOKi9lvhKhv30Pja4OBMnJRU2hI1hMVt7aNqAIr77Stev/m+e3QgvVcpH
         WPsA==
X-Gm-Message-State: AOAM5329MqDrV85SEHpEFJzrnC2t0MQMd4+ChaNZ738KZvyH3hepJpSz
        brqUEQlCvPgMqlfbnYuXH+I=
X-Google-Smtp-Source: ABdhPJzCy2rjqU0nVTZ/5hl+kH3DHSL6ZpDb7tuD4vOQUhlPgvNBxKhDldCMOANq//76iElEujTj2Q==
X-Received: by 2002:a17:907:6e16:: with SMTP id sd22mr7720582ejc.172.1644185913749;
        Sun, 06 Feb 2022 14:18:33 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id a17sm2347289edt.92.2022.02.06.14.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 14:18:33 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        phone-devel@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/1] Initial Samsung Galaxy A8 (2018) support
Date:   Mon,  7 Feb 2022 00:18:14 +0100
Message-Id: <20220206231816.127650-1-virag.david003@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Changes in v5:
- Only kept DTS patch as the rest have been merged.
- Several fixes in DTS patch

[1] https://github.com/VDavid003/minimal_sboot_wrapper

David Virag (1):
  arm64: dts: exynos: Add initial device tree support for Exynos7885 SoC

 arch/arm64/boot/dts/exynos/Makefile           |   7 +-
 .../boot/dts/exynos/exynos7885-jackpotlte.dts |  93 ++
 .../boot/dts/exynos/exynos7885-pinctrl.dtsi   | 855 ++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    | 440 +++++++++
 4 files changed, 1392 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885.dtsi

-- 
2.35.1

