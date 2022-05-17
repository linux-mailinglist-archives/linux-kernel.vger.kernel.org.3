Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7FE529CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243519AbiEQIkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238508AbiEQIkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:40:05 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3D73E0DE;
        Tue, 17 May 2022 01:40:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 14AC71F442B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652776802;
        bh=ejXGkWEU9/h8Gq6inz9Xqi8NHp2mWLXGwzZX33ZE2hk=;
        h=From:To:Cc:Subject:Date:From;
        b=M7+lCY12v+Sz9bXV5nqYxR3B4j9JgL50K17F45jPhYbkgWyrJsYxhxxz2jwfRxQbf
         YbeaCq8YQzHeEvaZ3wfQ2KT+OhftqhbdGoCzMhZETL2K9sjQbTkwboRcZY7cHJ7mG/
         Qj9USxiVhvmPjUVeFSu/BIud9YeHh6cbHwuuUTM7QrpGjyToQHKQ491tIRznfQGVe5
         2VeEYar8c8mab0T+UCJXNR6U8vPXN0eQrYkOuZOMGYY05pzhpjT4rKg0/jUuhtkJll
         bd392YPj3HLcUddBjUjl9+DR+88gpaAUZZOhoBPxoz+Mln7sbeOFqO2Uv572MMfho3
         BeHOYnm0URvsA==
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
Subject: [PATCH v4 0/2] MediaTek Helio X10 MT6795 - Pinctrl driver
Date:   Tue, 17 May 2022 10:39:55 +0200
Message-Id: <20220517083957.11816-1-angelogioacchino.delregno@collabora.com>
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

Changes in v4:
 - Changed license of mt6795-pinfunc.h to (GPL-2.0-only OR BSD-2-Clause)

Changes in v3:
 - Fixed $id in yaml file

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

