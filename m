Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4034E324C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 22:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiCUVWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 17:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiCUVWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 17:22:25 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BAA1AAFCC;
        Mon, 21 Mar 2022 14:20:18 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id mj15-20020a17090b368f00b001c637aa358eso592115pjb.0;
        Mon, 21 Mar 2022 14:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mUKC2d+rgbadrMqKVzRP63ji1CbU8Dtk3LjZqErXfOE=;
        b=M1cz0oNp0VZNd+EWrU5eo3Q9CNpBY6GlvjuOPjo7UNwwLLiok+jLmS1d/4hoTj9MHm
         ql25H9sfRQ0n6q2e7wgqPMNlcr8T4Ra3okSeFY8ezPCqAcLO+9sSkslmQDRDAggYzRhj
         gdsu45gccbRrFNc6/4mGVBGNKlWK0vdVbANxZpbEqQKfSAtkmB9cKHQpuMJQ4uERAWs/
         sH480/8jecHqQX5ikXdo+NC/BEQ4z1k3OrFpTLCXMMaDyc1V59TnkXgHfJ9eELnUmxUn
         7PQ73ETbMrhi0IM9DiyeDi8UdpRwEYehpaywLb6kFSWGLqWk3YW2+LWpS3zP+bc+93yL
         eFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mUKC2d+rgbadrMqKVzRP63ji1CbU8Dtk3LjZqErXfOE=;
        b=2NNpSFN54I3nJnzmaPWgzFLiFM68e+nvwcGeGl0TWc4YeP1nn6OHmLXDGh+A+AMDvA
         TyiN0BEWVUQpPHeo1QLAnro7o+97X6sUFUEdbduPV1ZC+bnnSc3MkSnDX9BqpKBkSgk+
         bUCmC01MkhhxDZrLMbz4apaCVP/7xrx/aQzyFb/mwiuS2JzW5FUELchfGLV7yaH1jxVw
         OJGXv0D1Ng1IxsIgM40GArbAfX+pzLIEeyPmN2l19p5mrtbrNXq81l7eAz9PtZUOWTOc
         OC08o7rkCsdZ915S1Fdo+g4Jm7/Y1jFZtN9BvWms9Q8OnVVYi4gVZaxlkZ7812q9PWy5
         eqfA==
X-Gm-Message-State: AOAM5305Ej4WVyBsB/FRau3uxemW/+X4OgQubHvZuSMy1uGvXoSsIZ/W
        AeD+u7H8GxIIjJWTHKbNj+ovomAQww8PvxoB
X-Google-Smtp-Source: ABdhPJzT7QSBE6LBEo1dSHapxVA/gwhWkgapC+sufWqb95WRdgxHj6lqgoAB825AlBFUQ7PBiGViig==
X-Received: by 2002:a17:902:d48a:b0:154:7a1b:5f2b with SMTP id c10-20020a170902d48a00b001547a1b5f2bmr2327169plg.52.1647897617648;
        Mon, 21 Mar 2022 14:20:17 -0700 (PDT)
Received: from jagath-PC ([115.99.184.169])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f791d0115esm22307990pfk.171.2022.03.21.14.20.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Mar 2022 14:20:17 -0700 (PDT)
Date:   Tue, 22 Mar 2022 02:50:13 +0530
From:   Jagath Jog J <jagathjog1996@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Dan Robertson <dan@dlrobertson.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 1/5] iio: accel: bma400: conversion to device-managed
 function
Message-ID: <20220321212012.GB10058@jagath-PC>
References: <20220319181023.8090-1-jagathjog1996@gmail.com>
 <20220319181023.8090-2-jagathjog1996@gmail.com>
 <CAHp75Vem7DS1oXRt=d78pKe4WEWVOJ7uR8p9r33H5Ws9Rz4Qmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75Vem7DS1oXRt=d78pKe4WEWVOJ7uR8p9r33H5Ws9Rz4Qmg@mail.gmail.com>
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

On Mon, Mar 21, 2022 at 10:30:26AM +0200, Andy Shevchenko wrote:
> On Sat, Mar 19, 2022 at 8:10 PM Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >
> > This is a conversion to device-managed by using devm_iio_device_register
> > inside probe function, now disabling the regulator and putting bma400 to
> > power down via a devm_add_action_or_reset() hook.
> >
> > The dev_set_drvdata() call, bma400_remove() function and hooks in the I2C
> > and SPI driver struct is removed as devm_iio_device_register function is
> > used to automatically unregister on driver detach.
> 
> ...
> 
> > +static void bma400_disable(void *data_ptr)
> > +{
> > +       struct bma400_data *data = data_ptr;
> > +       int ret;
> 
> > +       ret = bma400_set_power_mode(data, POWER_MODE_SLEEP);
> > +       if (ret)
> > +               dev_warn(data->dev, "Failed to put device into sleep mode (%pe)\n",
> > +                        ERR_PTR(ret));
> 
> By what reason did you remove mutex around this call?
> 
> > +       regulator_bulk_disable(ARRAY_SIZE(data->regulators), data->regulators);
> > +}
Sorry my mistake, I missed this.
I will include the mutex calls in next patch version.
> 
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
