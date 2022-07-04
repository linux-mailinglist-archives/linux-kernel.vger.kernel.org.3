Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1174E5651DE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 12:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiGDKNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 06:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiGDKNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 06:13:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27174CE2A;
        Mon,  4 Jul 2022 03:13:30 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 66AEF66017F7;
        Mon,  4 Jul 2022 11:13:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656929608;
        bh=HW6iJNpEd9bIAvKSJ5WiS1laYwYlZBUsBTzloi+AeCk=;
        h=From:To:Cc:Subject:Date:From;
        b=JeUh14jJtuzk8vMhxL1qPUCQRSyDEDuAfYWWNJ+JUfEkPwhGujQa6ZEcOAgcmChMj
         sF/C3VFNwUmUI5wmpZavlmNrGauWmsC7nZVRwKEPPdK7AGJumqoCGB/z3CEEwk5Yhb
         UOBWNVyOQ2OvwVp22PCTU7rI81cKoce64f42G/soZGHskID9S41YODFYn0KEoRSlMa
         1IXzRAatF/XTub8UITdEpQyQvx8nlTy+WPA/dRX1gmzyvM3Gn6Z7HY7FB5fSJimadm
         zNLRytmjOeRuzmmPWhGPB/bbNy0LomnX0q7AzLBfG2hUsfiU86Rf1mGJ4+wIwz1lfH
         lHsxaw5IGIG4g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        gtk3@inbox.ru, luca@z3ntu.xyz, sam.shih@mediatek.com,
        sean.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: [PATCH v2 00/11] MT8195 Chromebooks devicetrees - Google Tomato
Date:   Mon,  4 Jul 2022 12:13:10 +0200
Message-Id: <20220704101321.44835-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
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

This is the first part for upstreaming Google's Cherry Tomato
Chromebook (Acer Chromebook Spin 513): in this series, we introduce
the devicetrees for the four revisions of this Chromebook and enable
every controller and feature that can be added as per the current
state of the main SoC devicetrees (mt8195.dtsi) and its PMIC
devicetree (mt6359.dtsi).

More parts will come as soon as more support will be added by
MediaTek in the mt8195 devicetree.

Note: This series will introduce a dtbs_check warning about a failure
      to match compatible for 'mediatek,mt6359': that's expected, as
      this is defined in devicetree/bindings/mfd/mt6397.txt (so there
      is no schema, yet).

Changes in v2:
 - Added changes from Nìcolas' review
 - Changed board 'model' from 'MediaTek Tomato' to 'Acer Tomato'

This series depends on the following fixes:
[1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220630110453.186526-1-angelogioacchino.delregno@collabora.com/
[2]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220630122334.216903-1-angelogioacchino.delregno@collabora.com/
[3]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220630131543.225554-1-angelogioacchino.delregno@collabora.com/


And it depends on Nìcolas' dt-bindings patch for the [01/11] to
apply cleanly (this is done to keep mediatek.yaml ordered):
[4]: https://lore.kernel.org/all/20220629155956.1138955-2-nfraprado@collabora.com/


AngeloGioacchino Del Regno (11):
  dt-bindings: arm: mediatek: Add MT8195 Cherry Tomato Chromebooks
  arm64: dts: mediatek: Introduce MT8195 Cherry platform's Tomato
  arm64: dts: mediatek: cherry: Add platform regulators layout and
    config
  arm64: dts: mediatek: cherry: Assign interrupt line to MT6359 PMIC
  arm64: dts: mediatek: cherry: Add support for internal eMMC storage
  arm64: dts: mediatek: cherry: Document gpios and add default pin
    config
  arm64: dts: mediatek: cherry: Enable I2C and SPI controllers
  arm64: dts: mediatek: cherry: Enable T-PHYs and USB XHCI controllers
  arm64: dts: mediatek: cherry: Enable MT6360 sub-pmic on I2C7
  arm64: dts: mediatek: cherry: Enable support for the SPI NOR flash
  arm64: dts: mediatek: cherry: Add I2C-HID touchscreen on I2C4

 .../devicetree/bindings/arm/mediatek.yaml     |  13 +
 arch/arm64/boot/dts/mediatek/Makefile         |   3 +
 .../dts/mediatek/mt8195-cherry-tomato-r1.dts  |  15 +
 .../dts/mediatek/mt8195-cherry-tomato-r2.dts  |  35 +
 .../dts/mediatek/mt8195-cherry-tomato-r3.dts  |  36 +
 .../boot/dts/mediatek/mt8195-cherry.dtsi      | 702 ++++++++++++++++++
 6 files changed, 804 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi

-- 
2.35.1

