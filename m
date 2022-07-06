Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A7D567B51
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 03:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiGFBIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 21:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiGFBIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 21:08:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8229CA458;
        Tue,  5 Jul 2022 18:08:18 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 205-20020a1c02d6000000b003a03567d5e9so10266419wmc.1;
        Tue, 05 Jul 2022 18:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X9JGYMgyEjh/3XaB96SqjzcBtp/IEDYGgCXSHBcak0I=;
        b=XJSeUvcGwW3vDMSKNe+GSlBWvLm80N4dlkQgeW97/78iep9wAYNFxYhnBeb8RCAvDp
         vpenqHESq9nWVu4KY0AaLWwTMLGlnCUtkxxXEjXAle/Js0sY5e/+fHWX0lFowjWNGITf
         n6m97D4s3HYZP1Sr2OYyF82gnpfQ8TQfP+P5NCfmRqhjNaNQg8PfKtSEJ7xdI5cIfwG7
         F1x9U49G1LIDW7CMVGYJh2DgSvWjU9MkozPF5adAR9IkiesWsyCD+DE0finBQptN65Qi
         X7YJ8uc4GJld2EWT9HQHnY8Dl6pfI0TrvGjiLng986U2pong6KrWO9iRKt16QKJam3s3
         J7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X9JGYMgyEjh/3XaB96SqjzcBtp/IEDYGgCXSHBcak0I=;
        b=vYeCHEwhkuE9qU53vstseHFgW6u4tmyQ//kJXHN8/DnQ0rQ7l1gxxjwX5pC8kvDhgt
         4SHD6CHUhxRxg738Reof/AOTKh9WEpiAFp39F68ZN5LOQCpwRP9nQU/8NYDH6PaJwoh4
         9L6XiK7j7igsjop2whxbNvMPPIBCBy36uORsL/rk4i7SWkaGUgc8SQcV7zHmMr5qCL7S
         5eEId0QBCYPY4geXvX21plBaDrdeqJl/wdpCfi4j9bYTQtpRCyh4AFaeC0NiT03CWWe0
         SIWsAJQ2EA2G98VOdF+fIkhIQKOuJxcouxqu9hRkqRnaznVmYpylXCP725n5r6+rQ7TD
         VY4w==
X-Gm-Message-State: AJIora+6gjRtJZ+WNS2O/o3p+B2/lHGClkLYV6bGJ0c98ZX9R+K5c4/H
        Izkae6AmQEwrsLC32xntGu4L9dSIaXiIGy4v650X6P0u8s4=
X-Google-Smtp-Source: AGRyM1sPaZEn0qLD67hiapm6RAVVZG7N9epthPKNtAbB68VvGndYepMU2OZ40TlQINxl2yIzgw36xtcrBUCmc5VjNWw=
X-Received: by 2002:a05:600c:19c8:b0:3a1:792e:f913 with SMTP id
 u8-20020a05600c19c800b003a1792ef913mr35958362wmq.182.1657069696835; Tue, 05
 Jul 2022 18:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <1657038252-31360-1-git-send-email-u0084500@gmail.com>
 <1657038252-31360-3-git-send-email-u0084500@gmail.com> <CAHp75VeV6vByZXGLraLes+94Rfs23ZjPXGaXzUf-YY=sb_1=2Q@mail.gmail.com>
In-Reply-To: <CAHp75VeV6vByZXGLraLes+94Rfs23ZjPXGaXzUf-YY=sb_1=2Q@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 6 Jul 2022 09:08:05 +0800
Message-ID: <CADiBU38qzjECL9_8djx4Vna5PA=A2_jh7BFph1z2D_LOqTtZTQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: Add rtq6056 support
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=
=886=E6=97=A5 =E9=80=B1=E4=B8=89 =E5=87=8C=E6=99=A83:09=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Tue, Jul 5, 2022 at 6:31 PM cy_huang <u0084500@gmail.com> wrote:
> >
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add Richtek rtq6056 supporting.
> >
> > It can be used for the system to monitor load current and power with 16=
-bit
> > resolution.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Since you sent a new version:
> I said explicitly that the kernel version mustn't be not stable nor devel=
oping.
>
> ...
>
> > +KernelVersion: 5.15.31
>
> ^^^ Wrong
>
I really cannot understand what kernel version I need to specified.
https://lore.kernel.org/lkml/CAHp75VeBdgbyDQXEYb9ZZdi3AU=3DvPw6aKGWbNLnuA_Q=
oN4LE4A@mail.gmail.com/

Last time, my understanding is to use the realistic kernel version.
Then from my  development environment, the kernel  I used is 5.15.31.
That's why I changed it from '5.18.2' to '5.15.31'.

Do you mind to tell me what kernel version I need to write for this
ABI test document?
I'm almost confused about 'realistic', 'non-stable', nor 'developing'.

If to write '5.19' or the future version '5.20', is it ok?

> --
> With Best Regards,
> Andy Shevchenko
