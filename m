Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE0F5660BD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 03:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiGEBlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 21:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiGEBlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 21:41:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C950EDF09;
        Mon,  4 Jul 2022 18:41:52 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id q9so15431563wrd.8;
        Mon, 04 Jul 2022 18:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3mXXLJT3pzHfY2MP3/D0o2S28/BVSfmZhtJ9riIPTYk=;
        b=BOJBA7mleKywdRuyqtpjDV4i2xNN8cmg0F5cRn4q88lQ1pAwfmyWik2giLT5N20921
         NJU5t1mMU07Bzu+XlV+gQqNisf82bGhM2WpQdyhg8wD3NiZwOUY2qPwiLTWRFb4H9Uo3
         g5/RwjcSMRF5YkBkGJMrHckZciYeiPcWSxw7YDm7NavMDagqWVP8mDdFmkKVooHCgwEi
         am5SYzeLOtid4PoPlIrQiYdudZ+aPdJDbyuyswZC2UXMArFFVoJ/Dnk5uvQf21hI9oPX
         hFtSD/dYkt70aTjKYZGKa4fJKWSm7s0DvERiF4DVn/CuKNOk8uhyA8jZ2SDYuiJUDQQi
         dYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3mXXLJT3pzHfY2MP3/D0o2S28/BVSfmZhtJ9riIPTYk=;
        b=GxKP30WmrdL0lwMNz1EdfAbDKJB62vgqbL2mBwut7P1wHJcsdjT8oxzsNSVx3bRzcg
         UYTUV00fXH4kkXqNDUAm7g3UlbfRrTqo2DOJapJi8wBpSzVpSb6EG24P52ABSc4G04WM
         fIpuhTtIBd7ppZ2OflPyaPmm56CiT7YVGlrwmJOJfvs5ytlPDLAjm6qA1pD1YZng9Guu
         ScMk406m2L74iBSuPzqzCGsgahhao37bI1bxvD/K99SVUF6a+kMGfYlUf4VlXoOdgQzv
         ldMCHz+tLeK+hkl8qYOOv3E96HJ/SUkbi3tba7XOaFmanqtQYz2SBq1ZARTF2OcQbQGq
         0RIA==
X-Gm-Message-State: AJIora+9007brdJ0asrk3DWlZgX/o735xFa8FTVizlPT/lzMlRQ5XpRn
        yLV9kNnaW9ddGLnAVAeAh9tRv7EYGRhJvYSF+vE=
X-Google-Smtp-Source: AGRyM1thvmcTH3k8A1sXDOs2Gcf1kS8jALhWsjz7+83QLg81nbpKv3n2CrxTaDkOx1K4MTBmM9J3tyriWKZXLEbU9zw=
X-Received: by 2002:adf:f043:0:b0:21d:6a90:f3e6 with SMTP id
 t3-20020adff043000000b0021d6a90f3e6mr7291898wro.277.1656985311154; Mon, 04
 Jul 2022 18:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
 <1656469212-12717-3-git-send-email-u0084500@gmail.com> <CAHp75Vd2bxFA5PmjEtgAjJfCf9YZENq_fb9b2VHmMmmHdqGJSw@mail.gmail.com>
 <CADiBU384ZwKL_+i1zRL9qfVt-NLo=pnf8zrGna4Sxt+toYZdWg@mail.gmail.com>
 <CADiBU3_sU8bj29x2Qs9y9fM2YDYcKvNBkBuzfpzuCkAjSeTu+Q@mail.gmail.com> <CAHp75VeiuJjiPFFh0pEGGH4+UEn0g5902UhAJL93Ho2WvH0_gg@mail.gmail.com>
In-Reply-To: <CAHp75VeiuJjiPFFh0pEGGH4+UEn0g5902UhAJL93Ho2WvH0_gg@mail.gmail.com>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 5 Jul 2022 09:41:39 +0800
Message-ID: <CADiBU38FbZ87EHn_UDy-rS6V2bGDdLZJOcqNZsS03MzbNaVaKA@mail.gmail.com>
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
=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=B8=85=E6=99=A85:52=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Mon, Jul 4, 2022 at 9:27 AM ChiYuan Huang <u0084500@gmail.com> wrote:
> > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=884=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:16=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=
=E6=9C=881=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:05=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > On Wed, Jun 29, 2022 at 4:23 AM cy_huang <u0084500@gmail.com> wrote=
:
>
> ...
>
> > > > > +       *val =3D DIV_ROUND_UP(1000000, sample_time);
> > > >
> > > > USEC_PER_SEC ?
> > > >
> > > No, sample time is (vshunt convesion time + vbus conversion time) *
> > > average sample.
> > > And the sample freq returns the unit by HZ (sample frequency per seco=
nd)
> > >
> > The 'sample time' is unit by micro-second like as you mentioned.
>
> Ah, then it should be MICRO, so we will get Hz.
>
> > > > > +       return IIO_VAL_INT;
> > > > > +}
>
> ...
>
> > > > > +       struct {
> > > > > +               u16 vals[RTQ6056_MAX_CHANNEL];
> > > > > +               int64_t timestamp;
> > > > > +       } data __aligned(8);
> > > >
> > > > Hmm... alignment of this struct will be at least 4 bytes, but
> > > > shouldn't we rather be sure that the timestamp member is aligned
> > > > properly? Otherwise this seems fragile and dependent on
> > > > RTQ6056_MAX_CHANNEL % 4 =3D=3D 0.
> > > >
> > > Yap, from the 'max channel', it already guarantee this struct will be
> > > aligned at lease 4.
> > > Actually, It can be removed.
>
> I think for the safest side it should be given to the timestamp member. N=
o?
>
Sorry, following your comment, Why to use 'align' for the timestamp member?
the data member already guarantee 2 * 4 =3D 8 byte, then timestamp will
be 8 byte aligned, right?

what you mentioned is to put __aligned(8) only for timestamp.

I try to put aligned in two ways ( one is only for timestamp, another
is the whole struct). the result is the same.
From my thinking, in this case, the struct is already 8 byte aligned
for timestamp member. don't you think to put 'aligned' is redundant?
> --
> With Best Regards,
> Andy Shevchenko
