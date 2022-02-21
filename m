Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6945E4BEA64
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiBUSvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 13:51:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233873AbiBUSvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:51:13 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7FF195;
        Mon, 21 Feb 2022 10:50:49 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id p15so35461872ejc.7;
        Mon, 21 Feb 2022 10:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pQO7ydSB+50ZXan7KxUTGPR/+jBW3P05AbbyHsGBMKY=;
        b=MiHsA54rwzT6JJTQGupn68fWrBjqzaF61BiDr8rHkbH8QnbpbyoSumktR8sO1QRCAB
         rHx0ANh1OECLZVHur9t8k0XntOogV7eF9VuSxKFYr0mMHGW2wrtdXOMkVBA17kUF90uG
         WCqFo64y0vxipTMMEqbJyuju4cXFzaOdjwmEQ7Xl6MN59qjfPGDH0GevCTfV7h6yMHek
         hUMtbqmH/FAp2hddDV0GFA1qFdZ50bUfGUC8+0q2dzGGqb0++0jEsAVMOzTcibVCIQID
         ClDxidSt//yLe33TJ3qg80pzV28dqw568vxbEOiLWGiBgfT6NXAki/66ybGN0ghiUrh2
         nZ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pQO7ydSB+50ZXan7KxUTGPR/+jBW3P05AbbyHsGBMKY=;
        b=XZPXr4sBKY2JsojxLG0WzQZWqO22FhXiOHp1HYrAD0rUnjgu99MPNdZdxZzV0xldWT
         xOEIdAcLODMAyRBnRMfadsyZ9jQTpr+tEWY4DQpPYJoazWDWn3v9Z935qcKMyfQdDqWA
         ugUWFzhhayp51kYMoARWi4PV/2TJu0iPsoLr/jhpmsgkTkztUllCzwIdzGz5S8T0oTH9
         /LVDDGJ0OiJuM5TNVB1xM+jnvZi0q3w5kYleX27relohuYm0VV2YjEiHYsnRagfyki11
         JtnYyOn1gsVcL50WTVraFzOJjg55p7iJKaaJCbNJVz2jtAtW8T+D+UezR0GEoN2t1Pg7
         ec2A==
X-Gm-Message-State: AOAM5331LodJMkV9bOSMQqPvKNTDE1yLPQVytc+uPMpYyniX1tDhWyWQ
        uGVlBxZkbTQiqfQUAwPtm11cluMoLtCIcub8
X-Google-Smtp-Source: ABdhPJzFGoAnbg9Tir3q3AwivZ1RtHXAgpklM0kqVF+wy/ZDxtkkjMKtPZ8fHxt6/8Tr65w8HfFw/A==
X-Received: by 2002:a17:906:a057:b0:6cf:2736:ba65 with SMTP id bg23-20020a170906a05700b006cf2736ba65mr16575265ejb.171.1645469447972;
        Mon, 21 Feb 2022 10:50:47 -0800 (PST)
Received: from localhost.localdomain ([2a02:ab88:368f:2080:5d6e:322:57b6:5f03])
        by smtp.googlemail.com with ESMTPSA id 23sm5334497ejg.209.2022.02.21.10.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 10:50:47 -0800 (PST)
From:   David Virag <virag.david003@gmail.com>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        phone-devel@vger.kernel.org,
        David Virag <virag.david003@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/1] Initial Samsung Galaxy A8 (2018) support
Date:   Mon, 21 Feb 2022 20:49:55 +0100
Message-Id: <20220221194958.117361-1-virag.david003@gmail.com>
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

Changes in v6:
- DTS patch fixes
- Rebased on top of linux-next

[1] https://github.com/VDavid003/minimal_sboot_wrapper

David Virag (1):
  arm64: dts: exynos: Add initial device tree support for Exynos7885 SoC

 arch/arm64/boot/dts/exynos/Makefile           |   9 +-
 .../boot/dts/exynos/exynos7885-jackpotlte.dts |  92 ++
 .../boot/dts/exynos/exynos7885-pinctrl.dtsi   | 855 ++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7885.dtsi    | 423 +++++++++
 4 files changed, 1375 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-jackpotlte.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7885.dtsi

-- 
2.35.1

