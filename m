Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475BC5265BF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381750AbiEMPOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381091AbiEMPOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:14:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468D153A60;
        Fri, 13 May 2022 08:14:18 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 2336E1F461FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652454857;
        bh=eNQrmpvsqIQtwYolKiTtDiOp4ht3MwzuuikVm7BUBRA=;
        h=From:To:Cc:Subject:Date:From;
        b=ifTxDALRDsOUg2NBN8H0yqa1BCJr6hM2JSyW9QsFSEqpoBmIkPhzspDTJU52fDmwR
         aI0mPk84dcw4QaxXrYH5comEdHVP+s88W1MXFxjXAUwyb1SP/4OgAfXokT3MGNQJ30
         tin8aNAxuh8Bpi3SGqgNiRoFw0Ys1PYZzxVP6hABWEdFXypIAQYxBdaEoQ6d/1vWsW
         klt7wOLZb8KxcPhBdER+a7IJsYbPOdiyEzE7PysS4HvhFaeyKuUS/nrOAen1GlNzcf
         Jtcc5h+6oFeYhINPkhZyIdOvtGDqbjHHFHAW9vLH7mCeZuXWGKmeK4Q+2k0OG2CBj1
         NM6/52G3zNsGQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     yong.wu@mediatek.com
Cc:     joro@8bytes.org, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, paul.bouchara@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] MediaTek Helio X10 MT6795 - M4U/IOMMU Support
Date:   Fri, 13 May 2022 17:14:09 +0200
Message-Id: <20220513151411.395744-1-angelogioacchino.delregno@collabora.com>
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

This series introduces support for the IOMMUs found on this SoC.

Tested on a MT6795 Sony Xperia M5 (codename "Holly") smartphone.

AngeloGioacchino Del Regno (2):
  dt-bindings: mediatek: Add bindings for MT6795 M4U
  iommu: mtk_iommu: Add support for MT6795 Helio X10 M4Us

 .../bindings/iommu/mediatek,iommu.yaml        |  3 +
 drivers/iommu/mtk_iommu.c                     | 20 +++-
 include/dt-bindings/memory/mt6795-larb-port.h | 96 +++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/memory/mt6795-larb-port.h

-- 
2.35.1

