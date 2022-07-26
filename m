Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D303F5814F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiGZORn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238296AbiGZORj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:17:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A092250A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 07:17:34 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E84216601B1A;
        Tue, 26 Jul 2022 15:17:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658845053;
        bh=0aFS34Xh0Sull4UkSdhR2eAZVT3nTjndEQc593bt6E4=;
        h=From:To:Cc:Subject:Date:From;
        b=cryEsxWEoVTVN9IOYvY7zhZrBYLIDkLH1Q3Xl4ekNdkcZp5IJGejThwJFO37JgS9H
         exqCoMS9rkHg0WHmt73jz3w1kqAwZaACbbYd1vewwkno6P0FvfaTQErYCEgF7tO8Ow
         7F6JalwWVSs0pF5IaaJ6sEQK2195fdu5nzhMB8CvqjXPzn0MPkSXnHKwD/Ob6PE7yB
         bJWh6XyJk1zgFCbn5rTfLOVSbGE4yhhis3yZtjY8LKxHyVZTeYxZr73iTkQpY6U1xC
         tnbzOIXbRnCqluzOAFyS5YfyXQkUx+FwG6rfHnW52TTBiBs4MoYRheyGftbuPmG4WV
         pRbQZeNIhOM2Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     roger.lu@mediatek.com, khilman@baylibre.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/6] soc: mediatek: Cleanups for MediaTek SVS driver
Date:   Tue, 26 Jul 2022 16:16:47 +0200
Message-Id: <20220726141653.177948-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cleanup-only series for the mtk-svs driver, enhancing the
usage of standard Linux macros for bitfields for better readability
and register set/get safety, switches to devm_ functions variants
where possible and other general cleanups, getting this driver in a
better overall shape.

AngeloGioacchino Del Regno (6):
  soc: mediatek: mtk-svs: Commonize t-calibration-data fuse array read
  soc: mediatek: mtk-svs: Switch to platform_get_irq()
  soc: mediatek: mtk-svs: Remove hardcoded irqflags
  soc: mediatek: mtk-svs: Drop of_match_ptr() for of_match_table
  soc: mediatek: mtk-svs: Use devm variant for dev_pm_opp_of_add_table()
  soc: mediatek: mtk-svs: Use bitfield access macros where possible

 drivers/soc/mediatek/mtk-svs.c | 325 ++++++++++++++++++---------------
 1 file changed, 176 insertions(+), 149 deletions(-)

-- 
2.35.1

