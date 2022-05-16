Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A52652810C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241719AbiEPJvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239666AbiEPJu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:50:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0543E32ED0;
        Mon, 16 May 2022 02:50:53 -0700 (PDT)
X-UUID: b39f57b2a0204a3398949a3ee684f293-20220516
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:cd17e864-2998-4f44-8ae3-49e7bf910369,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:e08abdb9-9f46-4d76-a271-164488ed79f1,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:1,File:nil
        ,QS:0,BEC:nil
X-UUID: b39f57b2a0204a3398949a3ee684f293-20220516
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1293274372; Mon, 16 May 2022 17:50:41 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 16 May 2022 17:50:40 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Mon, 16 May 2022 17:50:40 +0800
Message-ID: <4b5d6607b90f3e36fce7e61e1768da55693546aa.camel@mediatek.com>
Subject: Re: [PATCH] soc: mediatek: mtk-mmsys: Add support for MT6795 Helio
 X10
From:   CK Hu <ck.hu@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, <matthias.bgg@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <konrad.dybcio@somainline.org>,
        <marijn.suijten@somainline.org>, <martin.botka@somainline.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <paul.bouchara@somainline.org>,
        <kernel@collabora.com>
Date:   Mon, 16 May 2022 17:50:39 +0800
In-Reply-To: <a7afc559-4e0a-6552-190c-19e58851ce68@collabora.com>
References: <20220513170350.502501-1-angelogioacchino.delregno@collabora.com>
         <7c996c665a57fdd9ba8d6df4dc085f70afc1b933.camel@mediatek.com>
         <a7afc559-4e0a-6552-190c-19e58851ce68@collabora.com>
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

On Mon, 2022-05-16 at 10:44 +0200, AngeloGioacchino Del Regno wrote:
> Il 16/05/22 07:43, CK Hu ha scritto:
> > Hi, Angelo:
> > 
> > On Fri, 2022-05-13 at 19:03 +0200, AngeloGioacchino Del Regno
> > wrote:
> > > Add MM support for the MT6795 SoC, using the mmsys default
> > > routing
> > > table.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <
> > > angelogioacchino.delregno@collabora.com>
> > > ---
> > > 
> > > In order for this patch to have any meaning and functionality, it
> > > is
> > > required to also have in-tree the [1] MT6795 clocks series, even
> > > though that's not required to actually compile this code.
> > > 
> > > [1]
> > > 
https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-mediatek/list/?series=641493__;!!CTRNKA9wMg0ARbw!ywDb_Gj4oV0iYHK_PbtJSNejzsJGlFVjX-1O0G1mR0vZX_5VeMtlZJ_AS6K_Mg$
> > >   
> > > 
> > >   drivers/soc/mediatek/mtk-mmsys.c | 11 +++++++++++
> > >   1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/soc/mediatek/mtk-mmsys.c
> > > b/drivers/soc/mediatek/mtk-mmsys.c
> > > index 06d8e83a2cb5..38b36b881a3b 100644
> > > --- a/drivers/soc/mediatek/mtk-mmsys.c
> > > +++ b/drivers/soc/mediatek/mtk-mmsys.c
> > > @@ -57,6 +57,13 @@ static const struct mtk_mmsys_match_data
> > > mt6779_mmsys_match_data = {
> > >   	},
> > >   };
> > >   
> > > +static const struct mtk_mmsys_driver_data
> > > mt6795_mmsys_driver_data =
> > > {
> > > +	.clk_driver = "clk-mt6795-mm",
> > > +	.routes = mmsys_default_routing_table,
> > 
> > mt6795 should have its own routing table instead of default one.
> > The
> > default one is used for mt8173, mt2701, mt2712 which no one knows
> > how
> > to separate them. If you don't know the routing table of mt6795,
> > just
> > left this as NULL.
> > 
> 
> Hello CK,
> 
> I agree with you, in fact the first test that I've done was with
> leaving
> routes to NULL, but that did not work (I couldn't get the display to
> work),
> while assigning the default routing table resulted in having a
> working
> internal (DSI) display et al, which is why I have done that.
> 
> I am sure that this may be a quirk that is required due to my
> platform's
> bootloader, but still, it won't work otherwise.
> 
> If anyone from MediaTek wants to help with providing a better
> solution for
> that, you're welcome to - but otherwise, my proposal is to configure
> MT6795
> with that default routing table and eventually come back to this
> later if
> any issue with this gets discovered... I couldn't find any, though.

So you have a drm driver which support mt6795 and it would call
mtk_mmsys_ddp_connect() to setup routing routing register. You could
generate mt6795 routing table from default one by partial element that
you use in mt6795. I think this table would be smaller than the default
one.

Regards,
CK

> 
> Cheers,
> Angelo
> 

