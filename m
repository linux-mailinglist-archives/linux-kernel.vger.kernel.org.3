Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E01496609
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:53:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiAUTx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:53:28 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:39430 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbiAUTx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:53:26 -0500
Received: by mail-ot1-f47.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso13093663otr.6;
        Fri, 21 Jan 2022 11:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=JD4McLT088Mx8+2ZEBZsNweJZVyYq9otK5A8Lk9paN4=;
        b=v+k/nf2VKw2IJrH8ZvWi+VW9y4+mFaNcElMLcWw5DlKRictroUq6QVzALTKjdr3Qhx
         mhIEAN87jUIbzWI1WPaJqXh+Jp/V+2PHFGH5pcJMBzXbFEHd6J0GtLIi9NkwUpOe7GRU
         jKaDiLINiPAIr4+ysiYE5p+6TxJVHxpk4BIc/4L8LaD/mQ84wa7awbzbiYxf1Rjx7nEI
         4PRTqlx+l7Zdq/rgOOIvhcVy9b+L4FQV8aOccIgbI7fjoWn2F7O73+Rp8gg90SMS3sRA
         0Q50dfTcVWQPZYHZ+Np8PxFvlReF4OaHAlHbEqjHsSK/ZGmlk2xE5AL6yAA3gdxliIvw
         xJeg==
X-Gm-Message-State: AOAM533m8Bj9sB1uKsm6Fs4CwtBv1YuEOP+x5VHyaDO7HCZPM7nteY2d
        3D1omWylHO17Y0QhWx++Jw==
X-Google-Smtp-Source: ABdhPJxLBRsGb8TyimDLqJ487TcbCsd3X0ClwVtYqDUu2pNLxUYNjRjrvJdIG9Gh4flJdQcGdvjtUQ==
X-Received: by 2002:a05:6830:612:: with SMTP id w18mr3857805oti.155.1642794805579;
        Fri, 21 Jan 2022 11:53:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h65sm1664024oia.56.2022.01.21.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:53:24 -0800 (PST)
Received: (nullmailer pid 1460682 invoked by uid 1000);
        Fri, 21 Jan 2022 19:53:23 -0000
Date:   Fri, 21 Jan 2022 13:53:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.17, take 1
Message-ID: <YesPMjmwx4snvWDQ@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull another batch of DT changes for v5.17.

Rob


The following changes since commit e623611b4d3f722b57ceeaf4368ac787837408e7:

  Merge branch 'dt/linus' into dt/next (2022-01-12 10:14:09 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.17-1

for you to fetch changes up to 18a86e5907f7160fb548d0d717e0f842b310708a:

  dt-bindings: google,cros-ec: drop Enric Balletbo i Serra from maintainers (2022-01-20 14:11:08 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.17, take 1:

- Fix a regression when probing a child device reusing the parent
  device's DT node pointer

- Refactor of_parse_phandle*() variants to static inlines

- Drop Enric Balletbo i Serra as a maintainer

- Fix DT schemas with arrays incorrectly encoded as a matrix

- Drop unneeded pinctrl properties from schemas

- Add SPI peripheral schema to SPI based displays

- Clean-up several schema examples

- Clean-up trivial-devices.yaml comments

- Add missing, in use vendor prefixes: Wingtech, Thundercomm, Huawei,
  F(x)tec, 8devices

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      dt-bindings: display: bridge: drop Enric Balletbo i Serra from maintainers
      dt-bindings: google,cros-ec: drop Enric Balletbo i Serra from maintainers

Matthias Schiffer (1):
      scripts/dtc: dtx_diff: remove broken example from help text

Michael Walle (2):
      of: base: make small of_parse_phandle() variants static inline
      of: property: define of_property_read_u{8,16,32,64}_array() unconditionally

Rob Herring (7):
      dt-bindings: display: Add SPI peripheral schema to SPI based displays
      dt-bindings: mmc: arm,pl18x: Make each example a separate entry
      dt-bindings: rtc: st,stm32-rtc: Make each example a separate entry
      dt-bindings: Drop unnecessary pinctrl properties
      dt-bindings: Fix array schemas encoded as matrices
      dt-bindings: mfd: cirrus,madera: Fix 'interrupts' in example
      of: Check 'of_node_reused' flag on of_match_device()

Sander Vanheule (1):
      dt-bindings: power: reset: gpio-restart: Correct default priority

Stanislav Jakubek (7):
      dt-bindings: vendor-prefixes: add 8devices
      dt-bindings: vendor-prefixes: add F(x)tec
      dt-bindings: vendor-prefixes: add Huawei
      dt-bindings: vendor-prefixes: add Thundercomm
      dt-bindings: vendor-prefixes: add Wingtech
      dt-bindings: trivial-devices: fix swapped comments
      dt-bindings: trivial-devices: fix double spaces in comments

 .../bindings/display/bridge/analogix,anx7814.yaml  |   4 +-
 .../display/bridge/google,cros-ec-anx7688.yaml     |   1 -
 .../devicetree/bindings/display/bridge/ps8640.yaml |   1 -
 .../bindings/display/panel/abt,y030xx067a.yaml     |   5 +-
 .../bindings/display/panel/ilitek,ili9322.yaml     |   4 +-
 .../bindings/display/panel/innolux,ej030na.yaml    |   5 +-
 .../display/panel/kingdisplay,kd035g6-54nt.yaml    |   5 +-
 .../bindings/display/panel/lgphilips,lb035q02.yaml |   5 +-
 .../bindings/display/panel/samsung,ld9040.yaml     |   7 +-
 .../bindings/display/panel/samsung,s6e63m0.yaml    |   1 +
 .../bindings/display/panel/sitronix,st7789v.yaml   |   5 +-
 .../bindings/display/panel/sony,acx565akm.yaml     |   5 +-
 .../devicetree/bindings/display/panel/tpo,td.yaml  |   5 +-
 .../display/rockchip/rockchip,rk3066-hdmi.yaml     |   8 -
 .../bindings/extcon/extcon-usbc-cros-ec.yaml       |   1 -
 .../bindings/i2c/google,cros-ec-i2c-tunnel.yaml    |   1 -
 .../proximity/google,cros-ec-mkbp-proximity.yaml   |   1 -
 .../bindings/input/google,cros-ec-keyb.yaml        |   1 -
 .../devicetree/bindings/input/gpio-keys.yaml       |   6 -
 .../bindings/media/nxp,imx7-mipi-csi2.yaml         |  12 +-
 .../bindings/media/nxp,imx8mq-mipi-csi2.yaml       |  12 +-
 .../devicetree/bindings/mfd/cirrus,madera.yaml     |   3 +-
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |   1 -
 .../devicetree/bindings/mmc/arm,pl18x.yaml         |   6 +-
 .../devicetree/bindings/net/can/bosch,m_can.yaml   |  52 ++-
 .../bindings/net/ethernet-controller.yaml          |  59 ++-
 Documentation/devicetree/bindings/nvmem/nvmem.yaml |  17 +-
 .../bindings/pinctrl/cirrus,lochnagar.yaml         |   9 -
 .../devicetree/bindings/pinctrl/cirrus,madera.yaml |  10 -
 .../bindings/power/reset/gpio-restart.yaml         |   4 +-
 .../devicetree/bindings/rtc/st,stm32-rtc.yaml      |   1 +
 .../devicetree/bindings/sound/samsung-i2s.yaml     |   6 -
 .../devicetree/bindings/trivial-devices.yaml       |   8 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |  10 +
 drivers/of/base.c                                  | 131 +------
 drivers/of/device.c                                |   2 +-
 include/linux/of.h                                 | 422 ++++++++++++---------
 scripts/dtc/dtx_diff                               |   8 +-
 38 files changed, 362 insertions(+), 482 deletions(-)
