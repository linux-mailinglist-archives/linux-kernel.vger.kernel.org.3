Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604F05A18F8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 20:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233371AbiHYSqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 14:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbiHYSqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 14:46:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB4D6B157
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 11:46:22 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [70.107.189.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C11FC6601EAE;
        Thu, 25 Aug 2022 19:46:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661453180;
        bh=ka9fMNk12qWUmYRvUYmT0kwBU/Dlq4CaIy2p/uhHjm4=;
        h=From:To:Cc:Subject:Date:From;
        b=bmW/hgbWwVdazDtl8iMAUKjAGE/IrmLsObyiHyXQiAcK+GaNvVR3QbDRjxdDBiJCD
         EX/VAKC1hZzfqjCLEosB5/ZzxFRoZ87Lc/71B8ejD/8WWIuQaW3Bq2TRdqcApLsOK9
         bvAS37vJFOvoG+gkuyUzzCmfbEIOxRxBzQW6YjSrzw1chQxG+guGbI70znyqA3yDh0
         DINAKsMqkqwAmLS4pD/gCLgvSr5ZsADin/HME3zhsyNH8fShjJX9F+fY45MRAf1/p/
         RaVwsVHZ3IIfGzJ3bP7rfCJDpvvUOJeMv33h/7/Cnybh4uR6dB4wJmRK1hZnU2TsND
         kVOZMipttieRg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     khilman@baylibre.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, roger.lu@mediatek.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v2 0/2] soc: mediatek: Cleanups for MediaTek SVS driver
Date:   Thu, 25 Aug 2022 14:46:14 -0400
Message-Id: <20220825184616.2118870-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

v1: https://lore.kernel.org/all/20220726141653.177948-1-angelogioacchino.delregno@collabora.com

Changes in v2:
- Rebased to not rely on mt8195 and mt8186 support, as they haven't been
  merged yet

AngeloGioacchino Del Regno (2):
  soc: mediatek: mtk-svs: Commonize t-calibration-data fuse array read
  soc: mediatek: mtk-svs: Use bitfield access macros where possible

 drivers/soc/mediatek/mtk-svs.c | 260 ++++++++++++++++++++-------------
 1 file changed, 160 insertions(+), 100 deletions(-)

-- 
2.37.2

