Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D52B470E39
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 23:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbhLJWyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 17:54:10 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36508 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235394AbhLJWyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 17:54:10 -0500
Received: by mail-ot1-f46.google.com with SMTP id w6-20020a9d77c6000000b0055e804fa524so11133133otl.3;
        Fri, 10 Dec 2021 14:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Zv2SJEG7dxMT51xWLzKdjvzE+4GfXvYq6wZ2VXGzv9A=;
        b=uo7fcPL/+Zasn78MQZZt5zjyGkN2y0vcj4IWg7KsPEpnidUVbmJegRh60roARgq/D7
         XWKWYcX97C3Njq37S+QpaYA3ZBc3V42k9NjazLeHwM1uCMltFmekfdWqC0JTK2XNeElR
         b8JGnb6zj41e0H5wzrDL/gXloeSybxPXr7vkj5Gv5S9bSydD2kveQbOIiFslDnUidEBZ
         0GnMrQ23OhCrvzghenlHh2566a5j7rap4Qt9/YXIHDRkRImD7qYBU6BEGFeutE+RTkfY
         pzu9VqniVSiaBg+jPHIrBXaEd133a4z9Zm61P+Tp7zX8cRZ86qOM1UxZ3Z2FBYisEOdd
         0Klw==
X-Gm-Message-State: AOAM530nLYpmri04JyCl+vbRqBURpdsXbl4jxNXtm1PCmGPooflgWFu+
        r17PgeTe5vOKxtkHf1UbRhmTuzGsUQ==
X-Google-Smtp-Source: ABdhPJx0YTX39U6qxWVSVn8sYrAZymigT2bu+Oc2vgoThaoj7OWiZr9KcK5fFUw1763UCfk6BZQNsw==
X-Received: by 2002:a05:6830:1d68:: with SMTP id l8mr13679456oti.21.1639176634128;
        Fri, 10 Dec 2021 14:50:34 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j20sm998396oig.52.2021.12.10.14.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 14:50:33 -0800 (PST)
Received: (nullmailer pid 2077795 invoked by uid 1000);
        Fri, 10 Dec 2021 22:50:32 -0000
Date:   Fri, 10 Dec 2021 16:50:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.16, take 2
Message-ID: <YbPZuCq+xIc6tqaZ@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a few more DT fixes.

Rob


The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.16-2

for you to fetch changes up to 75e895343d5a2fcbdf4cb3d31ab7492bd65925f0:

  Revert "kbuild: Enable DT schema checks for %.dtb targets" (2021-12-08 15:41:19 -0600)

----------------------------------------------------------------
Devicetree fixes for v5.16-rc, take 2:

- Revert schema checks on %.dtb targets. This was problematic for some
  external build tools.

- A few DT binding example fixes

- Add back dropped 'enet-phy-lane-no-swap' Ethernet PHY property

- Drop erroneous if/then schema in nxp,imx7-mipi-csi2

- Add a quirk to fix some interrupt controllers use of 'interrupt-map'

----------------------------------------------------------------
Alexander Stein (1):
      dt-bindings: net: Reintroduce PHY no lane swap binding

Geert Uytterhoeven (2):
      dt-bindings: iio: adc: exynos-adc: Fix node name in example
      dt-bindings: input: gpio-keys: Fix interrupts in example

Marc Zyngier (1):
      of/irq: Add a quirk for controllers with their own definition of interrupt-map

Rob Herring (2):
      dt-bindings: media: nxp,imx7-mipi-csi2: Drop bad if/then schema
      Revert "kbuild: Enable DT schema checks for %.dtb targets"

Thierry Reding (1):
      dt-bindings: bq25980: Fixup the example

 .../bindings/iio/adc/samsung,exynos-adc.yaml       |  2 +-
 .../devicetree/bindings/input/gpio-keys.yaml       |  2 +-
 .../bindings/media/nxp,imx7-mipi-csi2.yaml         | 14 ++---------
 .../devicetree/bindings/net/ethernet-phy.yaml      |  8 +++++++
 .../devicetree/bindings/power/supply/bq25980.yaml  |  2 +-
 Makefile                                           | 10 ++++----
 drivers/of/irq.c                                   | 27 ++++++++++++++++++++--
 7 files changed, 43 insertions(+), 22 deletions(-)
