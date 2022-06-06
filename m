Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B96A53DF68
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 03:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352004AbiFFBji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 21:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351993AbiFFBj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 21:39:29 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECB04EDD3;
        Sun,  5 Jun 2022 18:39:27 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id q1so14261485ljb.5;
        Sun, 05 Jun 2022 18:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2aAzgWufLM3eFBRQ9m2A+4XEm2/EjgHO8XjvIlt8qsc=;
        b=Icn4irk9qnC0CRZA12hvjLPiNe929gRNEg4ZfZV0T3RYBehB9uqQtL9hviXbnYeMv2
         bPOGPBWkInazcMgEV6wlUWAWy4LSCAmIviwlw4PqqQoU1GClhQ+gTrya2W+LXGW27HEI
         YTBJghZmXIacPXwHbAz2rLV6GEdEzbddpeFWiv5x8CHz0zoKy99fxoUgELLe3DGexses
         5LgMUJl0NxVpiM5Ez4NxsHgGhlLB+23vcIQlNp/NfcZ79MKpf4bLNTppNG2jATt0VSfc
         LY9vQsx92hbFfZqPtzMGD9LKgeqzTKmWr7UkOiBTX5xPNFaUc0caWkM8N94mo7q/5kjt
         wuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2aAzgWufLM3eFBRQ9m2A+4XEm2/EjgHO8XjvIlt8qsc=;
        b=qk5EA1mPyMBAiVwI31e0WMEWOtSdD2YLNat/olzs/OPmS+5Aw1lAXR3IFS/fdLk96r
         ZZCccozFH8i8USaHEvWGdJgnWySmI6EHSO3onyWdJWj3+qbDwJ0GV1ni/wy2WsF1PjsC
         up/6mfR4aCm6SxtJ8sM2gBF0qQ+rSoWpIUQxzdBla3aQ/lYDsIRtBfXD/rwXubeW+f6w
         XqvVTu2uUrtqSaj6knm7YikMICdZlxktSUnhwFW24EVDYo0K7LySvtNo/R9YwHsXU8zO
         F+sUYw8sRv5MZ5FsiMU3MTT/Q4hoxel5Mt3n26JYp2P8M2ATherh0wBkCZF4SEv4eQ1c
         3TPA==
X-Gm-Message-State: AOAM530tJO+N/QFtVAaGpxZzJAnAmJYstvw+RNsSakLXfLhGp1xfe/Ub
        StsJQEuRI3NNjlLKNoqMzkb78fOh8XJBhZ/dEr8=
X-Google-Smtp-Source: ABdhPJz9OSonsWzarHgyRgYmCYlUPNe4zRBAj9Xp3fTYOkGEBTtj9VEAk2DAw1kz0ZE+rmV7BJU35tGBEixhOrTn2Ic=
X-Received: by 2002:a2e:904a:0:b0:255:7b02:8f32 with SMTP id
 n10-20020a2e904a000000b002557b028f32mr9325452ljg.133.1654479565373; Sun, 05
 Jun 2022 18:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
 <1653534995-30794-2-git-send-email-u0084500@gmail.com> <1c7ab94c-a736-c629-bd8c-8a974803e2b9@linaro.org>
 <CADiBU39jZ6TdYZoH80m4R-X2_fUXZOvDA4yUd_TQdPzBJLE+JA@mail.gmail.com>
 <076d53d3-6062-686f-8e45-14c5f936bbf6@linaro.org> <20220602135604.GA2194286-robh@kernel.org>
 <e3aa9c7e-bf2d-dd55-8b3f-ca51f569771d@linaro.org> <CADiBU3-dN0vtQBEqvVLFCUp4-MkhLbQRkOiCet+fO8WfkEW4MQ@mail.gmail.com>
 <12096a2c-98c3-9e77-785f-808cc3e1a0e4@linaro.org>
In-Reply-To: <12096a2c-98c3-9e77-785f-808cc3e1a0e4@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 6 Jun 2022 09:39:15 +0800
Message-ID: <CADiBU3_REqNRb4UtT5OrVBKuhYL0NPAALisHTM76SrFCHUYMuA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: backlight: rt4831: Add the new property
 for ocp level selection
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Helge Deller <deller@gmx.de>, cy_huang <cy_huang@richtek.com>,
        lucas_tsai@richtek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
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

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B46=E6=9C=886=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=8812:11=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 02/06/2022 17:31, ChiYuan Huang wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=
=B9=B46=E6=9C=882=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:58=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >>
> >> On 02/06/2022 15:56, Rob Herring wrote:
> >>> On Thu, May 26, 2022 at 12:32:12PM +0200, Krzysztof Kozlowski wrote:
> >>>> On 26/05/2022 10:13, ChiYuan Huang wrote:
> >>>>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=
=E5=B9=B45=E6=9C=8826=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:06=E5=
=AF=AB=E9=81=93=EF=BC=9A
> >>>>>>
> >>>>>> On 26/05/2022 05:16, cy_huang wrote:
> >>>>>>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>>>>>
> >>>>>>> Add the new property for ocp level selection.
> >>>>>>>
> >>>>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>>>>>> ---
> >>>>>>>  .../bindings/leds/backlight/richtek,rt4831-backlight.yaml       =
  | 8 ++++++++
> >>>>>>>  include/dt-bindings/leds/rt4831-backlight.h                     =
  | 5 +++++
> >>>>>>>  2 files changed, 13 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/Documentation/devicetree/bindings/leds/backlight/ric=
htek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlig=
ht/richtek,rt4831-backlight.yaml
> >>>>>>> index e0ac686..c1c59de 100644
> >>>>>>> --- a/Documentation/devicetree/bindings/leds/backlight/richtek,rt=
4831-backlight.yaml
> >>>>>>> +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt=
4831-backlight.yaml
> >>>>>>> @@ -47,6 +47,14 @@ properties:
> >>>>>>>      minimum: 0
> >>>>>>>      maximum: 3
> >>>>>>>
> >>>>>>> +  richtek,bled-ocp-sel:
> >>>>>>
> >>>>>> Skip "sel" as it is a shortcut of selection. Name instead:
> >>>>>> "richtek,backlight-ocp"
> >>>>>>
> >>>>> OK, if so, do I need to rename all properties from 'bled' to 'backl=
ight' ?
> >>>>> If  only this property is naming as 'backlight'. it may conflict wi=
th
> >>>>> the others like as "richtek,bled-ovp-sel".
> >>>>
> >>>> Ah, no, no need.
> >>>>
> >>>>>>
> >>>>>>> +    description: |
> >>>>>>> +      Backlight OCP level selection, currently support 0.9A/1.2A=
/1.5A/1.8A
> >>>>>>
> >>>>>> Could you explain here what is OCP (unfold the acronym)?
> >>>>> Yes. And the full name is 'over current protection'.
> >>>>
> >>>> Thanks and this leads to second thing - you encode register value
> >>>> instead of logical value. This must be a logical value in mA, so
> >>>> "richtek,bled-ocp-microamp".
> >>>
> >>> We already have common properties for setting current of LEDs. We sho=
uld
> >>> use that here I think.
> >>
> >> It might not be exactly the same. We have "led-max-microamp" which is
> >> the maximum allowed current. I guess over-current protection level  is
> >> slightly higher (e.g. led-max-microamp + 1). IOW, led-max-microamp is
> >> something which still can be set and used by system/hardware. OCP shou=
ld
> >> not.
> >>
> > Yap, you're right.
>
> So I am right or Rob?
>
As I know, both are incorrect.
> > From the modern backlight IC design, it uses the boost converter archit=
ecture.
> > This OCP level is to limit the inductor current when the internal MOS
> > switch turn on.
> > Details can refer to the below wiki link
> > https://en.wikipedia.org/wiki/Boost_converter
> >
> > And based on it, OVP is used to limit the inductor output voltage.
> > Each channel maximum current is based on the IC affordable limit.
> > It is more like as what you said 'led-max-microamp'.
> >
> > So boost voltage level may depend on the LED VF.
> > The different series of LED may cause different boost voltage.
> >
> > RT4831's OVP/OCP is not just the protection, more like as the limit.
>
> This suggests Rob is right, so let's use led-max-microamp property?
>
No, the meaning is different. 'led-max-microamp' always means the
channel output current.
It already can be adjusted by backlight brightness node.

For example
low voltage side (3.3~4.4V) to generate the boost voltage to 16~17V,
even 20V for BLED Vout.
This OCP is to limit the input current of low voltage side.

After the explanation, do you still think it's the same thing?
> Best regards,
> Krzysztof
