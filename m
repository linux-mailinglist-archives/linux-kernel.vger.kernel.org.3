Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF13C53543D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348881AbiEZUHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbiEZUHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:07:15 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEB0BA9B2;
        Thu, 26 May 2022 13:07:14 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u23so3963059lfc.1;
        Thu, 26 May 2022 13:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zyoxcfUGkhRLREf2cpRhyhZi5hXxrWkBKr1smYGro+s=;
        b=LZ8DhRoqO7iGuYrA7HfKAm7AxwpI9bTaSNE3odNBSjH3IGuwo/2Y5dTMMZfJ4EdX9O
         dLH0HaUxjkyjaX8Od8n311p5OJt91y/lBD1Pt8kQ2Uws7U5gfpSfv7oGEzOyx+TFy5w7
         DXFmZGjrnwlfVNQdFt3fFHJEvlhD43sLnlt3HJTPKq+NpVq9y2iXtZqfbZNj1b5MctEq
         Qi6aJFGY7dkv0k7ZTgl/URhsIcB6iTDKxJ4CXPXAJ4rv/MCWR+myMKXzwbEXAO0GNU+k
         ZyejukdxtazmBPIaAb+svMn37dL04DsMrdiew2pNoKAso/5c3YZ4+Yehob+/hVLEmaMn
         lp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zyoxcfUGkhRLREf2cpRhyhZi5hXxrWkBKr1smYGro+s=;
        b=eD8NTAmmSOP6p+GZKNfkqBbzhMhdFE2AV81Yc67WYHYpkKsxgFaaPzCHbp5+x95KCS
         sR+HqG231juin430g2kv/QgehreZYBzSeybNNuZydH8EXQhfQfTZn9Nl6fVR72RFzKEN
         CNqI+eQUl0S7iXhsg6sdZzOSpH/bH1WV4BNlPFa6IWhkcTIcRhL7OkW6HF023g0dTNEf
         Bae5Hz76RCAKssnuFW/LRU9EF07hY0RxBrn0xWKZ/KrgZumIPB5u2qDTW73f/THb5e1+
         7gku5Tbu1NCBwBf0NYXhiiN81flHW4M1tR5USelffA1wDvP5mVLXQZwRNxnCL7BKa1Js
         XldQ==
X-Gm-Message-State: AOAM5332Kty4kzi5zrdu9VmgqBCuTseqynP/msebGlMYkj6IpJQ04D3P
        qXwidvVS24v77JKyz6hnmCrNPMgnbyc1PG0XGQM9BsZ8
X-Google-Smtp-Source: ABdhPJyw+nnuZYOIRPE4qQXN3KXf/9pua2DUaN9KJa8kShmnWZTS0FVsqCr94j4zSQ1e1QRqOnhXBrl4fL1VdQZVfkM=
X-Received: by 2002:a05:6512:128e:b0:478:67ec:44bc with SMTP id
 u14-20020a056512128e00b0047867ec44bcmr17359964lfs.381.1653595632789; Thu, 26
 May 2022 13:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220512001500.16739-1-fletcher0max@gmail.com>
 <CAEc3jaBbVT1t1kS_Vvp3EqfheCWr=CAvVgdzw7vkeFyYz9H_7Q@mail.gmail.com>
 <CAKcX28WpKoP=HVq3zCvBh9knKFEdR0_+NmATpt9D6rFmprkFDA@mail.gmail.com> <CAEc3jaCq9DOa86TAakY7K9Mrzc9qKt5wraTJ7Z2Y5yAu-XqWzg@mail.gmail.com>
In-Reply-To: <CAEc3jaCq9DOa86TAakY7K9Mrzc9qKt5wraTJ7Z2Y5yAu-XqWzg@mail.gmail.com>
From:   Maxwell Fletcher <fletcher0max@gmail.com>
Date:   Thu, 26 May 2022 13:07:01 -0700
Message-ID: <CAKcX28X+fqzjW3UHqzhbopjqD=eO7x4TTAjC-3x3w7Po-PgKSQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: nintendo: fix face button mappings
To:     Roderick Colenbrander <thunderbird2k@gmail.com>
Cc:     "Daniel J. Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
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

Hi Roderick,

Thank you so much for your time; this has all been very educational
for me. I'll be following the work on eBPF.

Best,
Max





On Sat, May 14, 2022 at 8:33 PM Roderick Colenbrander
<thunderbird2k@gmail.com> wrote:
>
> Hi Maxwell,
>
> I don't think it is desired to have such kernel module parameters as
> it essentially adds new kernel APIs, which have to be maintained
> unless truly needed.
>
> However, you may have seen the work Benjamin is doing around eBPF for
> HID. I'm no expert on it yet, but it could probably allow you to do a
> similar kind of fixup without having to modify the kernel module.
>
> Thanks,
> Roderick
>
> On Sat, May 14, 2022 at 5:57 PM Maxwell Fletcher <fletcher0max@gmail.com>=
 wrote:
> >
> > Hi Roderick,
> >
> > Thanks for the explanation. It makes sense that the mappings were never=
 meant to mirror Xbox controllers. Would it still be possible to merge a pa=
tch that adds an opt-in module parameter that changes the mappings, similar=
 to the one in the second part of this patch?
> >
> > Thanks,
> > Max
> >
> > On Fri, May 13, 2022 at 12:58 PM Roderick Colenbrander <thunderbird2k@g=
mail.com> wrote:
> >>
> >> Hi Max,
> >>
> >> Thanks for your patch, however I must say the patch is not correct for
> >> 2 reasons.
> >>
> >> Over the years different controllers have different layouts. The
> >> standard which this driver (as well as others such as
> >> hid-sony/hid-playstation) follow is the Linux gamepad standard (see
> >> Documentation/input/gamepad.rst). It stays away of the debate what is
> >> A/B/X/Y. It talks about North/west/.., (yes they are macros which map
> >> to A/B/X/Y). In case of the Switch it does mean things are flipped,
> >> but it was not meant to represent an Xbox controller. (Technically one
> >> could argue that the Xbox controller should be flipped as it was the
> >> SNES controller back in the days which introduced X/Y and the Switch
> >> is still consistent with that.)
> >>
> >> Second, even if the patch was right it would be tricky to merge. The
> >> problem is that a changed mapping breaks user spaces and in general
> >> can't do this unless there is a really good reason. It just would
> >> break existing applications and libraries (often e.g. SDL)
> >>
> >> Thanks,
> >> Roderick
> >>
> >> On Wed, May 11, 2022 at 8:12 PM Max Fletcher <fletcher0max@gmail.com> =
wrote:
> >> >
> >> > Previously, A and B would match the Xbox layout, but X and Y were in=
correctly swapped. This corrects it so that X and Y match the Xbox layout.
> >> >
> >> > Signed-off-by: Max Fletcher <fletcher0max@gmail.com>
> >> > ---
> >> >  drivers/hid/hid-nintendo.c | 10 +++++-----
> >> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> >> > index 2204de889739..7735971ede3f 100644
> >> > --- a/drivers/hid/hid-nintendo.c
> >> > +++ b/drivers/hid/hid-nintendo.c
> >> > @@ -1351,10 +1351,10 @@ static void joycon_parse_report(struct joyco=
n_ctlr *ctlr,
> >> >                 input_report_key(dev, BTN_START, btns & JC_BTN_PLUS)=
;
> >> >                 input_report_key(dev, BTN_THUMBR, btns & JC_BTN_RSTI=
CK);
> >> >                 input_report_key(dev, BTN_MODE, btns & JC_BTN_HOME);
> >> > -               input_report_key(dev, BTN_WEST, btns & JC_BTN_Y);
> >> > -               input_report_key(dev, BTN_NORTH, btns & JC_BTN_X);
> >> > -               input_report_key(dev, BTN_EAST, btns & JC_BTN_A);
> >> > -               input_report_key(dev, BTN_SOUTH, btns & JC_BTN_B);
> >> > +               input_report_key(dev, BTN_X, btns & JC_BTN_Y);
> >> > +               input_report_key(dev, BTN_Y, btns & JC_BTN_X);
> >> > +               input_report_key(dev, BTN_B, btns & JC_BTN_A);
> >> > +               input_report_key(dev, BTN_A, btns & JC_BTN_B);
> >> >         }
> >> >
> >> >         input_sync(dev);
> >> > @@ -1578,7 +1578,7 @@ static const unsigned int joycon_button_inputs=
_l[] =3D {
> >> >
> >> >  static const unsigned int joycon_button_inputs_r[] =3D {
> >> >         BTN_START, BTN_MODE, BTN_THUMBR,
> >> > -       BTN_SOUTH, BTN_EAST, BTN_NORTH, BTN_WEST,
> >> > +       BTN_A, BTN_B, BTN_Y, BTN_X,
> >> >         BTN_TR, BTN_TR2,
> >> >         0 /* 0 signals end of array */
> >> >  };
> >> > --
> >> > 2.35.3
> >> >
