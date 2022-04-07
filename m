Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97784F7E38
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 13:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244879AbiDGLqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 07:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238372AbiDGLqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 07:46:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEC417A5BC;
        Thu,  7 Apr 2022 04:44:36 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4637D1F4580C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649331873;
        bh=3xNDbtKo/QwtU2kZMPDobaM+xLfIkUASVQWxYMAggfM=;
        h=From:To:Cc:Subject:Date:From;
        b=c67OREi0ihF2CjgVqwyotdZpUpPe20ZzIqQsIyoxbQ8qLtO+JfUTzTX4ExhioHjo+
         VgxYPuYwyMH+csxqHP98+dzexkx0H1f2w4DkPnQc4ci+W27bfS/AmHQymnHXE4FfE5
         nzhCMRyt0BC7YofwSYQNwU2ejzFP3zJ/3CTeokQTP6DhKug3pkJ+D+nNbSvVZa7u4g
         DOVyR33WP5Tkt45CYl2cXSAqe/6lf4pcJwrGqO7rtn8yGEidb8z67xBhGeP35OKMSY
         tPcLrdSQ+tcmMARLykKLJwT8oFzDPS2F456ucfq6xPvmT7uAdkMz+90pThPKe+PcDy
         h2mSbc1SNg89g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     broonie@kernel.org
Cc:     matthias.bgg@gmail.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        nfraprado@collabora.com, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 0/8] MediaTek SPI controller cleanups and documentation
Date:   Thu,  7 Apr 2022 13:44:20 +0200
Message-Id: <20220407114428.167091-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series performs some cleanups to the spi-mt65xx driver, removing
all gotos, simplifying the probe function and adding kerneldoc to the
driver structures.

Changes in v2:
- Rebased over next-20220407 for new spimem commits

AngeloGioacchino Del Regno (8):
  spi: mt65xx: Simplify probe function with devm_spi_alloc_master
  spi: mt65xx: Switch to device_get_match_data()
  spi: mt65xx: Add and use pointer to struct device in mtk_spi_probe()
  spi: mt65xx: Move clock parent setting to remove clock disable gotos
  spi: mt65xx: Move pm_runtime_enable() call to remove all gotos
  spi: mt65xx: Simplify probe function with dev_err_probe()
  spi: mt65xx: Add kerneldoc for driver structures
  spi: mt65xx: Fix definitions indentation

 drivers/spi/spi-mt65xx.c | 368 ++++++++++++++++++---------------------
 1 file changed, 171 insertions(+), 197 deletions(-)

-- 
2.35.1

