Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40BB4C6C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiB1MfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiB1MfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:35:00 -0500
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3345F40902;
        Mon, 28 Feb 2022 04:34:20 -0800 (PST)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 56FDE4B0; Mon, 28 Feb 2022 13:34:19 +0100 (CET)
Date:   Mon, 28 Feb 2022 13:34:18 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
Subject: Re: [PATCH v5 00/34] MT8195 IOMMU SUPPORT
Message-ID: <YhzBSsn/zUlGg5JE@8bytes.org>
References: <20220217113453.13658-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217113453.13658-1-yong.wu@mediatek.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong Wu,

On Thu, Feb 17, 2022 at 07:34:19PM +0800, Yong Wu wrote:
> Yong Wu (34):
>   dt-bindings: mediatek: mt8195: Add binding for MM IOMMU
>   dt-bindings: mediatek: mt8195: Add binding for infra IOMMU
>   iommu/mediatek: Fix 2 HW sharing pgtable issue
>   iommu/mediatek: Add list_del in mtk_iommu_remove
>   iommu/mediatek: Remove clk_disable in mtk_iommu_remove
>   iommu/mediatek: Add mutex for m4u_group and m4u_dom in data
>   iommu/mediatek: Add mutex for data in the mtk_iommu_domain
>   iommu/mediatek: Adapt sharing and non-sharing pgtable case
>   iommu/mediatek: Add 12G~16G support for multi domains
>   iommu/mediatek: Add a flag DCM_DISABLE
>   iommu/mediatek: Add a flag NON_STD_AXI
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

This doesn't apply cleanly, can you please send a version rebased to
v5.17-rc4?

Thanks,

	Joerg
