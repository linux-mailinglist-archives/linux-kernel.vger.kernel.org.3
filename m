Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77AC0506642
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 09:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349586AbiDSHvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 03:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242782AbiDSHvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 03:51:06 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B3C2D1F5;
        Tue, 19 Apr 2022 00:48:25 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id q2so323446vsp.4;
        Tue, 19 Apr 2022 00:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=49QW4R6GIj49YV1VdgeuJcGl8zaS9XFIb7bFesDfF3k=;
        b=IM0iUP7If1NUZsK08A6wTmgqGaR3MnC35ohA70M9SPgPyyuqynKyYoW9A+23xj5JR5
         O5G1pj5d1UrO5AjDkp0tS6nnP9KW55Zx66b8k50CqjjR0lyjjnFxXq6o1nv/xWU7VoL3
         /iKVKO+lImcc1XDqYk2EOqCeyJdmzob+424UAwdZxBPUAcKKCwIIXQnarYrYG9PkMEMj
         vp/r033YdHYENyIa9uFnDL1bQ2NXY77KGoQlmFtHXHY1wMnVARYpExWX0UsPLOlZXVqc
         kwUBqolagLlT0BTRxJsGyaQSvXvqEfvXQnnKhoTE8g6YLYdqXUhYk5YOxR6y14xbScx/
         Lsyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=49QW4R6GIj49YV1VdgeuJcGl8zaS9XFIb7bFesDfF3k=;
        b=F088g985vjwLnwWmOGnqOFHc/kDGorv3UPivRsxCvDlO25GntuosakW0+UCnryOaFp
         ZqTxOOavRCQB8RlNv/BZWxOlQIIujAaj3Jb4pRD6iXEuwH/bDF54rEX17YZLoTvy4au9
         8rEJx6qDn/zvvGY0xV600eaU8895NyiYwIxF3epMWsvAW98/sER2QLKvbDMFmVmwKtix
         Mqn+MOWbgjMKVh70jWos2rKtMDESzvVr2NBaZ1SLbzA9ERNKNGIridgFyryoNCkzG+/B
         Pq724KDVKo7yrcGwV0+yvZEfpQB+HOSzaDjkvwGNURN6B0HjxnldK9wlqWT3YlCUCUPK
         qjmw==
X-Gm-Message-State: AOAM532m9X+ju1FGO8jDU1DFG3uGysDuJTVuN9U0HmMvdqRGk4PX+1hO
        Ar8Gkmm2CDeHMvMVEwLKWGhJHk7G28E8+auaAIk=
X-Google-Smtp-Source: ABdhPJxCif212DbzhU6zBUI42siDTQBb2Z3k8J3DZ9BO2rMQgKy0K4phCJIZtHoob4QnxCpH9QILxOrt74O3C9OJ7fw=
X-Received: by 2002:a67:fd65:0:b0:32a:27e9:7c09 with SMTP id
 h5-20020a67fd65000000b0032a27e97c09mr3971392vsa.55.1650354504535; Tue, 19 Apr
 2022 00:48:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220415130005.85879-1-andrea.merello@gmail.com>
 <20220415130005.85879-13-andrea.merello@gmail.com> <20220415174808.3b81baa4@jic23-huawei>
 <CAHp75Ve_f2txO8izFzjFUCRiP6SkT2wVHshy5EtU8LGtjzDAkA@mail.gmail.com>
In-Reply-To: <CAHp75Ve_f2txO8izFzjFUCRiP6SkT2wVHshy5EtU8LGtjzDAkA@mail.gmail.com>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 19 Apr 2022 09:48:13 +0200
Message-ID: <CAN8YU5PeDd8BQYHQVAzfkni_v55UjaJsRJ4ATs0FAVFt1KKX=g@mail.gmail.com>
Subject: Re: [v4 12/14] iio: imu: add BNO055 serdev driver
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

Il giorno sab 16 apr 2022 alle ore 10:45 Andy Shevchenko
<andy.shevchenko@gmail.com> ha scritto:
>
> On Fri, Apr 15, 2022 at 7:40 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Fri, 15 Apr 2022 15:00:03 +0200
> > Andrea Merello <andrea.merello@gmail.com> wrote:
>
> ...
>
> > > +CFLAGS_bno055_ser.o := -I$(src)
> >
> > Via a bit of grepping I can see other instances of this pattern which point out
> > that it's to do with allowing the tracing framework to see trace.h.
> > Perhaps a similar comment here would be good (if nothing else I doubt I'll
> > remember why this magic is here in a few years time!)
>
> Can be done better way, see dwc3 or drivers/base/ trace point implementations.

May you elaborate, please? It appears that both dwc3 and driver/base
use this same trick of tweaking the CFLAGS in the Makefile in order to
fix the header file thing. What I see is different is that they both
use an (almost empty) trace.c file. Is this what you are suggesting?

>
> --
> With Best Regards,
> Andy Shevchenko
