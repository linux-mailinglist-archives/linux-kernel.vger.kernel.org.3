Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5B1353CDD0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 19:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343969AbiFCRKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 13:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiFCRK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:10:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869CE5251B;
        Fri,  3 Jun 2022 10:10:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B46BB823AB;
        Fri,  3 Jun 2022 17:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2A6C385B8;
        Fri,  3 Jun 2022 17:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654276222;
        bh=Yhb8OPp1sSwZzVcLGVjDxYrN0vlwebO9faHuTNWhG4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pJUj26xM3omq1XfJzae2/kNYP0GNrKZJAlX6qQvFkoORdgX2jatgBaZhjITDetyo4
         6Ho3r8JCZNDTqYqTywpriBv1enouc70JPjw/sYrT7zAqOY3+TbCZUGrBVxnV0twFzb
         vBFIAuE6Owl4SCoC0jyhKAh0Wkj62wDDrGkEYuY9ZHlH2kkn5YxDGMdMJ4lJ4ZJtOM
         8FilAtIOaatwJZHh8x0+lYlCL4U9MemxvnRqpNaXZGP17ucBaA6OSj8utHuAIdF2Zq
         mOVjuiYHKrUQzkdqfZZndqYO3gcqFcQLMxn6f/bbPrMbEy5YxC7w8yXCWqyVB3lzQC
         zN8eYoz/vFcNw==
Date:   Fri, 3 Jun 2022 18:19:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, lars@metafoo.de, lgirdwood@gmail.com,
        broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de,
        ChiYuan Huang <cy_huang@richtek.com>, alice_chen@richtek.com,
        chiaen_wu@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [RESEND 10/14] iio: adc: mt6370: Add Mediatek MT6370 support
Message-ID: <20220603181917.3f737913@jic23-huawei>
In-Reply-To: <CABtFH5Lg43EXS7juhXQ2wQFZzkpD7YB8rM6UFT=U9BDOKcbaNw@mail.gmail.com>
References: <20220531111900.19422-1-peterwu.pub@gmail.com>
        <20220531111900.19422-11-peterwu.pub@gmail.com>
        <20220531142102.00007df0@Huawei.com>
        <CABtFH5Lg43EXS7juhXQ2wQFZzkpD7YB8rM6UFT=U9BDOKcbaNw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >  
> > > +
> > > +#define MT6370_AICR_400MA            0x6
> > > +#define MT6370_ICHG_500MA            0x4
> > > +#define MT6370_ICHG_900MA            0x8
> > > +
> > > +#define ADC_CONV_TIME_US             35000
> > > +#define ADC_CONV_POLLING_TIME                1000
> > > +
> > > +struct mt6370_adc_data {
> > > +     struct device *dev;
> > > +     struct regmap *regmap;
> > > +     struct mutex lock;  
> >
> > All locks need documentation.  What is the scope of the lock?
> > Looks like it protects device state when doing setup, wait for read, read
> > cycles.  
> 
> This mutex lock is for preventing the different adc channel from being
> read at the same time.
> So, if I just change its name to adc_chan_lock or adc_lock and add the
> comment for this mutex lock, does this change meet your requirement

Yes

> 
> >  
> > > +};
> > > +
> > > +static int mt6370_adc_read_scale(struct mt6370_adc_data *priv,
> > > +                              int chan, int *val1, int *val2)
> > > +{
> > > +     unsigned int reg_val;
> > > +     int ret;
> > > +
> > > +     switch (chan) {
> > > +     case MT6370_CHAN_VBAT:
> > > +     case MT6370_CHAN_VSYS:
> > > +     case MT6370_CHAN_CHG_VDDP:
> > > +             *val1 = 5000;  
> >
> > This seems very large.  Voltages are in millivolts
> > as per Documentation/ABI/testing/sysfs-bus-iio
> > and this means each step is 5 volts.
> >
> > So value in mv is currently 5 * _raw
> >  
> 
> OK, I got it. Also, I will add the ABI file in the next version. Thanks!
Only add ABI documentation for anything non-standard.

The documentation scripts really don't like repeats!

> 
> > > +static const char * const mt6370_channel_labels[MT6370_CHAN_MAX] = {  
> >
> > Perhaps define an enum with which to index this and the chan spec
> > and hence ensure they end up matching.
> >  [vbusdiv5] = "vbusdiv5", etc
> >  
> 
> Do you mean that I can refine this const char array to the following array??
> 
> static const char * const mt6370_channel_labels[MT6370_CHAN_MAX] = {
>     [MT6370_CHAN_VBUSDIV5] =  "vbusdiv5",
>     [MT6370_CHAN_VBUSDIV2] =  "vbusdiv2",
>     ...
>     ...
>     [MT6370_CHAN_TEMP_JC] =  "temp_jc",
> };

Yes

thanks,

Jonathan
