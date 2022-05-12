Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450155256A4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 22:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358456AbiELU4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 16:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbiELU4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 16:56:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2A134654;
        Thu, 12 May 2022 13:56:11 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 095511F45852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652388969;
        bh=+JM0/TCf78vIqvtOSPnO3S1iKSaG2U2+9jsn/lDu4kw=;
        h=From:To:Cc:Subject:Date:From;
        b=GqrILkk/bVyNI8JTeM4JvtRAjemlf5A/6kQmhRbhYouIrcGU8IEmNn+BYi4ocdt2k
         rjfhaTjCBOw/o/UOz0W2dEKf9rCU1uYn1ZVQHYUqkMUXYLFNtPYEmYyn+r7ymXbFCS
         +aLnKZ0NM2Zunla45Rnirea30glurSyiaBIZyEQZ5+uOzuh3uHawPWGknbrRpQjyG9
         8HUCTsdeo4HKaIIVUUJjhfttunHm9JpAEoHuG4o8dDZGGi4DlNst4gxUrA/oDdgKDB
         WD77XaFmDLh4z3nYOW4AMwDlx9BOq/IyzO4rlqyFdVvkZK2HIe3mPR26PEuGomgGWO
         qatQASe3j3eCQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxim Kutnij <gtk3@inbox.ru>, Rob Herring <robh+dt@kernel.org>,
        Sam Shih <sam.shih@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 00/16] Introduce support for MediaTek MT8192 Google Chromebooks
Date:   Thu, 12 May 2022 16:55:46 -0400
Message-Id: <20220512205602.158273-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
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

This series was peer-reviewed internally before submission.

v2: https://lore.kernel.org/all/20220505194550.3094656-1-nfraprado@collabora.com/
v1: https://lore.kernel.org/all/20220316151327.564214-1-nfraprado@collabora.com/

Changes in v3:
- Renamed regulator nodes to be generic
- Fixed keyboard layout for Hayato

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
 .../dts/mediatek/mt8192-asurada-hayato-r1.dts |  47 ++
 .../mediatek/mt8192-asurada-spherion-r0.dts   |  62 ++
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 748 ++++++++++++++++++
 5 files changed, 872 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi

-- 
2.36.1

