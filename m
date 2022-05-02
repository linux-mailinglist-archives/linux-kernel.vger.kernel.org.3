Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F32DE516DBF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384345AbiEBJyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384506AbiEBJyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:54:32 -0400
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6ECE9;
        Mon,  2 May 2022 02:50:59 -0700 (PDT)
Received: by mail-vk1-xa2e.google.com with SMTP id m203so6360848vke.13;
        Mon, 02 May 2022 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=8YULF+fxOKmOE52wuF3ol0Q9fjUkUz1zoEFHGOF9cuo=;
        b=lVoM3WQCO0+G//fu2Z0qzV524H9UEtANF/OSLZa6sQNv4K88nZPVzVzKcSPPtuj8SJ
         a+TgwLcx3DC55l8J7ks2N5PGkqGWnlJitoOuvGEkobqUlMwDqYyiXxGORmAXGEheHPN6
         NX4rdvIsCOc5I+7HdQAv04bp831U4GXwhYnhWeTbSdpZUNYDs88Ry2TKhRY+hY1KAYj5
         N5NG+rejIoZIrch/PWQkHOuZJ/Px+nhE0lfKXQZ+3MvlOHFCtJ77Vgrg998zxid23uSA
         ik2/1kHM8mFd+cn74073PyvuE6/lBUeGXgLgMpb6ne69nwrNL1B2Ov2Fl+qP4BoJnhjR
         5SYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=8YULF+fxOKmOE52wuF3ol0Q9fjUkUz1zoEFHGOF9cuo=;
        b=CRr9TwJklmBqAx0rQXHt00p4VDEEWf5z3BOsUmqmQJT1sDSG+Z0Rc/dRLiAuhlMUSw
         +3J8WFAtted1/vwLbKcQN1+/xk05ikhn9uhD+O4wJ8ll/HaP1CAUt5OolxS04M/8AnS3
         34nq89FA1EktcXCHzKMs+qY1xf7yZKNeKBwLthfkcEgzNdzoAuG9TI4IlEWjs44qFcuL
         bpM/3bFP8HGdtcrA/K35Gngwd2yOpdQgXIHHBIh+JpiA2AzdUqkdaj/udnXwFZyi4asL
         LTh1009yNkglstAb7Ip8Kb92bUlXZH4aMieQxKLaQbwsE8d5tblibMBkwekg+0W+4H3Q
         TvvQ==
X-Gm-Message-State: AOAM5329iFcniNkEy9aoE++L0m5DONOIsYd7Fe+2X4i+AQ7mb0Y9Eru2
        /7jEPas9o9xuZUuL6PS1mwAZLLy0Au7np+c0DK0=
X-Google-Smtp-Source: ABdhPJxrFUbWdgIa7fx7MiqjHJ7xhid6w+XNRYzydGbUkY73XQyHuwZ7g8NEihfKdX5XVRf3dnWdLVJaSqmaz78WrUk=
X-Received: by 2002:ac5:c899:0:b0:349:33e8:d676 with SMTP id
 n25-20020ac5c899000000b0034933e8d676mr2918216vkl.0.1651485058811; Mon, 02 May
 2022 02:50:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220426131102.23966-1-andrea.merello@gmail.com>
 <20220426131102.23966-9-andrea.merello@gmail.com> <CAHp75VdLiBkg100UjFN36rW_vaOObOoJ_Mv9n=4LjSWb+dQWMw@mail.gmail.com>
In-Reply-To: <CAHp75VdLiBkg100UjFN36rW_vaOObOoJ_Mv9n=4LjSWb+dQWMw@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Mon, 2 May 2022 11:50:47 +0200
Message-ID: <CAN8YU5PzwmeQ9XA3qod7HejG6cCLCrPvda5eomCh5hUze_DWcA@mail.gmail.com>
Subject: Re: [v5 08/14] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
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

Il giorno mer 27 apr 2022 alle ore 15:23 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:
>

As usual, some inline comments. OK for the rest.

[...]

>
> > +#define BNO055_ATTR_VALS(...)          \
> > +       .vals = (int[]){ __VA_ARGS__},  \
> > +       .len = ARRAY_SIZE(((int[]){__VA_ARGS__}))
>
> Not sure this adds any readability to the code. Can we simply have an
> array of int for each case with the explicit ARRAY_SIZE() calls?

Do you mean moving the vals array out of the structs? Something like:

static int bno055_gyr_scale_vals[] = {125, 1877467, 250, 1877467,
        500, 1877467, 1000, 1877467, 2000, 1877467};

static struct bno055_sysfs_attr_aux_data bno055_gyr_scale_aux = {
        .fusion_vals = (int[]){1, 900},
        .hw_xlate = (int[]){4, 3, 2, 1, 0},
        .type = IIO_VAL_FRACTIONAL

?
But then I'd make also something like:

#define bno055_sysfs_attr_avail(priv, attr, vals, len) \
        _bno055_sysfs_attr_avail(priv, attr##_vals,
ARRAY_SIZE(attr##_vals), attr##_aux, vals, len)

And the same for all other users of those structs.

My point is not about readability, but about avoiding as much as
possible bugs caused by mismatched attr_vals, attr_aux and
ARRAY_SIZE() arg. e.g:
bno055_sysfs_attr_avail(priv, bno_foo_vals, ARRAY_SIZE(bno_bar_vals),
bno_foobar_aux, vals, len)

I used to make quite a lot of mess until I grouped all the stuff in
one struct :/

[...]

>
> > +       msleep(20);
>
> Perhaps a comment why so long sleep is needed.

DS says that switching mode can last from 7mS up to 19mS depending on
the case, but I don't know _why_ it takes so long. I may add a comment
that just states that it's a sensor requirement.

[...]

>
> > +       for (i = 0; i < bno055_acc_range.len; i++)
> > +               len += sysfs_emit_at(buf, len, "%d%c", bno055_acc_range.vals[i],
> > +                                    (i == bno055_acc_range.len - 1) ? '\n' : ' ');
>
> You may move the condition out of the loop.

May you elaborate, please? Do you mean something like: loop one time
less, and then call sysfs_emit_at() once more outside the loop,
getting rid of the conditional ternary operator at all?

[...]

> > +       if (indio_dev->active_scan_mask &&
> > +           !bitmap_empty(indio_dev->active_scan_mask, _BNO055_SCAN_MAX))
> > +               return -EBUSY;
> > +
> > +       if (sysfs_streq(buf, "0")) {
> > +               ret = bno055_operation_mode_set(priv, BNO055_OPR_MODE_AMG);
>
> return bno055_operation_mode_set(...);

Why? bno055_operation_mode_set() returns an error code, while here we
need to return the len, or propagate the error code only when it's the
case

> > +       } else {
>
> ...and drop this with the following decreasing indentation.

if you want to drop this, then I can just duplicate if(ret) return
ret; i.e. add it after bno055_operation_mode_set(priv,
BNO055_OPR_MODE_AMG); and get rid of the else branch (see above)

[...]

>
> Can be removed to group all related checks together.

I'm not sure what you mean here, but see below

> > +       if (ret)
> > +               dev_notice(dev, "Calibration file load failed. See instruction in kernel Documentation/iio/bno055.rst");
> > +
> > +       if (caldata) {
> > +               caldata_data = caldata->data;
> > +               caldata_size = caldata->size;
> > +       }
> > +       ret = bno055_init(priv, caldata_data, caldata_size);
>
> > +       if (caldata)
> > +               release_firmware(caldata);
>
> > +       if (ret)
> > +               return ret;
>
> Can be rewritten in a form of
>
> if (caldata) {
>  ret = bno055_init();
>  release_firmware(...);
> } else {
>  ret = bno055_init();
> }
> if (ret)
>   return ret;
>
> ?

Indeed I'd say it could be rewritten as:

        if (ret)
                ret = request_firmware(&caldata, BNO055_FW_GENERIC_NAME, dev);
        if (ret) {
                dev_notice(dev, "Calibration file load failed. See
instruction in kernel Documentation/iio/bno055.rst");
                ret = bno055_init(priv, NULL, 0);
        } else {
                ret = bno055_init(priv, caldata->data, caldata->size);
                release_firmware(caldata);
        }
        if (ret)
                return ret;
