Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18B75045AE
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 00:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiDPW3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 18:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiDPW3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 18:29:10 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6551EAD5;
        Sat, 16 Apr 2022 15:26:37 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-df02f7e2c9so11025459fac.10;
        Sat, 16 Apr 2022 15:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=hvCxCwUFHQkLQBr7J+w+QCRRJE2MrOWyjavx4Ay8QBM=;
        b=mTvMciFX4PLTzgBdWTBt+DJ4YdwIkipOTVq53aedV1bWIVafyPyQCAcSDqGQpYx66y
         HsAEestO6oxfJjYB46hnoVxFTKZ/vNxAqcohBe27PyfQA/Xnek7T+FyTKURY38qs2a0u
         8244jSQ9t9Bm1D6qJrjoVf1Ht0g9gUGRA4YsSgJzASV9NfTmBWp+jOKHtMB9u4070iPo
         An5rO/hf9YDjl2yBX+oASAhzu8d2FG6CaE0ZG6eFAb27rLqLkPK1ol7yGKsvuKGnwnes
         8O+IA4CGw7H5uor1s8DJdLQ27zRsAXzm4EVphuSGhhpnk3zKgxnRnara0Ra/gF6ULAC8
         04EA==
X-Gm-Message-State: AOAM530WocB+p3/GXwP3vSL3vQwuA7+BVTpDbl+iuRPuSnBgiTTvRQuz
        EmBhW1Zy1OFg3LbWsj5bqw==
X-Google-Smtp-Source: ABdhPJwAU+czzeOWm0Hjm+2PAnXqqQ5eDd7fmD0UgJ0du/QHi33EB6DpQFfnsgngMtOCoGpqeirsxg==
X-Received: by 2002:a05:6870:d1c9:b0:e5:9f16:c94f with SMTP id b9-20020a056870d1c900b000e59f16c94fmr1885553oac.273.1650147996776;
        Sat, 16 Apr 2022 15:26:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id hq6-20020a0568709b0600b000e59102e1bbsm1894823oab.22.2022.04.16.15.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 15:26:36 -0700 (PDT)
Received: (nullmailer pid 3557472 invoked by uid 1000);
        Sat, 16 Apr 2022 22:26:35 -0000
Date:   Sat, 16 Apr 2022 17:26:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v5.18, take 2
Message-ID: <YltCm/NZ+tnI6dzn@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a few more DT fixes.

Rob


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.18-2

for you to fetch changes up to 652980b1541c5a02e6410647c7daf840c06d724a:

  dt-bindings: display: panel-timing: Define a single type for properties (2022-04-14 16:04:52 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.18, part 2:

- Fix scalar property schemas with array constraints

- Fix 'enum' lists with duplicate entries

- Fix incomplete if/then/else schemas

- Add Renesas RZ/V2L SoC support to Mali Bifrost binding

- Maintainers update for Marvell irqchip

----------------------------------------------------------------
Dongjin Yang (1):
      dt-bindings: net: snps: remove duplicate name

Geert Uytterhoeven (1):
      dt-bindings: power: renesas,apmu: Fix cpus property limits

Krzysztof Kozlowski (2):
      dt-bindings: extcon: maxim,max77843: fix ports type
      dt-bindings: irqchip: mrvl,intc: refresh maintainers

Lad Prabhakar (1):
      dt-bindings: gpu: mali-bifrost: Document RZ/V2L SoC

Rob Herring (4):
      dt-bindings: Fix incomplete if/then/else schemas
      dt-bindings: Fix 'enum' lists with duplicate entries
      dt-bindings: Fix array constraints on scalar properties
      dt-bindings: display: panel-timing: Define a single type for properties

 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     |  1 -
 Documentation/devicetree/bindings/bus/ti-sysc.yaml |  1 -
 .../bindings/display/panel/panel-timing.yaml       | 42 +++++------
 .../devicetree/bindings/extcon/maxim,max77843.yaml |  2 +-
 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |  5 +-
 .../devicetree/bindings/hwmon/ti,tmp464.yaml       |  5 +-
 .../devicetree/bindings/iio/adc/adi,ad7476.yaml    |  1 +
 .../bindings/iio/adc/st,stm32-dfsdm-adc.yaml       | 12 ++--
 .../devicetree/bindings/iio/dac/adi,ad5360.yaml    |  6 +-
 .../devicetree/bindings/interconnect/qcom,rpm.yaml | 84 +++++++++++-----------
 .../bindings/interrupt-controller/mrvl,intc.yaml   |  6 +-
 Documentation/devicetree/bindings/media/coda.yaml  |  1 -
 .../bindings/media/mediatek,vcodec-decoder.yaml    |  2 -
 .../bindings/media/mediatek,vcodec-encoder.yaml    |  3 -
 .../media/mediatek,vcodec-subdev-decoder.yaml      |  1 -
 .../bindings/mmc/nvidia,tegra20-sdhci.yaml         |  2 +
 .../devicetree/bindings/net/snps,dwmac.yaml        |  6 +-
 .../devicetree/bindings/net/ti,davinci-mdio.yaml   |  1 +
 .../bindings/phy/nvidia,tegra20-usb-phy.yaml       | 20 +++---
 .../devicetree/bindings/phy/qcom,usb-hs-phy.yaml   | 32 +++++----
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml | 11 ++-
 .../devicetree/bindings/power/renesas,apmu.yaml    |  3 +-
 .../devicetree/bindings/power/supply/bq2415x.yaml  |  1 -
 .../bindings/regulator/fixed-regulator.yaml        | 34 ++++-----
 .../bindings/remoteproc/qcom,sc7280-wpss-pil.yaml  |  4 +-
 .../devicetree/bindings/sound/st,stm32-sai.yaml    |  6 +-
 .../devicetree/bindings/spi/renesas,sh-msiof.yaml  |  2 -
 Documentation/devicetree/bindings/sram/sram.yaml   | 16 ++---
 28 files changed, 145 insertions(+), 165 deletions(-)
