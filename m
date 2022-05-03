Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B5E518694
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 16:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiECO30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 10:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbiECO3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 10:29:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB43123A;
        Tue,  3 May 2022 07:25:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CFF291F43CF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651587948;
        bh=OSfbrDUrVe70J9K2jP7JIoE1KkV5sv+mCi04aDwkksM=;
        h=From:To:Cc:Subject:Date:From;
        b=XOVaUqse8MFsLKBc1b9/W7RsrbglYlojHUwE8unQIm1yCMbDhY8m3VkGp3Ry6Xzv1
         +4hjBJqGEk5i0KzxcpEnHNpPyfwyExXir6g3RHGHBpfTA+HtnOWFXR24IDIqCfwY9a
         6qWXZTFiVVwQVNhOU5j73DTOdFb7ZoUHA6kGb5VJ0mixPEuEm8cglyjHF3bGRb84xl
         o2vYu/Uevmj0+AlDn3SGgq86mnLx39XsOpbVA00MN5Yk9mbrrx4oPHI0FbsbPUNSPy
         6A8+i9xjevscS//PZqPZNV17T+1kScbtEniM2ilanxpPvJba5+hXVyXl8TL6pjKwzy
         GJI1nfW+eqf5w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     linus.walleij@linaro.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sean.wang@kernel.org,
        angelogioacchino.delregno@collabora.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, nfraprado@collabora.com
Subject: [PATCH v2 0/2] MediaTek Helio X10 MT6795 - Pinctrl driver
Date:   Tue,  3 May 2022 16:25:35 +0200
Message-Id: <20220503142537.152499-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
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

In an effort to give some love to the apparently forgotten MT6795 SoC,
I am upstreaming more components that are necessary to support platforms
powered by this one apart from a simple boot to serial console.

This series introduces a pinctrl driver for the Helio X10 SoC.

Tested on a Sony Xperia M5 (codename "Holly") smartphone.

Changes in v2:
 - Reordered commits, dt-bindings first, driver last
 - Fixed yaml issues

AngeloGioacchino Del Regno (2):
  dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl bindings
  pinctrl: mediatek: Add pinctrl driver for MT6795 Helio X10

 .../pinctrl/mediatek,pinctrl-mt6795.yaml      |  224 +++
 drivers/pinctrl/mediatek/Kconfig              |    7 +
 drivers/pinctrl/mediatek/Makefile             |    1 +
 drivers/pinctrl/mediatek/pinctrl-mt6795.c     |  623 ++++++
 drivers/pinctrl/mediatek/pinctrl-mtk-mt6795.h | 1698 +++++++++++++++++
 include/dt-bindings/pinctrl/mt6795-pinfunc.h  |  908 +++++++++
 6 files changed, 3461 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6795.c
 create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6795.h
 create mode 100644 include/dt-bindings/pinctrl/mt6795-pinfunc.h

-- 
2.35.1

