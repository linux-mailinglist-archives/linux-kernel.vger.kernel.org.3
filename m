Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DC6519A15
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346483AbiEDInr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240868AbiEDInp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:43:45 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9911EC5E;
        Wed,  4 May 2022 01:40:10 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id C65FF7EE; Wed,  4 May 2022 10:40:08 +0200 (CEST)
Date:   Wed, 4 May 2022 10:40:07 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        libo.kang@mediatek.com, chengci.xu@mediatek.com
Subject: Re: [PATCH v7 00/36] MT8195 and MT8186 IOMMU SUPPORT
Message-ID: <YnI751zEqTjrVuuz@8bytes.org>
References: <20220503071427.2285-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503071427.2285-1-yong.wu@mediatek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 03, 2022 at 03:13:51PM +0800, Yong Wu wrote:
> Yong Wu (36):
>   dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
>   dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
>   dt-bindings: mediatek: mt8186: Add binding for MM iommu
>   iommu/mediatek: Fix 2 HW sharing pgtable issue
>   iommu/mediatek: Add list_del in mtk_iommu_remove
>   iommu/mediatek: Remove clk_disable in mtk_iommu_remove
>   iommu/mediatek: Add mutex for m4u_group and m4u_dom in data
>   iommu/mediatek: Add mutex for data in the mtk_iommu_domain
>   iommu/mediatek: Adapt sharing and non-sharing pgtable case
>   iommu/mediatek: Add 12G~16G support for multi domains
>   iommu/mediatek: Add a flag DCM_DISABLE
>   iommu/mediatek: Add a flag STD_AXI_MODE
>   iommu/mediatek: Remove the granule in the tlb flush
>   iommu/mediatek: Always enable output PA over 32bits in isr
>   iommu/mediatek: Add SUB_COMMON_3BITS flag
>   iommu/mediatek: Add IOMMU_TYPE flag
>   iommu/mediatek: Contain MM IOMMU flow with the MM TYPE
>   iommu/mediatek: Adjust device link when it is sub-common
>   iommu/mediatek: Allow IOMMU_DOMAIN_UNMANAGED for PCIe VFIO
>   iommu/mediatek: Add a PM_CLK_AO flag for infra iommu
>   iommu/mediatek: Add infra iommu support
>   iommu/mediatek: Add PCIe support
>   iommu/mediatek: Add mt8195 support
>   iommu/mediatek: Only adjust code about register base
>   iommu/mediatek: Just move code position in hw_init
>   iommu/mediatek: Separate mtk_iommu_data for v1 and v2
>   iommu/mediatek: Remove mtk_iommu.h
>   iommu/mediatek-v1: Just rename mtk_iommu to mtk_iommu_v1
>   iommu/mediatek: Add mtk_iommu_bank_data structure
>   iommu/mediatek: Initialise bank HW for each a bank
>   iommu/mediatek: Change the domid to iova_region_id
>   iommu/mediatek: Get the proper bankid for multi banks
>   iommu/mediatek: Initialise/Remove for multi bank dev
>   iommu/mediatek: Backup/restore regsiters for multi banks
>   iommu/mediatek: mt8195: Enable multi banks for infra iommu
>   iommu/mediatek: Add mt8186 iommu support

Applied, thanks.
