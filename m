Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE64E513851
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 17:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349149AbiD1Pa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 11:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349147AbiD1Pay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 11:30:54 -0400
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C0B36B8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 08:27:34 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CBFB6374; Thu, 28 Apr 2022 17:27:32 +0200 (CEST)
Date:   Thu, 28 Apr 2022 17:27:31 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com
Subject: Re: [PATCH v3 0/2] MT8186 IOMMU SUPPORT
Message-ID: <YmqyY7V5p2i2h6ZN@8bytes.org>
References: <20220407083230.18041-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407083230.18041-1-yong.wu@mediatek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:32:28PM +0800, Yong Wu wrote:
> Yong Wu (2):
>   dt-bindings: mediatek: mt8186: Add binding for MM iommu
>   iommu/mediatek: Add mt8186 iommu support
> 
>  .../bindings/iommu/mediatek,iommu.yaml        |   4 +
>  drivers/iommu/mtk_iommu.c                     |  17 ++
>  .../dt-bindings/memory/mt8186-memory-port.h   | 217 ++++++++++++++++++
>  3 files changed, 238 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt8186-memory-port.h

This patch-set seems to apply cleanly only on 'MT8195 IOMMU SUPPORT',
please re-submit it together with the former when you made the changes
Matthias requested.

Thanks,

	Joerg
