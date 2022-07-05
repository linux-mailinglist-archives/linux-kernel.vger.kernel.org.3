Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20F55665CC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiGEJFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiGEJFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:05:10 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D9B388C;
        Tue,  5 Jul 2022 02:05:09 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id i14so971325yba.1;
        Tue, 05 Jul 2022 02:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k0xB10Perd+Jw8sWS32J1melEiaxGcduzBXWrX0yzOs=;
        b=Qixjf4ql1w+8Zz+LViBF8fpy93wI5MiiTdINgX3wp5Z/C4esiA7TtuC/9+G6LIcbdt
         gitJpDgSBHGrpEjMoZL1tV1PfmhSNMfowzNYZWAehZS0/gH/v7195qEdtL7cLXOS03sn
         bN5dECcUjZw0hr8D6GOzyF/6N29Pw7kFjVr8CEr0KJq0N1Zaqj9d/JYtw6loLUQEi/KM
         3wimOaFwmQLG1d5CP5cyCYtkPfpYZ6XCPafcEQ1zP4VoRGwg5d3IZRYQM4OWkvV2Ci+E
         ACS53b0S23dlIMXjBRukRzEHWvzzuHRuVgo86Ed2rbN1RqCtPcXJV829EnPW2Oq3Zu+z
         TUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k0xB10Perd+Jw8sWS32J1melEiaxGcduzBXWrX0yzOs=;
        b=5GwlFHoNoSDfp3VEnTYhKdby5W9n4ugUOV6MBIx7UCYIVLc1+Gj5E+wkIv+WNA4dS3
         Y6WKmjYKECdcO0PmaJZVo0KZgyoBuhRs4bPUjf9LIKtILObk+l9Cd4pqJ8Cgu+zDwfqp
         2AhrZPTEiOni8ymjnPE17cKv7fG4AjBPWy4gpDzirMVCXyTgn6zvEu3qizVpfXNLdHrt
         9amFT0emPHIUKEVXei7trJOZIrUMfYLp9GEXAcnTw6r7qDafc46NpfPtchYwWgEtMFCW
         GwpmORpEwGp6fENwhc43MIb2MBqwuwKE3KKzJN4nmfPuG0fxsGbX45nQvrT2j4iZafvq
         7LwA==
X-Gm-Message-State: AJIora8Pj4msciAKuWU2NCgK2V57lVfrW3IRJ9353KCiQojUAryFKmQI
        LM7ULADgbEdmSOnjonLcyozowD0xwrWlAhw+gzY=
X-Google-Smtp-Source: AGRyM1vEJgsOVKvy5yYosHC0a0lhLEBvj5D1htGANQi2Qnyt9J61o+yFTZPe8MqchEmx3H5qdC92qu89v+8UdfQVGfg=
X-Received: by 2002:a05:6902:c4:b0:64b:4677:331b with SMTP id
 i4-20020a05690200c400b0064b4677331bmr36424263ybs.93.1657011908774; Tue, 05
 Jul 2022 02:05:08 -0700 (PDT)
MIME-Version: 1.0
References: <1656469212-12717-1-git-send-email-u0084500@gmail.com>
 <1656469212-12717-3-git-send-email-u0084500@gmail.com> <CAHp75Vd2bxFA5PmjEtgAjJfCf9YZENq_fb9b2VHmMmmHdqGJSw@mail.gmail.com>
 <CADiBU384ZwKL_+i1zRL9qfVt-NLo=pnf8zrGna4Sxt+toYZdWg@mail.gmail.com>
 <CADiBU3_sU8bj29x2Qs9y9fM2YDYcKvNBkBuzfpzuCkAjSeTu+Q@mail.gmail.com>
 <CAHp75VeiuJjiPFFh0pEGGH4+UEn0g5902UhAJL93Ho2WvH0_gg@mail.gmail.com> <CADiBU38FbZ87EHn_UDy-rS6V2bGDdLZJOcqNZsS03MzbNaVaKA@mail.gmail.com>
In-Reply-To: <CADiBU38FbZ87EHn_UDy-rS6V2bGDdLZJOcqNZsS03MzbNaVaKA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 11:04:32 +0200
Message-ID: <CAHp75VfyKtFQbcJJxW8TNSHMZppM6Qgj4hxiUzLB1bSmeWBBAg@mail.gmail.com>
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

On Tue, Jul 5, 2022 at 3:41 AM ChiYuan Huang <u0084500@gmail.com> wrote:
> Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=
=9C=885=E6=97=A5 =E9=80=B1=E4=BA=8C =E6=B8=85=E6=99=A85:52=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > On Mon, Jul 4, 2022 at 9:27 AM ChiYuan Huang <u0084500@gmail.com> wrote=
:
> > > ChiYuan Huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=884=
=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8811:16=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2022=E5=B9=B4=
7=E6=9C=881=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=886:05=E5=AF=AB=E9=
=81=93=EF=BC=9A
> > > > > On Wed, Jun 29, 2022 at 4:23 AM cy_huang <u0084500@gmail.com> wro=
te:

...

> > > > > > +       struct {
> > > > > > +               u16 vals[RTQ6056_MAX_CHANNEL];
> > > > > > +               int64_t timestamp;
> > > > > > +       } data __aligned(8);
> > > > >
> > > > > Hmm... alignment of this struct will be at least 4 bytes, but
> > > > > shouldn't we rather be sure that the timestamp member is aligned
> > > > > properly? Otherwise this seems fragile and dependent on
> > > > > RTQ6056_MAX_CHANNEL % 4 =3D=3D 0.
> > > > >
> > > > Yap, from the 'max channel', it already guarantee this struct will =
be
> > > > aligned at lease 4.
> > > > Actually, It can be removed.
> >
> > I think for the safest side it should be given to the timestamp member.=
 No?
> >
> Sorry, following your comment, Why to use 'align' for the timestamp membe=
r?
> the data member already guarantee 2 * 4 =3D 8 byte, then timestamp will
> be 8 byte aligned, right?

Today it's true, tomorrow it might be different. Imagine if this
driver will cover a new (version of) hardware and needs an additional
channel, how do you guarantee alignment in that case? So, current
approach is working, but fragile.

> what you mentioned is to put __aligned(8) only for timestamp.

Yes.

> I try to put aligned in two ways ( one is only for timestamp, another
> is the whole struct). the result is the same.
> From my thinking, in this case, the struct is already 8 byte aligned
> for timestamp member. don't you think to put 'aligned' is redundant?

No.

--=20
With Best Regards,
Andy Shevchenko
