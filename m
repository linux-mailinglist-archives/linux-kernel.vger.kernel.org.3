Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8FC454DAF6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 08:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358992AbiFPGr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 02:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiFPGrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 02:47:25 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA45AEC0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 23:47:20 -0700 (PDT)
X-UUID: 72cfa3363cb6482f891f5acbba363967-20220616
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:f54830ad-cf65-4c36-b30c-35111088470e,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:5
X-CID-META: VersionHash:b14ad71,CLOUDID:378ab548-4c92-421c-ad91-b806c0f58b2a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: 72cfa3363cb6482f891f5acbba363967-20220616
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <yf.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 262145049; Thu, 16 Jun 2022 14:47:14 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 16 Jun 2022 14:47:13 +0800
Received: from mbjsdccf07.mediatek.inc (10.15.20.246) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 16 Jun 2022 14:47:13 +0800
From:   <yf.wang@mediatek.com>
To:     <robin.murphy@arm.com>
CC:     <Libo.Kang@mediatek.com>, <iommu@lists.linux-foundation.org>,
        <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <ning.li@mediatek.com>,
        <will@kernel.org>, <wsd_upstream@mediatek.com>,
        <yf.wang@mediatek.com>, <yong.wu@mediatek.com>
Subject: Re: [PATCH v9 2/3] iommu/mediatek: Rename MTK_IOMMU_TLB_ADDR to MTK_IOMMU_ADDR
Date:   Thu, 16 Jun 2022 14:40:24 +0800
Message-ID: <20220616064024.10683-1-yf.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <949c22c4-5f64-47cf-673c-14fcadcc1d27@arm.com>
References: <949c22c4-5f64-47cf-673c-14fcadcc1d27@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-15 at 18:14 +0100, Robin Murphy wrote:
> On 2022-06-15 17:12, yf.wang--- via iommu wrote:
> > From: Yunfei Wang <yf.wang@mediatek.com>
> > 
> > Rename MTK_IOMMU_TLB_ADDR to MTK_IOMMU_ADDR, and update
> > MTK_IOMMU_ADDR
> > definition for better generality.
> > 
> > Signed-off-by: Ning Li <ning.li@mediatek.com>
> > Signed-off-by: Yunfei Wang <yf.wang@mediatek.com>
> > ---
> >   drivers/iommu/mtk_iommu.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> > index bb9dd92c9898..3d62399e8865 100644
> > --- a/drivers/iommu/mtk_iommu.c
> > +++ b/drivers/iommu/mtk_iommu.c
> > @@ -265,8 +265,8 @@ static const struct iommu_ops mtk_iommu_ops;
> >   
> >   static int mtk_iommu_hw_init(const struct mtk_iommu_data *data,
> > unsigned int bankid);
> >   
> > -#define MTK_IOMMU_TLB_ADDR(iova) ({				
> > 	\
> > -	dma_addr_t _addr = iova;					\
> > +#define MTK_IOMMU_ADDR(addr) ({					
> > 	\
> > +	unsigned long long _addr = addr;				\
> 
> If phys_addr_t is 64-bit, then dma_addr_t is also 64-bit, so there is
> no 
> loss of generality from using an appropriate type - IOVAs have to
> fit 
> into dma_addr_t for iommu-dma, after all. However, since IOVAs also
> have 
> to fit into unsigned long in the general IOMMU API, as "addr" is
> here, 
> then this is still just as broken for 32-bit LPAE as the existing
> code is.
> 
> Thanks,
> Robin.
> 

Hi Robin,
According to Path#1's suggestion, next version will keep ttbr to encoded 32 bits,
then will don't need to modify it.

Thanks,
Yunfei.


> >   	((lower_32_bits(_addr) & GENMASK(31, 12)) |
> > upper_32_bits(_addr));\
> >   })
> >   
> > @@ -381,8 +381,8 @@ static void
> > mtk_iommu_tlb_flush_range_sync(unsigned long iova, size_t size,
> >   		writel_relaxed(F_INVLD_EN1 | F_INVLD_EN0,
> >   			       base + data->plat_data->inv_sel_reg);
> >   
> > -		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova), base +
> > REG_MMU_INVLD_START_A);
> > -		writel_relaxed(MTK_IOMMU_TLB_ADDR(iova + size - 1),
> > +		writel_relaxed(MTK_IOMMU_ADDR(iova), base +
> > REG_MMU_INVLD_START_A);
> > +		writel_relaxed(MTK_IOMMU_ADDR(iova + size - 1),
> >   			       base + REG_MMU_INVLD_END_A);
> >   		writel_relaxed(F_MMU_INV_RANGE, base +
> > REG_MMU_INVALIDATE);
> >
