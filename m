Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B13C5182BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiECK7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbiECK6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:58:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D3A38DAD;
        Tue,  3 May 2022 03:54:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id B0EA41F43E1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651575282;
        bh=KImMtRiNvhnzKT2AFtwuL9K10f7DNftq+ja2O1mLSvs=;
        h=From:To:Cc:Subject:Date:From;
        b=ZEKMHHWSnyZlmj76oYNWJrFljSUXNFbHoFW6KKTLEMu/2ezN0Vq+G8juH2PM8Gtzg
         lkO25sGHy2uiGH9vG71MHm3nOettSPu9DW8ldOW2lJyw8acrCWzZbufdVNy835YejP
         HLmt+OIVh5lnCxd09efEhgcA/V/Oe31AJlAd4WZ+4ktZERwwJQxeXIxi14BPmq5Mmb
         bhMK1GidM+nItlJk2gEAfQLziz+o/MQw27lEEi3unZqqgHvc0kntZBdKHVaR300Gq4
         2Q/ZXOTCBwDQBQ+YM5+dmXD9UXQDZ2vpPrZfCWFvpgCFA2N/Btl2gnr+yuhQLpnCVw
         nTXSGzBwddMoA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        chun-jie.chen@mediatek.com,
        angelogioacchino.delregno@collabora.com, weiyi.lu@mediatek.com,
        mbrugger@suse.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        nfraprado@collabora.com
Subject: [PATCH 0/2] MediaTek Helio X10 MT6795 - power domains
Date:   Tue,  3 May 2022 12:54:34 +0200
Message-Id: <20220503105436.54901-1-angelogioacchino.delregno@collabora.com>
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

This series introduces support for the MTCMOS power domains found on
the Helio X10.

Tested on a Sony Xperia M5 (codename "Holly") smartphone.

AngeloGioacchino Del Regno (2):
  dt-bindings: power: Add MediaTek Helio X10 MT6795 power domains
  soc: mediatek: pm-domains: Add support for Helio X10 MT6795

 .../power/mediatek,power-controller.yaml      |   2 +
 drivers/soc/mediatek/mt6795-pm-domains.h      | 112 ++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c         |   5 +
 include/dt-bindings/power/mt6795-power.h      |  16 +++
 4 files changed, 135 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt6795-pm-domains.h
 create mode 100644 include/dt-bindings/power/mt6795-power.h

-- 
2.35.1

