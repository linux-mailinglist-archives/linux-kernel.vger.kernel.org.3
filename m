Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4A48F75E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 15:56:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiAOO40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 09:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiAOO4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 09:56:24 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82519C061574;
        Sat, 15 Jan 2022 06:56:24 -0800 (PST)
Received: from [81.101.6.87] (port=47186 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n8kTV-0000NS-RE; Sat, 15 Jan 2022 14:56:14 +0000
Date:   Sat, 15 Jan 2022 15:02:08 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Guodong Liu <guodong.liu@mediatek.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v1 2/2] iio: adc: mt8186: Add compatible node for mt8186
Message-ID: <20220115150208.15fb6284@jic23-huawei>
In-Reply-To: <292950d7-d057-4e66-5d0d-a5144f50f2ce@collabora.com>
References: <20220110084841.575-1-guodong.liu@mediatek.com>
 <20220110084841.575-2-guodong.liu@mediatek.com>
 <292950d7-d057-4e66-5d0d-a5144f50f2ce@collabora.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 11:01:28 +0100
AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:

> Il 10/01/22 09:48, Guodong Liu ha scritto:
> > This commit adds mt8186 compatible node.
> > 
> > Signed-off-by: Guodong Liu <guodong.liu@mediatek.com>  
> 
> Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Applied with a slight tweak to patch 2 as an earlier tidyup added
a bracket before the } in the table so make this line match as well.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to poke at it for us.  I'll be rebasing the tree after rc1 is out.

Thanks,
Jonathan

> 
> > ---
> >   drivers/iio/adc/mt6577_auxadc.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/mt6577_auxadc.c b/drivers/iio/adc/mt6577_auxadc.c
> > index d4fccd52ef08..fb08d761589a 100644
> > --- a/drivers/iio/adc/mt6577_auxadc.c
> > +++ b/drivers/iio/adc/mt6577_auxadc.c
> > @@ -46,6 +46,11 @@ struct mt6577_auxadc_device {
> >   	const struct mtk_auxadc_compatible *dev_comp;
> >   };
> >   
> > +static const struct mtk_auxadc_compatible mt8186_compat = {
> > +	.sample_data_cali = false,
> > +	.check_global_idle = false,
> > +};
> > +
> >   static const struct mtk_auxadc_compatible mt8173_compat = {
> >   	.sample_data_cali = false,
> >   	.check_global_idle = true,
> > @@ -334,6 +339,7 @@ static const struct of_device_id mt6577_auxadc_of_match[] = {
> >   	{ .compatible = "mediatek,mt2712-auxadc", .data = &mt8173_compat},
> >   	{ .compatible = "mediatek,mt7622-auxadc", .data = &mt8173_compat},
> >   	{ .compatible = "mediatek,mt8173-auxadc", .data = &mt8173_compat},
> > +	{ .compatible = "mediatek,mt8186-auxadc", .data = &mt8186_compat},
> >   	{ .compatible = "mediatek,mt6765-auxadc", .data = &mt6765_compat},
> >   	{ }
> >   };
> >   

