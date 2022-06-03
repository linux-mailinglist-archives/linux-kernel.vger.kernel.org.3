Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F41EC53D006
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345926AbiFCR7Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346187AbiFCRuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:50:52 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8496E59B9A;
        Fri,  3 Jun 2022 10:47:04 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id l84so11260453oif.10;
        Fri, 03 Jun 2022 10:47:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=2zNlEw4nB85sh8if2viVb9BSHeHyHaqpaxepxW9M49M=;
        b=n/gYscpI0b0i2GFJW8a0murd+LopJSmF2fxDB/3r+h40mmHna8acD5BLAAkvLL204t
         aDOc0HSkLu2YiCJyJkd1bcsUOEnRTjqi8vdEMke+tI3BHRnOrJu685d4zKT2meQ8lZFh
         VQlghYgDd6OLlnvmFBJ7bCBpGXbALSNyjqhQk3elnglmHv1cq+f56uk23gg4RM81F4dX
         G/DiwwYAT5pwb7t6ZYZ3BqU1Qk8mP/iYpInaM3Gan30kfkz1NM/9BAwLsmTAsP1FALJq
         V047PEzWszc3PuyyJ1D7qwTMbSFeI9+hE9Hlpnne3U4A+B95BvdOnAGrQk8osE6n5XWE
         o12g==
X-Gm-Message-State: AOAM533Xs6K0xP+3XhYuCkXgIHgga7cunXjhdiTFSqykvNo+bX7d6+h8
        ujkN8tRfPjUiZHk3MvXQ2Q==
X-Google-Smtp-Source: ABdhPJxAYuZBWa+RaA5nnGfbWpx8vAvZW4aD7zx8iDtmxRLOh8cfZs6aYlLqiB+Qiwa1fO9LsX5GQw==
X-Received: by 2002:a05:6808:120a:b0:322:3447:2d7a with SMTP id a10-20020a056808120a00b0032234472d7amr21382071oil.40.1654278423517;
        Fri, 03 Jun 2022 10:47:03 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u1-20020a056808000100b00325cda1ff9esm4254032oic.29.2022.06.03.10.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 10:47:03 -0700 (PDT)
Received: (nullmailer pid 617346 invoked by uid 1000);
        Fri, 03 Jun 2022 17:47:02 -0000
Date:   Fri, 3 Jun 2022 12:47:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v5.19, part 1
Message-ID: <20220603174702.GA614240-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT fixes for 5.19-rc.

Rob


The following changes since commit 8ab2afa23bd197df47819a87f0265c0ac95c5b6a:

  Merge tag 'for-5.19/fbdev-1' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev (2022-05-30 12:46:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.19-1

for you to fetch changes up to 987cf300e76d30b1bdad88d2a662b948ead6fb21:

  dt-bindings: mtd: spi-nand: Add spi-peripheral-props.yaml reference (2022-06-03 11:56:27 -0500)

----------------------------------------------------------------
Devicetree fixes for v5.19-rc:

- Fixes for unevaluatedProperties warnings. These were missed to due to
  a bug in dtschema which is now fixed. The changes involve either
  adding missing properties or removing spurious properties from
  examples.

- Update several Qualcomm binding maintainer email addresses

- Fix typo in imx8mp-media-blk-ctrl example

- Fix fixed string pattern in qcom,smd

- Correct the order of 'reg' entries in Xilinx PCI binding

----------------------------------------------------------------
Bharat Kumar Gogada (1):
      dt-bindings: PCI: xilinx-cpm: Fix reg property order

Jeffrey Hugo (1):
      dt-bindings: clock: Update my email address

Krzysztof Kozlowski (1):
      dt-bindings: soc: qcom,smd: do not use pattern for simple rpm-requests string

Laurent Pinchart (1):
      dt-bindings: soc: imx8mp-media-blk-ctrl: Fix DT example

Rob Herring (7):
      dt-bindings: usb: snps,dwc3: Add missing 'dma-coherent' property
      dt-bindings: PCI: socionext,uniphier-pcie: Add missing child interrupt controller
      dt-bindings: net: Fix unevaluatedProperties warnings in examples
      dt-bindings: PCI: apple: Add missing 'power-domains' property
      dt-bindings: net/dsa: Add spi-peripheral-props.yaml references
      dt-bindings: memory-controllers: ingenic: Split out child node properties
      dt-bindings: mtd: spi-nand: Add spi-peripheral-props.yaml reference

Sibi Sankar (1):
      dt-bindings: Update Sibi Sankar's email address

 .../devicetree/bindings/clock/qcom,mmcc.yaml       |   2 +-
 .../bindings/interconnect/qcom,osm-l3.yaml         |   2 +-
 .../ingenic,nemc-peripherals.yaml                  |  46 +++++++++
 .../bindings/memory-controllers/ingenic,nemc.yaml  |  32 ------
 .../devicetree/bindings/mtd/ingenic,nand.yaml      |   1 +
 .../devicetree/bindings/mtd/spi-nand.yaml          |   1 +
 .../devicetree/bindings/net/cdns,macb.yaml         |   1 -
 .../devicetree/bindings/net/dsa/brcm,b53.yaml      | 115 ++++++++++++---------
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |   1 +
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |   1 +
 .../devicetree/bindings/net/dsa/realtek.yaml       |   1 +
 .../devicetree/bindings/net/mediatek,net.yaml      |   3 +
 .../devicetree/bindings/net/mediatek-dwmac.yaml    |   3 +
 .../bindings/net/wireless/mediatek,mt76.yaml       |   2 +-
 .../devicetree/bindings/pci/apple,pcie.yaml        |   5 +-
 .../bindings/pci/socionext,uniphier-pcie.yaml      |  23 ++++-
 .../devicetree/bindings/pci/xilinx-versal-cpm.yaml |  10 +-
 .../devicetree/bindings/reset/qcom,aoss-reset.yaml |   2 +-
 .../devicetree/bindings/reset/qcom,pdc-global.yaml |   2 +-
 .../soc/imx/fsl,imx8mp-media-blk-ctrl.yaml         |   2 +-
 .../devicetree/bindings/soc/qcom/qcom,smd.yaml     |   4 +-
 .../devicetree/bindings/usb/snps,dwc3.yaml         |   2 +
 22 files changed, 162 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ingenic,nemc-peripherals.yaml
