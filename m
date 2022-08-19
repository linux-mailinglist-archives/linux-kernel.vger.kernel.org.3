Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464D6599CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349222AbiHSNKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349189AbiHSNJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:09:57 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48D6BB0B2A;
        Fri, 19 Aug 2022 06:09:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id jl18so4119750plb.1;
        Fri, 19 Aug 2022 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=ZhIc7AHWs6TolGv7ptNGHz8X/1GYjP1SkCttgRV0pVY=;
        b=PuNM3Tg+4uenHJhvegb4YgH+gcFcr6+4bpaYZm65sIBq+Sd7hzLz/ZIZxQMaAX1NL2
         rqwU71HIBqQ3Yk8wR3+GD61Nrojt1nragOz0fNsGQh3kqTOOkRCaPvC0U4nQeBnVxP/h
         xgiIaGl09Bjwo52vxNpFu+jt1OpoyYVGUFOHYp5VuVzWEWf0AG1Oarc7t2iLggRvXSaX
         +RVRR+oRbiBhch46ecw61SYb8s8czXsSm6GG/dLvGhrftyeJ9bdUI+x7O7DIVV/1YG9c
         e5j4NTHPcYxi4375hyzdfdv78PmremVOu5/e9yIsXyZzwVHbUuHJq3wIZ7GDjrsPFTK6
         ovrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=ZhIc7AHWs6TolGv7ptNGHz8X/1GYjP1SkCttgRV0pVY=;
        b=uYHd7mYuGTNFwP36xUvidn3/RYbrDdGhNKyj1m02RR4GJKSr7+/PeyYe8mG2c++H/x
         /TYXiPA0Da6L3eSneYLW+PiocI4RjA/EASStMWnG4oRQgpIv8ajmJhy7YMVzh3txDy0o
         JCHhrk18FB969pXNAxyDEagXbN5u0djeM6wdEEkgwWz5RIu47gwm9ktTKsjbLBtG9scx
         A6O6ap9fVTaQOTBqK3P1zH14p0VcW2i96kaGurm+ACJ1kWkbpKhHHUxBOcBJaFVKm0Ot
         p/1gsH7bQRNJjrr+edweRjTmTcsZtM1VysOP66zOj+SOzi1cBlGO3q9Kwr6fWB+QxmrS
         AjFQ==
X-Gm-Message-State: ACgBeo1sQ57tkpXQFI6169C6Yv7+7/6D2kPaG04L7wQs+4LERcgxtFN9
        tP+ugUETpuvLghGqWjNKcLTK3Sympn0=
X-Google-Smtp-Source: AA6agR7DlvlfFHUlvVO3s3Dxrwkj94T4Ll/CmH3IyT3qvhJ1bKXHFfQsgkCp3dMcvmYVFA/c6c/Lfw==
X-Received: by 2002:a17:903:124f:b0:171:4c36:a6ab with SMTP id u15-20020a170903124f00b001714c36a6abmr7440214plh.141.1660914596755;
        Fri, 19 Aug 2022 06:09:56 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bg8-20020a056a02010800b0042a59ecdbdfsm339735pgb.84.2022.08.19.06.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 06:09:55 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 Aug 2022 06:09:55 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v1 1/3] hwmon: (pwm-fan) Make use of device properties
Message-ID: <20220819130955.GB3108215@roeck-us.net>
References: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
 <20220818232040.GA3505561@roeck-us.net>
 <CAHp75Vf+-4U6OW4sf+mKsPt8WoRL_jN-sYtzOMzhhH8--+OU1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vf+-4U6OW4sf+mKsPt8WoRL_jN-sYtzOMzhhH8--+OU1w@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 12:56:42PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 19, 2022 at 2:41 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Sat, Aug 06, 2022 at 06:25:15PM +0300, Andy Shevchenko wrote:
> > > Convert the module to be property provider agnostic and allow
> > > it to be used on non-OF platforms.
> > >
> > > Add mod_devicetable.h include.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >
> > I had another look at this patch. A substantial part of the changes
> > is because device properties don't support of_property_read_u32_index(),
> > reworking the code to use device_property_read_u32_array() instead.
> > Sorry, I don't like it, it results in a substantial number of unnecessary
> > changes. Device properties should support the equivalent of
> > of_property_read_u32_index() instead to simplify conversions.
> 
> Not all (device property) providers can have such API available. Are
> you suggesting to
>  a) alloc memory for entire array;
>  b) cache one for a given index;
>  c) free a memory;
>  d) loop as many times as index op is called.
> 
> Sorry, this is way too far and non-optimal in comparison to the
> substantial number of unnecessary changes (two or three small
> refactorings?).
> 
> Another way is to provide a pwm-fan-acpi, which will be the copy of
> the driver after this patch is applied. I don't think it's a very
> bright idea either.
> 
An alternative might be to split the patch in two parts, one replacing
of_property_read_u32_index() with of_property_read_u32_array() as
preparation, with the above rationale and a note that this is to
prepare for the switch to device properties, and then the actual device
property switch. Some context showing how other conversions handled this
problem would also be nice, though not necessary.

Thanks,
Guenter
