Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FB5568A52
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232681AbiGFN72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbiGFN71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:59:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71A5E30;
        Wed,  6 Jul 2022 06:59:24 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k129so8915442wme.0;
        Wed, 06 Jul 2022 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ac9Gpr6U1DQvwMtz7WiTrdzZYCAj4x8uFrWYzzMTzb8=;
        b=pm/F8oyh3Wv4oJ9F1yZbKbUSnHnhOZIG7VBPv3k+Z7WkXw0SsQxmdwDM7+3qljP4Pc
         FNds8B23FRIZ+8RbnRrqwDxJ2j+G1MpLDsVuwZCTJmH6QLYPQSLF8rvGxjgNAkE16U/i
         mr0lOTFAbCftbS7CfNw40jwkZ6vciJnjrnnYG23GFIT4457GFHTfSbUGQhrLpMr8rFw+
         Y7Bk/NWbwNiwanYXlsSKfwv6iHYJSr+I8pKU/5DlNn/P54h+r1aVFdm5muGgkdQ8P+du
         5aJZ9QNGS+VhLek63Fewf+0LqoK5PgnCi8GyHnopaQwyVQmwSp/zAEx4TZZM+QHHcd+2
         4VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ac9Gpr6U1DQvwMtz7WiTrdzZYCAj4x8uFrWYzzMTzb8=;
        b=LZ3DHr56mJXNgXnCQwuFvrqljxTFUyJyQ4t0crXvcYpxZHU4IiFcA6pHBnUsyjADe7
         IdLmOYnCExy0nTEQzPwkRmCHWHkga2crRp2g6jSBTmO1FhaLxd1+Pmd5QCA6fXE++Jry
         cb0kRNyBqzHAbKufDQv12OVMoy/7mxpqq56AY1QFqoFw+0REgPvnm9QNiA3DKoN8NmFm
         2xkd1CuItglqXkL18d7l5ckMXFIestVF9LQwcII77Vc+mXdMIuHf6labanTEkFKn7fNo
         kgNTrIcmIKDOPvDaJPox1YDLeYSuC/jG3/M46eQp0kgIyq8JKnk530YbS/yvalxH6yDC
         syew==
X-Gm-Message-State: AJIora8iEXLVZpZKQLtwR5UVu0HVro/60/OYP4ej7Ysum3rAKH+nSI6t
        n5MTDUIG3dcE9SxCoDxOnSHoTjgTUvbIn4A9uZA=
X-Google-Smtp-Source: AGRyM1vxO/5kBovUPHP5jdMNDZbte60s29qcNytejGZBFSQ9kKKWQS7qjr+Cj+lKU8LyomLxfNv0XjGHHRJeOkbw2WU=
X-Received: by 2002:a05:600c:3505:b0:3a1:9fbb:4d59 with SMTP id
 h5-20020a05600c350500b003a19fbb4d59mr19296256wmq.165.1657115962761; Wed, 06
 Jul 2022 06:59:22 -0700 (PDT)
MIME-Version: 1.0
References: <1657038252-31360-1-git-send-email-u0084500@gmail.com>
 <1657038252-31360-3-git-send-email-u0084500@gmail.com> <CAHp75VeV6vByZXGLraLes+94Rfs23ZjPXGaXzUf-YY=sb_1=2Q@mail.gmail.com>
 <CADiBU38qzjECL9_8djx4Vna5PA=A2_jh7BFph1z2D_LOqTtZTQ@mail.gmail.com> <CAHp75Vct4YytjXmFVtqKEM6zK84=PsTDD7=y7mxjELjZMj845A@mail.gmail.com>
In-Reply-To: <CAHp75Vct4YytjXmFVtqKEM6zK84=PsTDD7=y7mxjELjZMj845A@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Wed, 6 Jul 2022 21:59:11 +0800
Message-ID: <CADiBU3-=gVqxLP2KP1Jm_ALU=LrCoJZ5e+VUFX_6Ow+cDqa9QQ@mail.gmail.com>
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
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=
=886=E6=97=A5 =E9=80=B1=E4=B8=89 =E6=99=9A=E4=B8=8A8:45=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Wed, Jul 6, 2022 at 3:08 AM ChiYuan Huang <u0084500@gmail.com> wrote:
> > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=886=E6=97=A5 =E9=80=B1=E4=B8=89 =E5=87=8C=E6=99=A83:09=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > On Tue, Jul 5, 2022 at 6:31 PM cy_huang <u0084500@gmail.com> wrote:
>
> ...
>
> > > > +KernelVersion: 5.15.31
> > >
> > > ^^^ Wrong
> > >
> > I really cannot understand what kernel version I need to specified.
> > https://lore.kernel.org/lkml/CAHp75VeBdgbyDQXEYb9ZZdi3AU=3DvPw6aKGWbNLn=
uA_QoN4LE4A@mail.gmail.com/
> >
> > Last time, my understanding is to use the realistic kernel version.
> > Then from my  development environment, the kernel  I used is 5.15.31.
> > That's why I changed it from '5.18.2' to '5.15.31'.
> >
> > Do you mind to tell me what kernel version I need to write for this
> > ABI test document?
> > I'm almost confused about 'realistic', 'non-stable', nor 'developing'.
> >
> > If to write '5.19' or the future version '5.20', is it ok?
>
> It's as simple as "next version that most likely your patch will be
> in", in 99.9% cases it's 'current-cycle-version + 1', i.e. 5.20.
>
It really confuse me for days.
Now, it's clear.
Thanks.
> --
> With Best Regards,
> Andy Shevchenko
