Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5EB1517616
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 19:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386726AbiEBRq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 13:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349355AbiEBRqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 13:46:49 -0400
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861DC2BC4;
        Mon,  2 May 2022 10:43:19 -0700 (PDT)
Received: by mail-vs1-xe2b.google.com with SMTP id c62so14222997vsc.10;
        Mon, 02 May 2022 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBsJxNxvImpl296Mus5mWmdnOpmXdmLbthaIxAskrPQ=;
        b=MFziamnY/d5gQwsIytBkVyPWmrtDfVrIM4oN59ExACT6YnNwihwZwKUjTOt0fdmzu+
         jC7DCGdVdeTWPzseZ3xQYauT3dbRslDf+5Oa5gx7ZbgSVT80aQVEjQm/z6t4Er0X6IPE
         YXiahUCLDnFlwur/uAmnmtwoci9OqHfcEY7tyTZS3Nt7+aRS55NvsPcGA+vaJU9aceHo
         1KfqO0NXdwKJQVxeclp24NkGn2nu7Qo9dPdF30M8CELnx8Azx7Z3S7eBr7FyonxVStCm
         8q/aXlC+EzH6M2Nkoe1n2PclHw/zn5psRZsuC+hobZZDXJ8vq1UZIs1DyKKzVCU3Eatx
         x53w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBsJxNxvImpl296Mus5mWmdnOpmXdmLbthaIxAskrPQ=;
        b=temQPQs4gFZHTYkpFVdlGNLcW+NwPArDtChE0oesUJZb6qVAVAhdKQoxc8a4VdW/Zr
         dApHjVCUgOT+29l0z35onlnYZ0r0J0pXhKIhVLReTTjhM5lNUbWplulkxyvid4Zavli2
         m5yZZ960xkr4yemNCDIqrbKVIsx0+44iZ0twv1hlOGL1BeHeGaIk6VfkHJy8zRQaPxWH
         Y155PboWsuYi/SymLq82zLvJ+EDcKxSWESdqxKCcPVnY4YJlAACJaQ+nYW8iY9fg1RmE
         HaUsmPl3nihlwxVQ56b3X40pn3nGFmWhJ0bwXJru6n6Q0GUgNXGD2Aq2Ma8SFqPVRjt1
         rZWg==
X-Gm-Message-State: AOAM53279698gnZXkac2MTIiTXHnB6uzukmeEx0xfb5xQ5pRmwa3D25f
        fq3ys/kRc+KTgGD5N2TSAtNQMiBOG0+v0f66ksk=
X-Google-Smtp-Source: ABdhPJxvT065s2t1DL93j9jZcTw+JknZAptyVqiTyV/JSlKLookBmGy+C7cfqGvx2DWG4EoU9qUzKjVQfSOGby9w+oE=
X-Received: by 2002:a67:ee90:0:b0:32a:6b7f:777c with SMTP id
 n16-20020a67ee90000000b0032a6b7f777cmr3764471vsp.83.1651513398507; Mon, 02
 May 2022 10:43:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220429233112.2851665-1-swboyd@chromium.org> <20220429233112.2851665-2-swboyd@chromium.org>
 <CAD=FV=VX8EEgkeLgKwyKvjztcjbA8UhKOUpTr-sS1_Ec=QcWbA@mail.gmail.com>
In-Reply-To: <CAD=FV=VX8EEgkeLgKwyKvjztcjbA8UhKOUpTr-sS1_Ec=QcWbA@mail.gmail.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon, 2 May 2022 10:43:06 -0700
Message-ID: <CAKdAkRSOtAD6u_cwKhHeMLgz5dC2hfPvVvqmj+17b4i-nspfgg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: google,cros-ec-keyb: Introduce
 switches only compatible
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        chrome-platform@lists.linux.dev,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 2, 2022 at 10:00 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Fri, Apr 29, 2022 at 4:31 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > If the device is a detachable, this device won't have a matrix keyboard
> > but it may have some button switches, e.g. volume buttons and power
> > buttons. Let's add a more specific compatible for this type of device
> > that indicates to the OS that there are only switches and no matrix
> > keyboard present. If only the switches compatible is present, then the
> > matrix keyboard properties are denied. This lets us gracefully migrate
> > devices that only have switches over to the new compatible string.
>
> I know the history here so I know the reasons for the 3 choices, but
> I'm not sure I'd fully understand it just from the description above.
> Maybe a summary in the CL desc would help?
>
> Summary:
>
> 1. If you have a matrix keyboard and maybe also some buttons/switches
> then use the compatible: google,cros-ec-keyb
>
> 2. If you only have buttons/switches but you want to be compatible
> with the old driver in Linux that looked for the compatible
> "google,cros-ec-keyb" and required the matrix properties, use the
> compatible: "google,cros-ec-keyb-switches", "google,cros-ec-keyb"
>
> 3. If you have only buttons/switches and don't need compatibility with
> old Linux drivers, use the compatible: "google,cros-ec-keyb-switches"
>
>
> > Similarly, start enforcing that the keypad rows/cols and keymap
> > properties exist if the google,cros-ec-keyb compatible is present. This
> > more clearly describes what the driver is expecting, i.e. that the
> > kernel driver will fail to probe if the row or column or keymap
> > properties are missing and only the google,cros-ec-keyb compatible is
> > present.
> >
> > Cc: Krzysztof Kozlowski <krzk@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: <devicetree@vger.kernel.org>
> > Cc: Benson Leung <bleung@chromium.org>
> > Cc: Guenter Roeck <groeck@chromium.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Hsin-Yi Wang <hsinyi@chromium.org>
> > Cc: "Joseph S. Barrera III" <joebar@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  .../bindings/input/google,cros-ec-keyb.yaml   | 95 +++++++++++++++++--
> >  1 file changed, 89 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > index e8f137abb03c..c1b079449cf3 100644
> > --- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > +++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > @@ -15,14 +15,19 @@ description: |
> >    Google's ChromeOS EC Keyboard is a simple matrix keyboard
> >    implemented on a separate EC (Embedded Controller) device. It provides
> >    a message for reading key scans from the EC. These are then converted
> > -  into keycodes for processing by the kernel.
> > -
> > -allOf:
> > -  - $ref: "/schemas/input/matrix-keymap.yaml#"
> > +  into keycodes for processing by the kernel. This device also supports
> > +  switches/buttons like power and volume buttons.
> >
> >  properties:
> >    compatible:
> > -    const: google,cros-ec-keyb
> > +    oneOf:
> > +      - items:
> > +          - const: google,cros-ec-keyb-switches
> > +      - items:
> > +          - const: google,cros-ec-keyb-switches
> > +          - const: google,cros-ec-keyb
> > +      - items:
> > +          - const: google,cros-ec-keyb
> >
> >    google,needs-ghost-filter:
> >      description:
> > @@ -41,15 +46,40 @@ properties:
> >        where the lower 16 bits are reserved. This property is specified only
> >        when the keyboard has a custom design for the top row keys.
> >
> > +dependencies:
> > +  function-row-phsymap: [ 'linux,keymap' ]
> > +  google,needs-ghost-filter: [ 'linux,keymap' ]
> > +
> >  required:
> >    - compatible
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: google,cros-ec-keyb
> > +    then:
> > +      allOf:
> > +        - $ref: "/schemas/input/matrix-keymap.yaml#"
> > +  - if:
> > +      not:
> > +        properties:
> > +          compatible:
> > +            contains:
> > +              const: google,cros-ec-keyb-switches
> > +    then:
> > +      required:
> > +        - keypad,num-rows
> > +        - keypad,num-columns
> > +        - linux,keymap
>
> I think that:
>
> 1. If you only have buttons/switches and care about backward
> compatibility, you use the "two compatibles" version.
>
> 2. If you care about backward compatibility then you _must_ include
> the matrix properties.
>
> Thus I would be tempted to say that we should just have one "if" test
> that says that if matrix properties are allowed then they're also
> required.
>
> That goes against the recently landed commit 4352e23a7ff2 ("Input:
> cros-ec-keyb - only register keyboard if rows/columns exist") but
> perhaps we should just _undo_ that that since it landed pretty
> recently and say that the truly supported way to specify that you only
> have keyboards/switches is with the compatible.
>
> What do you think?

I am sorry, I am still confused on what exactly we are trying to solve
here? Having a device with the new device tree somehow run an older
kernel and fail? Why exactly do we care about this case? We have
implemented the notion that without rows/columns properties we will
not be creating input device for the matrix portion, all older devices
should have it defined, so the newer driver is compatible with them...

Thanks.

-- 
Dmitry
