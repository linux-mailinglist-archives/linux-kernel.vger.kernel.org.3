Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DBB59AEEF
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 17:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345668AbiHTP5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 11:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbiHTP5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 11:57:35 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D8C3B954;
        Sat, 20 Aug 2022 08:57:30 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j6so5193574qkl.10;
        Sat, 20 Aug 2022 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=OI+dqN8FSTO1y8Wkg3T+b9ezzNniW+aOx+jdGzhafCA=;
        b=XrQWGLC9R2rUxelr5BkTZPjv4kEimI4FNkm2IeskGCjlAXEQoi6LLP2JeCL++OuIrl
         GWzZvATJcNOvWpTkq4RYUvh0tLPpqgKAc1KrWgvz3B8G3gdjy7kdVg/st/Di0J9Hzz2A
         gS3N3tKQ8eXz2Ub/Qf8u+GU86WLRARGcNa2/0eYKhrWqwZlBJJaRa6MNYj4zHpIY4O34
         SeVGIzZAOg4B3VjNfrdhTTj9Ng51/aTh5Tj/iDsAKR6EmdrFy82mw4WwbilYU9ULxfN3
         /1QpstHu4Q19zbec8chKWYy1ITmEMs6DeBb5X8iz9wM+S2bXHQEyhjqyyqVXeYL9gpna
         GXJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=OI+dqN8FSTO1y8Wkg3T+b9ezzNniW+aOx+jdGzhafCA=;
        b=A3ZVq+4SgA1CjQhThTdn/3HZGymN/YIkSXKs9AThMYVkZLBIXU3nHwSfpWSJ5T/AfI
         lM2E0jWE/nC/D3j2pvecfn6cKxUsCK3W03BEdBea7011xJuHPrUSZM4l8RGA1G5Q9Pus
         Mlyyh/0GiMBFI+h5fMZxHWyNAtdIfNKdVxXYG2OThO8IMwT60zwKttKTRwcLe+QFh37A
         sWNdrYjPSBvaHEhM6Fjfvvyg7i5QRfotX7YOcura0HusS81LM8IM3e1zYu8AGLV+NF5/
         dCg+Oebp0IrJOEZSJTYwjxQPCthqpD+LpvUkeCHpHyAIaStGvkRR3RFX7JPHbRZZkFUM
         u63A==
X-Gm-Message-State: ACgBeo18FtJMJACU8JYeFH5mEs2Lz4FxrCWSURMuTCQ1Q0lE2eOzqVY/
        x3jDrYr6aLE7rzdLUesGurhUlsUPdnJK6aNgddA=
X-Google-Smtp-Source: AA6agR4ZwxbJ82YOdzA4NzcqTs/vinKtJS9xYWjh/BMJKbDlU/RtjoYDETwEZCPm2DfC5kxSiE8kU1nQPmadadFkAQs=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr8270445qkf.320.1661011049777; Sat, 20
 Aug 2022 08:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220819104117.4600-1-antoniu.miclaus@analog.com> <20220819180856.5a1d4e5a@jic23-huawei>
In-Reply-To: <20220819180856.5a1d4e5a@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Aug 2022 18:56:53 +0300
Message-ID: <CAHp75VfQY_7WQZTxGG17Ps=VHGrnGdUAdRpacPYeJEMK5PS6yA@mail.gmail.com>
Subject: Re: [PATCH] iio: frequency: admv1014: return -EINVAL directly
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
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

On Fri, Aug 19, 2022 at 8:41 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 19 Aug 2022 13:41:17 +0300
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>
> > Remove extra step where the error code is assigned to the `ret`
> > variable.
> >
> > Return instead error code directly.

...

> Change is fine, but I've dropped the fixes tag. The code before this
> wasn't broken, just longer than it needed to be. We don't want the noise
> of this getting backported because someone sees the fixes tag and thinks
> there is a reason it needs to be.
>
> Applied to the togreg branch of iio.git

Haven't checked myself if it's possible, but shouldn;'t we go further
and return dev_err_probe()?

> >       chip_id = FIELD_GET(ADMV1014_CHIP_ID_MSK, chip_id);
> >       if (chip_id != ADMV1014_CHIP_ID) {
> >               dev_err(&spi->dev, "Invalid Chip ID.\n");
> > -             ret = -EINVAL;
> > -             return ret;
> > +             return -EINVAL;
> >       }


-- 
With Best Regards,
Andy Shevchenko
