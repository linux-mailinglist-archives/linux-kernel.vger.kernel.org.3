Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5EBC5459A7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 03:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241393AbiFJBoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 21:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiFJBoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 21:44:08 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9932C1A65C3;
        Thu,  9 Jun 2022 18:44:01 -0700 (PDT)
X-UUID: 9665cc928b9a4879b72636fe41e68882-20220610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:d2a5c10e-34cb-4546-8e88-175b9ad34f03,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACT
        ION:release,TS:-5
X-CID-META: VersionHash:2a19b09,CLOUDID:dad751e5-2ba2-4dc1-b6c5-11feb6c769e0,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 9665cc928b9a4879b72636fe41e68882-20220610
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <yunfei.dong@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 91365619; Fri, 10 Jun 2022 09:43:55 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Fri, 10 Jun 2022 09:43:53 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 10 Jun 2022 09:43:51 +0800
Message-ID: <b1b4ff47306af5fc0aecf8d2041ffca4c30717b2.camel@mediatek.com>
Subject: Re: [PATCH 1/4] media: mediatek: vcodec: Fix decoder v4l2 bus_info
 not correctly
From:   "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>
CC:     George Sun <george.sun@mediatek.com>,
        Xiaoyong Lu <xiaoyong.lu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Fritz Koenig" <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Irui Wang <irui.wang@mediatek.com>,
        "Steve Cho" <stevecho@chromium.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 10 Jun 2022 09:43:51 +0800
In-Reply-To: <3cd958be-41a8-707d-983a-c9950e913ae5@xs4all.nl>
References: <20220526095737.21118-1-yunfei.dong@mediatek.com>
         <3cd958be-41a8-707d-983a-c9950e913ae5@xs4all.nl>
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

Dear Hans,

Thanks for your suggestion.

I will fix bus_info in patch v2:
decoder: "platform:mt%d" to "platform:mt%d-dec"
encoder: "platform:mt%d" to "platform:mt%d-enc"

Best Regards,
Yunfei Dong

On Thu, 2022-06-09 at 12:08 +0200, Hans Verkuil wrote:
> Hi Yunfei Dong,
> 
> On 5/26/22 11:57, Yunfei Dong wrote:
> > Fix v4l2 capability bus_info value with correct chip name according
> > to compatible.
> > 
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> > ---
> >  .../platform/mediatek/vcodec/mtk_vcodec_dec.c | 23
> > ++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> > 
> > diff --git
> > a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > index 52e5d36aa912..ccfa426a34ab 100644
> > --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec.c
> > @@ -185,11 +185,32 @@ static int vidioc_vdec_dqbuf(struct file
> > *file, void *priv,
> >  	return v4l2_m2m_dqbuf(file, ctx->m2m_ctx, buf);
> >  }
> >  
> > +static int mtk_vcodec_dec_get_chip_name(void *priv)
> > +{
> > +	struct mtk_vcodec_ctx *ctx = fh_to_ctx(priv);
> > +	struct device *dev = &ctx->dev->plat_dev->dev;
> > +
> > +	if (of_device_is_compatible(dev->of_node, "mediatek,mt8173-
> > vcodec-dec"))
> > +		return 8173;
> > +	else if (of_device_is_compatible(dev->of_node,
> > "mediatek,mt8183-vcodec-dec"))
> > +		return 8183;
> > +	else if (of_device_is_compatible(dev->of_node,
> > "mediatek,mt8192-vcodec-dec"))
> > +		return 8192;
> > +	else if (of_device_is_compatible(dev->of_node,
> > "mediatek,mt8195-vcodec-dec"))
> > +		return 8195;
> > +	else if (of_device_is_compatible(dev->of_node,
> > "mediatek,mt8186-vcodec-dec"))
> > +		return 8186;
> > +	else
> > +		return 8173;
> > +}
> 
> Nice, but...
> 
> > +
> >  static int vidioc_vdec_querycap(struct file *file, void *priv,
> >  				struct v4l2_capability *cap)
> >  {
> > +	int platform_name = mtk_vcodec_dec_get_chip_name(priv);
> > +
> >  	strscpy(cap->driver, MTK_VCODEC_DEC_NAME, sizeof(cap->driver));
> > -	strscpy(cap->bus_info, MTK_PLATFORM_STR, sizeof(cap-
> > >bus_info));
> > +	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d",
> > platform_name);
> 
> ...this will result in identical bus_info values for the decoder and
> encoder
> video devices. The bus_info field is supposed to be unique, and
> that's now
> no longer the case.
> 
> I suggest changing this to:
> 
> 	snprintf(cap->bus_info, sizeof(cap->bus_info), "platform:mt%d-
> dec", platform_name);
> 
> (and '-enc' for the encoder patch).
> 
> Regards,
> 
> 	Hans
> 
> >  	strscpy(cap->card, MTK_PLATFORM_STR, sizeof(cap->card));
> >  
> >  	return 0;

