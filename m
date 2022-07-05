Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FC3566636
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiGEJca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiGEJax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:30:53 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7012026C4;
        Tue,  5 Jul 2022 02:30:52 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q9so16658656wrd.8;
        Tue, 05 Jul 2022 02:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pqNWIMkJNYvA/PC47JUDwOP00hRjeIEHchew0U2843w=;
        b=hWKb7nzY1odxTwb5B+tqx8kFvnCurCGajCsd+YSXTqu9Kh5ex9z5Fe3qMLd5kde8M7
         WPyQdrWaxdYyYN+rWxsEvPLc8AppeTizL3NJLo5C1AgGEANiiKV2SSqbyFsSeMYcTNxY
         8FKNIokGxQyz+HH+0ltunvS/RSiBSBWuq+fymdvN19yze7/vNFw5ioDtC4ptUfV8IkvT
         wvBY/lBRSIw7qdNpflZCEU321su/N2y+XdEgNmWvpJJtWz7f5OkxIP7sv//vwn8xdd9C
         hH79z0iDLJOLAPkN7uNi2tUD6300A8VY4QlYnM1OSy16rlyebC5u5T0+8wj5KfMCtdFS
         1PHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pqNWIMkJNYvA/PC47JUDwOP00hRjeIEHchew0U2843w=;
        b=4Quai0Xlkjte2BkN64u4M2OTFPfQSOfxCjdgWX2C8/Lx7i3GGMZVel4gNQ3Z0WokRz
         zTTBjFOhdJsZDzy5/Rek61foFsN8sVjaAgGupdzt9a/LwVItny5LoR7b4C1fmw/Hs4eB
         a3DBK9rbuhFcrideJX3ZN7YsARp28Y7RNyJMKXtD6LT3R5kYC9KjpVPjrwriImUuwLkY
         2IBmYJOA+KT358hdmeKZBYiv+gKcximHLxbeuqvnJdb6aVhG8r8RMg41eiz8gBL/qyvo
         TTVIzNyV0bugICOx6WvFXNqGGht0yQRfKeAnkFdLpU0QYvAKhZgihUMkJO3x08WSrYPR
         xBhQ==
X-Gm-Message-State: AJIora+9dfxGzgG1BfSU/N6i4mX+XbNLtZP3Mh/SRlgf9DMZc5Q8WmVL
        OdQJRCIsVWC/4KfIX7tak5bug6mF1EfOqW4SK2o=
X-Google-Smtp-Source: AGRyM1vjfo6ewz8a7C1z1FgnaLM7eptrOikYkhWProGUaTZ44xN7w/Kl7fw//m2WrPoXojCEf9C6mMWzFyegaLdvjlc=
X-Received: by 2002:a05:6000:15c1:b0:21b:ad5e:2798 with SMTP id
 y1-20020a05600015c100b0021bad5e2798mr31238285wry.237.1657013450868; Tue, 05
 Jul 2022 02:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
 <1656469212-12717-3-git-send-email-u0084500@gmail.com> <CAHp75Vd2bxFA5PmjEtgAjJfCf9YZENq_fb9b2VHmMmmHdqGJSw@mail.gmail.com>
 <CADiBU384ZwKL_+i1zRL9qfVt-NLo=pnf8zrGna4Sxt+toYZdWg@mail.gmail.com>
 <CADiBU3_sU8bj29x2Qs9y9fM2YDYcKvNBkBuzfpzuCkAjSeTu+Q@mail.gmail.com>
 <CAHp75VeiuJjiPFFh0pEGGH4+UEn0g5902UhAJL93Ho2WvH0_gg@mail.gmail.com>
 <CADiBU38FbZ87EHn_UDy-rS6V2bGDdLZJOcqNZsS03MzbNaVaKA@mail.gmail.com> <CAHp75VfyKtFQbcJJxW8TNSHMZppM6Qgj4hxiUzLB1bSmeWBBAg@mail.gmail.com>
In-Reply-To: <CAHp75VfyKtFQbcJJxW8TNSHMZppM6Qgj4hxiUzLB1bSmeWBBAg@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 5 Jul 2022 17:30:39 +0800
Message-ID: <CADiBU3_fZxCigiaa8mh9bHV565Bxiyux1a1zFWmi9v6xwdZzgQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add rtq6056 support
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
=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:05=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Tue, Jul 5, 2022 at 3:41 AM ChiYuan Huang <u0084500@gmail.com> wrote:
> > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=B8=85=E6=99=A85:52=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > On Mon, Jul 4, 2022 at 9:27 AM ChiYuan Huang <u0084500@gmail.com> wro=
te:
> > > > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=
=884=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:16=E5=AF=AB=E9=81=93=
=EF=BC=9A
> > > > > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=
=B47=E6=9C=881=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:05=E5=AF=AB=
=E9=81=93=EF=BC=9A
> > > > > > On Wed, Jun 29, 2022 at 4:23 AM cy_huang <u0084500@gmail.com> w=
rote:
>
> ...
>
> > > > > > > +       struct {
> > > > > > > +               u16 vals[RTQ6056_MAX_CHANNEL];
> > > > > > > +               int64_t timestamp;
> > > > > > > +       } data __aligned(8);
> > > > > >
> > > > > > Hmm... alignment of this struct will be at least 4 bytes, but
> > > > > > shouldn't we rather be sure that the timestamp member is aligne=
d
> > > > > > properly? Otherwise this seems fragile and dependent on
> > > > > > RTQ6056_MAX_CHANNEL % 4 =3D=3D 0.
> > > > > >
> > > > > Yap, from the 'max channel', it already guarantee this struct wil=
l be
> > > > > aligned at lease 4.
> > > > > Actually, It can be removed.
> > >
> > > I think for the safest side it should be given to the timestamp membe=
r. No?
> > >
> > Sorry, following your comment, Why to use 'align' for the timestamp mem=
ber?
> > the data member already guarantee 2 * 4 =3D 8 byte, then timestamp will
> > be 8 byte aligned, right?
>
> Today it's true, tomorrow it might be different. Imagine if this
> driver will cover a new (version of) hardware and needs an additional
> channel, how do you guarantee alignment in that case? So, current
> approach is working, but fragile.
>
> > what you mentioned is to put __aligned(8) only for timestamp.
>
> Yes.
>
> > I try to put aligned in two ways ( one is only for timestamp, another
> > is the whole struct). the result is the same.
> > From my thinking, in this case, the struct is already 8 byte aligned
> > for timestamp member. don't you think to put 'aligned' is redundant?
>
> No.
>
Thanks, I think I can get your point. if it need to be compatible with
others, this part will be a trap.
Then it's better to add the align for timestamp member.

I'll submit the v4 for this.

And very sorry about another mail.
I just confused about the text.

> --
> With Best Regards,
> Andy Shevchenko
