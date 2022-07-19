Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22F0579304
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 08:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbiGSGMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 02:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiGSGMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 02:12:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA41A237DD;
        Mon, 18 Jul 2022 23:12:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n185so8339363wmn.4;
        Mon, 18 Jul 2022 23:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0wMA9jMAuILoYnO43zm+jDHZKH9iuy2nJN0S0krKGAc=;
        b=hEVimiHqOYBGhb+W9twulYdCq25kgNVSk673Tk+0SYxPu2VVVxpjPHUCM2OZ1j2lOw
         UL2BGHaO4SlAecu0sHrNSaact+s/b1/BmY1WA0hOYUXsi3+X3W8TiqMj1gYzLQhBpoEG
         WqZ71BtlWL2/6ipdDUmHAU0GCn7vdtEL+/MGdANAhM6YWq+Poel6DPafJJhnCEsdVvTZ
         hSbQ64gSeH9tMbZl1u22U/PsJH/vVztoX5T+kphz0EuMSiIU7eQZPGo3WFpF0Xidzdp2
         3dMBpuw0E8pZdmwe7MUz/J2NNGrKGdvY3j5jS1j4zHFHdrnpP9US0SQ3gsq+GrWVckBN
         iGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0wMA9jMAuILoYnO43zm+jDHZKH9iuy2nJN0S0krKGAc=;
        b=sHaivfu7Y72/4v8RWvp/mskTJEuWpHOVArlvtOzIY6uR+dcjoSGgeoIFXBAq5XiE54
         o3xL0LlRg4yAgEcz8xwrJa2MY/gJ5d9zcnYkV8l4PiDd1MmFQ92oc1qL7/XNG1euiADh
         xOW0KEZYm2NTmGGxWAfmTJvW0J6+lIb25+UitwQS0+UFIS74RMxd0xPnT9caaEgDIBYK
         VYiGra0XHH4spytJV3QFyu/IMBln/nK8YJFG0QmMD3GZmIdC8a86WOlWxsXajoy4h10g
         pGV7U6WfeWicdUByfml+sfG8QNntvEAbhq8mDOVsqFvlhAsEazx+EC1FFlGCm0AfBoWL
         j5MQ==
X-Gm-Message-State: AJIora/eVE890fagmos8Y0ePaWOuir/00r2nOF95W6v7UTw2zcvYpr/8
        T9sJfll3MRm/LEs0lPqKAcSO2XG1DQotAf+sFwk=
X-Google-Smtp-Source: AGRyM1upsSKJtr+QvGYlMKxDP610N/WNZrsp03+aWUM5IFs5OahQz7kmvSZGbsUSUBYi4e7uffy4OOyxzU5UI1DtzQs=
X-Received: by 2002:a7b:c4c8:0:b0:3a3:1b77:61bf with SMTP id
 g8-20020a7bc4c8000000b003a31b7761bfmr7241829wmk.92.1658211153288; Mon, 18 Jul
 2022 23:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <1658123163-10039-1-git-send-email-u0084500@gmail.com>
 <1658123163-10039-4-git-send-email-u0084500@gmail.com> <20220718180441.1363d2a6@jic23-huawei>
In-Reply-To: <20220718180441.1363d2a6@jic23-huawei>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 19 Jul 2022 14:12:21 +0800
Message-ID: <CADiBU3_Nb4Rio3Z7L-907TB1Gvq6d5_GSP6Av5ZjHzhoDtcEZA@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] Documentation: ABI: testing: rtq6056: Update ABI docs
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        cy_huang <cy_huang@richtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> =E6=96=BC 2022=E5=B9=B47=E6=9C=8819=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E5=87=8C=E6=99=A812:54=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Mon, 18 Jul 2022 13:46:03 +0800
> cy_huang <u0084500@gmail.com> wrote:
>
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Add documentation for the usage of voltage channel integration time.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/AB=
I/testing/sysfs-bus-iio
> > index d4ccc68..1f7d327 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2030,3 +2030,13 @@ Description:
> >               Available range for the forced calibration value, express=
ed as:
> >
> >               - a range specified as "[min step max]"
> > +
> > +What:                /sys/bus/iio/devices/iio:deviceX/in_voltageY_inte=
gration_time
> > +KernelVersion:       5.20
> > +Contact:     linux-iio@vger.kernel.org
> > +Description:
> > +             For voltage sensing hardware, there may be different time=
 between
> > +             channel conversion and sample update. 'Integration time' =
is used to
> > +             specify the channel internal conversion time. And sample =
update
> > +             interval is equal to average sample count multiple integr=
ation time.
> > +             Unit as microsecond.
>
> Whilst I did suggest moving this to this file, I also suggested that it w=
as the
> wrong interface to use.  For similar cases we've used in_voltageY_samplin=
g_frequency
> in the past because this isn't really an integration time, but rather a r=
eflection of
> a bunch of other stuff that makes up the conversion time.  In IIO we chos=
e a long
> time ago to use 1/conversion_time as the exposed interface =3D=3D samplin=
g_frequency
>
> So, unless there is a strong reason to do otherwise, drop the overall sam=
pling_frequency
> attribute and use per channel ones instead.  Then update the main documen=
tation
> to make this usecase clear. Something in the block
> https://elixir.bootlin.com/linux/latest/source/Documentation/ABI/testing/=
sysfs-bus-iio#L89
> like adding the in_voltageY_sampling_frequency entry to the What: list an=
d a
> sentence at the end that says something like:
>
> "Some devices have separate controls of sampling frequency for individual=
 channels.
> If multiple channels are enabled in a scan, then the sampling_frequency o=
f the the
> scan may be computed from the per channel sampling_frequencies."
>
From my case, I need to specify
in_voltageX_sampling_frequency/in_powerY_sampling_frequency/
in_currentZ_sampling_frequency.

And describe all in the same sentence.
Can I directly copy the sentence that you described above?
I read the comment. The sentence that you wrote seems more generic.

If any misunderstanding, please correct me.
> Not something to put in the documentation, but for devices which do simul=
taneous sampling
> it is very unlikely we'll have per channel sampling frequencies so there =
isn't an
> ambiguity. The alternative we 'could' consider is to allow both overall s=
ampling_frequency
> and per channel in_voltageY_sampling_frequency but that is a bad idea bec=
ause the
> ABI (and most userspace software) assumes that more specific attributes o=
verride the
> values of more generic ones (rather than them having different meanings a=
s would be
> the case here).
>
> Jonathan
