Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD5A546CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbiFJSzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344236AbiFJSzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:55:01 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF6916BE1B;
        Fri, 10 Jun 2022 11:54:59 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id y79so7638135iof.2;
        Fri, 10 Jun 2022 11:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=XFJP0W9P3nmZgmGzrDbKIpL7gl4ZLTzQ3iGuT9QJtWA=;
        b=62dS8Gu1WJCcIatyG++69nlil8ErH/FZxqF6E4qUq92h7oo0hm5keZyTJeWrxIlBAg
         krXhAf5Is0/Hy9OpojU/wqUDcF/X5fB64L+MPJUBr5gPOZAI93f7GhYpF55DWAFjS0Qw
         HyqaMRI67Hb4jmuq3AsViJ6eMm21NBX9guOk+RWP3oHbIrCeYzfN1jI4Pew3LTNGljCb
         MvZ+acVWYKPY+5d3wbho+OE/40zNKZrinESb+CCwhaNEKo8D0biY1RGAQyQ6NX66S4d7
         Z9Qp2QmOVYoatATxN7ysX3Q5iju1X6O4k4cdv1Woa2S/JnMpRum9mO1QOIsN+UL9wvYk
         ZZLw==
X-Gm-Message-State: AOAM5330Q7oG16o2eYzDnFyRWBjINarJbyfFQSaljqbW3tRGaXs5YRgw
        aX/5A9/hxZq94OXwj27jI/ZNn6q1LQ==
X-Google-Smtp-Source: ABdhPJycdS9Xlkx3gUE8xOYM2P+AgPPnDiky0gjKvJoX4y6MgwpZC1cmopv30zy8I7c+nKJyImgwYA==
X-Received: by 2002:a02:94c5:0:b0:331:7154:9823 with SMTP id x63-20020a0294c5000000b0033171549823mr22941811jah.232.1654887298740;
        Fri, 10 Jun 2022 11:54:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id g12-20020a02b70c000000b0032e36d3843fsm11207380jam.19.2022.06.10.11.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 11:54:58 -0700 (PDT)
Received: (nullmailer pid 2009226 invoked by uid 1000);
        Fri, 10 Jun 2022 18:54:57 -0000
Date:   Fri, 10 Jun 2022 12:54:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v5.19, part 2
Message-ID: <20220610185457.GA2005396-robh@kernel.org>
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

Please pull another batch of DT fixes.

Rob


The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.19-2

for you to fetch changes up to 0b9431c8221cfe73d06f6b9cd37b813fa52be8ce:

  dt-bindings: display: arm,malidp: remove bogus RQOS property (2022-06-10 12:32:05 -0600)

----------------------------------------------------------------
Devicetree fixes for 5.19, part 2:

- More DT meta-schema check fixes from new bindings in merge window

- Fix stale DT binding references from Mauro

- Update various binding maintainers

- Fix in arm,malidp properties to match reality

- Add deprecated 'atheros' vendor prefix

----------------------------------------------------------------
Andre Przywara (1):
      dt-bindings: display: arm,malidp: remove bogus RQOS property

Krishna Manikandan (1):
      dt-bindings: msm: update maintainers list with proper id

Krzysztof Kozlowski (1):
      dt-bindings: vendor-prefixes: document deprecated Atheros

Luca Ceresoli (1):
      dt-bindings: update Luca Ceresoli's e-mail address

Lukas Bulwahn (1):
      MAINTAINERS: rectify entries for ARM DRM DRIVERS after dt conversion

Mauro Carvalho Chehab (8):
      dt-bindings: mfd: bd9571mwv: update rohm,bd9571mwv.yaml reference
      dt-bindings: interrupt-controller: update brcm,l2-intc.yaml reference
      dt-bindings: arm: update vexpress-config.yaml references
      dt-bindings: reset: update st,stih407-powerdown.yaml references
      dt-bindings: mfd: rk808: update rockchip,rk808.yaml reference
      MAINTAINERS: update cortina,gemini-ethernet.yaml reference
      MAINTAINERS: update dongwoon,dw9807-vcm.yaml reference
      MAINTAINERS: update snps,axs10x-reset.yaml reference

Rob Herring (3):
      dt-bindings: nvme: apple,nvme-ans: Drop 'maxItems' from 'apple,sart'
      dt-bindings: Drop more redundant 'maxItems/minItems' in if/then schemas
      dt-bindings: pinctrl: ralink: Fix 'enum' lists with duplicate entries

Wesley Cheng (1):
      dt-bindings: Update QCOM USB subsystem maintainer information

 .../ABI/testing/sysfs-driver-bd9571mwv-regulator   |  2 +-
 .../devicetree/bindings/clock/idt,versaclock5.yaml |  2 +-
 .../bindings/cpufreq/brcm,stb-avs-cpu-freq.txt     |  2 +-
 .../devicetree/bindings/display/arm,malidp.yaml    |  7 +-----
 .../bindings/display/msm/dpu-sc7180.yaml           |  2 +-
 .../bindings/display/msm/dpu-sc7280.yaml           |  2 +-
 .../bindings/display/msm/dpu-sdm845.yaml           |  2 +-
 .../bindings/display/msm/dsi-controller-main.yaml  |  2 +-
 .../bindings/display/msm/dsi-phy-10nm.yaml         |  2 +-
 .../bindings/display/msm/dsi-phy-14nm.yaml         |  2 +-
 .../bindings/display/msm/dsi-phy-20nm.yaml         |  2 +-
 .../bindings/display/msm/dsi-phy-28nm.yaml         |  2 +-
 .../bindings/display/msm/dsi-phy-common.yaml       |  2 +-
 .../devicetree/bindings/hwmon/vexpress.txt         |  2 +-
 .../memory-controllers/nvidia,tegra186-mc.yaml     |  3 ---
 .../devicetree/bindings/mfd/maxim,max77714.yaml    |  2 +-
 .../bindings/mmc/marvell,xenon-sdhci.yaml          |  1 -
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml   |  1 -
 .../devicetree/bindings/phy/phy-stih407-usb.txt    |  2 +-
 .../bindings/phy/qcom,qmp-usb3-dp-phy.yaml         |  2 +-
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |  2 +-
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |  2 +-
 .../devicetree/bindings/pinctrl/pinctrl-rk805.txt  |  2 +-
 .../bindings/pinctrl/ralink,mt7620-pinctrl.yaml    | 26 +++++++++++++--------
 .../bindings/pinctrl/ralink,rt305x-pinctrl.yaml    | 27 ++++++++++------------
 .../bindings/power/supply/maxim,max77976.yaml      |  2 +-
 .../regulator/qcom,usb-vbus-regulator.yaml         |  2 +-
 .../devicetree/bindings/regulator/vexpress.txt     |  2 +-
 Documentation/devicetree/bindings/usb/dwc3-st.txt  |  2 +-
 Documentation/devicetree/bindings/usb/ehci-st.txt  |  2 +-
 Documentation/devicetree/bindings/usb/ohci-st.txt  |  2 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |  2 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |  3 +++
 .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml |  1 -
 MAINTAINERS                                        | 12 +++++-----
 35 files changed, 64 insertions(+), 69 deletions(-)
