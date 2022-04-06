Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DAD4F5F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiDFNVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiDFNVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:21:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E235562D6E7;
        Wed,  6 Apr 2022 03:04:46 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id ADE991F438D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649239454;
        bh=g7srURYZOuoeOiWj2FQ3simmvNJ0zom1MOjMcEDysv8=;
        h=From:To:Cc:Subject:Date:From;
        b=nmf9pj3vLhpmo8SD1pnvbqWTLGdw5/y11iJWV+6hwEAL0cONjbn5jeXbNXS37Uwvh
         yLopOhZPHyVJ0dq5KWV9/clgqKc/SoH7xzIPrh6qm7rZ0eGeeXlaksw4mF/NjXnJQB
         uGgaILIqE0mKJ88Ts4MoivOPf9dnGwYWJPLelPo82t8R0mzDPi+LYHqakrKh90r+Ev
         Ca1fATeRBEKKSrBPmDh8w1aCpz3KR12xijS5Li2pKbqJSWTwV9zq9TQ/M1RfMmrG0T
         tpIMntMjy3h87FwIikMEz5HKA7XRfWWBEs7A7gV/GKTh9OQhxAQZZ/WSHLtajCqUzT
         YppmirKxGZj4g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/7] MediaTek SPI controller cleanups and documentation
Date:   Wed,  6 Apr 2022 12:04:02 +0200
Message-Id: <20220406100409.93113-1-angelogioacchino.delregno@collabora.com>
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

This series performs some cleanups to the spi-mt65xx driver, removing
all gotos, simplifying the probe function and adding kerneldoc to the
driver structures.

AngeloGioacchino Del Regno (7):
  spi: mt65xx: Simplify probe function with devm_spi_alloc_master
  spi: mt65xx: Switch to device_get_match_data()
  spi: mt65xx: Add and use pointer to struct device in mtk_spi_probe()
  spi: mt65xx: Move pm_runtime_enable() call to remove all gotos
  spi: mt65xx: Simplify probe function with dev_err_probe()
  spi: mt65xx: Add kerneldoc for driver structures
  spi: mt65xx: Fix definitions indentation

 drivers/spi/spi-mt65xx.c | 315 ++++++++++++++++++---------------------
 1 file changed, 145 insertions(+), 170 deletions(-)

-- 
2.35.1

