Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5CA4E4D58
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239147AbiCWHaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbiCWHaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:30:52 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60951EC72;
        Wed, 23 Mar 2022 00:29:23 -0700 (PDT)
X-UUID: 8906c5f59aaa459abc743dba05c9964d-20220323
X-UUID: 8906c5f59aaa459abc743dba05c9964d-20220323
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2145046796; Wed, 23 Mar 2022 15:29:19 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Mar 2022 15:29:17 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 23 Mar 2022 15:29:17 +0800
Message-ID: <08e3059ab5d645de0544e600b1bf85c95478e897.camel@mediatek.com>
Subject: Re: [PATCH v3 5/6] ASoC: mediatek: mt8195: add machine support for
 max98390 and rt5682
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
CC:     <broonie@kernel.org>, <tiwai@suse.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <angelogioacchino.delregno@collabora.com>,
        <yc.hung@mediatek.com>
Date:   Wed, 23 Mar 2022 15:29:17 +0800
In-Reply-To: <YjiV9DfLC7T1uweb@google.com>
References: <20220321072312.14972-1-trevor.wu@mediatek.com>
         <20220321072312.14972-6-trevor.wu@mediatek.com>
         <YjiV9DfLC7T1uweb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-21 at 23:12 +0800, Tzung-Bi Shih wrote:
> On Mon, Mar 21, 2022 at 03:23:11PM +0800, Trevor Wu wrote:
> > diff --git a/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> > b/sound/soc/mediatek/mt8195/mt8195-mt6359.c
> 
> [...]
> >  #define RT1011_SPEAKER_AMP_PRESENT		BIT(0)
> >  #define RT1019_SPEAKER_AMP_PRESENT		BIT(1)
> > +#define MAX98390_SPEAKER_AMP_PRESENT		BIT(2)
> > +
> > +#define MAX98390_CODEC_DAI	"max98390-aif1"
> > +#define MAX98390_DEV0_NAME	"max98390.2-0038" /* right */
> > +#define MAX98390_DEV1_NAME	"max98390.2-0039" /* left */
> >  
> >  #define RT1011_CODEC_DAI	"rt1011-aif"
> >  #define RT1011_DEV0_NAME	"rt1011.2-0038"
> 
> The quirk bit order: RT1011, RT1019, and MAX98390.  To be neat, move
> MAX98390_CODEC_DAI, MAX98390_DEV0_NAME, and MAX98390_DEV1_NAME after
> RT1019_DEV0_NAME to maintain the order.

OK. I will reorder the sequence in v4.

> 
> > +static int mt8195_max98390_init(struct snd_soc_pcm_runtime *rtd)
> 
> [...]
> > +
> > +	ret = snd_soc_dapm_add_routes(&card->dapm,
> > mt8195_max98390_routes,
> > +				      ARRAY_SIZE(mt8195_max98390_routes
> > ));
> > +
> > +	if (ret)
> 
> Remove the extra blank line.

OK. I will remove it in v4.

Thanks,
Trevor

