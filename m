Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3934FE8A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 21:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244968AbiDLTcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 15:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbiDLTck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 15:32:40 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F562627;
        Tue, 12 Apr 2022 12:30:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id md20-20020a17090b23d400b001cb70ef790dso3979179pjb.5;
        Tue, 12 Apr 2022 12:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zq+spe0FdFWadyE6Z3vT48KBIBCNRdapmLCCbr+Bbss=;
        b=X7/E3HjAxYYrn9q175XjZEGnATG+1FFuUmUx7q7Y5C7RT+WZ11r54QARCRer+AiEYZ
         OOQZlGk4h0GSTRTfg2rFBOB6dkfyU0a2EHefCNvGvfkedBFMhjWKwqhOMkOl8b1khDiD
         bIa+xQyp2i/tSR64qXNlMuGG0tTv0SJdx1pdMQ6UIkbb6YKOKo0keNv+t4CeP4bGtUS3
         o52v/ekrSdsRYBbM3gHEkb/Mmgpqrhbk6nxlML1CrixLo9tSuSAYtgg+A6WPSl1Yb5xA
         gkMozMR3DhjWBSGldxexPnJxldE6+Rn8Ya3iK+xlqomOxx4kPCaY8dvDWNZvJ1UN7WyA
         BiNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zq+spe0FdFWadyE6Z3vT48KBIBCNRdapmLCCbr+Bbss=;
        b=TrC95HvFu273Vsz4LrQ5a9TrzfMZH+iTuV3bbjIYtjnG+zSCQJs2z9WYE53lqY5Baw
         SQ0VUK447OdHvVFtW/+YA/u2pDhUVvx4V4yeKwURXbnqwsALaEmW09QMUOsFcy4UCUga
         711eZG0CyxLvnTFisIt5QZcUIByTR16KhGqWh+xnFgq3zr0IhQolAZljngy5FZ5PqRtr
         QfV6yaL6QYISYBgx7Wg2r8JXePdKr60FX/FuSeTua0iNtuQ1J13WBNOX43w77acxBfPq
         zdjE/O7hiRZIaa3valvomOhZClEi0emLa5vxv66obny81aACX/xGi52hQCH+IqVTH67Y
         O3Uw==
X-Gm-Message-State: AOAM530eEjDvkYvs+Hhzkk2LDVlYZR3sxHOumSzSlvFmuCwHTKoJcG6G
        h+i0kAGgSJjAZovgoBAR0P4=
X-Google-Smtp-Source: ABdhPJwCfcn/qr9fqf8hJ+5ZLK0UqyCuAr83KlLuIzVvMEXb8PbFM2ZSCQ5KI4lhHvn0f/Z/qjN1TA==
X-Received: by 2002:a17:903:2348:b0:154:dd0:aba8 with SMTP id c8-20020a170903234800b001540dd0aba8mr39914880plh.51.1649791820705;
        Tue, 12 Apr 2022 12:30:20 -0700 (PDT)
Received: from jagath-PC ([115.99.184.157])
        by smtp.gmail.com with ESMTPSA id 132-20020a62168a000000b004f40e8b3133sm40690811pfw.188.2022.04.12.12.30.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Apr 2022 12:30:20 -0700 (PDT)
Date:   Wed, 13 Apr 2022 01:00:15 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 4/9] iio: accel: bma400: Add triggered buffer support
Message-ID: <20220412193013.GA25279@jagath-PC>
References: <20220411203133.19929-1-jagathjog1996@gmail.com>
 <20220411203133.19929-5-jagathjog1996@gmail.com>
 <CAHp75VfHa9afhSdyi8dj5GpzrYE=hLacayu58+PHjXhMxTo9eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VfHa9afhSdyi8dj5GpzrYE=hLacayu58+PHjXhMxTo9eg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andy,

On Tue, Apr 12, 2022 at 12:12:21PM +0300, Andy Shevchenko wrote:
> On Mon, Apr 11, 2022 at 11:31 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >
> > Added trigger buffer support to read continuous acceleration
> > data from device with data ready interrupt which is mapped
> > to INT1 pin.
> 
> Can you explain the locking schema in this driver?
> 
> > +       /* Configure INT1 pin to open drain */
> > +       ret = regmap_write(data->regmap, BMA400_INT_IO_CTRL_REG, 0x06);
> > +       if (ret)
> > +               return ret;
> 
> No locking (or regmap only locking).

This is bma400_init() function which will run when probe runs so there is no
locking in this bma400_init().

> 
> ...
> 
> > +static int bma400_data_rdy_trigger_set_state(struct iio_trigger *trig,
> > +                                            bool state)
> > +{
> > +       struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> > +       struct bma400_data *data = iio_priv(indio_dev);
> > +       int ret;
> > +
> > +       ret = regmap_update_bits(data->regmap, BMA400_INT_CONFIG0_REG,
> > +                                BMA400_INT_DRDY_MSK,
> > +                                FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> > +       if (ret)
> > +               return ret;
> > +
> > +       return regmap_update_bits(data->regmap, BMA400_INT1_MAP_REG,
> > +                                 BMA400_INT_DRDY_MSK,
> > +                                 FIELD_PREP(BMA400_INT_DRDY_MSK, state));
> > +}
> 
> Ditto.

Sorry, I missed this.
I will add lock and unlocking in the next patch.

> 
> ...
> 
> > +       mutex_lock(&data->mutex);
> > +
> > +       /* bulk read six registers, with the base being the LSB register */
> > +       ret = regmap_bulk_read(data->regmap, BMA400_X_AXIS_LSB_REG,
> > +                              &data->buffer.buff, sizeof(data->buffer.buff));
> > +       mutex_unlock(&data->mutex);
> > +       if (ret)
> > +               return IRQ_NONE;
> 
> But here only above with locking...
> 
> > +       ret = regmap_read(data->regmap, BMA400_TEMP_DATA_REG, &temp);
> > +       if (ret)
> > +               return IRQ_NONE;
> 
> ...followed by no locking.

Okay I will add lock in the next patch.

> 
> ...
> 
> > +       mutex_lock(&data->mutex);
> > +       ret = regmap_bulk_read(data->regmap, BMA400_INT_STAT0_REG, &status,
> > +                              sizeof(status));
> > +       mutex_unlock(&data->mutex);
> > +       if (ret)
> > +               return IRQ_NONE;
> 
> And again with locking.
> 
> ...
> 
> So,
> 1) Does regmap is configured with locking? What for?
> 2) What's the role of data->mutex?

1.
NO, regmap is not configured with locking. 
In the regmap_config structure variable below these members are not defined
in the driver.

struct regmap_config {
	regmap_lock lock;
	regmap_unlock unlock;
	void *lock_arg;

2.
data->mutex is used to protect the register read, write access from the device.

Is the regmap functions handle locking and unlocking internally if these below
struct members are not defined?

regmap_lock lock;
regmap_unlock unlock;
void *lock_arg;


> 
> -- 
> With Best Regards,
> Andy Shevchenko
