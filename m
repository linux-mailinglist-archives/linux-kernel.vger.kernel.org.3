Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28977512B71
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243855AbiD1G1m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243792AbiD1G1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:27:34 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67E6972FC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:24:20 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id s131so4410126oie.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=AOUBjawPmRnN8evNXoYGp+/SwIc2Lx8wXlLCMbXCewc=;
        b=eFFoq6CzQtllJEhFXdGNNINBsySKH5Zogv5JnVRsgWjDI/7/fCM0iXGbg8y44gNgYE
         CVtURwJlXlwY2byoC7a7YrZDuayY5qI04K0A0/BYFxuA1Bx1/JQEs7610miyQQZ86ZTl
         dc/ZUERs0AX151PR25GDPOP78Pmgug2/iGiK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=AOUBjawPmRnN8evNXoYGp+/SwIc2Lx8wXlLCMbXCewc=;
        b=5AnykhMwqZH4n405dQO+8N2zBIJm4hDp5YjLyNl5xArj+o4fEShSHzNWI4oTMW4Sah
         2KbCCmWFylOQLWJvhJchDFb3QmVJZKQcWpbF+uWrGlXT5DpZPnw3i2pmN9ZizjYeVbDL
         h9Om4IrJitfqbwbKbsRb9JSOJrtYPq9FGoRANCDSze+wIEZuOE6g7efVPp9dkyzm0cua
         dq68+vkXxxsxV2nAEhyS7uhozcj9QQ29g1Meq1EaRPoPPISdsitqRlileBS26Y/CuJMO
         ey+CS/nQEfWxRLA/0dBS0h4up7Ft1ePTE2rNSUN5HqFeu5q8tz2YEQxfVQUrYm6xr0MN
         xuLg==
X-Gm-Message-State: AOAM5335bjzNEr6g1SoUfhO8NHZv0L1jfpnFUPBEWY8O2jggc2Tuchb9
        uZjHOwhRQHcrUkCB7hifZe3Bm07vmy5mvEDICXHuZQ==
X-Google-Smtp-Source: ABdhPJxTdgDULp8Ip+gh6w1tifiji7I8A/vnaeGTUOQvBOIBhBkdr1QUO8MYQFS6Fq24/UPeIqz1MmwGQ5SxG5Hr59k=
X-Received: by 2002:a05:6808:1296:b0:325:8fb:68f3 with SMTP id
 a22-20020a056808129600b0032508fb68f3mr10950982oiw.193.1651127060059; Wed, 27
 Apr 2022 23:24:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 27 Apr 2022 23:24:19 -0700
MIME-Version: 1.0
In-Reply-To: <9248da4f-ca04-82f0-2840-a20797c25d2a@linaro.org>
References: <20220427203026.828183-1-swboyd@chromium.org> <20220427203026.828183-2-swboyd@chromium.org>
 <9248da4f-ca04-82f0-2840-a20797c25d2a@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 27 Apr 2022 23:24:19 -0700
Message-ID: <CAE-0n52Y=3EEZ6qguNx=hM44BahbH3cuq7x6Bbe5HELKkkvrUw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: google,cros-ec-keyb: Introduce switches
 only compatible
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "Joseph S. Barrera III" <joebar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Krzysztof Kozlowski (2022-04-27 23:12:47)
> On 27/04/2022 22:30, Stephen Boyd wrote:
> > If the device is a detachable, this device won't have a matrix keyboard
> > but it may have some button switches, e.g. volume buttons and power
> > buttons. Let's add a more specific compatible for this type of device
> > that indicates to the OS that there are only switches and no matrix
> > keyboard present.
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
> >  .../bindings/input/google,cros-ec-keyb.yaml          | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > index e8f137abb03c..edc1194d558d 100644
> > --- a/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > +++ b/Documentation/devicetree/bindings/input/google,cros-ec-keyb.yaml
> > @@ -15,14 +15,20 @@ description: |
> >    Google's ChromeOS EC Keyboard is a simple matrix keyboard
> >    implemented on a separate EC (Embedded Controller) device. It provides
> >    a message for reading key scans from the EC. These are then converted
> > -  into keycodes for processing by the kernel.
> > +  into keycodes for processing by the kernel. This device also supports
> > +  switches/buttons like power and volume buttons.
> >
> >  allOf:
> >    - $ref: "/schemas/input/matrix-keymap.yaml#"
> >
> >  properties:
> >    compatible:
> > -    const: google,cros-ec-keyb
> > +    oneOf:
> > +      - items:
> > +          - const: google,cros-ec-keyb-switches
> > +          - const: google,cros-ec-keyb
> > +      - items:
> > +          - const: google,cros-ec-keyb
> >
>
> In such case matrix-keymap properties are not valid, right? The
> matrix-keymap should not be referenced, IOW, you need to move allOf
> below "required" and add:
> if:not:...then: $ref: "/schemas/input/matrix-keymap.yaml
>

Eventually that sounds doable, but for the time being I want to merely
add this new compatible in front of the original compatible so that
updated DTBs still work with older kernels, i.e. the switches still get
registered because the driver works with the original
google,cros-ec-keyb compatible. Given that none of the properties are
required for google,cros-ec-keyb it didn't seem necessary to make having
the google,cros-ec-keyb-switches compatible deny the existence of the
matrix-keymap properties.
