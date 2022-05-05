Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4231451C9FE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385622AbiEEULY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 16:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385618AbiEEULV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 16:11:21 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B0E5F250;
        Thu,  5 May 2022 13:07:38 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-ed9a75c453so5278803fac.11;
        Thu, 05 May 2022 13:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=AwA8zWAD2sC5PhAjhWHdWJP1lCys9uNIGcC2bNiqY2Q=;
        b=F333MFoJFLEM36A9gpwjOfyjH2+Otej7rAHacL1zbWevW47rLt7Sz5nVfmUdhrRrau
         P1722PVKXgrzCG2PZEyrmtuaImJOtPqHdM9BPj2iDJiJ293jBbHp6G93j2neU2Iw57e5
         Vw3Vr0yXxiRSJRbbN5a/kpf+rClJiPBSMFn1i7oUnHxkh4lMzY9/MHtZNW0P2XLub/aJ
         08L5XWpDsLJyTxHOblDnbugsbYglaWHsDclzG2gxnKyCit/6m/yqyhNbNHbQSi6E+lu9
         A3IBIC/6KAa4CjyzXpIpsmFIc8H5IUeBxuwcOxfu8WFMg0gCqzaoCYWoIf6AIIk0SnIt
         KwDA==
X-Gm-Message-State: AOAM532aT6PZEmla4JgiuFomJamH8qzVS5Oj2CgB32r1Gi5GMNgWzgTB
        QzPPEOO/xvyXYa370FawS1U9GsW5Jg==
X-Google-Smtp-Source: ABdhPJyj7f2iR1zohw91JUnQvUqY5crABiooFqUbG8qMSjVT3hgmGL59l8Augn3VoD4jHauMVBGIbg==
X-Received: by 2002:a05:6870:478f:b0:e9:8c5c:3c37 with SMTP id c15-20020a056870478f00b000e98c5c3c37mr3017803oaq.217.1651781257647;
        Thu, 05 May 2022 13:07:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w12-20020a056870430c00b000e686d1389fsm852672oah.57.2022.05.05.13.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 13:07:37 -0700 (PDT)
Received: (nullmailer pid 107799 invoked by uid 1000);
        Thu, 05 May 2022 20:07:36 -0000
Date:   Thu, 5 May 2022 15:07:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v5.18, take 3
Message-ID: <YnQuiPwutfe6EKGf@robh.at.kernel.org>
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

Please pull a couple more DT fixes for 5.18.

Rob


The following changes since commit 652980b1541c5a02e6410647c7daf840c06d724a:

  dt-bindings: display: panel-timing: Define a single type for properties (2022-04-14 16:04:52 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.18-3

for you to fetch changes up to 5dc4630426511f641b7ac44fc550b8e21eafb237:

  dt-bindings: pci: apple,pcie: Drop max-link-speed from example (2022-05-04 17:18:27 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.18, part 3:

- Drop unused 'max-link-speed' in Apple PCIe

- More redundant 'maxItems/minItems' schema fixes

- Support values for pinctrl 'drive-push-pull' and 'drive-open-drain'

- Fix redundant 'unevaluatedProperties' in MT6360 LEDs binding

- Add missing 'power-domains' property to Cadence UFSHC

----------------------------------------------------------------
Hector Martin (1):
      dt-bindings: pci: apple,pcie: Drop max-link-speed from example

Krzysztof Kozlowski (1):
      dt-bindings: ufs: cdns,ufshc: Add power-domains

Rob Herring (3):
      dt-bindings: leds-mt6360: Drop redundant 'unevaluatedProperties'
      dt-bindings: pinctrl: Allow values for drive-push-pull and drive-open-drain
      dt-bindings: Drop redundant 'maxItems/minItems' in if/then schemas

 .../devicetree/bindings/clock/imx8m-clock.yaml     |  4 ----
 .../bindings/display/bridge/renesas,lvds.yaml      |  4 ----
 .../devicetree/bindings/display/renesas,du.yaml    | 23 ----------------------
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |  2 --
 .../devicetree/bindings/leds/leds-mt6360.yaml      |  2 --
 .../bindings/mmc/nvidia,tegra20-sdhci.yaml         |  7 +------
 .../devicetree/bindings/mtd/gpmi-nand.yaml         |  2 --
 .../devicetree/bindings/net/can/bosch,c_can.yaml   |  3 ---
 .../devicetree/bindings/pci/apple,pcie.yaml        |  3 ---
 .../devicetree/bindings/phy/brcm,sata-phy.yaml     | 10 ++++------
 .../devicetree/bindings/pinctrl/pincfg-node.yaml   | 12 +++++++++--
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml      | 10 ----------
 .../devicetree/bindings/serial/samsung_uart.yaml   |  4 ----
 .../bindings/sound/allwinner,sun4i-a10-i2s.yaml    |  1 -
 .../bindings/sound/ti,j721e-cpb-audio.yaml         |  2 --
 .../bindings/thermal/rcar-gen3-thermal.yaml        |  1 -
 .../devicetree/bindings/ufs/cdns,ufshc.yaml        |  3 +++
 17 files changed, 18 insertions(+), 75 deletions(-)
