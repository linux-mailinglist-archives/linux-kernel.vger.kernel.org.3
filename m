Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A91F54997D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 19:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234469AbiFMREq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 13:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245154AbiFMRDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 13:03:41 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C052C6E5A
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:04:03 -0700 (PDT)
X-UUID: 7463ad46ea3f4f5ea78982a347fa1f4f-20220613
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:049ffec7-9613-4c0e-89a5-e7576225fc14,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:10,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:15
X-CID-META: VersionHash:b14ad71,CLOUDID:0fa58c37-84c0-4f9a-9fbd-acd4a0e9ad0f,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:3,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 7463ad46ea3f4f5ea78982a347fa1f4f-20220613
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yong.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 87006132; Mon, 13 Jun 2022 20:03:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 13 Jun 2022 20:03:56 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 13 Jun 2022 20:03:55 +0800
Message-ID: <e15deedee3a412e8496be1867725f7e62e396551.camel@mediatek.com>
Subject: Re: [PATCH v8 2/3] iommu/mediatek: Rename MTK_IOMMU_TLB_ADDR to
 MTK_IOMMU_ADDR
From:   Yong Wu <yong.wu@mediatek.com>
To:     <yf.wang@mediatek.com>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "open list:MEDIATEK IOMMU DRIVER" <iommu@lists.linux-foundation.org>,
        "moderated list:MEDIATEK IOMMU DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, Libo Kang <Libo.Kang@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ning Li <ning.li@mediatek.com>
Date:   Mon, 13 Jun 2022 20:03:55 +0800
In-Reply-To: <20220611102656.10954-3-yf.wang@mediatek.com>
References: <20220611102656.10954-1-yf.wang@mediatek.com>
         <20220611102656.10954-3-yf.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-06-11 at 18:26 +0800, yf.wang@mediatek.com wrote:
> From: Yunfei Wang <yf.wang@mediatek.com>
> 
> Rename MTK_IOMMU_TLB_ADDR to MTK_IOMMU_ADDR, and update
> MTK_IOMMU_ADDR
> definition for better generality.

Comment more about why you need this.

Prepare for supporting TTBR up to 35bit which also need this macro.
Currently it is dma_addr_t while ttbr is phys_addr_t, thus change the
type to "unsigned long long" for generality.

Anyway,

Reviewed-by: Yong Wu <yong.wu@mediatek.com>

> 
> Signed-off-by: Ning Li <ning.li@mediatek.com>
> Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> ---
>  drivers/iommu/mtk_iommu.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index bb9dd92c9898..3d62399e8865 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -265,8 +265,8 @@ static const struct iommu_ops mtk_iommu_ops;
>  
>  static int mtk_iommu_hw_init(const struct mtk_iommu_data *data,
> unsigned int bankid);
>  
> -#define MTK_IOMMU_TLB_ADDR(iova) ({					
> \
> -	dma_addr_t _addr = iova;					\
> +#define MTK_IOMMU_ADDR(addr) ({					
> 	\
> +	unsigned long long _addr = addr;				\
>  	((lower_32_bits(_addr) & GENMASK(31, 12)) |
> upper_32_bits(_addr));\
>  })
>  
> @@ -381,8 +381,8 @@ static void
> mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
>  		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
>  			       base + data->plat_data->inv_sel_reg);
>  
> -		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova), base +
> REG_MMU_INVLD_START_A);
> -		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova + size - 1),
> +		writel_relaxed(MTK_IOMMU_ADDR(iova), base +
> REG_MMU_INVLD_START_A);
> +		writel_relaxed(MTK_IOMMU_ADDR(iova + size - 1),
>  			       base + REG_MMU_INVLD_END_A);
>  		writel_relaxed(F_MMU_INV_RANGE, base +
> REG_MMU_INVALIDATE);
>  

