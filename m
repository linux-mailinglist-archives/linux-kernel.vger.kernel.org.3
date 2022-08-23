Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B73259E9EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbiHWRiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiHWRho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:37:44 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058D457557;
        Tue, 23 Aug 2022 08:22:34 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id de16so8419777qvb.12;
        Tue, 23 Aug 2022 08:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sclchRzcrlNQs45AXkw2Ui5z8V3RvXBbErHU2RT3Jyc=;
        b=Fd1M7NIx0fmqMelKHydncaohrBxDgDyRoxFLWtM/Wcx47NqCJ87JIiqphh2yfkYjhf
         G0Ye9hTNDWFqet2D4lkYBjGZjU/yKaQB8FAy8V2uYZ+6J8c+mC/LR2Gcjo5rbScSZc8G
         VPHjMYv73frrlmAnT+6puQRQUwucw+Us4XipM5mooYcNTnD4FQZIWZ5xhiIt7B3TTmTb
         /h2Hmo1nG07nVPCSy2bLCmAshO5h3TdXEPXcLIOt3l/tFxJZlPidDPEPlxLd4tm3Lp55
         CMMukJ9/Rerk3acbiVuYJe+mPbKzxp1zB6ymhOKVa7+70DKgh0iL4rXxFu+2EocfpTnQ
         h2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sclchRzcrlNQs45AXkw2Ui5z8V3RvXBbErHU2RT3Jyc=;
        b=2iazlj35Wa5VVtX9C9IYDZhoRtGQQ0zl5Mm1Vb11jDEyzd1kD+ymu4B/3enNJvf0xs
         js5ICwBgo/p/XuMkV2GZ9yYvmPUgtqofjflx9veUh0BO/MJTuE1oVGEo3/wG3aQr8p03
         iGk9jOi7NOON8qpCg+3tSrpaHhVNlhHxRvPEonoSs4RFNVPruds4noM5Cc/RKA9VLzAK
         X4IoR6yewbr6Qi2alT1Y5yertb5d8E1GZ7Y3AUt4nQWmFbfDObf7oJxYkmSWbkW95BdM
         LAHclNYUgsvuAZ5QVsNzNVaZhufeIk5zN5a4WVZeeL9Agdtvc5cAEOb2s8l63wSeFVJ7
         2B5Q==
X-Gm-Message-State: ACgBeo1J3sGGZ2X51hoQoOIT3V0hFpwu6Cq9S51p4DjgQ4RIGWYcdoKR
        OeV3C3/0VyVnfzgLJKin/ssmjN8ZCRVdlES+MQy/F63UioQ=
X-Google-Smtp-Source: AA6agR74s+Gdg75WX6h7niZAF5Whw1Aq2qTK4qGPDGrfUUokxr9hUNcPXbblY5QyY8JHU24hHN1hoGHmAnWBxe5P7Kg=
X-Received: by 2002:ad4:5baf:0:b0:476:6a9e:b5e1 with SMTP id
 15-20020ad45baf000000b004766a9eb5e1mr20073228qvq.64.1661268153078; Tue, 23
 Aug 2022 08:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220822125106.1106798-1-ciprian.regus@analog.com>
 <20220822125106.1106798-3-ciprian.regus@analog.com> <20220822203731.29c4c33b@jic23-huawei>
In-Reply-To: <20220822203731.29c4c33b@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Aug 2022 18:21:56 +0300
Message-ID: <CAHp75Vft2pvXtxZcpvyV38cR9gOdDxDfCae8g5Uf2q6npWpb+Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] drivers: iio: adc: LTC2499 support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Ciprian Regus <ciprian.regus@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
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

On Mon, Aug 22, 2022 at 11:13 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Mon, 22 Aug 2022 15:51:05 +0300
> Ciprian Regus <ciprian.regus@analog.com> wrote:

In reply to Jonathan's comments to answer his question and add more
comments from me.

...

> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/2499fe.pdf
> >
> > Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>

Tag block mustn't have the blank line(s).

...

> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/driver.h>
> >  #include <linux/module.h>
> > +#include <linux/property.h>
> why?

device_get_match_data() requires it.

But why not sort them?

> >  #include <linux/mod_devicetable.h>

...

> > -             *val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
>
> Old code here is less than ideal, should be reading into 3 bytes then using
> the be24 accesors. Please fix whilst here.  You will need multiple paths here
> depending on size.
>
> > +             *val = (be32_to_cpu(st->buf) >> st->sub_lsb) -
> > +                     BIT(ddata->chip_info->resolution + 1);

Shouldn't this use some kind of sign_extend()?

Also with a temporary variable for chip info this line can be single.

   struct ... *ci = ddata->chip_info;

   ...BIT(ci->resolution + 1)

...

> > +     u32 resolution;

Keep this in a way that the "longer lines go first".

...

> > +     resolution = st->common_ddata.chip_info->resolution;
> > +     st->sub_lsb = 31 - (resolution + 1);
> > +     st->recv_size = resolution / BITS_PER_BYTE + 1;

BITS_TO_BYTES()

...

> >  static const struct i2c_device_id ltc2497_id[] = {
> > -     { "ltc2497", 0 },
> > +     { "ltc2497", TYPE_LTC2497 },
> > +     { "ltc2499", TYPE_LTC2499 },

Use pointers here like you have done for the OF table.

> >       { }
> >  };

...

> > +enum chip_type {
> > +     TYPE_LTC2496,
> > +     TYPE_LTC2497,
> > +     TYPE_LTC2499

Keep trailing comma.

> > +};

-- 
With Best Regards,
Andy Shevchenko
