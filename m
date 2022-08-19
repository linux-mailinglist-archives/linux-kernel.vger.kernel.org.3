Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E7159A987
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241663AbiHSXdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240543AbiHSXdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:33:00 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CB3114A5C;
        Fri, 19 Aug 2022 16:32:59 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id i67so2957627vkb.2;
        Fri, 19 Aug 2022 16:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=8Ftt3u2zVCJ1XlR/QC6Ig2RR9m+8QvnAb/eHfD5q1ag=;
        b=eo8bqwAPmtSdzpfC2DXbNh1J+I4B3JgMZPZGvQwqJZ8zZiILLZeVZxbp+nNPCMQgir
         ND29DitHrMJ5vWipZ//ZPEFizYP6eeFn/DiDdrGg26CZgXcvLA5j9Ho1GTHzhZ3t7oE/
         luOF4fjMXtVJfi6YzE9a+DljBgBmoaUjqr2KlVEzzppf9JjF3cZlhZmh/vGq5IkcfnLj
         XfGp407fNCISq1mZdY79HdDwvNEm3o6fg8NwGfoAUDlzbAzu3EXnYacVWVN3XYTruSi3
         yRvda0WWPHy0zxa7c2Fm/RjxoFZS0HwBAL9/nxZVcMgSdywfaH3wZjxC3J7qQVyB3Wn/
         8pRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=8Ftt3u2zVCJ1XlR/QC6Ig2RR9m+8QvnAb/eHfD5q1ag=;
        b=m7fw3visih2cB3/NcyKErXYIwXNaGIO3i68WqwLKzwn0zQtedodzegUSpmikgPr7JI
         9tEgPKMoKD+S0TzjOdG/ishXb6E3ZQuGW8STj6SQ0M/d9vfFHSVVQw4vFlFnIWAgnk7o
         hJNMAYRvwgpdUmyt9jm2z1CHw8J/9C7udYqW6h7mwLXCJOcsr2z1/Z4h4IEa/ESe5xR1
         +IUfWm2M5/o5KnfCpjraoAWETeGCuJ7pQKTwYvCw6cp1w9dJ4R6DHsENynqMFRV06CIj
         T5wAYbbUdkxJEbWXL3Jh2Jth1I3/Lkb6f0yxNiUUPFM7uEfcefDhh1cX8pBLJNZxPLp3
         Reqg==
X-Gm-Message-State: ACgBeo2qCKPU2Z/vdHwRgXTBpJtkGSMg9oISfWkVFVlzx5FKFDAK+PF+
        eodEyqbwMZD8HpR8vEpjG8JM9mlDqFYiuR6NUIA=
X-Google-Smtp-Source: AA6agR6eJaaqNg8VDsxPvmfVCSoGG2OIUBTxkWbH6MePnRJAOqSfJjo7UZdduGoUilT7hODPdRuYkkP+jlm7KDQsFVY=
X-Received: by 2002:ac5:c7d7:0:b0:389:61cd:ac2d with SMTP id
 e23-20020ac5c7d7000000b0038961cdac2dmr1482277vkn.27.1660951978768; Fri, 19
 Aug 2022 16:32:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220806152517.78159-1-andriy.shevchenko@linux.intel.com>
 <20220818232040.GA3505561@roeck-us.net> <CAHp75Vf+-4U6OW4sf+mKsPt8WoRL_jN-sYtzOMzhhH8--+OU1w@mail.gmail.com>
 <20220819130955.GB3108215@roeck-us.net>
In-Reply-To: <20220819130955.GB3108215@roeck-us.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 02:32:22 +0300
Message-ID: <CAHp75VetU7_sJ-n6UHgFE+NU56t2Gw83x9E+OHETZkyxyF1qBQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] hwmon: (pwm-fan) Make use of device properties
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pwm@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 4:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Fri, Aug 19, 2022 at 12:56:42PM +0300, Andy Shevchenko wrote:
> > On Fri, Aug 19, 2022 at 2:41 AM Guenter Roeck <linux@roeck-us.net> wrot=
e:
> > > On Sat, Aug 06, 2022 at 06:25:15PM +0300, Andy Shevchenko wrote:
> > > > Convert the module to be property provider agnostic and allow
> > > > it to be used on non-OF platforms.
> > > >
> > > > Add mod_devicetable.h include.
> > > >
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > Acked-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> > >
> > > I had another look at this patch. A substantial part of the changes
> > > is because device properties don't support of_property_read_u32_index=
(),
> > > reworking the code to use device_property_read_u32_array() instead.
> > > Sorry, I don't like it, it results in a substantial number of unneces=
sary
> > > changes. Device properties should support the equivalent of
> > > of_property_read_u32_index() instead to simplify conversions.
> >
> > Not all (device property) providers can have such API available. Are
> > you suggesting to
> >  a) alloc memory for entire array;
> >  b) cache one for a given index;
> >  c) free a memory;
> >  d) loop as many times as index op is called.
> >
> > Sorry, this is way too far and non-optimal in comparison to the
> > substantial number of unnecessary changes (two or three small
> > refactorings?).
> >
> > Another way is to provide a pwm-fan-acpi, which will be the copy of
> > the driver after this patch is applied. I don't think it's a very
> > bright idea either.
> >
> An alternative might be to split the patch in two parts, one replacing
> of_property_read_u32_index() with of_property_read_u32_array() as
> preparation, with the above rationale and a note that this is to
> prepare for the switch to device properties, and then the actual device
> property switch. Some context showing how other conversions handled this
> problem would also be nice, though not necessary.

Thanks for the idea, I like it and it would indeed simplify the
understanding of the changes made.

--=20
With Best Regards,
Andy Shevchenko
