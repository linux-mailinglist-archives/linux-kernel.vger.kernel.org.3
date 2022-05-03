Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACC5F51829F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbiECK5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiECK5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:57:01 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77433153E;
        Tue,  3 May 2022 03:53:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 95CFB1F43E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651575205;
        bh=DmdsdXPUSOFXBQpmitusBnyiDtXQO80VoTWdNn6WKfA=;
        h=From:To:Cc:Subject:Date:From;
        b=HAkZtg1GPWzlwHe/TTfYeEZrf676FMHRcizYzPv9pXT1MeFSspEVUpbTdYo1nNMD+
         p3kiYBvxhKAWIp0xTYG5CyBQ+ydIoF0ae6Y60/Mf7gUMtd/L6xUfMUBCUCjPgbkRxK
         E6t1V8at431FO4garL+MTXx0C854ejQEsSWNtNe2QS6r+WGofB7Ex8W7si+iZDuiuq
         ci+P1JkKNy5VFCOpr4eirqeXegDm+bamEBSt4xzyZ3hYIK8BhDixrjWD2LNEr7c10J
         Zq/mysq7LpeBJynVIgV0gCsxlGCX7qIAT3atF79LOYR4zI13Z2y++/Og8nVQpdN6JH
         L5iD5s3bzgqSw==
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
Subject: [PATCH 0/2] MediaTek Helio X10 MT6795 - Pinctrl driver
Date:   Tue,  3 May 2022 12:53:15 +0200
Message-Id: <20220503105317.54696-1-angelogioacchino.delregno@collabora.com>
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

AngeloGioacchino Del Regno (2):
  pinctrl: mediatek: Add pinctrl driver for MT6795 Helio X10
  dt-bindings: pinctrl: Add MediaTek MT6795 pinctrl bindings

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

