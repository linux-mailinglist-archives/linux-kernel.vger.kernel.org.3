Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B56859CB45
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 00:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238249AbiHVWBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 18:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235796AbiHVWBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 18:01:42 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD85F474F3;
        Mon, 22 Aug 2022 15:01:41 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bt10so4177941lfb.1;
        Mon, 22 Aug 2022 15:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=dMleDmi8cDYPwG7g31q+GzjMNp7DXdwyOoOOOvnIB08=;
        b=XGklBEdd/czPgqVcfcb9DAU7otzBxODv2bDKtHK4dQmFsh6xqLvxkCiqvTOj9Re57w
         hUoAzID8mex5S9dEECpF2ZAof8FcHFuNRn6n7k8sWpnOhQGKlAAMOyUPREz0nfEDzik/
         Sn3RkOuW9ndxaHXmgwuhP5Kk3+N4+WWC+dW36cnJCzv2ADbgZDpFnsozQLtluK5jmK39
         j6fqQw479xME9+gIV2CxVhUjVzli/7Oik4kJPjmOXGcW/QxnGvIQUUcV4EC58QquFv44
         MnmRoq5hEHeu6gXe2C+8X6OxR+/Cb41dTPfpNoFFznkitBIfcO03goyTqVUh6kGqsq6B
         G7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=dMleDmi8cDYPwG7g31q+GzjMNp7DXdwyOoOOOvnIB08=;
        b=fqnOxfsJB7A3pdCrcmHqOwK9wzPwg1wv93tO+lfTTxcMfayRCsUDGO/ormgAQXkTwX
         4z3uJc/SpdgudSXCjDWLchp4rr+z/WwsrMgTDJhKoRQoH9nE31eWJf+BY/6OA3K2MOoa
         yyCF2nVpX1Se+xb/SiPUlPs0SG41Pq34oqidyastnHEi8/XtzDSV+PYVHm20VNdgq/7A
         MCIX4gMj/lBHP+tA83+I9NbD3Dsvof/wlRRJVRz70Am7kYbYeAsfYaTm+1+RdnxaYZdh
         PWEv+ldy8mgYZdBUBphYXTS+39/xHneY0qWm0xCw/eqMxVC7E2IFul9HmIo6Hz1vNHWY
         9C2Q==
X-Gm-Message-State: ACgBeo3I2TwrSe4p2eSDTV1YtRY/9EX6eh7xPoMEzKw+IbP62HqANjt+
        vlZFzjN+2mG+4c2NwlrOTMw=
X-Google-Smtp-Source: AA6agR5Q1DzxSxNGtMOUzvZv7yoHJpavYP8O075VngcOlmJIJX468efk6mDoqnTZz4jFHoKEVRXddg==
X-Received: by 2002:a19:6554:0:b0:492:e7d2:645c with SMTP id c20-20020a196554000000b00492e7d2645cmr1777073lfj.586.1661205699954;
        Mon, 22 Aug 2022 15:01:39 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id c20-20020a056512325400b00492e570e036sm651362lfr.54.2022.08.22.15.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 15:01:39 -0700 (PDT)
Date:   Tue, 23 Aug 2022 01:01:37 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: dw: Add deferred controller registration support
Message-ID: <20220822220137.nko7kznjae2ynm4p@mobilestation>
References: <20220822181853.23063-1-Sergey.Semin@baikalelectronics.ru>
 <CAHp75VefTEy7jFAFnZe5A+d+2+984RMRDqxtPDJnd+E+dbZw=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VefTEy7jFAFnZe5A+d+2+984RMRDqxtPDJnd+E+dbZw=w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 12:38:45AM +0300, Andy Shevchenko wrote:
> On Mon, Aug 22, 2022 at 9:19 PM Serge Semin
> <Sergey.Semin@baikalelectronics.ru> wrote:
> >
> > It's pretty possible to have the spi_register_controller() method
> > returning -EPROBE_DEFER status in case, for instance, if the GPIOs used
> > for the CS implementation aren't ready to be requested due to the
> > corresponding platform devices still pending to be probed. Let's make sure
> > the DW SSI driver won't print error message in that case by calling the
> > dev_err_probe() function if the SPI-registration procedure exited with
> > a non-zero status.
> 

> Shouldn't there be a Fixes tag?
> 

The dev_err-line has been there since the driver was born in commit
e24c74527207 ("spi: controller driver for Designware SPI core") ,
which had happened for several years before the deferred probe was
added d1c3414c2a9d ("drivercore: Add driver probe deferral
mechanism"). Moreover I didn't think it was that much critical to have
the patch backported since the discovered problem just caused a false
error message logged. So IMO the fixes tag wasn't that much required
in this case.

Anyway if Mark decides, that it still would be good to have the patch
backported, here is the fixes tag which could be added during the
patch merging in:
Fixes: e24c74527207 ("spi: controller driver for Designware SPI core")

> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Thanks.

-Sergey

> 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/spi/spi-dw-core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/spi/spi-dw-core.c b/drivers/spi/spi-dw-core.c
> > index f87d97ccd2d6..99edddf9958b 100644
> > --- a/drivers/spi/spi-dw-core.c
> > +++ b/drivers/spi/spi-dw-core.c
> > @@ -955,7 +955,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
> >
> >         ret = spi_register_controller(master);
> >         if (ret) {
> > -               dev_err(&master->dev, "problem registering spi master\n");
> > +               dev_err_probe(dev, ret, "problem registering spi master\n");
> >                 goto err_dma_exit;
> >         }
> >
> > --
> > 2.35.1
> >
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
