Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93F1851F9CE
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiEIKZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiEIKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:25:13 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025991F8F37;
        Mon,  9 May 2022 03:21:10 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id BBB721F43752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652091668;
        bh=kFY6xdvfRk2XofodD/pcIzhqwLnHWFBwbwW4/mpaiGk=;
        h=From:To:Cc:Subject:Date:From;
        b=lCQetSKw8oY2VFDLVOJDfP0OQrIwkQXWFqrQ58A1/O1es7qBNOttUR2OO2BMPkXAO
         c97xn4YW7SwxEf3ydcgUynbM26lydrJk6kJ5bE696XBO3SxD2Tc4C1fitRD6AHichg
         1wBeQmoQUb8SYPJlsOneogQpDjNxw5kjIHwxf3bZEjVX7DcCQFEwDGBvWOGVdqK4L6
         i+XNIsE5/pGvIzA/bNm1XrBOw6NseY7cOD4IUUVkAOauAIDWTtqGfxioHFK91fD6Br
         lhBzsFkxvT/dkbOx2BTPFS3M65xwfb0uq4BdWIS1w3HtEeJ4m+2hoC0dBBVTDl87DX
         jnu3WzBUcHJ0g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     daniel.lezcano@linaro.org
Cc:     tglx@linutronix.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, konrad.dybcio@somainline.org,
        marijn.suijten@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] MediaTek SoC ARM/ARM64 System Timer
Date:   Mon,  9 May 2022 12:20:56 +0200
Message-Id: <20220509102058.3064215-1-angelogioacchino.delregno@collabora.com>
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

This series introduces support to start the System Timer for the CPU
cores found in various MediaTek SoCs including, but not limited to the
MT6795 Helio X10 - and will most probably unblock many developers for
the upstreaming of various platforms.

For a broad overview of why/what/when, please look at the description
of patch [2/2] in this series.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

AngeloGioacchino Del Regno (2):
  dt-bindings: timer: mediatek: Add CPUX System Timer and MT6795
    compatible
  clocksource/drivers/timer-mediatek: Implement CPUXGPT timers

 .../bindings/timer/mediatek,mtk-timer.txt     |   4 +
 drivers/clocksource/timer-mediatek.c          | 118 ++++++++++++++++++
 2 files changed, 122 insertions(+)

-- 
2.35.1

