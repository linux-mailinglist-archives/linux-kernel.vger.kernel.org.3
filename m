Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB1254C01E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 05:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349243AbiFODXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 23:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347659AbiFODXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 23:23:04 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D628718;
        Tue, 14 Jun 2022 20:23:02 -0700 (PDT)
X-UUID: d33e49da718c4b51b3b0c14367503abb-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:6c3cccab-0fe4-43bc-84e0-0e0340287d29,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:b14ad71,CLOUDID:e5fc40f6-e099-41ba-a32c-13b8bfe63214,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:nil,BEC:nil,COL:0
X-UUID: d33e49da718c4b51b3b0c14367503abb-20220615
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <tinghan.shen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1213592873; Wed, 15 Jun 2022 11:22:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 15 Jun 2022 11:22:55 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 15 Jun 2022 11:22:55 +0800
Message-ID: <26dd3afdb6be659fe97d5e05588c6d1d6630d934.camel@mediatek.com>
Subject: Re: [PATCH v2 2/3] firmware: mediatek: Use meaningful names for mbox
From:   Tinghan Shen <tinghan.shen@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        YC Hung <yc.hung@mediatek.com>,
        Curtis Malainey <cujomalainey@chromium.org>,
        "Allen-KH Cheng" <allen-kh.cheng@mediatek.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 15 Jun 2022 11:22:55 +0800
In-Reply-To: <d3f718fa-c773-4bc7-506b-d109bf72aa3b@collabora.com>
References: <20220609083101.24195-1-tinghan.shen@mediatek.com>
         <20220609083101.24195-3-tinghan.shen@mediatek.com>
         <d3f718fa-c773-4bc7-506b-d109bf72aa3b@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angelo,

On Mon, 2022-06-13 at 14:37 +0200, AngeloGioacchino Del Regno wrote:
> Il 09/06/22 10:31, Tinghan Shen ha scritto:
> > Rename mbox according to action instead of 'mbox0' and 'mbox1'
> > 
> > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> > ---
> >   drivers/firmware/mtk-adsp-ipc.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/firmware/mtk-adsp-ipc.c b/drivers/firmware/mtk-adsp-ipc.c
> > index cb255a99170c..3de94765d659 100644
> > --- a/drivers/firmware/mtk-adsp-ipc.c
> > +++ b/drivers/firmware/mtk-adsp-ipc.c
> > @@ -83,7 +83,11 @@ static int mtk_adsp_ipc_probe(struct platform_device *pdev)
> >   		return -ENOMEM;
> >   
> >   	for (i = 0; i < MTK_ADSP_MBOX_NUM; i++) {
> > -		chan_name = kasprintf(GFP_KERNEL, "mbox%d", i);
> > +		if (i < MTK_ADSP_MBOX_NUM / 2)
> > +			chan_name = kasprintf(GFP_KERNEL, "rep");
> > +		else
> > +			chan_name = kasprintf(GFP_KERNEL, "req");
> > +
> >   		if (!chan_name) {
> >   			ret = -ENOMEM;
> >   			goto out;
> 
> At this point, just call them "reply" and "request", as that simply provides a
> perfectly clear explanation.
> 
> Besides, I'm sorry but I really don't like this code, it's really too much
> fragile and will have to be changed entirely if a third mbox is introduced.
> 
> I can suggest a cooler way:
> 
> static const char * const adsp_mbox_ch_names[MTK_ADSP_MBOX_NUM] = { "rep", "req" };
> 
> for (i = 0; i < ARRAY_SIZE(adsp_mbox_ch_names); i++) {
> 	/* we can delete chan_name and also avoid a kfree if we do... */
> 
> 	.... code ....
> 
> 	adsp_chan->ch = mbox_request_channel_byname(cl, adsp_mbox_ch_names[i]);
> 
> 	... etc etc ...
> }
> 
> Cheers,
> Angelo

Ok, I'll update in the next version.
Thank you!


Best regards,
TingHan

