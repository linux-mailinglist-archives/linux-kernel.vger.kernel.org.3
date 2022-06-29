Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63B9560516
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiF2QAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiF2QAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:00:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115341BEA5;
        Wed, 29 Jun 2022 09:00:04 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 88F06660191F;
        Wed, 29 Jun 2022 17:00:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656518402;
        bh=5jzvCGoUrHrL5/yJf6+vhjz74pv3DFTUx5ZwFy+A7lE=;
        h=From:To:Cc:Subject:Date:From;
        b=VOBtIa4ti0aCegzf39rysZ4fDCzi3EmDzqdPU9xjnlfjx99gJ81qXdysK3qxh+3pN
         QnN//y85NmTQf455lS05Nn7IcXaHbaxPDD8sm4I+b2tPWA8NhDS6wW3l6dK/EIaXEA
         dAzXaf8mqiy6czNH8y/Au/dJPnibIcI9T8sFvsSU2Py4vi3/bv1UpDuvcNIxxoqL7Q
         npBsJixzWFH29p37i0gmdRKfyroLZwYvDVJp6kvzIhTeqsSbLb8SEwUl8OLQ1srHdy
         55ewnKYjM1h6cEZOqiajM3ItlHLIVF5B8SL+O2rF60B5PM3RfIXysf5kZn7t/tPD8b
         h8Z7HI0jab0sQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, Maxim Kutnij <gtk3@inbox.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 00/19] Introduce support for MediaTek MT8192 Google Chromebooks
Date:   Wed, 29 Jun 2022 11:59:37 -0400
Message-Id: <20220629155956.1138955-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series introduces Devicetrees for the MT8192-based Asurada platform
as well as Asurada Spherion and Asurada Hayato boards.

Support for the boards is added to the extent that is currently enabled
in the mt8192.dtsi, and using only properties already merged in the
dt-bindings, as to not add any dependencies to this series.

This series was peer-reviewed internally before submission.

Series tested on next-20220629.

v3: https://lore.kernel.org/all/20220512205602.158273-1-nfraprado@collabora.com/
v2: https://lore.kernel.org/all/20220505194550.3094656-1-nfraprado@collabora.com/
v1: https://lore.kernel.org/all/20220316151327.564214-1-nfraprado@collabora.com/

Changes in v4:
- Added patches 17-19 enabling MMC, SCP and SPI NOR flash
- Switched mediatek,drive-strength-adv for drive-strength-microamp
- Switched mediatek,pull-up-adv for bias-pull-up
- Updated Vgpu minimum voltage to appropriate value

Changes in v3:
- Renamed regulator nodes to be generic
- Fixed keyboard layout for Hayato

Changes in v2:
- Added patches 1-2 for Mediatek board dt-bindings
- Added patches 13-16 enabling hardware for Asurada that has since been
  enabled on mt8192.dtsi

Nícolas F. R. A. Prado (19):
  dt-bindings: arm64: dts: mediatek: Add mt8192-asurada-spherion
  dt-bindings: arm64: dts: mediatek: Add mt8192-asurada-hayato
  arm64: dts: mediatek: Introduce MT8192-based Asurada board family
  arm64: dts: mediatek: asurada: Document GPIO names
  arm64: dts: mediatek: asurada: Add system-wide power supplies
  arm64: dts: mediatek: asurada: Enable and configure I2C and SPI busses
  arm64: dts: mediatek: asurada: Add ChromeOS EC
  arm64: dts: mediatek: asurada: Add keyboard mapping for the top row
  arm64: dts: mediatek: asurada: Add Cr50 TPM
  arm64: dts: mediatek: asurada: Add Elan eKTH3000 I2C trackpad
  arm64: dts: mediatek: asurada: Add I2C touchscreen
  arm64: dts: mediatek: spherion: Add keyboard backlight
  arm64: dts: mediatek: asurada: Enable XHCI
  arm64: dts: mediatek: asurada: Enable PCIe and add WiFi
  arm64: dts: mediatek: asurada: Add MT6359 PMIC
  arm64: dts: mediatek: asurada: Add SPMI regulators
  arm64: dts: mediatek: asurada: Enable MMC
  arm64: dts: mediatek: asurada: Enable SCP
  arm64: dts: mediatek: asurada: Add SPI NOR flash memory

 .../devicetree/bindings/arm/mediatek.yaml     |  13 +
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../dts/mediatek/mt8192-asurada-hayato-r1.dts |  47 +
 .../mediatek/mt8192-asurada-spherion-r0.dts   |  62 ++
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 959 ++++++++++++++++++
 5 files changed, 1083 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi

-- 
2.36.1

