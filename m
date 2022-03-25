Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3F14E7285
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357689AbiCYMAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345872AbiCYMAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:00:13 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07850E008;
        Fri, 25 Mar 2022 04:58:37 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id b24so8938009edu.10;
        Fri, 25 Mar 2022 04:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5HUtOUWp2sZ6TtVf8FyrTatTYVQYhhjB2DEeLm0DIl0=;
        b=Bg2vRbrg9DC8jGkbN/gbK8JUSHWn8tszqPOOqDcsWhq4S6iO5qxDWltryZiQp8nEWq
         oW5nGkC4I5+5JNYMYBQ6f7tm2HhCUkbCjBJMOc2UEkMlgcBVIW4gX3jKewoABH5VHC3V
         fXrFoG7ZigtE6BY/TJizDV/Ah9/91kbNHiJ5hpy1HVK0v2xzhTp+ssVMpdjlcpjrrJN1
         TcnIFzPiGrFApB0lRhcOUVI20sNlr3OlZ52uKYxUTk2EO6ZqgCBwHE6Z990iJw6x7v78
         J4XkI3tntZuna9FXg4Lj/u3I3S9nZbWrryfstI7CNGkI/FNND00q+KQlTzXc6qXpBDux
         NNmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5HUtOUWp2sZ6TtVf8FyrTatTYVQYhhjB2DEeLm0DIl0=;
        b=XeFp9PS0snQF9/WCwjq/3Z/vrRGnPNvwIOqFg3P6LYrDJbhF8jPyRVzqh/MtOLVv6j
         hufwLV1WcHuIggShiY61oWckp4XpBtkN9euq4KkvcnNWfr1bNuF14D9fABQH8JuSwzzB
         MeCa+L0MkD6cdOglNZh5enSA7W1SEGFieOfRYVYNwqTP7/m8iMJ/VBQJk6tHh70/EBme
         WZH5qbBdr6HaTq5xhdBHKxTUoD3t8C0bGAnGvVc/Yuxc7ajdAMpX83TwDFTLnbMNpvg0
         wbj2BddGdmMzE1VZ8u6mxfc1zBkyFxxpF2i2S1Bna8gBY/QJrH7i8PgUINFM3/G5TYDY
         WWGQ==
X-Gm-Message-State: AOAM530BQ+RgXY3pSoITXPXwz/8QXk8dZdNnzX7rEzFVvGV+DcuzsH34
        wltaPwL1iwMbtRlOj72wC42EkPmd2v3YXjRdhuJd0NzP0zg=
X-Google-Smtp-Source: ABdhPJxxBxQy7rz7v8ypAhFqy/HT7mxKKkNRASnaabG6Xdhji28aPSrvtWzHmfMC2YJPtOaiBFr9jbln0E7ItrEv4Ng=
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id
 f20-20020a056402005400b004199b58e305mr5305571edu.158.1648209515478; Fri, 25
 Mar 2022 04:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220215081216.67706-1-antoniu.miclaus@analog.com> <20220220121414.48d7a3b6@jic23-huawei>
In-Reply-To: <20220220121414.48d7a3b6@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 25 Mar 2022 13:57:26 +0200
Message-ID: <CAHp75VdWPBNeX4=7ZzozodLR2A9=YxfKLpey=fhKhmW+y2HAPw@mail.gmail.com>
Subject: Re: [PATCH v8 1/4] iio:frequency:admv1014: add support for ADMV1014
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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

On Sun, Feb 20, 2022 at 11:55 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 15 Feb 2022 10:12:13 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>
> > The ADMV1014 is a silicon germanium (SiGe), wideband,
> > microwave downconverter optimized for point to point microwave
> > radio designs operating in the 24 GHz to 44 GHz frequency range.
> >
> > Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADMV1014.pdf
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
>
> Hi Antoniu.
>
> One really trivial point inline that I noticed whilst having 'one last look'.
>
> I'll fix it up whilst applying but please check I didn't mess up!
>
> Series applied to the togreg branch of iio.git and initially pushed out as
> testing to let 0-day poke at it an see if it can find anything we missed.

On v5 I have given a few comments and the author didn't include me
into the Cc list for the following series. It's not good. Not that I
care too much about the series, but just to make the point for the
future reactions on somebody's review.

-- 
With Best Regards,
Andy Shevchenko
