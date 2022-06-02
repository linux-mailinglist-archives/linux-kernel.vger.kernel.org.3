Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0C053BB98
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiFBPbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 11:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234580AbiFBPbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 11:31:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67AC13C1F6;
        Thu,  2 Jun 2022 08:31:42 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j10so8340737lfe.12;
        Thu, 02 Jun 2022 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=esMKub0cfzvqnfMV7lmbB0oZRypBhw/uecaEXqoF+WU=;
        b=oTu0P2daaKsA1l22EDygSdCtDLs65QG9Z696gkcTXpMo2tPkRWcIDU2SMt0nxxwHQV
         csoZh3kuDwqEf57wSVlZictjMfan6VYdNqioDeQrZBxICj/Wj03NDcp8oSK1+klzeBcx
         XcYkpq4lntn5O9wd5dX8J9zJOtEUn1gmdu9TJrmh3E2MtzmmvM5IfgMdo9Ve7xiXelvj
         N7b0cjXXMinL39F1ZZ+NPFL2o7Z4V4Xpl+l3ZuVhZ7ULijC4XHWkWjKa8NPclYWMZsg5
         pvaMNdZN8qOCh5oTGXJGE6gyXJktrIDLP+dhxJ65pVF/x3LinZGRwkfCxH6t089Io3Pq
         EGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=esMKub0cfzvqnfMV7lmbB0oZRypBhw/uecaEXqoF+WU=;
        b=d2x4JaHlzZBuG19hgxHk5Up+d/KzA++DJ/hW5HAen8uqHHKgSo7FFa46suOWME2fY5
         oS2sG4ukzxA56wzeYFWr42k2rB0UP91b1xtnghFs2A3ILADRRmBr54o89CwHj684saG4
         wPM3Pk35D4rjVZfLKNknFvDqH43waT5606QWZgGclqNVi31POoyuZs8PgleaiKtKjudj
         vOqpkvn3Kk/pHD9VHsKGg7GimNgDU2lJAfzOprFKeoidktVZte//U/GZaMzUz9qSH+DY
         j9+FsPTHVwW0d0YJ0VoZEYCQaPTL+jr+hcAiTGyLIVq4WqQoshTchbRxzdMEjSULLGId
         LHZg==
X-Gm-Message-State: AOAM533C5FAuDAt/bykFYmScPq5kuI3B/U+2+g7L0aZW+OY4hp0UM4Ky
        3bBdr1bzMuBfSCUS/XX9c171+8qJhiFbEu5et4V17V7qHbfeYA==
X-Google-Smtp-Source: ABdhPJwUWTC1dJi2VZe48WvDxa+lO5SkWNx609HcHDHFfZMmdimibD/T9ChrnJh/j6CAvW90E37p6PiD4Z97tjQIh84=
X-Received: by 2002:a05:6512:3a95:b0:478:da91:ebc8 with SMTP id
 q21-20020a0565123a9500b00478da91ebc8mr4080306lfu.120.1654183900754; Thu, 02
 Jun 2022 08:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
 <1653534995-30794-2-git-send-email-u0084500@gmail.com> <1c7ab94c-a736-c629-bd8c-8a974803e2b9@linaro.org>
 <CADiBU39jZ6TdYZoH80m4R-X2_fUXZOvDA4yUd_TQdPzBJLE+JA@mail.gmail.com>
 <076d53d3-6062-686f-8e45-14c5f936bbf6@linaro.org> <20220602135604.GA2194286-robh@kernel.org>
 <e3aa9c7e-bf2d-dd55-8b3f-ca51f569771d@linaro.org>
In-Reply-To: <e3aa9c7e-bf2d-dd55-8b3f-ca51f569771d@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 2 Jun 2022 23:31:29 +0800
Message-ID: <CADiBU3-dN0vtQBEqvVLFCUp4-MkhLbQRkOiCet+fO8WfkEW4MQ@mail.gmail.com>
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
=B46=E6=9C=882=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:58=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 02/06/2022 15:56, Rob Herring wrote:
> > On Thu, May 26, 2022 at 12:32:12PM +0200, Krzysztof Kozlowski wrote:
> >> On 26/05/2022 10:13, ChiYuan Huang wrote:
> >>> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=
=E5=B9=B45=E6=9C=8826=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:06=E5=
=AF=AB=E9=81=93=EF=BC=9A
> >>>>
> >>>> On 26/05/2022 05:16, cy_huang wrote:
> >>>>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>>>
> >>>>> Add the new property for ocp level selection.
> >>>>>
> >>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>>>> ---
> >>>>>  .../bindings/leds/backlight/richtek,rt4831-backlight.yaml         =
| 8 ++++++++
> >>>>>  include/dt-bindings/leds/rt4831-backlight.h                       =
| 5 +++++
> >>>>>  2 files changed, 13 insertions(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/leds/backlight/richt=
ek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight=
/richtek,rt4831-backlight.yaml
> >>>>> index e0ac686..c1c59de 100644
> >>>>> --- a/Documentation/devicetree/bindings/leds/backlight/richtek,rt48=
31-backlight.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt48=
31-backlight.yaml
> >>>>> @@ -47,6 +47,14 @@ properties:
> >>>>>      minimum: 0
> >>>>>      maximum: 3
> >>>>>
> >>>>> +  richtek,bled-ocp-sel:
> >>>>
> >>>> Skip "sel" as it is a shortcut of selection. Name instead:
> >>>> "richtek,backlight-ocp"
> >>>>
> >>> OK, if so, do I need to rename all properties from 'bled' to 'backlig=
ht' ?
> >>> If  only this property is naming as 'backlight'. it may conflict with
> >>> the others like as "richtek,bled-ovp-sel".
> >>
> >> Ah, no, no need.
> >>
> >>>>
> >>>>> +    description: |
> >>>>> +      Backlight OCP level selection, currently support 0.9A/1.2A/1=
.5A/1.8A
> >>>>
> >>>> Could you explain here what is OCP (unfold the acronym)?
> >>> Yes. And the full name is 'over current protection'.
> >>
> >> Thanks and this leads to second thing - you encode register value
> >> instead of logical value. This must be a logical value in mA, so
> >> "richtek,bled-ocp-microamp".
> >
> > We already have common properties for setting current of LEDs. We shoul=
d
> > use that here I think.
>
> It might not be exactly the same. We have "led-max-microamp" which is
> the maximum allowed current. I guess over-current protection level  is
> slightly higher (e.g. led-max-microamp + 1). IOW, led-max-microamp is
> something which still can be set and used by system/hardware. OCP should
> not.
>
Yap, you're right.
From the modern backlight IC design, it uses the boost converter architectu=
re.
This OCP level is to limit the inductor current when the internal MOS
switch turn on.
Details can refer to the below wiki link
https://en.wikipedia.org/wiki/Boost_converter

And based on it, OVP is used to limit the inductor output voltage.
Each channel maximum current is based on the IC affordable limit.
It is more like as what you said 'led-max-microamp'.

So boost voltage level may depend on the LED VF.
The different series of LED may cause different boost voltage.

RT4831's OVP/OCP is not just the protection, more like as the limit.
>
> Best regards,
> Krzysztof
