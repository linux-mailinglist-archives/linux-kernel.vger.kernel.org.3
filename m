Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C466523442
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiEKNcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiEKNcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:32:48 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8EDAFAED;
        Wed, 11 May 2022 06:32:46 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 16so2581837lju.13;
        Wed, 11 May 2022 06:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1H3ona0oTbz59kwRqd1lHBTp5NjIu/8z9f9BOfETVU=;
        b=DXOECGjzG3bszrjtO/ceGDZrjGl18l8sUxJKu8RYByebsRn/x60DklA5x0HzSBI0/D
         zywozP4Jmgx3fSCY00Oyz0t48qLY+nAHBzT8nX8drKQsoBDNbn16l2HHRueHPNmzzWfD
         zu7mLaiu8p6J/ppEl+rKcYp/5E9E83E3Cidh9nWYhhz5JpzEpoM91BBuiYgkscLIr2W1
         GRPm3RtIWeoVjkj9RlLLrwonPMVC8Dadhr6P8WUsgCLz7bf+L58USaw0uWOqvfFQyevG
         jia6wei/wDVmVI5JbK6GvfgsA7mDrXhNHnpz29uw9aKOphbBEB78nolexhEyciWukAx3
         DA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1H3ona0oTbz59kwRqd1lHBTp5NjIu/8z9f9BOfETVU=;
        b=Oa/f6nR4ryIToQ6KAQM/LLmxTJUoG8vOvGQxyhGcef5UaVKfG7dxMxTX5WD816m2S2
         nSZs43ZNDYO75dIgqSAPGyQQn5bIQwdDk6C8C1RloIQSyhhIFnbRpQuAeYSVmjZLqFSL
         uHzyzNuhsixKTzqOaqZXrLnXQP3s2BNpSv6u/3RXwLDy90aXxrRLBO3K/H2PKVvr+C5T
         YoGLqXhxQIhCQko+EniL2ChBAOLx2tFrNz+Ht0NoBuhkKwBcFk4ley7gZsAE7uUMlSAo
         jazsMsLuthODP99wtwAKKME5lVAXnICeAfx2OyqfMyITZ8Gk8T/N47bq4m8gBMwfWRVr
         Seaw==
X-Gm-Message-State: AOAM533Ib1p/HjBElktJtcyeFlEkIghsfGf1+GZxTPr9ZZLgULRiftyl
        Aai+aNgGGl8DGEW23W0yycxWJJ2/lgmWxTMeWkTryUVxSbU=
X-Google-Smtp-Source: ABdhPJw8Aawwk2AC3bGkcSXGgJuv1DnTvl3XZin4BXHRTdxy10Myt5bWrotb0jdkKhIwPZKrf4nUFjCyH5NabIoQfSU=
X-Received: by 2002:a2e:a889:0:b0:24f:19df:46ef with SMTP id
 m9-20020a2ea889000000b0024f19df46efmr17332743ljq.110.1652275964464; Wed, 11
 May 2022 06:32:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220511115911.54960-1-max.oss.09@gmail.com> <20220511115911.54960-4-max.oss.09@gmail.com>
 <CAOMZO5AboNfb_E-4QVurZ6UTYephsOakW0QrAU8xRAMe8_zRow@mail.gmail.com>
In-Reply-To: <CAOMZO5AboNfb_E-4QVurZ6UTYephsOakW0QrAU8xRAMe8_zRow@mail.gmail.com>
From:   Max Krummenacher <max.oss.09@gmail.com>
Date:   Wed, 11 May 2022 15:32:33 +0200
Message-ID: <CAEHkU3U=58qittoNazqXrkYKO9gs7VU3VW_67823fs+dt6r6eA@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] ARM: dts: imx6qdl-colibri: backlight pwm: Simplify
 inverted backlight
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio

On Wed, May 11, 2022 at 2:07 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> On Wed, May 11, 2022 at 8:59 AM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> >         backlight: backlight {
> >                 compatible = "pwm-backlight";
> > -               brightness-levels = <0 127 191 223 239 247 251 255>;
> > -               default-brightness-level = <1>;
> > +               brightness-levels = <0 4 8 16 32 64 128 255>;
> > +               default-brightness-level = <6>;
>
> In this patch, you are still changing the brightness levels + passing
> the polarity.
>
> I would suggest that this patch only touches the PWM polarity.

I disagree. Just setting the invert without at the same changing the
brightness-levels does
change the user experience way more than when one adapts the available
duty cycles
at the same time.

With the change to use the PWM with inverted polarity the PWM signals
is inverted to
how it was before this patch. Keeping the brightness-levels will then
have a big brightness
jump from 0 to 127 duty cycle, the other 6 steps will then be barely noticable.

I.e. before the change the brightness for level [0..7] was
['off', 128/255, 64/255, 32/255, 16/255, 8/255, 4/255, 'off'],
if one only inverts the polarity it will be
['off', 128/255, 191/255, 223/255, 239/255, 247/255, 255/255].
With the proposed patch it will be
['off', 4/255, 8/255, 16/255, 32/255, 64/255, 128/255, 255/255].

Max

> The next patch could fix the brightness levels.
