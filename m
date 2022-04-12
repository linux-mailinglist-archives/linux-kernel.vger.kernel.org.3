Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF9A4FDC4E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358050AbiDLKS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377981AbiDLJ7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:59:31 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217222459A;
        Tue, 12 Apr 2022 02:04:34 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g18so11036071ejc.10;
        Tue, 12 Apr 2022 02:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f4TT5UNx0Yp4KH9JbPXFXmqbUuY1CSYFdDKxg9p57+A=;
        b=U408lcUsREqvC9m5tjgQTjVsRQ8rISKj5W0oOD4KR2hYVh3mqH9z27TIa7zKe3/TEg
         8m2Lk6YHPXLwXPYwZ8T/KTxupmNo5JHVfPYrN9RFo+eyaJNNYY406RSYIP5Fos3lAREO
         WGvrRld04QWHdnu8tV20TWgQVwv03wwrenE8S6H+YfBXzQH5MdkTJY8/ue3cbaQIM26J
         qV4TXlBSq/dDF9cViqG3WzxpI/CHWKEQcdB7EfrgWZi7apP6zLvIRlA1viSennKoVnJu
         Hj5+rOypZAJ8MfQbk1tVHcmZx6Cwf1fZv3faXVflbijElwJVA8PK3K5No1gjoSjbRdIT
         kqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f4TT5UNx0Yp4KH9JbPXFXmqbUuY1CSYFdDKxg9p57+A=;
        b=McPf55snahNN8hLY5pThN0YuSVW2zzZAXLZWZI2bUS2AYiYT7RVW4ND0kWYZpq8G1g
         cl42ezYPocmsXfEbixXVff4Xi0wIiKzOnlOY3IU28cUI3A4wuZFQwun5J52si+XDs31a
         R3eWs9NWwKBrli1Oq7riAkSyFUjQxI/uV/XtWa9OMfRutGWGDOuqRvySBz2YEW9eaUT5
         UlhNoKBtWMPZ/nbN6eznDWiy2thx+JQnEDAtcKV5MTNo9Ts2Kp/pRLUDqFQLMPhqB3wB
         Oz+OeYDLWoMMNa7MdSmjiez6/EIf6g9lcS95FP6zq0CFrbudpex7UEoik0TEIfCE4A+3
         UM4w==
X-Gm-Message-State: AOAM5317h7eEOwgi6KGI4mRL3zIvS4o5PPRdYXtSTm7l6QnPs8rLUcbQ
        RZexL7PXMko4jaUrK0pz+ltdCwoOm3ojy+Wp09c=
X-Google-Smtp-Source: ABdhPJwAH4rYf0R00Q9mwzIjwKxvRb/xsB9qmIUj9JIDX4daESQdjEk1SnLk/g1Ki/9AJI52sHf/IdYsCDt4O1TYDEQ=
X-Received: by 2002:a17:907:628e:b0:6d9:c6fa:6168 with SMTP id
 nd14-20020a170907628e00b006d9c6fa6168mr33634475ejc.132.1649754272722; Tue, 12
 Apr 2022 02:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20220411203133.19929-1-jagathjog1996@gmail.com> <20220411203133.19929-3-jagathjog1996@gmail.com>
In-Reply-To: <20220411203133.19929-3-jagathjog1996@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Apr 2022 12:00:20 +0300
Message-ID: <CAHp75VeUit2_b75vuBDKToEENsMeO7Q7Joi5edhfT2UVW0zjRw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] iio: accel: bma400: Reordering of header files
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 11:31 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
>
> Reordering of header files and removing the iio/sysfs.h since
> custom attributes are not being used in the driver.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/accel/bma400_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/accel/bma400_core.c b/drivers/iio/accel/bma400_core.c
> index 043002fe6f63..25ad1f7339bc 100644
> --- a/drivers/iio/accel/bma400_core.c
> +++ b/drivers/iio/accel/bma400_core.c
> @@ -13,14 +13,14 @@
>
>  #include <linux/bitops.h>
>  #include <linux/device.h>
> -#include <linux/iio/iio.h>
> -#include <linux/iio/sysfs.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>
> +#include <linux/iio/iio.h>
> +
>  #include "bma400.h"
>
>  /*
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
