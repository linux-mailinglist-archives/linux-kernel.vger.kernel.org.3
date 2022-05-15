Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4092527531
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 05:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiEODd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 23:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiEODdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 23:33:51 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B93896;
        Sat, 14 May 2022 20:33:49 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id o80so1921580ybg.1;
        Sat, 14 May 2022 20:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vtZpCF2eVfrsEShzCqG/31YFWN+65aph4jwpCIOfvTM=;
        b=StUmTH4HRARTE9iPSXhUk/FpIxloaIfjujaD6EetNSRLEL0xFRXi+ylEv9t6hayslT
         RoiVRxdwM5/3Ddb1NysWLPqsc0P6tDChVD5k19bdrBZwzTjkGrlExI/RV0TC25WqhxGo
         bwqVGYVKw3LPUrbOmc6F/ryOo22aecKSt4d/SFN8lRXYDmaYQCa9Gzzn83mnhvpk4/B9
         +7bWzTw9UKRUeYeA02qG4sYSiVLzIN/Dw/MrE8FPonrHESDw9pu70ogBGq/9h1tGiWCx
         CqPWJQlyqZX2hdIZdTRlWnfGBAeKUco6CWQ3ILf9NVlWaeMsLg6SfADdrM+madX/qcjq
         Uf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vtZpCF2eVfrsEShzCqG/31YFWN+65aph4jwpCIOfvTM=;
        b=irJ8K7DAgSi6DV0E0hemI9IOB4EPo70/97Y50u4gjw+dM4j+Ztk1eYl+rus+aUcVde
         B+gzudyqOJsHnJfveXa6EnwiOvTwxrzubyB1nA9a0q2nHwCKYC7RZZgKOLbXE7qXpzHx
         ldC2eBHT8xIc3q4mUr/W7jOUfrg5aAa0GW6obxZv6bIbQRSa7+FuJwlixfPdWt9VzRDG
         pnkJEiXjCiVOVHfIFkwH4+hMLd9umg9mzBGo/lKMGDzYSoRxUvjW4/iaJuvaveyppwMe
         MvyWeXtNoskVmYIKdcYbQdCEn94kM7FpVRh978ghBf5AXBSJ+ah/OUJejESPzPx4b2MR
         XlJw==
X-Gm-Message-State: AOAM531290uJQbp7YK2qF4lh2mUAwO1LIbBwJ+g826XXwOTvEKooP1h5
        bHSM+FfbpVq5yCEttSTAi+NNn6O8S0FMS64XOys=
X-Google-Smtp-Source: ABdhPJyCudeg8Z2SFTD7Vq2yUFVWPuT6OFCvNc1jJVlmxZlw8qVWBNqWkjVFX4dX4Pbzf12Vp+54xMysyZg7zM7ftVI=
X-Received: by 2002:a5b:5c2:0:b0:649:c4fe:ca5b with SMTP id
 w2-20020a5b05c2000000b00649c4feca5bmr11703621ybp.284.1652585629047; Sat, 14
 May 2022 20:33:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220512001500.16739-1-fletcher0max@gmail.com>
 <CAEc3jaBbVT1t1kS_Vvp3EqfheCWr=CAvVgdzw7vkeFyYz9H_7Q@mail.gmail.com> <CAKcX28WpKoP=HVq3zCvBh9knKFEdR0_+NmATpt9D6rFmprkFDA@mail.gmail.com>
In-Reply-To: <CAKcX28WpKoP=HVq3zCvBh9knKFEdR0_+NmATpt9D6rFmprkFDA@mail.gmail.com>
From:   Roderick Colenbrander <thunderbird2k@gmail.com>
Date:   Sat, 14 May 2022 20:33:38 -0700
Message-ID: <CAEc3jaCq9DOa86TAakY7K9Mrzc9qKt5wraTJ7Z2Y5yAu-XqWzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] HID: nintendo: fix face button mappings
To:     Maxwell Fletcher <fletcher0max@gmail.com>
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

Hi Maxwell,

I don't think it is desired to have such kernel module parameters as
it essentially adds new kernel APIs, which have to be maintained
unless truly needed.

However, you may have seen the work Benjamin is doing around eBPF for
HID. I'm no expert on it yet, but it could probably allow you to do a
similar kind of fixup without having to modify the kernel module.

Thanks,
Roderick

On Sat, May 14, 2022 at 5:57 PM Maxwell Fletcher <fletcher0max@gmail.com> w=
rote:
>
> Hi Roderick,
>
> Thanks for the explanation. It makes sense that the mappings were never m=
eant to mirror Xbox controllers. Would it still be possible to merge a patc=
h that adds an opt-in module parameter that changes the mappings, similar t=
o the one in the second part of this patch?
>
> Thanks,
> Max
>
> On Fri, May 13, 2022 at 12:58 PM Roderick Colenbrander <thunderbird2k@gma=
il.com> wrote:
>>
>> Hi Max,
>>
>> Thanks for your patch, however I must say the patch is not correct for
>> 2 reasons.
>>
>> Over the years different controllers have different layouts. The
>> standard which this driver (as well as others such as
>> hid-sony/hid-playstation) follow is the Linux gamepad standard (see
>> Documentation/input/gamepad.rst). It stays away of the debate what is
>> A/B/X/Y. It talks about North/west/.., (yes they are macros which map
>> to A/B/X/Y). In case of the Switch it does mean things are flipped,
>> but it was not meant to represent an Xbox controller. (Technically one
>> could argue that the Xbox controller should be flipped as it was the
>> SNES controller back in the days which introduced X/Y and the Switch
>> is still consistent with that.)
>>
>> Second, even if the patch was right it would be tricky to merge. The
>> problem is that a changed mapping breaks user spaces and in general
>> can't do this unless there is a really good reason. It just would
>> break existing applications and libraries (often e.g. SDL)
>>
>> Thanks,
>> Roderick
>>
>> On Wed, May 11, 2022 at 8:12 PM Max Fletcher <fletcher0max@gmail.com> wr=
ote:
>> >
>> > Previously, A and B would match the Xbox layout, but X and Y were inco=
rrectly swapped. This corrects it so that X and Y match the Xbox layout.
>> >
>> > Signed-off-by: Max Fletcher <fletcher0max@gmail.com>
>> > ---
>> >  drivers/hid/hid-nintendo.c | 10 +++++-----
>> >  1 file changed, 5 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
>> > index 2204de889739..7735971ede3f 100644
>> > --- a/drivers/hid/hid-nintendo.c
>> > +++ b/drivers/hid/hid-nintendo.c
>> > @@ -1351,10 +1351,10 @@ static void joycon_parse_report(struct joycon_=
ctlr *ctlr,
>> >                 input_report_key(dev, BTN_START, btns & JC_BTN_PLUS);
>> >                 input_report_key(dev, BTN_THUMBR, btns & JC_BTN_RSTICK=
);
>> >                 input_report_key(dev, BTN_MODE, btns & JC_BTN_HOME);
>> > -               input_report_key(dev, BTN_WEST, btns & JC_BTN_Y);
>> > -               input_report_key(dev, BTN_NORTH, btns & JC_BTN_X);
>> > -               input_report_key(dev, BTN_EAST, btns & JC_BTN_A);
>> > -               input_report_key(dev, BTN_SOUTH, btns & JC_BTN_B);
>> > +               input_report_key(dev, BTN_X, btns & JC_BTN_Y);
>> > +               input_report_key(dev, BTN_Y, btns & JC_BTN_X);
>> > +               input_report_key(dev, BTN_B, btns & JC_BTN_A);
>> > +               input_report_key(dev, BTN_A, btns & JC_BTN_B);
>> >         }
>> >
>> >         input_sync(dev);
>> > @@ -1578,7 +1578,7 @@ static const unsigned int joycon_button_inputs_l=
[] =3D {
>> >
>> >  static const unsigned int joycon_button_inputs_r[] =3D {
>> >         BTN_START, BTN_MODE, BTN_THUMBR,
>> > -       BTN_SOUTH, BTN_EAST, BTN_NORTH, BTN_WEST,
>> > +       BTN_A, BTN_B, BTN_Y, BTN_X,
>> >         BTN_TR, BTN_TR2,
>> >         0 /* 0 signals end of array */
>> >  };
>> > --
>> > 2.35.3
>> >
