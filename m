Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334BC4DB493
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357200AbiCPPPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357111AbiCPPOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:14:49 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB143BFAF;
        Wed, 16 Mar 2022 08:13:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id C951E1F44661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647443611;
        bh=jPM6xKtCPNZJwJ/DiHYFLek7T8L3dpESMA/tat5KKvc=;
        h=From:To:Cc:Subject:Date:From;
        b=fzKMEmzbsWa8oaNnpTpFzMhWn1w0yS505IAwyj3uMiAucpQlzFipEI8daQjZYn3or
         wy1i84wcSd4uK5QxICDrmNEkGdL/2VloPeinACJErIYwZEW5hML/KbqS5TeY4F0ta/
         2H4U0GC/6eX6m6ZF0nRBf3ZJkAuO8ye3MDhzWNWxu0dbhHw/7cHeS2+1qxRlT8PLwP
         QiOYBSOpDbQzpLV7lTR9rzraJLdJ6xUMBEqNZ2ha+njs+UbszGDLX0oGZKQwHM1/iJ
         7ktHaHQC01DmuFJCAxMVHXNgkdcK77XfnARW4pr+u6HRXaMVLGFRbAnkYYyDMHQE5J
         fvgbHVoPh94xg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1 00/10] Introduce support for MediaTek MT8192 Google Chromebooks
Date:   Wed, 16 Mar 2022 11:13:17 -0400
Message-Id: <20220316151327.564214-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
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

After the series adding various missing nodes on MT8192 [1] is merged, a
new series will be sent enabling the remaining devices on the Asurada
platform.

While the dts files added in this series introduce a couple new
dtbs_check warnings, they are fixed by another series [2].

This series was peer-reviewed internally before submission.

[1] https://lore.kernel.org/linux-mediatek/20220304130809.12924-1-allen-kh.cheng@mediatek.com/
[2] https://lore.kernel.org/linux-mediatek/20220315211936.442708-1-nfraprado@collabora.com/


Nícolas F. R. A. Prado (10):
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

 arch/arm64/boot/dts/mediatek/Makefile         |   2 +
 .../dts/mediatek/mt8192-asurada-hayato-r1.dts |  18 +
 .../mediatek/mt8192-asurada-spherion-r0.dts   |  33 +
 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 616 ++++++++++++++++++
 4 files changed, 669 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-hayato-r1.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada-spherion-r0.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi

-- 
2.35.1

