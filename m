Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB81503553
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 10:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbiDPIrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 04:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbiDPIrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:47:35 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CD822538;
        Sat, 16 Apr 2022 01:45:04 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id bg10so18939567ejb.4;
        Sat, 16 Apr 2022 01:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UfDzZ0b1pw+tmJ0b/K2clf+bL/Ytz2Hx/TnsHmLXCyM=;
        b=d7nNzoxHHTlMXu1XK2YvcCWRL6SlZeJwDjpbLZVmDrSNYIkX8kOoyCOK/jgzxp3SWK
         pMqaSb0dPLVVUmDc2kMGK7HKKS7ABpDELhqZHObQCOZvTy8R9ndhSDfNuOw08KEtjKp3
         L2Dur2H4r7vbrXgyoUAMbbSLr7Hzmiu8Skv97Xvl80eBBi3IvYqy3M6EH6dte/7/9uis
         JcegEWnnL42WkR4vidtISRcgoIIiWaWYsx6xstnnm0jOaCmKCc7xCvLtBPD2uiEjMYVk
         RbqhYbpEUYZxRjUqJhr5OSx95Cm0KySf9TyqRWdb6Yp3ho9D9KeWozWrJzZyjqgfpAvj
         02YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UfDzZ0b1pw+tmJ0b/K2clf+bL/Ytz2Hx/TnsHmLXCyM=;
        b=JGSwFLmCO5VwCNk/cWBM6qfXB56M0AWMMGGsqgcSUq3JNC/JRog7ir/UwQJWdEK3rK
         C066ChcRmwh77LrdlNf/0EBMbtq32QrZVrZgszyr2VS0shvNYqXFtB7raFwjoDY1hntT
         v4WHbG7pKi7JAe8qHAZMNLB32TW2mnlv5FbVefYqv+5zuOgKyqytsGtREM42eVemyhjd
         iLTo/MVJgXwashG9Vz9jfyja/+twOIz/0UHXtR70KNWiKLL4pf7+arl4RxH5q0RxlX2n
         fv3nM2xgpZmRLk0qEkb8RUGx4LXw3P/fcbfM970UmlBhMYgGeW6tN3aDn92k/RnzpuIO
         8krA==
X-Gm-Message-State: AOAM533bQzJ9BNI9BWWa6o9XkBDOjA1aKk2Qi8rgBh45E2msD3hO1r8u
        zshVbHmRDofv88wqaNjWfIiV9XDWiKHm7qbdeHY=
X-Google-Smtp-Source: ABdhPJxhUvCQ8dSyn4OlYf10H76cCG2aIIhvNa7BmB1UiA+aYPF1lTKjNRV7AHvwCt5vvCF2QXadhnEkzqmnqETFCTM=
X-Received: by 2002:a17:906:1cd1:b0:6ec:c59:6a1d with SMTP id
 i17-20020a1709061cd100b006ec0c596a1dmr1176376ejh.77.1650098702580; Sat, 16
 Apr 2022 01:45:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220415130005.85879-1-andrea.merello@gmail.com>
 <20220415130005.85879-13-andrea.merello@gmail.com> <20220415174808.3b81baa4@jic23-huawei>
In-Reply-To: <20220415174808.3b81baa4@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 16 Apr 2022 11:44:26 +0300
Message-ID: <CAHp75Ve_f2txO8izFzjFUCRiP6SkT2wVHshy5EtU8LGtjzDAkA@mail.gmail.com>
Subject: Re: [v4 12/14] iio: imu: add BNO055 serdev driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andrea Merello <andrea.merello@gmail.com>,
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

On Fri, Apr 15, 2022 at 7:40 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 15 Apr 2022 15:00:03 +0200
> Andrea Merello <andrea.merello@gmail.com> wrote:

...

> > +CFLAGS_bno055_ser.o := -I$(src)
>
> Via a bit of grepping I can see other instances of this pattern which point out
> that it's to do with allowing the tracing framework to see trace.h.
> Perhaps a similar comment here would be good (if nothing else I doubt I'll
> remember why this magic is here in a few years time!)

Can be done better way, see dwc3 or drivers/base/ trace point implementations.

-- 
With Best Regards,
Andy Shevchenko
