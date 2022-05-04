Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1647519D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348351AbiEDKzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348296AbiEDKzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:55:43 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F0823BE7;
        Wed,  4 May 2022 03:52:03 -0700 (PDT)
X-UUID: 9c4e4f33b5d844c283514e4bd4346407-20220504
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:2c6a1a93-3001-4a42-a9d1-603d1596aa48,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:faefae9,CLOUDID:276f89b2-56b5-4c9e-8d83-0070b288eb6a,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 9c4e4f33b5d844c283514e4bd4346407-20220504
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1720649923; Wed, 04 May 2022 18:51:57 +0800
Received: from mtkmbs07n1.mediatek.inc (172.21.101.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 4 May 2022 18:51:56 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 4 May 2022 18:51:56 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Wed, 4 May 2022 18:51:56 +0800
Message-ID: <a70c96248f7bc22b9f7f247f59ceafed17d912e0.camel@mediatek.com>
Subject: Re: [PATCH 2/2] soc: mediatek: devapc: Add support for MT8186
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>
CC:     <neal.liu@mediatek.com>, <runyang.chen@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 4 May 2022 18:51:55 +0800
In-Reply-To: <3bd77be6-82ea-8c24-242a-0ee486ce888c@collabora.com>
References: <20220429065429.7957-1-rex-bc.chen@mediatek.com>
         <20220429065429.7957-3-rex-bc.chen@mediatek.com>
         <3bd77be6-82ea-8c24-242a-0ee486ce888c@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-05-04 at 11:34 +0200, AngeloGioacchino Del Regno wrote:
> Il 29/04/22 08:54, Rex-BC Chen ha scritto:
> > Add devapc data and compatible to support MT8186 devapc.
> > 
> > Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> > Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> > ---
> >   drivers/soc/mediatek/mtk-devapc.c | 15 +++++++++++++++
> >   1 file changed, 15 insertions(+)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-devapc.c
> > b/drivers/soc/mediatek/mtk-devapc.c
> > index 7c65ad3d1f8a..762e0e4d967d 100644
> > --- a/drivers/soc/mediatek/mtk-devapc.c
> > +++ b/drivers/soc/mediatek/mtk-devapc.c
> > @@ -227,10 +227,25 @@ static const struct mtk_devapc_data
> > devapc_mt6779 = {
> >   	.vio_shift_con_offset = 0xF20,
> >   };
> >   
> > +static const struct mtk_devapc_data devapc_mt8186 = {
> > +	.vio_idx_num = 519,
> > +	.vio_mask_offset = 0x0,
> > +	.vio_sta_offset = 0x400,
> > +	.vio_dbg0_offset = 0x900,
> > +	.vio_dbg1_offset = 0x904,
> > +	.apc_con_offset = 0xF00,
> > +	.vio_shift_sta_offset = 0xF10,
> > +	.vio_shift_sel_offset = 0xF14,
> > +	.vio_shift_con_offset = 0xF20,
> > +};
> 
> Hello Rex,
> since the register layout is common across a lot of MediaTek SoCs and
> basically
> only the vio_idx_num wildly varies between them, can you separate
> this parameter
> from the mtk_devapc_data struct?
> 
> I propose the following:
> 
> struct mtk_devapc_regs {
> 	/* reg offset */
> 	u32 vio_mask_offset;
> 	u32 ... etc
> };
> 
> struct mtk_devapc_data {
> 	u32 vio_idx_num;
> 	const struct mtk_devapc_regs *regs;
> };
> 
> static const struct mtk_devapc_regs devapc_regs_mt6779 = {
> 	.vio_mask_offset = 0x0,
> 	.vio...etc
> };
> 
> static const struct mtk_devapc_data devapc_mt6779 = {
> 	.vio_idx_num = 511,
> 	.regs = devapc_regs_mt6779,
> };
> 
> static const struct mtk_devapc_data devapc_mt8186 = {
> 	.vio_idx_num = 519,
> 	.regs = devapc_regs_mt6779,
> };
> 
> Regards,
> Angelo
> 

Hello Angelo,

Thanks for your advise.
I will separate vio_idx_num and register offsets in next version.

BRs,
Rex

