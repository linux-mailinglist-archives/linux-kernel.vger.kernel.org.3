Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6C5488A60
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 17:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235966AbiAIQAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 11:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiAIQAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 11:00:34 -0500
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF26C06173F;
        Sun,  9 Jan 2022 08:00:33 -0800 (PST)
Received: from [81.101.6.87] (port=47170 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n6acF-00086N-Ss; Sun, 09 Jan 2022 16:00:20 +0000
Date:   Sun, 9 Jan 2022 16:06:07 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Cixi Geng <gengcixi@gmail.com>, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, yuming.zhu1@unisoc.com,
        linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] iio: adc: sc27xx: fix read big scale voltage not
 right
Message-ID: <20220109160532.5977aa08@jic23-huawei>
In-Reply-To: <CADBw62pCDOu41G6t42dupuYF8F0mdhidNYg9=G7D+ns3AkyE_w@mail.gmail.com>
References: <20220106125947.139523-1-gengcixi@gmail.com>
        <20220106125947.139523-3-gengcixi@gmail.com>
        <CADBw62pCDOu41G6t42dupuYF8F0mdhidNYg9=G7D+ns3AkyE_w@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jan 2022 14:55:15 +0800
Baolin Wang <baolin.wang7@gmail.com> wrote:

> On Thu, Jan 6, 2022 at 9:00 PM Cixi Geng <gengcixi@gmail.com> wrote:
> >
> > From: Cixi Geng <cixi.geng1@unisoc.com>
> >
> > Fix wrong configuration value of SC27XX_ADC_SCALE_MASK and
> > SC27XX_ADC_SCALE_SHIFT by spec documetation.
> >
> > Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> > Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>  
> 
> Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

Fixes: tag for backports?

or is this having no visible result today?

Jonathan

> 
> > ---
> >  drivers/iio/adc/sc27xx_adc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> > index 00098caf6d9e..aee076c8e2b1 100644
> > --- a/drivers/iio/adc/sc27xx_adc.c
> > +++ b/drivers/iio/adc/sc27xx_adc.c
> > @@ -36,8 +36,8 @@
> >
> >  /* Bits and mask definition for SC27XX_ADC_CH_CFG register */
> >  #define SC27XX_ADC_CHN_ID_MASK         GENMASK(4, 0)
> > -#define SC27XX_ADC_SCALE_MASK          GENMASK(10, 8)
> > -#define SC27XX_ADC_SCALE_SHIFT         8
> > +#define SC27XX_ADC_SCALE_MASK          GENMASK(10, 9)
> > +#define SC27XX_ADC_SCALE_SHIFT         9
> >
> >  /* Bits definitions for SC27XX_ADC_INT_EN registers */
> >  #define SC27XX_ADC_IRQ_EN              BIT(0)
> > --
> > 2.25.1
> >  
> 
> 

