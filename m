Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E01D51C97A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 21:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385280AbiEETtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 15:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383150AbiEETto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 15:49:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052B95D645;
        Thu,  5 May 2022 12:46:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 35F1B1F45CBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651779960;
        bh=RGCX7f1c3IvRqOzT0kQrLTGaV5rzWYFn7wa3F2g/3sc=;
        h=From:To:Cc:Subject:Date:From;
        b=BXy3pO2lbGRDAQvI5Sqc06/aVbQjRQAa+9OJG3jTImF2Pkx1vJdy6g8je5lhrAJ44
         ZTfO2haJHSE1EIl6OgDagBuOOZd5pbaNkbLQO0pWBu3ma9rQVSqRG7s/OCOpK4AF7f
         bG+2iJpQMt4I+pdTBf/dryqWzsxGfAWrGulm/I++Kczj1divEdS/4eQKcZlfxZs1fm
         KIZLrg7EScTR452qblEK9qL4EXT1rFjN65ekXO2EniYPBdtTMcQdNJk6hpIA1003DG
         6/s2b2Ftt/m888IGvwWOQ6A1l6YU2tx82ilpar4j9DAolh1i9+ywWO3J6sY59ikA5b
         t9r9012cLKAHA==
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
Subject: [PATCH v2 00/16] Introduce support for MediaTek MT8192 Google Chromebooks
Date:   Thu,  5 May 2022 15:45:34 -0400
Message-Id: <20220505194550.3094656-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series introduces Devicetrees for the MT8192-based Asurada platform
as well as Asurada Spherion and Asurada Hayato boards.

Support for the boards is added to the extent that is currently enabled
in the mt8192.dtsi, as to not add any dependencies to this series.

Besides the other dt-binding fixes already on linux-next to avoid new
warnings by this series, [1] is already merged but not on next yet.

This series was peer-reviewed internally before submission.

[1] https://lore.kernel.org/all/20220429201325.2205799-1-nfraprado@collabora.com/

v1: https://lore.kernel.org/all/20220316151327.564214-1-nfraprado@collabora.com/

Changes in v2:
- Added patches 1-2 for Mediatek board dt-bindings
- Added patches 13-16 enabling hardware for Asurada that has since been
  enabled on mt8192.dtsi

Nícolas F. R. A. Prado (16):
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

 .../devicetree/bindings/arm/mediatek.yaml     |  13 +
 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../dts/mediatek/mt8192-asurada-hayato-r1.dts |  18 +
 .../mediatek/mt8192-asurada-spherion-r0.dts   |  33 +
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 777 ++++++++++++++++++
 5 files changed, 843 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi

-- 
2.36.0

