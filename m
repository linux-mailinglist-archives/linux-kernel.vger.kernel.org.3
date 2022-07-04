Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04AB565F30
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 23:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbiGDVwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 17:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiGDVwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 17:52:11 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194B6BC2F;
        Mon,  4 Jul 2022 14:52:10 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-31cb2c649f7so17770087b3.11;
        Mon, 04 Jul 2022 14:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=my4+DrJedrpU/mQg8JGhfRmIVUW7fXxN9fPtsnqMMtU=;
        b=pUv3GqCAR076f7MQVe6wqNqK9r3m2Ew/RBH93+pa0aquynCK61nfHf0b7hL044eELB
         6MmSG+bt0J6cDt0L4KhhdeX+HrXaDEgugMJrc9ysHoA9t/IFrLg4Wu1H81glivOLsbew
         mlr/wudKWu8vUqDWWlVUn0lcjddrFhK56vkZAF3jRaoDsgDvM1vw/7j0gO4BrUPCuMAg
         HOlOtbJ1Hm8Oom3xPPmA4ysQn28rgBejhqg86KfCu5Hleatkzi6FQtkE37VWB4ho3lI3
         QGQT5b7/LXgMLuq9aHyRsUuOtysnsSWn5x2mXqLrYZ1v1a6aUKX7YGipnyA/rdHo8WnE
         XgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=my4+DrJedrpU/mQg8JGhfRmIVUW7fXxN9fPtsnqMMtU=;
        b=CfkqBjEFA6l9sPKkaXvRctdjMrJte3aiaNptzvJVJarD+QNp225QKi+49Vc77PWLk1
         athrF43JoY9WZBI4taIYl1lAjuA5gP22SrU9CcNnSmv2eTAh7P4TR688gR2wIZRlcOHm
         /bCt/3i44+UuyWfpiiTTpOZu4cnc2OJpFOoEuIEoYpn/bUkwkubZc6IOkh3Cepaw3vww
         XAU48IpKNz5A7gaKuF05OGui01TYHIj5TgVjyHUZ0zoRnqkcgyWXHC5y03SdfscyCD7R
         4OzM6Z9agmyRS6l6bcJ5ChVC26YdsBCVnXX+HfAPM0JrjWbBY34xTvw8aIgirMhrFfxb
         m5tg==
X-Gm-Message-State: AJIora+e9wdOraoJ0SllYFju3VyOat+JBjr3+G+YTNt5YS4PmiQ5yRKB
        Eb22i89UvcvauodGxq+2YBLJNfjfqJhhY1qb2hQ=
X-Google-Smtp-Source: AGRyM1tncnebGXxmPlwNScVipoJpd0YMqdaueQM5CNpTc5n8/Snp7w17G1jrQVlMz/SY1v3bvQJi4Bq4N4FbmjQE16I=
X-Received: by 2002:a81:5d88:0:b0:318:31c1:56f3 with SMTP id
 r130-20020a815d88000000b0031831c156f3mr35991617ywb.18.1656971529266; Mon, 04
 Jul 2022 14:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
 <1656469212-12717-3-git-send-email-u0084500@gmail.com> <CAHp75Vd2bxFA5PmjEtgAjJfCf9YZENq_fb9b2VHmMmmHdqGJSw@mail.gmail.com>
 <CADiBU384ZwKL_+i1zRL9qfVt-NLo=pnf8zrGna4Sxt+toYZdWg@mail.gmail.com> <CADiBU3_sU8bj29x2Qs9y9fM2YDYcKvNBkBuzfpzuCkAjSeTu+Q@mail.gmail.com>
In-Reply-To: <CADiBU3_sU8bj29x2Qs9y9fM2YDYcKvNBkBuzfpzuCkAjSeTu+Q@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 4 Jul 2022 23:51:32 +0200
Message-ID: <CAHp75VeiuJjiPFFh0pEGGH4+UEn0g5902UhAJL93Ho2WvH0_gg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add rtq6056 support
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

On Mon, Jul 4, 2022 at 9:27 AM ChiYuan Huang <u0084500@gmail.com> wrote:
> ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=884=E6=
=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:16=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=881=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:05=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > On Wed, Jun 29, 2022 at 4:23 AM cy_huang <u0084500@gmail.com> wrote:

...

> > > > +       *val =3D DIV_ROUND_UP(1000000, sample_time);
> > >
> > > USEC_PER_SEC ?
> > >
> > No, sample time is (vshunt convesion time + vbus conversion time) *
> > average sample.
> > And the sample freq returns the unit by HZ (sample frequency per second=
)
> >
> The 'sample time' is unit by micro-second like as you mentioned.

Ah, then it should be MICRO, so we will get Hz.

> > > > +       return IIO_VAL_INT;
> > > > +}

...

> > > > +       struct {
> > > > +               u16 vals[RTQ6056_MAX_CHANNEL];
> > > > +               int64_t timestamp;
> > > > +       } data __aligned(8);
> > >
> > > Hmm... alignment of this struct will be at least 4 bytes, but
> > > shouldn't we rather be sure that the timestamp member is aligned
> > > properly? Otherwise this seems fragile and dependent on
> > > RTQ6056_MAX_CHANNEL % 4 =3D=3D 0.
> > >
> > Yap, from the 'max channel', it already guarantee this struct will be
> > aligned at lease 4.
> > Actually, It can be removed.

I think for the safest side it should be given to the timestamp member. No?

--=20
With Best Regards,
Andy Shevchenko
