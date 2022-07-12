Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FC95716DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbiGLKME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232647AbiGLKLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:11:45 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D17AE3AE;
        Tue, 12 Jul 2022 03:10:54 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 6so13116188ybc.8;
        Tue, 12 Jul 2022 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZrbCxqggRZgufaB5CskDiyadw0Cspfud9ibS8+AuPuk=;
        b=Yk8iKP/8vgEX0WPSPr+xRjpb4dIH3/V3BA+FYO6VDhvl/l7xVvRWBfW+o9JMSJ75Da
         vOeoVGJolK3DH+lsn+4nESm60wjSPWdxXYhMbhnqqk2rPXQQBM/ffB+ZXcFtaSMiygzY
         M7cRaAK4NnsTxNDxzWkTSCfK+63tV1m6P7xwwrchzFAJsLUN7sprjd91MFbRFOJ0RspR
         LqZhBz4sczywLwXQovlWNaP/SUsyrBnUvQDa0s2Yns6nLEOuLK0wxODopQsxHl/1meOS
         sN9YMY792gkDzlgSacr08pVSd/QOsOt6GwTxkBww9q+xMszIH8jM00XA9hRtYrNWK/M6
         QEVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZrbCxqggRZgufaB5CskDiyadw0Cspfud9ibS8+AuPuk=;
        b=de1YnMPEYDssl05ErppCd/g/9Cv8roZ6OyTUVXv6sHg9EOP/dk3FhL7Bzw4HiYti5b
         gjLVOA+uHOs1PQrVPfEGLngIWpGTE2XVI0iDjk3N0ECZzwg2KXsRuCoCjCe+lRvUnXUx
         m9l/gqwLBm/MHB+mIyOvLDPXsucHRULnO8Q/38AfA8nnvLkXsuraUrE1OwVwk+M2N7kw
         bvfGpgQbvK4C5OATLGXUbKjMt0zWqDruFfe9tLXG5XrOK608B7a6+On/YdFORifMElbK
         u1stU29uYgTSZET5oqRc2Ee1GwSR0f16Ije0GeEJ2Ki9zOXS8ydgNy+xlGAN7g0TZF0C
         mmPg==
X-Gm-Message-State: AJIora/Yq7uR+5taXVPw9jjzMdFAYwWo2tRehWeXSCzPGr8YflQy4Hbb
        KitbDQVEQjkdAX9gXUEpNl70I731LQuxB/SryWg=
X-Google-Smtp-Source: AGRyM1teu7aOq5oE9YFjF4RCgZz+6u17KG+1hMabxQp9o6pQtFpCaQg2BbQgLOxu9d3xFPmAjzPnH6cpkiK6xgkJq3A=
X-Received: by 2002:a25:df97:0:b0:66f:6e7c:b3c0 with SMTP id
 w145-20020a25df97000000b0066f6e7cb3c0mr4621519ybg.93.1657620653173; Tue, 12
 Jul 2022 03:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220710081853.1699028-1-uwu@icenowy.me> <20220710081853.1699028-3-uwu@icenowy.me>
 <CAHp75Vdso_PGUomjmKaF1ytdUe4qLeAbpwkNmcRng9aNHs7g8w@mail.gmail.com> <7a947683de71e68a0925cfd4cab80238c3a03205.camel@icenowy.me>
In-Reply-To: <7a947683de71e68a0925cfd4cab80238c3a03205.camel@icenowy.me>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Jul 2022 12:10:15 +0200
Message-ID: <CAHp75Vc0kfQZJjdu+MrJAAdcR7GKD9Sh1zU4gz5dua5Lw9BVHA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] pinctrl: sunxi: add support for R329 CPUX pin controller
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
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

On Tue, Jul 12, 2022 at 11:37 AM Icenowy Zheng <uwu@icenowy.me> wrote:
> =E5=9C=A8 2022-07-10=E6=98=9F=E6=9C=9F=E6=97=A5=E7=9A=84 21:06 +0200=EF=
=BC=8CAndy Shevchenko=E5=86=99=E9=81=93=EF=BC=9A
> > On Sun, Jul 10, 2022 at 10:22 AM Icenowy Zheng <uwu@icenowy.me>
> > wrote:

...

> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> >
> > No use of these.
> >
> > > +#include <linux/pinctrl/pinctrl.h>
> >
> > Missed headers:
> > mod_devicetable.h
>
> Thanks for these.
>
> In addition, how to decide what header should be included? The code
> works properly because of_device.h includes mod_devicetable.h.

The best approach is usually learnt with experience =E2=80=94 the more you
code, the more you get. One of the rules is to avoid too many
inclusions and at the same time reduce indirect inclusions, so that
the headers which are guaranteed to be included by others shouldn't
appear. Another rule is that, for the headers (*.h files) the forward
declarations are preferable over the inclusion in case if the opaque
pointers are in use.

--=20
With Best Regards,
Andy Shevchenko
