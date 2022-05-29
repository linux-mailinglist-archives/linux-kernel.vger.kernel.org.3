Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4546C536FC2
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 07:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbiE2FWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 01:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiE2FWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 01:22:14 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0DF22535;
        Sat, 28 May 2022 22:22:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id u12-20020a17090a1d4c00b001df78c7c209so10542161pju.1;
        Sat, 28 May 2022 22:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i9Ns75XzJ2Va1ZDogag5Rg93i8Iff+qI4w13+OQhT+A=;
        b=nspM9nRcFx4OsmLzgMA7ZyD8LHHJIACZQkfInjNUQ/F7xWDfwskaQX+27vCeAr4zQX
         ECj+MO2tD/u367ayEiF+cOL/OZAEO9A9rb04LWb24GZt8Qb2BiOFzlrJzG4o40n4Irrq
         eAxHcvBtlHIFZS4853yVjTN5DIIsJlN9ovzeD45+DKiCTlhxlHpBDEdHqIE+CvQEvzsF
         Y9HbDiI7aj/zRaoyPZIQhIp6wA94EDHzZFalpgRILuV5rpwOJGITLhTN4/6ZD7nmugbn
         WBd661tz0l6isSiFiJgZ3q/i0c7Dqvv+SIvP7unkEtUp7XKj5jF3nwtq7DNphlp3OuBT
         cHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i9Ns75XzJ2Va1ZDogag5Rg93i8Iff+qI4w13+OQhT+A=;
        b=RHaXjIywC1WgJ3Sc0qb1eFrOvwsd28SSXaOhb2UZGMW1xXVaOcvKldHVSnR4YDcS/H
         UH6mFmuafnJb+mAl1KVVR4j0h+XxXUlh5XQ26+DYeIWYJDL8g0mbkDKuOPHzYtNtlKcZ
         gLE0JBxhOOr3zIRSX/ElaBNxonfhqh1lA5RnRy+KWkWRuPDkM5Q4kcNauUoZFvaP1ycG
         0VKXW+FqT820bhVmtzwFmR/3xq9IOgdlO4sACz3cgNMoGP56CN0qEWx2Tz15LJNl0dmx
         u6nANS1GjgHOefpTw+xAxD4yBzG9qvFdqcKIHvPPFMPEysaipYZsXRTPFib7hTkQ1puJ
         wA9A==
X-Gm-Message-State: AOAM533Alsyz4/hiXBc580f+OELOGsvvN6tnx0Kmfh3HQLbZ5MmHX3vq
        +I0KxdMPqfXRg6wxJ/uFJqChAsEJRXM=
X-Google-Smtp-Source: ABdhPJwifhmkw727xZb0XSP8glilE6iyvfShBbRpAwFGomWtoZJhDn8oDdTjUFjLeatQMDQVV2hl/A==
X-Received: by 2002:a17:90a:5792:b0:1e0:63f3:b3ba with SMTP id g18-20020a17090a579200b001e063f3b3bamr16491915pji.102.1653801731827;
        Sat, 28 May 2022 22:22:11 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:781a:4ab0:a93b:176b])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709027ed600b0016399d50df3sm4395626plb.281.2022.05.28.22.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 22:22:09 -0700 (PDT)
Date:   Sat, 28 May 2022 22:22:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] Input: adp5588-keys - switch to using managed
 resources
Message-ID: <YpMC/90883D286nG@google.com>
References: <20220528045631.289821-1-dmitry.torokhov@gmail.com>
 <20220528045631.289821-3-dmitry.torokhov@gmail.com>
 <20220528193755.lncxrpgmyiy4hprm@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220528193755.lncxrpgmyiy4hprm@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 09:37:55PM +0200, Uwe Kleine-König wrote:
> On Fri, May 27, 2022 at 09:56:30PM -0700, Dmitry Torokhov wrote:
> > This simplifies error handling in probe() and reduces amount of explicit
> > code in remove().
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/keyboard/adp5588-keys.c | 111 +++++++++++---------------
> >  1 file changed, 45 insertions(+), 66 deletions(-)
> > 
> > diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
> > index ac21873ba1d7..df84a2998ed2 100644
> > --- a/drivers/input/keyboard/adp5588-keys.c
> > +++ b/drivers/input/keyboard/adp5588-keys.c
> > @@ -182,6 +182,21 @@ static int adp5588_build_gpiomap(struct adp5588_kpad *kpad,
> >  	return n_unused;
> >  }
> >  
> > +static void adp5588_gpio_do_teardown(void *_kpad)
> > +{
> > +	struct adp5588_kpad *kpad = _kpad;
> > +	struct device *dev = &kpad->client->dev;
> > +	const struct adp5588_kpad_platform_data *pdata = dev_get_platdata(dev);
> > +	const struct adp5588_gpio_platform_data *gpio_data = pdata->gpio_data;
> > +	int error;
> > +
> > +	error = gpio_data->teardown(kpad->client,
> > +				    kpad->gc.base, kpad->gc.ngpio,
> > +				    gpio_data->context);
> > +	if (error)
> > +		dev_warn(&kpad->client->dev, "teardown failed %d\n", error);
> > +}
> 
> I think the more sensible approach is to drop support for setup and
> teardown. Maybe even rip all usage of adp5588_gpio_platform_data.

That will come with the transition to device tree/device properties. For
now wanted to keep existing functionality intact.

Thanks.

-- 
Dmitry
