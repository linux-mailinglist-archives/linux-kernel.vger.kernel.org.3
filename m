Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572FE4BB8FF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiBRMRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:17:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiBRMRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:17:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CD128DDE3;
        Fri, 18 Feb 2022 04:17:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0B4EB82610;
        Fri, 18 Feb 2022 12:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DA16C340E9;
        Fri, 18 Feb 2022 12:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645186653;
        bh=Xhp/n5pC/m8sJ4ETvUkmuS+0wXHJDe9HqAoXpaAAhzM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PrljZQE8KwYpeMK9yqKJtAVzgIsR13V2D/cO1/YaA0stNMtu0dq16C7/idti+OouO
         iz2SPe6Wma2QcaUnMcTycT8HXS3cD3B6eoJ/i6RDHuJo3uduYJaloxAYQ0wI5FkqYY
         pT0JTDzLiV4jPhR4md7bFjLPPUov54Vy4lUR69u05EYgC38FJsvdO+dHoBqd+hyQda
         5y31/ssSqyfZU1lLWFJkCcw/ylmdiwG5K5OcUVgZK9IRLsp2yEFX95MVT29UreL8WH
         Fkbijs58ZmxV8cx+a7McKm+XS3+DsFBz8/E/FKX19cVTH1GOYNgxiZC7gU8MVxRA3p
         Vq09onRuupwag==
Date:   Fri, 18 Feb 2022 12:24:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio: potentiometer: Add support for Maxim DS3502
Message-ID: <20220218122420.76425450@jic23-huawei>
In-Reply-To: <20220214195252.GA7374@jagath-PC>
References: <20220214033620.4059-1-jagathjog1996@gmail.com>
        <20220214033620.4059-4-jagathjog1996@gmail.com>
        <CAHp75VcWym5vyDAVyTUCpj=Qkm28VUaqdqJ7VuFL_bsb0fmhaA@mail.gmail.com>
        <20220214195252.GA7374@jagath-PC>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2022 01:22:54 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Hello Andy,
> 
> On Mon, Feb 14, 2022 at 01:32:14PM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 14, 2022 at 5:36 AM Jagath Jog J <jagathjog1996@gmail.com> wrote:  
> > >
> > > The DS3502 is a 7-bit, nonvolatile digital potentiometer featuring
> > > an output voltage range of up to 15.5V.
> > > DS3502 support is implemented into existing ds1803 driver  
> > 
> > Be consistent here and in other commit messages with how you refer to
> > the IC parts, i.e.
> > DS1803. Don't forget English grammar and punctuation, i.e. missed period above.
> >   
> 
> I will fix this in v3
> 
> > > Datasheet: https://datasheets.maximintegrated.com/en/ds/DS3502.pdf  
> >   
> > >  
> > 
> > A tag block may not have blank lines. Drop it.
> >   
> > > Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>  
> > 
> > ...
> >   
> > > -       tristate "Maxim Integrated DS1803 Digital Potentiometer driver"
> > > +       tristate "Maxim Integrated DS1803 and similar Digital Potentiometer driver"  
> > 
> > Please, list them like other drivers do:
> > 
> >        tristate "Maxim Integrated DS1803/DS... Digital Potentiometer driver"
> > 
> > ...
> >   
> > > -         Say yes here to build support for the Maxim Integrated DS1803
> > > -         digital potentiometer chip.
> > > +         Say yes here to build support for the Maxim Integrated DS1803 and
> > > +         similar digital potentiometer chip.  
> > 
> > Same here.

Usual thing is to use the and similar phrasing for the title if it
is getting to long and have the one place that lists them all being the belp
text.  We need it somewhere so people can grep for it.

> > 
> > ...
> >   
> > > - * Maxim Integrated DS1803 digital potentiometer driver
> > > + * Maxim Integrated DS1803 and similar digital potentiometer driver  
> > 
> > Same here.  
> 
> Based on Jonathan suggestion for the previous patch version I used 
> "and similar" wording here.

I wasn't that clear on exactly where to do that!  Sorry about that.

> 
> > 
> > ...
> >   
> > > -#define DS1803_MAX_POS         255
> > > -#define DS1803_WRITE(chan)     (0xa8 | ((chan) + 1))  
> > 
> > Not sure why these were removed (or moved?)  
> 
> Since max wiper position is present in avail array of ds1803_cfg structure
> and that is being used for read scale so DS1803_MAX_POS is removed.
> 
> Since each wiper address of both parts is assigned to the address
> member of iio_chan_spec struct so DS1803_WRITE(chan) is removed.
> 
> > 
> > ...
> >   
> > > +static const struct ds1803_cfg ds1803_cfg[] = {
> > > +       [DS1803_010] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  10,
> > > +                        .channels = ds1803_channels,
> > > +                        .num_channels = ARRAY_SIZE(ds1803_channels) },
> > > +       [DS1803_050] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms =  50,
> > > +                        .channels = ds1803_channels,
> > > +                        .num_channels = ARRAY_SIZE(ds1803_channels) },
> > > +       [DS1803_100] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100,
> > > +                        .channels = ds1803_channels,
> > > +                        .num_channels = ARRAY_SIZE(ds1803_channels) },
> > > +       [DS3502] =     { .wipers = 1, .avail = { 0, 1, 127 }, .kohms =  10,
> > > +                        .channels = ds3502_channels,
> > > +                        .num_channels = ARRAY_SIZE(ds3502_channels) },
> > >  };  
> > 
> > Split this on a per type basis. I believe it won't be too much work,
> > also, consider adding channels as a separate preparatory patch as you
> > did with avail.  
> 
> Based on Jonathan suggestion for the previous patch version to avoid
> having different chip type related structures so channels and num_channels
> are added into ds1803_cfg structure.
> 
> Sure for channels I will split into separate patch for old part in v3.

I'm not totally sure what Andy is suggesting with his feedback here.

> 
> >
> > ...
> >   
> > > -       data->cfg = &ds1803_cfg[id->driver_data];
> > > +       data->chip_type = (uintptr_t)device_get_match_data(dev);
> > > +       if (data->chip_type < DS1803_010 || data->chip_type > DS3502)
> > > +               data->chip_type = id->driver_data;  
> > 
> > Split it into a separate patch and use pointer validation instead:
> > 
> > data->cfg = ...
> > if (!data->cfg)
> >   data->cfg = ...id->driver_data;
> > 
> > ...
> >   
> > > -       { .compatible = "maxim,ds1803-010", .data = &ds1803_cfg[DS1803_010] },
> > > -       { .compatible = "maxim,ds1803-050", .data = &ds1803_cfg[DS1803_050] },
> > > -       { .compatible = "maxim,ds1803-100", .data = &ds1803_cfg[DS1803_100] },  
> 
> To get the chip specific structure I can use previous structure method for data
> and validation as you shown above.
> But it is necessary to get the chip_type also because of dependency in 
> ds1803_raw_read().

You could use a function pointer in the cfg structure and provide appropriate read
functions for the different types so that read_raw() can call the appropriate function
for the type of device.  That would be tidy and avoid this need to change
to an enum.

Sorry for slow response btw as I didn't get in before v3!

Thanks,

Jonathan


> 
> To get the chip_type can I use 
> data->chip_type = id->driver_data
> 
> > > +       { .compatible = "maxim,ds1803-010", .data = (void *)DS1803_010 },
> > > +       { .compatible = "maxim,ds1803-050", .data = (void *)DS1803_050 },
> > > +       { .compatible = "maxim,ds1803-100", .data = (void *)DS1803_100 },  
> > 
> > This is not good, please use pointers as it was before.
> >   
> > > +       { .compatible = "maxim,ds3502",     .data = (void *)DS3502 },  
> > 
> > Ditto. Create a new, separate structure for this type.
> > 
> > ...
> >   
> > >         { "ds1803-010", DS1803_010 },
> > >         { "ds1803-050", DS1803_050 },
> > >         { "ds1803-100", DS1803_100 },
> > > +       { "ds3502",     DS3502     },  
> > 
> > Too many spaces.
> > Besides this, please create a new prerequisite patch to convert this
> > to use pointers as above.  
> 
> Sure I will split this patch in v3.
> Thanks for feedback.
> 
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko  
> 
> Best Regards,
> Jagath

