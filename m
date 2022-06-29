Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93E5E55FDE7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiF2KwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbiF2KwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:52:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36F925290;
        Wed, 29 Jun 2022 03:52:17 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5491F6601907;
        Wed, 29 Jun 2022 11:52:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656499936;
        bh=th90aph/IQBD7WzvP1T5xI7Z0J+BoGGihn+p98MgdkM=;
        h=From:To:Cc:Subject:Date:From;
        b=PaC0ppAX3eGZrvvQDeNsnTJlNLZplFQAsXVHj80izyQxTleDC7iToQA1pUvqrGu2b
         ov+NshkMorDHzqC4rKh2/aIjRWzk3vlnh+VJnrJRem+o5LkEHOKww50eutPssles9d
         OlFAtqO+Nv34jJMiPA5nB37Q9Gie5ZnknbuCywpl2dAyoCnN1Av6NDBMfFnIA+G/Yf
         47RPKHzF0A4KA3jR84Odl0cFbMZT/jmYI/bj3NW/V8h4kITHMkb5GLU+7kAalSksU2
         2Eekcjd5PFiEqFXneD4WzSfSyBI97pu02pQzILNHEaabUcSa1qwdNZhCHXz8A2P4Q/
         kCxAiQPits+yg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        chun-jie.chen@mediatek.com, miles.chen@mediatek.com,
        rex-bc.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 0/2] MT8195: Add resets for PCIe controllers
Date:   Wed, 29 Jun 2022 12:52:03 +0200
Message-Id: <20220629105205.173471-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MediaTek PCIe driver supports resets from a reset controller and
they're essential for correct initialization of the PCIe controllers.

As a preparation for adding the PCIe nodes to mt8195, add the resets
to dt-bindings and infra_ao clock driver.

AngeloGioacchino Del Regno (2):
  dt-bindings: reset: mt8195: Add resets for PCIE controllers
  clk: mediatek: mt8195: Add reset idx for PCIe0 and PCIe1

 drivers/clk/mediatek/clk-mt8195-infra_ao.c | 2 ++
 include/dt-bindings/reset/mt8195-resets.h  | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.35.1

