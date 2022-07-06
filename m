Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F6F56889D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiGFMpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiGFMpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:45:51 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F67B1A053;
        Wed,  6 Jul 2022 05:45:51 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31c89111f23so88364097b3.0;
        Wed, 06 Jul 2022 05:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pxQ0akSIpGA9dPAjcdLLYFtTSDWH+hUWLR2UqjvHiV4=;
        b=ejR6eADL9/QpJDdvg1e7GysSgoBWFXYJ4foMw4AerG1LUtiNZSprPoVRSqB8pznJ6q
         sbodb1F6QhO/GxUSPNqXKfSxj3rsp3WEPIQUDKWOmIDzXc3vzcBnwc8bQH6EgDIceZDF
         WuPggNbPhNm5A6yFeNllZP54JycRrPjsvK+KSfu93pdfPLIgFhRtkPEwgxDrim9PlCyo
         AsshhbJXy7UuVNNDDTf3qzLa5fSPNWGbVXwgY1AuT/5UKOmHfMWq+ioCpml6XRrlaFaH
         HLiEgmS78dkBQr0QmpnHcQ09X3cEUV9hjjvBS9ycyAoxBG3ezPijNBQ4pF+v7XfnTVrg
         +I4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pxQ0akSIpGA9dPAjcdLLYFtTSDWH+hUWLR2UqjvHiV4=;
        b=WrZMWGCiAPCQyE4v+bWSc8+FwqnWzRv2zkf4f8fuobPqK163jGM+NLEL9cfJTpaKdy
         O00vgRANvGHxf9b/bZZXTyeJn/7L7VTxZOLdn7nmHn3Ttn5ROEMypXuRtOYLGZPAU+uT
         lAMt+CPdG1tfkbEgeX2aVFOR21g+cr1UTwQU5K2KrHVnhrOOCXiefS1tG+6EMRgGxhgd
         gObtWcBgiLL2O6H9t4+TjluFCb6+1vOxLNxdvPYPGpup7+8hFPjrcfvN84a58XRiFs/M
         gxc4BP8lF+gQdEA0rYeTv+9Ls6icsGzNFEpINzm0oj4lNRosTRjWvbi5vq81bLMXDyjp
         4ejg==
X-Gm-Message-State: AJIora++xSTZJTQxIDUnOxvnkOXr+AvIDd9E+w9ZFqNP3ua6JWbKGPLl
        c6YVnFBixV9OMQM+VRZPEiqyg/7iaQAozOmtqpQ=
X-Google-Smtp-Source: AGRyM1saMDAcd52qtKTSCYpA+P0fDD0DMRQdGlSQL8wPPaqACMEimC6j4uYPvpQrBJgPPhcxrXtM8nNn9tbgesBH2jQ=
X-Received: by 2002:a81:3984:0:b0:31c:b59e:a899 with SMTP id
 g126-20020a813984000000b0031cb59ea899mr12886820ywa.195.1657111550463; Wed, 06
 Jul 2022 05:45:50 -0700 (PDT)
MIME-Version: 1.0
References: <1657038252-31360-1-git-send-email-u0084500@gmail.com>
 <1657038252-31360-3-git-send-email-u0084500@gmail.com> <CAHp75VeV6vByZXGLraLes+94Rfs23ZjPXGaXzUf-YY=sb_1=2Q@mail.gmail.com>
 <CADiBU38qzjECL9_8djx4Vna5PA=A2_jh7BFph1z2D_LOqTtZTQ@mail.gmail.com>
In-Reply-To: <CADiBU38qzjECL9_8djx4Vna5PA=A2_jh7BFph1z2D_LOqTtZTQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 6 Jul 2022 14:45:13 +0200
Message-ID: <CAHp75Vct4YytjXmFVtqKEM6zK84=PsTDD7=y7mxjELjZMj845A@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: Add rtq6056 support
To:     ChiYuan Huang <u0084500@gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 6, 2022 at 3:08 AM ChiYuan Huang <u0084500@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=886=E6=97=A5 =E9=80=B1=E4=B8=89 =E5=87=8C=E6=99=A83:09=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Tue, Jul 5, 2022 at 6:31 PM cy_huang <u0084500@gmail.com> wrote:

...

> > > +KernelVersion: 5.15.31
> >
> > ^^^ Wrong
> >
> I really cannot understand what kernel version I need to specified.
> https://lore.kernel.org/lkml/CAHp75VeBdgbyDQXEYb9ZZdi3AU=3DvPw6aKGWbNLnuA=
_QoN4LE4A@mail.gmail.com/
>
> Last time, my understanding is to use the realistic kernel version.
> Then from my  development environment, the kernel  I used is 5.15.31.
> That's why I changed it from '5.18.2' to '5.15.31'.
>
> Do you mind to tell me what kernel version I need to write for this
> ABI test document?
> I'm almost confused about 'realistic', 'non-stable', nor 'developing'.
>
> If to write '5.19' or the future version '5.20', is it ok?

It's as simple as "next version that most likely your patch will be
in", in 99.9% cases it's 'current-cycle-version + 1', i.e. 5.20.

--=20
With Best Regards,
Andy Shevchenko
