Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71045462A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 11:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245131AbiFJJjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 05:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240143AbiFJJjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 05:39:35 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577AD2DD45
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:39:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id w20so20294332lfa.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=nV43jtmwHVhNIUIwHqbPqyXT6AOAMyWo/9t3uutR0Qo=;
        b=PAtECZypcteP9uwJWi2omhMCe2W0JP5ojEDBSMhWtPUuUP/W5gFWYqDgst1QrGIzrZ
         Oes9uDu6/m5HC6eqRgievAxVNYETDEdTAtXk6RP1ts2F5VWj9RVslkuah88dkD1mrsy9
         tjbWGNBxmjO9v0voDhV0bUBdcO8Tj8kvJ2slrW8onbIRu0VrhWBc8yRr0ghCEeriZ/NN
         veXTvGvDdaULdMdqMh4pzHkGz6ZnoIUneq5Vvf1VcNJPKRPXPlwte59hT3n3KS/XBa5c
         GGAzX4GUcTtOAbkwKIGpAXUMq9rT8Z+VThb6/X4UKr97n4BJovWcczY1JX60zRQTE47J
         9iYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nV43jtmwHVhNIUIwHqbPqyXT6AOAMyWo/9t3uutR0Qo=;
        b=jIONh74p327DYAZItKrog7ORIM1JPxyQIF+A0e6fBhxOWpQ7LEKeJ4M54n4dMHwar2
         OANv78Qu7T3kWIWx16Fz+oVk54P3m+J/0aSOuAjwitT/zPJj9oVQKcpXa0AtkXG6IPiu
         2T1uzKddy+7H7mgZBXqI/2EcaTHPYYsMf2WqK5K6iMItuXbOxVine9E/SnmRaU9bzclP
         EpBnf7fcyDn0f0+t2mdoMlu3jaPLPARuYGLZ64rlVoG5zppGJXOQOUeAhZfHHsLAHbGw
         CbqZ/sFuI+iH8r5sKKjT7w0/2r1+OZg/FKa/yBjq9+/8EpodIHxCn98I8wdU3vyMDcPt
         f/RQ==
X-Gm-Message-State: AOAM5315GL2qqZskiFWRrG5yHQX8vRV8eXtWEvPMfV/BFVJOgURvT4sU
        HsQYVn2JYu9N1eD5K5iIF3o=
X-Google-Smtp-Source: ABdhPJzhfuW5XdHCCRPubLqs1LoFsN2HHa+bDTgi7nPzDkZ8jaCdbntBg6Vboo4kR3OSwudczJn+0Q==
X-Received: by 2002:ac2:4c48:0:b0:479:4fdc:2c70 with SMTP id o8-20020ac24c48000000b004794fdc2c70mr13827925lfk.295.1654853968748;
        Fri, 10 Jun 2022 02:39:28 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id n8-20020a056512310800b0047906bad093sm2387841lfb.173.2022.06.10.02.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 02:39:28 -0700 (PDT)
Date:   Fri, 10 Jun 2022 12:39:26 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        soc@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bus: bt1-apb: Don't print error on -EPROBE_DEFER
Message-ID: <20220610093926.xgy5pd5wep3hrakl@mobilestation>
References: <20220610080103.10689-1-Sergey.Semin@baikalelectronics.ru>
 <103fdfb5287a29fc229a734a40c3bcd3b373037f.camel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <103fdfb5287a29fc229a734a40c3bcd3b373037f.camel@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:35:36AM +0200, Philipp Zabel wrote:
> Hi Serge,
> 
> On Fr, 2022-06-10 at 11:01 +0300, Serge Semin wrote:
> > The Baikal-T1 APB bus driver correctly handles the deferred probe
> > situation, but still pollutes the system log with a misleading error
> > message. Let's fix that by using the dev_err_probe() method to print the
> > log message in case of the clocks/resets request errors.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > ---
> >  drivers/bus/bt1-apb.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/bus/bt1-apb.c b/drivers/bus/bt1-apb.c
> > index b25ff941e7c7..ac13b5b97107 100644
> > --- a/drivers/bus/bt1-apb.c
> > +++ b/drivers/bus/bt1-apb.c
> > @@ -176,7 +176,8 @@ static int bt1_apb_request_rst(struct bt1_apb *apb)
> >  
> > 
> > 
> > 
> >  	apb->prst = devm_reset_control_get_optional_exclusive(apb->dev, "prst");
> >  	if (IS_ERR(apb->prst)) {
> > -		dev_warn(apb->dev, "Couldn't get reset control line\n");
> > +		dev_err_probe(apb->dev, PTR_ERR(apb->prst),
> > +			      "Couldn't get reset control line\n");
> >  		return PTR_ERR(apb->prst);
> 

> This could be shortened to
> 
> -		dev_warn(apb->dev, "Couldn't get reset control line\n");
> +		return dev_err_probe(apb->dev, PTR_ERR(apb->prst),
> +				     "Couldn't get reset control line\n");
> -		return PTR_ERR(apb->prst);

You are absolutely right. Thanks. I'll fix it in the v2 in both
patches.

-Sergey

> 
> regards
> Philipp
> 
